Return-Path: <SRS0=E6mM=JG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C819C433B4
	for <virtualization@archiver.kernel.org>; Fri,  9 Apr 2021 16:16:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE35761041
	for <virtualization@archiver.kernel.org>; Fri,  9 Apr 2021 16:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE35761041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69992405E0;
	Fri,  9 Apr 2021 16:16:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lc-fOto_jBe3; Fri,  9 Apr 2021 16:16:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0697405D9;
	Fri,  9 Apr 2021 16:16:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87E9CC000B;
	Fri,  9 Apr 2021 16:16:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AC37C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36EFF405DA
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:16:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EpfD0F-6TOED
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:16:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4828405D9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617984959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ympzD91JBFEmUB8z07nEg3SFQfNcnSyyZ0Xyv2VW9mY=;
 b=TlzeXOtNuTnUvukhNQ2GH9MewsWRL+TUX+H15gXN9KQ5JfLSP9bcH/MZtSF5UemuwRZiDc
 jDbF5TQH+4dBNMB5fHU3SSEB58ObtgRxyTyK5rTz25rIawL25CZTe8fU7/CtfGiuT4Nn1e
 c1HNpKt3k9MSQrYPBdy/NnC47TPSRd4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-IbFqJwscMN-d81j6tggSvg-1; Fri, 09 Apr 2021 12:15:57 -0400
X-MC-Unique: IbFqJwscMN-d81j6tggSvg-1
Received: by mail-wr1-f72.google.com with SMTP id l3so2494302wrp.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Apr 2021 09:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ympzD91JBFEmUB8z07nEg3SFQfNcnSyyZ0Xyv2VW9mY=;
 b=euWv9bKOZbJ0LQ0Oa2hD2lP1B015U94Jo2MQujzdeRDOVQGkC81lXVmKu3kfBbJqIk
 HMC3L3mugQ69VwAAiKm/mrYQWH5u5ZCdlQO06Yy43DG+pXWQYXvKZCYnsBjnSAHzj6yl
 SKvswGad9kx7Zo7PbVJFXo3F3EqlRKrnOZ0iVYryeah7TOjv0cpZaGkD0UmKY6PRJJD7
 m/mXsfHCz5gINSxLNoYIo6xsWWq/2TaMWyimwmy9vfxCSClowEu4ykhXm90p6H8MGAn4
 h7nh4ijaEeFM10+nGcfe3JNXj/14VnC6YPV2KI9FfCriYIOmNdgdKlS1sBTRrTQDbP1u
 Heng==
X-Gm-Message-State: AOAM533MfjX8iNsujUQSVFmwHDT8R+LPvpD3VcdeAPg4iLHdgztLi9IF
 jiCzlu3RDYQiyDz/TgKnIJkjKyKy8UuFYQV2Ge0Tf0ThaPlHc5cNID9EQTUd214LBeF8lS0+8SP
 Dz0Y4gikwDyiNyVz/UFaeePouRm4T9NYerS/At3kw5Q==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr18461077wrr.61.1617984956087; 
 Fri, 09 Apr 2021 09:15:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7/KOvp7jfAdtHy4C2v6W8Sr5jADGDS1mDCv/rNxxuSfa3gCZY792heyfmCgnU+ZhCR5H7YQ==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr18461055wrr.61.1617984955917; 
 Fri, 09 Apr 2021 09:15:55 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id 3sm5445635wma.45.2021.04.09.09.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Apr 2021 09:15:55 -0700 (PDT)
Date: Fri, 9 Apr 2021 12:15:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v6 03/10] vhost-vdpa: protect concurrent access to vhost
 device iotlb
Message-ID: <20210409121512-mutt-send-email-mst@kernel.org>
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-4-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210331080519.172-4-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, kvm@vger.kernel.org, corbet@lwn.net,
 netdev@vger.kernel.org, rdunlap@infradead.org, willy@infradead.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 christian.brauner@canonical.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org, dan.carpenter@oracle.com,
 mika.penttila@nextfour.com
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

On Wed, Mar 31, 2021 at 04:05:12PM +0800, Xie Yongji wrote:
> Use vhost_dev->mutex to protect vhost device iotlb from
> concurrent access.
> 
> Fixes: 4c8cf318("vhost: introduce vDPA-based backend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

I could not figure out whether there's a bug there now.
If yes when is the concurrent access triggered?

> ---
>  drivers/vhost/vdpa.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 3947fbc2d1d5..63b28d3aee7c 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -725,9 +725,11 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
>  	const struct vdpa_config_ops *ops = vdpa->config;
>  	int r = 0;
>  
> +	mutex_lock(&dev->mutex);
> +
>  	r = vhost_dev_check_owner(dev);
>  	if (r)
> -		return r;
> +		goto unlock;
>  
>  	switch (msg->type) {
>  	case VHOST_IOTLB_UPDATE:
> @@ -748,6 +750,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
>  		r = -EINVAL;
>  		break;
>  	}
> +unlock:
> +	mutex_unlock(&dev->mutex);
>  
>  	return r;
>  }
> -- 
> 2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
