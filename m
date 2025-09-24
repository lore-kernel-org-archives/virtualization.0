Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54002BDC32
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704106; cv=none; b=HNJRUKogey6BIqnMLSPjw8e0WXie3dw4kSelVpt9zIDwWIG36m/mUzWLGqLVUEXNFXGZQ/SscKnVPPNc9aSgAB+jPNGziTH0KqMrvJ2dWcS3+sVBI2qvpT5NNVJtpGNddo7B3L8AfRd7G9BtVIreMzOUCTpbV/NgBFqr1a4MvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704106; c=relaxed/simple;
	bh=yC4F9BxKMD2tLjzPZNMkOfB70p02zY5u5wUAbNq4KtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=g2tSxrO+zwYnvJtZraOtap+9cRItUJOLnJtVWXwCvQnceVOVViX/OHelziv6QT+5WjzaI4s+88k0YXOgqpiqIigQXFS/qXsBn31cKvayYP6G86pSfPoHV8EWOaA+1GuQwlMQFumH2/mDfbfrYE70vnDx5gDzbcmR60LACvdWAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKPQJMFl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKPQJMFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758704103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oeF4iLafWqiyYhAJj/z0HEWgGu1flHRP9T+bwNm7VOY=;
	b=LKPQJMFlPtlepooEfDAZhUqpUFS1VJAA3mhfz0yE9QIMcmitxyvLd3qKqqj8xGAb2uYCel
	LWnPCTxVOfWE/yWPx+bypCwf0O3FMKvF7CDW2iwAPYNRvfpp3t2p1Xew1FUVr5x2e2xsJx
	yCoZN8VitByyd4ETILd9MBAaIpFmmpc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-oVe_YiSXPGSmMAKxUnZNFg-1; Wed, 24 Sep 2025 04:55:02 -0400
X-MC-Unique: oVe_YiSXPGSmMAKxUnZNFg-1
X-Mimecast-MFC-AGG-ID: oVe_YiSXPGSmMAKxUnZNFg_1758704101
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-62fcb646334so6992751a12.2
        for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 01:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758704101; x=1759308901;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeF4iLafWqiyYhAJj/z0HEWgGu1flHRP9T+bwNm7VOY=;
        b=cTewyaJ4xlM3QSEUE25Mjz08dSqUC9yemx06+oEf4duhrrj5Ey7bMWGKVzVobGgYjG
         MDiu0J+HuV9+/6D7J1kYtrjAUIdo2WCIxJDppvO+tTXhZYo+I7gzeW5JDPxbr+CndLcH
         RhXOBXWXWYGr+9MhTaQF2/7dPK0lApZu8oVn7k4TPWPywkQp/AsLcgsEs0GmXjqZAWuY
         5FMu2cXoRcF1/2GZtRoFJ3o6q9cnvULPC80rm95Z9FgN+Tc1+f21PB2B0zlaYPEz91rN
         /SfyfkL/WEN7iZbbyQa4q34oxRJpsp9zdr0UkuIEKqwe3ZiRupInX0V0hu+BZvMSN0nZ
         MJ8w==
X-Forwarded-Encrypted: i=1; AJvYcCXVlAGgWf2aRaa6ASFgYouCPiEVeZDhWyz4iapBsfFOK2DUODhaVDME+J3bfZjjZRMje+Hj+GEw+z6qHsTd5g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2t6OEqIsSV9bw+EFimcW53JrUCf4KzSlehxRkMXisdjS/Kfad
	g4n+eA7DuEFsDVvy2S+wVVEbbIUEjCQ+gYjZsZJAroxDWL81Ra06det9ro/0Q847hpvun6KR/89
	1u+fW/8xsy2wNOWuzWugKpo3pJCEW8+qIpDxb8xlZ96DuLIIYpqNbW9alxwbrToMSx51D
X-Gm-Gg: ASbGncvxKEMvRs0f7tLrCsiAYiABHRrvzTMW4KbflFaLkWa2/10BHELBQEhPhhve0zU
	b3NeU0rOZzDLWZFhAqbKM2GBWOMKMVzAzcKHjqyxclf3V5mG+LOowupmLtRmv92Pa34q7Wsllij
	fOeL0Fuj0i/Dks7zYIrtT+VFH19FreuCF6cnE7RBUq0kIVNnRbv/HgpcfAQIExsz/+wB9Lb3/dS
	l5g1JCXL74ro2z3UWFvxdYfoa//DM6xgQXt4tiJCoCPJyB7NtZ+KjxP7oALrTWq2BZjqaQkopkH
	4IHl+DQWIyBYuo9E0v7ZQZXiHh+4
X-Received: by 2002:a05:6402:42d4:b0:634:66c8:9e6d with SMTP id 4fb4d7f45d1cf-63467a196c6mr5117519a12.35.1758704100852;
        Wed, 24 Sep 2025 01:55:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsvQzI/barPCHCcY3wmgFpimCqdL8DPZENn3l5dqczZHN9mqSB95iiRU7jvEjFsRYlUtc7jA==
X-Received: by 2002:a05:6402:42d4:b0:634:66c8:9e6d with SMTP id 4fb4d7f45d1cf-63467a196c6mr5117491a12.35.1758704100372;
        Wed, 24 Sep 2025 01:55:00 -0700 (PDT)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d03befsm12964100a12.2.2025.09.24.01.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 01:54:59 -0700 (PDT)
Date: Wed, 24 Sep 2025 04:54:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, eperezma@redhat.com,
	stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
Message-ID: <20250924045430-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250924031105-mutt-send-email-mst@kernel.org>
 <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>
 <20250924034112-mutt-send-email-mst@kernel.org>
 <CACGkMEtdQ8j0AXttjLyPNSKq9-s0tSJPzRtKcWhXTF3M_PkVLQ@mail.gmail.com>
 <20250924040915-mutt-send-email-mst@kernel.org>
 <CACGkMEtfbZv+6BYT-oph1r8HsFTL0dVxcfsEwC6T-OvHOA1Ciw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtfbZv+6BYT-oph1r8HsFTL0dVxcfsEwC6T-OvHOA1Ciw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KPP4pc1Cw2ujx0aknQsfYC-auBuxgU1FcuolMuPsNdg_1758704101
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 24, 2025 at 04:30:45PM +0800, Jason Wang wrote:
> On Wed, Sep 24, 2025 at 4:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Sep 24, 2025 at 04:08:33PM +0800, Jason Wang wrote:
> > > On Wed, Sep 24, 2025 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Sep 24, 2025 at 03:33:08PM +0800, Jason Wang wrote:
> > > > > On Wed, Sep 24, 2025 at 3:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> > > > > > > This patch series deals with TUN, TAP and vhost_net which drop incoming
> > > > > > > SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> > > > > > > patch series, the associated netdev queue is stopped before this happens.
> > > > > > > This allows the connected qdisc to function correctly as reported by [1]
> > > > > > > and improves application-layer performance, see our paper [2]. Meanwhile
> > > > > > > the theoretical performance differs only slightly:
> > > > > >
> > > > > >
> > > > > > About this whole approach.
> > > > > > What if userspace is not consuming packets?
> > > > > > Won't the watchdog warnings appear?
> > > > > > Is it safe to allow userspace to block a tx queue
> > > > > > indefinitely?
> > > > >
> > > > > I think it's safe as it's a userspace device, there's no way to
> > > > > guarantee the userspace can process the packet in time (so no watchdog
> > > > > for TUN).
> > > > >
> > > > > Thanks
> > > >
> > > > Hmm. Anyway, I guess if we ever want to enable timeout for tun,
> > > > we can worry about it then.
> > >
> > > The problem is that the skb is freed until userspace calls recvmsg(),
> > > so it would be tricky to implement a watchdog. (Or if we can do, we
> > > can do BQL as well).
> >
> > I thought the watchdog generally watches queues not individual skbs?
> 
> Yes, but only if ndo_tx_timeout is implemented.
> 
> I mean it would be tricky if we want to implement ndo_tx_timeout since
> we can't choose a good timeout.
> 
> Thanks

userspace could supply that, thinkably. anyway, we can worry
about that when we need that.

-- 
MST

