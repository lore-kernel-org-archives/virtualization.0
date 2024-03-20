Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F93A1DD
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926745; cv=none; b=Fwm/EbHiYSUxHuQOZxM1dOBR04t3BnilEhBcuC4pWfWHdG+Sai+/cNtfoJn7+OY5VJ52Amq/u4O2ICkuL4KUQRxzM2INFuHEjWCl6B/E9X/X8WVV6j/jI+88X4yNOR8tirnxa6tETfLE6902dCh908lHlhWVDWOnPELz96pAKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926745; c=relaxed/simple;
	bh=56rDbNCxI2vOSQbDeXQzX5eiAqbmjduUur3AvBWEm84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtP1UI5mBNXQkCXGbyDvse52KaK7pxEtjwPXB4R/0vSLkg09Tno4BFBijpHMRQT/EwZPpY/8aMuLYGmKekPK9m4NEHLrRdaM6TZyyPuQLrgrFWzNLI0Mjmp7I+9cl4RljKemZWMxbwdI0FmixLVqwI73AORFx1GcywLv1DrivZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcGUZ0du; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcGUZ0du"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710926742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56rDbNCxI2vOSQbDeXQzX5eiAqbmjduUur3AvBWEm84=;
	b=QcGUZ0duC3FRAqMOPpr3TG9rBeD2cxr8zRLgSl4KQnqg3EJqVYB7r8qoIV0LjFBHbRCwDK
	z9EtGHcWisQVwwbFQG9KF4v9KPLQDCfWJJayimUR5m97wlywtqUbc6sjOdpNX+G1v6pcrd
	P8NBFlzRj0bxKJdbkNucJ8QgE11ZZdc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-3vS5vY54PtaHxyYjkD1Tog-1; Wed, 20 Mar 2024 05:25:40 -0400
X-MC-Unique: 3vS5vY54PtaHxyYjkD1Tog-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29ff108f223so485553a91.1
        for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 02:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710926740; x=1711531540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56rDbNCxI2vOSQbDeXQzX5eiAqbmjduUur3AvBWEm84=;
        b=HCbRvkt3IQmy0C6x90V/WNA39LQBUKaE0FaBLJyFDf/nSVYT/kvFks+lY71XSKVcdn
         n8baw92Je5dO+i8t4TmB0PijIM2pdGubnivRlXrEAYah4qfWpg8QwDMs0DHoq7qCvsoV
         ktA8oqKmqurx60lh7okwvuaqcK7J1zQgP5aZ8lI0+fK8eK1rrbPJFBq8KN/HPUxaKV5e
         Ippx6+0mCCs0+4DItbStQu/rw09H/g1lH4frO93yFKNxpiruYW0OiAKllTk3vjupO+Vj
         qfAATROVD1AWczubVt2RtRyBF4T6RsDz5n+XWVwBO4pWE8JWvNBIL85RJzxZQZQBF++w
         kSew==
X-Forwarded-Encrypted: i=1; AJvYcCXhwdR3gynaDOehaby4fOHu2c4dWNM/+ibREMW93OpfSrkqOHhf+GydGUya2p/+24GnB4r5oq+l1NaFJCL9K65qnZ6UXECw4tJX7WLObcY=
X-Gm-Message-State: AOJu0Yx59TfscGbbZz1vuc6tCuyIOpP1LS81v8af3rCYoCLUo1oH4Pqf
	zKVdafP5FZvWRKKSpWLtUJqabTmSqh/asDixs4rZQ57p+bTZzNUo/aqO8QRdBnxK9VLEPKLb1C6
	B2IbYjbTzLCYCb3uelFkuvkRZ5FRarWYajgA3bFFds7Pz64EZm0lgC8qInwsJwS5AHAoyCabX41
	n5nMe3FiQIsR6vhMJCQYorJLXLX4x5Z5IIzWEV+wM=
X-Received: by 2002:a17:90a:17a7:b0:29d:f2a4:e634 with SMTP id q36-20020a17090a17a700b0029df2a4e634mr7459309pja.19.1710926739663;
        Wed, 20 Mar 2024 02:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYQGKoaDn72eJo80nDHf8Qb569J1Tx6XzB9bumhyiEpIYi7ZoXTwtMeJQLvDU+wGiP8dnwl3Smsj+VIVEE8uw=
X-Received: by 2002:a17:90a:17a7:b0:29d:f2a4:e634 with SMTP id
 q36-20020a17090a17a700b0029df2a4e634mr7459289pja.19.1710926739348; Wed, 20
 Mar 2024 02:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com> <20240319025515-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240319025515-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Mar 2024 17:25:28 +0800
Message-ID: <CACGkMEsELwxC8sqRfNkVQbxHj9RL8aWV2z5qV_Tw6Ln-GM9Kzg@mail.gmail.com>
Subject: Re: [PATCH vhost v4 00/10] virtio: drivers maintain dma info for
 premapped vq
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Mar 12, 2024 at 11:35:47AM +0800, Xuan Zhuo wrote:
> > As discussed:
> >
> > http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rH=
YqRZxYg@mail.gmail.com
> >
> > If the virtio is premapped mode, the driver should manage the dma info =
by self.
> > So the virtio core should not store the dma info. We can release the me=
mory used
> > to store the dma info.
> >
> > For virtio-net xmit queue, if the virtio-net maintains the dma info,
> > the virtio-net must allocate too much memory(19 * queue_size for per-qu=
eue), so
> > we do not plan to make the virtio-net to maintain the dma info by defau=
lt. The
> > virtio-net xmit queue only maintain the dma info when premapped mode is=
 enable
> > (such as AF_XDP is enable).
>
> This landed when merge window was open already so I'm deferring this
> to the next merge window, just to be safe. Jason can you review please?

Will do.

Thanks

