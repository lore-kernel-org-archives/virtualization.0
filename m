Return-Path: <SRS0=s1EX=B5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB0EC433E1
	for <virtualization@archiver.kernel.org>; Wed, 19 Aug 2020 09:35:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEFE206FA
	for <virtualization@archiver.kernel.org>; Wed, 19 Aug 2020 09:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWvsaX6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEFE206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C0BA620BF9;
	Wed, 19 Aug 2020 09:35:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id queH4mFU0WqT; Wed, 19 Aug 2020 09:35:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 39AC820358;
	Wed, 19 Aug 2020 09:35:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0BF6C0889;
	Wed, 19 Aug 2020 09:35:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CDBEC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 09:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DC32321546
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 09:35:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G-IQQxC01D3U
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 09:35:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 2569520358
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 09:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597829702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zgtCTigZDuhIGcxkV1+kVI09BLaRJYOiJT5Qj4JZMc0=;
 b=NWvsaX6KxcaVKWeczrmsQADFybabdpeFcVkuRdoN8LjbRbO1DT3tvmrFn+hIWDsvwVLVo9
 KGUo3oHPWy8toallB6PBAcF9GnVl2dMTO0OtKDVOrf8Z/kiaAjnQMdfbH/llWzzw7f1yCb
 2dWrPuV95P1QQjU7VytBuaE+C5wRzck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-ZetAcgeqN7WK8fydIu2eWQ-1; Wed, 19 Aug 2020 05:34:58 -0400
X-MC-Unique: ZetAcgeqN7WK8fydIu2eWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1ED41084C8A;
 Wed, 19 Aug 2020 09:34:55 +0000 (UTC)
Received: from gondolin (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62AFA59;
 Wed, 19 Aug 2020 09:34:49 +0000 (UTC)
Date: Wed, 19 Aug 2020 11:34:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v8 1/2] virtio: let arch validate VIRTIO features
Message-ID: <20200819113446.3f098d1e.cohuck@redhat.com>
In-Reply-To: <64acd55a-8a22-4b84-0f9e-e13196c1520d@linux.ibm.com>
References: <1597762711-3550-1-git-send-email-pmorel@linux.ibm.com>
 <1597762711-3550-2-git-send-email-pmorel@linux.ibm.com>
 <20200818191910.1fc300f2.cohuck@redhat.com>
 <64acd55a-8a22-4b84-0f9e-e13196c1520d@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: gor@linux.ibm.com, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
 kvm@vger.kernel.org, mst@redhat.com, linuxram@us.ibm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, thomas.lendacky@amd.com,
 hca@linux.ibm.com, david@gibson.dropbear.id.au
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

On Wed, 19 Aug 2020 10:50:18 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2020-08-18 19:19, Cornelia Huck wrote:
> > On Tue, 18 Aug 2020 16:58:30 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> ...
> >> +config ARCH_HAS_RESTRICTED_MEMORY_ACCESS
> >> +	bool
> >> +	help
> >> +	  This option is selected by any architecture enforcing
> >> +	  VIRTIO_F_IOMMU_PLATFORM  
> > 
> > This option is only for a very specific case of "restricted memory
> > access", namely the kind that requires IOMMU_PLATFORM for virtio
> > devices. ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS? Or is this intended
> > to cover cases outside of virtio as well?  
> 
> AFAIK we did not identify other restrictions so adding VIRTIO in the 
> name should be the best thing to do.
> 
> If new restrictions appear they also may be orthogonal.
> 
> I will change to ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS if no one 
> complains.
> 
> >   
> >> +
> >>   menuconfig VIRTIO_MENU
> >>   	bool "Virtio drivers"
> >>   	default y
> >> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> >> index a977e32a88f2..1471db7d6510 100644
> >> --- a/drivers/virtio/virtio.c
> >> +++ b/drivers/virtio/virtio.c
> >> @@ -176,6 +176,10 @@ int virtio_finalize_features(struct virtio_device *dev)
> >>   	if (ret)
> >>   		return ret;
> >>   
> >> +	ret = arch_has_restricted_memory_access(dev);
> >> +	if (ret)
> >> +		return ret;  
> > 
> > Hm, I'd rather have expected something like
> > 
> > if (arch_has_restricted_memory_access(dev)) {  
> 
> may be also change the callback name to
> arch_has_restricted_virtio_memory_access() ?

Yes, why not.

> 
> > 	// enforce VERSION_1 and IOMMU_PLATFORM
> > }
> > 
> > Otherwise, you're duplicating the checks in the individual architecture
> > callbacks again.  
> 
> Yes, I agree and go back this way.
> 
> > 
> > [Not sure whether the device argument would be needed here; are there
> > architectures where we'd only require IOMMU_PLATFORM for a subset of
> > virtio devices?]  
> 
> I don't think so and since we do the checks locally, we do not need the 
> device argument anymore.

Yes, that would also remove some layering entanglement.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
