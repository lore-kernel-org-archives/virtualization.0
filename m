From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/simple-kms: Standardize arguments for callbacks
Date: Wed, 23 Oct 2019 10:53:19 +0200
Message-ID: <20191023085319.GS11828__13649.6100037888$1571820818$gmane$org@phenom.ffwll.local>
References: <20191022155536.27939-1-daniel.vetter@ffwll.ch>
	<56867554-5169-e249-8e55-043d07be3e99@suse.de>
	<CAKMK7uHo2L8m+VT1vSMjOdScJmuSQP032HyAFj_aYiCJu+gaRQ@mail.gmail.com>
	<64a4e824-f730-2ac4-0b02-4ead2bce4b69@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <64a4e824-f730-2ac4-0b02-4ead2bce4b69@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel.vetter@intel.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 23, 2019 at 08:47:57AM +0200, Thomas Zimmermann wrote:
> Hi
> =

> Am 22.10.19 um 21:03 schrieb Daniel Vetter:
> > On Tue, Oct 22, 2019 at 7:16 PM Thomas Zimmermann <tzimmermann@suse.de>=
 wrote:
> >>
> >> Hi,
> >>
> >> there are two types of callbacks in struct
> >> drm_simple_display_pipe_funcs: functions that are genuine to simple KM=
S,
> >> and functions that are merely forwarded from another structure (crtc,
> >> plane, etc).
> >>
> >> In the former category are enable(), disable(), check(), and update().
> >> Those should probably receive a simple display pipe as their first arg=
ument.
> > =

> > mode_valid _very_ much belongs to this category too, since there's
> > mode_valid hooks also on other objects. But simple pipe helper
> > condenses that down to one mode_valid hook (we could also put the
> > mode_valid onto encoder, wouldn't change anything).
> > =

> >> In the latter category are mode_valid(), prepare_fb(), cleanup_fb(),
> >> enable_vblank(), and disable_vblank(). IMHO those functions should
> >> receive a pointer to the original structure as their first argument.
> >> This type provides the context in which the operations make sense. (Ev=
en
> >> their documentation already refers to the original structure.)
> > =

> > Now on those you can maybe make a case that they only exist in one
> > object. But the entire point of simple helpers was to condense the zoo
> > of drm types down to one. Only reason you don't also get a
> > drm_simple_display_pipe_state is that this one would be a bit more
> > work to make work correctly. If we full on leak all the underlying
> > objects, then you might as well set them up yourself and set up all
> > the hooks, it's just a few more lines of code.
> > =

> > Imo for simple pipe we should go more into that direction, not less.
> > =

> >> I admit that not all are as shareable as prepare_fb() and enable_fb().
> >> But what else than boiler-plate wrappers do we get from simple display
> >> pipe here?
> > =

> > Boiler plate wrappers is pretty much the entire point of simple pipe
> > helpers. Anytime you're interested in the things it abstracts away
> > (crtc, plane, encoder) you probably want your own atomic
> > implementation.
> =

> I was speaking of boiler-plate code in drivers and other helpers (e.g.,
> drm_gem_fb_simple_display_pipe_prepare_fb() )
> =

> TBH I don't think it is possible to build and use simple pipe without
> exposing the underlying primitives (crtc, plane, connector). This would
> require a completely separate set of atomic helpers. IMHO the current
> simple pipe is a mid-layer and comes with typical mid-layer problems.

Helpers can be midlayers, as long as their optional. And for simple I
agree it's not a perfect illusion, it's a tradeoff between having a huge
helper library that remaps everything and still enabling useful code and
complexity savings in the tiny drivers.

Maybe another rule of thumb: If your driver has more than one source file,
simple pipe is maybe not what you're looking for. Exceptions apply ofc.
simple pipe was designed for drm/tiny, and it utterly excels at that. But
that doesn't make it a general purpose tool.

> Anyway, given your rational for the current design, I'll update my
> recent patches for prepare_fb() to support simple pipe.
> =

> For this patch
> =

>   Acked-By: Thomas Zimmermann <tzimmermann@suse.de>

Thanks, will apply.
-Daniel

> =

> Best regards
> Thomas
> =

> > conversion is a good fit, it's not meant to be useful for all small
> > drivers. Only for the _really_ simple ones.
> > =

> > Otherwise if we readd all the bells and whistles to simple pipe
> > helpers, then we just end back where we started. That's also why I
> > personally think explicit simple wrappers would fit better, instead of
> > wrestling the prepare/cleanup_fb functions to match full atomic
> > helpers.
> > -Daniel
> > =

> >>
> >> Best regards
> >> Thomas
> >>
> >> Am 22.10.19 um 17:55 schrieb Daniel Vetter:
> >>> Passing the wrong type feels icky, everywhere else we use the pipe as
> >>> the first parameter. Spotted while discussing patches with Thomas
> >>> Zimmermann.
> >>>
> >>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> >>> Cc: Noralf Tr=F8nnes <noralf@tronnes.org>
> >>> Cc: Gerd Hoffmann <kraxel@redhat.com>
> >>> Cc: Eric Anholt <eric@anholt.net>
> >>> Cc: Emil Velikov <emil.velikov@collabora.com>
> >>> Cc: virtualization@lists.linux-foundation.org
> >>> Cc: Linus Walleij <linus.walleij@linaro.org>
> >>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> >>> ---
> >>>  drivers/gpu/drm/cirrus/cirrus.c         | 2 +-
> >>>  drivers/gpu/drm/drm_simple_kms_helper.c | 2 +-
> >>>  drivers/gpu/drm/pl111/pl111_display.c   | 4 ++--
> >>>  include/drm/drm_simple_kms_helper.h     | 2 +-
> >>>  4 files changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus=
/cirrus.c
> >>> index 7d08d067e1a4..248c9f765c45 100644
> >>> --- a/drivers/gpu/drm/cirrus/cirrus.c
> >>> +++ b/drivers/gpu/drm/cirrus/cirrus.c
> >>> @@ -390,7 +390,7 @@ static int cirrus_conn_init(struct cirrus_device =
*cirrus)
> >>>  /* -----------------------------------------------------------------=
- */
> >>>  /* cirrus (simple) display pipe                                     =
       */
> >>>
> >>> -static enum drm_mode_status cirrus_pipe_mode_valid(struct drm_crtc *=
crtc,
> >>> +static enum drm_mode_status cirrus_pipe_mode_valid(struct drm_simple=
_display_pipe *pipe,
> >>>                                                  const struct drm_dis=
play_mode *mode)
> >>>  {
> >>>       if (cirrus_check_size(mode->hdisplay, mode->vdisplay, NULL) < 0)
> >>> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/dr=
m/drm_simple_kms_helper.c
> >>> index 046055719245..15fb516ae2d8 100644
> >>> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> >>> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> >>> @@ -43,7 +43,7 @@ drm_simple_kms_crtc_mode_valid(struct drm_crtc *crt=
c,
> >>>               /* Anything goes */
> >>>               return MODE_OK;
> >>>
> >>> -     return pipe->funcs->mode_valid(crtc, mode);
> >>> +     return pipe->funcs->mode_valid(pipe, mode);
> >>>  }
> >>>
> >>>  static int drm_simple_kms_crtc_check(struct drm_crtc *crtc,
> >>> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/=
pl111/pl111_display.c
> >>> index 024771a4083e..703ddc803c55 100644
> >>> --- a/drivers/gpu/drm/pl111/pl111_display.c
> >>> +++ b/drivers/gpu/drm/pl111/pl111_display.c
> >>> @@ -48,10 +48,10 @@ irqreturn_t pl111_irq(int irq, void *data)
> >>>  }
> >>>
> >>>  static enum drm_mode_status
> >>> -pl111_mode_valid(struct drm_crtc *crtc,
> >>> +pl111_mode_valid(struct drm_simple_display_pipe *pipe,
> >>>                const struct drm_display_mode *mode)
> >>>  {
> >>> -     struct drm_device *drm =3D crtc->dev;
> >>> +     struct drm_device *drm =3D pipe->crtc.dev;
> >>>       struct pl111_drm_dev_private *priv =3D drm->dev_private;
> >>>       u32 cpp =3D priv->variant->fb_bpp / 8;
> >>>       u64 bw;
> >>> diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_si=
mple_kms_helper.h
> >>> index 4d89cd0a60db..15afee9cf049 100644
> >>> --- a/include/drm/drm_simple_kms_helper.h
> >>> +++ b/include/drm/drm_simple_kms_helper.h
> >>> @@ -49,7 +49,7 @@ struct drm_simple_display_pipe_funcs {
> >>>        *
> >>>        * drm_mode_status Enum
> >>>        */
> >>> -     enum drm_mode_status (*mode_valid)(struct drm_crtc *crtc,
> >>> +     enum drm_mode_status (*mode_valid)(struct drm_simple_display_pi=
pe *pipe,
> >>>                                          const struct drm_display_mod=
e *mode);
> >>>
> >>>       /**
> >>>
> >>
> >> --
> >> Thomas Zimmermann
> >> Graphics Driver Developer
> >> SUSE Software Solutions Germany GmbH
> >> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> >> (HRB 36809, AG N=FCrnberg)
> >> Gesch=E4ftsf=FChrer: Felix Imend=F6rffer
> >>
> > =

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





-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
