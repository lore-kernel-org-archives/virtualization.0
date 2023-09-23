Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B058CE7A81
	for <virtualization@archiver.kernel.org>; Sat, 23 Sep 2023 01:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9C78405E2;
	Sat, 23 Sep 2023 01:48:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C9C78405E2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.a=rsa-sha256 header.s=default header.b=gWUmwGML
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rhCowYk_8fUQ; Sat, 23 Sep 2023 01:48:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 35B78400C5;
	Sat, 23 Sep 2023 01:48:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35B78400C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 130C3C0071;
	Sat, 23 Sep 2023 01:48:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55595C0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Sep 2023 01:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 288BB60F1F
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Sep 2023 01:48:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 288BB60F1F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com
 header.a=rsa-sha256 header.s=default header.b=gWUmwGML
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3GsgY8zK9y8p
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Sep 2023 01:48:48 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 23 Sep 2023 01:48:48 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C1AE60C11
Received: from omta34.uswest2.a.cloudfilter.net
 (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C1AE60C11
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Sep 2023 01:48:48 +0000 (UTC)
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
 by cmsmtp with ESMTP
 id jkwWqgTGHOzKljreOqFrci; Sat, 23 Sep 2023 01:41:40 +0000
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with ESMTPS
 id jreNqeVwJ3zN9jreOqWMRm; Sat, 23 Sep 2023 01:41:40 +0000
X-Authority-Analysis: v=2.4 cv=YJCMdDKx c=1 sm=1 tr=0 ts=650e4254
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=-VAfIpHNAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=srlwD-8ojaedGGhPAyx8:22 a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=26mug2OgFJgVqTLezDBhTB27nouTOVCr4w9qfN76dRA=; b=gWUmwGML3LS+6SgXzjEE2Nv0zY
 6WvEyyE/D9r5aCj97Qk0hU44T53pcFDfJ0WyOiS/y/dodQv4zYLJWZVtBZg6aROkxEqiqHxWMAJ61
 +bd/LUHoDPJN5875L0nhhFj064A/XItWKFZvpwztqirYg9Wo8HlyZHMRGa2FXndjO5z3QOeEehb5x
 9pWKegwGcf6NwBGOyvfvUpoFR09ZCPES7oKwjP54v2sT2Oga4jwYCdhMiQe75/Xvu5af1uayGh/Zi
 LcKlz1Qa7HgfYM4nH9rvd6EoSM6xQwXtEMS+kzdzm26iBfpWyzv/7s9+4bmv2+xTf8q41SvM9G7GE
 L+885mkQ==;
Received: from [94.239.20.48] (port=50846 helo=[192.168.1.98])
 by gator4166.hostgator.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96)
 (envelope-from <gustavo@embeddedor.com>) id 1qjkgW-000Qi0-2c;
 Fri, 22 Sep 2023 13:15:24 -0500
Message-ID: <75f4a4fa-a177-db4a-4653-f121a1e54141@embeddedor.com>
Date: Fri, 22 Sep 2023 20:16:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/9] drm/vc4: Annotate struct vc4_perfmon with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, David Airlie <airlied@gmail.com>
References: <20230922173110.work.084-kees@kernel.org>
 <20230922173216.3823169-6-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922173216.3823169-6-keescook@chromium.org>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.linux-foundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjkgW-000Qi0-2c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:50846
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN3BkBePPxjvpg9NZkzr2QUZlvr5ZNHKw48jzTpkex3za3NO7jn/QB8uHtjBUTU2cQxqATAD4wwTgXqHL1rJRwrgoWZIdpejdNUz6TAOB0z/fSW6CQ48
 7dGUKnVIOSl3L5QS3rePDPs7NKxB1NeeLx07mQa/jdrXhnW5mg6/BupNjcqsZK2Suef4fXpmOPW1DudUMeGivmylkIpTExKsjE/RT1s7fYSaggbf7JMvqpzP
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>, Emma Anholt <emma@anholt.net>,
 Tom Rix <trix@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, Prike Liang <Prike.Liang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Matthew Brost <matthew.brost@intel.com>, Karol Herbst <kherbst@redhat.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, amd-gfx@lists.freedesktop.org,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, Nathan Chancellor <nathan@kernel.org>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>,
 linux-hardening@vger.kernel.org, Lijo Lazar <lijo.lazar@amd.com>,
 Lyude Paul <lyude@redhat.com>, Yifan Zhang <yifan1.zhang@amd.com>,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Kevin Wang <kevin1.wang@amd.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Melissa Wen <mwen@igalia.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Evan Quan <evan.quan@amd.com>, Sean Paul <sean@poorly.run>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>, Le Ma <le.ma@amd.com>,
 freedreno@lists.freedesktop.org, Bjorn Andersson <andersson@kernel.org>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
 Zack Rusin <zackr@vmware.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Nirmoy Das <nirmoy.das@intel.com>,
 Lang Yu <Lang.Yu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Harrison <john.c.harrison@Intel.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 9/22/23 11:32, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct vc4_perfmon.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Emma Anholt <emma@anholt.net>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/gpu/drm/vc4/vc4_drv.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index bf66499765fb..ab61e96e7e14 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -76,7 +76,7 @@ struct vc4_perfmon {
>   	 * Note that counter values can't be reset, but you can fake a reset by
>   	 * destroying the perfmon and creating a new one.
>   	 */
> -	u64 counters[];
> +	u64 counters[] __counted_by(ncounters);
>   };
>   
>   struct vc4_dev {
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
