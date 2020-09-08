Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535DBC433E2
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 12:05:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C823D206B5
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 12:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/CHXHWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C823D206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5F75E869E2;
	Tue,  8 Sep 2020 12:05:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uvSSdCkOpdLd; Tue,  8 Sep 2020 12:05:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 33C1A8112C;
	Tue,  8 Sep 2020 12:05:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B7E4C0859;
	Tue,  8 Sep 2020 12:05:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 979CCC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 12:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 922F220358
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 12:05:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v6sX18Fwf+gJ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 12:05:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id 70B402000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599566752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uTbg/F8EMJz/zWHZGHElfxdFbIFaiE/jJsKyDwICFFY=;
 b=E/CHXHWw9Cv6402zquVgpCHVFtKNLeNgqFvbE1h4e2diKN7iduMwXBRccW7yz9wRvlAuj9
 /+K/7ZvZ8/fs0V7AkTwONAxnYyxNE8LZHNGcncc+J3YItTYJuXWPj9y2VGIMzaYTodw+wQ
 2ecnKFpwpU9d+e4PCGfzdlvNAAEr8bE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-NDuYbXFAPwSOIZcAVWPhag-1; Tue, 08 Sep 2020 08:05:50 -0400
X-MC-Unique: NDuYbXFAPwSOIZcAVWPhag-1
Received: by mail-wr1-f72.google.com with SMTP id l15so6894845wro.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Sep 2020 05:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uTbg/F8EMJz/zWHZGHElfxdFbIFaiE/jJsKyDwICFFY=;
 b=Eueaa7l52HOTJxV+XHXETt2Npz4KsbNP4qJ3ZcAmi5aHY4sb2ftcuU2pABNbJgHDaW
 GDYvK2gYm7xRad6WtqkVRU8qbONgoqj4QCT/DPxEcZzj90+mCVr7CYjci2cG7sCvlWD5
 dsPt+WHbm3IjH8TSOaAvf4HPrdgP9dja71JbvEMMR/L0vIFlsXZM+LIhnMOcB93fODIY
 Q20s7IhcI+fO5jqPpXDHPJ5lTMrM2rZ3ZrQs7x9n82bNwLN9phMd1bg7abz1d2HrOQW1
 /pxu+ChgC+h0yDuPIApFCgPVzC16pNBtIuTPXYIQldYeY1B+LwpnMIwOQy9u4Yh4Fec6
 wowg==
X-Gm-Message-State: AOAM533Y+0qKQVbbi5XZCkjjWyfINAcbMGmWtxrzAhmZNHK9xuXFCvmV
 YyTR7mHHfCzy0vDdsse/qy5AAGsSsOXIbDCZj7ytP4SWEoClwDZLQg26ff1ugOzwNkaFU63Mcd9
 5a4PY/NA6jXpoenitsB+3g1xSMHoYyS0Kv6EGhNI+Aw==
X-Received: by 2002:a1c:80d7:: with SMTP id b206mr4062494wmd.161.1599566749491; 
 Tue, 08 Sep 2020 05:05:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1voR2aDQ/omOiAhnyNbh20XUmSq/vHolLDEZXQW14ePuREj8QwPqWOFx4FPXk1oqmTfQ+LA==
X-Received: by 2002:a1c:80d7:: with SMTP id b206mr4062476wmd.161.1599566749321; 
 Tue, 08 Sep 2020 05:05:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-218-236.inter.net.il. [80.230.218.236])
 by smtp.gmail.com with ESMTPSA id
 l8sm34308524wrx.22.2020.09.08.05.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 05:05:48 -0700 (PDT)
Date: Tue, 8 Sep 2020 08:05:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH 1/2] vhost: remove mutex ops in vhost_set_backend_features
Message-ID: <20200908080513-mutt-send-email-mst@kernel.org>
References: <20200907105220.27776-1-lingshan.zhu@intel.com>
 <20200907105220.27776-2-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20200907105220.27776-2-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org,
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

On Mon, Sep 07, 2020 at 06:52:19PM +0800, Zhu Lingshan wrote:
> In vhost_vdpa ioctl SET_BACKEND_FEATURES path, currect code
> would try to acquire vhost dev mutex twice
> (first shown in vhost_vdpa_unlocked_ioctl), which can lead
> to a dead lock issue.
> This commit removed mutex operations in vhost_set_backend_features.
> As a compensation for vhost_net, a followinig commit will add
> needed mutex lock/unlock operations in a new function
> vhost_net_set_backend_features() which is a wrap of
> vhost_set_backend_features().
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>

I think you need to squash these two or reorder, we can't first
make code racy then fix it up.

> ---
>  drivers/vhost/vhost.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index b45519ca66a7..e03c9e6f058f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2591,14 +2591,12 @@ void vhost_set_backend_features(struct vhost_dev *dev, u64 features)
>  	struct vhost_virtqueue *vq;
>  	int i;
>  
> -	mutex_lock(&dev->mutex);
>  	for (i = 0; i < dev->nvqs; ++i) {
>  		vq = dev->vqs[i];
>  		mutex_lock(&vq->mutex);
>  		vq->acked_backend_features = features;
>  		mutex_unlock(&vq->mutex);
>  	}
> -	mutex_unlock(&dev->mutex);
>  }
>  EXPORT_SYMBOL_GPL(vhost_set_backend_features);
>  
> -- 
> 2.18.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
