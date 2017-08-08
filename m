From: Dave Airlie <airlied@gmail.com>
Subject: Re: [Intel-gfx] [PATCH libdrm] drm: Remove create_handle()
	drm_framebuffer "virtual".
Date: Wed, 9 Aug 2017 09:50:05 +1000
Message-ID: <CAPM=9tzQuont4B9ybMXEDpqP583V_G64ypCR4E+zGvxLGdTULw__4231.35455134815$1502236220$gmane$org@mail.gmail.com>
References: <20170808234237.62051-1-djmk@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170808234237.62051-1-djmk@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Kniss <djmk@chromium.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Edward O'Callaghan <funfunctor@folklore1984.net>, Dave Airlie <airlied@linux.ie>, nouveau <nouveau@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Vetter,
	Daniel" <daniel.vetter@intel.com>, baoyou.xie@linaro.org, Alex Xie <AlexBin.Xie@amd.com>, "StDenis,
	Tom" <tom.stdenis@amd.com>, zhoucm1 <David1.Zhou@amd.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Joonyoung Shim <jy0922.shim@samsung.com>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, Russell King <linux@armlinux.org.uk>, krzk@kernel.org, jonathanh@nvidia.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Tomi
List-Id: virtualization@lists.linuxfoundation.org

On 9 August 2017 at 09:42, Joe Kniss <djmk@chromium.org> wrote:
> Because all drivers currently use gem objects for framebuffer planes,
> the virtual create_handle() is not required.  This change adds a
> struct drm_gem_object *gems[4] field to drm_framebuffer and removes
> create_handle() function pointer from drm_framebuffer_funcs.  The
> corresponding *_create_handle() function is removed from each driver.
>
> In many cases this change eliminates a struct *_framebuffer object,
> as the only need for the derived struct is the addition of the gem
> object pointer.

Why the libdrm in the tag? this isn't for libdrm.

This will break drivers that don't current implement the virtual at all.

I think vwmgfx.

The current code checks if the virtual is there before callng it, this code
just calls the gem code always.

Dave.
