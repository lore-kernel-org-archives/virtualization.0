Return-Path: <SRS0=pd2K=EP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B01C2D0A3
	for <virtualization@archiver.kernel.org>; Mon,  9 Nov 2020 22:32:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F1220679
	for <virtualization@archiver.kernel.org>; Mon,  9 Nov 2020 22:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhEuh4O8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F1220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4FED687416;
	Mon,  9 Nov 2020 22:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UbebOfAFH1tg; Mon,  9 Nov 2020 22:32:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BE4D386FD4;
	Mon,  9 Nov 2020 22:32:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD1F6C088B;
	Mon,  9 Nov 2020 22:32:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9513C016F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 22:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9676B87003
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 22:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c8TBQYZSVy-N
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 22:32:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B09EC86FD4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604961147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ilWn6M2YeSNAy1OjrKgETUEYS6rW9P62pTXErbsPxXU=;
 b=JhEuh4O8qd6Dbe/GEK3Po5sh1ENbAdjChp4F7fpyc1yRDL+ufN/3xMbkBUqhkH46bcsc6M
 LuRCKV5EES98pX2oKBHwwfMHo1LudaJx8fCa7ovszjQ3RSG2yXv/ZPaYNVuGvYYxIRtPmw
 Pab0GqIpPACE77UMlrtrTIA0VGiST94=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-IcN7WfBHO8Og9HZlkAD2GA-1; Mon, 09 Nov 2020 17:32:25 -0500
X-MC-Unique: IcN7WfBHO8Og9HZlkAD2GA-1
Received: by mail-wm1-f70.google.com with SMTP id s85so268529wme.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Nov 2020 14:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ilWn6M2YeSNAy1OjrKgETUEYS6rW9P62pTXErbsPxXU=;
 b=bvUOzcTba5EkNtQGpPwLp95KGwMQN43HQ4IJLOZUOjN9rM+FHXmu8LjUO/+ByHd3uJ
 HWwRjtge2TeGFhFChwTYLRsaDEuk+oXZfyjE1hARmmJ0Xo3KyaKW+ebCNPBliXjSfr12
 6JiaENAMP+ylURIRRqDJBXtg3CkFjzsuIhbvizAYDaaEHOKACeYZWZm3GCH4EzQfNx/j
 Gmlt6jUw29Vr7bGitq1Fi7ZW2OaIGZnXwxpiKoRYtBoNRIOPv8/2HyLRnE1bTMJgVEec
 Ed9TgUIbDncV0wlnz4o+tphPaF8F+9eIlu8pGPeRjzGUNcc7UVk2K6uzuGe+WVN8f8lG
 ClYw==
X-Gm-Message-State: AOAM533NTTEjCxbSr1JAHc/j/KnIIehtwzgyyYAz8mYc6JarKVD+vz2p
 15MaeCw/i0U5H9ujUFy51EifoU2k9p3wLx9Wv5jGvFBgwhYtNzZIXo+eK0+TKqQrO+85/Lb8sDQ
 5Pq2UcxiVJhdQ85l/E45knRCpB/T9/bxlR2K46k++ZA==
X-Received: by 2002:adf:9544:: with SMTP id 62mr20108969wrs.223.1604961143334; 
 Mon, 09 Nov 2020 14:32:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyh47AqupUQogPqD176lZqagmPngj1Pmkx6eJjzzl/nhQE8xwUWQt+djiOvPwM7ngtjJEbr0g==
X-Received: by 2002:adf:9544:: with SMTP id 62mr20108951wrs.223.1604961143173; 
 Mon, 09 Nov 2020 14:32:23 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id y185sm841543wmb.29.2020.11.09.14.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 14:32:21 -0800 (PST)
Date: Mon, 9 Nov 2020 17:32:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 06/11] vhost: support delayed vq creation
Message-ID: <20201109173058-mutt-send-email-mst@kernel.org>
References: <1604528804-2878-1-git-send-email-michael.christie@oracle.com>
 <1604528804-2878-7-git-send-email-michael.christie@oracle.com>
 <56056e8d-d6ff-9a6e-2a7e-1ea1737b1d27@redhat.com>
 <54285b79-637e-3dcd-382f-ddeff44f6019@oracle.com>
 <fc22b679-08c1-85bb-515a-8f63de7148a2@oracle.com>
MIME-Version: 1.0
In-Reply-To: <fc22b679-08c1-85bb-515a-8f63de7148a2@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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

On Mon, Nov 09, 2020 at 02:30:36PM -0600, Mike Christie wrote:
> On 11/9/20 12:41 PM, Mike Christie wrote:
> > 
> > If you want to pair this patchset down to it's bare bug fixes that
> > prevent users from getting IO errors, I would do ring.addr check only
> > approach for this bug fix patchset.
> 
> Oh yeah, just so we don't have to burn an extra day, above I'm proposing I
> repost the original patchset:
> 
> https://lore.kernel.org/linux-scsi/1600712588-9514-1-git-send-email-michael.christie@oracle.com/t/
> 
> for the bug fix only patches. It will have the compile error fixed and
> Bart's comment handled.
> 
> To even trim it down more I can also drop the last 2 patches:
> 
> 0007-vhost-remove-work-arg-from-vhost_work_flush.patch
> 0008-vhost-scsi-remove-extra-flushes.patch
> 
> and send separately in a cleanups patchset since the extra flushes it kills
> don't really hurt.

Makes sense to me.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
