From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/simple-kms: Standardize arguments for callbacks
Date: Thu, 24 Oct 2019 13:55:47 +0200
Message-ID: <20191024115547.GA11828__21821.0951004707$1571918167$gmane$org@phenom.ffwll.local>
References: <20191023101256.20509-1-daniel.vetter@ffwll.ch>
	<CACRpkdYfh=9oextiC1rtQ2UQ72OW_0TqjCe4AmvRtXKVv_ZazQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYfh=9oextiC1rtQ2UQ72OW_0TqjCe4AmvRtXKVv_ZazQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel.vetter@intel.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 23, 2019 at 05:40:32PM +0200, Linus Walleij wrote:
> On Wed, Oct 23, 2019 at 12:13 PM Daniel Vetter <daniel.vetter@ffwll.ch> w=
rote:
> =

> > Passing the wrong type feels icky, everywhere else we use the pipe as
> > the first parameter. Spotted while discussing patches with Thomas
> > Zimmermann.
> >
> > v2: Make xen compile correctly
> >
> > Acked-By: Thomas Zimmermann <tzimmermann@suse.de> (v1)
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Noralf Tr=F8nnes <noralf@tronnes.org>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Eric Anholt <eric@anholt.net>
> > Cc: Emil Velikov <emil.velikov@collabora.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> =

> Makes perfect sense.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for taking a look, applied.
-Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
