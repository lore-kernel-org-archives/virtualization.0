From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 09/20] drm: rcar-du: Rely on the default
	->best_encoder() behavior
Date: Fri, 3 Jun 2016 09:38:49 +0200
Message-ID: <20160603093849.136858be__8510.04122891954$1464939555$gmane$org@bbrezillon>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
	<1464877907-27723-10-git-send-email-boris.brezillon@free-electrons.com>
	<5863270.jtrd0Kruzj@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5863270.jtrd0Kruzj@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, Thierry Re ding <thierry.reding@gmail.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Alexandre Courbot <gnurou@gmail.com>, linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, linux-tegra@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Inki Dae <inki.dae@samsung.com>, linux-mediatek@lists
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 02 Jun 2016 23:57:14 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Boris,
> 
> Thank you for the patch.
> 
> On Thursday 02 Jun 2016 16:31:36 Boris Brezillon wrote:
> > All outputs have a 1:1 relationship between connectors and encoders,
> > and the driver is relying on the atomic helpers: we can drop the custom  
> > ->best_encoder() implementations and let the core call  
> > drm_atomic_helper_best_encoder() for us.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/gpu/drm/rcar-du/rcar_du_encoder.c | 12 ------------
> >  drivers/gpu/drm/rcar-du/rcar_du_encoder.h |  3 ---
> >  drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c |  1 -
> >  drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c |  1 -
> >  drivers/gpu/drm/rcar-du/rcar_du_vgacon.c  |  1 -
> >  5 files changed, 18 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
> > b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c index 4e939e4..55149e9 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
> > @@ -27,18 +27,6 @@
> >  #include "rcar_du_vgacon.h"
> > 
> >  /*
> > ---------------------------------------------------------------------------
> > -- - * Common connector functions
> > - */
> > -
> > -struct drm_encoder *
> > -rcar_du_connector_best_encoder(struct drm_connector *connector)
> > -{
> > -	struct rcar_du_connector *rcon = to_rcar_connector(connector);
> > -
> > -	return rcar_encoder_to_drm_encoder(rcon->encoder);
> > -}
> > -
> > -/*
> > ---------------------------------------------------------------------------
> > -- * Encoder
> >   */
> > 
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
> > b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h index 719b6f2a..a8669c3 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
> > @@ -49,9 +49,6 @@ struct rcar_du_connector {
> >  #define to_rcar_connector(c) \
> >  	container_of(c, struct rcar_du_connector, connector)
> > 
> > -struct drm_encoder *
> > -rcar_du_connector_best_encoder(struct drm_connector *connector);
> > -
> >  int rcar_du_encoder_init(struct rcar_du_device *rcdu,
> >  			 enum rcar_du_encoder_type type,
> >  			 enum rcar_du_output output,
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
> > b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c index 6c92714..612b4d5 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
> > @@ -52,7 +52,6 @@ static int rcar_du_hdmi_connector_mode_valid(struct
> > drm_connector *connector, static const struct drm_connector_helper_funcs
> > connector_helper_funcs = { .get_modes = rcar_du_hdmi_connector_get_modes,
> >  	.mode_valid = rcar_du_hdmi_connector_mode_valid,
> > -	.best_encoder = rcar_du_connector_best_encoder,
> >  };
> > 
> >  static enum drm_connector_status
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
> > b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c index e905f5d..6afd0af 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
> > @@ -59,7 +59,6 @@ static int rcar_du_lvds_connector_get_modes(struct
> > drm_connector *connector)
> > 
> >  static const struct drm_connector_helper_funcs connector_helper_funcs = {
> >  	.get_modes = rcar_du_lvds_connector_get_modes,
> > -	.best_encoder = rcar_du_connector_best_encoder,
> >  };
> > 
> >  static enum drm_connector_status
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
> > b/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c index 9d7e5c9..68f7ffa 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
> > @@ -28,7 +28,6 @@ static int rcar_du_vga_connector_get_modes(struct
> > drm_connector *connector)
> > 
> >  static const struct drm_connector_helper_funcs connector_helper_funcs = {
> >  	.get_modes = rcar_du_vga_connector_get_modes,
> > -	.best_encoder = rcar_du_connector_best_encoder,
> >  };
> > 
> >  static enum drm_connector_status  
> 
> You can also remove
> 
>         rcon->encoder = renc;
> 
> from rcar_du_vga_connector_init(), it's not needed anymore. The same code in 
> rcar_du_hdmi_connector_init() has to stay for now though, as it's used to 
> locate the slave encoder in the HDMI support code. That should change when the 
> driver will be converted to use drm_bridge.
> 
> I can also fix this during the conversion to drm_bridge if you don't want to 
> resubmit. In any case,

There will be a v2 anyway, so I'll squash this change in the patch.

> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
