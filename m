From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 3/9] drm: replace "drm_dev_unref" function with
	"drm_dev_put"
Date: Mon, 19 Nov 2018 20:13:28 +0800
Message-ID: <20181119121327.GS5829__16856.3339779668$1542629524$gmane$org@dragon>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
	<20181115221634.22715-4-greenfoo@gluegarage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181115221634.22715-4-greenfoo@gluegarage.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fernando Ramos <greenfoo@gluegarage.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Gilles Muller <Gilles.Muller@lip6.fr>, David Airlie <airlied@linux.ie>, Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>, cocci@systeme.lip6.fr, Marek Vasut <marex@denx.de>, Archit Taneja <architt@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Russell King <linux+etnaviv@armlinux.org.uk>, Nicolas Palix <nicolas.palix@imag.fr>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, etnaviv@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, Christian Gmeiner <christian.gmeiner@gmail.com>Stefan Agner <s>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 15, 2018 at 11:16:23PM +0100, Fernando Ramos wrote:
> This patch unifies the naming of DRM functions for reference counting as
> requested on Documentation/gpu/todo.rst
> 
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
> ---
>  drivers/gpu/drm/arc/arcpgu_drv.c             | 4 ++--
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 4 ++--
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c        | 4 ++--
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c            | 4 ++--
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c        | 2 +-
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c     | 4 ++--
>  drivers/gpu/drm/tve200/tve200_drv.c          | 4 ++--
>  drivers/gpu/drm/zte/zx_drm_drv.c             | 4 ++--

We have already queued a patch [1] from Thomas Zimmermann for
zx_drm_drv.

Shawn

[1] https://patchwork.kernel.org/patch/10615837/
