Return-Path: <SRS0=/j96=DI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83053C4741F
	for <virtualization@archiver.kernel.org>; Thu,  1 Oct 2020 12:46:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F3320B1F
	for <virtualization@archiver.kernel.org>; Thu,  1 Oct 2020 12:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXMT8ybI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F3320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 55475862D4;
	Thu,  1 Oct 2020 12:46:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zF4_27vopk3x; Thu,  1 Oct 2020 12:46:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B101C85F58;
	Thu,  1 Oct 2020 12:46:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0BB4C0889;
	Thu,  1 Oct 2020 12:46:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06840C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 12:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E371C86A32
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 12:46:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N4f7npqq6MJ2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 12:46:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9DCC486A26
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601556400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Js563GcaR2/yt5ZRRb4g7uvZTFa1RVtXs31pHNFBFkg=;
 b=RXMT8ybI/DtCizqV42MCHXcUUePtAUW1c/V3LW7DZkpFyTq0Egzu4S3s90djEHpE1Bg1HB
 q94BFq4defsIkxQUpieyXx40F4NCbUgK2cET/UDQ6hGjATL/Pq6K+/cc5rJeC5Kk03GKow
 nLjaM83zpOCR2hgfuJ+3XXJn/fR+XVo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-938LRj9YM0yq4c-3wedWCw-1; Thu, 01 Oct 2020 08:46:35 -0400
X-MC-Unique: 938LRj9YM0yq4c-3wedWCw-1
Received: by mail-wm1-f69.google.com with SMTP id l26so861873wmg.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Oct 2020 05:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Js563GcaR2/yt5ZRRb4g7uvZTFa1RVtXs31pHNFBFkg=;
 b=qT9Etz7raUuV+BdpnN3ERCRlpwZN3T4wZ0RpZn0oZKRtTl48ql4efeugDEjmW0Vdqv
 S2abW2N7gYqfiozISqjcOtFqQ6ekhiQwgQTJdnK/LLUjO/crWzZaRem8xChW11jNaddQ
 RWcC7JSLWYqKsuODh2lrbG6z62Q+DzdkN3oOim2ni58k+hisT1CxlPddOopa90skOl6D
 Mu8qe5Jeee/5ErRDnN64PjrBwDqy/kJkAHQbzPledWgQURAtPpnFpNBqaWD6WYdtNmVP
 Kd/JrMlvZf3dbg9eQdYA1/+/AJ57J1nFctGY3or3OPjGSvWQE+uC4Mt5GSxdsG+WSMHV
 vkQw==
X-Gm-Message-State: AOAM530ypshg0Q1eRrgwe9IN+6kPhra9otJGhDocLFSHPW4dR7axbwfM
 uh7Rn7txxdh+UjUlveJjW/jAauxydg4kRRREm941PMc5jFTphhsWfkSO4Ms4yr8GkV6qXfAApXd
 8hlnla2PFPNms5Rv9Dyzjr03ru8eYgT2aQuG4rDmTaw==
X-Received: by 2002:a7b:c774:: with SMTP id x20mr2389452wmk.102.1601556394413; 
 Thu, 01 Oct 2020 05:46:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH6EuErZXThHeJ05UE72wy3Fr8fkLJJnHtXxx76BlpIz/RYUHWaHYI9cBE1T6i8tXzrTOyqA==
X-Received: by 2002:a7b:c774:: with SMTP id x20mr2389421wmk.102.1601556394184; 
 Thu, 01 Oct 2020 05:46:34 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id y1sm8480045wma.36.2020.10.01.05.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 05:46:33 -0700 (PDT)
Date: Thu, 1 Oct 2020 08:46:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 0/2] vhost: Skip access checks on GIOVAs
Message-ID: <20201001084608-mutt-send-email-mst@kernel.org>
References: <160139701999.162128.2399875915342200263.stgit@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <160139701999.162128.2399875915342200263.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org,
 David Gibson <david@gibson.dropbear.id.au>
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

On Tue, Sep 29, 2020 at 06:30:20PM +0200, Greg Kurz wrote:
> This series addresses some misuse around vring addresses provided by
> userspace when using an IOTLB device. The misuse cause failures of
> the VHOST_SET_VRING_ADDR ioctl on POWER, which in turn causes QEMU
> to crash at migration time.
> 
> While digging some more I realized that log_access_ok() can also be 
> passed a GIOVA (vq->log_addr) even though log_used() will never log
> anything at that address. I could observe addresses beyond the end
> of the log bitmap being passed to access_ok(), but it didn't have any
> impact because the addresses were still acceptable from an access_ok()
> standpoint. Adding a second patch to fix that anyway.
> 
> Note that I've also posted a patch for QEMU so that it skips the used
> structure GIOVA when allocating the log bitmap. Otherwise QEMU fails to
> allocate it because POWER puts GIOVAs very high in the address space (ie.
> over 0x800000000000000ULL).
> 
> https://patchwork.ozlabs.org/project/qemu-devel/patch/160105498386.68108.2145229309875282336.stgit@bahia.lan/

I queued this. Jason, can you ack please?

> v2:
>  - patch 1: move the (vq->ioltb) check from vhost_vq_access_ok() to
>             vq_access_ok() as suggested by MST
>  - patch 2: new patch
> 
> ---
> 
> Greg Kurz (2):
>       vhost: Don't call access_ok() when using IOTLB
>       vhost: Don't call log_access_ok() when using IOTLB
> 
> 
>  drivers/vhost/vhost.c |   32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> --
> Greg

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
