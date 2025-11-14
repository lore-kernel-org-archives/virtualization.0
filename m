Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5692EBDE9
	for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763147342; cv=none; b=S5MfLWtb6/5DCXSliAj/9U6ZkEX/yE+uJhcyFyc494TjO/Ig2HZzdoxqYwrMNmyoCECVP3KsDBdxuV2j9D3uwAJXOr4G1cziQ+h/igLDiKNo9rN3bPsdX3ZvTdDZvve2fLezxRxaZ8PDNbJfPTIm7Tp1hsiOPsWNZ1PhPdU3Vts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763147342; c=relaxed/simple;
	bh=Nfxgm75Jhb2I/JUAINHfI4c962h33wDu9+inj+NnIc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjQ3hGWThPNYq+KzRmiwMlcG9U8ke41vdMcAq3U1V4sAmYb51fma4mUYLV1pL0KAT7N8wl7uJddS8pvscXXcgzEcnUSQANlt/cksJIS64lOrp6bh1JCbI4B0XnBpbrrclTTM93dbE4aTMl9NbnydiE6QeFIla5CnKarwD9f7YjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUPTW92l; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUPTW92l"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477770019e4so27560095e9.3
        for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 11:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763147339; x=1763752139; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kduuOxJm1uiHOQpqpaE+0Irtr18Sdz3O5vUWzH6wpM=;
        b=HUPTW92lb/5EE52L/Sg/0vY2hMGAZ/J3BjIDUURbEAIM6nRkFzw18DaZ8+xUbi8Q7U
         uZTdG94/psTXrJRGASmR+CSkAqvDBuy7QEHk73qUG2lu2fvRINE2Xo0+yVcv+J7HRfi2
         +7/JXTYmjpfzGCvUbEM5/eP/4FfFBfWYuSaMmTmrIz2ZhbrhVKLlynfwBzFDousciqSs
         fkjtb6PkDROJH1AwqnBc/GoBWjBKToDHrpvRTVMTV0x+QSbo+yl6hmL5jFXED8LCygl7
         4BtCMeLg2b1gi5yNAQ0IRmFxI796IbKsz9rqoqFvP00FZlmbcwk2lLj6OqXHYO81KfRk
         U4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763147339; x=1763752139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/kduuOxJm1uiHOQpqpaE+0Irtr18Sdz3O5vUWzH6wpM=;
        b=imgRGRcDfn2u9B2iWb249jrSKaDkmJh79ApshFca60ARqK77VqdfYkB9K2h6UOETvA
         2hP3DF3ial8Z+cfWctAGuC5xlgk0UmfSUjdnCgQe//pihoD3qFfnaaMJkva9e4DzmNix
         JXcDHEYHcvpYZJLRmUTYW+wA2Rn7f8LTTOy/nr7IdRz59zHL/QE3LchU2SluLP3zd1if
         0JA2fI0nQke4HvvJ06SZwkByxIMtNz0rRYJf3zFTNUo0bEhdqVq0TXQsZTCWAbdyOUyL
         UFvo2AWv4mnGrj0Oyja3L28XFRDaKck5wbfqLB/qnJmK45jmeYmZlnq58T7oQ0/UPfbS
         eBHA==
X-Forwarded-Encrypted: i=1; AJvYcCWGXejyxo7A73hm+ZtM881vESOA3FuiaOzgqp/nHAs/llxJSBvvpQ7zPZYckjHzPL8bKAy8weAjB93rhocLXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtdFP62ZKeiY/aaRUidMaLRAJNMrHL/hNCyASYjrKR9a9idl3P
	f5bW1U6wlieH55B1fIZfml65qI3TJTu69Z5wnb1DMh8pAFGmaLGSbENf
X-Gm-Gg: ASbGncskd//zk+nv+6+5wtYob8lmiatXOD9HsCJWXr021makSQvvUi+3jklY8PxNUQ3
	Z1jsmayiWdlVkCL6hYQA7OGva6cyIIy/vwIQY4BlpzN6v0o5NuvW9FCeO6+IvWRmmT22uCbj9FB
	AsC8CT4H9t7+N/0AVZU+NZNn9F3WC84FG8mCaw1SKCO1T1SRb0u9f7avAjK6pXaBFhpluaxTvdD
	eB9MGmdgNWvFC0qPxvjtmStDp6CbuqrnkOcbACxlr0QZq5XT6ZI0mmIvIRIe5XlM/HwAg+avzjA
	TS15EVydqwPbczOxpVgFZWfRfpckkZwfrNyCIGpN6Obgcb8233/C3upgFm1F79fpougc4lRvpQT
	v1cwj16bCYvPBNjXv/1q9UTzy/Qiax+JHCbfxoab8VMEgtlXED8AqNlaGr16aAJzlA6Jg8qziqL
	z4ofzlOLsnBeW2pBu5M3AOFsjxGGf8Hp1aI29gHALwhZp8H57p6RyC1DTRVwItgqE=
X-Google-Smtp-Source: AGHT+IFWHe5vo4aCmUnfRTE8bLs+NNaWOHslfnze7qRX+02RlEOWeu0jyoeKkQbA3EZNRkKxFnbT8Q==
X-Received: by 2002:a05:600c:1f87:b0:471:1435:b0ea with SMTP id 5b1f17b1804b1-4778fe795b0mr39564935e9.24.1763147338776;
        Fri, 14 Nov 2025 11:08:58 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477952823d3sm23335595e9.11.2025.11.14.11.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:08:58 -0800 (PST)
Date: Fri, 14 Nov 2025 19:08:56 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jon Kohler <jon@nutanix.com>, Jason Wang <jasowang@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav
 Petkov <bp@alien8.de>, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user()
 and put_user()
Message-ID: <20251114190856.7e438d9d@pumpkin>
In-Reply-To: <CAHk-=whkVPGpfNFLnBv7YG__P4uGYWtG6AXLS5xGpjXGn8=orA@mail.gmail.com>
References: <20251113005529.2494066-1-jon@nutanix.com>
	<CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
	<E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com>
	<CAHk-=whkVPGpfNFLnBv7YG__P4uGYWtG6AXLS5xGpjXGn8=orA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 09:48:02 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

...
> But then get_user() gets optimized to do the address space check using
> a data dependency instead of the "access_ok()" control dependency, and
> so get_user() doesn't need LFENCE at all, and now get_user() is
> *faster* than __get_user().

I think that is currently only x86-64?
There are patches in the pipeline for ppc.
I don't think I've seen anything for arm32 or arm64.

arm64 has the issue that the hardware looks at the wrong address bit,
so might need an explicit guard page at the end of user addresses.

Changing x86-32 to have a guard page ought to be straightforward.
But I think the user stack ends right at 0xc000000 (with argv[] and env[])
so it might be safer to also reduce the stack size by 4k (pretending
env[] is larger) to avoid problems with code that is trying to map
things at fixed addresses just below the stack (or do we care about that?).

I'm sure I should be able to build and test the x86-32 code.
I guess there are instruction for doing that under qemu somewhere?
Might be time to drop support for cpu that don't support cmov?

	David
