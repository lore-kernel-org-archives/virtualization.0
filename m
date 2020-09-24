Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61C1C2D0E2
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 12:41:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640FC206D9
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 12:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwlnFb0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640FC206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9DB4986C29;
	Thu, 24 Sep 2020 12:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ucubh8fg3ntQ; Thu, 24 Sep 2020 12:41:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8F2CC86C1B;
	Thu, 24 Sep 2020 12:41:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69209C0890;
	Thu, 24 Sep 2020 12:41:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA027C0859
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 12:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 924CB87494
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 12:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NOIXCKlkw754
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 12:41:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DDFFC87490
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 12:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600951290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aNSiF3HKmN7T9wLSIPvLbtJzDyySplPmYpNDTcjCSdE=;
 b=EwlnFb0dX01+dYmTcYI8vMpxrSiceIgLTCHYB2SrH4UyV69ybjcj+gGxIyfEGpOG4RWyDx
 DAT+8ybvSAvrwAK/R41mfAnRL/aDSyoHQDEzvvVrWQB2EZSsJrHUES5o9/8OaaSRoNPubP
 PT6PuzFly6l1qxIqvd8BjvYWceTZA8U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-8CkO9ALbOAyYR2i6FvctPw-1; Thu, 24 Sep 2020 08:41:28 -0400
X-MC-Unique: 8CkO9ALbOAyYR2i6FvctPw-1
Received: by mail-wm1-f72.google.com with SMTP id a7so1193713wmc.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 05:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aNSiF3HKmN7T9wLSIPvLbtJzDyySplPmYpNDTcjCSdE=;
 b=ZpKw7lWCyW4rQkRFBtkN4xNib+B77VWeYPfXCQc+CeVYYgC71udfuHDJOpcG1jJe7r
 oQkSfobfDtdbwrLVYrG5jSLRhjGB9ccY04fp9XCbZvgt3Mte4anc6Vyq4D7CE+I9jk8l
 hKrhGkcG01dPpRcVhNXjVSS21whTn8U7mpAtHba2dKx4mxhgX/sta9wkkh6y+w/qNUqV
 GEqtD12Uo2ZFGiuY6+w7/czRg5pY9pMFceov4hx1v7zLzhkAJrKabQ5zc/gNpR+bbWG6
 TAcyA/QDFkC7o2PZxpyUg8ElGmji1eNUnI97LHAN/7w2ak5feciYd/9MDWEYbVWzHQQs
 Fg5w==
X-Gm-Message-State: AOAM5336TUasDHPtoDKQMObqdFvahVcYDOEFi1fgKrEg133Ymm435b6m
 Pf+8JYqcyJ6VxpPeumnapVYY/AGPlrItNJ59zqMuEtcDiQRTLJBRA08geT5w9p1zU9ZtYAa4tyE
 vb28j5ryespvVxSqGP6o19g4x3pPLHA2vXw2wVToD+w==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr4746948wrm.320.1600951287614; 
 Thu, 24 Sep 2020 05:41:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEXHb/sRDwgsZMDckSultGUskNu3nU9TGPgRovxnxIBYnpHIZ20/F1hEMcaTVWh90tOc5wHQ==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr4746933wrm.320.1600951287425; 
 Thu, 24 Sep 2020 05:41:27 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id z11sm3575767wru.88.2020.09.24.05.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 05:41:26 -0700 (PDT)
Date: Thu, 24 Sep 2020 08:41:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200924083918-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <20200924100255.GM27174@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200924100255.GM27174@8bytes.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Auger Eric <eric.auger@redhat.com>,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 bhelgaas@google.com
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

On Thu, Sep 24, 2020 at 12:02:55PM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2020 at 05:38:13AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> > > On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> > > > OK so this looks good. Can you pls repost with the minor tweak
> > > > suggested and all acks included, and I will queue this?
> > > 
> > > My NACK still stands, as long as a few questions are open:
> > > 
> > > 	1) The format used here will be the same as in the ACPI table? I
> > > 	   think the answer to this questions must be Yes, so this leads
> > > 	   to the real question:
> > 
> > I am not sure it's a must.
> 
> It is, having only one parser for the ACPI and MMIO descriptions was one
> of the selling points for MMIO in past discussions and I think it makes
> sense to keep them in sync.
> 
> > We can always tweak the parser if there are slight differences
> > between ACPI and virtio formats.
> 
> There is no guarantee that there only need to be "tweaks" until the
> ACPI table format is stablized.
> 
> Regards,
> 
> 	Joerg

But this has nothing to do with Linux.  There is also no guarantee that
the two committees will decide to use exactly the same format. Once one
of them sets the format in stone, we can add support for that format to
linux. If another one is playing nice and uses the same format, we can
use the same parsers. If it doesn't linux will have to follow suit.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
