Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A34025B31C
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747347; cv=none; b=DmarKWhnykrT+ngNlNzYXX12h0HJRK/o6S4R00XaRmyp4Ue0encpUuINbq93XkVhYxhER3Ar83Y1JkzNZeGHtj0Vyfcyw//0VmGUSK7f7w+/3uVDxhkAdbkY9faEt+3DZEISu1dwDjw+TMm5DttSa8T0gW4VDRwVphxBZBoTeTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747347; c=relaxed/simple;
	bh=bbpHoxgmqkgEJqHNWPVdMBw27oGNmoNKaCdnnuCAO/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbLuEHlJKrqCnrAOw+mtdX99Jzxefmk3mfehaI2GBahhuI6zvT3NqAtQiHkq6jmMFcvTUeffE/Xwds6RR1xOVumcdSwf/PzOil1s48+pjwWopZc3OHg0sqKhAleuOGuscGFbhAEB0p5s8mLDGJfISxx+/EXoxNoYg3leL0rQAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDdlANLL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDdlANLL"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso3814725a12.2
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 09:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763747344; x=1764352144; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h8ErBzqTgP4cHYgJVQfDWaPxezOQKn0ALUTf491LHzg=;
        b=PDdlANLLC/HocaAqIXjFNe2LhRDuLD+D1bpnBYxurPWsqxOQh/OOu9sC2M1SXTY1p1
         eDN9CWqbHNLqcEdTiqY9qT43wdxQ0PPa8MpW1jB4TC6XwgXvb6rcGi5yHsDt8EN02YQf
         z6tUxEFiIZQmxKibk/jZC5M3LjRoQW1YUqzCTvWJMegpLMzJ5+CjUd9FSN3oYem3140J
         GTEOKtaKDigW+oqhPWUyMIN6FIZycF9yJoXzbdcOgzw6RXVmC/t0yC08L/QsziLmEf3I
         9XtR503243AbKXRfb3B2TCI/JDj1PyTc/lG12O8sOnhAVBXMJxaNn4531ZPJeSgdp81b
         Gxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747344; x=1764352144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8ErBzqTgP4cHYgJVQfDWaPxezOQKn0ALUTf491LHzg=;
        b=oJfMRLxl/0iSpWvUnhUTVBssPzejIRL/44ZFbAaLq9VFgbYhOTrnIODU007Y5Xfn8G
         bTwXL/dJLBjilYI82vVoLjLf/tlKtspb8sDeddg+FmPsVfqV8tNre0DsHn2d7TE+5xLc
         ZVp4D19WR7DdgWpSMqvyYJDnZCYnHdU3Vf+dK5MQgAmyGxwsoeVZkjArfyF6NlRb6wr9
         Zfy4snTxXqheqF2uW9RjiOuYshxNNXOzCPQTSUPQ6sdUHuKIaW4Sjx8TA6Zy2B+r8Y2l
         1jCnlgSsjfYWXjyg+qm617ZxrngAyuccvolALOx9FtDj0iu4/hWCBbS8+oS0awldZcZ8
         H+DA==
X-Forwarded-Encrypted: i=1; AJvYcCX0m2n1U6GF9zOp9tQp3/2UULSaaXJGkuPa/pbDUooELCiuCUJRaZWbH+Drfn31Licxj8Khdwr2h/4T5azySg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfYLXO/57p4oabQbaGffiJXaIW9kVhtxEiSOAjBFbSnxelN1u1
	+CDhEq2ciZLsnrZacgjhUtd3RC3JomJZdNSntQZ78iUHDVX8mDI6gRfY8E+FPkfF9fqGYG+h8Hp
	QhT8zysIzhovqYuhjhMGPRNM8oy+1Me8=
X-Gm-Gg: ASbGncvw3U333Z+LWWGkR0jDcr2pPq3Lrxuk4oydiucMfB7UhQuLfKMDz1L9DJqBoNn
	/jm2W0+i2xf/mcBCO8wcmUvKYrTiYrZKCABwpeJQLQUTkpHXTh6eiJxjp9eaW8jzFcHUEfugcgA
	eggDNmz/JHO6j4jzzlHdiqiARcFmlTgoYnu00xXXLnpA1CBYISr00Q9lZ2x4GvNGc+vokun34eb
	XZagyz4DkNBLuZKMmQMSAVKAglD1np4EVh72O1/zvJ2RMtJNPqpz8LswVq/Q8e/PtKjGsYJBueu
	3Bjm3GstuyQnTAPLC0CH1Ghx7eU8
X-Google-Smtp-Source: AGHT+IE4GS79sSxW/Rd4Ohj496vpRoSTu+pKqkj/hZLDMt5SoW5D+KLGWEEIKTW5/CgPvJlUkWdvl5lidG3EzaU5/BE=
X-Received: by 2002:a05:6402:35cc:b0:640:c918:e3b with SMTP id
 4fb4d7f45d1cf-64554676c63mr2972912a12.26.1763747344224; Fri, 21 Nov 2025
 09:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251120141354.355059-1-viswanathiyyappan@gmail.com> <20251120071715.28a47b21@kernel.org>
In-Reply-To: <20251120071715.28a47b21@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Fri, 21 Nov 2025 23:18:51 +0530
X-Gm-Features: AWmQ_bnsZ7DyviHAe10zuie-93KQZaGmhmfWVwmmKuclxNtRbUQFHAMN1h6UQus
Message-ID: <CAPrAcgN=RwA5j_hCwHAdSTwyfj5jignvaZ0nNidFqYaY_VeRxA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/2] net: Split ndo_set_rx_mode into snapshot
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, 
	skhawaja@google.com, aleksander.lobakin@intel.com, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 20:47, Jakub Kicinski <kuba@kernel.org> wrote:

> Running
>
> make -C tools/testing/selftests TARGETS="drivers/net/virtio_net" run_tests

This bug seems to be caused by a call to probe() followed by remove()
without ever calling
dev_open() as dev->rx_mode_ctx is allocated there. Modifying
netif_rx_mode_flush_work()
to call flush_work only when netif_running() is true, seems to fix
this specific bug.

However, I found the following deadlock while trying to reproduce that:

dev_close():
    rtnl_lock();
    cancel_work_sync(); // wait for netif_rx_mode_write_active to complete

netif_rx_mode_write_active(): // From work item

    rtnl_lock(); // Wait for the rtnl lock to be released

I can't find a good way to solve this without changing alloc logic to
be partly in
alloc_netdev_mqs since we need the work struct to be alive after
closing. Does this
look good if that's really the most reasonable solution:

struct netif_rx_mode_ctx *rx_mode_ctx;

struct netif_rx_mode_ctx {
    struct work_struct rx_mode_work;
    struct netif_rx_mode_active_ctx *active_ctx;
    int state;
}

struct netif_rx_mode_active_ctx {
        struct net_device               *dev;
        struct netif_rx_mode_config     *ready;
        struct netif_rx_mode_config     *pending;
}

rx_mode_ctx will be handled in alloc_netdev_mqs()/free_netdev() while active_ctx
will be handled in dev_open()/dev_close()

Never call flush_work/cancel_work_sync for this work in core
as that is a guaranteed deadlock because of how everything is serialized
