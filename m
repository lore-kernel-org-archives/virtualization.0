Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE242D0617
	for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766680041; cv=none; b=q3WNC1NOIdy+/duiXSmJYiYEJW4wmchBfepfVBwWbpQ/n80LJtRr2qC6keVw5mOUsh/8V0V4aTblSpLDpwA8JK7XbngN6QOZMz42KhoWnxEZ5DQOQl3McZm6L1KvaDQXEzfgCIHBnf+q4romGQBWOFJGSaPeF+DDrjbDNpf6hVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766680041; c=relaxed/simple;
	bh=vv1phZqix/ryOn4SSA6WVQ7/V1Efqn5k4N47N/zr0mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VdQyFn/OCs8X1uY6WkPrTMSiCE+fumarEHfD1A286YeawoD4KIqBDW792dps7i4gskYBQ/NBBb+bu4toP8OkrCNwolNgxmskKWh7r3VWIB03zPmt3DTXCHd6q/W8JvQVfQyyXiXPm0zZmITbjoSFzCtuzoRLWP6c0q7hV1El/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbNxra6+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbNxra6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766680038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n/GZnGNU0TUGeQc/Z49ZORFqF8Kc+GJGvY+J18xzKb8=;
	b=PbNxra6+Hd55H+efDAA7nj8i9LvsR/9QcdmNP9buOk8cP01erL7rkN93jtfKdb2Sibc2fJ
	nrstI1dwZ0V1IszxuCWAbx2NJis8iRTpt0JrD5oGwnPg+xiCIAq7P2/5ibbmOgb0xe2YhQ
	VfKkY4fnHIOs0/RRStWs/4NZ9aJ7quI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-UCWbN2O5PhWYZo-hwlOkGQ-1; Thu, 25 Dec 2025 11:27:15 -0500
X-MC-Unique: UCWbN2O5PhWYZo-hwlOkGQ-1
X-Mimecast-MFC-AGG-ID: UCWbN2O5PhWYZo-hwlOkGQ_1766680034
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477964c22e0so45717645e9.0
        for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 08:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766680034; x=1767284834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/GZnGNU0TUGeQc/Z49ZORFqF8Kc+GJGvY+J18xzKb8=;
        b=F3Lf8ue3T5kzr9Jy9qWRydKPeq+x1wC4p0ARfVYMFY4lWDVFUcBAlzKoQkAUCVtzU/
         VunzZ9qRRzoZlQ4JCbIMWGCjfIasWoB54CV4bjRgsIlbT3exPo0nyWQb1doF4HK/f5R6
         kDDMIaL7AEiutlKk2YHthoEyLOXaGpB9sv5V/bj1xnNkIrpxu8l0bXHxs3JYRo8B3BZB
         tQ8CgJ1cLCoiyfQOhioYkm4r2RuDM5u1AhnZ/97uvVu1c1xNW7Lv8XzRgZGp2EbnsOUJ
         bsp4yHagQULoaiKMv9FZ1EqUvZohxawo5xUeOx9f9IT1jKbDkSiXZFeRpoBqnBP9x69x
         fVxA==
X-Forwarded-Encrypted: i=1; AJvYcCVKD5zVUaKDV57sBdfELURdSgJ6zI1ZTbtDofjLU3p/YmSfSBPgRL1X3VL9nx5T4Uzj2BeIeQK0p/7eoPqJvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YymKUxJKYZBn/LelnphMZStBfCeO/0UGiATXjgnvsWjjZfs8CcR
	Xv9oLkfadClNw9IC8fADTr+RxZwmzEXnutlT0te8FSAFyIC5QsRjBc+LQznyR0XpU8BfRSeMsq4
	D0alZ8JbehBoodSV3/dSiTf1AIr7gNXXv9SazS5MuEAYVHZNPST9llMNSj/vc6shm+C5l
X-Gm-Gg: AY/fxX7v5E5meldL6uxYI+gzrPInOevNrNgjjIoYg2aJXmgdg1vzMGZuUaW+N1CGzJL
	l2PopqatZem+pilSAZ0DetF/TrhOr5cwDv028WgM0pOfceDOM4zRiiIgLHBxon++x49JeI2tpHt
	y8a1Ql2yZHynYodD3pR3YbJ5R+77TGiSe6MT68ighuEU4jvfg5gmwXiYVzkcAQzMx6OWltL1u65
	fbpDfFJ3SYvne05SCbioLxQMRsESFvoEE3JDfQ4+/kM3ZRyrnjaHL88xd3e+Qlwjsv20+lZ6fvV
	XRQESWhKTVGJKxF47Ai2c3BtAYvtyOhAVBhFwa/eN+EQIVYBzAtyptmGjWSI/+Offcr+ecLD12u
	6rlhdbdFortCdpP6fHhdKGA7Fg20FeXsN6Q==
X-Received: by 2002:a05:600c:8718:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d18b0ad6fmr209121215e9.0.1766680034040;
        Thu, 25 Dec 2025 08:27:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExHtOTrO6amFRMKKbbMC2la+j516gOLyPplDk/OSZh4gRdGY/ppOsxF00RFw07Xle4k8vO4Q==
X-Received: by 2002:a05:600c:8718:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d18b0ad6fmr209120785e9.0.1766680033471;
        Thu, 25 Dec 2025 08:27:13 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19352306sm344339415e9.5.2025.12.25.08.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 08:27:12 -0800 (PST)
Date: Thu, 25 Dec 2025 11:27:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251225112636-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <75e32d60-51b1-4c46-bd43-d17af7440e74@gmail.com>
 <dd4d01d7-29a8-43b3-bb5b-f50ea384aadb@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <dd4d01d7-29a8-43b3-bb5b-f50ea384aadb@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nMMcQkJDx9aAfsSptorJ_OWcqTHkfoH28xw6udLmp-Q_1766680034
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 25, 2025 at 10:55:36PM +0700, Bui Quang Minh wrote:
> On 12/24/25 23:49, Bui Quang Minh wrote:
> > On 12/24/25 08:47, Michael S. Tsirkin wrote:
> > > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > > > Hi Jason,
> > > > 
> > > > I'm wondering why we even need this refill work. Why not simply
> > > > let NAPI retry
> > > > the refill on its next run if the refill fails? That would seem
> > > > much simpler.
> > > > This refill work complicates maintenance and often introduces a lot of
> > > > concurrency issues and races.
> > > > 
> > > > Thanks.
> > > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> > > 
> > > And if GFP_ATOMIC failed, aggressively retrying might not be a great
> > > idea.
> > > 
> > > Not saying refill work is a great hack, but that is the reason for it.
> > 
> > In case no allocated received buffer and NAPI refill fails, the host
> > will not send any packets. If there is no busy polling loop either, the
> > RX will be stuck. That's also the reason why we need refill work. Is it
> > correct?
> 
> I've just looked at mlx5e_napi_poll which is mentioned by Jason. So if we
> want to retry refilling in the next NAPI, we can set a bool (e.g.
> retry_refill) in virtnet_receive, then in virtnet_poll, we don't call
> virtqueue_napi_complete. As a result, our napi poll is still in the
> softirq's poll list, so we don't need a new host packet to trigger
> virtqueue's callback which calls napi_schedule again.
> > 
> > Thanks,
> > Quang Minh.
> > 
>


yes yes.
but aggressively retrying GFP_ATOMIC until it works is not the thing to
do.

-- 
MST

