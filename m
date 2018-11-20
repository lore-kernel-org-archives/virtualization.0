From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 3/9] drm: replace "drm_dev_unref" function with
	"drm_dev_put"
Date: Tue, 20 Nov 2018 11:53:43 +0200
Message-ID: <87lg5of520.fsf__35877.9351147406$1542707479$gmane$org@intel.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
	<20181115221634.22715-4-greenfoo@gluegarage.com>
	<1542363310.23489.22.camel@pengutronix.de>
	<1542387884.1134874.1579436592.07F916C5@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1542387884.1134874.1579436592.07F916C5@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fernando <greenfoo@gluegarage.com>, Lucas Stach <l.stach@pengutronix.de>, dri-devel@lists.freedesktop.org
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Gilles Muller <Gilles.Muller@lip6.fr>, David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org, cocci@systeme.lip6.fr, Marek Vasut <marex@denx.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Russell King <linux+etnaviv@armlinux.org.uk>, Nicolas Palix <nicolas.palix@imag.fr>, etnaviv@lists.freedesktop.org, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org, Michal Marek <michal.lkml@markovi.net>, Boris Brezillon <boris.brezillon@bootlin.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Kiera
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 16 Nov 2018, Fernando <greenfoo@gluegarage.com> wrote:
> And, related to this, what is the "good" branch to start developing
> new drm patches? Is is "drm-next" or "linux-next"? Or does it change
> depending on how much time until the merge window closes?

I advise most of our developers to work on drm-tip because it contains
the latest stuff in drm core, i915, amd, most of the small drivers, as
well as sound. It's a bit like "linux-next for graphics". And you don't
really have to care about the merge cycles with that.

But YMMV, it probably doesn't work for everyone.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
