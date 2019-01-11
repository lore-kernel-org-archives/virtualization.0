From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/cirrus: fix connector leak at unload
Date: Fri, 11 Jan 2019 23:16:38 +0100
Message-ID: <20190111221638.GG21184__38882.65169594$1547693132$gmane$org@phenom.ffwll.local>
References: <20190111140242.29002-1-robdclark@gmail.com>
	<20190111220620.GF21184@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190111220620.GF21184@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rob Clark <robdclark@gmail.com>
Cc: Rob Clark <rclark@redhat.com>, Daniel Stone <daniels@collabora.com>, David Airlie <airlied@linux.ie>, YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Thierry Reding <treding@nvidia.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 11, 2019 at 11:06:20PM +0100, Daniel Vetter wrote:
> On Fri, Jan 11, 2019 at 09:02:34AM -0500, Rob Clark wrote:
> > This fixes an '*ERROR* connector VGA-2 leaked!' splat at driver unload.
> > 
> > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > ---
> > Similar case to the issue that was fixed recently in drm/ast
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Actually I just pushed a patch to drm-misc-next to rename this function to
drm_helper_force_disable_all(), so you need to respin ... My r-b still
holds.
-Daniel

> 
> > 
> >  drivers/gpu/drm/cirrus/cirrus_fbdev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
> > index 4dd499c7d1ba..bb379ec4c182 100644
> > --- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
> > +++ b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
> > @@ -256,6 +256,8 @@ static int cirrus_fbdev_destroy(struct drm_device *dev,
> >  {
> >  	struct drm_framebuffer *gfb = gfbdev->gfb;
> >  
> > +	drm_crtc_force_disable_all(dev);
> > +
> >  	drm_fb_helper_unregister_fbi(&gfbdev->helper);
> >  
> >  	vfree(gfbdev->sysram);
> > -- 
> > 2.20.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
