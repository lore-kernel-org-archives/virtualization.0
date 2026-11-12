Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503556;
	b=hnl9IYJMAa0qsWNwzUgyYOJ4gEO4LzrmEfiXpKPB3s3Q8yxmJYq6dqumZrVy1/PBXF23
	 KirZlqqnD0hL5E3Dd4kVpyMXGtXBmPxC0Imkjq+Jt/aJlc8YPT6PzX9K/+bXAHefsXQQO
	 pwQg7Az6QmUj3BYm/+RwSrxlH2IyS8sPs0gvICXC8C/bZclDu8JuphjhXZesfO6yO2otf
	 frkDFxuqs50VnLRdf5LZfi97QNSLEt087FATiir/0gBRQKer5RX3mZ0lStQ/iJW33Jj7l
	 Bso4XuF85Aj2IiOPbZctYeE4ZmiiA6Xqvoka3QXOE6ONeiWAaNMpIJ1qyebGy+7Fv4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=F6YTYLTty4ZhMoj9B/ri1dVEfYoUCO5Spihz/O49FOQ=;
	b=iMTVtEuVZrmZTowW9G0IY/ntx8mC9UN04BRacTdzL23O1iajdayTy+lB8Psmbgnz1Qo3
	 LzKY7rCEdzCN0Xa4RTDjX9frVObdkGTLIb9dqNwaD86Zd44wL6DnlEEtzVyKB8NthGgkp
	 hzFXKwYJRysE46YlDvsqebEWYkppGY0Hea6BYnWUhSklFh7A6SBoHse0Ltu2xcgAmZ76L
	 w+ZMuOpHwFKPo35nzn4qGpFx/tUElgZwJxV9ZD4QTynfsYVR0fvKsys3i32ZgGCKhXBNN
	 B5OkEb/X/l7JbFmq70fkChRAN1Rfky0AVX1sf215VHoBq4y2mL5oZsnpPrG3Nu2QtOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=fDOQ28rl;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0552B606A88A
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 17:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0552B606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=fDOQ28rl
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so721312166b.3
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794503554; x=1795108354; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6YTYLTty4ZhMoj9B/ri1dVEfYoUCO5Spihz/O49FOQ=;
        b=fDOQ28rlVDjCb+K+WzyKmwpR1TnQ0ZA+a+gOMR9IBj3s2lGAw+PpQljX1/a0z/pw4G
         CjU6xKq4wUEG8TM6BWrnu+GMxo65bnTXGI5vQXMjQN/MS8Ada3RlMyLvXquWR/MtMSUO
         xCHd8t//uA2LcHadnaCWTagqrro61MRm9mW+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503554; x=1795108354;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F6YTYLTty4ZhMoj9B/ri1dVEfYoUCO5Spihz/O49FOQ=;
        b=uX9gbNBImzRqeWg7Bjxy+RLw2C9U49IlF0u2NAkC+sUDs0vC2ImFYaQX+nhMIHbrpv
         KbIFJz9X7fj02QzqE0/Xc8czixEL8vuPKp25rq/8e+RsygdkTjQCcxdmg0N035QMnA3q
         XCY4LgTgcb8hHCtzEi+lruaC9Wa7MF6eVEd+DoFX/2B3lmzJ11tQUwTtM8/ZFwlr47rC
         kjNvxoMFpCphiI+NM3FvsS3bUOpQWyyhj+Z3D8byhsLiWoZ5UL7T0i1FTK4G432EPlT/
         3mWdDWnkaNdzTPDggOMQEExBCRKI/dCrREVTRWZEWE9Rj9PtWYJMDCubyEq4mbTnhpRL
         8cIQ==
X-Forwarded-Encrypted: i=1; AL+hErGTEg+xUldgwnseG1jAiFTVHZz1bpKfo2seKq8LRy0ELLcjW1EvXlnSvBYdk6mP/PiET9LTLL6ta/XNxI6EqQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9XGebrv9AFAZXA+oxBXNXJKrKsbO+dWereUaiBuBxiDSgzBhU7
	+OFPXbUI2aVXJRKPMbCWeBn+KmrRzlfBejjZHluwuRyKdUYUGBMVVUbCIpO9jOBeQpciygGlq/H
	ZO5Tkx1bWQA==
X-Gm-Gg: AYBFou04F+i0oC51s+PmCYgvzQW673FR5NZEBgtGlt0y1Z7OaukgWZ8oBKu1QbFD5qU
	begChI0XexVo546VQtAVWY2LkiMKzCZGkRoJ4HuROQxklA9b3F3d5udLsr7Uj+s6S8lkf1DqNo4
	j/GFqP913PBntZ6kYtUo2Kof7hNsvpMiSVSgAnmfuILj3iv5qKnpMeIOU4rZQHS1rG0KPSUxOls
	DfjviKeL4ws79s5DT5AtfEPDk88S5DwQwgXS6oqsFllELy0KrHz/REVwkS03xxdhMZsJl8zc79q
	tfsUp0zeRvq4rLb4xhxRj24WDM3zpBinAGbYIfkeFAVyYpJo0SDe6zEEw+QCaQQLu3Z8v9ItXkL
	YIm3CaDHiw0nMEZcmjBgXsI2qkNzBJ+FgE5fCo3/PTMRixz8h/yOvVjcSDzTxLo/eRbw/mJMMvX
	3iNrlso5QrAPicEtK7j8BhwsXy07jxCV37g/JGgSmH05CWx3I60VP9HFbpAwPIsMfL4zYhQ+JeC
	kO13QXkpuam5LcrrgNsta8X6uHuiE1aUspA7ni75F/j1ZFPwdUPBUq4O/IS20nX4amFI+1OOEGQ
	TwhOHUKv288PuO21V914FhBkFXaInewACVCXtDlq2JuUrmz4aTJtjqGNGtK2krBoZk0ql5uj5yj
	q7/k=
X-Received: by 2002:a17:907:3d8d:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c5066da63dfmr609505766b.44.1794503554423;
        Thu, 12 Nov 2026 09:12:34 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50957c6c1fsm1602266b.0.2026.11.12.09.12.30
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 09:12:31 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso682695566b.2
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:12:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEcr6KYbF37HmxY3eKxVc12Kp+C7DM2nDQp7d75gSH0zfZ3ggLS/BXJ+XYagFAC49SzO3D7DogjByXg4qnxog==@lists.linux.dev
X-Received: by 2002:a17:907:dab:b0:c35:babe:ab44 with SMTP id
 a640c23a62f3a-c50665538e0mr626078766b.0.1794503550222; Thu, 12 Nov 2026
 09:12:30 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org> <20261110145241.536019-2-kas@kernel.org>
 <avNuQqLf9CG9dSsE@casper.infradead.org> <20261111-heimreisen-ungeziefer-empfunden-a892571f2c07@brauner>
 <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner> <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
 <20261111-stumpf-montag-miterleben-c4e2feac8090@brauner> <CAHk-=wjGXBnme-N+HvbzHH40ftb7Suc=kZVT5cuintQWyMHJ7Q@mail.gmail.com>
 <e94bdf7c-eae6-4f64-bf93-0aeedca1a22e@app.fastmail.com> <32ad880e-5946-4703-9c6f-43ff59da39af@kernel.org>
 <3eb60948-8fc9-4682-87c2-c113e54e7d4e@app.fastmail.com> <4d6a3d68-3fc7-446e-9f59-f61d7475e22e@kernel.org>
 <bf186643-780c-40e0-bde6-f2af90404a18@app.fastmail.com> <b90d4bcb-b865-4a41-8496-78d751c03dfb@app.fastmail.com>
In-Reply-To: <b90d4bcb-b865-4a41-8496-78d751c03dfb@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Nov 2026 09:12:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTG_hWYC=a2+uu_+SeN4E1ra0n=ytGqyk83Yr7tDuEJA@mail.gmail.com>
X-Gm-Features: AclHuK8_5teM8idFuSWqym8O4N3OQPYF_Y6jfMJ_yh9uCx25qjwD1XBnjE0OwRA
Message-ID: <CAHk-=whTG_hWYC=a2+uu_+SeN4E1ra0n=ytGqyk83Yr7tDuEJA@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Bernd Schubert <bschubert@ddn.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, Netdev <netdev@vger.kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Malin Jonsson <malin.jonsson@est.tech>, Richard Weinberger <richard@nod.at>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Nishanth Menon <nm@ti.com>, Frank Li <frank.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 03:35, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Posted with a somewhat shorter Cc list at
> https://lore.kernel.org/linux-arm-kernel/20261112112528.1116405-1-arnd@kernel.org/T/#t

Lovely.

I'd love to expand on this kind of early removal: anybody want to get
brownie points by just removing the remaining users of the legacy
'kmap()' interface entirely?

I don't think we actually have that many of them. Almost all users
have already been converted to 'kmap_local_page()' and friends.

If we got rid of the legacy kmap() case, I think that would get rid of
the whole "pkmap_page_table[]" mess and the PKMAP_BASE / PKMAP_END /
PKMAP_ADDR games and only use the FIXMAP area.

                   Linus
