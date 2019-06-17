From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 06/59] drm/prime: Actually remove DRIVER_PRIME everywhere
Date: Mon, 17 Jun 2019 18:56:06 +0100
Message-ID: <20190617175606.GE26766@arch-x1c3>
References: <20190614203615.12639-1-daniel.vetter@ffwll.ch>
	<20190614203615.12639-7-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190614203615.12639-7-daniel.vetter@ffwll.ch>
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
Cc: linux-aspeed@lists.ozlabs.org, nouveau@lists.freedesktop.org, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel.vetter@intel.com>, linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, lima@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org, VMware Graphics <linux-graphics-maintainer@vmware.com>, NXP Linux Team <linux-imx@nxp.com>, spice-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, etnaviv@lists.freedesktop.org, xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, freedreno@lists.freedesktop.org
List-Id: virtualization@lists.linuxfoundation.org

On 2019/06/14, Daniel Vetter wrote:
> Split out to make the functional changes stick out more.
> 
Since this patch flew-by, as standalone one (intentionally or not) I'd
add, anything vaguely like:

"Core users of DRIVER_PRIME were removed from core with prior patches."

HTH
Emil
