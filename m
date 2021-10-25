Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471DBC433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 09:09:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C1660E0B
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 09:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E5C1660E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE81E6059B;
	Mon, 25 Oct 2021 09:09:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dcv51YK67lgG; Mon, 25 Oct 2021 09:09:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F8A7605A5;
	Mon, 25 Oct 2021 09:09:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29E7DC0019;
	Mon, 25 Oct 2021 09:09:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52DD4C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 09:09:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F0B780CCC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 09:09:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i5Xy4A7rRkFK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 09:08:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A80280CD3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635152937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XeGNSOcAvBmLSqJs1UuImaAZO/HaSB8DxKn5L+5tDB0=;
 b=Wenb+UaHfY3BHKOnKiwF83ErdkoY1odxDOqTCXnb7zC32aIE/guoxbRf3CrqDepdifjDfv
 phg4IeTW5CnaYLdMZSWidB3oaupd4vOMk3RXnIh1JHCBldeRc3nvWcPBPOJKwzVuUmXh6r
 /cRSim0EDiQEtJydB17UC759jZHdebA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-5wqxHWsxO-6B8To9IqbAiQ-1; Mon, 25 Oct 2021 05:08:56 -0400
X-MC-Unique: 5wqxHWsxO-6B8To9IqbAiQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 w14-20020a05640234ce00b003dd3ac71960so4257030edc.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XeGNSOcAvBmLSqJs1UuImaAZO/HaSB8DxKn5L+5tDB0=;
 b=hxd5o+QkpuSvr2mXtq4Cb6SOjuoeN5kNsN3WZxLAQo6kL67YL6Cxo2OAffWJIzksTE
 pXCUlS6+YAf4S3zKbaR/7RtK/s4hEEaS7XDvxYR2wWVRLKxf4FgmCKYVHE2b51DjlozV
 3nsNLxYzdFEi3TQsaNiGlwWYm3pWuCka3vqLVkaVqpnvI72luA1X8qXwVBDpvvsHTxCl
 R/isPslsY1mMnwmKJbvIFPY0KZAD0cyVvHuG55PKFstOKvaCUynx8K4KUras9xxdW+Cf
 MabpojUyi2pOnNNAKNCpPKhNuPCoQzgemLj96sY7Hkw8TnhODkzNM39xD9xcbzRYoI8y
 KdQg==
X-Gm-Message-State: AOAM532y+qIkjdm/H0jiyBKWUizwe1ZRex8VBzkIISDhXAO1PGrBgiV3
 DDQ1DrNSH1MVXLfGalVxWisc1ZIZZSKgvaxv+Yx383x597bb3yr8/bnG76ARSPPQqNoLRQC7tmN
 SdXgmNsUcIXJvdqQsC0Vcg2aB4KVAmC9SrjXBXUmsag==
X-Received: by 2002:a17:907:3f9c:: with SMTP id
 hr28mr21157754ejc.246.1635152934825; 
 Mon, 25 Oct 2021 02:08:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/sV83vvSJXd/ysEd58WtGrMeInWgBZZGAKoZJQ3ewcqc/wys+wOPgIfJKAvE2jCVNIiBILg==
X-Received: by 2002:a17:907:3f9c:: with SMTP id
 hr28mr21157730ejc.246.1635152934633; 
 Mon, 25 Oct 2021 02:08:54 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it.
 [79.30.88.77])
 by smtp.gmail.com with ESMTPSA id hb9sm3019913ejc.80.2021.10.25.02.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 02:08:54 -0700 (PDT)
Date: Mon, 25 Oct 2021 11:08:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V3 06/11] vhost-sock: convert to vq helpers
Message-ID: <20211025090852.4kbqf3gieednw6ie@steredhat>
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <20211022051911.108383-8-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20211022051911.108383-8-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Oct 22, 2021 at 12:19:06AM -0500, Mike Christie wrote:
>Convert from vhost dev based helpers to vq ones.
>
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> drivers/vhost/vsock.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 938aefbc75ec..c50c60d0955e 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -300,7 +300,7 @@ vhost_transport_send_pkt(struct virtio_vsock_pkt *pkt)
> 	list_add_tail(&pkt->list, &vsock->send_pkt_list);
> 	spin_unlock_bh(&vsock->send_pkt_list_lock);
>
>-	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
>+	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_TX], &vsock->send_pkt_work);

I think we should use VSOCK_VQ_RX. I know, the nomenclature is weird, 
but it's from the guest's point of view, so the host when sending 
packets uses the VSOCK_VQ_RX, see vhost_transport_send_pkt_work().


>
> 	rcu_read_unlock();
> 	return len;
>@@ -612,7 +612,7 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 	/* Some packets may have been queued before the device was started,
> 	 * let's kick the send worker to send them.
> 	 */
>-	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
>+	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_TX], 
>&vsock->send_pkt_work);

Ditto.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
