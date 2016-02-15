From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 10/17] drm/imx: removed optional dummy encoder
	mode_fixup function.
Date: Mon, 15 Feb 2016 17:16:55 +0100
Message-ID: <1455553015.4899.38.camel__38907.0777725012$1455576489$gmane$org@pengutronix.de>
References: <cover.1455540137.git.palminha@synopsys.com>
	<8bf274e8f6908142a9f940d3f2913e4a735e0caa.1455540137.git.palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8bf274e8f6908142a9f940d3f2913e4a735e0caa.1455540137.git.palminha@synopsys.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Cc: k.kozlowski@samsung.com, linux-samsung-soc@vger.kernel.org, heiko@sntech.de, airlied@linux.ie, jingoohan1@gmail.com, patrik.r.jakobsson@gmail.com, virtualization@lists.linux-foundation.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, dri-devel@lists.freedesktop.org, benjamin.gaignard@linaro.org, vincent.abriou@st.com, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com
List-Id: virtualization@lists.linuxfoundation.org

Am Montag, den 15.02.2016, 13:00 +0000 schrieb Carlos Palminha:
> mode_fixup function for encoder drivers became optional with patch
> http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha@synopsys.com
> 
> This patch set nukes all the dummy mode_fixup implementations.
> 
> (made on top of Daniel topic/drm-misc branch)
> 
> Signed-off-by: Carlos Palminha <palminha@synopsys.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
