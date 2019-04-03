From: Daniel Stone <daniel@fooishbar.org>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Date: Wed, 3 Apr 2019 16:15:08 +0100
Message-ID: <CAPj87rOE2K9nxV2p+KrMTDnijdKpmNP8BGSUJyK9YtFueJpkqw__6146.09739729843$1554304531$gmane$org@mail.gmail.com>
References: <20190403072318.31507-1-kraxel@redhat.com>
	<85ba308177f4e9ddee336d5110cb6df7a447cebf.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <85ba308177f4e9ddee336d5110cb6df7a447cebf.camel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adam Jackson <ajax@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 3 Apr 2019 at 16:12, Adam Jackson <ajax@redhat.com> wrote:
> On Wed, 2019-04-03 at 09:23 +0200, Gerd Hoffmann wrote:
> >  - Only DRM_FORMAT_RGB565 (depth 16) is supported.  The old driver does
> >    that too by default.  There was a module parameter which enables 24/32
> >    bpp support and disables higher resolutions (due to cirrus hardware
> >    constrains).  That parameter wasn't reimplemented.
>
> One slightly annoying aspect of this (well, initially of the patch to
> clamp the default to 16bpp, but this too) is that we only have a way to
> ask the driver which format it prefers, not which ones it supports at
> all. For X's modesetting driver (and yes some of this is because X is
> awful) this creates the following failure mode:
>
> 1: user sets up xorg.conf for depth 24
> 2: user upgrades kernel, reboots
> 3: X driver detects that depth 16 is preferred, but
> 4: X core respects user's xorg.conf and tries depth 24, which
> 5: throws -EINVAL and X won't start.
>
> Possibly X should work around this by transparently setting up a shadow
> framebuffer at the user's requested depth. The problem there is, if 565
> is preferred but 8888 works, you're adding a format-conversion blit in
> the middle for no reason. If I could ask the kernel for the entire list
> of supported formats, I could only set up the shadow if it was
> necessary.

There's already a list of supported formats for each DRM plane, which
you can get via drmModeGetPlane (being careful to enable universal
planes so you can discover the primary plane). The same information is
present in the 'IN_FORMATS' property, which is more difficult to parse
but also tells you about modifiers.

modesetting already pulls all this out (at least in the atomic path)
so we can reason about acceptable modifiers.

Cheers,
Daniel
