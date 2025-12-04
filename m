Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D13074A7
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841025; cv=none; b=Y9HVoTNaBXfB8vbBl/Se5vCmLTi648GZEsXuBuqgDrjF+Gc4FlhuvI/HKidnkq2rzh2FFcHK7LdvA1pTyWDIYwcMjVLrcLa0khMa3iI5OIClEUb6l9+CRK/LUMPAQ34UI5qPJbzbWdMRxNypGcj+CKYL0T23VhI+AsWcTft0nGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841025; c=relaxed/simple;
	bh=qeEjzVz7GQk6EpiDzPclRlc2LVPc/X5pecZGz9q1Q90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fL/EomNXC/ObKdbBwwJdgykERUznWrwxNti8ylAHVxSNfi5sNjZHEnMeqC4eefQg6vdtomPx62wSYMTp9bhsCc1hcDwAwq4dn3oR90jplEwUBzIN9X5c3tPXFMiqdTPzdgk3xQVz6YkiJc3NtVO2edpv107H6xaFCa9+ySy0yaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9Xg1hNG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9Xg1hNG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764841022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeEjzVz7GQk6EpiDzPclRlc2LVPc/X5pecZGz9q1Q90=;
	b=J9Xg1hNGgKJjP88Sx51OE4X/POL66noCRL4TOp8zfyt5r0S87yaYlEsZaFCXTn9d7HEudu
	p8V4h9zn+z9NvP99nwlzGjXejKldzFPtjXX2tCy+iphrOE7Zc2jFmAdt6NTxqCTzWi98m1
	cxkdLKadocpvq6QoQCkjbLAyCawE5kU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-OG7fCA72PGO215dUMcZuVQ-1; Thu, 04 Dec 2025 04:37:01 -0500
X-MC-Unique: OG7fCA72PGO215dUMcZuVQ-1
X-Mimecast-MFC-AGG-ID: OG7fCA72PGO215dUMcZuVQ_1764841021
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-787e3b03cc2so10651757b3.1
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 01:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764841021; x=1765445821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qeEjzVz7GQk6EpiDzPclRlc2LVPc/X5pecZGz9q1Q90=;
        b=r1Rx+As2aWn+zaUTXL6yLWtBFKVVdzvDGj0dOthFbb7XmrHY70fg0ewdCdO4OARN0a
         3LopROOSeiaPGuEUtzae03ri0ndDaafsRr/KU+X638/Duzz9/hK3Wjs0CRexKNfDly7R
         lw4B6FKXGP4u1oVCQwuOL5ovVFGoOqqquaTMFWUZqx32h0dCHTwh0vy4yBZP0fITwBcj
         ND1vkWXtosvEhggBtcoY6pMIqUBWWwqPR0ybMWePt3VNzuni7xGxbPyc29AGcC6Ci+sH
         GDx0+ws6SebIUSjAQXqOgXD4I6QGMyuPiEeh/phy3rEDMNXK7XCxjuRzZTcQ3qVx0Ec+
         1PJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxT+2l683KYTFXeZxzZs3yUTAlH+EOOAJ5VX71xqE0WyAClVNhKg1zsrr5G5RbHrqOHLczZC0pjOczvKVdIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdR1Al08mtonLApDa08XOFR6O6ZggXiSxNWNSPnaEfFDhOnJZZ
	Se2mPP6H/gpb8VLCjegmBtEYTcwQcadobaKq4VAGR9ivxVU5Cmb7f23GHutDmcdnZHl+ws0fv2J
	G76GgBW7eZUntJUmiX1eCitlvIUYnwmfpK2B588mz19iMbzR9QlRkUNho+hVjOuMCc8ZHsacoHd
	WGD/pXfBw2kVdpDVckzvPy1gKTZuQPMxXPEaaSqF43WOk=
X-Gm-Gg: ASbGncsWIoOyMZnf8DG2dZRU44/O+A5lPGjYrZGAPZjHWtK99PSFgGtkj2Q1ojiCVyK
	76VOXAGTP+nOzEw6vrKdAoiUXHoP82E/oBTz5SeWopuUGuyUSOKhfWU9eZaEVHlWuaGzsV3dToN
	hGaskjYVNEOL7L0+SOEsli7jyaAT83rwOHYmIKv16uXTNZ5D9ily11WE3lZhxRsv48
X-Received: by 2002:a05:690c:6713:b0:786:4fd5:e5de with SMTP id 00721157ae682-78c0c210028mr42666177b3.67.1764841021009;
        Thu, 04 Dec 2025 01:37:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBJRkWOGl554rCJxMS1W+VD+59CzpNDKchBFktxp0UKkP2qgdZoPND338wG5ha+uJ8PPPkfv0dwHOd25ifO9U=
X-Received: by 2002:a05:690c:6713:b0:786:4fd5:e5de with SMTP id
 00721157ae682-78c0c210028mr42666067b3.67.1764841020714; Thu, 04 Dec 2025
 01:37:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
 <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
In-Reply-To: <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 4 Dec 2025 10:36:49 +0100
X-Gm-Features: AWmQ_blRRqbIFTY0f39yIA51TqtDoPBldWIhSqZwhzNWbMT5aHjbQPCsAOYEw2M
Message-ID: <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iLQnvldUIBIv2EvZ-YWtUxDdMcLWzficBmWZzQRSr68_1764841021
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 11:31=E2=80=AFAM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
> On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail=
.com> wrote:
> > This one should also be dropped because the 'prev' and 'new' are in
> > the wrong order.
>
> Ouch. Thanks for pointing this out.

Linus has merged the fix for this bug now, so this patch can be
updated / re-added.

Thanks,
Andreas

