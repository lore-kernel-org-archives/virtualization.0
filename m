Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E3338F98
	for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682669; cv=none; b=gd5azL7jppK35cIv+wTXNySwCMT+pUvkgPwQ+Va+Wtfsh9ko6aiIwqsT/10hTJqII3ayn6jzDRdPpZZPp4MqNah7V7FrIuMSuRe6e0Q4tpzjHdXI6Q8B2doBgkzDZ6fKHIe+mLGKDLE1Mj4ydP2sgw/X6gHjvptBvA2RuxGL4i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682669; c=relaxed/simple;
	bh=/fG2JnYUZfUyDB3Lw/EmsvV7Xz+nRAw6bOwVHap1V2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKvc4KuvAHT07ReGsgesTKxCinRU2OSIL1HXMqPSNzrS3s9PAkBZg7GTPbNQpQ05hAcHZ1LZhycReSHCrYth7e1E6Y9raidoq3xlOnk3JsbzynAdNP9ZOQZ/NurPeKr+wYXN/MsEpzApyziEBn25qJVbvyCXCVUQj4e08PkLx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2e4/b4M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2e4/b4M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711682666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Eq/UGEZlb6s/SpvkWTV9xqs1ZCeAFO66kFsPV97qNI=;
	b=W2e4/b4MJD+REuSleTtOGLJi9LspJmr2dPQNb7oT/Nz1NqAGKF0txAwHJmPdLLuAWhwXtV
	EbobrWQhqAtxQeTRIpulKTqEBO2M4g/zbgVQe7AsO8by6r64PKE4zhwCXoNS2Cs8EgvNo7
	3Pla6PnbZS/Bp+MIfBaKkX6vaBtMQNM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-HYwRHu5lPj2_siPHMXyr3w-1; Thu, 28 Mar 2024 23:24:23 -0400
X-MC-Unique: HYwRHu5lPj2_siPHMXyr3w-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29dd9bfd4fdso1578961a91.0
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 20:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711682662; x=1712287462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Eq/UGEZlb6s/SpvkWTV9xqs1ZCeAFO66kFsPV97qNI=;
        b=SN7Y+SIAai0Fox9r/b3/ot62TvpSLJCa6FglmvQ+jehVu78YIyYZs1+T+kNvjj+Raj
         HmIPi0T9LlZeZho7z6pv8uGOv8XZlFkygDI7q0K98EN1YcAZ+/bk2pOUi1Ql1A+IMuch
         fIvJp/edZ8uE9mwCZBfX5MZS39reO1o3uWeUavrwp1aituj4EODgKC97/ziXPBFDctrt
         7zZAoI1TG4P3FADd2AuhRNswhqFPxDAUt0J5m08XTAM1FG5z+aY/0Jk86RAOHcs8nZzh
         c3K8XszyDdVK7adnvZQtD35WLt/yJTJWeO0LhYLAeP6fJTGyuumd8BKspa7IvhjAcfIG
         hxKQ==
X-Gm-Message-State: AOJu0YxtkD8zrlk822G6ngcbgwDP4nfDOx54b78a8RKwFkOKxJ8JkcnO
	v9swsYy9cbaBnv/9Sfkg5YiUXDfZ9qbEnURXT7w5rIHFPqSyJ0N343myk3z8e5Id8Ub1tbfJsQG
	N8a3FwsheZqUsLaWs0vnFbWq9r9jlbnDWItq4SX1iPx0bqP7DsvfmcgeFdEaRMPdlzKJa/+qB2h
	TNFR5wH6+nrUASBKY+e2ioP9MKuH2cwa4uB7lZwCg=
X-Received: by 2002:a17:90b:1b43:b0:2a0:36b6:9683 with SMTP id nv3-20020a17090b1b4300b002a036b69683mr1322858pjb.29.1711682661948;
        Thu, 28 Mar 2024 20:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+EvkvcfjaydeOwYaJW0lwSV7DoBI7aD9GVFLZOcLfK1KCyjQkCEEzGIG4MJUVNxirLFIe6Rq90gxcw8WLRbw=
X-Received: by 2002:a17:90b:1b43:b0:2a0:36b6:9683 with SMTP id
 nv3-20020a17090b1b4300b002a036b69683mr1322849pjb.29.1711682661687; Thu, 28
 Mar 2024 20:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-3-xuanzhuo@linux.alibaba.com> <CACGkMEsG7+mNx4WqhAuhrpk1bhLEwrTzngT5q=CZ_aHkzRasVg@mail.gmail.com>
 <1711610846.0120149-1-xuanzhuo@linux.alibaba.com> <CACGkMEstpEfrnsuLwE2AaceXDzE97kOCu9ukMAeX0O80k9xTUw@mail.gmail.com>
 <1711613734.5560663-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711613734.5560663-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Mar 2024 11:24:10 +0800
Message-ID: <CACGkMEu894Fie1jvFfrfO2KvmKjdDvNBKE+EBELawacAiwPKfw@mail.gmail.com>
Subject: Re: [PATCH vhost v6 02/10] virtio_ring: packed: remove double check
 of the unmap ops
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:16=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 28 Mar 2024 16:07:14 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Mar 28, 2024 at 3:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Thu, 28 Mar 2024 14:56:47 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > In the functions vring_unmap_extra_packed and vring_unmap_desc_pa=
cked,
> > > > > multiple checks are made whether unmap is performed and whether i=
t is
> > > > > INDIRECT.
> > > > >
> > > > > These two functions are usually called in a loop, and we should p=
ut the
> > > > > check outside the loop.
> > > > >
> > > > > And we unmap the descs with VRING_DESC_F_INDIRECT on the same pat=
h with
> > > > > other descs, that make the thing more complex. If we distinguish =
the
> > > > > descs with VRING_DESC_F_INDIRECT before unmap, thing will be clea=
rer.
> > > > >
> > > > > For desc with VRING_DESC_F_INDIRECT flag:
> > > > > 1. only one desc of the desc table is used, we do not need the lo=
op
> > > > >     Theoretically, indirect descriptors could be chained.
> > > > >     But now, that is not supported by "add", so we ignore this ca=
se.
> > > > > 2. the called unmap api is difference from the other desc
> > > > > 3. the vq->premapped is not needed to check
> > > > > 4. the vq->indirect is not needed to check
> > > > > 5. the state->indir_desc must not be null
> > > >
> > > > It doesn't explain the connection to the goal of this series. If it=
's
> > > > not a must I'd suggest moving it to a separate patch.
> > >
> > >
> > > The "no store dma ..." depends this.
> > >
> > > I will add this message in next version.
> > >
> > >
> > > >
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >
> > > > Rethink this, it looks to me it would complicate the codes furtherl=
y.
> > > >
> > > > For example, vring_map_xxx() helpers will check premappred and
> > > > use_dma_api by itself. But in the case of vring_unmap() you want to
> > > > move those checks to the caller. This will result in tricky codes t=
hat
> > > > are hard to understand.
> > > >
> > > > We need to be consistent here.
> > > >
> > > > If we try to optimize unmap we need to optimize map as well. But
> > > > generally it would complicate the logic of the caller if we want to
> > > > let the caller to differ. Ideally, the caller of those function sho=
uld
> > > > know nothing about use_dma_api, premapped and other.
> > >
> > >
> > > The key is that we can check "use_dma_api, premapped" to skip the loo=
p.
> > > If the vring_unmap_xxx is called, the "use_dma_api, premapped" is che=
cked in
> > > advance, so that is a waste to check thest again.
> >
> > Right, but we have the same logic for map.
>
> But we can not skip the loop for map.

Ok, right. So I'm fine to leave it as is. We can optimize the checking
on top anyhow.

Thanks

