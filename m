Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061AD28488F
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785695291; cv=none; b=fGmpXsStfEVoScH2cg4+ro3YXJk2vusD6PvK3cq627Vpo/VMdb/NjhlAffgAEJVVJnnlhckcA28IQUn2qx5EtZsgTIPBP+2+oXDEfdY1ABulCpBm3UcrwVYIkh/OL0e4K/KHQunRvMlIyV2uRY7iVHHExxtaGIJjH27L+WbCVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785695291; c=relaxed/simple;
	bh=7HXkHNgH9ELdrRlmACJ7C8pxByRbOLKaeRGZFPBUd1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfoaRWc5d29bKI2PlPvdpxMJwZGx/sT/wnSwarOVvaRKMNfOmLArLHe7ueX0w8hENCEdKyucOvbzf/NzTQjrGEStiitv7jfsohh5YhtM0EyHZlv1VdEBusc8eKKrBDalCZCHOpHIIK0tTdntW7JPblcLhX/CYsJGRtARXS+GPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXEAuOtO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXEAuOtO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-496b7622a83so8267235e9.2
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785695287; x=1786300087; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7HXkHNgH9ELdrRlmACJ7C8pxByRbOLKaeRGZFPBUd1k=;
        b=eXEAuOtOPet9pNSvbIBLcwdwT+DFqAE2SPoLKgppNoNSvIhqZqy+tDcH9fV/i3hRtA
         Uim76GsO3HktMJIQ3h9e5xZgbHTVcdR5//C2eYWi0GSt32g8+QYKY3IHfnL4On2hutil
         3odBp6OyCr/IehCZaYijevW4oNUL6ZSQGZjc9mvEAuGZg/FVbJrK9slpTNSXnT9VRSN8
         CUUryJHJJcDn3awxI/mBRP1B84y/8BIVK4i07ZDIk6r4u6KFRu70nIducXZVQFCGOpNe
         KhkHPLJPLTRNwB5ijXZjnRMS2hXs2F42fPrA/KKH6vVF4y3jiKHjZsOTcuRzf1sPUrTY
         Jg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785695287; x=1786300087;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HXkHNgH9ELdrRlmACJ7C8pxByRbOLKaeRGZFPBUd1k=;
        b=IWcw2xPrr/hRunIdZqwcyDRFAlyROSmbCoO85se92JdVUAsS+fuqFlcXKteUEHQ+8V
         o7XB2ulAs3s4BSv0vSpYVjKrLJp9q7hzPogrHx/qOHKBZudNBWKXhGWoZbWDJctdbASJ
         d8NPxSpJqqV/iBHDxo6UmxTpDOX2vaGEmUR6yPEfS8XvEbRy7iTK0ygt3+Tp88bCDxnt
         f+W/o3YWWnMcfrx+Uylgmq12y9MtzGE9vd3/Kg3fBxwLtXjcs/m5Hl/XLds00j8blf4E
         aDq2gDbvR1ysqbd+VjhpbyC+FHMvxjnEzSIUTN29O5y252u8N9zLE8VszuDc530a9r/9
         7cAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2aWrnjtSSMLYtnRbWrCdcqLr1x8xBatzuwQeHth1EA2IsV7XG8irdGYCHD3bV55hCOcbfXRI2zpVWhUjzwA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1XYWAsx+ovoY2/c0FYEmGbvYreOP6+j5cp6d4SvtEkjfNiIm1
	1h3tQBJdvzDP4uatmnUSPruvamGrySpm+ZMIMfiFmof8mynS9c502CgT7fwsQS8w
X-Gm-Gg: AR+sD11GYlGykVR4xqBD/VUQvm1NWJeO8npb6xs9d+d8QaBeEYPllxiVo8iZWX78Rh1
	BTu2Y1G23AHr72XH7MskP7V1NzylScpAhDcUsGWy1A81TuDGKysoSnnIeJNNk/ImAAxhiZuSbPm
	ORne86YSPFEwI3Ck4Eg5DZffMhsUjZ+jz3ZoGVvMdcZ6CLbVnAAjAfs1Oq+Nxk5t+MrjR+OGSVZ
	TktpTQJjp66nZw0hp76XILbTBuc6go0mzg5BC3oj1CCvZhE79o/Jjl4V4VaCLGomdRZDEstr1v4
	I6jaD44YvbjCIOqrmISz4hoGZY9E4/8o3CrrCXklqnylchKx4/LX/tbWawei3+EwtXtWXKjfbfD
	cnSDpKSfVMqOrHwXjHpr89nej9e/w5bFi5u/ijLyVFVxiRnDsF/D3xEEVScd8ZEhhyS1CpLlwMv
	9p9vWszsZfiydLNmzMACUX2j5jCK3ARFqi9JCRWaPITVYLZYXjWxXmIGK/5sMXn/ZpfmRApfZbu
	IS9xceXMWhBg2CHZ27wjtOK8IvH2Nx+KcwrQVG2bU5bSAWMNqep3g==
X-Received: by 2002:a05:600c:54c8:b0:495:7285:a498 with SMTP id 5b1f17b1804b1-4980c693094mr110821335e9.18.1785695286714;
        Sun, 02 Aug 2026 11:28:06 -0700 (PDT)
Received: from 1c44f78ca37e (dynamic-002-214-008-136.2.214.pool.telefonica.de. [2.214.8.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498081a12a3sm229546405e9.8.2026.08.02.11.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 11:28:06 -0700 (PDT)
Date: Sun, 2 Aug 2026 18:28:03 +0000
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] virtio_pci_modern: fix vp_reset() hang on
 unresponsive device
Message-ID: <am-MM4VLtULd3DNt@1c44f78ca37e>
References: <20260802174059.4082-1-abhinjoses@gmail.com>
 <20260802134443-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802134443-mutt-send-email-mst@kernel.org>

On Sun, Aug 02, 2026 at 01:47:01PM -0400, Michael S. Tsirkin wrote:
> On Sun, Aug 02, 2026 at 05:40:57PM +0000, Abhin Parekadan Jose wrote:
> > While investigating a syzbot report of a WARN_ON_ONCE firing in
> > virtio_dev_remove() [1],
>
>
> And I responded to that syzbot report, and I quote:
>
> So it writes 0 into pci command, effectively killing the device,
> and then is unhappy that the driver prints warnings?
> Who thought it's a good idea? Why?

I was learning how to reproduce syzbot bugs when I found this
issue by writing 0 to PCI_COMMAND to simulate an unresponsive
device. While doing that I noticed that echo 1 > /sys/../remove
hung completely rather than just printing the warning. Since the
device_status register lives in the virtio common config MMIO
space and has defined values(based on the bits set) in the spec.
I thought it made sense for virtio to detect this and handle it
gracefully rather than spin forever, so I wrote up a small fix
for that.

> > I found a related but more serious issue:
> > vp_reset() in the modern virtio-pci transport can hang indefinitely
> > if PCI_COMMAND memory-space decode is disabled while the device is
> > bound (e.g. surprise removal, hardware fault, or -- as reproduced
> > here -- a direct write to the PCI_COMMAND register). The status
> > register poll loop has no way to distinguish "device still resetting"
> > from "device unreachable," so it never terminates.
> >
> > Patch 1 adds a VIRTIO_STATUS_ERROR() check that recognizes an
> > all-ones status read as invalid (per spec, bits 4-5 are reserved and
> > can never legitimately be set) and warns once at the point the bad
> > read actually happens.
> >
> > Patch 2 uses that check to break out of vp_reset()'s poll loop
> > instead of spinning forever.
>
> Was all this including the cover letter written with ai assistance?
> if yes pls disclose this.

Yes, I used AI assistance (Claude). The commit messages were written
by me and then refined with AI for spelling and grammar; the cover
letter was generated by Claude and reviewed by me. The code, testing,
and debugging were done by me -- I reproduced the hang in QEMU,
debugged to reach the hanging loop, and wrote the actual fix.

I should have disclosed this upfront. I'll do so in future
submissions.

Do I need to add Assisted-by: Claude <claude-4-6-sonnet> to the
commit messages?

P.S. This is my first kernel patch set.
