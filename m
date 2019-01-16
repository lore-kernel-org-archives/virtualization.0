From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] drm: Split out drm_probe_helper.h
Date: Wed, 16 Jan 2019 19:10:18 +0100
Message-ID: <20190116181018.GA27364__19725.0553560027$1547692629$gmane$org@ravnborg.org>
References: <20190116163442.12622-1-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190116163442.12622-1-daniel.vetter@ffwll.ch>
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

> v5: Actually try to sort them, and while at it, sort all the ones I
> touch.

Applied this variant on top of drm-misc and did a build test.
Looked good for ia64, x86 and alpha.

Took a closer look at the changes to atmel_hlcd - and they looked OK.

But I noticed that atmel_hlcdc uses only drm_kms_helper_poll_init() and
drm_kms_helper_poll_fini().
But there are no hits on DRM_CONNECTOR_POLL - so I think we maybe
have a driver here where we have plugged the drm_poll infrastructure,
but it is not in use.

>  include/drm/drm_crtc_helper.h                 | 16 -----------

The list of include files in this file could be dropped and replaced by:
struct drm_connector;
struct drm_device;
struct drm_display_mode;
struct drm_encoder;
struct drm_framebuffer;
struct drm_mode_set;
struct drm_modeset_acquire_ctx;

I tried to do so on top of your patch.
But there were too many build errros and I somehow lost the motivation.


>  include/drm/drm_probe_helper.h                | 27 +++++++++++++++++++
This on the other hand is fine - as expected as this is a new file.

But the above is just some random comments so:

Acked-by: Sam Ravnborg <sam@ravnborg.org>
