Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026D1C4321E
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 06:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9063B405AD;
	Mon, 28 Nov 2022 06:17:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9063B405AD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xnzdLYCGFPFB; Mon, 28 Nov 2022 06:17:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3CFCE408E3;
	Mon, 28 Nov 2022 06:17:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CFCE408E3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18D56C0032;
	Mon, 28 Nov 2022 06:17:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02EE1C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 06:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C570D60AC3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 06:17:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C570D60AC3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rNeLfC1TGsSa
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 06:17:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56531607DE
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56531607DE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 06:17:11 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0VVoRcX4_1669616225; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VVoRcX4_1669616225) by smtp.aliyun-inc.com;
 Mon, 28 Nov 2022 14:17:06 +0800
Message-ID: <1669616200.943005-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 2/2] tools/virtio: remove smp_read_barrier_depends()
Date: Mon, 28 Nov 2022 14:16:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>
References: <20221128034347.990-1-dave@stgolabs.net>
 <20221128034347.990-3-dave@stgolabs.net>
In-Reply-To: <20221128034347.990-3-dave@stgolabs.net>
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

On Sun, 27 Nov 2022 19:43:47 -0800, Davidlohr Bueso <dave@stgolabs.net> wrote:
> This gets rid of the last references to smp_read_barrier_depends()
>  which for the kernel side was removed in v5.9. The serialization
> required for Alpha is done inside READ_ONCE() instead of having
> users deal with it. Simply use a full barrier, the architecture
> does not have rmb in the first place.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  tools/virtio/ringtest/main.h | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
> index 9ed09caa659e..b68920d52750 100644
> --- a/tools/virtio/ringtest/main.h
> +++ b/tools/virtio/ringtest/main.h
> @@ -140,12 +140,6 @@ static inline void busy_wait(void)
>  #define smp_wmb() smp_release()
>  #endif
>
> -#ifdef __alpha__
> -#define smp_read_barrier_depends() smp_acquire()
> -#else
> -#define smp_read_barrier_depends() do {} while(0)
> -#endif
> -
>  static __always_inline
>  void __read_once_size(const volatile void *p, void *res, int size)
>  {
> @@ -175,13 +169,22 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
>  	}
>  }
>
> +#ifdef __alpha__
>  #define READ_ONCE(x) \
>  ({									\
>  	union { typeof(x) __val; char __c[1]; } __u;			\
>  	__read_once_size(&(x), __u.__c, sizeof(x));		\
> -	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
> +	smp_mb(); /* Enforce dependency ordering from x */		\
>  	__u.__val;							\
>  })
> +#else
> +#define READ_ONCE(x)							\
> +({									\
> +	union { typeof(x) __val; char __c[1]; } __u;			\
> +	__read_once_size(&(x), __u.__c, sizeof(x));			\
> +	__u.__val;							\
> +})
> +#endif
>
>  #define WRITE_ONCE(x, val) \
>  ({							\
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
