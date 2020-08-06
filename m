Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ED4C433E0
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 15:47:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028C022E01
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 15:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYMZTGs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028C022E01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5B7F288268;
	Thu,  6 Aug 2020 15:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SxtI+1cvKv5e; Thu,  6 Aug 2020 15:47:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D5DD888257;
	Thu,  6 Aug 2020 15:47:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4348C0050;
	Thu,  6 Aug 2020 15:47:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57917C004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 15:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4CB718855E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 15:47:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pyHS+b1JSw2g
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 15:47:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6C38388557
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 15:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596728876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8ASlZG4PjPJBhAfnFIIFM3UUn4KVlmkZfG7k5GeMeY=;
 b=OYMZTGs1buQVvG5YCT32IVjpASCoFaOVY08OcxIt0mZGzEHzf4ns8JzbHZL6b+wZrp4kzD
 /o+75mAdVDoTo16ZRGRxwQEyI2Edq30GKV+P5YnpKvxI2dOTD5fs+lmEzShX1yr3yWf6nX
 WyU5mMuGXigPFTnjQuKGCcLVNtUb9wg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-1Bx-Afw6NCqOOHK1jEdsug-1; Thu, 06 Aug 2020 11:47:53 -0400
X-MC-Unique: 1Bx-Afw6NCqOOHK1jEdsug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41A2F1800D42;
 Thu,  6 Aug 2020 15:47:52 +0000 (UTC)
Received: from gondolin (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4497D65C82;
 Thu,  6 Aug 2020 15:47:47 +0000 (UTC)
Date: Thu, 6 Aug 2020 17:47:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v1 0/1] s390: virtio-ccw: PV needs VIRTIO I/O device
 protection
Message-ID: <20200806174744.595b9c8c.cohuck@redhat.com>
In-Reply-To: <1596723782-12798-1-git-send-email-pmorel@linux.ibm.com>
References: <1596723782-12798-1-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, kvm@vger.kernel.org,
 mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com
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

On Thu,  6 Aug 2020 16:23:01 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Hi all,
> 
> In another series I proposed to add an architecture specific
> callback to fail feature negociation on architecture need.
> 
> In VIRTIO, we already have an entry to reject the features on the
> transport basis.
> 
> Transport is not architecture so I send a separate series in which
> we fail the feature negociation inside virtio_ccw_finalize_features,
> the virtio_config_ops.finalize_features for S390 CCW transport,
> when the device do not propose the VIRTIO_F_IOMMU_PLATFORM.
> 
> This solves the problem of crashing QEMU when this one is not using
> a CCW device with iommu_platform=on in S390.

This does work, and I'm tempted to queue this patch, but I'm wondering
whether we need to give up on a cross-architecture solution already
(especially keeping in mind that ccw is the only transport that is
really architecture-specific).

I know that we've gone through a few rounds already, and I'm not sure
whether we've been there already, but:

Could virtio_finalize_features() call an optional
arch_has_restricted_memory_access() function and do the enforcing of
IOMMU_PLATFORM? That would catch all transports, and things should work
once an architecture opts in. That direction also shouldn't be a
problem if virtio is a module.

> 
> Regards,
> Pierre
> 
> Regards,
> Pierre
> 
> Pierre Morel (1):
>   s390: virtio-ccw: PV needs VIRTIO I/O device protection
> 
>  drivers/s390/virtio/virtio_ccw.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
