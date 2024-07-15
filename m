Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A456446
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074324; cv=none; b=LCEfI/fDln6O/NsBpnqViTrwl2X7DCWIIOTBhnP0ZLynPaS+8vwyqoPE5r/a7lDsVauNfCxfJTbc4tRIMvdDQ8t2nzA9jpNK0sNET9PAq86Iv/1OG9klYXUTwDwdjP5JQYxa7I/rIN2i3Ocr3kBm82S1yJR87mlnhf1QWuWaZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074324; c=relaxed/simple;
	bh=qRijKDE2WB4CmAcrbM+GaBZ+3De9hfvyJ2SDyHeHXiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ATH1VrIJyI/C+9tn/a4EEsgOeVjN3d/cPHdc6YvONgcpiP7unJQOG19DEiQ6Qp4LdeA4wemTFjWXnrNu2C3l85KL6pY9N4MaUx/vu5YUIsa9a7RGTdwKW6f/iOjD4qkKU3tHOakd5vX6tmdK7c8t/+JbK/C3jmQCDoYayNjkwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZdT7Y5U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZdT7Y5U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721074320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfWngamyaxDL68vd1jlF67juEeKJbmPqBg7+SRmfl20=;
	b=SZdT7Y5U24pvqA+u0s164Uj/PaxWsz3Uv+PNcJohiScjZx+JdEK1fclZM9UMZONrEWNaDy
	dc2HsfQclwxcyzo0iglIg+fHj5e+36fhhxrLph5QHb8i3UXECkDaN0GMKJP4HO4wvmCjXf
	YPve/lme0n7Rl63ds2+Oyxzsj5reJxs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-O3570j0DNVW0u24nfMUWgw-1; Mon, 15 Jul 2024 16:11:59 -0400
X-MC-Unique: O3570j0DNVW0u24nfMUWgw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-427a7a65e7dso11215295e9.1
        for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 13:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074318; x=1721679118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfWngamyaxDL68vd1jlF67juEeKJbmPqBg7+SRmfl20=;
        b=mG34nnKyNzK8F9JT+ObWTSRQUGOlvqcwEgqwMuiTs0yVYOi+9XOTHKuxiqGslfhZ6G
         7DipO2q1mkKCV9uxZoxmzQg90/bKHQQJmVwX9xoZeK5brnoqEe3wfBieZKOHKEHrTHmS
         MF58lVsdRQgymKS72OS8q0aBD5dyE//FkirBrUbwgfDMkVh39zyFnc9HOmdXRzrrlzuL
         TMR7ZPG5Cwas8o3C+Ekr8oRIGi5LTTbwXsn99VSOdeot1lywxItwDy7zrEsYcd4eoUFw
         aB1qtlgLqdEoIty7ziTDaVadc3cnBgv+ispdBYmEPF+o5ti40xkbM/+fSXFUi4DFVf+Q
         kWMA==
X-Forwarded-Encrypted: i=1; AJvYcCXV1gPpqcqnq/raaxEFfsnalYyAgvjq+uUGDgQZyuMXRQggW6+eVwnqi4fBRcBXK5EM6c3eXmEaQ1ypAvF4+/cttLDzHWfaRCR98keLMn8=
X-Gm-Message-State: AOJu0YyEE/dA7qrhFEjMAfSJBvprmPwTO7KEfRvv6rYvUOiMd/LG59f4
	mAbCPDv1uUrHGDn83nliWG+cz10bebY0Dy8dT0pqZ1Ta/L51/S5Q2yqbXIk8tzCTc3uWDAl/62K
	TU2ch5pH8QCtX0LQViNPyfyxspQoEsxBGdVmrWAiEF3ELsdf/TDUpf41VquxN1vqI
X-Received: by 2002:a05:600c:1592:b0:426:6f26:d7f4 with SMTP id 5b1f17b1804b1-4279da43452mr100799425e9.18.1721074318170;
        Mon, 15 Jul 2024 13:11:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLLNB0KB2uwBkyWtQnciT2LnO8RnJp3yMQCVRUKdb/wCGQt2Ac0TOr/0Rjp3uDeV+znXGPAg==
X-Received: by 2002:a05:600c:1592:b0:426:6f26:d7f4 with SMTP id 5b1f17b1804b1-4279da43452mr100799255e9.18.1721074317501;
        Mon, 15 Jul 2024 13:11:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:243:da88:7ff9:68fc:2f43:bcdf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e8e2ecsm100817845e9.21.2024.07.15.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 13:11:56 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:11:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Potapenko <glider@google.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [PATCH] virtio_ring: fix KMSAN error for premapped mode
Message-ID: <20240715161130-mutt-send-email-mst@kernel.org>
References: <20240606111345.93600-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtZWJJ1TxnbDLio28M1_0mUZmDd_HbQrZOVB9ixKoLbMQ@mail.gmail.com>
 <CAG_fn=Xe+XQROUqZ9zy94BXVj8SRKprW3fUj_0rD3AhSAvtn-w@mail.gmail.com>
 <20240624095629-mutt-send-email-mst@kernel.org>
 <CAG_fn=VwB_EepsY7GcMM2ihz77vtWDR3tsxJ6iD0Sdx-wQVx+g@mail.gmail.com>
 <20240715102018-mutt-send-email-mst@kernel.org>
 <090a8152eab55555b23b1a7605520567ce0bffa3.camel@linux.ibm.com>
 <20240715120606-mutt-send-email-mst@kernel.org>
 <CAG_fn=X4B6PJZpV15M4dAbxSb9euuCYpEr=8yZ0ak1C+bNzo3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAG_fn=X4B6PJZpV15M4dAbxSb9euuCYpEr=8yZ0ak1C+bNzo3A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 15, 2024 at 06:32:52PM +0200, Alexander Potapenko wrote:
> On Mon, Jul 15, 2024 at 6:06 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 15, 2024 at 05:30:49PM +0200, Ilya Leoshkevich wrote:
> > > On Mon, 2024-07-15 at 10:20 -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Jul 15, 2024 at 03:24:17PM +0200, Alexander Potapenko wrote:
> > > > > On Mon, Jun 24, 2024 at 3:57 PM Michael S. Tsirkin <mst@redhat.com>
> > > > > wrote:
> > > > > >
> > > > > > On Mon, Jun 24, 2024 at 03:51:50PM +0200, Alexander Potapenko
> > > > > > wrote:
> > > > > > > On Fri, Jun 7, 2024 at 8:34 AM Jason Wang <jasowang@redhat.com>
> > > > > > > wrote:
> > > > > > > >
> > > > > > > > On Thu, Jun 6, 2024 at 7:13 PM Xuan Zhuo
> > > > > > > > <xuanzhuo@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > Add kmsan for virtqueue_dma_map_single_attrs to fix:
> > > > > > > > >
> > > > > > > > > BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
> > > > > > > > >  receive_buf+0x45ca/0x6990
> > > > > > > > >  virtnet_poll+0x17e0/0x3130
> > > > > > > > >  net_rx_action+0x832/0x26e0
> > > > > > > > >  handle_softirqs+0x330/0x10f0
> > > > > > > > >  [...]
> > > > > > > > >
> > > > > > > > > Uninit was created at:
> > > > > > > > >  __alloc_pages_noprof+0x62a/0xe60
> > > > > > > > >  alloc_pages_noprof+0x392/0x830
> > > > > > > > >  skb_page_frag_refill+0x21a/0x5c0
> > > > > > > > >  virtnet_rq_alloc+0x50/0x1500
> > > > > > > > >  try_fill_recv+0x372/0x54c0
> > > > > > > > >  virtnet_open+0x210/0xbe0
> > > > > > > > >  __dev_open+0x56e/0x920
> > > > > > > > >  __dev_change_flags+0x39c/0x2000
> > > > > > > > >  dev_change_flags+0xaa/0x200
> > > > > > > > >  do_setlink+0x197a/0x7420
> > > > > > > > >  rtnl_setlink+0x77c/0x860
> > > > > > > > >  [...]
> > > > > > > > >
> > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > Tested-by: Alexander Potapenko <glider@google.com>
> > > > > > > >
> > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > >
> > > > > > > Jason, Michael, any chance this patch can make it to 6.10?
> > > > > > > The bug in question has essentially been blocking KMSAN on
> > > > > > > syzbot for
> > > > > > > the past month:
> > > > > > > https://syzkaller.appspot.com/bug?id=2819883f3d376b703e686e700fde00a01eec62fa
> > > > > > >
> > > > > > > The patch should probably have
> > > > > > >   Fixes: b6253b4e21939 ("virtio_ring: introduce dma map api for
> > > > > > > virtqueue")
> > > > > > >
> > > > > > > , but I am not exactly sure why syzkaller only started
> > > > > > > triggering the
> > > > > > > bug this year, given that the patch dates back to 2023.
> > > > > >
> > > > > > Yes that's probably a good idea. I will queue it with this tag.
> > > > >
> > > > > Hi Michael,
> > > > >
> > > > > Looks like the patch is still stuck in the limbo :(
> > > >
> > > > It should be in linux next. Don't you see it there?
> 
> It's there, sorry for the confusion.
> However the KMSAN builder doesn't test -next, so it will be down until
> the fix(es) reach torvalds/linux.
> 
> > > FWIW I ran linux-next with KMSAN today and this fix was already there.
> > >
> > > But in the meantime another similarly looking issue crept in:
> > >
> > > https://lore.kernel.org/netdev/20240712195759.GA2972562@myrica/T/
> >
> > I remember picking up that fix for next, too. Not there?
> > Not at the testing box right now.
> 
> I don't see the patch referenced by Ilya in linux-next/master either.

Oh right, there was confusion with net-next.
Thanks for pointing this out.

-- 
MST

