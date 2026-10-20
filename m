Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488098;
	b=3tUe9/SXUQXWWoFfh6Y5KlewSrD5ydZ9xlkGr/vLMhTqmLoDF8hHOpYTcRoTns5k9re9
	 lqfZadDeHUnj7oJhDmLl61S5AFKevJDhgS2qsOWEnql8Srd1wYNWViJZO7Vr3gstCjQKQ
	 9GXX9QF7V3y7oesVUqZ2o49H3EjVTgD8+3/J8x0/Q4h4hD+HTcTcUTPeS7Q1wcXsUY4yG
	 64cvL0wb/jIpVYin79B0Yx6PzwjDZeJUZ8NqiilJikgvGLkKSOOaXllMmBOdGcxSAp24f
	 e0d7wDU4fwaxCmZqHzILkbZvDiLq+PCCw3K2Txtbbpp3nQ9qaAZGc+aPHkZNNFs/gcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oK/+sZCg2jpdsH2ljNfSqzCUTPMd7ZlHvWodhd0LpQk=;
	b=ZWwNktYQBUvCZp0sXSRtwA8p79fRkllK/IcSJAaQPCaNgi3NMDmoz/2f5TvJIzUk5NaH
	 sdu+9HrvLtujO+42lCd2SJamj7XN0NesTeQ8KDEVee2ZG2itBIHCNruiMYVlFoCEOeLQ5
	 RyfbjOcXriCZbHdGhE+CGGHuvxBL6yympjD+DX1r329tXAN2Sunwumjpv7DgR2Gk4SbAb
	 P2lrmYsYYs/ToV6RHJstnat+UdfF//zK2IuOjxCguyTZ4g3EpRb+JCly+ia4j9mrk3rxn
	 Oh392lIOHgQ8E0Eonwg9+mQGBF1YLtnxRwcqFIIGf52CXnc4R8uMU3w55HQuiPRZbsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cc7au2Pi;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817CF606A31A
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 09:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 817CF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cc7au2Pi
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso2472460f8f.1
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 02:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792488097; x=1793092897; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oK/+sZCg2jpdsH2ljNfSqzCUTPMd7ZlHvWodhd0LpQk=;
        b=cc7au2PiKmE+BnglYXzpWZ6V7dNVhnsC1iJEttOcoEiNWuBRrzSD2Ro+RQc6z35lF2
         CQg7GUDtM5oD8+Z7lUfNPou9Fxom9d34l2PCTs2H90kIcn5DhOlz3bnLuRO9o9MN3Bda
         jo9NuemcebVIlNPeLBjRjgo6h3nPySqn9EC72uP9ykKpO5+/G/bhIys56hPBHQwNqpVX
         CZ4X12/i9IyFGB95mU4an3weiRFiCteBoVUGymV5aUvnLYU1tE9j3EDWZfuFDPr+vNeW
         2wi0mEhArhX6pObA80PC1W5OBFlFmejvZTtjdu/Q/wY0i+llEG2nr3/i/FWFG+4W5a0h
         FfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488097; x=1793092897;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oK/+sZCg2jpdsH2ljNfSqzCUTPMd7ZlHvWodhd0LpQk=;
        b=ZK612wDDvYPOl/lig4YNgpKCnYVq0Jny4CRMaK4Ny+fu6Fic5EjTe5RMyUPC4j9w9o
         P99sMF6BD6TDC3frRZJ6ddZlZTYoK/sr2UFWfrjs74dyAdUWg7DQLXsZmNuAT+7Kirmn
         ZTfF+ZmGfuUmY/IoC8bbCf6Rj9mt9734DXs5152pcem8ZR8TE4o+SEGVCuumC9t2D8Qy
         0P3iWmcQqz7HoAMAR2JR2Xr01vXnrD9c+IQWuBFBGfwff5aGbsHTNOF2B9+atvbRLSLN
         aNfct36DPIPZ7gEhY0ft3mPSIDumZPn7S/pmSAL8AJc7aDixW9zNQj9svMtua2LRxWB9
         Muvw==
X-Forwarded-Encrypted: i=1; AKwUvBxU4Mioy5PO6akWj+1jmRYSr6fpYp8wUBK2YcV/ICNnATLsxAzx3LlSH+jAwRViOzkpBgpuZRhoK7RnyDlQbg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKZ/x2/0U+bk8AMG6o6GbidmiL1KdUNwFPHpu3U0/lLs4PV/RoN
	e6zxI1mBmxuF1mlWfpIB54XUL6vuFonSJepUTM7iNkJD2AGKZbls/VzY
X-Gm-Gg: AYBFou2Vt4VJW+CFEhYKjVU2+UnZY6mf0SN6CmMnKQvxSC1bm8UARG8PVB2tws1BI1k
	f48TEvjp1tSKi5Nz7vkXDY4GRlo6mOlG/CXILTsFwZiY0yIptpAHFiHelT78HA5KAGqy8LxHXhO
	HSuCE8yS7s+pL0KC5CL+5JPpvjCuOYRk4jZSHxfIGWjqRf1ANEtjak5Pu5IpcyIfbKzj6p6nusz
	dBwforgWQN6fpNNS/2PVEuLvddxKLK9EEmWGVzqhF9cIhAl2Ag2dKjkh5/HLZAAMloGcNs4dRuO
	HRJ33kBumVsCESc6sBJ/sS1kmdEXUHQ6bVYQop9wNuBLXm9gzDbV3c2qUaWN2DW/23LKtsGfccu
	1qXT41XpNH0dTtP4aQTBdv9QV34GmOiJAlmmQoGGJVYEhlFvIo1d4UBhu6Ugc70XzfWKbIDEqC2
	gISVj92SCdxgl7YFzgeaKtumQdTGJr5TlPqdmjJHXLCjpYQPqgjwm80Bwi31e/soUqUKvfevJFy
	tUn8qyWJLcs52rcP95ZiT3XNr1odQUauJw=
X-Received: by 2002:adf:fd4c:0:b0:487:27f9:841 with SMTP id ffacd0b85a97d-48e07fbdfe2mr15044578f8f.54.1792488096337;
        Tue, 20 Oct 2026 02:21:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d80f9b3sm4629943f8f.20.2026.10.20.02.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:21:35 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:21:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wang Haoran
 <haoranwangsec@gmail.com>, jasowangio@gmail.com, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, eperezma@redhat.com
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261020102134.745ff48a@pumpkin>
In-Reply-To: <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
	<20261018152358-mutt-send-email-mst@kernel.org>
	<CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
	<20261018174250-mutt-send-email-mst@kernel.org>
	<376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
	<20261020021924-mutt-send-email-mst@kernel.org>
	<CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 20:51:43 -1000
Linus Torvalds <torvalds@linuxfoundation.org> wrote:

> On Mon, 19 Oct 2026 at 20:31, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following seems to work for me. Testing would be appreciated.  
> 
> I have a whole branch that removes __get_user() and __put_user() entirely.

There should also be very few (if any) access_ok() calls outside of the code
that implements user copies.

David

> 
> Somebody should check that I did it right. But I didn't want to do the
> pagefault_disable() around the vringh_notify() part, so it's not quite
> the same as yours.
> 
> Let me just push it out. I was going to let it simmer, but your email
> made me go "I should just let more people look at it".
> 
> Mind taking a look at the 'uaccess-cleanups' branch?
> 
> It builds for me. That's all the testing it has gotten so far. Blush.
> 
>                    Linus
> 

