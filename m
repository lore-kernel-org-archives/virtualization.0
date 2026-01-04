Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E9A2D5940
	for <virtualization@lists.linux.dev>; Sun,  4 Jan 2026 05:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767504551; cv=none; b=FHHZKkKho9l9QhBaj7AGacmF1JyMb3bmYCT/7q9K84LfuuqGq+DGBD71RX2FEFWzpnNkivJHcF7ea6/v3vEiowm0GXWWWzhNm6x8YyR8438zk6XNx8tukm+6QNFX8hoxpOaDWk4fT9kok4YGuIlABt0aRkRaVudhLA2Ss31h+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767504551; c=relaxed/simple;
	bh=65vgSVMqf/BQy1Yp33ggrUZQR1FCpsrPR3lKZwoF6e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZKULY/4XJJ61ZIl89Phz1AEV1ARNixmQjE9ibAs23QCxUgczyjpQaa6qZJtTdwI3USb7ogdGyRtpMVmKuP02USvtepp3sWa0yRB8do4Ne6834i2i+W+n4rHGQyrByNX0m2zER7LUB8WrlXwxHPwHyDOlRcbM9RyS4OCh2/kDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB8eF+04; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB8eF+04"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-121b251438eso1418160c88.0
        for <virtualization@lists.linux.dev>; Sat, 03 Jan 2026 21:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767504548; x=1768109348; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nvOkP8SZJigPzeyYaj+yZhhAkS0A2aAjhXuUNUZVL+k=;
        b=YB8eF+04xxQ7kOjVvxHclaLuw+s5UmQztcR5uh4yi9HTVNlBT0AfQa7Sllh83tPuVh
         XHv6VEj9siBk1eL+4C++l23ZJ7VnihtMM9xUhCAzoKRgJpSMRq0tpYHRJciFIH2liAwO
         JYOYt38vJUENoPaODuSIZkGNoj3MEHCfRyNf/xjisgblpdZxYtOepIFr8AYXA9sUDo42
         RzyY6XlLZCWrZHJRqv091zqgAGbnin7iY/IFb4PmW607RYW/l5TkQPhUTCQqWTOK89HB
         3MgZM/9JMMobMTM0W34BoDrSakOG8e3mNZTIyWIOr8T1B0v+WsN+8l8AON3QerGrYZCP
         157A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767504548; x=1768109348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvOkP8SZJigPzeyYaj+yZhhAkS0A2aAjhXuUNUZVL+k=;
        b=BpaYDUX1Hw3N9PWpMO/vTugFpx7LeU7pLgjyNkNtEyaXGFp5snobYM/zOi4O6FF0na
         vpJbAzYXlRjq6LAXRjr3kv1Sph1S787kj0kmTlpS7KcRutzCU4Yl9ZmO9sJcMPdnlhfI
         3SdJ0S/KqJh9sZ8dbVY/3qKLZcFEDOFFrnLnriF4xJmEjsMmTqqyUvSo3hUCn1agtyUr
         sUhtTeY1KSb0qmSw15slaRI+iKFKjz89sM8IX16jCmU9J9XoxUCYveR+yvGYerpxU1SK
         pFJrKeHGnNTWcvCQVDNPixGvTZtfIsOt0TTF/Ww/ud3W/uZheDZjtkUUv+sCo9RR0t8q
         TlhA==
X-Forwarded-Encrypted: i=1; AJvYcCV93fhiMEH1byp6b8q8SkHAXY658I94g9rXvjXBL/bldgJMsr7dGy9oruqTWn3Q7/DzLRkO3O6FlB3T8fQFew==@lists.linux.dev
X-Gm-Message-State: AOJu0YzobBMBUWgqyMgY+sN/NtPJDwqVfrZ4RSeOfv5pUzGsWmn8NrMN
	RpMaDjnZfBkZTOJf11OIenShO1dzzThfi3q7mG4G1dLk3mJrgc9HRS5r
X-Gm-Gg: AY/fxX4FaNvolvtNFOONha6p3GFiTc/Y8wsf7MPF+zQlX6shQmBiQ0wV15+oOfGT7HZ
	Vjuu3mnmZBe1hJQ72Ja1JQuZKBPitRb4Rg/iSXdeELX/DVz4O4/FJrMUr2Yy7wvF+79zTSoTE4b
	nRctmdX/CMdYmeF6H4zjq4dqzAD67P5WSDBgk5TVbLoxyTat9FEsTndmWauK1fkVagNuIz6+FxG
	WHVUN+Ikryjk+W1EghEbgxQAquvtMw0Z0uxXFx4L0S17tMRsK9zSa+QeWeZG2dwdqGAzBA+Qt3l
	hG1RMxrVuWSM1eUx7563j8A+bClVTVq0Rq7Z458JLsqEk1DTdrQMr325z9MbJf4Rdrk8zOSbAM6
	zh+N+M4u8BsTUTd/01P4JmiZPo8j/bl0I6upXeir4QMYxu2dG5M+PybzPVuz+jVGdqkGuRb6Zss
	j9/Eg4eeSI+eLdUTbr
X-Google-Smtp-Source: AGHT+IEUP35P72PXbqK3T+Jw88HQN7ZqgMrv6wlEXPBBGaZBS9BBhhgZozXciIYpR2i4MqLpZOsSXw==
X-Received: by 2002:a05:7022:320:b0:11f:3479:fb72 with SMTP id a92af1059eb24-121d808b16emr3204222c88.6.1767504547989;
        Sat, 03 Jan 2026 21:29:07 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:8a10:ce2:890f:8db0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm164944598c88.4.2026.01.03.21.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 21:29:07 -0800 (PST)
Date: Sat, 3 Jan 2026 21:29:06 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Cong Wang <cwang@multikernel.io>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [Patch net] vsock: fix DMA cacheline overlap warning using
 coherent memory
Message-ID: <aVn6ooxGnWH3X8ZZ@pop-os.localdomain>
References: <20251228015451.1253271-1-xiyou.wangcong@gmail.com>
 <20251228104521-mutt-send-email-mst@kernel.org>
 <aVGz39EoF5ScJfIP@pop-os.localdomain>
 <20251230081220-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230081220-mutt-send-email-mst@kernel.org>

On Tue, Dec 30, 2025 at 08:12:47AM -0500, Michael S. Tsirkin wrote:
> On Sun, Dec 28, 2025 at 02:49:03PM -0800, Cong Wang wrote:
> > On Sun, Dec 28, 2025 at 02:31:36PM -0500, Michael S. Tsirkin wrote:
> > > On Sat, Dec 27, 2025 at 05:54:51PM -0800, Cong Wang wrote:
> > > > From: Cong Wang <cwang@multikernel.io>
> > > > 
> > > > The virtio-vsock driver triggers a DMA debug warning during probe:
> > > > 
> > [...]
> > > > This occurs because event_list[8] contains 8 struct virtio_vsock_event
> > > > entries, each only 4 bytes (__le32 id). When virtio_vsock_event_fill()
> > > > creates DMA mappings for all 8 events via virtqueue_add_inbuf(), these
> > > > 32 bytes all fit within a single 64-byte cacheline.
> > > > 
> > > > The DMA debug subsystem warns about this because multiple DMA_FROM_DEVICE
> > > > mappings within the same cacheline can cause data corruption: if the CPU
> > > > writes to one event while the device is writing another event in the same
> > > > cacheline, the CPU cache writeback could overwrite device data.
> > > 
> > > But the CPU never writes into one of these, or did I miss anything?
> > > 
> > > The real issue is other data in the same cache line?
> > 
> > You are right, it is misleading.
> > 
> > The CPU never writes to the event buffers themselves, it only reads them
> > after the device writes. The problem is other struct fields in the same
> > cacheline.
> > 
> > I will update the commit message.
> > 
> > > 
> > > You want virtqueue_map_alloc_coherent/virtqueue_map_free_coherent
> > > methinks.
> > > 
> > > Then you can use normal inbuf/outbut and not muck around with premapped.
> > > 
> > > 
> > > I prefer keeping fancy premapped APIs for perf sensitive code,
> > > let virtio manage DMA API otherwise.
> > 
> > Yes, I was not aware of these API's, they are indeed better than using
> > DMA API's directly.
> > 
> > Thanks!
> > Cong
> 
> BTW I sent an RFC fixing these bugs in all drivers. Review/testing would
> be appreciated.

Thanks for taking care of it.

In case you need, it is 100% reproducible with CONFIG_DMA_API_DEBUG=y.

If you need my config, here it is:
https://github.com/congwang/kernelconfig/blob/master/kvm-debug-config

Regards,
Cong Wang
