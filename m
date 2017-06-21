From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Nouveau] [PATCH 01/11] drm/fb-helper: do a generic fb_setcmap
	helper in terms of crtc .gamma_set
Date: Wed, 21 Jun 2017 10:14:54 +0200
Message-ID: <20170621081454.ymykfka5peelkqxp__17327.2339314737$1498032910$gmane$org@phenom.ffwll.local>
References: <1497986735-14418-1-git-send-email-peda@axentia.se>
	<1497986735-14418-2-git-send-email-peda@axentia.se>
	<20170621073804.akyg4rxvoavjjt2v@phenom.ffwll.local>
	<dfd961c1-2ca9-d85e-fc28-d873666b9bf3@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <dfd961c1-2ca9-d85e-fc28-d873666b9bf3@daenzer.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Philippe Cornu <philippe.cornu@st.com>, dri-devel@lists.freedesktop.org, Peter Rosin <peda@axentia.se>, Yannick Fertre <yannick.fertre@st.com>, Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, virtualization@lists.linux-foundation.org, Vincent Abriou <vincent.abriou@st.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 21, 2017 at 04:59:31PM +0900, Michel D=E4nzer wrote:
> On 21/06/17 04:38 PM, Daniel Vetter wrote:
> > On Tue, Jun 20, 2017 at 09:25:25PM +0200, Peter Rosin wrote:
> >> This makes the redundant fb helpers .load_lut, .gamma_set and .gamma_g=
et
> >> totally obsolete.
> >>
> >> I think the gamma_store can end up invalid on error. But the way I read
> >> it, that can happen in drm_mode_gamma_set_ioctl as well, so why should
> >> this pesky legacy fbdev stuff be any better?
> >>
> >> drm_fb_helper_save_lut_atomic justs saves the gamma lut for later. How=
ever,
> >> it saves it to the gamma_store which should already be up to date with=
 what
> >> .gamma_get would return and is thus a nop. So, zap it.
> > =

> > Removing drm_fb_helper_save_lut_atomic should be a separate patch I
> > think.
> >  =

> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> =

> [...]
> =

> >> @@ -1167,50 +1150,6 @@ void drm_fb_helper_set_suspend_unlocked(struct =
drm_fb_helper *fb_helper,
> >>  }
> >>  EXPORT_SYMBOL(drm_fb_helper_set_suspend_unlocked);
> >>  =

> >> -static int setcolreg(struct drm_crtc *crtc, u16 red, u16 green,
> >> -		     u16 blue, u16 regno, struct fb_info *info)
> >> -{
> >> -	struct drm_fb_helper *fb_helper =3D info->par;
> >> -	struct drm_framebuffer *fb =3D fb_helper->fb;
> >> -
> >> -	if (info->fix.visual =3D=3D FB_VISUAL_TRUECOLOR) {
> > =

> > This case here seems gone, and it was also the pi=E8ce de r=E9sistance =
when I
> > tried tackling fbdev lut support. As far as I understand this stuff we =
do
> > not support FB_VISUAL_TRUECOLOR palette, and all that bitshifting here =
is
> > pointless. But I'm honestly not really clear.
> > =

> > I think removing this case should also be a separate patch, and I'd very
> > much prefer that someone with some fbdev-clue would ack it.
> =

> No need for anyone with fbdev-clue, just run fbset -i. :) fbcon uses a
> TRUECOLOR visual at depths > 8.

Then I understand even less what exactly this code does ... Should we keep
it? Is it just pure cargo-cult? Only needed when we'd change the color
depth of the fbdev buffer, which we never do at runtime?

> > It's a pre-existing bug, but should we also try to restore the fbdev lut
> > in drm_fb_helper_restore_fbdev_mode_unlocked()? Would be yet another bu=
g,
> > but might be relevant for your use-case. Just try to run both an fbdev
> > application and some kms-native thing, and then SIGKILL the native kms
> > app.
> > =

> > But since pre-existing not really required, and probably too much effor=
t.
> =

> I suspect something like that indeed needs to be done though. E.g.
> killing Xorg results in fbcon continuing to use the LUT set by Xorg.

Ok, the only trouble with that is atomic kms locking, which requires that
we can only do 1 commit per lock-holding time, and also
drm_modeset_lock_all is an evil hack and needs to be phased out. Two
solutions:

- We just update the lut after we've dropped the locks again in
  restore_fbdev_mode.
- We need both a legacy path, in restore_fbdev_mode_legacy, and an atomic
  path in restore_fbdev_mode_atomic. The latter cannot use the gamme_set
  callback, since that would call drm_atomic_helper_legacy_gamma_set for
  atomic drivers, which would result in two calls to drm_atomic_commit in
  one critical sections. Instead that needs to open-code the logic in
  drm_atomic_helper_legacy_gamma_set and integrate it into the overall
  fbdev restore commit.

The 2nd option is a bit more typing, but much cleaner. It also fits better
into some of the refactoring plans I have (I want to get rid of
drm_modeset_lock_all in the fbdev emulation). And has the benefit of
giving drivers a bit more complex fbdev emulation atomic commits, which
would be good for testing I think.

Cheers, Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
