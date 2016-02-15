From: Vincent ABRIOU <vincent.abriou@st.com>
Subject: Re: [PATCH v2 16/17] drm/sti: removed optional dummy encoder
	mode_fixup function.
Date: Mon, 15 Feb 2016 17:44:13 +0100
Message-ID: <56C2005D.3020302__10776.4306515039$1455576511$gmane$org@st.com>
References: <cover.1455540137.git.palminha@synopsys.com>
	<7f47c6a7b00e4f16af672ebf3a277e31ad117e21.1455540137.git.palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7f47c6a7b00e4f16af672ebf3a277e31ad117e21.1455540137.git.palminha@synopsys.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "k.kozlowski@samsung.com" <k.kozlowski@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "airlied@linux.ie" <airlied@linux.ie>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "patrik.r.jakobsson@gmail.com" <patrik.r.jakobsson@gmail.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "kgene@kernel.org" <kgene@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mark.yao@rock-chips.com" <mark.yao@rock-chips.com>
List-Id: virtualization@lists.linuxfoundation.org



On 02/15/2016 02:01 PM, Carlos Palminha wrote:
> mode_fixup function for encoder drivers became optional with patch
> http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha@synopsys.com
>
> This patch set nukes all the dummy mode_fixup implementations.
>
> (made on top of Daniel topic/drm-misc branch)
>
> Signed-off-by: Carlos Palminha <palminha@synopsys.com>
> ---
>   drivers/gpu/drm/sti/sti_tvout.c | 10 ----------
>   1 file changed, 10 deletions(-)
>

Acked-by: Vincent Abriou <vincent.abriou@st.com>

BR
Vincent
