Return-Path: <SRS0=8XPq=E2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ED2C5519F
	for <virtualization@archiver.kernel.org>; Fri, 20 Nov 2020 14:41:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864F72224C
	for <virtualization@archiver.kernel.org>; Fri, 20 Nov 2020 14:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUkGMczl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864F72224C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ED24D86EDC;
	Fri, 20 Nov 2020 14:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9cLInT2QIB-H; Fri, 20 Nov 2020 14:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6015686E9F;
	Fri, 20 Nov 2020 14:41:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A2D3C163C;
	Fri, 20 Nov 2020 14:41:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82C4EC0891
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 14:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6A27B86EDB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 14:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f6cx_Y5pFt1r
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 14:41:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0BEAB86E9F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605883274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1lkgsCtAW9gay4nzrsgpJCYCXHG/gdOfQ5aoMkR6+I=;
 b=TUkGMczl366J9djoxklEC+y+r3wfAu92vtP3RlKShEWi58kTYJS3em/FiSm0Lipgu9EcCI
 ll2SHsHYF+gPBhqCoD0j5vmjSSKNI8dRejlgcS2DKojY8MymGMn4rfELziXIBSMbCSlno/
 AALheBiPuFWP70zryjgjDKbK8VTwWq4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-T-lcw9tZOyeGGAW_nkMyaQ-1; Fri, 20 Nov 2020 09:41:13 -0500
X-MC-Unique: T-lcw9tZOyeGGAW_nkMyaQ-1
Received: by mail-wr1-f71.google.com with SMTP id n4so3465768wrt.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 06:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O1lkgsCtAW9gay4nzrsgpJCYCXHG/gdOfQ5aoMkR6+I=;
 b=RmT6HR8usovrKlZp1tqr3wcwA382wHIwZtJ1Y7OCEPjvSBgIyY5dZQPGEDLuQAGVci
 wyV+Zgg+r3pEalDlDFea8EmWd3Z5ltCWGN0tMyVX3wnc+Ks4SPVqtN4UXJ2ADXOZuHLt
 JGViKtVAEy1BXpL2QjBMm9IX04IRv16aoQbFt8eOLFTsK7VDuHRUAbM5lHE21l8T5U+j
 xw1IKQBIwurld4LSf0n6Nzf0ONHN62yLJx3QBnTqlp5HX1xUZaB40gOVzFYPoyyZBa8e
 /KbtPj/B2/tEZD2+7U1fRc3YgvOJeVaFxz/1LOw6sgR0/0ub0J0TA76+Dnwtm+Yl100E
 0pdg==
X-Gm-Message-State: AOAM531Vjh72GHRJGMjV75Sfk8pP7m9P7pB+LDnwQfo2Cj/t3hJt1sZg
 hpluPB95qefcvugEc4MOFjFkvM3aVhInT3jB2UxLC76VelVEmdXh/dYNc6KsLW6EYyelciu34lb
 Tp6UoPbYaK0UAg/HRdgYvRbPENTgjnyc+l24qpElj2A==
X-Received: by 2002:adf:f181:: with SMTP id h1mr15982315wro.267.1605883271029; 
 Fri, 20 Nov 2020 06:41:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEZQejCgLFVrq6q+ujHyBd46vdktdOw4jy0hWO52Dab1yBLPrKbw2vTOTtv2NCzaReoRni8w==
X-Received: by 2002:adf:f181:: with SMTP id h1mr15982290wro.267.1605883270766; 
 Fri, 20 Nov 2020 06:41:10 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id k64sm4598406wmb.11.2020.11.20.06.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2020 06:41:10 -0800 (PST)
Date: Fri, 20 Nov 2020 15:41:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC 10/12] vdpa_sim: split vdpasim_virtqueue's iov field
 in riov and wiov
Message-ID: <20201120144107.hlpkkrjdvjhvuxma@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-11-sgarzare@redhat.com>
 <20201117112703.GF131917@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201117112703.GF131917@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eli Cohen <elic@nvidia.com>
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

On Tue, Nov 17, 2020 at 11:27:03AM +0000, Stefan Hajnoczi wrote:
>On Fri, Nov 13, 2020 at 02:47:10PM +0100, Stefano Garzarella wrote:
>> vringh_getdesc_iotlb() manages 2 iovs for writable and readable
>> descriptors. This is very useful for the block device, where for
>> each request we have both types of descriptor.
>>
>> Let's split the vdpasim_virtqueue's iov field in riov and wiov
>> to use them with vringh_getdesc_iotlb().
>
>Is riov/wiov naming common? VIRTIO uses "in" (device-to-driver) and
>"out" (driver-to-device). Using VIRTIO terminology might be clearer.

I followed the vringh_getdesc_iotlb() attribute names, but I agree that 
"in" and "out" would be better. I lost multiple times with read/write...

I'll fix!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
