Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B2CC05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 10:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2078940C1B;
	Thu,  2 Feb 2023 10:34:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2078940C1B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FtcbzLjx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0mDMA-RWZ6hu; Thu,  2 Feb 2023 10:34:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 92FE040C0D;
	Thu,  2 Feb 2023 10:34:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92FE040C0D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79991C0032;
	Thu,  2 Feb 2023 10:34:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 252D0C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E727F81ECF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:34:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E727F81ECF
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FtcbzLjx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cRodsC-zJpcT
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:34:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34334812D2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 34334812D2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675334042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SpknTtimSl+guOKxaF16NMhAWaSqtArEG/8BewjAniM=;
 b=FtcbzLjxVvJOkGDqDyXOXzv8zcTFFurVB54v0WqaIDm3C1007IHZ86i739AjhFrDZd6v8s
 VfAjh73UBibhMHiki4Gq2A1U9K6c30jIQFJLkZ9dgi1z0iJA+59E6t9/rffU2netortYOM
 uhz4K8wootE7tgp1m5NN/ETfG6zuXRY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-377-P9LdYr8UMmG79BkTAdUYTQ-1; Thu, 02 Feb 2023 05:34:01 -0500
X-MC-Unique: P9LdYr8UMmG79BkTAdUYTQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 e9-20020a5d6d09000000b002c172f173a9so155511wrq.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 02:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpknTtimSl+guOKxaF16NMhAWaSqtArEG/8BewjAniM=;
 b=Wjwj1eLH+3x/bENhfEweE/qbk4jLgfk0OQCuNGEsu7P0CMwy6khp+Mb/2Eu7XF3aoZ
 lx/peUs0QZkVZJ6oy151J5K7OOlbfhQxnPQWYtn97eAe8t73QM6s5EAg1dNYcPS+V+zb
 bOAcrfhDM34NhYUxVCb5IKxmWwv6RAaC8564WvRueHlvOkQJRdnxGjv6aPJcbPuSn7X9
 QCtkXdt3zii6K5mxA0KQzKpcFclgN+VLOUQ0cPVnVKFwJU6hd3MTniWCNXbECmHb1ENy
 9pxBCajCzya66H5I/xnn7/XxrcNlyN47+/exjnl3tE+Qfsxx2+Y47GoyXh1BNkMtN3Pd
 eQoQ==
X-Gm-Message-State: AO0yUKUu65+Yj9ZKg9m/UdIY/j8CtXNczNThoV1juzZX6aXDBTvRGZrn
 9OMm+QmvA8HNRrFC5bJrxFNfHocL7+iuvfDMnHrdibpc1FjsLmljEQs0gPSAOm/9gjtapI7RYZh
 Oodvz01afrBWQhmD7jBCpGtAggfzOxIuGV6rC4sitZw==
X-Received: by 2002:a1c:f606:0:b0:3db:3695:11b4 with SMTP id
 w6-20020a1cf606000000b003db369511b4mr5235167wmc.33.1675334039773; 
 Thu, 02 Feb 2023 02:33:59 -0800 (PST)
X-Google-Smtp-Source: AK7set/aRh3S+7oJAh3Alg/NT2t1M9KB8chGYSyRGs8MriRivULozR8wG/So+QjE+3JvxeVKT3C53g==
X-Received: by 2002:a1c:f606:0:b0:3db:3695:11b4 with SMTP id
 w6-20020a1cf606000000b003db369511b4mr5235153wmc.33.1675334039564; 
 Thu, 02 Feb 2023 02:33:59 -0800 (PST)
Received: from redhat.com ([2a02:14f:1fc:826d:55d8:70a4:3d30:fc2f])
 by smtp.gmail.com with ESMTPSA id
 l13-20020adff48d000000b002366e3f1497sm19523049wro.6.2023.02.02.02.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 02:33:58 -0800 (PST)
Date: Thu, 2 Feb 2023 05:33:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [RFC PATCH v2 2/7] tools/virtio: enable to build with retpoline
Message-ID: <20230202053341-mutt-send-email-mst@kernel.org>
References: <20230202090934.549556-1-mie@igel.co.jp>
 <20230202090934.549556-3-mie@igel.co.jp>
MIME-Version: 1.0
In-Reply-To: <20230202090934.549556-3-mie@igel.co.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Feb 02, 2023 at 06:09:29PM +0900, Shunsuke Mie wrote:
> Add build options to bring it close to a linux kernel. It allows for
> testing that is close to reality.
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

This too, pls submit separately.

> ---
>  tools/virtio/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index 1b25cc7c64bb..7b7139d97d74 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -4,7 +4,7 @@ test: virtio_test vringh_test
>  virtio_test: virtio_ring.o virtio_test.o
>  vringh_test: vringh_test.o vringh.o virtio_ring.o
>  
> -CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
> +CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register
>  CFLAGS += -pthread
>  LDFLAGS += -pthread
>  vpath %.c ../../drivers/virtio ../../drivers/vhost
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
