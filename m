From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 17/23] drm/qxl: use generic fbdev emulation
Date: Mon, 28 Jan 2019 09:59:51 +0100
Message-ID: <20190128085951.gkap3by26xgkbwaa__40344.3847362482$1548681688$gmane$org@sirius.home.kraxel.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
	<20190118122020.27596-18-kraxel@redhat.com>
	<e31c0fdd-315a-59cf-e7fe-dfd6a064f6ee@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e31c0fdd-315a-59cf-e7fe-dfd6a064f6ee@tronnes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 25, 2019 at 06:25:27PM +0100, Noralf Tr=F8nnes wrote:
> =

> =

> Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> > Switch qxl over to the new generic fbdev emulation.
> > =

> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/qxl/qxl_display.c | 7 -------
> >  drivers/gpu/drm/qxl/qxl_drv.c     | 2 ++
> >  2 files changed, 2 insertions(+), 7 deletions(-)
> > =

> > diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qx=
l_display.c
> > index ef832f98ab..9c751f01e3 100644
> > --- a/drivers/gpu/drm/qxl/qxl_display.c
> > +++ b/drivers/gpu/drm/qxl/qxl_display.c
> > @@ -1221,18 +1221,11 @@ int qxl_modeset_init(struct qxl_device *qdev)
> >  	qxl_display_read_client_monitors_config(qdev);
> >  =

> >  	drm_mode_config_reset(&qdev->ddev);
> > -
> > -	/* primary surface must be created by this point, to allow
> > -	 * issuing command queue commands and having them read by
> > -	 * spice server. */
> > -	qxl_fbdev_init(qdev);
> >  	return 0;
> >  }
> >  =

> >  void qxl_modeset_fini(struct qxl_device *qdev)
> >  {
> > -	qxl_fbdev_fini(qdev);
> > -
> >  	qxl_destroy_monitors_object(qdev);
> >  	drm_mode_config_cleanup(&qdev->ddev);
> >  }
> > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_dr=
v.c
> > index 13c8a662f9..3fce7d16df 100644
> > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > @@ -93,6 +93,8 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_=
device_id *ent)
> >  	if (ret)
> >  		goto modeset_cleanup;
> >  =

> > +	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
> =

> I couldn't find that this was part of old fbdev code, so it would be
> nice to mention it in the commit message.

It actually is, but a bit hidden because it doesn't use a helper you can
easily grep for.  Instead sets fb_info->apertures->ranges[0] in
qxlfb_create(), which has the same effect.

cheers,
  Gerd
