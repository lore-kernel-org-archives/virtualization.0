From: Vincent ABRIOU <vincent.abriou@st.com>
Subject: Re: [PATCH 7/8] drm: Nuke drm_atomic_helper_connector_dpms
Date: Tue, 8 Aug 2017 10:05:11 +0000
Message-ID: <462c98df-2633-3c61-9ae6-e567780941c0__40439.8171733648$1502187612$gmane$org@st.com>
References: <20170725080122.20548-1-daniel.vetter@ffwll.ch>
	<20170725080122.20548-8-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170725080122.20548-8-daniel.vetter@ffwll.ch>
Content-Language: en-US
Content-ID: <C1D66642F494334E83389CC9FEAF0D3A@st.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc: Martyn Welch <martyn.welch@collabora.co.uk>, Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Andrzej Hajda <a.hajda@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Romain Perier <romain.perier@collabora.com>, Daniel Vetter <daniel.vetter@intel.com>, Jyri Sarha <jsarha@ti.com>, Heiko Stuebner <heiko@sntech.de>, Marek Vasut <marex@denx.de>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Archit Taneja <architt@codeaurora.org>, Lars-Pete
List-Id: virtualization@lists.linuxfoundation.org



On 07/25/2017 10:01 AM, Daniel Vetter wrote:
> It's dead code, the core handles all this directly now.
> 
> The only special case is nouveau and tda988x which used one function
> for both legacy modeset code and -nv50 atomic world instead of 2
> vtables. But amounts to exactly the same.
> 
> v2: Rebase over the panel/brideg refactorings in stm/ltdc.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

[...]

>   drivers/gpu/drm/sti/sti_dvo.c                      |  1 -
>   drivers/gpu/drm/sti/sti_hda.c                      |  1 -
>   drivers/gpu/drm/sti/sti_hdmi.c                     |  1 -

Acked-by: Vincent Abriou <vincent.abriou@st.com>

BR
Vincent
