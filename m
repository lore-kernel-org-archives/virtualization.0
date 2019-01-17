From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm: Split out drm_probe_helper.h
Date: Thu, 17 Jan 2019 17:45:41 +0100
Message-ID: <20190117164541.GE3271__9205.96864675662$1547755177$gmane$org@phenom.ffwll.local>
References: <20190116163442.12622-1-daniel.vetter@ffwll.ch>
	<20190116181018.GA27364@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190116181018.GA27364@ravnborg.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Liviu Dudau <liviu.dudau@arm.com>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org, nouveau@lists.freedesktop.org, CK Hu <ck.hu@mediatek.com>, spice-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@intel.com>, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, etnaviv@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, linux-mediatek@lists.infradead.orgRodrigo Vivi <ro>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 16, 2019 at 07:10:18PM +0100, Sam Ravnborg wrote:
> Hi Daniel.
> 
> > v5: Actually try to sort them, and while at it, sort all the ones I
> > touch.
> 
> Applied this variant on top of drm-misc and did a build test.
> Looked good for ia64, x86 and alpha.
> 
> Took a closer look at the changes to atmel_hlcd - and they looked OK.
> 
> But I noticed that atmel_hlcdc uses only drm_kms_helper_poll_init() and
> drm_kms_helper_poll_fini().
> But there are no hits on DRM_CONNECTOR_POLL - so I think we maybe
> have a driver here where we have plugged the drm_poll infrastructure,
> but it is not in use.
> 
> >  include/drm/drm_crtc_helper.h                 | 16 -----------
> 
> The list of include files in this file could be dropped and replaced by:
> struct drm_connector;
> struct drm_device;
> struct drm_display_mode;
> struct drm_encoder;
> struct drm_framebuffer;
> struct drm_mode_set;
> struct drm_modeset_acquire_ctx;
> 
> I tried to do so on top of your patch.
> But there were too many build errros and I somehow lost the motivation.

Yeah the drm_crtc_helper.h header is a bit the miniature drmP.h for legacy
kms drivers. Just removing it from all the atomic drivers caused lots of
fallout, I expect even more if you entirely remove the includes it has.
Maybe a todo, care to pls create that patch since it's your idea?
-Daniel

> 
> 
> >  include/drm/drm_probe_helper.h                | 27 +++++++++++++++++++
> This on the other hand is fine - as expected as this is a new file.
> 
> But the above is just some random comments so:
> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
