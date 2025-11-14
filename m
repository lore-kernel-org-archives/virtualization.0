Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C12D340A4D
	for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156293; cv=none; b=k2Feb5k7WSPYVyowcOa2vvDxcrDg1kgtCLdX+F3gmSLw1iEb2a0L/xqJvzNEQWXNFn+hgPteFLOsyLVRFQsi8cf7txu/9X8lKINDhxdwMxXgRDcznQd5qVrQZOtJnWTZeM/4XlNE6uKvgpiMawoMz+YMdy+jYDCBbx/d8rtIBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156293; c=relaxed/simple;
	bh=NdC5qsF+daIwhv+jfvY4zcENzV+hiW0SWRKdXrzUDDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZKEQeiCXLRol8LvozH15hfvygsuByg00T3ITozYx8uBsJ8RcT5uDTIMtlo9odpeTzQF9Pn7YAAKtTJolXVaj1UbvyG81aLtI+uiXgS2jojAgVel6AoqMEOYg6Ifd6zOpuuVtx1KzTO9TFsf3glDTACP/UedhPThnS6QzpDw05o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUyIbrPw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUyIbrPw"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so2101265f8f.1
        for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 13:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763156290; x=1763761090; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AdOzp3Vu6NN0uDZN6wbKPsm+e3bm/G64aFJ2Czz/Dc=;
        b=IUyIbrPwkt43kOaEP/gg2z/YB7GsPLD6Ayrp9obIlIgWmrEcb5e+JnDs5yQpE/iErF
         5nGQE1u8ztuITd8KG4so1H1PihBm0fa64OcXLTLxpoi6BRaTN6CTjYVB/HxKdDI5XG+A
         GzjPnv2Uu5twvqWbQn+Q1r7m5F59EJ0c7dmwVYmiKuhg8m5BxY21v3zKpRXAhAOlVAj5
         iLJz4LkdQsw7bjkQXx1A2RJsDzux+fJp6UiaWvP++k3OW47V5Pcit1mlCYDZWnXHHDtg
         +rxsL1SQqzulWhQDuAHBAmE8ExX0jVWP4b49RewQJDJtAuJ4MRggrERV8VBuCQunp26v
         aQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763156290; x=1763761090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2AdOzp3Vu6NN0uDZN6wbKPsm+e3bm/G64aFJ2Czz/Dc=;
        b=s2OxYC7lDY7msUCFiSasGdYw4mhsgWws0LUOC++XEWcFTzpIpxZV2xyX7jx7iSJZMP
         obmyln91khOv+U+eK8cLe/Tk9xIWSj7plu1+gHBb7d4m0OWOs9p7pFf8/5fjWqNhonHo
         hGUXDkP3v7z8UXyPGQMuWR42VaiDp+lpolbpNrZQZlAK6ZDzxTcrPIzMZYk9Xidpg4z8
         XbJPEHbiSKN2UeYQ1xgLMz9/si9fFkY5QvrPJSMNfw5j1oPgAKA9WX0hzPLEEpxdl506
         Y2hsUz278pbUEQJAOG9PmPJrHRXlP+S1E+V/jIg5NLEQ/DJ1dO8U/kUtRdodqLZNFEXj
         ga9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWda9dyCpT3z8tHYRwHvkkUMKauEWCrnPTJF0tIiZK9QUAw/BcofwrEmDSZedVsU2rrzJlYR3Lr9HI2kzCIsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjoF5BM9SZpRMrwTlTyAjXOondSQnCNtVlH0pFks2HSVLl0Dbj
	43Le8d8488ot8BewzyAYCkUCqb4tASiPoXDsOUgZpKUZjrT6MynCemfe
X-Gm-Gg: ASbGnctJxBzdqcVnWda/8f5AJv09uPse4QQNbtFzamkUVhvNoW2bK41Q+C/M30GLqNS
	Bg5NguGxOV04mtSW/KZGlX58BvsLW52WzanW5zqY9dWVaV0OMKT7sLxdMXVuOlg4cCJx6IxUPXA
	qEIGuYT20oEzCXJ6d94sf6x2TN7ieJRtsvaVy3DQQEtaiULUuXdfKsGRkUPMNDGjllioVVEcPY7
	HhxL+oB63fBuc1AFikDf5MtW6h7U0UTudgEiNyfoWPEmoZNdUZ88Zx6aWfI3P37nE/xiVouRVOv
	NPqU4fkyY9ULqk1EFokufi8c5dFLMKzvxKK/NcDiMkb7Xkz7k/KLn9zasR9jckuIuHwlQHDqkVQ
	7Jesgghxfz6qL5+4XuTnrZJ8W073qWdVxxAxzjltrIEcv1HqgAx50ZqCerGEBwrptRclgeHn0xj
	7MvcxcNHpaTcVN5vmgEFuBIkr/Fkp5lVlyrEPXScu6ckAm2ttsxHu8q7h6VcgJqNo=
X-Google-Smtp-Source: AGHT+IF4RUaKrhCIq/a+CQuzQOczqQ1I8RVr8VKrQgygddIe/fx8JxhllhOhRwXR1khsOJv2FxFapw==
X-Received: by 2002:a5d:584a:0:b0:429:cfa3:5fde with SMTP id ffacd0b85a97d-42b527be676mr8873626f8f.11.1763156290271;
        Fri, 14 Nov 2025 13:38:10 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f206e2sm12158736f8f.41.2025.11.14.13.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 13:38:10 -0800 (PST)
Date: Fri, 14 Nov 2025 21:38:08 +0000
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
Message-ID: <20251114213808.252fc8eb@pumpkin>
In-Reply-To: <CAHk-=whJ0T_0SMegsbssgtWgO85+nJPapn6B893JQkJ7x6K0Kw@mail.gmail.com>
References: <20251113005529.2494066-1-jon@nutanix.com>
	<CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
	<E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com>
	<CAHk-=whkVPGpfNFLnBv7YG__P4uGYWtG6AXLS5xGpjXGn8=orA@mail.gmail.com>
	<20251114190856.7e438d9d@pumpkin>
	<CAHk-=whJ0T_0SMegsbssgtWgO85+nJPapn6B893JQkJ7x6K0Kw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 12:48:52 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 14 Nov 2025 at 11:09, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > I think that is currently only x86-64?
> > There are patches in the pipeline for ppc.
> > I don't think I've seen anything for arm32 or arm64.  
> 
> Honestly, the fact that it's mainly true on x86-64 is simply because
> that's the only architecture that has cared enough.
> 
> Pretty much everybody else is affected by the exact same speculation
> bugs. Sometimes the speculation window might be so small that it
> doesn't matter, but in most cases it's just that the architecture is
> so irrelevant that it doesn't matter.
> 
> So no, this is not a "x86 only" issue. It might be a "only a couple of
> architectures have cared enough for it to have any practical impact".
> 
> End result: if some other architecture still has a __get_user() that
> is noticeably faster than get_user(), it's not an argument for keeping
> __get_user() - it's an argument that that architecture likely isn't
> very important.

I was really thinking it was a justification to get the 'address masking'
implemented for other architectures.

It wouldn't surprise me if some of the justifications for the 'guard page'
at the top of x86-64 userspace (like speculative execution across the
user-kernel boundary) aren't a more general problem.

So adding support to arm32, arm64, riscV and 32bit x86 might be reasonable.
What does that really leave? sparc, m68k?

At that point requiring a guard page for all architectures starts looking
reasonable, and the non 'address masking' user access checks can all be
thrown away.
That isn't going to happen quickly, but seems a reasonable aim.

Architectures without speculation issues (old ones) can use a C compare.
I think this works for 32bit x86 (without cmov):
	mov $-guard_page, %guard_off
	add %user_addr, %guard_off
	sbb %mask, %mask
	and %mask, %guard_off
	sub %guard_off, %user_addr
mips-like architectures (no flags) probably require a 'cmp' and 'dec'
to generate the mask value.
(I'm not sure how that compares to any of the ppc asm blocks.)

	David

> 
>            Linus

