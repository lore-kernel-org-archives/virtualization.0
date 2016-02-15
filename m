From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: Re: [PATCH v2 03/17] drm/exynos: removed optional dummy encoder
	mode_fixup function.
Date: Mon, 15 Feb 2016 15:18:34 +0000
Message-ID: <56C1EC4A.1000803@synopsys.com>
References: <cover.1455540137.git.palminha@synopsys.com>
	<3768b670931572de51fca1102efa18d20dd770ee.1455540137.git.palminha@synopsys.com>
	<CAMeQTsZLdMOnk7-isneoUyFBbQdiRUsGH6+EhD8W1LNB=80LVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMeQTsZLdMOnk7-isneoUyFBbQdiRUsGH6+EhD8W1LNB=80LVQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Cc: k.kozlowski@samsung.com, linux-samsung-soc@vger.kernel.org, heiko@sntech.de, benjamin.gaignard@linaro.org, David Airlie <airlied@linux.ie>, jingoohan1@gmail.com, dri-devel <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, p.zabel@pengutronix.de, vincent.abriou@st.com, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Patrik,

No particular reason... i was grepping along the development and probably didn't noticed that exynos was not completely nuked... :)

Regards,
C.Palminha

On 15-02-2016 13:49, Patrik Jakobsson wrote:
> Hi Carlos
> 
> Any particular reason why this patch isn't squashed with patch 8/17?
> 
> Thanks
> Patrik
> 
> 
> On Mon, Feb 15, 2016 at 1:58 PM, Carlos Palminha
> <CARLOS.PALMINHA@synopsys.com> wrote:
>> mode_fixup function for encoder drivers became optional with patch
>> http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha@synopsys.com
>>
>> This patch set nukes all the dummy mode_fixup implementations.
>>
>> (made on top of Daniel topic/drm-misc branch)
>>
>> Signed-off-by: Carlos Palminha <palminha@synopsys.com>
>> ---
>>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 8 --------
>>  1 file changed, 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> index e977a81..736115c 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> @@ -1597,13 +1597,6 @@ static int exynos_dsi_create_connector(struct drm_encoder *encoder)
>>         return 0;
>>  }
>>
>> -static bool exynos_dsi_mode_fixup(struct drm_encoder *encoder,
>> -                                 const struct drm_display_mode *mode,
>> -                                 struct drm_display_mode *adjusted_mode)
>> -{
>> -       return true;
>> -}
>> -
>>  static void exynos_dsi_mode_set(struct drm_encoder *encoder,
>>                                 struct drm_display_mode *mode,
>>                                 struct drm_display_mode *adjusted_mode)
>> @@ -1623,7 +1616,6 @@ static void exynos_dsi_mode_set(struct drm_encoder *encoder,
>>  }
>>
>>  static const struct drm_encoder_helper_funcs exynos_dsi_encoder_helper_funcs = {
>> -       .mode_fixup = exynos_dsi_mode_fixup,
>>         .mode_set = exynos_dsi_mode_set,
>>         .enable = exynos_dsi_enable,
>>         .disable = exynos_dsi_disable,
>> --
>> 2.5.0
>>
