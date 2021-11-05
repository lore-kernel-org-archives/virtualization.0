Return-Path: <SRS0=YXi0=PY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1630C433EF
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 08:32:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0A560232
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 08:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F0A560232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BE09605FE;
	Fri,  5 Nov 2021 08:32:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vu1mRKvlMnYL; Fri,  5 Nov 2021 08:32:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 20DF860614;
	Fri,  5 Nov 2021 08:32:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEBE8C0019;
	Fri,  5 Nov 2021 08:32:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84E6CC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:32:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 736E960614
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:32:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A_5qU6CEMEq8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:32:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7E93605FE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636101151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUz7Uqfcr6vjpPuFN/6PJkrmCB4tUkJaU03BFN22CaE=;
 b=OX6aZtWYtaBTA4SK0N5wHWadhRGoiZ5IX+U7tCen1XoPTDpcEL9id+NBwqjyA0KRj2JdCl
 EfE+WtLUUa/9Oo0JxZy6kK1i5Lcgzsn8aGpoaVG26AMl7c7ZyWz9le1iq1RpMlbtNs9Gr/
 E3OdyCmh3N9/WhmpkzatsM8+iftnQfQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-R6rlaj7MNa-g0dwmtZNKHw-1; Fri, 05 Nov 2021 04:32:30 -0400
X-MC-Unique: R6rlaj7MNa-g0dwmtZNKHw-1
Received: by mail-ed1-f72.google.com with SMTP id
 w12-20020a056402268c00b003e2ab5a3370so8257688edd.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Nov 2021 01:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HUz7Uqfcr6vjpPuFN/6PJkrmCB4tUkJaU03BFN22CaE=;
 b=bb1S4m3p/Q54oC8ftsm/V1UI9D+IgaiHsA5OEi1l4KE+07YGEpTkKPvt5TUyLuTIVC
 tOwf6/6KqIqygYQyFrj02elwgQHh6nPUG/Ne91I2pGONk3o6Ue5gwZpGpa1NdCmYxIFL
 IkuthwDMvNGK1mSCkzib8nLTik4nNWdKKhy76tEatGD2nwFz3SoG27splSGyXIJ4keZb
 2E5kDx0QN1sF5N0p+Cf9lfKogcRFZDSktTLlHUn57GOOIMzNAzp3lcjEXQASxoEv4dsc
 bteUhTqh6NmLrqGEn6Khr+c21rJtP61Rfdikjg9Avm0ntDXlImvVPRikAmqk1KVUhJdX
 WSdw==
X-Gm-Message-State: AOAM533HffVRHca+4jAY0ZHEinZJVWCXJkXH0krQ6J+tM2IlaAfpx9gn
 /szAya5jXb/om10Ue3GliKRF9fhDszYeqdeFIksVc1WM1BSTD7StGQD74hYSZYkyLj5Rk8vcroE
 LN82gjENy1oqAs3MTDeI6NwucOTvoWHQhOkHR/mvexQ==
X-Received: by 2002:aa7:c395:: with SMTP id k21mr59826683edq.175.1636101149130; 
 Fri, 05 Nov 2021 01:32:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG6LlOvWNxHc/km/eCAgFIUf26b78WCGDOP8wC0KUlo3tODOpjH30Ptj/aqd85VBUALJi06g==
X-Received: by 2002:aa7:c395:: with SMTP id k21mr59826670edq.175.1636101149017; 
 Fri, 05 Nov 2021 01:32:29 -0700 (PDT)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id t15sm3588190ejx.75.2021.11.05.01.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Nov 2021 01:32:27 -0700 (PDT)
Date: Fri, 5 Nov 2021 09:32:24 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa: Mark vdpa_config_ops.get_vq_notification as optional
Message-ID: <20211105083224.5tkhslrswshbynnu@steredhat>
References: <20211104195248.2088904-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211104195248.2088904-1-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Nov 04, 2021 at 08:52:48PM +0100, Eugenio P=E9rez wrote:
>Since vhost_vdpa_mmap checks for its existence before calling it.
>
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>---
> include/linux/vdpa.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>index c3011ccda430..0bdc7f785394 100644
>--- a/include/linux/vdpa.h
>+++ b/include/linux/vdpa.h
>@@ -155,7 +155,7 @@ struct vdpa_map_file {
>  *				@vdev: vdpa device
>  *				@idx: virtqueue index
>  *				@state: pointer to returned state (last_avail_idx)
>- * @get_vq_notification:	Get the notification area for a virtqueue
>+ * @get_vq_notification:	Get the notification area for a virtqueue (optio=
nal)
>  *				@vdev: vdpa device
>  *				@idx: virtqueue index
>  *				Returns the notifcation area
>-- =

>2.27.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
