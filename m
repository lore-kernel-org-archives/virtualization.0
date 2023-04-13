Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D38C77B6C
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 07:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8A3D60F2A;
	Thu, 13 Apr 2023 07:50:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8A3D60F2A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SJrg_ZH_jj9D; Thu, 13 Apr 2023 07:50:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3D6E260DF4;
	Thu, 13 Apr 2023 07:50:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D6E260DF4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04DE9C0036;
	Thu, 13 Apr 2023 07:50:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41515C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1905340CB9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:50:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1905340CB9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IGFwXR_IZ-1k
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:50:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 86463403F8
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86463403F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:50:22 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0Vg-WHcF_1681372217; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vg-WHcF_1681372217) by smtp.aliyun-inc.com;
 Thu, 13 Apr 2023 15:50:18 +0800
Message-ID: <1681372206.941719-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] tools/virtio/ringtest: Replace obsolete memalign() with
 posix_memalign()
Date: Thu, 13 Apr 2023 15:50:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Deming Wang <wangdeming@inspur.com>
References: <20230412072536.2029-1-wangdeming@inspur.com>
In-Reply-To: <20230412072536.2029-1-wangdeming@inspur.com>
Cc: mst@redhat.com, Deming Wang <wangdeming@inspur.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, 12 Apr 2023 03:25:36 -0400, Deming Wang <wangdeming@inspur.com> wrote:
> memalign() is obsolete according to its manpage.
>
> Replace memalign() with posix_memalign() and remove malloc.h include
> that was there for memalign().
>
> As a pointer is passed into posix_memalign(), initialize *p to NULL
> to silence a warning about the function's return value being used as
> uninitialized (which is not valid anyway because the error is properly
> checked before p is returned).
>
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

LGTM

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  tools/virtio/ringtest/ptr_ring.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/virtio/ringtest/ptr_ring.c b/tools/virtio/ringtest/ptr_ring.c
> index c9b26335f891..a0bf4978eace 100644
> --- a/tools/virtio/ringtest/ptr_ring.c
> +++ b/tools/virtio/ringtest/ptr_ring.c
> @@ -26,9 +26,12 @@ typedef int gfp_t;
>
>  static void *kmalloc(unsigned size, gfp_t gfp)
>  {
> -	void *p = memalign(64, size);
> -	if (!p)
> -		return p;
> +	void *p;
> +	int ret;
> +
> +	ret = posix_memalign(&p, 64, size);
> +	if (ret < 0)
> +		return NULL;
>
>  	if (gfp & __GFP_ZERO)
>  		memset(p, 0, size);
> --
> 2.27.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
