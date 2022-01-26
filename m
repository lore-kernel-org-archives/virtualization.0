Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC8FC3526D
	for <virtualization@archiver.kernel.org>; Wed, 26 Jan 2022 14:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A756441616;
	Wed, 26 Jan 2022 14:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KWCRMm3Wgcbb; Wed, 26 Jan 2022 14:14:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4713740247;
	Wed, 26 Jan 2022 14:14:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26CC0C0039;
	Wed, 26 Jan 2022 14:14:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52844C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 14:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CA87415DF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 14:14:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7iuNjKYoVsq8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 14:14:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8198740247
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643206450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sIHOSHa8eGkKGGsPkDgJCA6OjwUd7QYCWYjmU+mG6O0=;
 b=YjGsliaLe+GJEvnt/Y+5wUXLcVzxsSmrMS8pZV3zvBcqkq1CxptHcYqRMXwm/30ryL8NDR
 KdmobClCuIx3EzHWBO9vyyhWCSkRGC6CoYMnche4CHXITN3jo1SGLPrlhPZ+g0MsuxLYtv
 lrfG+0ktx1aRGfEJ9WxKKGSQmWQiSko=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-FdHl94vEMDifE0RlsgqgNA-1; Wed, 26 Jan 2022 09:14:09 -0500
X-MC-Unique: FdHl94vEMDifE0RlsgqgNA-1
Received: by mail-wr1-f72.google.com with SMTP id
 c9-20020adfa709000000b001dde29c3202so502502wrd.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 06:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sIHOSHa8eGkKGGsPkDgJCA6OjwUd7QYCWYjmU+mG6O0=;
 b=zB2kCuhtWkUnkkTjTdFQoZh8WXFpiELV53r/5Epqg8jq1c2T27fzdqL2HLTCdVcKn/
 5/URt7V/x88kle+OaeF2Ihs7mUT4FVrjBsBEphrpb+Arv6kvJBS8zVDnmENgCpv0+E4F
 T/cFle3vlhkR3jdiMk+P/sb7fi49VTw0TlVhKxsmk69uzUFnCZtQnIaNW0fUiM+RlcXJ
 ZR17MpNV8DVlK0UCskTLJPdSnKMP0FEoxQl12jZd2Pvr/U4n1YX2Sw2UD4ulMLENRV/C
 NgdZ069lXAwUHMBBt3XKf18u6S5fw6B0XB5LBEj4M5mMVrqpYa/wtbYW7lormasaVxDn
 gIEA==
X-Gm-Message-State: AOAM532plU4/YPnhXjGAY4aygWab419eYConu70NYo6sVrKkM+heEhZd
 uMtZW5QdTIg+UHt6yxpAgvKlAHYVIjFjWepTn8PKdVbYvu/rYAsdCrEhzfdZ8VLKK8e7EBPoGCS
 AtAzXEBnjHbcb00K0HvrQ+kd5o2DsjwtW1Mn761XuTQ==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr7547569wmi.137.1643206447919; 
 Wed, 26 Jan 2022 06:14:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxsuOF3MaH44FkbRm4WHcKCRq305PlEtcSv3SMmq9JgF98lmfEoXB0+wfRuQwNcMIKUfVgdQ==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr7547554wmi.137.1643206447732; 
 Wed, 26 Jan 2022 06:14:07 -0800 (PST)
Received: from redhat.com ([2.55.9.226])
 by smtp.gmail.com with ESMTPSA id n14sm12369103wri.75.2022.01.26.06.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jan 2022 06:14:07 -0800 (PST)
Date: Wed, 26 Jan 2022 09:14:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V3 0/4] vDPA/ifcvf: implement shared IRQ feature
Message-ID: <20220126091329-mutt-send-email-mst@kernel.org>
References: <20220126124912.90205-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20220126124912.90205-1-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Wed, Jan 26, 2022 at 08:49:08PM +0800, Zhu Lingshan wrote:
> It has been observed that on some platforms/devices, there may
> not be enough MSI vectors for virtqueues and the config change.
> Under such circumstances, the interrupt sources of a device
> have to share vectors/IRQs.
> 
> This series implemented a shared IRQ feature for ifcvf.
> 
> Please help review.

Given the history, can you please report which tests
were performed with this patchset? Which configs tested?
Thanks?

> Changes from V2:
> (1) Fix misuse of nvectors(in ifcvf_alloc_vectors return value)(Michael)
> (2) Fix misuse of irq = get_vq_irq() in setup irqbypass(Michael)
> (3) Coding style improvements(Michael)
> (4) Better naming of device shared irq/shared vq irq
> 
> Changes from V1:
> (1) Enable config interrupt when only one vector is allocated(Michael)
> (2) Clean vectors/IRQs if failed to request config interrupt
> since config interrupt is a must(Michael)
> (3) Keep local vdpa_ops, disable irq_bypass by setting IRQ = -EINVAL
> for shared IRQ case(Michael)
> (4) Improvements on error messages(Michael)
> (5) Squash functions implementation patches to the callers(Michael)
> 
> Zhu Lingshan (4):
>   vDPA/ifcvf: implement IO read/write helpers in the header file
>   vDPA/ifcvf: implement device MSIX vector allocator
>   vhost_vdpa: don't setup irq offloading when irq_num < 0
>   vDPA/ifcvf: implement shared IRQ feature
> 
>  drivers/vdpa/ifcvf/ifcvf_base.c |  67 +++-----
>  drivers/vdpa/ifcvf/ifcvf_base.h |  60 +++++++-
>  drivers/vdpa/ifcvf/ifcvf_main.c | 260 ++++++++++++++++++++++++++++----
>  drivers/vhost/vdpa.c            |   4 +
>  4 files changed, 312 insertions(+), 79 deletions(-)
> 
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
