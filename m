Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9741B2D600
	for <virtualization@lists.linux.dev>; Fri,  7 Jun 2024 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742090; cv=none; b=pSdJWHlgp6b3P7eHisQn16EHAd0SeQaUPlyhYPTPDJaF6X2szppIt1ekGFUxLtdIWnGv1A8Hpa7UGFoJpAWARB7ABwV9xJZ8h2ZH978/AHiPJdpeeUe8wH8HPYZ7RZbwb2ukGxqF1z3iDXhmFeereY9+r2RcYSZ4YLMjj6FUuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742090; c=relaxed/simple;
	bh=RbzJODhep2gcIiyXyE++vvZuHjaTxdb3/FSkQyADL68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRLEQTijXOVVSZF7zJdKcJbVGhYBu4dlEKtqgzB9Sg+e9W/YYNyczQ3HkfmlAWFrkL5yKzo55mR3/7WKm81oH0diCRi7jbQX+DXPMzG/jn9yZ2Gj356pEwrnh3HRK4iwf/Z/8mRduoQgNlteP3khz15gZULuBhpVWt9L5ptiTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyMuARxo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyMuARxo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717742088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaGgNSVLbGmdtADzAatOqfFlJKS+H2R0vPXjp7XIl6I=;
	b=XyMuARxoYRA+6m95TyopqeSLF/Thiq0onSqqh3asbcR77AUUPsUUOlif2SsotID0PoiHMf
	a/vsn4qkNlXGri3yxXji2MSuMu0mU3KPM6myTh+Uzr8fh+6k10ge8VYcXFGQtkwaCPhj52
	oid0CaGB11WBbxLSZfkX13JmsY9j+Ik=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-YNVTzIrzMdaFQ8KqVxWoyQ-1; Fri, 07 Jun 2024 02:34:47 -0400
X-MC-Unique: YNVTzIrzMdaFQ8KqVxWoyQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c1e6fc4122so1609943a91.0
        for <virtualization@lists.linux.dev>; Thu, 06 Jun 2024 23:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717742086; x=1718346886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaGgNSVLbGmdtADzAatOqfFlJKS+H2R0vPXjp7XIl6I=;
        b=qoderYdBdG50PvO7EhRWpa7ti4orWNg9H4UKSEknWSeIQhN1+Tc9gTUF4NDnYncCxT
         ctiElZBTA86dZqr5pr/O6le7WkOCg1oBY4ChJfIlfWoBw4VKw6sD2oA4OPJBIVLXPLzh
         xAhE+6zPuCRBoKk+QpEoYIRkI1aK/JGZTbzAwoO4sIBIchxt57ssjM3xvLxs9wuc8ZEQ
         /anpT8r5pj9E6xWWfY3XoxA/VNckCBDNrOmyOutnyydkUhzoNmr3mjiDE6KgmAvYHAOO
         RpOJi9Qt2O3b1JK/YoKD7+ajhb7OmjJ4vsJ4h0G7s2gJjExiI2Kt0kztPUYUb24jSb3a
         /wxw==
X-Gm-Message-State: AOJu0YzLVfbNzV7byh3akA3daU/qDOBpIcXI5uNDmX6HvpP5vCYPt5Ok
	mGk54XmHhqYz5vwCHQGts5zxb7h/yWDuMBWkwjPsoEoPzI8ulx9HBvwwle1+a01x3MwQ25DvP2m
	rwqNdCMEXRx6vLylLUMV7FPt1NTjXnShIid4mELdqFo2ienew9xzfj7lKbg5aF54hNbNWSTZEku
	FiJNWKrbHPTNRQkLliQ/MrBA9yeElde1SZ83KGr34=
X-Received: by 2002:a17:90b:3691:b0:2c1:a74d:653a with SMTP id 98e67ed59e1d1-2c2bcacb9f4mr1576889a91.16.1717742085856;
        Thu, 06 Jun 2024 23:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtBe8agKdu3Jnn/0LcBNDLHrirlYtfHbxsEEmLCHh1Pd7LG9jzLfzNNZrmoDDHhP05Jk92hu3SadM7k9HWeoc=
X-Received: by 2002:a17:90b:3691:b0:2c1:a74d:653a with SMTP id
 98e67ed59e1d1-2c2bcacb9f4mr1576874a91.16.1717742085343; Thu, 06 Jun 2024
 23:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240606111345.93600-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240606111345.93600-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jun 2024 14:34:34 +0800
Message-ID: <CACGkMEtZWJJ1TxnbDLio28M1_0mUZmDd_HbQrZOVB9ixKoLbMQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: fix KMSAN error for premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Alexander Potapenko <glider@google.com>, Ilya Leoshkevich <iii@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 7:13=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> Add kmsan for virtqueue_dma_map_single_attrs to fix:
>
> BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
>  receive_buf+0x45ca/0x6990
>  virtnet_poll+0x17e0/0x3130
>  net_rx_action+0x832/0x26e0
>  handle_softirqs+0x330/0x10f0
>  [...]
>
> Uninit was created at:
>  __alloc_pages_noprof+0x62a/0xe60
>  alloc_pages_noprof+0x392/0x830
>  skb_page_frag_refill+0x21a/0x5c0
>  virtnet_rq_alloc+0x50/0x1500
>  try_fill_recv+0x372/0x54c0
>  virtnet_open+0x210/0xbe0
>  __dev_open+0x56e/0x920
>  __dev_change_flags+0x39c/0x2000
>  dev_change_flags+0xaa/0x200
>  do_setlink+0x197a/0x7420
>  rtnl_setlink+0x77c/0x860
>  [...]
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Tested-by: Alexander Potapenko <glider@google.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

