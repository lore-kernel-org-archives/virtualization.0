From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH libdrm] drm: Remove create_handle()
	drm_framebuffer "virtual".
Date: Thu, 10 Aug 2017 10:59:14 +0200
Message-ID: <20170810085914.baxswpiaym5duub6__10856.2976507985$1502355578$gmane$org@phenom.ffwll.local>
References: <20170808234237.62051-1-djmk@google.com>
	<8a7bf59a-0f58-21ba-8b82-78e6ba873065@tronnes.org>
	<CAOvnNvbEt=Uyve3cu_+6BB0EepvO=OKC6gpV3isRef+UdVoX-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAOvnNvbEt=Uyve3cu_+6BB0EepvO=OKC6gpV3isRef+UdVoX-g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Kniss <djmk@google.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Edward O'Callaghan <funfunctor@folklore1984.net>, Dave Airlie <airlied@linux.ie>, nouveau <nouveau@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Vetter,
	Daniel" <daniel.vetter@intel.com>, baoyou.xie@linaro.org, Alex Xie <AlexBin.Xie@amd.com>, "StDenis,
	Tom" <tom.stdenis@amd.com>, zhoucm1 <David1.Zhou@amd.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Russell King <linux@armlinux.org.uk>, krzk@kernel.org, jonathanh@nvidia.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Matth
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 09, 2017 at 04:13:05PM -0700, Joe Kniss wrote:
> On Wed, Aug 9, 2017 at 12:14 PM, Noralf Tr=F8nnes <noralf@tronnes.org> wr=
ote:
> >
> > Den 09.08.2017 01.42, skrev Joe Kniss:
> >>
> >> Because all drivers currently use gem objects for framebuffer planes,
> >> the virtual create_handle() is not required.  This change adds a
> >> struct drm_gem_object *gems[4] field to drm_framebuffer and removes
> >> create_handle() function pointer from drm_framebuffer_funcs.  The
> >> corresponding *_create_handle() function is removed from each driver.
> >>
> >> In many cases this change eliminates a struct *_framebuffer object,
> >> as the only need for the derived struct is the addition of the gem
> >> object pointer.
> >>
> >> TESTED: compiled: allyesconfig ARCH=3Dx86,arm platforms:i915, rockchip
> >>
> >> Signed-off-by: Joe Kniss <djmk@google.com>
> >> ---
> >
> >
> > Hi Joe,
> >
> > I'm also looking into adding gem objs to drm_framebuffer in this patch:
> > [PATCH v2 01/22] drm: Add GEM backed framebuffer library
> > https://lists.freedesktop.org/archives/dri-devel/2017-August/149782.html
> >
> =

> Great.  There's only minimal overlap here.  I'll rebase this change on yo=
urs
> once it's in.

Even better than waiting: Reviewing each another's patches. Noralf has
commit rights and knows how driver-wide refactoring works, so you're all
covered to get this landed, if you provide a bit of review for the review
market :-)

Cheers, Daniel

> =

> > [...]
> >
> >> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c
> >> b/drivers/gpu/drm/drm_fb_cma_helper.c
> >> index ade319d10e70..f5f011b910b1 100644
> >> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> >> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> >> @@ -31,14 +31,9 @@
> >>     #define DEFAULT_FBDEFIO_DELAY_MS 50
> >>   -struct drm_fb_cma {
> >> -       struct drm_framebuffer          fb;
> >> -       struct drm_gem_cma_object       *obj[4];
> >> -};
> >> -
> >>   struct drm_fbdev_cma {
> >>         struct drm_fb_helper    fb_helper;
> >> -       struct drm_fb_cma       *fb;
> >> +       struct drm_framebuffer  *fb;
> >
> >
> > This fb pointer isn't necessary, since fb_helper already has one.
> >
> =

> I'll remove it... but I am sure when I look deeper there will be more
> of these in the various drivers too.
> =

> > Noralf.
> >
> >
> =

> -joe
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
