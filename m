From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 16/18] drm/virtio: rework
	virtio_gpu_cmd_context_{attach,detach}_resource
Date: Thu, 4 Jul 2019 14:00:31 +0200
Message-ID: <20190704120031.mbgkwcrmxvmtp2ll__41355.1240040519$1562241841$gmane$org@sirius.home.kraxel.org>
References: <20190702141903.1131-1-kraxel@redhat.com>
	<20190702141903.1131-17-kraxel@redhat.com>
	<CAAfnVBmKotCfkrM4hph4++FDrVUYR8WKpomP7Y0-aergqHTSyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAAfnVBmKotCfkrM4hph4++FDrVUYR8WKpomP7Y0-aergqHTSyA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 02, 2019 at 05:08:46PM -0700, Gurchetan Singh wrote:
> On Tue, Jul 2, 2019 at 7:19 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > Switch to the virtio_gpu_array_* helper workflow.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_drv.h |  4 ++--
> >  drivers/gpu/drm/virtio/virtgpu_gem.c | 24 +++++++++++-------------
> >  drivers/gpu/drm/virtio/virtgpu_vq.c  | 10 ++++++----
> >  3 files changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > index b1f63a21abb6..d99c54abd090 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > @@ -292,10 +292,10 @@ void virtio_gpu_cmd_context_destroy(struct
> > virtio_gpu_device *vgdev,
> >                                     uint32_t id);
> >  void virtio_gpu_cmd_context_attach_resource(struct virtio_gpu_device
> > *vgdev,
> >                                             uint32_t ctx_id,
> > -                                           uint32_t resource_id);
> > +                                           struct virtio_gpu_object_array
> > *objs);
> >  void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device
> > *vgdev,
> >                                             uint32_t ctx_id,
> > -                                           uint32_t resource_id);
> > +                                           struct virtio_gpu_object_array
> > *objs);
> >  void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
> >                            void *data, uint32_t data_size,
> >                            uint32_t ctx_id,
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c
> > b/drivers/gpu/drm/virtio/virtgpu_gem.c
> > index 6baf64141645..e75819dbba80 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> > @@ -111,19 +111,18 @@ int virtio_gpu_gem_object_open(struct drm_gem_object
> > *obj,
> >  {
> >         struct virtio_gpu_device *vgdev = obj->dev->dev_private;
> >         struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
> > -       struct virtio_gpu_object *qobj = gem_to_virtio_gpu_obj(obj);
> > -       int r;
> > +       struct virtio_gpu_object_array *objs;
> >
> >         if (!vgdev->has_virgl_3d)
> >                 return 0;
> >
> > -       r = virtio_gpu_object_reserve(qobj);
> > -       if (r)
> > -               return r;
> > +       objs = virtio_gpu_array_alloc(1);
> > +       if (!objs)
> > +               return -ENOMEM;
> > +       virtio_gpu_array_add_obj(objs, obj);
> >
> >         virtio_gpu_cmd_context_attach_resource(vgdev, vfpriv->ctx_id,
> > -                                              qobj->hw_res_handle);
> > -       virtio_gpu_object_unreserve(qobj);
> > +                                              objs);
> >         return 0;
> >  }
> >
> > @@ -132,19 +131,18 @@ void virtio_gpu_gem_object_close(struct
> > drm_gem_object *obj,
> >  {
> >         struct virtio_gpu_device *vgdev = obj->dev->dev_private;
> >         struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
> > -       struct virtio_gpu_object *qobj = gem_to_virtio_gpu_obj(obj);
> > -       int r;
> > +       struct virtio_gpu_object_array *objs;
> >
> >         if (!vgdev->has_virgl_3d)
> >                 return;
> >
> > -       r = virtio_gpu_object_reserve(qobj);
> > -       if (r)
> > +       objs = virtio_gpu_array_alloc(1);
> > +       if (!objs)
> >                 return;
> > +       virtio_gpu_array_add_obj(objs, obj);
> >
> 
> This seems to call drm_gem_object_get.  Without adding the objects to the
> vbuf, aren't we missing the corresponding drm_gem_object_put_unlocked?

Yes.  Fixed.

> Some miscellaneous comments:
> 1) Maybe virtio_gpu_array can have it's own header and file?  virtgpu_drv.h
> is getting rather big..

Longer-term it might move out anyway due to becoming a generic drm helper.

> 2) What data are you trying to protect with the additional references?  Is
> it host side resources (i.e, the host GL texture or buffer object) or is it
> guest side resources (fences)?

Protect the (guest) gem object, specifically make sure the
bo->hw_res_handle stays valid.

cheers,
  Gerd
