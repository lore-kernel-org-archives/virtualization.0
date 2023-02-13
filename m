Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869E7C636D4
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 12:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 223414060E;
	Mon, 13 Feb 2023 12:10:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 223414060E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J6R/QByW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id upQw3XU4U2jt; Mon, 13 Feb 2023 12:10:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 94356403EA;
	Mon, 13 Feb 2023 12:10:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94356403EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67096C0032;
	Mon, 13 Feb 2023 12:10:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5152C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC932414C5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:10:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC932414C5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J6R/QByW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h8kDiBwo2Kyl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:10:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A916D414C4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A916D414C4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676290200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3mEYzxx/bkDFLt7byV5MhD22WdETXrhwLYc+g6bKb6Q=;
 b=J6R/QByWJU9aA/fWhdJ45Jc+DjFKAf+JgdwkvYNTRGn0vjmDgHIBTG4IC6VrcS1jxD33pI
 3eTb9NWjECf+xnNgmP0qHf2KcwJaV+UG0mK38itRCmYI7dLolRIkKFlwWxHUWZWef6nqYg
 MSW/JJ5lhrKBdrzB5y6aoHL3YCmHC5U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-159-XXQG_fgyMQeLRCBZoDaBcg-1; Mon, 13 Feb 2023 07:09:57 -0500
X-MC-Unique: XXQG_fgyMQeLRCBZoDaBcg-1
Received: by mail-ej1-f72.google.com with SMTP id
 ti11-20020a170907c20b00b00886244203fcso7402468ejc.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 04:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mEYzxx/bkDFLt7byV5MhD22WdETXrhwLYc+g6bKb6Q=;
 b=ZN4SpCi8uQ++Mx96q+AB7ItEmdaya1hF+oZ2jEh1N4UXRf2jVcdzxRWW1J1NZxklCZ
 aD8ZdeWPsqBWWjY8KSvlnx9FMxRhrhHyumFiTymjVuU2OQm1Vi6OeFCzgCKpiRcBgSs/
 FP0vTQlgGfJte2PhQUNYooTxMQ6bqO9DiRPyCLY5dQ71ieduimL6QddEKA6hWcY7SdP/
 tIYhmEtBFp+ZzS2uzUv0oxKjdi8/2+4EZJNz26A4+IonUUUDH69IEcfdayOnHZ7s5kwy
 0o3Vb61jN10dlIy65VHkmA4RHTq7nIWUeDvlly+f1+15j8Dr46aVuH+/YQrXqeIupEOM
 k4iA==
X-Gm-Message-State: AO0yUKWP9rtrv9hSBG0S7faa3T6BSbf5bebNIj/ArmeQxCLr6sIeP69V
 DbnuLbsVefOybKARIFiSd+fkjBFvn2IG9tgHn+uEdZUf1/18ba/Is5+e/c1zA2Pr61JO8uNK3c9
 qxKOVDeKFGLg1J/tBsqoednx1VXbqFb5pml0ijsMe3Q==
X-Received: by 2002:a17:906:1286:b0:886:50d:be8d with SMTP id
 k6-20020a170906128600b00886050dbe8dmr26816172ejb.13.1676290196341; 
 Mon, 13 Feb 2023 04:09:56 -0800 (PST)
X-Google-Smtp-Source: AK7set/LVnxEG3I8rnVK7885EnaICcxb+lvhiOf/rZbS+wU3TNmlvfBa8qzgmQnMIPHWTVKERIaRaw==
X-Received: by 2002:a17:906:1286:b0:886:50d:be8d with SMTP id
 k6-20020a170906128600b00886050dbe8dmr26816157ejb.13.1676290196155; 
 Mon, 13 Feb 2023 04:09:56 -0800 (PST)
Received: from redhat.com ([2.52.132.212]) by smtp.gmail.com with ESMTPSA id
 l26-20020a170906079a00b008966488a5f1sm6757478ejc.144.2023.02.13.04.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Feb 2023 04:09:55 -0800 (PST)
Date: Mon, 13 Feb 2023 07:09:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zheng Wang <zyytlz.wz@163.com>
Subject: Re: [PATCH v2] scsi: virtio_scsi: Fix poential NULL pointer
 dereference in  virtscsi_rescan_hotunplug
Message-ID: <20230213070906-mutt-send-email-mst@kernel.org>
References: <20230202064124.22277-1-zyytlz.wz@163.com>
MIME-Version: 1.0
In-Reply-To: <20230202064124.22277-1-zyytlz.wz@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: alex000young@gmail.com, security@kernel.org, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
 hackerzheng666@gmail.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, pbonzini@redhat.com, jejb@linux.ibm.com
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

On Thu, Feb 02, 2023 at 02:41:24PM +0800, Zheng Wang wrote:
> There is no check about the return value of kmalloc in
> virtscsi_rescan_hotunplug. Add the check to avoid use
> of null pointer 'inq_result' in case of the failure
> of kmalloc.
> 
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---

I fixed a typo in subject and tweaked the patch a bit

> v2:
> - add kfree to avoid memory leak
> ---
>  drivers/scsi/virtio_scsi.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index d07d24c06b54..a66d8815d738 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -330,7 +330,7 @@ static void virtscsi_handle_param_change(struct virtio_scsi *vscsi,
>  	scsi_device_put(sdev);
>  }
>  
> -static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
> +static int virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
>  {
>  	struct scsi_device *sdev;
>  	struct Scsi_Host *shost = virtio_scsi_host(vscsi->vdev);
> @@ -338,6 +338,11 @@ static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
>  	int result, inquiry_len, inq_result_len = 256;
>  	char *inq_result = kmalloc(inq_result_len, GFP_KERNEL);
>  
> +	if (!inq_result) {
> +		kfree(inq_result);
> +		return -ENOMEM;
> +	}
> +
>  	shost_for_each_device(sdev, shost) {
>  		inquiry_len = sdev->inquiry_len ? sdev->inquiry_len : 36;
>  
> @@ -366,6 +371,7 @@ static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
>  	}
>  
>  	kfree(inq_result);
> +	return 0;
>  }
>  
>  static void virtscsi_handle_event(struct work_struct *work)
> @@ -374,12 +380,15 @@ static void virtscsi_handle_event(struct work_struct *work)
>  		container_of(work, struct virtio_scsi_event_node, work);
>  	struct virtio_scsi *vscsi = event_node->vscsi;
>  	struct virtio_scsi_event *event = &event_node->event;
> +	int ret = 0;
>

dropped = 0 here
  
>  	if (event->event &
>  	    cpu_to_virtio32(vscsi->vdev, VIRTIO_SCSI_T_EVENTS_MISSED)) {

and moved declaration here.

>  		event->event &= ~cpu_to_virtio32(vscsi->vdev,
>  						   VIRTIO_SCSI_T_EVENTS_MISSED);
> -		virtscsi_rescan_hotunplug(vscsi);
> +		ret = virtscsi_rescan_hotunplug(vscsi);
> +		if (ret)
> +			return;
>  		scsi_scan_host(virtio_scsi_host(vscsi->vdev));
>  	}
>  
> -- 
> 2.25.1
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
