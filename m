From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] qxl: fix null-pointer crash during suspend
Date: Tue, 02 Oct 2018 13:05:50 +0300
Message-ID: <1688275.zophSNHJ2k__31913.3286284798$1538474617$gmane$org@avalon>
References: <20180904202747.14968-1-peter@lekensteyn.nl>
	<20181002081422.GH11082@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181002081422.GH11082@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Alan Jenkins <alan.christopher.jenkins@gmail.com>, Peter Wu <peter@lekensteyn.nl>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

On Tuesday, 2 October 2018 11:14:22 EEST Daniel Vetter wrote:
> On Tue, Sep 04, 2018 at 10:27:47PM +0200, Peter Wu wrote:
> > "crtc->helper_private" is not initialized by the QXL driver and thus the
> 
> This is still initialized, it's the ->disable that goes boom. At least the
> call to drm_crtc_helper_add is still there. The ->disable was removed in:
> 
> commit 64581714b58bc3e16ede8dc37a025c3aa0e0eef1
> Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Date:   Fri Jun 30 12:36:45 2017 +0300
> 
>     drm: Convert atomic drivers from CRTC .disable() to .atomic_disable()
> 
> Fixes: 64581714b58b ("drm: Convert atomic drivers from CRTC .disable() to
> .atomic_disable()") Cc: <stable@vger.kernel.org> # v4.14+
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I'll let Gerd pick this one up, after some testing. Also adding Laurent.

Sorry for breaking it :-( Please let me know if there's something I can do to 
help.

> > "crtc_funcs->disable" call would crash (resulting in suspend failure).
> > Fix this by converting the suspend/resume functions to use the
> > drm_mode_config_helper_* helpers.
> > 
> > Tested system sleep with QEMU 3.0 using "echo mem > /sys/power/state".
> > 
> > During suspend the following message is visible from QEMU:
> >     spice/server/display-channel.c:2425:display_channel_validate_surface:
> >     canvas address is 0x7fd05da68308 for 0 (and is NULL)
> >     spice/server/display-channel.c:2426:display_channel_validate_surface:
> >     failed on 0> 
> > This seems to be triggered by QXL_IO_NOTIFY_CMD after
> > QXL_IO_DESTROY_PRIMARY_ASYNC, but aside from the warning things still
> > seem to work (tested with both the GTK and -spice options).
> > 
> > Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> > ---
> > Hi,
> > 
> > I found this issue while trying to suspend a VM that uses QXL. In order to
> > see the stack trace over serial, boot with no_console_suspend. Searching
> > for "qxl_drm_freeze" showed one recent report from Alan:
> > https://lkml.kernel.org/r/891e334c-cf19-032c-b996-59ac166fcde1@gmail.com
> > 
> > Kind regards,
> > Peter
> > ---
> > 
> >  drivers/gpu/drm/qxl/qxl_drv.c | 26 +++++---------------------
> >  1 file changed, 5 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> > index 2445e75cf7ea..d00f45eed03c 100644
> > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > @@ -136,20 +136,11 @@ static int qxl_drm_freeze(struct drm_device *dev)
> > 
> >  {
> >  
> >  	struct pci_dev *pdev = dev->pdev;
> >  	struct qxl_device *qdev = dev->dev_private;
> > 
> > -	struct drm_crtc *crtc;
> > -
> > -	drm_kms_helper_poll_disable(dev);
> > -
> > -	console_lock();
> > -	qxl_fbdev_set_suspend(qdev, 1);
> > -	console_unlock();
> > +	int ret;
> > 
> > -	/* unpin the front buffers */
> > -	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> > -		const struct drm_crtc_helper_funcs *crtc_funcs = crtc-
>helper_private;
> > -		if (crtc->enabled)
> > -			(*crtc_funcs->disable)(crtc);
> > -	}
> > +	ret = drm_mode_config_helper_suspend(dev);
> > +	if (ret)
> > +		return ret;
> > 
> >  	qxl_destroy_monitors_object(qdev);
> >  	qxl_surf_evict(qdev);
> > 
> > @@ -175,14 +166,7 @@ static int qxl_drm_resume(struct drm_device *dev,
> > bool thaw)> 
> >  	}
> >  	
> >  	qxl_create_monitors_object(qdev);
> > 
> > -	drm_helper_resume_force_mode(dev);
> > -
> > -	console_lock();
> > -	qxl_fbdev_set_suspend(qdev, 0);
> > -	console_unlock();
> > -
> > -	drm_kms_helper_poll_enable(dev);
> > -	return 0;
> > +	return drm_mode_config_helper_resume(dev);
> > 
> >  }
> >  
> >  static int qxl_pm_suspend(struct device *dev)


-- 
Regards,

Laurent Pinchart
