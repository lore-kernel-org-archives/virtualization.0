Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098B94D8CB
	for <virtualization@lists.linux.dev>; Sun,  8 Sep 2024 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790747; cv=none; b=q6dTb6QbKTl8HEgmldI4uQj58Iau04Lb2O40HWtMqC2Jt3VrEt+XwtlY4ts45JubL3ImDf6CjHmtkXDiUKaPCQ+xoObWo8XVyWRVy/BpM4yjfECmkV6GZmPIDaJFAM5TGHR5c58ueOp6tzm2PV1j7cTlZ3+LloRi5ZB0E9g2hNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790747; c=relaxed/simple;
	bh=DRWxifU7vwmXwZB1tK+ZP/dk9fsH+VAnzqPMHgRvXeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ifc8k+PGgoy7lTF/wu+c2dCGo1mJfsOzGvyK9NzWFZ5Ut2FsAr2OaUDDVVMiWdIxLsfc7ypPpiQjMb2DnYDfAhZnCBKSsh/SCkqLdnw3FGXd9hTjApNc6t/MlGaWQ/0TLxCOsMDq/GGsx6XvyC+vYZZkFwq0F1guTqEXb8DmBJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbN2qlHh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbN2qlHh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725790744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVqEQQ8qNMoeL+c6yr06XEkBQ3WYJ641g5XPFAKQmsE=;
	b=NbN2qlHh0+hZ3/Yd6R/DXf7XakMqo8NrkXPlUOyDNhF7PVMeoBMOfUjQTGAqqnv4wq7reX
	+bb3g9gRiET4W7YiUm9GMryuM9nnvchJZpB4fzTcxv+ewgCT6MevXMocHEtjVU083JCNW6
	qiSnF+QgRL08dM+XOQQOBN9mQZpztcs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-8OgC9gBBNc2_bzxKdsrzOA-1; Sun, 08 Sep 2024 06:19:03 -0400
X-MC-Unique: 8OgC9gBBNc2_bzxKdsrzOA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c24cd1e1bdso2381809a12.2
        for <virtualization@lists.linux.dev>; Sun, 08 Sep 2024 03:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725790742; x=1726395542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVqEQQ8qNMoeL+c6yr06XEkBQ3WYJ641g5XPFAKQmsE=;
        b=sLoyFiwh1eyf3oIUi3TaoDamb5fdTTZwnP/PgWju8Tkd4wBlA/d/8doix6G4RIaKsM
         MK/yxFbFY83H8rwjRDvmB9jb11m+Qf0NU10FkT7yGAf5TZP6bgtyix1hvjvUp7NEvqfc
         xudVnxrtK1KxFEThKglVmTh7n7KKwHyQ9ajHSmfUjE8zkgQF0hEh3jgTcahXMv4VImWW
         1az1YrNXq6KQVx9nTZaRR/tyRGpWw0Ah1OjbuOZAge+0wRcIiGabrNmiemPfqGYmpIjE
         8Qy9pvatfpvAyEB82s+OItEHOrRSoONoZ1sDjqKGA0bvbLBY62tOhHKw/XLSuqyuP0Cx
         KvHw==
X-Forwarded-Encrypted: i=1; AJvYcCXICuQ7EirIJTKcp0u56K5WjwPGiDBxSPveNIVfriA6mIgaBy3HkIqLtec+vFRTCStk5ARu3WOn1PXXtYYLzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMmyeIxQrJty4ubDfiOx02SKrPEyNBToT3WNVHIineSPp2kZiL
	Tpu9Ta0s1tv5Rn8W2ce5AInWpwpsvdSl3PpRmXAobeB/vHMO/5WhHAeYI8yfnVhe3NpSdhyANE1
	bxePZN62KMTD867GCEV3kwskFsrFCZXpbawT509rllooZItTCq4U1D0+hKbdF5ADx
X-Received: by 2002:a05:6402:27cb:b0:5c2:70a2:5e41 with SMTP id 4fb4d7f45d1cf-5c3dc7b8318mr6536182a12.28.1725790742056;
        Sun, 08 Sep 2024 03:19:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5FXNB8NTJzuChrUg8oo4i2APrka7tk7A5aRFH/8gtXFH6jOPKxaIOviKYhW8L1DkTfI4Evw==
X-Received: by 2002:a05:6402:27cb:b0:5c2:70a2:5e41 with SMTP id 4fb4d7f45d1cf-5c3dc7b8318mr6536142a12.28.1725790740747;
        Sun, 08 Sep 2024 03:19:00 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:17aa:6194:fdaa:53cf:2b5f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8cc1dsm1671109a12.94.2024.09.08.03.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 03:18:59 -0700 (PDT)
Date: Sun, 8 Sep 2024 06:18:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Takero Funaki <flintglass@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Message-ID: <20240908061810-mutt-send-email-mst@kernel.org>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240906044143-mutt-send-email-mst@kernel.org>
 <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
 <20240906045904-mutt-send-email-mst@kernel.org>
 <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>
 <20240906053922-mutt-send-email-mst@kernel.org>
 <1725615962.9178205-1-xuanzhuo@linux.alibaba.com>
 <20240906055236-mutt-send-email-mst@kernel.org>
 <CAPpodde7Bi4ewzPqPC0ZNAMdy=3LYgzUHsADZKFgGniUCRdrRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAPpodde7Bi4ewzPqPC0ZNAMdy=3LYgzUHsADZKFgGniUCRdrRg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Sep 07, 2024 at 12:16:24PM +0900, Takero Funaki wrote:
> 2024年9月6日(金) 18:55 Michael S. Tsirkin <mst@redhat.com>:
> >
> > On Fri, Sep 06, 2024 at 05:46:02PM +0800, Xuan Zhuo wrote:
> > > On Fri, 6 Sep 2024 05:44:27 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Fri, Sep 06, 2024 at 05:25:36PM +0800, Xuan Zhuo wrote:
> > > > > On Fri, 6 Sep 2024 05:08:56 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> > > > > > > On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > > > > > > > > leads to regression on VM with the sysctl value of:
> > > > > > > > >
> > > > > > > > > - net.core.high_order_alloc_disable=1
> > > > > > > > >
> > > > > > > > > which could see reliable crashes or scp failure (scp a file 100M in size
> > > > > > > > > to VM):
> > > > > > > > >
> > > > > > > > > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> > > > > > > > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > > > > > > > everything is fine. However, if the frag is only one page and the
> > > > > > > > > total size of the buffer and virtnet_rq_dma is larger than one page, an
> > > > > > > > > overflow may occur. In this case, if an overflow is possible, I adjust
> > > > > > > > > the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> > > > > > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> > > > > > > > > the first buffer of the frag is affected.
> > > > > > > > >
> > > > > > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> > > > > > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > > > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > >
> > > > > > > >
> > > > > > > > Guys where are we going with this? We have a crasher right now,
> > > > > > > > if this is not fixed ASAP I'd have to revert a ton of
> > > > > > > > work Xuan Zhuo just did.
> > > > > > >
> > > > > > > I think this patch can fix it and I tested it.
> > > > > > > But Darren said this patch did not work.
> > > > > > > I need more info about the crash that Darren encountered.
> > > > > > >
> > > > > > > Thanks.
> > > > > >
> > > > > > So what are we doing? Revert the whole pile for now?
> > > > > > Seems to be a bit of a pity, but maybe that's the best we can do
> > > > > > for this release.
> > > > >
> > > > > @Jason Could you review this?
> > > > >
> > > > > I think this problem is clear, though I do not know why it did not work
> > > > > for Darren.
> > > > >
> > > > > Thanks.
> > > > >
> > > >
> > > > No regressions is a hard rule. If we can't figure out the regression
> > > > now, we should revert and you can try again for the next release.
> > >
> > > I see. I think I fixed it.
> > >
> > > Hope Darren can reply before you post the revert patches.
> > >
> > > Thanks.
> > >
> >
> > It's very rushed anyway. I posted the reverts, but as RFC for now.
> > You should post a debugging patch for Darren to help you figure
> > out what is going on.
> >
> >
> 
> Hello,
> 
> My issue [1], which bisected to the commit f9dac92ba908, was resolved
> after applying the patch on v6.11-rc6.
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219154
> 
> In my case, random crashes occur when receiving large data under heavy
> memory/IO load. Although the crash details differ, the memory
> corruption during data transfers is consistent.
> 
> If Darren is unable to confirm the fix, would it be possible to
> consider merging this patch to close [1] instead?
> 
> Thanks.


Could you also test
https://lore.kernel.org/all/cover.1725616135.git.mst@redhat.com/

please?

