Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F04C433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 12:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DF2482A28;
	Tue, 11 Jan 2022 12:12:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QvBaV637Pafh; Tue, 11 Jan 2022 12:12:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4916681AC1;
	Tue, 11 Jan 2022 12:12:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F02B7C002F;
	Tue, 11 Jan 2022 12:12:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23AD8C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 12:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B896401ED
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 12:12:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0agBw2P-2rVq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 12:12:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB897401DF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641903167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+JwBXKLH4NzNFAnwckZER2iqQBL9AvK/6BgEkjCf/E=;
 b=FiJ/GEJJUyp/auMlbJM8+O99IPQ4GFjn7Cq3N6YqBoxrzXNZKB98p5HW+MYyQHSoz6ivZp
 Ve8KCIMgOMBypf7HN0bxqhtQgF/IHmafGeqpUUA/rvtPY4dkn/MvkmGoz9XwJ6+hDZna5N
 wM+SuPnDBkszZcLqTGt5AqRXWa4Odzk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-LI1GK6NvNuKvpKAYKBkjFw-1; Tue, 11 Jan 2022 07:12:46 -0500
X-MC-Unique: LI1GK6NvNuKvpKAYKBkjFw-1
Received: by mail-ed1-f70.google.com with SMTP id
 x19-20020a05640226d300b003f8b80f5729so13022560edd.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D+JwBXKLH4NzNFAnwckZER2iqQBL9AvK/6BgEkjCf/E=;
 b=RoSzakDfm5/77uRmcwV7dsTbFjEfx3r95tntBu+KPd600N4b/fPS3Z8HcYHGwvpSPa
 mZBqBvAcIO6777B7okU3F8B6MbQzic4N2bz16kCB2jS4JpDoA0w/ZoUflW249heVNKuf
 WUVn3T3bfF8oMz14OqLi+J04+J4+E++fjAQzWKWHk0vmrwjs4ue4hz9K2TMylxUZlnWJ
 J2Bo/CattDKjRLKSb2UzF2Ty1bHc1uZ7EGxBZkh/c7vj1/nT0me99ttdcm9eJAPryjIv
 xCFmwJfceHWMhsG3p97/DZSYqj5EDLvbZWrMb+33QAFblBYTWZkjKfjGwJoZDYimxX6r
 +9AA==
X-Gm-Message-State: AOAM530EFfAnyAmz6dhYTTULvMEpGxj3gP23sW0SF2FNDJGMcnfFEQwQ
 5/gI/bzW5nrM0DVcreLmc1uBA/aftpPHAnmFnJAOT2hyBI77Os5pGaLCfVSrPY+AcvmVT0rdTVE
 glhDR2A1lgdhzRgiOPV7vaWUgPSLcUw0e3gTAyLLrsw==
X-Received: by 2002:a17:907:a42a:: with SMTP id
 sg42mr3410699ejc.413.1641903165297; 
 Tue, 11 Jan 2022 04:12:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyn+HBSWzRmwPfwdKn9MBTiJv8kC1oPBnrcd2espINtsRmbDSRkTPnikgecszuaERMFk7gBQg==
X-Received: by 2002:a17:907:a42a:: with SMTP id
 sg42mr3410681ejc.413.1641903165088; 
 Tue, 11 Jan 2022 04:12:45 -0800 (PST)
Received: from redhat.com ([2.55.5.100])
 by smtp.gmail.com with ESMTPSA id kv5sm3525931ejc.113.2022.01.11.04.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 04:12:44 -0800 (PST)
Date: Tue, 11 Jan 2022 07:12:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: dongsheng li <lidongsheng@dayudpu.com>
Subject: Re: [PATCH v2] virtio_vdpa: Support surprise removal of virtio vdpa
 device
Message-ID: <20220111071135-mutt-send-email-mst@kernel.org>
References: <20220111065527.1160-1-lidongsheng@dayudpu.com>
MIME-Version: 1.0
In-Reply-To: <20220111065527.1160-1-lidongsheng@dayudpu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wangwei@dayudpu.com, linux-kernel@vger.kernel.org,
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

On Tue, Jan 11, 2022 at 02:55:27PM +0800, dongsheng li wrote:
> When virtio vdpa device removed, the abnormal damage of the device cannot be
> perceived normally, which will cause problems similar to:
> 
> Commit 43bb40c5b926 ("virtio_pci: Support surprise removal of
> virtio pci device")
> Hence, add the ability to abort the command on surprise removal
> 
> Signed-off-by: dongsheng li <lidongsheng@dayudpu.com>

If you don't mkae changes you can carry forward acks.

> ---
>  drivers/virtio/virtio_vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index f85f860bc10b..a5cebad09320 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -396,6 +396,7 @@ static void virtio_vdpa_remove(struct vdpa_device *vdpa)
>  {
>  	struct virtio_vdpa_device *vd_dev = vdpa_get_drvdata(vdpa);
>  
> +	virtio_break_device(&vd_dev->vdev);

My comment on graceful removal stands. E.g. a storage device
will want to flush out writes if possible not drop them.

>  	unregister_virtio_device(&vd_dev->vdev);
>  }
>  
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
