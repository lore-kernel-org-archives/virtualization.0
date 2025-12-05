Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1709F2FDC3D
	for <virtualization@lists.linux.dev>; Fri,  5 Dec 2025 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764924966; cv=none; b=aikNNKhe15rR9o9dUPboaVuWEJGKvHARrnPGWUCiPzZLNhwJ3pALgZuHiwwy9zphpe8wSomwLTrB7FnlOvdJU1LRNqCTxzYkGifhYiq7kxgpQZJybTCxRpKTibx64yN9bv/p2uadfCi0obkJRGvI1mRFodSibHtRwlD+07EDGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764924966; c=relaxed/simple;
	bh=kI/BmZknfJEnMAoux6UNqNWZZavATt2Ci9CEQ2NFztc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W01oBvOE8S6UmAX4iYCzBgl8En9xR012o9ZZq4KLfVq7aFwDVZ8A6AgipDYcnN+K/FydhAVSa3svPAmmsZMZSdBxHqlM39SgY+pJBmGUje2C10Zd8GSLCanEIkyHdOos2xUo4AcNykVC/B1qMx6XT6tZwNik51Ftgiab1+a9R+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cU1RodDP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cU1RodDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764924954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kI/BmZknfJEnMAoux6UNqNWZZavATt2Ci9CEQ2NFztc=;
	b=cU1RodDPJ9JgGz8qtXc7VF3MvDevWO/vhXymqmp8mXJ/UWHccgWSJW/GNykwibIPT2Rb4B
	aheKbDeHd4cad+otO8mOxBjF0bMTVdafR+OsQ9GBiYXTz6msMCDLS/HBZd2L4TEwWFPQzi
	JriTQFJHLH1kHw8/scLqZWaW/JJbpfg=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-aoRow--nNEKmDDNGJJ8ZDg-1; Fri, 05 Dec 2025 03:55:51 -0500
X-MC-Unique: aoRow--nNEKmDDNGJJ8ZDg-1
X-Mimecast-MFC-AGG-ID: aoRow--nNEKmDDNGJJ8ZDg_1764924951
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63e08ae023cso3276764d50.1
        for <virtualization@lists.linux.dev>; Fri, 05 Dec 2025 00:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764924951; x=1765529751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kI/BmZknfJEnMAoux6UNqNWZZavATt2Ci9CEQ2NFztc=;
        b=iqZqc/IG+dpUnU/c1swx8vW8/CQk2fauZNXBVKYYRmNiGvx3nKdtJ9fvtRbwUMIuKv
         Y1IKsFg6MHNABlhrgSykGigcEKjFErD0hhxA2dH0RnoPtJxxQ1ORWGUkeVvSV2T1fnhv
         mB+Kl54sZ57o+FHwI8fng5/X8H4UhIr4tc54r9QnktT14PVN0meG1q3Mkc5/YqQdJx+A
         JyKhBckZsNjELF6c1GlvlsstmFPiooo+iXKy7wKgog5QMVKxzrbN/nMyxp1PhbCiIS+i
         BwZaYGCDKVYuBTutb6z2tKh5oPBy+s5Ap6ufJIgIXLGVc4om5/nqp/2IT3atEuZGcf7y
         liKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/LWKm08wTVZcwcZC72tF9kR7uz1yZlNTQnGNJW6aeZH3wK5hytq8HMbWcdC4mHNukEblEv8gaVA4pz4dCng==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPv9NJE2ukvyPNTz2XoOXhin4hSjGHdUNkoU3ZTE6Vh8hxdGXx
	eEwAPR6kB/wzv941iKF+3R72Jbem0pTO/ujI/Y1Vy57Nwvz3UdUDHlOi2M1MvTby+EBq08gvLn/
	RAOfFMFUP4JImub+yqJsYBxgWyDwV7gF9b75oWJ3MFkNkZkv0APQRYeWk7lho0ACcP6jn5PpldO
	QjkBYKqh3pOamspLmPL2hS0xXJNb9C5a4vieSrcAn3xIo=
X-Gm-Gg: ASbGncuZQBF3EPTiDTIVAQlLtI3lzqqWI1cfiZ7r7tBt56is75NU3RcPy5l/ynH19fM
	11qxNQZhELty3mDnUt9kpraa0cYpfojSKJow4yI8iJwz+kNLLiXoCB9RfXav28pmG1udpeqHNhl
	TNEyRO3UGPzEWXLrOKMLE2h8JrCjYE2nAjEgS2BfB8LL9U/Ztc1B4LEjW7q+6GQQSE
X-Received: by 2002:a05:690e:11c7:b0:63f:a876:ae58 with SMTP id 956f58d0204a3-6443d6e683bmr5035627d50.9.1764924951055;
        Fri, 05 Dec 2025 00:55:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH06t5ScTL3/41cXQ9/KNdNBUKke6bRZRDIIsDOJI/s90MmtU+OELXMsXOy8CKQ41Y5BIrK12B8cMtyqGUq3aU=
X-Received: by 2002:a05:690e:11c7:b0:63f:a876:ae58 with SMTP id
 956f58d0204a3-6443d6e683bmr5035612d50.9.1764924950709; Fri, 05 Dec 2025
 00:55:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
 <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
 <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com> <CANubcdVuRNfygyGwnXQpsb2GsHy4=yrzcLC06paUbAMS60+qyA@mail.gmail.com>
In-Reply-To: <CANubcdVuRNfygyGwnXQpsb2GsHy4=yrzcLC06paUbAMS60+qyA@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 5 Dec 2025 09:55:39 +0100
X-Gm-Features: AWmQ_bn5nYIfNoOVXdPvu9TIQvwvBK4TRvGDwrtrakvgOSxNJSsbjWkIZFSXMho
Message-ID: <CAHc6FU4G+5QnSgXoMN726DOTF9R-d88-CrfYMof0kME6P_o-7w@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cBVgAUkwMZA2kXogBRyXKiUV5NAMmg81XuChJOTP-2w_1764924951
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 8:46=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail.co=
m> wrote:
> Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=
=884=E6=97=A5=E5=91=A8=E5=9B=9B 17:37=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Dec 1, 2025 at 11:31=E2=80=AFAM Andreas Gruenbacher <agruenba@r=
edhat.com> wrote:
> > > On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd@g=
mail.com> wrote:
> > > > This one should also be dropped because the 'prev' and 'new' are in
> > > > the wrong order.
> > >
> > > Ouch. Thanks for pointing this out.
> >
> > Linus has merged the fix for this bug now, so this patch can be
> > updated / re-added.
> >
>
> Thank you for the update. I'm not clear on what specifically has been
> merged or how to verify it.
> Could you please clarify which fix was merged,

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8a157e0a0aa5
"gfs2: Fix use of bio_chain"


> and if I should now resubmit the cleanup patches?
>
> Thanks,
> Shida
>
> > Thanks,
> > Andreas
> >
>

