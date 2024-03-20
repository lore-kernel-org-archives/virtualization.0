Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682CD54BF7
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Mar 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948366; cv=none; b=V8wTMe7ky9WytDWR43CjIOCVk5Bli7eKi/G/WBBbKdCWVL8KoYyQYrSxbtEBBg0vL8//MygcJFaetcBK/rTn4vbcABmqMsSeEKPdvEB1gOiIy2HYoGw3qcXKSckoGRoRtHAKpmm8OZTRgSy2JZEyE4fiHdqkthCbCNUhZTyB8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948366; c=relaxed/simple;
	bh=zR+ah/AZybH8jZSLZxrEDknNvOMLtHTgIU4u4ltErhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWw3peZVg1jL0P+G7w+sY7DSjYylcz8Sk60NAvxMKqhRlSIf81ubLk61zKyh9S098XE1WBHSRTymYiXbR7uQdTRGShrTx/SF1KzMBnIjzUbBPEMgE9N5jPUgO5VGnox5YUVlRY1rKluf2KgsA16glIoyfLNHijKUUz3k4xHxELU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=VK1dkoim; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="VK1dkoim"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B102260C21
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Mar 2024 15:26:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fcTWzndwxZuQ
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Mar 2024 15:26:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.237.130.52; helo=wp530.webpack.hosteurope.de; envelope-from=regressions@leemhuis.info; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 41FD260C07
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41FD260C07
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=he214686 header.b=VK1dkoim
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 41FD260C07
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Mar 2024 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=/EpaCQTpGqGU5ULt8qAmE+s8SSReKSogNzvd/au7Mjs=;
	t=1710948363; x=1711380363; b=VK1dkoimVrResAdC5OFibRO/WNeeSGJIYT81lOHUoE1QaXN
	S23TAN61cY5/umeushGw3Q19Ce4TOaDQsnqTVabY+gAaEEtLPx+cZEYA6L1/wFrFUY+u1V56cdgFa
	y32UGApPY6TVi5N2mVohD5xwZleMV5DHzmYwuUlfX8SQCcwqwmL22cHeMmHeelZzB72yEMvXSsxtU
	LsGYoGgLMmOa3bed04bu3ujE2cUfE8jkfk8o9yi0tlQXKb2EPdparCBLxqJdJWDdrDQ0Uv2idwmod
	SSpV1H5lpZMkKyjOSbwHqra/mhncZ10Cn0jM0dVAK7nrF/dqZ58DLsPL91IMSUbA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rmxp7-0004iK-29; Wed, 20 Mar 2024 16:25:49 +0100
Message-ID: <db4c8e74-5c79-49be-9781-a5d8669eccc1@leemhuis.info>
Date: Wed, 20 Mar 2024 16:25:48 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/qxl: fixes qxl_fence_wait
Content-Language: en-US, de-DE
To: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
Cc: 1054514@bugs.debian.org, airlied@redhat.com, carnil@debian.org,
 daniel@ffwll.ch, dri-devel@lists.freedesktop.org, kraxel@redhat.com,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 spice-devel@lists.freedesktop.org, timo.lindfors@iki.fi,
 tzimmermann@suse.de, virtualization@lists.linux-foundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
References: <fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info>
 <20240308010851.17104-1-dreaming.about.electric.sheep@gmail.com>
 <20240308010851.17104-2-dreaming.about.electric.sheep@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240308010851.17104-2-dreaming.about.electric.sheep@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710948363;8fc86e2f;
X-HE-SMSGID: 1rmxp7-0004iK-29

On 08.03.24 02:08, Alex Constantino wrote:
> Fix OOM scenario by doing multiple notifications to the OOM handler through
> a busy wait logic.
> Changes from commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") would
> result in a '[TTM] Buffer eviction failed' exception whenever it reached a
> timeout.
> 
> Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
> Link: https://lore.kernel.org/regressions/fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info
> Reported-by: Timo Lindfors <timo.lindfors@iki.fi>
> Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054514
> Signed-off-by: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
> ---
>  drivers/gpu/drm/qxl/qxl_release.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

Hey Dave and Gerd as well as Thomas, Maarten and Maxime (the latter two
I just added to the CC), it seems to me this regression fix did not
maybe any progress since it was posted. Did I miss something, is it just
"we are busy with the merge window", or is there some other a reason?
Just wondering, I just saw someone on a Fedora IRC channel complaining
about the regression, that's why I'm asking. Would be really good to
finally get this resolved...

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
> index 368d26da0d6a..51c22e7f9647 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -20,8 +20,6 @@
>   * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
>   */
>  
> -#include <linux/delay.h>
> -
>  #include <trace/events/dma_fence.h>
>  
>  #include "qxl_drv.h"
> @@ -59,14 +57,24 @@ static long qxl_fence_wait(struct dma_fence *fence, bool intr,
>  {
>  	struct qxl_device *qdev;
>  	unsigned long cur, end = jiffies + timeout;
> +	signed long iterations = 1;
> +	signed long timeout_fraction = timeout;
>  
>  	qdev = container_of(fence->lock, struct qxl_device, release_lock);
>  
> -	if (!wait_event_timeout(qdev->release_event,
> +	// using HZ as a factor since it is used in ttm_bo_wait_ctx too
> +	if (timeout_fraction > HZ) {
> +		iterations = timeout_fraction / HZ;
> +		timeout_fraction = HZ;
> +	}
> +	for (int i = 0; i < iterations; i++) {
> +		if (wait_event_timeout(
> +				qdev->release_event,
>  				(dma_fence_is_signaled(fence) ||
> -				 (qxl_io_notify_oom(qdev), 0)),
> -				timeout))
> -		return 0;
> +					(qxl_io_notify_oom(qdev), 0)),
> +				timeout_fraction))
> +			break;
> +	}
>  
>  	cur = jiffies;
>  	if (time_after(cur, end))
