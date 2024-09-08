Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF0E165F06
	for <virtualization@lists.linux.dev>; Sun,  8 Sep 2024 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725818232; cv=none; b=hTsVpGExydZcPsXggHz0BE4cLwDJacuVNhy+hFgaJsjvwvI96BBEGxSs77C48X7Je0FvI/nG6HQcAPNqiQw4hMfdJbhZAlY2RytZuBBc/UuOqcP5eDonSZHWAEMfEDzwdHIKN4xd2j0HqivMKDYtiljEDrr4Ay3cLASc2CcCRPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725818232; c=relaxed/simple;
	bh=OaCQHJoykbEsxKAplnxvc1soId4XaFSZuU76TVD3vaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKkgXDqXow1Mk9FiHHe8UqytzUQTE847k9fkkbDE+4xVoSpxQ3CCYUcuMMydKdjtANsczeJjtpecpMV/dd16xRqxJpcQF6Qo4bkjaCJJsXUMayCR2jAkN1fAdcXcVj9kL0DI0oBheHO/rZAo2EV1DW9ewHKFgR920Yk57956Duc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbcnLayx; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbcnLayx"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e1a7e54b898so3433405276.2
        for <virtualization@lists.linux.dev>; Sun, 08 Sep 2024 10:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725818230; x=1726423030; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaCQHJoykbEsxKAplnxvc1soId4XaFSZuU76TVD3vaM=;
        b=SbcnLayxzSQprISNqYuXrjN32DYqzKQA81sufgzMx60r/ffG2vBsXO787b/gPVMSuI
         F0fWHjivpVe1Q4yDQ9ij8DgjJjEsqalhplXuddmf8ww0Z8hldNCog323A6ry00gdimS+
         lOIoY05XQ7s5XMes+8BE4FYF+RR8h+9JM1VPETXpyyhAkT/MYOhevQ++vZ8aBGC7ZxfA
         w9vBy+641VVbvJhBeUsCyoufgxHb5DJ6+rE4Obc6t0S9ScauL2069iDUzFDJCG3gP9dQ
         cNJEn8//pPgNdEa1KdijH3AgSuWYMivtberM5tWP+Cm9QCc34XXZNpyRLH3m8bSWPh9e
         eMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725818230; x=1726423030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaCQHJoykbEsxKAplnxvc1soId4XaFSZuU76TVD3vaM=;
        b=LkJYxAWLBQhMuHEel/asg9B2nqKbXfshUZ1bE5P2w7vlgttF+QQq16wbqk4Gaq+zT3
         LOCyn/JBgaus7QJi4pFw7uYB2eHluJhEZsjMq8qoMTEYlyySz0J/cFsh7XGZmNQHd0pf
         icSBH/s9PYqs9qLoKhOZs7syyuVSD4efwqdHUigDTGLWhJ5kYWzA71S7ivac6iYCBY36
         pJJwRjxUw0In2z5Hv462FwD/dfuDR6OW/n1ym6beOgu3WI+ls7AwhSJWeWvR0qjOs8Ri
         1XWJ/6fsT2/DirMHQ4Pqn4+37cvjy0A5oP2FI+OsbGq8YzcUCsE/hinxLqAaFHnNJ20+
         R8rA==
X-Forwarded-Encrypted: i=1; AJvYcCXzQOHog4UjtIJAinQpL+KmZu5ujRtArhNyLjmErVYaQLvkCsaSYJ9j6HbC5GAtx3pcl0rsg+vRV0A75P1oCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCMMIUwKECxf27JFCf5WuovBEzFlEHOKS9bm142pxyXuHzWoaP
	uJt0uwm/r006gUrCm3N7nXUjCMDS5d8l6MOdqGlMSMcX4Y1mzo5/ncIoEFM1SnNceMwgsfxOO9d
	y6bCwivxZnAId0vgc4ItPMPQLsyg=
X-Google-Smtp-Source: AGHT+IGk3Og9LGLFwbr9PB8/DBzWRSD3yFkiFAV9EMMN2RKDYU/y5UDEebSPtlq+/apiQby0+YwVjXKC2Uxi092Gq1s=
X-Received: by 2002:a05:6902:1023:b0:e1c:f437:baee with SMTP id
 3f1490d57ef6-e1d346b1885mr8793151276.0.1725818230229; Sun, 08 Sep 2024
 10:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240906044143-mutt-send-email-mst@kernel.org> <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
 <20240906045904-mutt-send-email-mst@kernel.org> <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>
 <20240906053922-mutt-send-email-mst@kernel.org> <1725615962.9178205-1-xuanzhuo@linux.alibaba.com>
 <20240906055236-mutt-send-email-mst@kernel.org> <CAPpodde7Bi4ewzPqPC0ZNAMdy=3LYgzUHsADZKFgGniUCRdrRg@mail.gmail.com>
 <20240908061810-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240908061810-mutt-send-email-mst@kernel.org>
From: Takero Funaki <flintglass@gmail.com>
Date: Mon, 9 Sep 2024 02:56:58 +0900
Message-ID: <CAPpoddeQo3tJL4hiC4Y_RjrHVQkbbaDGB3ngoCj4EAZur=LqBw@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B49=E6=9C=888=E6=97=A5(=E6=97=A5) 19:19 Michael S. Tsirkin <mst@=
redhat.com>:
>
> On Sat, Sep 07, 2024 at 12:16:24PM +0900, Takero Funaki wrote:
> > 2024=E5=B9=B49=E6=9C=886=E6=97=A5(=E9=87=91) 18:55 Michael S. Tsirkin <=
mst@redhat.com>:
> > >
> > > On Fri, Sep 06, 2024 at 05:46:02PM +0800, Xuan Zhuo wrote:
> > > > On Fri, 6 Sep 2024 05:44:27 -0400, "Michael S. Tsirkin" <mst@redhat=
.com> wrote:
> > > > > On Fri, Sep 06, 2024 at 05:25:36PM +0800, Xuan Zhuo wrote:
> > > > > > On Fri, 6 Sep 2024 05:08:56 -0400, "Michael S. Tsirkin" <mst@re=
dhat.com> wrote:
> > > > > > > On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> > > > > > > > On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <ms=
t@redhat.com> wrote:
> > > > > > > > > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote=
:
> > > > > > > > > > leads to regression on VM with the sysctl value of:
> > > > > > > > > >
> > > > > > > > > > - net.core.high_order_alloc_disable=3D1
> > > > > > > > > >
> > > > > > > > > > which could see reliable crashes or scp failure (scp a =
file 100M in size
> > > > > > > > > > to VM):
> > > > > > > > > >
> > > > > > > > > > The issue is that the virtnet_rq_dma takes up 16 bytes =
at the beginning
> > > > > > > > > > of a new frag. When the frag size is larger than PAGE_S=
IZE,
> > > > > > > > > > everything is fine. However, if the frag is only one pa=
ge and the
> > > > > > > > > > total size of the buffer and virtnet_rq_dma is larger t=
han one page, an
> > > > > > > > > > overflow may occur. In this case, if an overflow is pos=
sible, I adjust
> > > > > > > > > > the buffer size. If net.core.high_order_alloc_disable=
=3D1, the maximum
> > > > > > > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_=
disable=3D0, only
> > > > > > > > > > the first buffer of the frag is affected.
> > > > > > > > > >
> > > > > > > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mod=
e whatever use_dma_api")
> > > > > > > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > > > > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8=
e87-ba164a540c0a@oracle.com
> > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Guys where are we going with this? We have a crasher righ=
t now,
> > > > > > > > > if this is not fixed ASAP I'd have to revert a ton of
> > > > > > > > > work Xuan Zhuo just did.
> > > > > > > >
> > > > > > > > I think this patch can fix it and I tested it.
> > > > > > > > But Darren said this patch did not work.
> > > > > > > > I need more info about the crash that Darren encountered.
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > >
> > > > > > > So what are we doing? Revert the whole pile for now?
> > > > > > > Seems to be a bit of a pity, but maybe that's the best we can=
 do
> > > > > > > for this release.
> > > > > >
> > > > > > @Jason Could you review this?
> > > > > >
> > > > > > I think this problem is clear, though I do not know why it did =
not work
> > > > > > for Darren.
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > >
> > > > > No regressions is a hard rule. If we can't figure out the regress=
ion
> > > > > now, we should revert and you can try again for the next release.
> > > >
> > > > I see. I think I fixed it.
> > > >
> > > > Hope Darren can reply before you post the revert patches.
> > > >
> > > > Thanks.
> > > >
> > >
> > > It's very rushed anyway. I posted the reverts, but as RFC for now.
> > > You should post a debugging patch for Darren to help you figure
> > > out what is going on.
> > >
> > >
> >
> > Hello,
> >
> > My issue [1], which bisected to the commit f9dac92ba908, was resolved
> > after applying the patch on v6.11-rc6.
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219154
> >
> > In my case, random crashes occur when receiving large data under heavy
> > memory/IO load. Although the crash details differ, the memory
> > corruption during data transfers is consistent.
> >
> > If Darren is unable to confirm the fix, would it be possible to
> > consider merging this patch to close [1] instead?
> >
> > Thanks.
>
>
> Could you also test
> https://lore.kernel.org/all/cover.1725616135.git.mst@redhat.com/
>
> please?
>

I have confirmed that both your patchset [1] and Xuan's patchset [2]
on v6.11-rc6 successfully resolved my issue.
[1] https://lore.kernel.org/all/cover.1725616135.git.mst@redhat.com/
[2] https://lore.kernel.org/netdev/20240906123137.108741-1-xuanzhuo@linux.a=
libaba.com/

It seems that simply reverting the original patchset would suffice to
resolve the crash.
