Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBFFC64ED6
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 21:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2776640AAB;
	Mon, 27 Feb 2023 21:54:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2776640AAB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iJyi0S45
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tjbJ3UXqFFtn; Mon, 27 Feb 2023 21:54:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E4294014E;
	Mon, 27 Feb 2023 21:54:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E4294014E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8282AC0032;
	Mon, 27 Feb 2023 21:54:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57166C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 21:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31509416D7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 21:54:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31509416D7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iJyi0S45
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XDZk-TYBeHvm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 21:54:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0EAC41621
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0EAC41621
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677534840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NH1zCP7fchiReMFqu555SwmXjnCrBh0XjRIbNOlyPW8=;
 b=iJyi0S45rNUfqGcbzQOs93fhrJfj2NQwY89GE8TG6avazsxutiBXVAEy5AJ4NoBLPIZBpi
 W+/fcoUhqzF4yKVt5lgL06MJ50kAdviSgi2N2GuAfqvsfC3Nd6OBa3s+Irnbediw9YV/HS
 us/clbyPsUaktJipsbmCu+yofl3d+sE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-FSiE0J-FPBiC5SMVF19zYA-1; Mon, 27 Feb 2023 16:53:59 -0500
X-MC-Unique: FSiE0J-FPBiC5SMVF19zYA-1
Received: by mail-ed1-f69.google.com with SMTP id
 ec13-20020a0564020d4d00b004a621e993a8so10664012edb.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 13:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NH1zCP7fchiReMFqu555SwmXjnCrBh0XjRIbNOlyPW8=;
 b=lg44YbWbMYZEF1ik5cdHzhS67jc4WWCb9uYS6u2MdrPMn/DoJZMy1PlI/2x2CSzJhA
 iJeNX2A0DZIbtQjbluMWX4FFx3MHPaa+NXtlHtJp6yHppVV3OUBm9vfc26d1WZ07jNwt
 gUYLrj20E7JuAUuGWkJtW6a7/Sx353kijzMYdl5XXWJcDOjnGq0Bt5C/ZsAZKjUEGGUP
 bUzgHvXfhjDbUiIRrsdAfo1MXmEnh3x5m/caJT0UEPZ7uws4VbkeYtKthJdpm8+gAmEu
 NdOgabuwiV8mbcfxnjkAI5FAgcajkWHjq51LUiPBalF4nKRZqNOunRt9x7A5We4RtWD8
 A6+w==
X-Gm-Message-State: AO0yUKVOCbA6jecEU5Xa21hwww46X0dSKIeGX6Iv0Wc1DPWeoPqlqr2R
 C26pAW/aXUirxIUSHhmrnqGxURt+lVWPncJP+PL4gzCMY4P5VkTmrNChmc/3rEdmeiJAPoHnIYS
 su8J30PVpL9I8CKXOM1SaAuR7RUQaXHGkWKwWxr0pvw==
X-Received: by 2002:a17:907:20ca:b0:87b:d2b3:67ca with SMTP id
 qq10-20020a17090720ca00b0087bd2b367camr159469ejb.75.1677534838092; 
 Mon, 27 Feb 2023 13:53:58 -0800 (PST)
X-Google-Smtp-Source: AK7set9ogYP9qlfEFY1lD8iKUQGWG7h/CDs1XyL2Fcs+3FtFVG3WfF+4nQOz3bzdoERPheVvemFjnQ==
X-Received: by 2002:a17:907:20ca:b0:87b:d2b3:67ca with SMTP id
 qq10-20020a17090720ca00b0087bd2b367camr159448ejb.75.1677534837776; 
 Mon, 27 Feb 2023 13:53:57 -0800 (PST)
Received: from redhat.com ([2.52.141.194]) by smtp.gmail.com with ESMTPSA id
 o15-20020a1709064f8f00b008b17662e1f7sm3721063eju.53.2023.02.27.13.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Feb 2023 13:53:57 -0800 (PST)
Date: Mon, 27 Feb 2023 16:53:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH] vhost: use struct_size and size_add to compute flex
 array sizes
Message-ID: <20230227165340-mutt-send-email-mst@kernel.org>
References: <20230227214127.3678392-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230227214127.3678392-1-jacob.e.keller@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Feb 27, 2023 at 01:41:27PM -0800, Jacob Keller wrote:
> The vhost_get_avail_size and vhost_get_used_size functions compute the size
> of structures with flexible array members with an additional 2 bytes if the
> VIRTIO_RING_F_EVENT_IDX feature flag is set. Convert these functions to use
> struct_size() and size_add() instead of coding the calculation by hand.
> 
> This ensures that the calculations will saturate at SIZE_MAX rather than
> overflowing.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: kvm@vger.kernel.org


Acked-by: Michael S. Tsirkin <mst@redhat.com>

Will merge, thanks!
> ---
> 
> I found this using a coccinelle patch I developed and submitted at [1].
> 
> [1]: https://lore.kernel.org/all/20230227202428.3657443-1-jacob.e.keller@intel.com/
> 
>  drivers/vhost/vhost.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index f11bdbe4c2c5..43fa626d4e44 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -436,8 +436,7 @@ static size_t vhost_get_avail_size(struct vhost_virtqueue *vq,
>  	size_t event __maybe_unused =
>  	       vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
>  
> -	return sizeof(*vq->avail) +
> -	       sizeof(*vq->avail->ring) * num + event;
> +	return size_add(struct_size(vq->avail, ring, num), event);
>  }
>  
>  static size_t vhost_get_used_size(struct vhost_virtqueue *vq,
> @@ -446,8 +445,7 @@ static size_t vhost_get_used_size(struct vhost_virtqueue *vq,
>  	size_t event __maybe_unused =
>  	       vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
>  
> -	return sizeof(*vq->used) +
> -	       sizeof(*vq->used->ring) * num + event;
> +	return size_add(struct_size(vq->used, ring, num), event);
>  }
>  
>  static size_t vhost_get_desc_size(struct vhost_virtqueue *vq,
> -- 
> 2.39.1.405.gd4c25cc71f83

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
