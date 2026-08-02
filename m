Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359DE2561A7
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785700112; cv=none; b=GlhYRQ4zaT0QNDgvrdkzYZDVqI0z87zcvTDNMtz4cTysgBMkAms2ne0732y4x0J8qC42V463TMP2RvqRx+KyHXXO/qC1bylS0eX5A5LLyR949o37cOWzBl9RUU0ROPxZmrEDoRN5N6Uuh/e6m2Fhxhd0fJldjK31czpZ9A0HDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785700112; c=relaxed/simple;
	bh=LkBm8EG2uZavCvEVbOADDIQOY5+xUftLQcPsVAGPXO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCCyqSs0vQ/+V38bxwxduT9zqInBn3Kf/tMAQGhAtL8aL+F0x4Uxlcx7cPw2OeQ3ckIUCmW/EBLF3GYZHzHwrR79X1lZL+NT7lCTYobUbJSzPfgSTomzzVFGJBLupKRHrXsYzhDduu46BmAhUx+0SzUHEjszzNQ/m6Ibi0IL744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3kw/MUh; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3kw/MUh"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f904e80eeso2488448f8f.1
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785700109; x=1786304909; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I8QMn2ksXm3uoxHvww2d4cky/knVUFaCbpvrqdsZVhI=;
        b=V3kw/MUhOKt4peCsOQQzCDhqZlOWfdW/2V+jJY0M+lqm1BLws8NCBm6ihgrBZnorLT
         dJi4Bg7AMvA/D/7uxcOkNoUrgUt93A3k1K+T0Nve0wD0o+Xvf0ztA9c7ieDMSh3zPQ9j
         pyMeDMb3kenX/oMURaciZfqGcjZvD5fT/MLv56C5sSwKeN8PONQP7f517iB8lB/9b97g
         cFO7qYY26e4BKRIKj7tE2ElL8qHKhDLvxr6MsqNxOV+AkkN8/AFs5iHCRb36SqpSuIyG
         gsTBLnZOOD/0eIAEfeYXuUZAkWf9wNmXXpUG3peAVado/AUL1ip6mW7H1iFcwztleYs2
         52ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785700109; x=1786304909;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8QMn2ksXm3uoxHvww2d4cky/knVUFaCbpvrqdsZVhI=;
        b=P72w883s78CZGRSnXIKCAaGkDB8UDaxFi5di94RNutoS0XpYL7L0isBF65X8awS6zP
         7N/HYbaMHNEo0L9TNTF+j7PYhd7qFYPcxt9AEHEYtJZ9tGUqHwrKgQZoY2fv0NNhu+Hm
         bMA+N2vdVLo1gHe1h6UIMHTeR6fa1e8w8X0XTUtksLu/8ckejSL9Ukt9BetiU0y1zYTW
         eBRjhce/FxnFeTsR0XzgQIgV/2PWjUsbjC5wIHbtSpNsHHUQda7TNnJwsy//+5XU9g2o
         D5KctV/eU4aYGpwX/N9jODQJElSg0/h3hCbR+tAIMfwL9FkCz3/5U0PgOJg/hEspRGva
         Xdtw==
X-Forwarded-Encrypted: i=1; AHgh+RoJP7ilyo5BST1p/LjQtXvIVLv8GHnUBAMhGf7L/R8DBA0zbzldHp9EcqLmkvVIT3zXeUEnmJ8KjOi/20eU2w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7dD3JtlKOSM2mh+PNNERlhiEMNavzw+4SayB9v24SdYqR0t33
	ZyduOYrQb6WwjbfOQ8SWZ+F+MbLBtSRsqVK+n5B2BkgwQ1PKLx8uQv8D
X-Gm-Gg: AR+sD10IOdVMSd0/w/wQIXTu7NkQf8g/0ZQmJK968BsaAX9OiUF1N1EqphHv8KN5Ixa
	yJqKZv9gMQKEwT31JWmAORu09KysxDi+4AbwvwXxZaLBoneq6wqoVVhGzedelscjdadteE928td
	7QdOHtWh/CIRvqBNGHsfENNajeJgAW/TpXi87lUi+uxQ7ggZc00O6Mm9hjJZjRVhrwdsvT4pLiF
	yjXK6V/baINYN43JRRsg1c2/Un+0pWPuDec9pLxU2u6s54UVmQupGAphMyOXv07lqlkohG1I2m4
	JKdMZVMW8dJLLCKa0PIwbCDM4JybmQXnwhb74o9DE6vpP9FXLuYM6uHvEP56nd2X6yVcyPE2c9f
	ieFLzGsUm6I4jRynYKkJlMxp6AJUfvX94z+yacMDLp4Ns85Sv1Dk6ecr3DiRrCx+b5WguKoCB8A
	wqiXAM7zq8xpx5qrh6eafQYdXjUDLxW2HM66hIDZjMcX3PeG2+7nJgGDlpgu3rvAE07OuSOSzmB
	NsW8GBcWJhjjJ32yX4IlSBw4ai4hUhMjB17CheIcpqDoHE2H9M3XzSglERoJFXljdfhNue5M2t2
	Kg==
X-Received: by 2002:a05:6000:2087:b0:47d:ea8a:d211 with SMTP id ffacd0b85a97d-47fd9f93ed8mr15437528f8f.29.1785700109211;
        Sun, 02 Aug 2026 12:48:29 -0700 (PDT)
Received: from home-linux (dynamic-2a02-3102-44b4-cc00-3af3-abff-fe75-d5da.310.pool.telefonica.de. [2a02:3102:44b4:cc00:3af3:abff:fe75:d5da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45895b6sm26428310f8f.26.2026.08.02.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 12:48:28 -0700 (PDT)
Date: Sun, 2 Aug 2026 21:48:26 +0200
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] virtio_pci_modern: fix vp_reset() hang on
 unresponsive device
Message-ID: <am-fCnOibXGuW0JG@home-linux>
References: <20260802174059.4082-1-abhinjoses@gmail.com>
 <20260802134443-mutt-send-email-mst@kernel.org>
 <am-MM4VLtULd3DNt@1c44f78ca37e>
 <20260802145944-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802145944-mutt-send-email-mst@kernel.org>

On Sun, Aug 02, 2026 at 03:08:12PM -0400, Michael S. Tsirkin wrote:
> On Sun, Aug 02, 2026 at 06:28:03PM +0000, Abhin Parekadan Jose wrote:
> > On Sun, Aug 02, 2026 at 01:47:01PM -0400, Michael S. Tsirkin wrote:
> > > On Sun, Aug 02, 2026 at 05:40:57PM +0000, Abhin Parekadan Jose wrote:
> > > > While investigating a syzbot report of a WARN_ON_ONCE firing in
> > > > virtio_dev_remove() [1],
> > >
> > >
> > > And I responded to that syzbot report, and I quote:
> > >
> > > So it writes 0 into pci command, effectively killing the device,
> > > and then is unhappy that the driver prints warnings?
> > > Who thought it's a good idea? Why?
> > 
> > I was learning how to reproduce syzbot bugs when I found this
> > issue by writing 0 to PCI_COMMAND to simulate an unresponsive
> > device.
> 
> Yea I have no idea where does this syzbot "bug report"
> come from. Poking at random at device registers is ... not
> a very good idea.
> 
> > While doing that I noticed that echo 1 > /sys/../remove
> > hung completely rather than just printing the warning. Since the
> > device_status register lives in the virtio common config MMIO
> > space and has defined values(based on the bits set) in the spec.
> > I thought it made sense for virtio to detect this and handle it
> > gracefully rather than spin forever, so I wrote up a small fix
> > for that.
> > 
> > > > I found a related but more serious issue:
> > > > vp_reset() in the modern virtio-pci transport can hang indefinitely
> > > > if PCI_COMMAND memory-space decode is disabled while the device is
> > > > bound (e.g. surprise removal, hardware fault, or -- as reproduced
> > > > here -- a direct write to the PCI_COMMAND register). The status
> > > > register poll loop has no way to distinguish "device still resetting"
> > > > from "device unreachable," so it never terminates.
> > > >
> > > > Patch 1 adds a VIRTIO_STATUS_ERROR() check that recognizes an
> > > > all-ones status read as invalid (per spec, bits 4-5 are reserved and
> > > > can never legitimately be set) and warns once at the point the bad
> > > > read actually happens.
> > > >
> > > > Patch 2 uses that check to break out of vp_reset()'s poll loop
> > > > instead of spinning forever.
> > >
> > > Was all this including the cover letter written with ai assistance?
> > > if yes pls disclose this.
> > 
> > Yes, I used AI assistance (Claude). The commit messages were written
> > by me and then refined with AI for spelling and grammar; the cover
> > letter was generated by Claude and reviewed by me.
> 
> I suggest limiting it to fixing spelling and grammar exclusively.  It
> tends to do things like dramatize, e.g. "more serious issue", like it
> did here.
> 
> > The code, testing,
> > and debugging were done by me -- I reproduced the hang in QEMU,
> > debugged to reach the hanging loop, and wrote the actual fix.
> > 
> > I should have disclosed this upfront. I'll do so in future
> > submissions.
> > 
> > Do I need to add Assisted-by: Claude <claude-4-6-sonnet> to the
> > commit messages?
> 
>     Assisted-by: Claude:claude-sonnet-4-6
> 
> 
> > 
> > P.S. This is my first kernel patch set.
> 
> 
> Thanks, keep at it. Bonus points if you find a real fix for
> issues raised in thread about surprise removal, see e.g. here
> cover.1752094439.git.mst@redhat.com
> but don't expect it to be easy.
> 

That looks interesting (haven't gone through in detail but got a gist of it).
I'll try it out and make suggestions if I find a good solution.

As for the current patch set, does it make sense to drop macro
`VIRTIO_STATUS_ERROR` and use `PCI_POSSIBLE_ERROR` to break out of the loop,
I could test it by actually doing a surprise removal on qemu via the monitor
or just drop this patch set and try on cover.1752094439.git.mst@redhat.com patch set?

> -- 
> MST
> 
