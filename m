Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24773C4321E
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 06:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 852C160F4E;
	Mon, 28 Nov 2022 06:16:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 852C160F4E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id leWcHzyg3B8v; Mon, 28 Nov 2022 06:16:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 08F8660AC3;
	Mon, 28 Nov 2022 06:16:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08F8660AC3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0ECFC0032;
	Mon, 28 Nov 2022 06:16:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30850C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 06:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0533141575
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 06:16:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0533141575
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PZHGf_L3ccgP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 06:16:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14CFB4156E
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14CFB4156E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 06:16:31 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0VVoOaBy_1669616184; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VVoOaBy_1669616184) by smtp.aliyun-inc.com;
 Mon, 28 Nov 2022 14:16:25 +0800
Message-ID: <1669616174.7244327-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] tools/virtio: remove stray characters
Date: Mon, 28 Nov 2022 14:16:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>
References: <20221128034347.990-1-dave@stgolabs.net>
 <20221128034347.990-2-dave@stgolabs.net>
In-Reply-To: <20221128034347.990-2-dave@stgolabs.net>
Cc: dave@stgolabs.net, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Sun, 27 Nov 2022 19:43:46 -0800, Davidlohr Bueso <dave@stgolabs.net> wrote:
> __read_once_size() is not a macro, remove those '/'s.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  tools/virtio/ringtest/main.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
> index 6d1fccd3d86c..9ed09caa659e 100644
> --- a/tools/virtio/ringtest/main.h
> +++ b/tools/virtio/ringtest/main.h
> @@ -149,16 +149,16 @@ static inline void busy_wait(void)
>  static __always_inline
>  void __read_once_size(const volatile void *p, void *res, int size)
>  {
> -        switch (size) {                                                 \
> -        case 1: *(unsigned char *)res = *(volatile unsigned char *)p; break;              \
> -        case 2: *(unsigned short *)res = *(volatile unsigned short *)p; break;            \
> -        case 4: *(unsigned int *)res = *(volatile unsigned int *)p; break;            \
> -        case 8: *(unsigned long long *)res = *(volatile unsigned long long *)p; break;            \
> -        default:                                                        \
> -                barrier();                                              \
> -                __builtin_memcpy((void *)res, (const void *)p, size);   \
> -                barrier();                                              \
> -        }                                                               \
> +	switch (size) {
> +	case 1: *(unsigned char *)res = *(volatile unsigned char *)p; break;
> +	case 2: *(unsigned short *)res = *(volatile unsigned short *)p; break;
> +	case 4: *(unsigned int *)res = *(volatile unsigned int *)p; break;
> +	case 8: *(unsigned long long *)res = *(volatile unsigned long long *)p; break;
> +	default:
> +		barrier();
> +		__builtin_memcpy((void *)res, (const void *)p, size);
> +		barrier();
> +	}
>  }
>
>  static __always_inline void __write_once_size(volatile void *p, void *res, int size)
> --
> 2.38.1
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
