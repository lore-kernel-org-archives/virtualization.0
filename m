Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A631AF14
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785697702; cv=none; b=gPlb1Bjy8A7pltyGWMY9pJai8oeNd8b5tZ4UAiyKondxD921zNO6soARU7TOWgD7qwQi0dyBeGGJwx0nsVH8qfyT33akeEST04a0acFaG3TFsQ0IwP0Rumxm5IbxozYIe/vZJspnZDF2SRHmHdulUbKhq9Klpd40xoC1bC8ya3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785697702; c=relaxed/simple;
	bh=fdafD+f1wymzNcufy3OXoFEK6YXbdBzplnansnGg7M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IAixdu0bVIA1QnB98rsodzrBA+2mwr0rX3JJDFeyQ9kfCg/ZYNWopDFyaPYgLBrJPvQNkk5hMh0heCd104SXLRNYLS8+RX6WryCVmmg7zxyrO5kop16ePardKy580lqwEPBbLWxd/UjWJ48n6MmAgbmdXHABASzWK9ALl1eiDNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7VlSr8A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7VlSr8A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785697699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BInnex2CUENRve7TOZngJ+kLiWL4JajzKi2RPRW31mY=;
	b=G7VlSr8AW9lRNIn4I29rJfdC3Nt/0P4Dca/PVTu/ttcWzNjmqiHeFKbTdlI/tJKps0zbve
	3dRbyJzlestyZ1HCmdpOzDbVqp0Wcb7AUyxphrA81yc1bLpzxG7+mh9Kv8X1oOJfZL2GHm
	vjYn7y8GDfI6Da3JvFNPmT+mxZfKCOQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-4E2-JfsuNxiOUTyJHL7D4g-1; Sun, 02 Aug 2026 15:08:18 -0400
X-MC-Unique: 4E2-JfsuNxiOUTyJHL7D4g-1
X-Mimecast-MFC-AGG-ID: 4E2-JfsuNxiOUTyJHL7D4g_1785697697
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f6d70223dso2077555f8f.1
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 12:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785697697; x=1786302497;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BInnex2CUENRve7TOZngJ+kLiWL4JajzKi2RPRW31mY=;
        b=ajncW35mQlubMdyVZkms1lRbcu2E5iM9uOOO+X4mSIljG0/ymqdUAy3lGm5dUT5S3n
         BxqC567Zo93Gw+cuMOnQVS8ElxbPVsdfKwUZV4J6gBmrxCw8KT5ZAug38ol03lOjOIOU
         RNvU/TnjO1yBZ1M+MBPfBgr62Y0jguRNWxNjMz72fiFqmDxQwFe4ZN1Kc37CuXXuqj9M
         rKfwEvPIycW+3o9KgvJlmcXmXX9yjQ5WEbAVDLQpzBn0YDuwyVsgiFA+XSncg5e/+kOj
         UOnPCoM9itzoVWmDTaKuf6Ddbo+4cjz5NeHIMQQzrreOYk5LJhsrR51rp/4rTIAqT+Je
         3x3g==
X-Forwarded-Encrypted: i=1; AHgh+RoQVgXT7LHefO7YSnmuICCWOVhMlye5cUoXdVvs8VTd5N/VYMadRFGy1LJb3PG2m/zQq/OCoapbhnLAFRv3TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwL4KcBv7RNPpZ1lXbj2CDyrd3fnHlTk1rclVh473NlktMROjHS
	JeU6uJTY0AxlCMGNmb9vFYD+iF+RYtYnwaHwcc5mCan0Np+DR+AulXeroEa4oQWPtMESq+cG1so
	pSwVYRIdFgeY9ibOYcKyH6I9bfDYu3EygVIXXRaRGhXmTtZNvWr5p6vls7xgTc4Cwuuf9
X-Gm-Gg: AR+sD11u5jxSH+7og3oHKKLk54tbagkswiWFVofT1eDLTZuvbmS4uHaLZUV9DUbt4ES
	eD4Qm9f1C68GRbRK9I2evyJlsHu11/c4tC9nqG7tvLRgkhO9IXcyK8x3X9E4pZRh6KoBfhkdbE3
	MHA1Y2TzK86M59/LqoHFGm+YA/AyRg2gVv8Adx1pABWjLHGSrwncOvUdJmjYcUSFZEXhLDVRcWJ
	AnSPKg9cEmonla3rYS8bmXsWPjwSIpwkvphpgQF+lnl+axNbcgXudWT5oy2Do3F08jmLbkFIN0h
	pddx9HDElx3ywqOff4k0UXGKK7j7CSF3QJR2Sf0GHFLrCvbp/Ka5ZoCimMbu9KN0U8QlVPRx2lC
	RYkKA/eqAXqgASBTNRmoGsQ==
X-Received: by 2002:a5d:5e86:0:b0:47f:9461:7747 with SMTP id ffacd0b85a97d-47fd72c55camr18142611f8f.20.1785697697193;
        Sun, 02 Aug 2026 12:08:17 -0700 (PDT)
X-Received: by 2002:a5d:5e86:0:b0:47f:9461:7747 with SMTP id ffacd0b85a97d-47fd72c55camr18142566f8f.20.1785697696722;
        Sun, 02 Aug 2026 12:08:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4068fb7sm26795069f8f.0.2026.08.02.12.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 12:08:16 -0700 (PDT)
Date: Sun, 2 Aug 2026 15:08:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Abhin Parekadan Jose <abhinjoses@gmail.com>
Cc: jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] virtio_pci_modern: fix vp_reset() hang on
 unresponsive device
Message-ID: <20260802145944-mutt-send-email-mst@kernel.org>
References: <20260802174059.4082-1-abhinjoses@gmail.com>
 <20260802134443-mutt-send-email-mst@kernel.org>
 <am-MM4VLtULd3DNt@1c44f78ca37e>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <am-MM4VLtULd3DNt@1c44f78ca37e>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uBHCJoK9WMNPXDYbVs9z3wgHw7VKfu4skozbLAev5oE_1785697697
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 02, 2026 at 06:28:03PM +0000, Abhin Parekadan Jose wrote:
> On Sun, Aug 02, 2026 at 01:47:01PM -0400, Michael S. Tsirkin wrote:
> > On Sun, Aug 02, 2026 at 05:40:57PM +0000, Abhin Parekadan Jose wrote:
> > > While investigating a syzbot report of a WARN_ON_ONCE firing in
> > > virtio_dev_remove() [1],
> >
> >
> > And I responded to that syzbot report, and I quote:
> >
> > So it writes 0 into pci command, effectively killing the device,
> > and then is unhappy that the driver prints warnings?
> > Who thought it's a good idea? Why?
> 
> I was learning how to reproduce syzbot bugs when I found this
> issue by writing 0 to PCI_COMMAND to simulate an unresponsive
> device.

Yea I have no idea where does this syzbot "bug report"
come from. Poking at random at device registers is ... not
a very good idea.

> While doing that I noticed that echo 1 > /sys/../remove
> hung completely rather than just printing the warning. Since the
> device_status register lives in the virtio common config MMIO
> space and has defined values(based on the bits set) in the spec.
> I thought it made sense for virtio to detect this and handle it
> gracefully rather than spin forever, so I wrote up a small fix
> for that.
> 
> > > I found a related but more serious issue:
> > > vp_reset() in the modern virtio-pci transport can hang indefinitely
> > > if PCI_COMMAND memory-space decode is disabled while the device is
> > > bound (e.g. surprise removal, hardware fault, or -- as reproduced
> > > here -- a direct write to the PCI_COMMAND register). The status
> > > register poll loop has no way to distinguish "device still resetting"
> > > from "device unreachable," so it never terminates.
> > >
> > > Patch 1 adds a VIRTIO_STATUS_ERROR() check that recognizes an
> > > all-ones status read as invalid (per spec, bits 4-5 are reserved and
> > > can never legitimately be set) and warns once at the point the bad
> > > read actually happens.
> > >
> > > Patch 2 uses that check to break out of vp_reset()'s poll loop
> > > instead of spinning forever.
> >
> > Was all this including the cover letter written with ai assistance?
> > if yes pls disclose this.
> 
> Yes, I used AI assistance (Claude). The commit messages were written
> by me and then refined with AI for spelling and grammar; the cover
> letter was generated by Claude and reviewed by me.

I suggest limiting it to fixing spelling and grammar exclusively.  It
tends to do things like dramatize, e.g. "more serious issue", like it
did here.

> The code, testing,
> and debugging were done by me -- I reproduced the hang in QEMU,
> debugged to reach the hanging loop, and wrote the actual fix.
> 
> I should have disclosed this upfront. I'll do so in future
> submissions.
> 
> Do I need to add Assisted-by: Claude <claude-4-6-sonnet> to the
> commit messages?

    Assisted-by: Claude:claude-sonnet-4-6


> 
> P.S. This is my first kernel patch set.


Thanks, keep at it. Bonus points if you find a real fix for
issues raised in thread about surprise removal, see e.g. here
cover.1752094439.git.mst@redhat.com
but don't expect it to be easy.


-- 
MST

