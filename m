Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AA13D1CB5
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027874; cv=none; b=JPZjcBBbhsRAnmDK1wcHxTyPRRDFyF+oknNsoodL1CapkjjW0IPZnsBC7vc6Dy5MrUyLH7S+CfbDcF4PPNqVSzDZIgMqM/t2wMesWbjliw7iNoFUcN/5GqyuZAE+vpFY8JMxtze0vJUhhPSUOuaS4lxh82S13zhHPOdNazBshjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027874; c=relaxed/simple;
	bh=BjpCm1b460eDJlTTxeDtrDCf8v/HQ9t1gJnD8PhPRzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aRgnbCwKv3TVBb2xA0i0ai4Gz3keW8HUWEe6/RN+IxeK96kMP/qgjbJLJmWMaLamYb1tGB0Kj3u1qJJNx0utGee4Q2tT2qZWXyVDIbMWF0mVYZvFWaSKDvU3gpFS+gBt4zw8S7DKqZ6eTClyf6JcSvb8ZitTB2XcYWnF+dBSDi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXBhbuwN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXBhbuwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772027872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ReMKR00ftNX6ariSVfYbnK7T/z45lFmC8ykR+jm3nU8=;
	b=KXBhbuwNhV1Y8lsni+t+llvChY0l3QaaA/hr9P8C/HQyoAqO2BzFT4H5UHapNflOhzm5t/
	GpWlVDDpTmhqXe9pjw3sUf3cD/fVcVyuTF1MMy8H0gayFyAwVqvY2Yt7Sy02ilcJFgFOMR
	VHdse/WksEiK2TXqvo5lkdGvwCMVt4U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-o34AcKzdOaqubfjpLEFTCw-1; Wed, 25 Feb 2026 08:57:48 -0500
X-MC-Unique: o34AcKzdOaqubfjpLEFTCw-1
X-Mimecast-MFC-AGG-ID: o34AcKzdOaqubfjpLEFTCw_1772027867
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836cd6dfe6so33589865e9.2
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 05:57:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772027867; x=1772632667;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReMKR00ftNX6ariSVfYbnK7T/z45lFmC8ykR+jm3nU8=;
        b=j4rdhvjwd0/Ww2s1PxkWlFUN4wWEwWcW/Bjdz37qAawR6T1w2Z5O3d6BffdPnJ+j4w
         /is8rRE7mBJ+8cs2Kh43zkZen9KLgkuReCMEUGe8ZM6kn/fOiVriCItNHqAvXQDFxina
         pa+Ay70Xj+849x9HD7B24WX/R0s4QAPMM4iV1a4+N9YBN1STd5d6XB2h3QTomH2Lzu3q
         DkqdaO2IIEYiLvjrUSK/QHvlUpv3o6Dm3TF0qo/BFZVp6SzM9MoWObQ+DfCeA8tAbAlP
         AsiK+Q9nc+K/6g2rrNmdQGVhbD/0KiUSAplE9UxHq82VDKnnx3evRICMyMaFWGODqoyK
         NOhw==
X-Forwarded-Encrypted: i=1; AJvYcCVdN34TIgdimUlwHGaOmYfl/yL8sEBVqXbD00Mv1VVkQYmjIbu6e/L3rpTuUFn4vbpf8DS9mvLhbWgj7P7jnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQb+JpNUJQehQSkhvVdRS9k6+BfI6miTZwciDVhi+0tlijJ3RV
	bVvJLGS1/XIVZtM86qflFKKeKaHWEeDgyuJL1Ot/4nJhKRWkFBP3iZaYS/WdmJUDnTtZ+VyXOPa
	8j2XEH2BoYPceF1hFBJ5X6TyjuWiF+koHzjHVwWU1hO/d6kLZ7hoNcZkO+G0p9ioRNavQ
X-Gm-Gg: ATEYQzxKNTNJqsv7LksrFovDAq1SYQ5dUi9jVOLo8h314cwCa7hxWWH56nSbgR/dx7N
	KI8LbLMKKXtQeHmeGh1XK3nlUSGSq5dYUqAs+orBs3YMzlldty/X+jkeDEvXYECSqWdKNmOlBgR
	Xj12aEzaa8UJ1lrhQyQDt0ShkgvNKKskL2OCyxDxUHlkSK4UgBTmxOlLF7pE7nX42MZK3n+QoMQ
	dmLJDFZRyzEye0czV7GQ53RalYi8xl1W/c95YrcsEE3FOdHcBRUA03rqDuRdJZAtXsPcgCTsiaF
	tRmqgXvGSImjIsNXAX7SBrkv7rSvXeDETYC290gJ29PkzPVgAdskw/PW/wmQqducStCs6GRCWDI
	Td4ePI0AIb91zI/AiJ8t22xYDJQq9lbiC0qeO7ZhakG8bNg==
X-Received: by 2002:a05:600c:4750:b0:480:1c2f:b003 with SMTP id 5b1f17b1804b1-483c219ec0bmr6831395e9.20.1772027867344;
        Wed, 25 Feb 2026 05:57:47 -0800 (PST)
X-Received: by 2002:a05:600c:4750:b0:480:1c2f:b003 with SMTP id 5b1f17b1804b1-483c219ec0bmr6831035e9.20.1772027866853;
        Wed, 25 Feb 2026 05:57:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf5fbsm11717095e9.18.2026.02.25.05.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:57:46 -0800 (PST)
Date: Wed, 25 Feb 2026 08:57:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Message-ID: <20260225085523-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225072355-mutt-send-email-mst@kernel.org>
 <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225073537-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63741BBD1FEF6CB7328A7B44A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <BY1PR18MB6374C5EC263CB6812B197296A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225081735-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63740F76E83C299E9AAB32F0A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <BY1PR18MB63740F76E83C299E9AAB32F0A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uXHksUJEgh6ffTFAOC5xFrE5peBKAggFcgDes16PuAY_1772027867
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 25, 2026 at 01:31:50PM +0000, Srujana Challa wrote:
> > On Wed, Feb 25, 2026 at 12:56:19PM +0000, Srujana Challa wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > So if device is powerful and supports a very big key size then...
> > > > > > > > > we disable the feature? how does this make sense?
> > > > > > > > The intent isn’t to disable the feature on capable devices,
> > > > > > > > but to ensure the driver never advertises support for RSS
> > > > > > > > key sizes larger than what the net device can actually
> > > > > > > > handle. Even if a device reports a very
> > > > > > > large key size, the driver is constrained by
> > > > > > > NETDEV_RSS_KEY_LEN, since
> > > > > > > netdev_rss_key_fill() enforces:
> > > > > > > > BUG_ON(len > sizeof(netdev_rss_key));
> > > > > > >
> > > > > > > so cap it to NETDEV_RSS_KEY_LEN. Why is that a reason to clear
> > > > > > > the
> > > > > feature?
> > > > > > Our device mandates that hash_key_length must be identical to
> > > > > > rss_max_key_size to guarantee symmetric bidirectional flow hashing.
> > > > > > If rss_max_key_size is larger than VIRTIO_NET_RSS_MAX_KEY_SIZE,
> > > > > > clamping
> > > > > the value is not feasible.
> > > > >
> > > > > I don't know what to tell you. rss_max_key_size is just the max
> > > > > device supports. driver should be free to use a smaller size.
> > > > My understanding is that this patch prevents the probe from failing
> > > > by disabling the feature instead.
> > > > Given the current implementation, the driver becomes unusable when
> > > > this condition is hit.
> > >
> > > I understand that the driver is allowed to use a smaller RSS key than the
> > device’s advertised rss_max_key_size.
> > > But, our hardware does not behave correctly in that configuration. For
> > > symmetric bidirectional hashing, the device requires that the
> > hash_key_length match rss_max_key_size exactly.
> > > If the driver uses a smaller key, the hardware produces inconsistent hash
> > values for forward vs reverse flows.
> > > Because of this device requirement, we cannot cap the key to
> > > NETDEV_RSS_KEY_LEN when the device advertises a larger
> > rss_max_key_size.
> > 
> > Would you not say it's a buggy device then?
> No. The device works correctly when a smaller key is used. The limitation only affects
> symmetric bidirectional hashing. For the other use cases capping the key size is fine.


yes the device seems buggy in that configuration, in that it has this
requirement which does not seem to be in the spec.

so tell me, what is the actual rss_max_key_size of that device?



> > 
> > --
> > MST
> 

