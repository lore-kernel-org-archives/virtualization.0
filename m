From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 40/44] drm/cirrus: Don't use
 drm_device->dev_private
Date: Wed, 8 Apr 2020 10:04:49 +0200
Message-ID: <20200408080449.GT14965@ravnborg.org>
References: <20200403135828.2542770-1-daniel.vetter@ffwll.ch>
 <20200403135828.2542770-41-daniel.vetter@ffwll.ch>
 <a7bb7d54-2c71-b087-8347-888a5019aacc@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <a7bb7d54-2c71-b087-8347-888a5019aacc@suse.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Thomas.

On Mon, Apr 06, 2020 at 01:58:54PM +0200, Thomas Zimmermann wrote:
> =

> =

> Am 03.04.20 um 15:58 schrieb Daniel Vetter:
> > Upcasting using a container_of macro is more typesafe, faster and
> > easier for the compiler to optimize.
> > =

> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: "Noralf Tr=F8nnes" <noralf@tronnes.org>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Eric Anholt <eric@anholt.net>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: virtualization@lists.linux-foundation.org
> > ---
> >  drivers/gpu/drm/cirrus/cirrus.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > =

> > diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/c=
irrus.c
> > index 4b65637147ba..744a8e337e41 100644
> > --- a/drivers/gpu/drm/cirrus/cirrus.c
> > +++ b/drivers/gpu/drm/cirrus/cirrus.c
> > @@ -59,6 +59,8 @@ struct cirrus_device {
> >  	void __iomem		       *mmio;
> >  };
> >  =

> > +#define to_cirrus(_dev) container_of(_dev, struct cirrus_device, dev)
> > +
> =

> Maybe to_cirrus_device() ? I had the same comment for vbox and I think
> it applies to all patches.

The variable name is consistently using the name "cirrus" - so my
personal preference is to_cirrus().

Also IMO struct cirrus_device is misnamed. It is more than a device.

	Sam

> =

> Best regards
> Thomas
> =

> >  /* ------------------------------------------------------------------ =
*/
> >  /*
> >   * The meat of this driver. The core passes us a mode and we have to p=
rogram
> > @@ -311,7 +313,7 @@ static int cirrus_mode_set(struct cirrus_device *ci=
rrus,
> >  static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
> >  			       struct drm_rect *rect)
> >  {
> > -	struct cirrus_device *cirrus =3D fb->dev->dev_private;
> > +	struct cirrus_device *cirrus =3D to_cirrus(fb->dev);
> >  	void *vmap;
> >  	int idx, ret;
> >  =

> > @@ -436,7 +438,7 @@ static void cirrus_pipe_enable(struct drm_simple_di=
splay_pipe *pipe,
> >  			       struct drm_crtc_state *crtc_state,
> >  			       struct drm_plane_state *plane_state)
> >  {
> > -	struct cirrus_device *cirrus =3D pipe->crtc.dev->dev_private;
> > +	struct cirrus_device *cirrus =3D to_cirrus(pipe->crtc.dev);
> >  =

> >  	cirrus_mode_set(cirrus, &crtc_state->mode, plane_state->fb);
> >  	cirrus_fb_blit_fullscreen(plane_state->fb);
> > @@ -445,7 +447,7 @@ static void cirrus_pipe_enable(struct drm_simple_di=
splay_pipe *pipe,
> >  static void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
> >  			       struct drm_plane_state *old_state)
> >  {
> > -	struct cirrus_device *cirrus =3D pipe->crtc.dev->dev_private;
> > +	struct cirrus_device *cirrus =3D to_cirrus(pipe->crtc.dev);
> >  	struct drm_plane_state *state =3D pipe->plane.state;
> >  	struct drm_crtc *crtc =3D &pipe->crtc;
> >  	struct drm_rect rect;
> > @@ -573,7 +575,6 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
> >  		return PTR_ERR(cirrus);
> >  =

> >  	dev =3D &cirrus->dev;
> > -	dev->dev_private =3D cirrus;
> >  =

> >  	cirrus->vram =3D devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0),
> >  				    pci_resource_len(pdev, 0));
> > =

> =

> -- =

> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> (HRB 36809, AG N=FCrnberg)
> Gesch=E4ftsf=FChrer: Felix Imend=F6rffer
> =





> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
