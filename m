Return-Path: <SRS0=YXi0=PY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355D4C433F5
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 08:33:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E825360232
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 08:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E825360232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B94D540178;
	Fri,  5 Nov 2021 08:33:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fVGBnPKKBS6E; Fri,  5 Nov 2021 08:33:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7ACBD4015A;
	Fri,  5 Nov 2021 08:33:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40386C0019;
	Fri,  5 Nov 2021 08:33:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C88CFC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2FFD80EDF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:33:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6uQYuH3B9icM
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:33:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D4E180ECE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636101179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JSxcNVRVB/DnKZ4+R+U2HEVeDSNW0idhy+8Cu/Pwcx0=;
 b=APMT/2up7s68m7Hru2j/xMF7qi+7x3C2nOT1Lu9cxn33Pw3qiRgBFOwBthC6O9q+tEdd1o
 g4i3lFlEBSZWLdL6WhGN4FWj/OGo0DKEVyZSAsO9QLamTQqskivBkyb361q38YQM72OhLF
 vD+UeQBCLxywKBVfrIvBn2bS3F6/TAQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-qbdI_Pf9Opq7PS3OxsoFCw-1; Fri, 05 Nov 2021 04:32:57 -0400
X-MC-Unique: qbdI_Pf9Opq7PS3OxsoFCw-1
Received: by mail-ed1-f71.google.com with SMTP id
 m8-20020a056402510800b003e29de5badbso8158252edd.18
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Nov 2021 01:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=JSxcNVRVB/DnKZ4+R+U2HEVeDSNW0idhy+8Cu/Pwcx0=;
 b=zeEI3z9AZrb/99iiyYwin33zPmqsnCtWR3fRysKYxAyCOW6ifhmCs4EOaHU7e1a2uy
 RYldnRQAb/5sZY8D04XBHw8XszNP2rVaNmmKBErLMPprfsCMnj4OclHWwWDPL4tIXanR
 3IK7wkuynv/17eXympIl267ROcG+tq+FUuFZ5+vRnuKIEz/Gk7etSyCMGOSlqzsOsNGl
 7xJ6hVthIvrlj11fFWK/0Wr+n6S8Fry9Dk2ELEqMw6KMkInWfDUAErIcKE9YFizM8mQ2
 2GDbEYARGUwTyPXkR1v0v87pd8i5AsBopXW1bNNNFHj5CbryLEjAoSXqc+YlA2Iw0Cgr
 8PbA==
X-Gm-Message-State: AOAM530YfxbAlCXOt4Kw95uTjfNjNJpQGd/nvWoBIAHfQmR332oeuHFv
 nfIWnJXiXy62ro/UJrGSS31eg1J+BPEzoILS6NegmC4jfqUAWr/yL6Gztdcde2WtlmoY9AAjdlI
 9j63RR+e1UwuApuC6puT4+SRR7mjCy9g5sK0Odm7gEQ==
X-Received: by 2002:a05:6402:6c8:: with SMTP id
 n8mr44987883edy.38.1636101176829; 
 Fri, 05 Nov 2021 01:32:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1GoJj1G+zOd7oQ+Yq/sGjIs8oFTI+82pGo9B8tvnTk8Cb+1Fmockzi86p8mv8w/4VBcIpXg==
X-Received: by 2002:a05:6402:6c8:: with SMTP id
 n8mr44987864edy.38.1636101176724; 
 Fri, 05 Nov 2021 01:32:56 -0700 (PDT)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id f22sm4127471edu.26.2021.11.05.01.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Nov 2021 01:32:56 -0700 (PDT)
Date: Fri, 5 Nov 2021 09:32:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa: Avoid duplicate call to vp_vdpa get_status
Message-ID: <20211105083253.y4mikalhbfwmcuhp@steredhat>
References: <20211104195833.2089796-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211104195833.2089796-1-eperezma@redhat.com>
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

On Thu, Nov 04, 2021 at 08:58:33PM +0100, Eugenio P=E9rez wrote:
>It has no sense to call get_status twice, since we already have a
>variable for that.
>
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>---
> drivers/vhost/vdpa.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index 01c59ce7e250..10676ea0348b 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -167,13 +167,13 @@ static long vhost_vdpa_set_status(struct vhost_vdpa =
*v, u8 __user *statusp)
> 	status_old =3D ops->get_status(vdpa);
>
> 	/*
> 	 * Userspace shouldn't remove status bits unless reset the
> 	 * status to 0.
> 	 */
>-	if (status !=3D 0 && (ops->get_status(vdpa) & ~status) !=3D 0)
>+	if (status !=3D 0 && (status_old & ~status) !=3D 0)
> 		return -EINVAL;
>
> 	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG=
_S_DRIVER_OK))
> 		for (i =3D 0; i < nvqs; i++)
> 			vhost_vdpa_unsetup_vq_irq(v, i);
>
>-- =

>2.27.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
