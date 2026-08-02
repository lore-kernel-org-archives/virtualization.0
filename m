Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A02B331222
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785700474; cv=none; b=EjzLWcgovugRjo73ByzQMLymlxwiP840c5InU7GYq6d51VB53Bom7VjnAC4SzyDLzXCxafg93KclL2yp3w4Lff/coi2k47KFI+hFCbkIi/1BtIsfd29/r8CwHdZrOI6HFtWw8uSNkl4Wl+CotuFyFQJI6jiLguTbPFSH3CJa4BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785700474; c=relaxed/simple;
	bh=ehK5JhoQna7+Uy0Gif3hJvuLiOiFhkY/+8zP8o4ZtQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PfHz7X0atmyr7wrM/y3kM4JOvGBgK03UZP7WK78khj3uGFhbzacfr4wtCHrgkbXDz/4Ayl6GI6XimILkJHLtIfTBcjG2ew3LeYJ7fMBBCnebKCcTN5DxmdM+BGLwk0VCFhkcKmmgnrX6NcL/z/D0vnVpga3mSg8WPZGGNAhuXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VS20jYND; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VS20jYND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785700471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xjP8Nj5ayArKITQglbdxDINIj5XZHeMrEUA74eJ1q04=;
	b=VS20jYNDU1UbQdtu0FIW7pUv+gZBGx4JQAi+3aBB1Tvq+hXweZGjPazl+avBbFo/Yg2BOJ
	axGIgDiiXBzJ5FLmB6tuTSWEi8fBt16tJdFuQ4oPph+cnREUG5oduTf3FIQpc29lDWAeQw
	OeD/2Q1lpwlQFOVftrZXSj69V3TJIjM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-AY31xcikMOmFm_d3IVW8Hw-1; Sun, 02 Aug 2026 15:54:29 -0400
X-MC-Unique: AY31xcikMOmFm_d3IVW8Hw-1
X-Mimecast-MFC-AGG-ID: AY31xcikMOmFm_d3IVW8Hw_1785700469
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49545071724so14498625e9.0
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 12:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785700468; x=1786305268;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xjP8Nj5ayArKITQglbdxDINIj5XZHeMrEUA74eJ1q04=;
        b=VaV7Kl1BcE8Saig9GbvXSWSnw3pi/E3GNrKCLonKq5Wvnf9SnFzjKd4HMj4fGNlZNq
         HRuc8SMfrBpY7SmsvDn138VHr7hPdfy7yvgjWNIy/m2MusDG9+i5wp/8Y7wsYWpZV7j3
         FoapNdxA7nT14BPJeOE9GAT/2f8dQUAoJ/GK0kgXpf9oLWPEEp5D3mQwla8h9dLN04Mi
         aglUakSdpeHj3puU2FDwXRxj9hTx54Nr6SDunxJe+W0mH0q6854tLlQZG+LcPevYb9p0
         Xuy/ilVXxCo2vP5w38Eq5U3fITLyXB/GFNOMasUC7sDZBkIEVw2ub1ozdoPp8VRSNHdh
         nRsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2zDlQFrCLnvRnpfZGv0zJ6z0kAv3YbP6bSX+Vy1Fcnkbo25to8CQTINl/NlT3u1fAcWtHOj9D5Nb+hX1cGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCQAvefzaHoRqrp0G96VFNuJSCTyuLY31A4MzhumAwSA0btvac
	EivHuabZpsuz/8nJo2GIYC53+3rcloxUXUMaNK5zMSCC5Ovlasdou+tZwq90wdGCwEH71+7lRTC
	jz3v4ZOtixc8TQnScYhdtaVjP2PvTbkJn32MiLytv6Ll+vcC5f3AOBAHmhTWjfEqsq3yu
X-Gm-Gg: AR+sD11Late6+sfkKi9yABIDJmAP6s/XiOaGog2YuTzGrBtNFQ20YU0pcorQPBEQKkF
	jCIdUXaWhWfoyUtObnwMs1Y0WOXVzMlqzTF9UgQW7g4kx6P5Fls1wvETmh2m+VRSjcczy7wzU/N
	CJ0iLHz+VrOAjSwXSSur/8pSx4ShD/Eu9WDmUjf5ebcMqsHYecG0cSyNjiPBWafzpSKPBRFlc3i
	TcovJmhQwdZdcre+fufMLp3Wqs0zGGKcz5XLl04vNVJG+5DQaKNA06qle0T9PW8IdqhImGcj1ZG
	5LHlEPk0BIQJtP7NQ2RwR4TK7pl642RIhahheq5JnM2s0sUceCAEck7Zkm6COJ+yMQnKQoVOllz
	Ey4TOBZTGybFJ/u06ITIOJg==
X-Received: by 2002:a05:600c:8b33:b0:495:779a:ed33 with SMTP id 5b1f17b1804b1-4980c66c798mr174723815e9.7.1785700468591;
        Sun, 02 Aug 2026 12:54:28 -0700 (PDT)
X-Received: by 2002:a05:600c:8b33:b0:495:779a:ed33 with SMTP id 5b1f17b1804b1-4980c66c798mr174723515e9.7.1785700468061;
        Sun, 02 Aug 2026 12:54:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b21e66sm144240835e9.0.2026.08.02.12.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 12:54:27 -0700 (PDT)
Date: Sun, 2 Aug 2026 15:54:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Abhin Parekadan Jose <abhinjoses@gmail.com>
Cc: jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] virtio_pci_modern: fix vp_reset() hang on
 unresponsive device
Message-ID: <20260802155133-mutt-send-email-mst@kernel.org>
References: <20260802174059.4082-1-abhinjoses@gmail.com>
 <20260802134443-mutt-send-email-mst@kernel.org>
 <am-MM4VLtULd3DNt@1c44f78ca37e>
 <20260802145944-mutt-send-email-mst@kernel.org>
 <am-fCnOibXGuW0JG@home-linux>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <am-fCnOibXGuW0JG@home-linux>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jp_p_MWzfGX6xksIWrCfRBAoCFEIkW5c_wL76uOY-4g_1785700469
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 02, 2026 at 09:48:26PM +0200, Abhin Parekadan Jose wrote:
> On Sun, Aug 02, 2026 at 03:08:12PM -0400, Michael S. Tsirkin wrote:
> > On Sun, Aug 02, 2026 at 06:28:03PM +0000, Abhin Parekadan Jose wrote:
> > > On Sun, Aug 02, 2026 at 01:47:01PM -0400, Michael S. Tsirkin wrote:
> > > > On Sun, Aug 02, 2026 at 05:40:57PM +0000, Abhin Parekadan Jose wrote:
> > > > > While investigating a syzbot report of a WARN_ON_ONCE firing in
> > > > > virtio_dev_remove() [1],
> > > >
> > > >
> > > > And I responded to that syzbot report, and I quote:
> > > >
> > > > So it writes 0 into pci command, effectively killing the device,
> > > > and then is unhappy that the driver prints warnings?
> > > > Who thought it's a good idea? Why?
> > > 
> > > I was learning how to reproduce syzbot bugs when I found this
> > > issue by writing 0 to PCI_COMMAND to simulate an unresponsive
> > > device.
> > 
> > Yea I have no idea where does this syzbot "bug report"
> > come from. Poking at random at device registers is ... not
> > a very good idea.
> > 
> > > While doing that I noticed that echo 1 > /sys/../remove
> > > hung completely rather than just printing the warning. Since the
> > > device_status register lives in the virtio common config MMIO
> > > space and has defined values(based on the bits set) in the spec.
> > > I thought it made sense for virtio to detect this and handle it
> > > gracefully rather than spin forever, so I wrote up a small fix
> > > for that.
> > > 
> > > > > I found a related but more serious issue:
> > > > > vp_reset() in the modern virtio-pci transport can hang indefinitely
> > > > > if PCI_COMMAND memory-space decode is disabled while the device is
> > > > > bound (e.g. surprise removal, hardware fault, or -- as reproduced
> > > > > here -- a direct write to the PCI_COMMAND register). The status
> > > > > register poll loop has no way to distinguish "device still resetting"
> > > > > from "device unreachable," so it never terminates.
> > > > >
> > > > > Patch 1 adds a VIRTIO_STATUS_ERROR() check that recognizes an
> > > > > all-ones status read as invalid (per spec, bits 4-5 are reserved and
> > > > > can never legitimately be set) and warns once at the point the bad
> > > > > read actually happens.
> > > > >
> > > > > Patch 2 uses that check to break out of vp_reset()'s poll loop
> > > > > instead of spinning forever.
> > > >
> > > > Was all this including the cover letter written with ai assistance?
> > > > if yes pls disclose this.
> > > 
> > > Yes, I used AI assistance (Claude). The commit messages were written
> > > by me and then refined with AI for spelling and grammar; the cover
> > > letter was generated by Claude and reviewed by me.
> > 
> > I suggest limiting it to fixing spelling and grammar exclusively.  It
> > tends to do things like dramatize, e.g. "more serious issue", like it
> > did here.
> > 
> > > The code, testing,
> > > and debugging were done by me -- I reproduced the hang in QEMU,
> > > debugged to reach the hanging loop, and wrote the actual fix.
> > > 
> > > I should have disclosed this upfront. I'll do so in future
> > > submissions.
> > > 
> > > Do I need to add Assisted-by: Claude <claude-4-6-sonnet> to the
> > > commit messages?
> > 
> >     Assisted-by: Claude:claude-sonnet-4-6
> > 
> > 
> > > 
> > > P.S. This is my first kernel patch set.
> > 
> > 
> > Thanks, keep at it. Bonus points if you find a real fix for
> > issues raised in thread about surprise removal, see e.g. here
> > cover.1752094439.git.mst@redhat.com
> > but don't expect it to be easy.
> > 
> 
> That looks interesting (haven't gone through in detail but got a gist of it).
> I'll try it out and make suggestions if I find a good solution.
> 
> As for the current patch set, does it make sense to drop macro
> `VIRTIO_STATUS_ERROR` and use `PCI_POSSIBLE_ERROR` to break out of the loop,
> I could test it by actually doing a surprise removal on qemu via the monitor
> or just drop this patch set

I'd drop this, I'm not interested in working around one source of hangs
if others in the same exact path remain unfixable.

> and try on cover.1752094439.git.mst@redhat.com patch set?

it's not a question of "trying it on" it's a question of the fact that
the pci core serializes probe/removal events so a driver inside
probe/remove never sees the removal event. in this instance it
is polling so it can check (at the cost of adding cpu overhead,
mostly for nothing) but in most places it can't, we need the event
to reach it.

> > -- 
> > MST
> > 

