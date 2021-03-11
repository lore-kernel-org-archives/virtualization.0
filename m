Return-Path: <SRS0=WRLV=IJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AACEC433E0
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 15:45:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1E264E21
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 15:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1E264E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E58B34ECB6;
	Thu, 11 Mar 2021 15:45:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iLI4P5RETYy4; Thu, 11 Mar 2021 15:44:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 520A14EC0B;
	Thu, 11 Mar 2021 15:44:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D40DC000B;
	Thu, 11 Mar 2021 15:44:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BE6DC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 15:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED8134EC0B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 15:44:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HqNRgT1JC-aN
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 15:44:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 080414EC02
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615477495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EDixfRUXhwwO3Hr27sZpPActljciPMjEXVNBDCJPQ2g=;
 b=foBNDMTCNesOZFo9/N9sF91GAwtJTotpg+heNBrqJ23YaJDA+qKNY8xJo4YxEnEqEySQGT
 dA0qyT0oY+uRnwr+6ZPQnU5VQrpfWByIXY70EmaYnzzcMNDIY9hDf8IZOUBhMf8NHSQyXI
 lrYxV9cu6Rlb8qKSOf19I5ECf5s4r0Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-VKpjhKyANi-FBBTVKcwa4w-1; Thu, 11 Mar 2021 10:44:53 -0500
X-MC-Unique: VKpjhKyANi-FBBTVKcwa4w-1
Received: by mail-wm1-f72.google.com with SMTP id s192so4208644wme.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 07:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EDixfRUXhwwO3Hr27sZpPActljciPMjEXVNBDCJPQ2g=;
 b=gsecOVJ8MTN8LpEevGPlQElQ9K83uVYKeoyUnA/+3kKSp/8Sh91k1wRdxRwdkD50ce
 jnpHTgrDr6jHc04FxEgeOeq2HO0BBH6HiMmRWOSecl7HLl9us5TSu2iTYNMhb/SvSSjJ
 A4xRGb5XM5eJ3viqtywDTPbn9ICZ8kW4ytNQD0yjOnFOSWziCLzG9Lf6oJDQPTBrQYXV
 ZpiC69TMO0j4zQr4yPA6xA5sEr9tK0du6cVmVuZgbJPV7ghXeJxSAGsrFxqSHgkJiYzj
 FpQMkeM1cuD6pKoyHKUTitjoCpdeEuJacWydNAYYmwbPvAxAdKHiys7JaHMjf45c+jMi
 dfBw==
X-Gm-Message-State: AOAM532/V2YJXiKmwuqKhAaDPtWoyb86uP2ja2ZRDJCk7vKd9fdCUkaQ
 SkiGv71VTvgFmgcOLmuhPVA5DirVNFi6RqeiJnnfQjJmnzuWuiqPKIg9Ma/Wpx2er9e3Reov4M1
 prXRzDsZoaVrzUo+5rVnLLJqeHHoIuRlJqnt9s5avtQ==
X-Received: by 2002:a1c:1d14:: with SMTP id d20mr8970946wmd.36.1615477492630; 
 Thu, 11 Mar 2021 07:44:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHjr8644cgD/IAgZiJcIftxezr5XDgbDQ2Ot4F+wCFbcHXofdu4R60zaHjqtJPY8mYxFUyag==
X-Received: by 2002:a1c:1d14:: with SMTP id d20mr8970931wmd.36.1615477492444; 
 Thu, 11 Mar 2021 07:44:52 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id i11sm4590680wro.53.2021.03.11.07.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Mar 2021 07:44:50 -0800 (PST)
Date: Thu, 11 Mar 2021 10:44:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] virtio-mmio: read[wl]()/write[wl] are already
 little-endian
Message-ID: <20210311104414-mutt-send-email-mst@kernel.org>
References: <20210309224313.956065-1-laurent@vivier.eu>
MIME-Version: 1.0
In-Reply-To: <20210309224313.956065-1-laurent@vivier.eu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Mar 09, 2021 at 11:43:13PM +0100, Laurent Vivier wrote:
> read[wl]()/write[wl] already access memory in little-endian mode.

But then they convert it to CPU right? We just convert it back ...

> No need to convert the value with cpu_to_leXX()/leXX_to_cpu()
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  drivers/virtio/virtio_mmio.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index a286d22b6551..3f6a5588f77d 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -168,17 +168,17 @@ static void vm_get(struct virtio_device *vdev, unsigned offset,
>  		memcpy(buf, &b, sizeof b);
>  		break;
>  	case 2:
> -		w = cpu_to_le16(readw(base + offset));
> +		w = readw(base + offset);
>  		memcpy(buf, &w, sizeof w);
>  		break;
>  	case 4:
> -		l = cpu_to_le32(readl(base + offset));
> +		l = readl(base + offset);
>  		memcpy(buf, &l, sizeof l);
>  		break;
>  	case 8:
> -		l = cpu_to_le32(readl(base + offset));
> +		l = readl(base + offset);
>  		memcpy(buf, &l, sizeof l);
> -		l = cpu_to_le32(ioread32(base + offset + sizeof l));
> +		l = ioread32(base + offset + sizeof l);
>  		memcpy(buf + sizeof l, &l, sizeof l);
>  		break;
>  	default:
> @@ -212,17 +212,17 @@ static void vm_set(struct virtio_device *vdev, unsigned offset,
>  		break;
>  	case 2:
>  		memcpy(&w, buf, sizeof w);
> -		writew(le16_to_cpu(w), base + offset);
> +		writew(w, base + offset);
>  		break;
>  	case 4:
>  		memcpy(&l, buf, sizeof l);
> -		writel(le32_to_cpu(l), base + offset);
> +		writel(l, base + offset);
>  		break;
>  	case 8:
>  		memcpy(&l, buf, sizeof l);
> -		writel(le32_to_cpu(l), base + offset);
> +		writel(l, base + offset);
>  		memcpy(&l, buf + sizeof l, sizeof l);
> -		writel(le32_to_cpu(l), base + offset + sizeof l);
> +		writel(l, base + offset + sizeof l);
>  		break;
>  	default:
>  		BUG();
> -- 
> 2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
