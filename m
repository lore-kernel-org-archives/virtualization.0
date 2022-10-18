Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84879C433FE
	for <virtualization@archiver.kernel.org>; Tue, 18 Oct 2022 06:15:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04F4A60FD7;
	Tue, 18 Oct 2022 06:15:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 04F4A60FD7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OQsNf4PP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oX69gt2Z6spB; Tue, 18 Oct 2022 06:15:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 72A81605AE;
	Tue, 18 Oct 2022 06:15:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72A81605AE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4442BC0033;
	Tue, 18 Oct 2022 06:15:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FD7FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A3A382F51
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:15:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A3A382F51
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OQsNf4PP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eKTNC5n7NKpG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:15:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1CFC1829FE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1CFC1829FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666073730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zpVfy6wCqfcz19Nf6miQhSXq6cJYbY42NLTDy57gurg=;
 b=OQsNf4PPHribh9hsh46UmOmxeANDztVG+lJALCU4RM9X7MMBhCKlIDu0w/6v6J9bJu4SY9
 eds5GT3HeOtXe++cXG6uHuR4OYV9WQdhSOSHvh6+jvpjbYgtvl7DT+mjCN+3vAaIrJwoMs
 KBuR7yMFvF6/AlVhW3FdeJGNUCxLOEg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-90-bzbfbFLSMj2c45SwJi0byw-1; Tue, 18 Oct 2022 02:15:28 -0400
X-MC-Unique: bzbfbFLSMj2c45SwJi0byw-1
Received: by mail-wm1-f69.google.com with SMTP id
 fc12-20020a05600c524c00b003b5054c70d3so8778909wmb.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 23:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zpVfy6wCqfcz19Nf6miQhSXq6cJYbY42NLTDy57gurg=;
 b=sQ1IG0OHCj/+3+2khRtcJ2synCygLf171YdrbqPOoo3R2y3B0HLbr9baK+TFko8M7N
 My7hPl8Ee2+c3eapWBS7ykhHvcBizz53W3QwIAb1KOjpZ7B2N5BjKlNOQebSrsGaxi8s
 2riFHuKTzNUuWIwNzdv25ysuez/zqK917hCCrGHHlGMb83FDxANzfEcNl4GrN3rkZYLQ
 HC3SPiZj2ulybfyysdQnagghMponZeHQmBgifsk7fZbnTawk6UBPTCpOM2Jn3ngflm0B
 Hs+7o0PQH5b+0RacfSuojJYs0nblnFSwHCJTbhObBnd9tTAFpYKGtkUXlKUDlph0Oy7i
 ZJIw==
X-Gm-Message-State: ACrzQf0fFkznFOMGYNrs+FvKfRhqVX1SxDiybmTLcRseejZoNetPVaoP
 50Zrw66c3PYYUfFV9n+DoRY/mk5+xWxTuUtEnh95/2pBCKXDqVIdEJvKtiq/0xcxFyfWySXaU4+
 eIIvn9T2quKYqdMlTReIVQB8ti3LL2mi5P8FMJYjJeA==
X-Received: by 2002:a05:600c:6028:b0:3c6:f0bb:316a with SMTP id
 az40-20020a05600c602800b003c6f0bb316amr9564310wmb.1.1666073727801; 
 Mon, 17 Oct 2022 23:15:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4WNPgaS6HslEhBdXCqt7n+xVxIebjn0za52rwGUrmf6GTlgbv1cPYvvmczESDAI5t40p2Z7g==
X-Received: by 2002:a05:600c:6028:b0:3c6:f0bb:316a with SMTP id
 az40-20020a05600c602800b003c6f0bb316amr9564297wmb.1.1666073727570; 
 Mon, 17 Oct 2022 23:15:27 -0700 (PDT)
Received: from redhat.com ([2.54.172.104]) by smtp.gmail.com with ESMTPSA id
 iw6-20020a05600c54c600b003c6c3fb3cf6sm12447693wmb.18.2022.10.17.23.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Oct 2022 23:15:26 -0700 (PDT)
Date: Tue, 18 Oct 2022 02:15:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sebastien.boeuf@intel.com
Subject: Re: [PATCH v3 0/4] vdpa: Add resume operation
Message-ID: <20221018021506-mutt-send-email-mst@kernel.org>
References: <cover.1666008238.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
In-Reply-To: <cover.1666008238.git.sebastien.boeuf@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org
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

On Mon, Oct 17, 2022 at 02:06:19PM +0200, sebastien.boeuf@intel.com wrote:
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> 
> This series introduces a new operation for vdpa devices. It allows them
> to be resumed after they have been suspended. A new feature bit is
> introduced for devices to advertise their ability to be resumed after
> they have been suspended. This feature bit is different from the one
> advertising the ability to be suspended, meaning a device that can be
> suspended might not have the ability to be resumed.
> 
> Even if it is already possible to restore a device that has been
> suspended, which is very convenient for live migrating virtual machines,
> there is a major drawback as the device must be fully reset. There is no
> way to resume a device that has been suspended without having to
> configure the device again and without having to recreate the IOMMU
> mappings. This new operation aims at filling this gap by allowing the
> device to resume processing the virtqueue descriptors without having to
> reset it. This is particularly useful for performing virtual machine
> offline migration, also called snapshot/restore, as it allows a virtual
> machine to resume to a running state after it was paused and a snapshot
> of the entire system was taken.
> 
> Sebastien Boeuf (4):
>   vdpa: Add resume operation
>   vhost-vdpa: Introduce RESUME backend feature bit
>   vhost-vdpa: uAPI to resume the device
>   vdpa_sim: Implement resume vdpa op
> 
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 19 ++++++++++++++++++
>  drivers/vhost/vdpa.c             | 34 +++++++++++++++++++++++++++++++-
>  include/linux/vdpa.h             |  6 +++++-
>  include/uapi/linux/vhost.h       |  8 ++++++++
>  include/uapi/linux/vhost_types.h |  2 ++
>  5 files changed, 67 insertions(+), 2 deletions(-)


Not on list:

$ b4 mbox cover.1666008238.git.sebastien.boeuf@intel.com
Looking up https://lore.kernel.org/r/cover.1666008238.git.sebastien.boeuf%40intel.com
That message-id is not known.
$ 


dropped for now.

> -- 
> 2.34.1
> 
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris, 
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 5 208 026.16 Euros
> 
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
