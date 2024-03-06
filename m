Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD961B7E5
	for <virtualization@lists.linux.dev>; Wed,  6 Mar 2024 05:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709703216; cv=none; b=KBhaY+aHvZyjD2rYXa1JBONCV3K1Bw+CywUjbM+7S0dJ7/QAyi8mBe6i5h+ObdebPpDNiVtI36QzFX5efb0r7PSMQ5adWKb5MPYgv7WkVSRZSm90ANQ6mJ1fHPygQUNQafZRirVKHWPUQSJHT/T7HwAxZ5LgQbN1sWw+88we0w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709703216; c=relaxed/simple;
	bh=3hxZI4emF1wYSHuHobZcbBk1gscMxJ+EA04ne/SQOYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFxI292WdoQIh9n9YlDpg7a/KGK04h2NgaiHUWSRdvqu5u4jQM7J8Aaxut4y7Pxsj36denEwCgoFT70DGcGI3ffy/8udSoTBakgm5oqesP57fNfF1yjqtcXM7NaW1ksyOgmgOpo6D76qxSfr2g6qoEDyVYos/CRCFTA8QbNqPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tr8KADRe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tr8KADRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709703213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hxZI4emF1wYSHuHobZcbBk1gscMxJ+EA04ne/SQOYA=;
	b=Tr8KADRe6ejto1C/WSD0BaRjzPGGHakLAQloU2VPFbqxhtAlusUV1TT7Y9733cHf2LRd4G
	/G9GvqX2NdsgHc/dbI9Q8sn0QeGYwC8ZoomlvcQM34ZrSDXTGDv3EAWfkQRjoyYju7cdu0
	k3s78V9DATZWvd+a4bUGXycGnogSg1g=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-i-tdgjvePl-E-n66AvSlUA-1; Wed, 06 Mar 2024 00:33:32 -0500
X-MC-Unique: i-tdgjvePl-E-n66AvSlUA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29b4becb184so2050041a91.0
        for <virtualization@lists.linux.dev>; Tue, 05 Mar 2024 21:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709702908; x=1710307708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hxZI4emF1wYSHuHobZcbBk1gscMxJ+EA04ne/SQOYA=;
        b=r5i/87Usb4MjGSC6AAharh3QrRKA0XM+9lZnHmCt7ns8nDgjkaPNIbS7hJe14UYBOL
         WUubruDtERjTBCtAvV0NFLD3Kk4/nlz2BjsKnbDh6etLmxYTYzmsKkdOWfau6yD1JkOX
         zLGv2UYI+eMsr+PhaSvuDdtIFJtrEJtE98FgeZPkfjui+1iNSXgDEdQJpVJU/uUzN92l
         t7p5aFSX+bKbboAryDburiDh/Mg5nxRLEvEg0cZA0vEwOSfYqb9KJ84C2l89UbBcLdtq
         j/D2BP4F0rpp60BonUYkaWHFvbi216Nz3cbxbAEvOvaXI7v+WKbYg8Ku3nIbATTun6UD
         14dA==
X-Forwarded-Encrypted: i=1; AJvYcCULuR6lkEAjDF+aKtHlaIFciptxbDtREhwrNpFX1MGrOTfD3Rv+xk/23ZNLrYeEpDiqr7dtqxV+ZMARQkjYlUZatD39cbsnfAid2CpGMSM=
X-Gm-Message-State: AOJu0YywKnGuxPEHN+2gjC4cg4ZMxGhgtu37q+O3OZHu9zfF3VEmK4wN
	LrDAqVjh6yL7C8nFAEWZd4zlT98XnUOQa4GjGgE+7BrwU0Y+Iux+dUHxmRycSabX6UH1oPw/wQp
	zLzZJxcdGi6orBmmy5zFj6Nqap8ezGrXjbAuf8K0JhEsQ1EkRp+TIRqrE5RLnt2/84FO0lxP6Z7
	7BZRbuzPYdqnt+hoRDLaQwUS51m3vSCVfOi4XWHl4=
X-Received: by 2002:a17:90a:fa96:b0:299:8957:9898 with SMTP id cu22-20020a17090afa9600b0029989579898mr11177779pjb.42.1709702907977;
        Tue, 05 Mar 2024 21:28:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3Aj9fYblNSHqZkWcccQqlzqUYhtj/+FONgyoU5B6Vd3h9SCF/s0WtuY4Kuj8YPdnUmWlVkzWj361ddQrkNHc=
X-Received: by 2002:a17:90a:fa96:b0:299:8957:9898 with SMTP id
 cu22-20020a17090afa9600b0029989579898mr11177772pjb.42.1709702907704; Tue, 05
 Mar 2024 21:28:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240228093013.8263-1-linyunsheng@huawei.com> <20240228093013.8263-6-linyunsheng@huawei.com>
 <65c3503409c0e1670bdf06fecfd58ec483a114b9.camel@redhat.com>
In-Reply-To: <65c3503409c0e1670bdf06fecfd58ec483a114b9.camel@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Mar 2024 13:28:16 +0800
Message-ID: <CACGkMEts-S7=p8aY+p+1JcTGZdLO65ug6t7c_yNj8xwRrhg9tA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 5/5] tools: virtio: introduce vhost_net_test
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, Yunsheng Lin <linyunsheng@huawei.com>, 
	davem@davemloft.net, kuba@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 5:47=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Wed, 2024-02-28 at 17:30 +0800, Yunsheng Lin wrote:
> > introduce vhost_net_test for both vhost_net tx and rx basing
> > on virtio_test to test vhost_net changing in the kernel.
> >
> > Steps for vhost_net tx testing:
> > 1. Prepare a out buf.
> > 2. Kick the vhost_net to do tx processing.
> > 3. Do the receiving in the tun side.
> > 4. verify the data received by tun is correct.
> >
> > Steps for vhost_net rx testing:
> > 1. Prepare a in buf.
> > 2. Do the sending in the tun side.
> > 3. Kick the vhost_net to do rx processing.
> > 4. verify the data received by vhost_net is correct.
> >
> > Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>
> @Jason: AFAICS this addresses the points you raised on v5, could you
> please have a look?
>
> Thanks!

Looks good to me.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Paolo
>
>

