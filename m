From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] drm: Split out drm_probe_helper.h
Date: Wed, 23 Jan 2019 18:00:15 +0100
Message-ID: <20190123170015.GA23138__14649.9328709737$1548263042$gmane$org@ravnborg.org>
References: <20190116181018.GA27364@ravnborg.org>
	<20190117210334.13234-1-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190117210334.13234-1-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Neil Armstrong <narmstrong@baylibre.com>, nouveau@lists.freedesktop.org, Liviu Dudau <liviu.dudau@arm.com>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org, CK Hu <ck.hu@mediatek.com>, spice-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@intel.com>, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, etnaviv@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-tegra@vger
List-Id: virtualization@lists.linuxfoundation.org

Hi Daniel.

On Thu, Jan 17, 2019 at 10:03:34PM +0100, Daniel Vetter wrote:
> Having the probe helper stuff (which pretty much everyone needs) in
> the drm_crtc_helper.h file (which atomic drivers should never need) is
> confusing. Split them out.
> 
> To make sure I actually achieved the goal here I went through all
> drivers. And indeed, all atomic drivers are now free of
> drm_crtc_helper.h includes.

How are the plans to get this patchset merged?
There were dependencies on onging drmP.h removal in i915 IIRC?
I guess my "Minimize drmP.h dependencies" patch-set also have a role in this.

This does not hold up any work of mine, mainly wanted to make
sure this was not lost between all the other patches.

	Sam
