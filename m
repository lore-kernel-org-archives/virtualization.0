From: Gurchetan Singh <gurchetansingh@chromium.org>
Subject: Re: [PATCH v6 16/18] drm/virtio: rework
	virtio_gpu_cmd_context_{attach, detach}_resource
Date: Tue, 2 Jul 2019 17:08:46 -0700
Message-ID: <CAAfnVBmKotCfkrM4hph4++FDrVUYR8WKpomP7Y0-aergqHTSyA__43831.7255627894$1562112557$gmane$org@mail.gmail.com>
References: <20190702141903.1131-1-kraxel@redhat.com>
	<20190702141903.1131-17-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1528415554062751103=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190702141903.1131-17-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============1528415554062751103==
Content-Type: multipart/alternative; boundary="000000000000ed7192058cbbaa00"

--000000000000ed7192058cbbaa00
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 2, 2019 at 7:19 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Switch to the virtio_gpu_array_* helper workflow.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h |  4 ++--
>  drivers/gpu/drm/virtio/virtgpu_gem.c | 24 +++++++++++-------------
>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 10 ++++++----
>  3 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h
> b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index b1f63a21abb6..d99c54abd090 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -292,10 +292,10 @@ void virtio_gpu_cmd_context_destroy(struct
> virtio_gpu_device *vgdev,
>                                     uint32_t id);
>  void virtio_gpu_cmd_context_attach_resource(struct virtio_gpu_device
> *vgdev,
>                                             uint32_t ctx_id,
> -                                           uint32_t resource_id);
> +                                           struct virtio_gpu_object_array
> *objs);
>  void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device
> *vgdev,
>                                             uint32_t ctx_id,
> -                                           uint32_t resource_id);
> +                                           struct virtio_gpu_object_array
> *objs);
>  void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
>                            void *data, uint32_t data_size,
>                            uint32_t ctx_id,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c
> b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 6baf64141645..e75819dbba80 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -111,19 +111,18 @@ int virtio_gpu_gem_object_open(struct drm_gem_object
> *obj,
>  {
>         struct virtio_gpu_device *vgdev = obj->dev->dev_private;
>         struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
> -       struct virtio_gpu_object *qobj = gem_to_virtio_gpu_obj(obj);
> -       int r;
> +       struct virtio_gpu_object_array *objs;
>
>         if (!vgdev->has_virgl_3d)
>                 return 0;
>
> -       r = virtio_gpu_object_reserve(qobj);
> -       if (r)
> -               return r;
> +       objs = virtio_gpu_array_alloc(1);
> +       if (!objs)
> +               return -ENOMEM;
> +       virtio_gpu_array_add_obj(objs, obj);
>
>         virtio_gpu_cmd_context_attach_resource(vgdev, vfpriv->ctx_id,
> -                                              qobj->hw_res_handle);
> -       virtio_gpu_object_unreserve(qobj);
> +                                              objs);
>         return 0;
>  }
>
> @@ -132,19 +131,18 @@ void virtio_gpu_gem_object_close(struct
> drm_gem_object *obj,
>  {
>         struct virtio_gpu_device *vgdev = obj->dev->dev_private;
>         struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
> -       struct virtio_gpu_object *qobj = gem_to_virtio_gpu_obj(obj);
> -       int r;
> +       struct virtio_gpu_object_array *objs;
>
>         if (!vgdev->has_virgl_3d)
>                 return;
>
> -       r = virtio_gpu_object_reserve(qobj);
> -       if (r)
> +       objs = virtio_gpu_array_alloc(1);
> +       if (!objs)
>                 return;
> +       virtio_gpu_array_add_obj(objs, obj);
>

This seems to call drm_gem_object_get.  Without adding the objects to the
vbuf, aren't we missing the corresponding drm_gem_object_put_unlocked?

Some miscellaneous comments:
1) Maybe virtio_gpu_array can have it's own header and file?  virtgpu_drv.h
is getting rather big..
2) What data are you trying to protect with the additional references?  Is
it host side resources (i.e, the host GL texture or buffer object) or is it
guest side resources (fences)?  Guest side resources seem properly counted
to me.  GL is supposed to reference count pending resources as well, but
that's not always the case in practice.  A little blurb somewhere like
"hold on to 3D GEM buffers until the host response as a safety measure" or
"we could potential cause a kernel oops if [...]" would be useful.

The guest side looks sufficiently referenced to me, while the GL spec
indicates


>
>         virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
> -                                               qobj->hw_res_handle);
> -       virtio_gpu_object_unreserve(qobj);
> +                                              objs);
>  }
>
>  struct virtio_gpu_object_array *virtio_gpu_array_alloc(u32 nents)
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c
> b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 1c0097de419a..799d1339ee0f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -835,8 +835,9 @@ void virtio_gpu_cmd_context_destroy(struct
> virtio_gpu_device *vgdev,
>
>  void virtio_gpu_cmd_context_attach_resource(struct virtio_gpu_device
> *vgdev,
>                                             uint32_t ctx_id,
> -                                           uint32_t resource_id)
> +                                           struct virtio_gpu_object_array
> *objs)
>  {
> +       struct virtio_gpu_object *bo =
> gem_to_virtio_gpu_obj(objs->objs[0]);
>         struct virtio_gpu_ctx_resource *cmd_p;
>         struct virtio_gpu_vbuffer *vbuf;
>
> @@ -845,15 +846,16 @@ void virtio_gpu_cmd_context_attach_resource(struct
> virtio_gpu_device *vgdev,
>
>         cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE);
>         cmd_p->hdr.ctx_id = cpu_to_le32(ctx_id);
> -       cmd_p->resource_id = cpu_to_le32(resource_id);
> +       cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
>         virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
>
>  }
>
>  void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device
> *vgdev,
>                                             uint32_t ctx_id,
> -                                           uint32_t resource_id)
> +                                           struct virtio_gpu_object_array
> *objs)
>  {
> +       struct virtio_gpu_object *bo =
> gem_to_virtio_gpu_obj(objs->objs[0]);
>         struct virtio_gpu_ctx_resource *cmd_p;
>         struct virtio_gpu_vbuffer *vbuf;
>
> @@ -862,7 +864,7 @@ void virtio_gpu_cmd_context_detach_resource(struct
> virtio_gpu_device *vgdev,
>
>         cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE);
>         cmd_p->hdr.ctx_id = cpu_to_le32(ctx_id);
> -       cmd_p->resource_id = cpu_to_le32(resource_id);
> +       cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
>         virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
>  }
>
> --
> 2.18.1
>
>

--000000000000ed7192058cbbaa00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 2, 2019 at 7:19 AM Gerd H=
offmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank">kraxel@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Switch to the virtio_gpu_array_* helper workflow.<br>
<br>
Signed-off-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" targe=
t=3D"_blank">kraxel@redhat.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/virtio/virtgpu_drv.h |=C2=A0 4 ++--<br>
=C2=A0drivers/gpu/drm/virtio/virtgpu_gem.c | 24 +++++++++++-------------<br=
>
=C2=A0drivers/gpu/drm/virtio/virtgpu_vq.c=C2=A0 | 10 ++++++----<br>
=C2=A03 files changed, 19 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h<br>
index b1f63a21abb6..d99c54abd090 100644<br>
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h<br>
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h<br>
@@ -292,10 +292,10 @@ void virtio_gpu_cmd_context_destroy(struct virtio_gpu=
_device *vgdev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t id);<br>
=C2=A0void virtio_gpu_cmd_context_attach_resource(struct virtio_gpu_device =
*vgdev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint32_t ctx_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uint32_t resource_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct virtio_gpu_object_array *objs);<br>
=C2=A0void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device =
*vgdev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint32_t ctx_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uint32_t resource_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct virtio_gpu_object_array *objs);<br>
=C2=A0void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0void *data, uint32_t data_size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ctx_id,<br>
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/=
virtgpu_gem.c<br>
index 6baf64141645..e75819dbba80 100644<br>
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c<br>
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c<br>
@@ -111,19 +111,18 @@ int virtio_gpu_gem_object_open(struct drm_gem_object =
*obj,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_device *vgdev =3D obj-&gt;dev=
-&gt;dev_private;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_fpriv *vfpriv =3D file-&gt;dr=
iver_priv;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_object *qobj =3D gem_to_virti=
o_gpu_obj(obj);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_object_array *objs;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vgdev-&gt;has_virgl_3d)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D virtio_gpu_object_reserve(qobj);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0objs =3D virtio_gpu_array_alloc(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!objs)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_array_add_obj(objs, obj);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_cmd_context_attach_resource(vgdev, v=
fpriv-&gt;ctx_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 qobj-&gt;hw_res_handle);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_object_unreserve(qobj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 objs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
@@ -132,19 +131,18 @@ void virtio_gpu_gem_object_close(struct drm_gem_objec=
t *obj,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_device *vgdev =3D obj-&gt;dev=
-&gt;dev_private;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_fpriv *vfpriv =3D file-&gt;dr=
iver_priv;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_object *qobj =3D gem_to_virti=
o_gpu_obj(obj);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_object_array *objs;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vgdev-&gt;has_virgl_3d)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D virtio_gpu_object_reserve(qobj);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0objs =3D virtio_gpu_array_alloc(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!objs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_array_add_obj(objs, obj);<br></block=
quote><div><br></div><div>This seems to call=C2=A0drm_gem_object_get.=C2=A0=
 Without adding the objects to the vbuf, aren&#39;t we missing the correspo=
nding=C2=A0drm_gem_object_put_unlocked?</div><div><br></div><div>Some misce=
llaneous comments:</div><div>1) Maybe virtio_gpu_array can have it&#39;s ow=
n header and file?=C2=A0 virtgpu_drv.h is getting rather big..</div><div>2)=
 What data are you trying to protect with the additional references?=C2=A0 =
Is it host side resources (i.e, the host GL texture or buffer object) or is=
 it guest side resources (fences)?=C2=A0 Guest side resources seem properly=
 counted to me.=C2=A0 GL is supposed to reference count pending resources a=
s well, but that&#39;s not always the case in practice.=C2=A0 A little blur=
b somewhere like &quot;hold on to 3D GEM buffers until the host response as=
 a safety measure&quot; or &quot;we could potential cause a kernel oops if =
[...]&quot; would be useful.</div><div><br></div><div>The guest side looks =
sufficiently referenced to me, while the GL spec indicates=C2=A0 =C2=A0</di=
v><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_cmd_context_detach_resource(vgdev, v=
fpriv-&gt;ctx_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0qobj-&gt;hw_res_handle);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_object_unreserve(qobj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 objs);<br>
=C2=A0}<br>
<br>
=C2=A0struct virtio_gpu_object_array *virtio_gpu_array_alloc(u32 nents)<br>
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c<br>
index 1c0097de419a..799d1339ee0f 100644<br>
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c<br>
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c<br>
@@ -835,8 +835,9 @@ void virtio_gpu_cmd_context_destroy(struct virtio_gpu_d=
evice *vgdev,<br>
<br>
=C2=A0void virtio_gpu_cmd_context_attach_resource(struct virtio_gpu_device =
*vgdev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint32_t ctx_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uint32_t resource_id)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct virtio_gpu_object_array *objs)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_object *bo =3D gem_to_virtio_=
gpu_obj(objs-&gt;objs[0]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctx_resource *cmd_p;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_vbuffer *vbuf;<br>
<br>
@@ -845,15 +846,16 @@ void virtio_gpu_cmd_context_attach_resource(struct vi=
rtio_gpu_device *vgdev,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd_p-&gt;hdr.type =3D cpu_to_le32(VIRTIO_GPU_C=
MD_CTX_ATTACH_RESOURCE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd_p-&gt;hdr.ctx_id =3D cpu_to_le32(ctx_id);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cmd_p-&gt;resource_id =3D cpu_to_le32(resource_=
id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmd_p-&gt;resource_id =3D cpu_to_le32(bo-&gt;hw=
_res_handle);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);<br>
<br>
=C2=A0}<br>
<br>
=C2=A0void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device =
*vgdev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint32_t ctx_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uint32_t resource_id)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct virtio_gpu_object_array *objs)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_object *bo =3D gem_to_virtio_=
gpu_obj(objs-&gt;objs[0]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_ctx_resource *cmd_p;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_vbuffer *vbuf;<br>
<br>
@@ -862,7 +864,7 @@ void virtio_gpu_cmd_context_detach_resource(struct virt=
io_gpu_device *vgdev,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd_p-&gt;hdr.type =3D cpu_to_le32(VIRTIO_GPU_C=
MD_CTX_DETACH_RESOURCE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd_p-&gt;hdr.ctx_id =3D cpu_to_le32(ctx_id);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cmd_p-&gt;resource_id =3D cpu_to_le32(resource_=
id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmd_p-&gt;resource_id =3D cpu_to_le32(bo-&gt;hw=
_res_handle);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);<br>
=C2=A0}<br>
<br>
-- <br>
2.18.1<br>
<br>
</blockquote></div></div>

--000000000000ed7192058cbbaa00--

--===============1528415554062751103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1528415554062751103==--
