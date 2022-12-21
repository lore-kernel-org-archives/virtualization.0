Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09459C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 09:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8386E40327;
	Wed, 21 Dec 2022 09:17:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8386E40327
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TB9kWcwi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uRP4xX2yQ_HC; Wed, 21 Dec 2022 09:17:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1C5CA4047C;
	Wed, 21 Dec 2022 09:17:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C5CA4047C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8028AC0071;
	Wed, 21 Dec 2022 09:17:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA29EC0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 09:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 974E781F55
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 09:17:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 974E781F55
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TB9kWcwi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cOj5LEae9Iqm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 09:17:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD4FF81F47
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD4FF81F47
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 09:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671614258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AergAdW6+TgtRXhtnjRDfBqIWsvcGuj5y1ttsyoo6mc=;
 b=TB9kWcwi9ghGmpF3bYE0ggQk8mlWQSTmoo2xSmqgaYy3Ww9sozZlQqgJNYwZ87am4V7JkK
 JZ1iY7C9VJ2uI7+P0xPY9kLhcpKbipSYGgmekFoRzBo82u30w3EHqSYJZbb+joaeSwYNjd
 GkB19Ih/zPDLUfZqIs4aad5vR2CSSWQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-556-urov3kCiMUmDAOXy1gIZuQ-1; Wed, 21 Dec 2022 04:17:37 -0500
X-MC-Unique: urov3kCiMUmDAOXy1gIZuQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 y2-20020a056402440200b004779fcdf1baso8208915eda.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 01:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AergAdW6+TgtRXhtnjRDfBqIWsvcGuj5y1ttsyoo6mc=;
 b=z5biY5Un6HEZS7qim3h8HaLRIthD0gFjQ722Y71hIw/d6PBrkH7V73vJpr1oA1vO1X
 ESGbbDJckxwQouRpQG+xBdm2MNT+JSmp2692WcjzV4O1BzK/ufM3MGYENkZpceakW1rg
 P1Cp3gLRc/vXHkvwsFbqKsly2D421mar7FU2w5Zqdiw0XWfm+gLcbyJe98Ky4U5RTZPg
 ywNzw1qzq9ttaFgy8YLqL+k/wUKWiUu1ecvX/6doAm5BnH1d4nIUS0VKno/3sbyZReaC
 HHs9klwnGZzOn/E4BpmZkFzxQWeazOyaw7cRtLhzEnOk57cewf4ANIhD+mulQxcl8LSm
 DZvA==
X-Gm-Message-State: AFqh2kqW3zE5Aj5BQeoS4QdjKuA4UDStv4Av3N5Asc8YcO3GvXGpV625
 Kr0WEDexMhhDy6wD8W4PfSQBLbWrUKSznYOnJz54nRTcaJxrTxyQATaGpTb2d/0NIQHnF3JYTYc
 71Rgbvx9AaFedQGtJlcjNI2SrAcTF2FzEqz/6FtRZ7g==
X-Received: by 2002:a17:907:c28f:b0:83f:5f77:8ff9 with SMTP id
 tk15-20020a170907c28f00b0083f5f778ff9mr555342ejc.12.1671614256280; 
 Wed, 21 Dec 2022 01:17:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtsQIsCOCRbzktd3KBHd26Cph4enfdKBy5a5qRXNFpei1bQ8jMMoxgPGhW6LIpdLJz34o1fZA==
X-Received: by 2002:a17:907:c28f:b0:83f:5f77:8ff9 with SMTP id
 tk15-20020a170907c28f00b0083f5f778ff9mr555327ejc.12.1671614256062; 
 Wed, 21 Dec 2022 01:17:36 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 ch16-20020a170906c2d000b0079e11b8e891sm6677651ejb.125.2022.12.21.01.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Dec 2022 01:17:35 -0800 (PST)
Date: Wed, 21 Dec 2022 10:17:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa_sim: use weak barriers
Message-ID: <20221221091732.gvc724dnq2ntza7g@sgarzare-redhat>
References: <20221221062146.15356-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221221062146.15356-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

On Wed, Dec 21, 2022 at 02:21:46PM +0800, Jason Wang wrote:
>vDPA simulators are software emulated device, so let's switch to use
>weak barriers to avoid extra overhead in the driver.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

I was going to propose the same :-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index b071f0d842fb..eeaeaf43b476 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -68,7 +68,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
> 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>
> 	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>-			  VDPASIM_QUEUE_MAX, false,
>+			  VDPASIM_QUEUE_MAX, true,
> 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
> 			  (struct vring_avail *)
> 			  (uintptr_t)vq->driver_addr,
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
