
adawebpack = {

  __gnat_put_int: function (item) { console.log(item); },
  __gnat_put_char: function (item) { console.log(String.fromCharCode(item)); },

  __adawebpack__is_instance_of: function(identifier, address, size)
  {
    return from_wasm_object_identifier(identifier) instanceof window[string_to_js(address, size)];
  },

  __adawebpack__wasm__object_release: function (identifier)
  { console.log('Object released ' + identifier);
  },

  __adawebpack__bom__window__document: function ()
  {
    return to_wasm_object_identifier(window.document);
  },

  __adawebpack__dom__Document__getElementById: function (identifier, address, length)
  {
    return to_wasm_object_identifier(from_wasm_object_identifier(identifier).getElementById(string_to_js(address, length)));
  },

  __adawebpack__dom__Node__addEventListener: function (identifier, type_address, type_size, callback, capture)
  {
    from_wasm_object_identifier(identifier).addEventListener
     (string_to_js(type_address, type_size),
      function(e) { instance.exports.__adawebpack__dom__Node__dispatch_event (callback,to_wasm_object_identifier(e)); },
      capture !== 0);
  },

  __adawebpack__html__Button__disabled_setter: function(identifier,to) {
    from_wasm_object_identifier (identifier).disabled = (to !== 0);
  },

  __adawebpack__html__Button__disabled_getter: function(identifier) {
    return +from_wasm_object_identifier(identifier).disabled;
  },

  __adawebpack__html__Canvas__getContext: function(identifier,address,size) {
    return to_wasm_object_identifier(from_wasm_object_identifier(identifier).getContext(string_to_js(address,size)));
  },

  __adawebpack__html__Element__hidden_setter: function(identifier,to) {
    from_wasm_object_identifier (identifier).hidden = (to !== 0);
  },

  __adawebpack__html__Element__hidden_getter: function(identifier) {
    return +from_wasm_object_identifier(identifier).hidden;
  },

  __adawebpack__webgl__RenderingContext__clear: function(identifier,mask) {
    from_wasm_object_identifier(identifier).clear(mask);
  },

  __adawebpack__webgl__RenderingContext__clearColor: function(identifier,red,green,blue,alpha) {
    from_wasm_object_identifier(identifier).clearColor(red,green,blue,alpha);
  }

};

var obj2id = new Map();
var id2obj = new Map();
var last_id = 0;

function to_wasm_object_identifier(obj)
{
  if (obj2id.has(obj))
  {
    return obj2id.get(obj);
  } else {
    last_id++;
    obj2id.set(obj, last_id);
    id2obj.set(last_id, obj);
    return last_id;
  }
}

function from_wasm_object_identifier(identifier)
{
  return id2obj.get(identifier);
}

function string_to_js(address, size)
{
  return String.fromCharCode.apply(null, new Uint16Array(instance.exports.memory.buffer, address, size));
}
