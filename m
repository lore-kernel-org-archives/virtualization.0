From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/4] drm/virtio: pass gem reservation object to ttm init
Date: Mon, 17 Jun 2019 16:11:48 +0200
Message-ID: <20190617141148.GE12905__27476.1809430615$1560780726$gmane$org@phenom.ffwll.local>
References: <20190617111406.14765-1-kraxel@redhat.com>
	<20190617111406.14765-2-kraxel@redhat.com>
	<20190617140825.GD12905@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190617140825.GD12905@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 17, 2019 at 04:08:25PM +0200, Daniel Vetter wrote:
> On Mon, Jun 17, 2019 at 01:14:03PM +0200, Gerd Hoffmann wrote:
> > With this gem and ttm will use the same reservation object,
> > so mixing and matching ttm / gem reservation helpers should
> > work fine.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> While doing my prime doc+cleanup series I wondered whether we should do
> this for everyone, and perhaps even remove ttm_bo.ttm_resv. Only driver
> which doesn't yet have a gem_bo embedded in the same allocation is vmwgfx,
> and that would be easy to fix by adding a vmwgfx_resv somehwere.
> 
> Anyway, looks like a solid start into the convergence story.
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Aside: if virtio ever allows dma-buf sharing with something else (or
multiple virtio-gpu instances), then together with my patch series this
will fix dma-buf import. Atm virtio ignores the reservation object of the
imported dma-buf, which for foreing objects really isn't correct.
-Daniel

> 
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_object.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> > index b2da31310d24..242766d644a7 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> > @@ -132,7 +132,8 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
> >  	virtio_gpu_init_ttm_placement(bo);
> >  	ret = ttm_bo_init(&vgdev->mman.bdev, &bo->tbo, params->size,
> >  			  ttm_bo_type_device, &bo->placement, 0,
> > -			  true, acc_size, NULL, NULL,
> > +			  true, acc_size, NULL,
> > +			  bo->gem_base.resv,
> >  			  &virtio_gpu_ttm_bo_destroy);
> >  	/* ttm_bo_init failure will call the destroy */
> >  	if (ret != 0)
> > -- 
> > 2.18.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
