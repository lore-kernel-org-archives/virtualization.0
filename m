Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB9631E0FA
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160251; cv=none; b=ab6ntORp9YVIikvhhJJVFkb9ZUaZ9nLp9BSTmCtXmqqpdsCjUqppquyY/dlbt9UKbj50GPyzTYTnGD6qCts4/3dgHiSsIFo69Nc7QEta8fTYpxnXl9Ci44Pe1sV2vw9YTeg19jM8fZWv+NSMVngtqALty0udQFXfgsWF4pREF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160251; c=relaxed/simple;
	bh=TgihVCzdHkhlFl7XJgdzny7+kp/vV44ySjol3tn7/k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OZlBIdpL81Jt0XuCqu+aUY80r82jWTvssRbn+12GPqcu12qUa8nMcH/tgKAzWCYrNFEhS/493mzWJ9uxap+o33DTjAE4NvLiENI+Lzwq2/yzuwGQr330MUgohDR7fWg2RoslBVX7QHgUCIaVhoO1huDTMovZkncBFjVJcUlkvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=amaiOSpt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amaiOSpt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764160249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2M8hirVbY5OIpSvxcWUFbxShnVmyIWY2UihN4VUkME=;
	b=amaiOSptmqek0ZGkmzM7NXNaOjDjf8ZcTPY+cnD935WE6KtFIafuHfRnnx6YQLq7qqVFc6
	0JwBrRtfBE3FQYQfRDg+PaooPrUb1VMFULgWFhccdmimFti6F+nqnXcT8UNvy4Nzge37p8
	6l8jvH1/U+MdG9aezI3VqclO0WrYaPs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-v-NXQDHiOtS3VxnTVQh86g-1; Wed, 26 Nov 2025 07:30:45 -0500
X-MC-Unique: v-NXQDHiOtS3VxnTVQh86g-1
X-Mimecast-MFC-AGG-ID: v-NXQDHiOtS3VxnTVQh86g_1764160244
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429cbed2b8fso3650793f8f.1
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 04:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764160244; x=1764765044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2M8hirVbY5OIpSvxcWUFbxShnVmyIWY2UihN4VUkME=;
        b=dPixg/NEZmU8iwTf9MMsOJCE2uWDe6fAiRYhBcVptLLXDKKqFOmPIkCCppRMiYytX0
         DltIZWoKDxd4/Mcismjx37Mksft20TXHJYjAeDQxKiBVlyG5q6NfS252obuUQzQeVOzl
         08f5CyX4dwp9vszQY72d43ZtFwqzaQGnQCJLj7P/ciUedfkN77NRtMqNvsvF2sB7RlHu
         DLjIFA95K1LP8b8VzCpmnAz4X0Zd9xvBgomQvdQUmb+B0NWkLw3Q2bZ12a9XrN6g7EU3
         +CISyOHwu+PRNX9jHSFNtxqsFVd14YzTu9hdh2LTrLOsddoKM7cNr7HkyV0THhuQtC+I
         x5SA==
X-Forwarded-Encrypted: i=1; AJvYcCWSWaq2ETUGTTlytLz88ZuWVFKy/22IoMYn1UjumEociejMxFLfxTQpn9+Z7dDrEQLJX6d2sjID8th/OWJbjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9JjsziHU+XYckhcMjSnawLkLI29XeXV/KM3Z1UXH4X7t5xWdk
	O2BnmmPtBlVnDXzh+7yREicT7+E/HOaWndBxPkwo6Cq9AvxMEOVthWHzrv5rA3rVF/0bKEFvQ+X
	2hfOorp7LZpYhcp5YWCMLbv5qwS+UoPnTxpMBV3vbtiAVe6bBPGQva6dEsZn4dMhChR8e
X-Gm-Gg: ASbGncu/SnRElbi1PTPVVC+0eAHkPGu8B/47D0Fur9+nu8BSsAlKIeBjR9ZFf15TAUb
	lko1TdTH2qr/RhTZXuxrXAWqxl7MGOXsnDC0U+0kIXNT8cGo7+sqdbcvVrfdGYF7Fke2qucpCUI
	bKRXhj7m6uqan3WCfDu/Pnrg04Sy9oG8bhCZI1oLfrt/O1GDyiO/nJWs4hcR/GGuJrgaOSUdxIb
	yGILfbmFniWnNpJf9aXXIajfmTuSZPYq3zrPn1V6dwt2F2n8wPpKYOFi5b4915yUg3iCsQUXlxN
	K9jWOiU0tbts3Vppsqx3xAoZUqVuX0BeTAp79K/qqHqgaZEjYci7KbLB1xvUEtsbrx/dOgEbxE4
	JWh/g4PNkralxtev+vfsXIb9VwVkEFA==
X-Received: by 2002:a05:600c:450f:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-477c01eb9bdmr217492455e9.31.1764160244358;
        Wed, 26 Nov 2025 04:30:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzDOShduGdp9zc8mysLjLBhEjKzKDO88zCdk+Rqo9ljArnPM2e+3HscrIdh+6qslIZbPmv4Q==
X-Received: by 2002:a05:600c:450f:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-477c01eb9bdmr217492125e9.31.1764160243786;
        Wed, 26 Nov 2025 04:30:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e556sm39990416f8f.5.2025.11.26.04.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 04:30:43 -0800 (PST)
Date: Wed, 26 Nov 2025 07:30:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jon Kohler <jon@nutanix.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio-net: avoid unnecessary checksum
 calculation on guest RX
Message-ID: <20251126073008-mutt-send-email-mst@kernel.org>
References: <20251125175117.995179-1-jon@nutanix.com>
 <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
 <3ED1B031-7C20-45F9-AB47-8FCDB68B448E@nutanix.com>
 <abb04d29-1cd8-4bff-879d-116798487263@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <abb04d29-1cd8-4bff-879d-116798487263@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X1_5bYbFiymRtU_lVTjti5tuIKbno-Kb7MG9kkZM-dw_1764160244
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Nov 26, 2025 at 12:16:56PM +0100, Paolo Abeni wrote:
> On 11/25/25 9:00 PM, Jon Kohler wrote:
> >> On Nov 25, 2025, at 12:57 PM, Paolo Abeni <pabeni@redhat.com> wrote:
> >>
> >> CC netdev
> > 
> > Thats odd, I used git send-email --to-cmd='./scripts/get_maintainer.pl,
> > but it looks like in MAINTAINERS, that only would have hit
> > VIRTIO CORE AND NET DRIVERS, 
> 
> ?!? not here:
> 
> ./scripts/get_maintainer.pl drivers/net/virtio_net.c

yes but not include/linux/virtio_net.h


> "Michael S. Tsirkin" <mst@redhat.com> (maintainer:VIRTIO CORE AND NET
> DRIVERS)
> Jason Wang <jasowang@redhat.com> (maintainer:VIRTIO CORE AND NET DRIVERS)
> Xuan Zhuo <xuanzhuo@linux.alibaba.com> (reviewer:VIRTIO CORE AND NET
> DRIVERS)
> "Eugenio Pérez" <eperezma@redhat.com> (reviewer:VIRTIO CORE AND NET DRIVERS)
> Andrew Lunn <andrew+netdev@lunn.ch> (maintainer:NETWORKING DRIVERS)
> "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
> Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
> Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
> Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
> virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS)
> netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
> linux-kernel@vger.kernel.org (open list)
> 
> The "NETWORKING DRIVER" entry should catch even virtio_net. Something
> odd in your setup?!?
> 
> BTW, this is a bit too late, but you should wait at least 24h before
> reposting on netdev:
> 
> https://elixir.bootlin.com/linux/v6.17.9/source/Documentation/process/maintainer-netdev.rst#L422
> 
> /P

