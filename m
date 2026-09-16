Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA234B048F
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552238; cv=none; b=H0oieJorzb81V34lNKTw/qvLr98yQ52pV3xcfD+ei6joyeRk22Vu55/0S2gp77SplgtqNseUTBvwzShAwG7rUSBXSkpXW4UjF9dkjgl7GkV59BOrJiHPtkenZpuQ8i6XF535FIeS/Pzvgw/OS94nzYWV916UkLbx2LuUJWWrC/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552238; c=relaxed/simple;
	bh=zVftL0e6KTn1Fup/RmgkkUqXURXldH56P13A6WLi8KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqsJTl1xxQs2WsUFbBXdPD9+T0CvxzJgnj/eLVQoXXPhsU5zSiAiTlgKp5ZFjMjqDBoDMDLsfHttQQjFHdTgMAdH6g1bLmHItSx8bsw2lMvTweZRJd92uWRQD3r/fAhxjanZ1c7bp/nuXqncXUVwsjFbpxKOt5uIugq6rg93lTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfsHaQ8z; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfsHaQ8z"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so3877815e9.3
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789552219; x=1790157019; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
        b=VfsHaQ8zYkwmd/iEt5S57McxT/aMkyWItzxtCnJk8ZpJ0XVO5Zf7LvYHldbYTEsoS3
         2nJqAYBRHlTAJBGMZ7l/b+NDe65hyw+7ZlObV7dN1NUJ/lE5NWIYB6JsHTNUGgHcyamh
         M9BVdtzI1skh7omRDZaFC4JWWPDFSatUPRDvauo9RVKeccYSQb1j6vatmVwJ7cNL4DNo
         KXR14c/5PvNlBGzZa4dETfZpKip9h8Pf9OY/S5njjB98G0YZ1BpiQPSXSGSYlORDlVmD
         RAEk0HxRBZL9X36S7q7MbEIVKDJiPxuKPPf/as0Rr+IayUVa2EjtRtYOecwAvXekIy3n
         DbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552219; x=1790157019;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
        b=pcCKVTPCUcrTOy151QNVLI69MMpxb6igKtbMzasvW5IIoKA6aeUfqijvrgvDkuzxlF
         2gdPss3gpeYj5Roor0ZtOTXcN3oyXK3Fqq/QU6wsqJJueolRRxutS1FJ2y/tcYfpBhh3
         r1H4ar3G5RFfqjm8cw47EDUu4kPsG3UW0djhDBO2yqQ2FibVtfOmQFRmwbxSgrUFDnTB
         Zr9FdmqIT2V1r9GyhALViqSJGVa1ft3m7pPjD0H6O4zctqeC7zstLmwpiDXtFcXUHDEv
         1AL0JM6UyoNTUfa3zMv8VzJw+hlaAoGnJGj3dSB9sL/X5XZuTObnJBzPuw3Wy9niXQet
         I1dg==
X-Forwarded-Encrypted: i=1; AKwUvBy91oQkG/PzUhU/Os6jgiC+xPx044/ovMAksZQOrdWwu6aSonvAj/clhuusmdemhMLOinNlkACwpT19r+FtSA==@lists.linux.dev
X-Gm-Message-State: AFuF++nczZcjDxmBYZTT4+XWK8TJbOO7stT76++fa3BgNDuGSPv9wSvz
	vxubUgnvLo2kpJzitfJJSWywixXAmik1m+D1NLkT80Ra3jGlQWEObks2
X-Gm-Gg: AYBFou30lBQ1wqeXfBZ6SkavhQ97TYI/Uy4g/jMaH+FoFattmu5R3+eFuXIesPqsLuD
	wKTd9ypnkxrX09lCHiMLAlotGiuOnwoSn5r5x7ifKSBk525zf/vFlkxu9h1bpUh4A7XJlJQnwJi
	YLKEqrnVae7DcF+y0KRzJjMTqnps2Sf+cQfpRHWco6fiOouqxnVN3wRiTkmJwHc4Z618RVjAlWD
	UAKuOlz1jhepDSGa+eFoxZEZMdnkyCcnR6cgjtPoF83hQve5+mv1tNdjhJhl8bCiE6Iq+WV74EJ
	lT9VgMpnOZRjkBfdlR/awMl05KWWSHvGTqKUPkYTi/eUMRinq71ONAeZczWwqXZcFqOoMdklJPN
	yLXtfjMGPl9n0Ne+Yq6Aw/SlqlMwo/sJQVsuxrVyiX8pvOr2JJqN+ZIXhIZD/62/3wuy+Nrz1mm
	N4CzR8U/6K8C5fYj2ryNYbist1s43fKAigPEQr8+gHicF8rQi64QZpY2hh0tpF/ADNkn0MwfNHP
	S8H3nyikEBiUmkMOwk3nySbRH+XIZOsNKywGBEZ4SnoDQI=
X-Received: by 2002:a05:600c:4ec6:b0:49c:fea3:8633 with SMTP id 5b1f17b1804b1-49eb732aec0mr19444455e9.24.1789552219000;
        Wed, 16 Sep 2026 02:50:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83b02245sm84055225e9.10.2026.09.16.02.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:50:18 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:50:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, Jens Axboe
 <axboe@kernel.dk>, io-uring@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
Message-ID: <20260916105017.13ea5e36@pumpkin>
In-Reply-To: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
	<CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
	<CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 12:08:57 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
> >
> > Is this mainly about stuff like "we installed a file descriptor and
> > then the following put_user() failed"? Because if so, I think a nicer
> > fix would be to have a policy of "if userspace provides unwritable
> > memory to a syscall, just keep going and pretend the access worked",
> > and maybe have a sysctl that kills the process when this happens to
> > emphasize that userspace should not be doing this.  
> 
> We've done that before, where we just ignore put_user() errors and the
> user gets whatever the user gets.
> 
> It is maybe not optimal, but it's fine. You can find quite a lot of
> unchecked put_user() calls with a pattern like
> 
>         git grep '^[[:space:]]*put_user(.*);'
> 
> and some of them are in core code - see the two in kernel/fork.c, for example.
> 
> One of them says "if userspace has not set up a proper pointer then
> tough luck". The other one doesn't even bother with a comment.

I think the code should try to return EFAULT (IIRC that is too hard
in one of the exec cases).
Otherwise very unexpected things might happen if the memory is just
readonly.
If you ignore the error and the pointer is invalid the application will
get a SIGSEGV and (usually) die.
But winding back kernel data because a user copy failed is likely to
be problematic/difficult and at best have error path code that isn't
really tested.

As well as writing fd numbers to userspace, some sockopt code tries to
wind back if the write to optlen fails (which has been read earlier).

I've forgotten which Unix converted EFAULT to SIGSEGV in the system
call exit code - I'm sure one of the ones I've used did.

David

> 
> The scheduler has two cases too, although one of them is admittedly
> for another error case.
> 
> So yes, saying "if you pass bogus arguments, you get what you get" is
> a valid model. It's perhaps not the *preferred* model, but it's not
> wrong.
> 
> It *would* be wrong to take code that already has error handling and
> remove the error handling, though.
> 
>                   Linus
> 

