From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: Re: [PATCH 11/16] drm/atmel-hldcd: removed optional dummy crtc
	mode_fixup function.
Date: Wed, 17 Feb 2016 09:02:44 +0000
Message-ID: <56C43734.9050708__31714.7880713039$1455699973$gmane$org@synopsys.com>
References: <cover.1455630967.git.palminha@synopsys.com>
	<e4bdb8552c245f8b73084b93da60460a00f7798c.1455630967.git.palminha@synopsys.com>
	<20160216175856.32bbb579@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160216175856.32bbb579@bbrezillon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: nicolas.pitre@linaro.org, jianwei.wang.chn@gmail.com, alison.wang@freescale.com, airlied@linux.ie, daniel.vetter@ffwll.ch, patrik.r.jakobsson@gmail.com, virtualization@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, jani.nikula@intel.com, dri-devel@lists.freedesktop.org, benjamin.gaignard@linaro.org, vincent.abriou@st.com, sudipm.mukherjee@gmail.com, laurent.pinchart@ideasonboard.com
List-Id: virtualization@lists.linuxfoundation.org

Thanks Boris.

@Daniel, do you want me to resend this patch or will you fix it directly in mode-fixup git branch?

On 16-02-2016 16:58, Boris Brezillon wrote:
> On Tue, 16 Feb 2016 14:19:06 +0000
> Carlos Palminha <CARLOS.PALMINHA@synopsys.com> wrote:
> 
>> This patch set nukes all the dummy crtc mode_fixup implementations.
>> (made on top of Daniel topic/drm-misc branch)
> 
> There's 2 typos in the subject line (s/hldcd/hlcdc/ and
> s/removed/remove/), and you're removing an empty line after
> atmel_hlcdc_crtc_create() definition (which is correct, but I'm not
> sure it should be part of the same patch).
> Otherwise it looks good to me.
> Once you've fixed those 2 things, you can add my
> 
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
>>
>> Signed-off-by: Carlos Palminha <palminha@synopsys.com>
>> ---
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 9 ---------
>>  1 file changed, 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> index 9863291..58c4f78 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> @@ -121,13 +121,6 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>>  			   cfg);
>>  }
>>  
>> -static bool atmel_hlcdc_crtc_mode_fixup(struct drm_crtc *crtc,
>> -					const struct drm_display_mode *mode,
>> -					struct drm_display_mode *adjusted_mode)
>> -{
>> -	return true;
>> -}
>> -
>>  static void atmel_hlcdc_crtc_disable(struct drm_crtc *c)
>>  {
>>  	struct drm_device *dev = c->dev;
>> @@ -261,7 +254,6 @@ static void atmel_hlcdc_crtc_atomic_flush(struct drm_crtc *crtc,
>>  }
>>  
>>  static const struct drm_crtc_helper_funcs lcdc_crtc_helper_funcs = {
>> -	.mode_fixup = atmel_hlcdc_crtc_mode_fixup,
>>  	.mode_set = drm_helper_crtc_mode_set,
>>  	.mode_set_nofb = atmel_hlcdc_crtc_mode_set_nofb,
>>  	.mode_set_base = drm_helper_crtc_mode_set_base,
>> @@ -349,4 +341,3 @@ fail:
>>  	atmel_hlcdc_crtc_destroy(&crtc->base);
>>  	return ret;
>>  }
>> -
> 
> 
