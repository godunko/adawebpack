
adawebpack = {

  __gnat_put_int: function (item) { console.log(item); },
  __gnat_put_char: function (item) { console.log(String.fromCharCode(item)); },
  __gnat_put_string: function (address,size) { console.log(String.fromCharCode.apply(null, new Uint8Array(instance.exports.memory.buffer, address, size))); },
  __gnat_put_f32: function (item) { console.log(item); },
  __gnat_put_f64: function (item) { console.log(item); },
  __gnat_put_exception: function (address,size,line) {
     msg = String.fromCharCode.apply(null, new Uint8Array(instance.exports.memory.buffer, address, size));
     if (line !== 0) {
        console.error("Predefined exception raised at %s:%i", msg, line);
     } else {
        console.error("User defined exception, message: %s", msg);
     }
  },

  __adawebpack__is_instance_of: function(identifier, address, size)
  {
    return __adawebpack_o2i.too(identifier) instanceof window[string_to_js(address, size)];
  },

  __adawebpack__wasm__object_seize: function (identifier) {
    __adawebpack_o2i.sei(identifier);
  },

  __adawebpack__wasm__object_release: function (identifier) {
    __adawebpack_o2i.rel(identifier);
  },

  __adawebpack__bom__window__document: function ()
  {
    return __adawebpack_o2i.toi(window.document);
  },

  __adawebpack__cssom__Element__clientHeight_getter: function(identifier) {
    return __adawebpack_o2i.too(identifier).clientHeight;
  },

  __adawebpack__cssom__Element__clientWidth_getter: function(identifier) {
    return __adawebpack_o2i.too(identifier).clientWidth;
  },

  __adawebpack__cssom__Window__devicePixelRatio_getter: function() {
    return window.devicePixelRatio;
  },

  __adawebpack__dom__Document__getElementById: function (identifier, address, length)
  {
    return __adawebpack_o2i.toi(__adawebpack_o2i.too(identifier).getElementById(string_to_js(address, length)));
  },

  __adawebpack__dom__Node__addEventListener: function (identifier, type_address, type_size, callback, capture)
  {
    __adawebpack_o2i.too(identifier).addEventListener
     (string_to_js(type_address, type_size),
      function(e) { instance.exports.__adawebpack__dom__Node__dispatch_event (callback,__adawebpack_o2i.toi(e)); },
      capture !== 0);
  },

  __adawebpack__html__Button__disabled_getter: function(identifier) {
    return +(__adawebpack_o2i.too(identifier).disabled);
  },

  __adawebpack__html__Button__disabled_setter: function(identifier,to) {
    __adawebpack_o2i.too (identifier).disabled = (to !== 0);
  },

  __adawebpack__html__Canvas__height_getter: function(identifier) {
    return __adawebpack_o2i.too(identifier).height;
  },

  __adawebpack__html__Canvas__height_setter: function(identifier,to) {
    __adawebpack_o2i.too(identifier).height = to;
  },

  __adawebpack__html__Canvas__getContext: function(identifier,address,size) {
    return __adawebpack_o2i.toi(__adawebpack_o2i.too(identifier).getContext(string_to_js(address,size)));
  },

  __adawebpack__html__Canvas__width_getter: function(identifier) {
    return __adawebpack_o2i.too(identifier).width;
  },

  __adawebpack__html__Canvas__width_setter: function(identifier,to) {
    __adawebpack_o2i.too(identifier).width = to;
  },

  __adawebpack__html__Element__hidden_setter: function(identifier,to) {
    __adawebpack_o2i.too (identifier).hidden = (to !== 0);
  },

  __adawebpack__html__Element__hidden_getter: function(identifier) {
    return +(__adawebpack_o2i.too(identifier).hidden);
  },

  __adawebpack__html__Script__text_getter: function(identifier) {
    return string_to_wasm(__adawebpack_o2i.too(identifier).text);
  },

  __adawebpack__html__Script__text_setter: function(identifier,address,size) {
    __adawebpack_o2i.too(identifier).text = string_to_js(address,size);
  },

  __adawebpack__html__Select__disabled_getter: function(identifier) {
    return +(__adawebpack_o2i.too(identifier).disabled);
  },

  __adawebpack__html__Select__disabled_setter: function(identifier,to) {
    __adawebpack_o2i.too(identifier).disabled = (to !== 0);
  },

  __adawebpack__html__Window__requestAnimationFrame: function(address) {
    return window.requestAnimationFrame(function(time){instance.exports.__adawebpack__html__Window__dispatch_animation_frame(address, time);});
  },

  __adawebpack__uievents__MouseEvent__offsetX_getter: function(identifier) {
    return __adawebpack_o2i.too(identifier).offsetX;
  },

  __adawebpack__uievents__MouseEvent__offsetY_getter: function(identifier) {
    return __adawebpack_o2i.too(identifier).offsetY;
  },

  __adawebpack__uievents__MouseEvent__pageX_getter: function(identifier) {
    return __adawebpack_o2i.too(identifier).pageX;
  },

  __adawebpack__uievents__MouseEvent__pageY_getter: function(identifier) {
    return __adawebpack_o2i.too(identifier).pageY;
  },

  __adawebpack__webgl__RenderingContext__attachShader: function(context_identifier,program_identifier,shader_identifier) {
    __adawebpack_o2i.too(context_identifier).attachShader(__adawebpack_o2i.too(program_identifier), __adawebpack_o2i.too(shader_identifier));
  },

  __adawebpack__webgl__RenderingContext__bindBuffer: function(context_identifier,target,buffer_identifier) {
    __adawebpack_o2i.too(context_identifier).bindBuffer(target, __adawebpack_o2i.too(buffer_identifier));
  },

  __adawebpack__webgl__RenderingContext__bindTexture: function(context_identifier,target,texture_identifier) {
    __adawebpack_o2i.too(context_identifier).bindTexture(target, __adawebpack_o2i.too(texture_identifier));
  },

  __adawebpack__webgl__RenderingContext__bufferData: function(context_identifier,target,size,data,usage) {
    __adawebpack_o2i.too(context_identifier).bufferData(target, new Uint8Array(instance.exports.memory.buffer,data,size), usage);
  },

  __adawebpack__webgl__RenderingContext__clear: function(identifier,mask) {
    __adawebpack_o2i.too(identifier).clear(mask);
  },

  __adawebpack__webgl__RenderingContext__clearColor: function(identifier,red,green,blue,alpha) {
    __adawebpack_o2i.too(identifier).clearColor(red,green,blue,alpha);
  },

  __adawebpack__webgl__RenderingContext__clearDepth: function(identifier,depth) {
    __adawebpack_o2i.too(identifier).clearDepth(depth);
  },

  __adawebpack__webgl__RenderingContext__compileShader: function(context_identifier,shader_identifier) {
    __adawebpack_o2i.too(context_identifier).compileShader(__adawebpack_o2i.too(shader_identifier));
  },

  __adawebpack__webgl__RenderingContext__createBuffer: function(identifier) {
    return __adawebpack_o2i.toi(__adawebpack_o2i.too(identifier).createBuffer());
  },

  __adawebpack__webgl__RenderingContext__createProgram: function(identifier) {
    return __adawebpack_o2i.toi(__adawebpack_o2i.too(identifier).createProgram());
  },

  __adawebpack__webgl__RenderingContext__createTexture: function(identifier) {
    return __adawebpack_o2i.toi(__adawebpack_o2i.too(identifier).createTexture());
  },

  __adawebpack__webgl__RenderingContext__createShader: function(identifier,type) {
    return __adawebpack_o2i.toi(__adawebpack_o2i.too(identifier).createShader(type));
  },

  __adawebpack__webgl__RenderingContext__deleteShader: function(context_identifier, shader_identifier) {
    __adawebpack_o2i.too(context_identifier).deleteShader(__adawebpack_o2i.too(shader_identifier));
  },

  __adawebpack__webgl__RenderingContext__deleteTexture: function(context_identifier, texture_identifier) {
    __adawebpack_o2i.too(context_identifier).deleteTexture(__adawebpack_o2i.too(texture_identifier));
  },

  __adawebpack__webgl__RenderingContext__depthFunc: function(identifier,func) {
    __adawebpack_o2i.too(identifier).depthFunc(func);
  },

  __adawebpack__webgl__RenderingContext__drawArrays: function(identifier,mode,first,count) {
    __adawebpack_o2i.too(identifier).drawArrays(mode,first,count);
  },

  __adawebpack__webgl__RenderingContext__drawElements: function(identifier,mode,count,type,offset) {
    __adawebpack_o2i.too(identifier).drawElements(mode,count,type,offset);
  },

  __adawebpack__webgl__RenderingContext__enable: function(context_identifier,capability) {
    __adawebpack_o2i.too(context_identifier).enable(capability);
  },

  __adawebpack__webgl__RenderingContext__enableVertexAttribArray: function(context_identifier,index) {
    __adawebpack_o2i.too(context_identifier).enableVertexAttribArray(index);
  },

  __adawebpack__webgl__RenderingContext__finish: function(context_identifier) {
    __adawebpack_o2i.too(context_identifier).finish();
  },

  __adawebpack__webgl__RenderingContext__flush: function(context_identifier) {
    __adawebpack_o2i.too(context_identifier).flush();
  },

  __adawebpack__webgl__RenderingContext__generateMipmap: function(context_identifier, target) {
    __adawebpack_o2i.too(context_identifier).generateMipmap(target);
  },

  __adawebpack__webgl__RenderingContext__getAttribLocation: function(context_identifier,program_identifier,name_address,name_size) {
    return __adawebpack_o2i.too(context_identifier).getAttribLocation(__adawebpack_o2i.too(program_identifier), string_to_js(name_address, name_size));
  },

  __adawebpack__webgl__RenderingContext__getProgramInfoLog: function(context_identifier,program_identifier) {
    return string_to_wasm(__adawebpack_o2i.too(context_identifier).getProgramInfoLog(__adawebpack_o2i.too(program_identifier)));
  },

  __adawebpack__webgl__RenderingContext__getProgramParameter: function(context_identifier,program_identifier,pname) {
    return +(__adawebpack_o2i.too(context_identifier).getProgramParameter(__adawebpack_o2i.too(program_identifier), pname));
  },

  __adawebpack__webgl__RenderingContext__getShaderInfoLog: function(context_identifier,shader_identifier) {
    return string_to_wasm(__adawebpack_o2i.too(context_identifier).getShaderInfoLog(__adawebpack_o2i.too(shader_identifier)));
  },

  __adawebpack__webgl__RenderingContext__getShaderParameter: function(context_identifier,shader_identifier,pname) {
    return +(__adawebpack_o2i.too(context_identifier).getShaderParameter(__adawebpack_o2i.too(shader_identifier), pname));
  },

  __adawebpack__webgl__RenderingContext__getUniformLocation: function(context_identifier,program_identifier,name_address,name_size) {
    return __adawebpack_o2i.toi(__adawebpack_o2i.too(context_identifier).getUniformLocation(__adawebpack_o2i.too(program_identifier),string_to_js(name_address,name_size)));
  },

  __adawebpack__webgl__RenderingContext__linkProgram: function(context_identifier,program_identifier) {
    __adawebpack_o2i.too(context_identifier).linkProgram(__adawebpack_o2i.too(program_identifier));
  },

  __adawebpack__webgl__RenderingContext__shaderSource: function(context_identifier,shader_identifier,source_address,source_size) {
    __adawebpack_o2i.too(context_identifier).shaderSource(__adawebpack_o2i.too(shader_identifier),string_to_js(source_address,source_size));
  },

  __adawebpack__webgl__RenderingContext__texImage2D: function(context_identifier, target, level, internalformat, format, type, source_identifier) {
    __adawebpack_o2i.too(context_identifier).texImage2D(target, level, internalformat, format, type, __adawebpack_o2i.too(source_identifier));
  },

  __adawebpack__webgl__RenderingContext__uniform1i: function(context_identifier,location_identifier,x) {
    __adawebpack_o2i.too(context_identifier).uniform1i(__adawebpack_o2i.too(location_identifier),x);
  },

  __adawebpack__webgl__RenderingContext__uniform1f: function(context_identifier,location_identifier,x) {
    __adawebpack_o2i.too(context_identifier).uniform1f(__adawebpack_o2i.too(location_identifier),x);
  },

  __adawebpack__webgl__RenderingContext__uniform2fv: function(context_identifier,location_identifier,value_address) {
    __adawebpack_o2i.too(context_identifier).uniform2fv(__adawebpack_o2i.too(location_identifier), new Float32Array(instance.exports.memory.buffer,value_address,2));
  },

  __adawebpack__webgl__RenderingContext__uniform3fv: function(context_identifier,location_identifier,value_address) {
    __adawebpack_o2i.too(context_identifier).uniform3fv(__adawebpack_o2i.too(location_identifier), new Float32Array(instance.exports.memory.buffer,value_address,3));
  },

  __adawebpack__webgl__RenderingContext__uniform4fv: function(context_identifier,location_identifier,value_address) {
    __adawebpack_o2i.too(context_identifier).uniform4fv(__adawebpack_o2i.too(location_identifier), new Float32Array(instance.exports.memory.buffer,value_address,4));
  },

  __adawebpack__webgl__RenderingContext__uniformMatrix2fv: function(context_identifier,location_identifier,transpose,value_address) {
    __adawebpack_o2i.too(context_identifier).uniformMatrix2fv(__adawebpack_o2i.too(location_identifier),transpose!==0, new Float32Array(instance.exports.memory.buffer,value_address,4));
  },

  __adawebpack__webgl__RenderingContext__uniformMatrix3fv: function(context_identifier,location_identifier,transpose,value_address) {
    __adawebpack_o2i.too(context_identifier).uniformMatrix3fv(__adawebpack_o2i.too(location_identifier),transpose!==0, new Float32Array(instance.exports.memory.buffer,value_address,9));
  },

  __adawebpack__webgl__RenderingContext__uniformMatrix4fv: function(context_identifier,location_identifier,transpose,value_address) {
    __adawebpack_o2i.too(context_identifier).uniformMatrix4fv(__adawebpack_o2i.too(location_identifier),transpose!==0, new Float32Array(instance.exports.memory.buffer,value_address,16));
  },

  __adawebpack__webgl__RenderingContext__useProgram: function(context_identifier,program_identifier) {
    __adawebpack_o2i.too(context_identifier).useProgram(__adawebpack_o2i.too(program_identifier));
  },

  __adawebpack__webgl__RenderingContext__vertexAttribPointer: function(context_identifier,index,size,type,normalized,stride,offset) {
    __adawebpack_o2i.too(context_identifier).vertexAttribPointer(index,size,type,normalized !== 0,stride,offset);
  },

  __adawebpack__webgl__RenderingContext__viewport: function(context_identifier,x,y,width,height) {
    __adawebpack_o2i.too(context_identifier).viewport(x,y,width,height);
  },

  __adawebpack__sockets__WebSocket__create: function (address, length) {
    return __adawebpack_o2i.toi(new WebSocket(string_to_js(address, length)));
  },

  __adawebpack__sockets__WebSocket__get_bin_type: function (identifier) {
    return __adawebpack_o2i.too(identifier).binaryType == "blob" ? 0 : 1;
  },

  __adawebpack__sockets__WebSocket__set_bin_type: function (identifier, value) {
    __adawebpack_o2i.too(identifier).binaryType = value ? "arraybuffer" : "blob";
  },

  __adawebpack__sockets__WebSocket__buf_amount: function (identifier) {
    return __adawebpack_o2i.too(identifier).bufferedAmount;
  },

  __adawebpack__sockets__WebSocket__get_ext: function(identifier) {
    return string_to_wasm(__adawebpack_o2i.too(identifier).extensions);
  },

  __adawebpack__sockets__WebSocket__get_proto: function(identifier) {
    return string_to_wasm(__adawebpack_o2i.too(identifier).protocol);
  },

  __adawebpack__sockets__WebSocket__get_state: function (identifier) {
    return __adawebpack_o2i.too(identifier).readyState;
  },

  __adawebpack__sockets__WebSocket__get_url: function(identifier) {
    return string_to_wasm(__adawebpack_o2i.too(identifier).url);
  },

  __adawebpack__sockets__WebSocket__send_str: function(identifier, address, length) {
    __adawebpack_o2i.too(identifier).send(string_to_js(address, length));
  },

  __adawebpack__sockets__WebSocket__send_bin: function(identifier, address, length) {
    __adawebpack_o2i.too(identifier).send(new Uint8Array(instance.exports.memory.buffer, address, length));
  },

  __adawebpack__sockets__WebSocket__close: function(identifier) {
    __adawebpack_o2i.too(identifier).close();
  }

};

__adawebpack_o2i = {
  o2r : new Map(),
  i2r : new Map(),
  last: 0,

  toi: function(o) {
    if (__adawebpack_o2i.o2r.has(o))
    {
      return __adawebpack_o2i.o2r.get(o).i;
    } else {
      __adawebpack_o2i.last++;
      r = {c: 0, i: __adawebpack_o2i.last, o: o};
      __adawebpack_o2i.o2r.set(o, r);
      __adawebpack_o2i.i2r.set(__adawebpack_o2i.last, r);
      return __adawebpack_o2i.last;
    }
  },

  too: function(i) {
    return __adawebpack_o2i.i2r.get(i).o;
  },

  sei: function(i) {
    __adawebpack_o2i.i2r.get(i).c++;
  },

  rel: function(i) {
    if (--__adawebpack_o2i.i2r.get(i).c === 0) {
      __adawebpack_o2i.o2r.delete(__adawebpack_o2i.i2r.get(i).o);
      __adawebpack_o2i.i2r.delete(i);
    }
  },
};

function string_to_js(address, size)
{
  return String.fromCharCode.apply(null, new Uint16Array(instance.exports.memory.buffer, address, size));
}

function string_to_wasm(item)
{
  s = instance.exports.__adawebpack__core__allocate_string(item.length);
  a = new Uint16Array(instance.exports.memory.buffer, s, item.length);
  for(var i=0, l=item.length; i < l; i++) {
    a[i] = item.charCodeAt(i);
  }
  return s;
}
