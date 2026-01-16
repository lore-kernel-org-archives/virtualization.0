Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244D2517AA
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768543150; cv=none; b=VWtFr42D/IJCTmxjosMvCXnK0IAAwyxGbk9corSRImRhn631E1fPlmAKbAYhl0Bx9SAX7aSqZcXE5EH5a7aFZnCQgHJbCElBMSFgs4dDyGtyyUZQiudKlpBSht+S2+wNz03XyqGG+AOOOuFF53EpGHZKj/LnufjqZ0DW8pbcFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768543150; c=relaxed/simple;
	bh=gMXjxkRiCG6bc5xzkGJLJJ77xyt0l3ekz9zNbGesmC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCcuuO6yIEXwngIUwNuq2WxppQac6vCpYXZmnM4Vc44kXJbLd77AlHZq541WFmG8T95u170Db5IAFSD3c8pypljUCe9hLoRjeXUQoHIVeGGVskNxsblwLQB0hWIG6P9y3fBCQBP6s0FQ3phJ/O2u0BNZ0XyPI4CSfydH1TEc9WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNQh6rCM; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNQh6rCM"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso2539879a12.3
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 21:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768543148; x=1769147948; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gMXjxkRiCG6bc5xzkGJLJJ77xyt0l3ekz9zNbGesmC4=;
        b=KNQh6rCMzTm5maCTxZbuChesWzk6Tkda4XYyONUyjPNglp9f/ZANxKS/HBVvOAv0qH
         nN36ta3yoagwBD8bIi+ZkzMuM7bQCy/EUFTsD5I9dvEGYVt+a3mSjKRIHGAfLFl4HbTu
         IV+ZR3qxejg+mocc/BUX2Nl1cRtIBO+vPYyqwViZEARkN0D/hFN8VICV0o6PZTVN18Cp
         IdYalCbdpv9LqwkwB9j2fEriiPrvAnGRnRehKdPd90qgpdCxky2/Q54kvzPt4qMX6HBF
         MUp8qbcMr54wquEQ3XrNCyLBofOfnCHTdi3YlRSgl/LaIo9o6SQKLcNnMbLI+SKZPv0C
         AWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768543148; x=1769147948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMXjxkRiCG6bc5xzkGJLJJ77xyt0l3ekz9zNbGesmC4=;
        b=qcTrtSZ80vfUgXzFYjAhGPL6jS5KaR0WGhD11+Jjk97Phh3Xh49hHJjyVFrU6fGxFP
         f4XAbl2M+1HBJuciViIgGELEQd7isnDBF7DRoxI8wI1turxYM/yl5sZ/0U1Ln/WFYWIq
         B3HxenehOFmXPwz9/Tn6CeTqYYIs869DQhaNBYtzz5rg1XhjWYjYGzjpTKwpF+jW1bIU
         BTez6vEoTabjW7aj13EgHWRh7KdgbkYnH46rvkvP+GPCcxxKFcmsM+UTzarOueewk5Tc
         1YazZLEZeJyaZRIGJ4Xl8aPcm34g+legiK8OK+1KkJ6NIZah238BWi6QhNRO6DA8xux8
         n6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXKC/wyGfQbKGuAM7XDfbQ76zSF1R/whuKLiFCR7CW3vXIFRWNn/qXmIZlvrkzvXY88/pdkV7/cpOB9YnYyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGhhCmjQeTRfN++kMo4Jpu5vAmPFYeSfkxtCEjNlWkEI/JAW13
	OP1NsOdBWCSDhkdT09g+BG/4lPD/U3X94ijGb1k6ipWxAB/vRS8f1dc2iMyk8T7NgI0VheyXIwL
	p9iMPXgQ7fg+/NUBDilcMc40ZiIRE+sg=
X-Gm-Gg: AY/fxX6F8yhZ+77kq/PnNHVDwsfPhBLqExSQJaJwhz2tDBxsFDlTlZRaRT+Z/hF+3PM
	Vd7eHGkuBilWha/frH1+Wv2TiuaQ7XY5cNhzA4QZOgopdOaVoskN5R9bsQ3CuA3ah6Wl1cLxQuY
	FqAEvZnI6hT6lEGhWNTItGj9oGYT/6vZrRhgEZ2CLRZBdrK72SbGF6rkhAZMh3NyC+V+nW8p0wv
	igTj3pEF9A4D9VLhsj9MPBQeArsp/aKKbTOoHYIHkez/yLJc56T9UvuUrH6QBuHahdFECpk6/Ub
	yvi69HoRJOZEZX5LFDFmpJjxfc8=
X-Received: by 2002:a05:6402:1d52:b0:650:863d:3df0 with SMTP id
 4fb4d7f45d1cf-65452ce4e7bmr1441098a12.33.1768543147392; Thu, 15 Jan 2026
 21:59:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
In-Reply-To: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Fri, 16 Jan 2026 11:28:47 +0530
X-Gm-Features: AZwV_QjOfAkZ2vUXIm-6kMTxgl6VawOaDwLVmNCBjmyYhioWn1jf-eouDtywdF4
Message-ID: <CAPrAcgNhpK-cOVenrtw+-t9CV7bb6V+4b-R=_0m9Tv0C7U0ecw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/6] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: edumazet@google.com, horms@kernel.org, sdf@fomichev.me, kuba@kernel.org, 
	andrew+netdev@lunn.ch, pabeni@redhat.com, jasowang@redhat.com, 
	eperezma@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, 
	ronak.doshi@broadcom.com, pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com, intel-wired-lan@lists.osuosl.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1:

> If netif_alloc_rx_mode_ctx() succeeds but ndo_open() subsequently fails,
does this leak the rx_mode_ctx allocation? The error path only clears
__LINK_STATE_START but does not appear to free the rx_mode_ctx. (Yes,
There is a leak)
> Would it make sense to add netif_free_rx_mode_ctx(dev) to the error path,
or perhaps check if dev->rx_mode_ctx is already allocated before calling
netif_alloc_rx_mode_ctx()?

This framework should accommodate future ndo s requiring deferred work.
Therefore, the best course of action would be to schedule the cleanup
work. If we reuse it, we would have a memory leak in case __dev_open
never succeeds as the cleanup is in __dev_close_many

Does it make sense to move

+ if (!ret && dev->needs_cleanup_work) {
+ if (!dev->cleanup_work)
+ ret = netif_alloc_cleanup_work(dev);
+ else
+ flush_work(&dev->cleanup_work->work);
+ }
+
+ if (!ret && ops->ndo_write_rx_mode)
+ ret = netif_alloc_rx_mode_ctx(dev);
+
to a new function netif_alloc_deferred_ctx() and rename
netif_cleanup_work_fn() to netif_free_deferred_ctx()?

Patch 3:

First of all, Does it make sense to call e1000_set_rx_mode when the
netif is down?

Second of all, I am not dealing with the cases where I/O should be
illegal but the netif is still up correctly.
For this, I am thinking of adding netif_enable_deferred_ctx() and
netif_disable_deferred_ctx()

netif_disable_deferred_ctx() will be called in the PM suspend
callbacks and in the PCI shutdown callback while
netif_enable_deferred_ctx() will be called in the PM resume callbacks.

I know this will be a lot of work but this is a one time thing that
other deferred work ndo s can use for free.

Correct me if I have missed any cases.

Patch 6:

This was stupid on my part. I will add back netif_wake_queue(dev) in
the next version.
