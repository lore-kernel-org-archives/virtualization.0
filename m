Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85620968D
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730932064; cv=none; b=uoRlvQjPuyheutpowYBn7aTvdlUgAkRbGV1RUQCYouDjvPUHXzBuW4m1TfUmfscnnzOwT1PomRBaX6XE1TSOjReeDS9tGUC42L+9L9mhmJBG1r+HoeyfAwXv9yGR7Z2OAOi/Bqv61U9VkqTLNa1N1S8vNZKFvWJma4Va5R4kIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730932064; c=relaxed/simple;
	bh=TfcbASzHLXOQmhUTw7B7XdgxSKt70YMSigBRGMXvYGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9Y67PEH/G1xQgaQUhg/p5jCUPK2nOWBPEbC5p2GhcBrdDi6Y6oqeEdu+2laQgqu1tulcom0jfiHwPVnQU4+Zx/insR5fpXfRax2nx8kF+wV9ylkxAS4Id0jX05NmyxwzYBjqiYJgWki/JG4Kh7HL0byLzq620FkwW9Wfo+LxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWva7UoQ; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWva7UoQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 78B9540296
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 22:27:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p6utCTNoUxrk for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Nov 2024 22:27:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 48C16401AF
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48C16401AF
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RWva7UoQ
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48C16401AF
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730932059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=go5QFFw5cefXrO1K9axgjZ1UBjNlFOTxnqSlKpShRvI=;
	b=RWva7UoQhtExdYNzOboM3WE+RoFtbyhJ2zN5RUP9pjjoxgCGmlpXifF4KPXjIXyEOppxt5
	tMmLolN0nf+Q7fh94YExL6VchvR3padL5b7PZId0GHfDrgqu4QayD7YJm9YOvku/m7UPMf
	nEvIF/FE2S4QhdU7Vo8YTlxjds0zzN8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-9Gg7uOw5M4SFqMaMXic0BQ-1; Wed, 06 Nov 2024 17:27:36 -0500
X-MC-Unique: 9Gg7uOw5M4SFqMaMXic0BQ-1
X-Mimecast-MFC-AGG-ID: 9Gg7uOw5M4SFqMaMXic0BQ
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6cabd39e9so788835ab.0
        for <virtualization@lists.linux-foundation.org>; Wed, 06 Nov 2024 14:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730932056; x=1731536856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=go5QFFw5cefXrO1K9axgjZ1UBjNlFOTxnqSlKpShRvI=;
        b=aXDkfX1P+Sk9DTRBs16O4BM0IAqm5TEaLtjKDETtKjBf4hOak+hexy4OsoC7fvJOTm
         joATIOSIOqjQxfP0HbC8yLUk2BQxQwmVPIZQJulE67lknS9ct6G1Ld6L/verJV3xe/FP
         Wb+dh/VbWdh2h3feqsD2KrGCXxoj5Yzihdly6PZ5o/cw5/uW4R26BnU09iTUhhp+/cz7
         oODCNc47/u80nkZWUQUaPZRGzoddCeOolWJ5XM/9IXp1CANMWNM/1uoPdq2ZGG78dQPN
         DN9kggeuK40JrVy0XPwHV8uHprigxpk+th57+s1TvzpCf9e39WIMdr9EackO+N7Q+QLj
         KrkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBTHku8N1YDnAGzJeq8E1D7ryLGV6avY6lOYXkVUakvEMf/ae3AYHWTt0FCyvl9n3Fl0WeKdJ7j1E9y5i60w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy4FgcLpkPUqb/kFmzRFtFkrapKcL8xbdxbqyCdhfeCiNZAtgkK
	UvwRNS0AGe9f4GOb3/IB1y/j8K1Dh8+lFO7YyoZH5Z8naHTgLCs74HD4I3xVYA5Ikf2g18H6YjJ
	Y3gsMHCO3zgwR6HLCP68VS5je0FAAxzMJnX7SMuBWezGOr3SG2rz8/OOKcdw4xBLj/rmCJLYnUA
	lVaIM=
X-Received: by 2002:a05:6e02:1c0f:b0:3a6:c23b:5aa9 with SMTP id e9e14a558f8ab-3a6e84cd750mr3952275ab.4.1730932056009;
        Wed, 06 Nov 2024 14:27:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHN4fi2YHJCawlF5KgLKrt4ol1xgPR4L91BiOakokLHkZ74AuOFSDy3T9be8LT9i6QdnCvUw==
X-Received: by 2002:a05:6e02:1c0f:b0:3a6:c23b:5aa9 with SMTP id e9e14a558f8ab-3a6e84cd750mr3952155ab.4.1730932055649;
        Wed, 06 Nov 2024 14:27:35 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6bb812f95sm28024745ab.39.2024.11.06.14.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 14:27:35 -0800 (PST)
Date: Wed, 6 Nov 2024 15:27:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 parav@nvidia.com, feliu@nvidia.com, kevin.tian@intel.com,
 joao.m.martins@oracle.com, leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V1 vfio 7/7] vfio/virtio: Enable live migration once
 VIRTIO_PCI was configured
Message-ID: <20241106152732.16ac48d3.alex.williamson@redhat.com>
In-Reply-To: <20241106135909.GO458827@nvidia.com>
References: <20241104102131.184193-1-yishaih@nvidia.com>
	<20241104102131.184193-8-yishaih@nvidia.com>
	<20241105162904.34b2114d.alex.williamson@redhat.com>
	<20241106135909.GO458827@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2v42FrXV-ezBYzEApgV-C9LhjYPHkF3d4pK1fLZKjgs_1730932056
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 09:59:09 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Nov 05, 2024 at 04:29:04PM -0700, Alex Williamson wrote:
> > > @@ -1,7 +1,7 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  config VIRTIO_VFIO_PCI
> > >          tristate "VFIO support for VIRTIO NET PCI devices"
> > > -        depends on VIRTIO_PCI && VIRTIO_PCI_ADMIN_LEGACY
> > > +        depends on VIRTIO_PCI
> > >          select VFIO_PCI_CORE
> > >          help
> > >            This provides support for exposing VIRTIO NET VF devices which support
> > > @@ -11,5 +11,7 @@ config VIRTIO_VFIO_PCI
> > >            As of that this driver emulates I/O BAR in software to let a VF be
> > >            seen as a transitional device by its users and let it work with
> > >            a legacy driver.
> > > +          In addition, it provides migration support for VIRTIO NET VF devices
> > > +          using the VFIO framework.  
> > 
> > The first half of this now describes something that may or may not be
> > enabled by this config option and the additional help text for
> > migration is vague enough relative to PF requirements to get user
> > reports that the driver doesn't work as intended.  
> 
> Yes, I think the help should be clearer
> 
> > For the former, maybe we still want a separate config item that's
> > optionally enabled if VIRTIO_VFIO_PCI && VFIO_PCI_ADMIN_LEGACY.  
> 
> If we are going to add a bunch of  #ifdefs/etc for ADMIN_LEGACY we
> may as well just use VIRTIO_PCI_ADMIN_LEGACY directly and not
> introduce another kconfig for it?

I think that's what Yishai is proposing, but as we're adding a whole
new feature to the driver I'm concerned how the person configuring the
kernel knows which features from the description might be available in
the resulting driver.

We could maybe solve that with a completely re-written help text that
describes the legacy feature as X86-only and migration as a separate
architecture independent feature, but people aren't great at reading
and part of the audience is going to see "X86" in their peripheral
vision and disable it, and maybe even complain that the text was
presented to them.

OR, we can just add an optional sub-config bool that makes it easier to
describe the (new) main feature of the driver as supporting live
migration (on supported hardware) and the sub-config option as
providing legacy support (on supported hardware), and that sub-config
is only presented on X86, ie. ADMIN_LEGACY.

Ultimately the code already needs to support #ifdefs for the latter and
I think it's more user friendly and versatile to have the separate
config option.

NB. The sub-config should be default on for upgrade compatibility.

> Is there any reason to compile out the migration support for virtio?
> No other drivers were doing this?

No other vfio-pci variant driver provides multiple, independent
features, so for instance to compile out migration support from the
vfio-pci-mlx5 driver is to simply disable the driver altogether.

> kconfig combinations are painful, it woudl be nice to not make too
> many..

I'm not arguing for a legacy-only, non-migration version (please speak
up if someone wants that).  The code already needs to support the
#ifdefs and I think reflecting that in a sub-config option helps
clarify what the driver is providing and conveniently makes it possible
to have a driver with exactly the same feature set across archs, if
desired.  Thanks,

Alex

