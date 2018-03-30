From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 00/24] drm_framebuffer boilerplate removal
Date: Fri, 30 Mar 2018 10:47:53 -0400
Message-ID: <CADnq5_MSsXgUdGNPu76c0qE1As5wmTbJr147KfTeG8E-LGG5ig__20812.5113546432$1522421160$gmane$org@mail.gmail.com>
References: <CAPj87rPKDwBK7qoOoY2zXoS6T02toATPRsk=39m_OBr=s1kXTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPj87rPKDwBK7qoOoY2zXoS6T02toATPRsk=39m_OBr=s1kXTw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Stone <daniels@collabora.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Thierry Reding <thierry.reding@gmail.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Russell King <linux@armlinux.org.uk>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, CK Hu <ck.hu@mediatek.com>, Dave Airlie <airlied@redhat.com>, Rob Clark <robdclark@gmail.com>, David Lechner <david@lechnology.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Jani Nikula <jani.nikula@linux.intel.com>, Inki Dae <inki.dae@samsung.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>li
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 30, 2018 at 10:11 AM, Daniel Stone <daniels@collabora.com> wrote:
> Hi,
> I've been working on a getfb2[0] ioctl, which amongst other things
> supports multi-planar framebuffers as well as modifiers. getfb
> currently calls the framebuffer's handle_create hook, which doesn't
> support multiple planes.
>
> Thanks to Noralf's recent work, drivers can just store GEM objects
> directly in drm_framebuffer. I use this directly in getfb2: we need
> direct access to the GEM objects and not a vfunc in order to not hand
> out duplicate GEM names for the same object.
>
> This series converts all drivers except for nouveau, which was a
> little too non-trivial for my comfort, to storing GEM objects directly
> in drm_framebuffer. For those drivers whose driver_framebuffer struct
> was nothing but drm_framebuffer + BO, it deletes the driver-specific
> struct. It also makes use of Noralf's generic framebuffer helpers for
> create_handle and destroy where possible.
>
> I don't have the hardware for most of these drivers, so have had to
> settle for just staring really hard at the diff.
>
> I intend to remove create_handle when all drivers are converted over
> to placing BOs directly inside drm_framebuffer. For most drivers
> there's a relatively easy conversion to using the helpers for
> basically all framebuffer handling and fbdev emulation as well, though
> that's a bit further than I was willing to go without hardware to test
> on ...

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Cheers,
> Daniel
>
> [0]: https://lists.freedesktop.org/archives/dri-devel/2018-March/170512.html
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
