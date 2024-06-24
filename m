Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D45140399
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237154; cv=none; b=OQ/92vYzNAhrKzikIg3NRGMTxfto0Or/PGYNX5GeH0wkFr2PiOzIeq5cccLH58IxzFyHjybipm0z8vNm2Ct+pgSj2aSfBGD4mOcnwCOxi+tN3KEdYrc49Iw/jApgvABi4Dzw5AMBVLX8XPQiZ/8hWeI/Usx6dL2urdhMrW8EEpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237154; c=relaxed/simple;
	bh=DcPfmR1l4bModJlCqUxPpDWrYmgLAwKMchvIGQs+0gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/zqkg3J6LixnX/9lACkmljQST9x2e8Skdssca4NdNV07V5s1KwIQN5km6lR1Fwj6Rh+3qKmC9zf7dfLWiWGRop1XxQ/kjJObZkJMrJ/lgIp0EDhVl1DcYqDx1anRU7NOQye7ElRigqmWrtNCCT5i5zDyLjKlN0rJDF4HnqqPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LF9bi/jc; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LF9bi/jc"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7955af79812so246022485a.1
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719237152; x=1719841952; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EDsLn1OgzRgyNhEu4xvrhQi5e7pRWLpS/h4W2a5wsU=;
        b=LF9bi/jcF5wbsqpVFRmxJQiO31+5DC4aqphbDhmCZPpW/E3PqNPOvqTmQTMIIAQWTI
         ADyWbeiWMD+op4mOLBkyj3B84lQSuqtfKaRwvLjP1B0DeybcQe5etZe6a5eBLvFUBfyp
         p0I/NssLHXkn/6FzhFP35TfwWKxAVz17owZxbP/Z8SJuno+hv1OfKVeyXVkSvHa7GrYo
         Cb08VC0M88DDRYhxS1CukDVJV57bHeGxPQrGMf1mGvbVUAN82i8yNEpTVPnBTqdC+Zor
         1bapEbVFO3VtLU4kmX8EcPfj7fBj+Nnqkt+j87no2sjVN/wpb+rzH97gCzo4DRJE93yG
         Ecpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719237152; x=1719841952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EDsLn1OgzRgyNhEu4xvrhQi5e7pRWLpS/h4W2a5wsU=;
        b=ndQ5rIbn8Rd+G6TmKUhvMSSmNi1KU5IrMjNrH67+s/udqNP0T0sNlY8Lcd9lD8D1ai
         vb5veY3x+vlCXajLocbclJ+rYtbKHzw5Sj58eCmCuTKJH4DZ2eSd03W+FtWclMcmTEUY
         zh7BcXvCeioRWEyodq0oB3C6jqB6KDsBLJ2yLCeTYz8/YvSzzYBVPfk6KBiTDY9IYGsu
         n+c3ecZFh0E/F76tCD//k9Vq67pJLi5SZApxTakTfpZD8Df6h6huoFmrvwPa1aSmU8Ft
         YNKtsjtlycEq/h1GQlaEoBuBXQNM8h/SD42riG0NjomNl8g0l14PSDuK7SN7xtM6ZWB+
         a8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXVjL8lM4wXFU9kdYUbqYgsEdiYTi9zF/hM2UB9o+p+TUmHRpImFBVJJxa068PBV3kgnXpEC/MNGybgFQXoo7i5BMFiAWdZKmj+BUIxj4Y=
X-Gm-Message-State: AOJu0YysMGEFKeXOwVvMpmbbF3pbQsJ37OADz67WFnmxGkXiZK7fDW15
	AFy/kdN6htfC69d/C8ZP6pRwkT3SSKVO+UrkjFSZ+HKUCSt76Et1RsLZ2ldbe0DU6O1BOWwuT/f
	6wL++6tdQpSKqoQ/mmEJUuqOS5Yh/iqMclwZm
X-Google-Smtp-Source: AGHT+IFElQ+3gzo5alcZs2P13akx+VrbUCKVOC71sr0kMTL0rspnVhmcd0pjD9YgW1eZ7h0k9JfWZOuXETrot3Pj8Xc=
X-Received: by 2002:ac8:7f81:0:b0:441:579d:c7f1 with SMTP id
 d75a77b69052e-444d647e664mr53406461cf.20.1719237151648; Mon, 24 Jun 2024
 06:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240606111345.93600-1-xuanzhuo@linux.alibaba.com> <CACGkMEtZWJJ1TxnbDLio28M1_0mUZmDd_HbQrZOVB9ixKoLbMQ@mail.gmail.com>
In-Reply-To: <CACGkMEtZWJJ1TxnbDLio28M1_0mUZmDd_HbQrZOVB9ixKoLbMQ@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 24 Jun 2024 15:51:50 +0200
Message-ID: <CAG_fn=Xe+XQROUqZ9zy94BXVj8SRKprW3fUj_0rD3AhSAvtn-w@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: fix KMSAN error for premapped mode
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:34=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Thu, Jun 6, 2024 at 7:13=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > Add kmsan for virtqueue_dma_map_single_attrs to fix:
> >
> > BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
> >  receive_buf+0x45ca/0x6990
> >  virtnet_poll+0x17e0/0x3130
> >  net_rx_action+0x832/0x26e0
> >  handle_softirqs+0x330/0x10f0
> >  [...]
> >
> > Uninit was created at:
> >  __alloc_pages_noprof+0x62a/0xe60
> >  alloc_pages_noprof+0x392/0x830
> >  skb_page_frag_refill+0x21a/0x5c0
> >  virtnet_rq_alloc+0x50/0x1500
> >  try_fill_recv+0x372/0x54c0
> >  virtnet_open+0x210/0xbe0
> >  __dev_open+0x56e/0x920
> >  __dev_change_flags+0x39c/0x2000
> >  dev_change_flags+0xaa/0x200
> >  do_setlink+0x197a/0x7420
> >  rtnl_setlink+0x77c/0x860
> >  [...]
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Tested-by: Alexander Potapenko <glider@google.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>

Jason, Michael, any chance this patch can make it to 6.10?
The bug in question has essentially been blocking KMSAN on syzbot for
the past month:
https://syzkaller.appspot.com/bug?id=3D2819883f3d376b703e686e700fde00a01eec=
62fa

The patch should probably have
  Fixes: b6253b4e21939 ("virtio_ring: introduce dma map api for virtqueue")

, but I am not exactly sure why syzkaller only started triggering the
bug this year, given that the patch dates back to 2023.
