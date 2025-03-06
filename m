Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC72036E3
	for <virtualization@lists.linux.dev>; Thu,  6 Mar 2025 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303353; cv=none; b=gdnQYH6E6mAcOF4N7r4PORjlzDvY0dKDhE+UmuowUq5hyi6YslqfayROxAWZti701494x7k6hlrzfs3qJATyw4LR09pa0JGBBaEmK+frjwjcENsopm2JJxESkFmmddzjYPBKZ3ZwR+V/IR4aFlYjz65rp+gZcMwbQeJ48z9q2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303353; c=relaxed/simple;
	bh=FQKwi2RpsEPtPJYNKOqwYo3KLh9T8f/v/uynBA7Sowk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=T6jeyWhRFiJv8e6MS3GhIQofpjhvfManqlcxRpL0JPCSx8tgajIXBIhITKoxL8JD4Gy0eV2JIaCUQy67WYkXOQ95hckdoJpnOosvpDn+PGY5I0ezx9EhzWcrIJyMJhichDQZdF8uaBkNIuYEnLIWDTIuTRGAwxWnQqGVMMWBwDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ6EzQ3h; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ6EzQ3h"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd01781b56so13900216d6.0
        for <virtualization@lists.linux.dev>; Thu, 06 Mar 2025 15:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741303350; x=1741908150; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Twj0Fw1nbiazziIk6/g3nWgynDdti7bN7lR1cuE/+CU=;
        b=NJ6EzQ3hOTNJqOdIphE7sTVajmnCPsjYtwrfB/2tWYeJ/1RXzv45m0xt1cCOa6qejL
         FinjN1RupNUkcFy/mM8Zq0Ziqc2qJ8cOzgDFPj99tgCD9Ge6VlMNY2LoXi9hIhkchRg2
         Ew59dOJQUG1ENnzhvNMCeK+m2Jn+nEVlnXnkh70vQlW0RByWF8xzmwq6QH7/RHIgI3ec
         Hi6byQFzysUg8X3Vp5Lc0x/g7sPHZ/y8UV5r/xgF9EruCKJ8S7kGufBR3C0Q9k4rP/fR
         2zw1LZtPxf5fXb2XI0cN4pcpAQ4P2XDEyWjqUZCrQDDlLzajaWz1qDITYiQZNMC2nrxj
         xbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741303350; x=1741908150;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Twj0Fw1nbiazziIk6/g3nWgynDdti7bN7lR1cuE/+CU=;
        b=Z/eMjGs89kFU3llReZN2L+rvhKKGCiVxnF231Q81mPrn35Xc5K6RDFcwIIK0mcM2bO
         RE2Vj5Q1Q39iBoRWol0b+Db7rJqkX+zdz3VHO4DgTfi0A87MiowdjAbBD6LvLCqlgbYD
         f8CvujMUSEJ10T7wbrZwyRz19JBEcrWg9lT/Wi1RI5Ef9YRuaM94sBHUN98B71GWqzIm
         UCLvTwzlCIDCn/p8fNeJ9VGY0IS4bLWjjITOU62D7sSUqmazqK0bZHWzMcZKtCgdbmO9
         jw5n+JN9jo+GLOGwdpoarseuHhkEhMwy1SFJe+PSNupO59DK1MMaDazF5uanMcQtSSbt
         OSvA==
X-Forwarded-Encrypted: i=1; AJvYcCUCdnz4geucvwKVSmgXH6Soj0WIvRqMqSwErk0oMaxptAvk58vMBmeEGXkv2wqC9HBLRG2yTNYGCDkDppWMnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVHEXda27UW8uOl+K3fq0vKjLsxQjzqaNg79KWq7yst2ou+oHi
	//wBYGNXvZYOQE/HPpwcKILdkNyJo4vkA1MpwXnJ4T53lWKd6oFc
X-Gm-Gg: ASbGnctD8oFW4A8VsuecpkDg27f1V0iQupxujO5sOBx7J5D4aUvT0K7FOqBdryrYPji
	A9Jo50WqF4LiNvUDvtBNBlFDxiPbhR8H3dawy8I4hmo8qIl8Vnew/c9867Wp7kxGCN8M6h4Jzqm
	b3ZoU1aR8lu+PqQcEGtjw1b/HwhOV8GgFTJC+LKEEzcDVLkhcuIzRTbbnDeGnkXp0uj9F3ZByVe
	JNWdIRMHa3iceDe1jKNiWrAAngQSEO6M5qNq38y0WSLhrbIkpE24kZxeTJEhdGDPdS69pjMpc/q
	C/p9l/ugfXw1Y8dGQNAqYNEtrg+7BPsSSGU6UhAbQedZlQ1egOEfLA1SROWgr085kczmMJhBJRb
	SZLGumntFq7kDTXQGrAhzYQ==
X-Google-Smtp-Source: AGHT+IFJOZJD5sARwEyPr0FygyKi+XS53r3utqjUWk1sDqXC/avHS6/glE7hkif/N9K1k6uHaaUJ0Q==
X-Received: by 2002:a05:6214:19eb:b0:6e8:f133:3795 with SMTP id 6a1803df08f44-6e9006751cfmr15738296d6.32.1741303350496;
        Thu, 06 Mar 2025 15:22:30 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707bf85sm12334176d6.18.2025.03.06.15.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:22:28 -0800 (PST)
Date: Thu, 06 Mar 2025 18:22:28 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Mina Almasry <almasrymina@google.com>
Cc: Pranjal Shrivastava <praan@google.com>, 
 Shivaji Kant <shivajikant@google.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, 
 Donald Hunter <donald.hunter@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 sdf@fomichev.me, 
 asml.silence@gmail.com, 
 dw@davidwei.uk, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Victor Nogueira <victor@mojatatu.com>, 
 Pedro Tammela <pctammela@mojatatu.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 dvyukov@google.com, 
 nogikh@google.com
Message-ID: <67ca2e3467212_3c5672949f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250306150244.7797232f@kernel.org>
References: <20250227041209.2031104-1-almasrymina@google.com>
 <20250227041209.2031104-2-almasrymina@google.com>
 <20250228163846.0a59fb40@kernel.org>
 <CAHS8izNQnTW7sad_oABtxhy3cHxGR0FWJucrHTSVX7ZAA6jT3Q@mail.gmail.com>
 <20250303162051.09ad684e@kernel.org>
 <CAHS8izNWt2-1bC2f0jv4Qpk_A9VpEXNvVRoXUtL43_16d-Ui-A@mail.gmail.com>
 <20250306134019.1702e609@kernel.org>
 <CAHS8izM8dnFNj5p8vKiyhV9qeE+9=a=BWRnH=vCu49Tq_XTL9g@mail.gmail.com>
 <20250306150244.7797232f@kernel.org>
Subject: Re: [PATCH net-next v6 1/8] net: add get_netmem/put_netmem support
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 6 Mar 2025 14:44:41 -0800 Mina Almasry wrote:
> > > Meaning it doesn't currently do anything special, or you can't make it
> > > do anything special with netdevsim?
> >
> > Meaning it currently doesn't do anything special with netdevsim. I
> > imagine we may be able to create a specialized syzbot instance that
> > loads netdevsim and starts fuzzing its APIs. However I'm told
> > specialized syzbot instances are much less valuable than making the
> > feature discoverable to existing syzbot instances, which is why our
> > thoughts went to adding devmem/unreadable skb support to virtio or
> > tun/tap.
> > 
> > Do I surmise from your question you prefer a netdevsim-based approach?
> > (and just curious maybe, why?)
> 
> My exposure to syzbot is mostly as a consumer of reports, I thought
> from looking at the repros that there's a way of teaching syzbot
> how to perform more complex "ops", like a sequence of specific
> writes. IIRC for netlink it does things like resolve family.
> But not sure if it's true or how much of an exception adding such
> things is.

The standard way of increasing coverage is by teaching syzbot about
new ABI extensions.

Adding additional initialization, such as setting up a usdma buf,
requires changing the repro scripts that it generates. Not sure where
that code gen lives. But all .c repros consist of a small loop() that
does the pertinent work, wrapped in a lot of initialization of the
tun devices, tunnel devices, netns, etc, etc.

> Here we'd need to guide syzbot towards a specific series of
> sysfs writes, so that it creates the correctly configured netdevsim
> instance with higher probability.
> 
> Just explaining my thinking, not saying this is the way we should
> necessarily go.


> > > > We'll need to add queue API/page_pool/unreadable netmem support to
> > > > one of the drivers qemu (syzbot) uses, and that should get syzbot
> > > > fuzzing the control plane.
> > > >
> > > > To get syzbot to fuzz the data plane, I think we need to set up a
> > > > special syzbot instance which configures udmabuf/rss/flow  
> > >
> > > To be clear for Tx you don't need RSS and flow steering, Tx should
> > > be trivial for any device driver which managers DMAs directly (not USB).
> > 
> > Yes, we don't need queue API or page_pool support or header split
> > either for that matter. TX fuzzing is definitely simpler. Maybe we can
> > start with that.
> 
> Adding support to virtio would be ideal, if syzbot already fuzzes it. 
> I was recently talking to David Wei about it for the Rx side, too, 
> so we can test io_uring ZC. But io_uring can only ZC user memory now.
> I'm not sure what adding DEVMEM support to virtio would entail.

By default syzbot uses a local tun device.

At least all the reports that I have seen. That is why virtio_net_hdr_to_skb
was such a frequent target.

We also added tun IFF_NAPI and IFF_NAPI_FRAGS to get more coverage of those
receive paths in syzbot.

If expanding syzkaller to a devmem rx path, tun would be more first choice.
But since devmem requires page_pool, queue API, etc., another virtual
device that already has those may be an alternative, not sure.
