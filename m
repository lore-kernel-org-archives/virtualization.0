Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670B34D381
	for <virtualization@lists.linux.dev>; Mon, 10 Nov 2025 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759630; cv=none; b=HPrGzcA7fWR6FhJiUO0FxoTEQa+3GTDd9OFiaA3u8qYT0u3r3GvQ0UG2KfeLVPiSZsKdnKgGbad/402jttMjA1k9Qv8+HLz2MuwfKXM8qSjIEwQEDFIDlSC+qenfDxcsyfrLOb2nJuyx3IWY90WORdSFNTPdcCPQDTca6F3Nd3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759630; c=relaxed/simple;
	bh=XUT23dtRQ9JDXHuvYsTi21YFd/7an4tE9F+V5WLNTAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UBpFpfXmAPezKrpqJTU/EskD/fyMitkYRMvi9jCMbzfFsmZLxN44SDmDXu4DsQHh1RnmElhbr6PHoKsHL/pmVRSfkGVAdiHzYXd2kNHvS/tPZQgxp8Sj4ouW0RsD9/4CQ3EhhrjkgQUgerCzE5kRcydGyDa1wZf5QLQ4nHQnnwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6hZVDHr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6hZVDHr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762759624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eN2rz2uTu9iFkEupVoH3hbAbTYcyN2eAv1mkojYGSTQ=;
	b=O6hZVDHrkDczpYyJs6z36SemK6LJ+co2KSA41e+6lueaHrQap6PekkGFcEky7jQHYDr3hf
	8PKo0SlRdLPTans2jEfmKlWg0hTrk7QipAflt95WJoCmf8jdBkE9k9yLYiyV56mGaXWnsP
	vKbppeH0RzPotio5vydl0Rn2sjnH55o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-Wr7-4EiIP2SopAuYlIRecg-1; Mon, 10 Nov 2025 02:27:03 -0500
X-MC-Unique: Wr7-4EiIP2SopAuYlIRecg-1
X-Mimecast-MFC-AGG-ID: Wr7-4EiIP2SopAuYlIRecg_1762759622
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b3ab5c85aso237230f8f.3
        for <virtualization@lists.linux.dev>; Sun, 09 Nov 2025 23:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762759622; x=1763364422;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eN2rz2uTu9iFkEupVoH3hbAbTYcyN2eAv1mkojYGSTQ=;
        b=jlSVTz16gRFcSfyS3+GyyRRqRSPc1EAbw5HLyVINNLRvDrLnqB4wj5De1M2qi6pfr6
         FI0+QDvvvRBqFEltFlC0q90B+JApgAltOdNNsH/t+cKEcojIvZ0jCS6N90inQQsLkM91
         n5fZk0RkBBHbUbxiCbe6ECWE+ylzkLvg3tXa/YRgd2mqFk+TitHmTnOauXawiX7GCBYg
         CvVBxGV9CcFJb038HKRYkq6DltBdO3dVQZcNOiTeJdQ/zpjj55b2i4oC2F4P+WljZ2tL
         tB0d33agZZFN5vqmk7aObiyvUv5Hc9vGl2n23Y7NvlPRa45VYfVRuA9YcWSrZzQnKLjx
         QUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+vZ85V3ZiV3865BDxpKg1vx7dsu4nZhwjemuoSarBLztG3BIWu9BzVP9OhLN12e1wdxxxqZiJhFJuy/fbQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzz+NI9iQ19IS50gr2mmkFXGTJ1MlZsbBqWi/54940rbciugZ+6
	wJ/M04S2n9f02e0KGwU/404kHAIsVTGqWzUBnAxQa+EyJJwdB4w6UbGIVnDVRfiwHqvj1S3R4p/
	h6gDZAbQz7tcD4hglfY64/m0o3jtnEfwjWAGyIoFMOdewK0C0uG6BtUdzwLD0AQZiWKZd
X-Gm-Gg: ASbGncvpJe5cQTjk8vSFg57PKA4mIn0ge7RT27T7TbAOSPOOpx1JdzEYz97wgrs9+U4
	uooh3WbEu6I86Te8p5Hw3/MfeTE6SI9/LubRG9Af0gPYJJN1iSQti35wcV5FgWR6/MXOwJdNQzW
	5eTpeQGrJd7CyVNq8jfS2jPYv/GaZgQWmt8RZm2BYtrrRtWpU/XjTe0w2XYp7JAE4ewc7mxdqbB
	hvLokmS+jUpYdUKafaqcUnw8KkSCmXsXXbodc8Pe938bMjVwGl945h19nZWbAlbzDJ7YP/jLDJw
	riRFMm8iosYjgDRx1t1rHjW1MC4gsoS9LX7FbcvBZe59X1VTqo9BrfVNaz5aIM0BbxY=
X-Received: by 2002:a05:6000:4112:b0:42b:383d:9c8e with SMTP id ffacd0b85a97d-42b383d9f37mr2993482f8f.41.1762759621746;
        Sun, 09 Nov 2025 23:27:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/a8qq+Ue+iHNjogq2bkP0rULMW/kLl3jHcx5gWR6m6UdyH6hhrWDWgTsH7k/b1hskYU9tew==
X-Received: by 2002:a05:6000:4112:b0:42b:383d:9c8e with SMTP id ffacd0b85a97d-42b383d9f37mr2993448f8f.41.1762759621250;
        Sun, 09 Nov 2025 23:27:01 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2b08a91esm15051311f8f.2.2025.11.09.23.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 23:27:00 -0800 (PST)
Date: Mon, 10 Nov 2025 02:26:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251110022550-mutt-send-email-mst@kernel.org>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
 <20251109163911-mutt-send-email-mst@kernel.org>
 <CACGkMEtxfZh=66TSTC2B8TdXWP-fsTrYFkfz5aOViYkZmmcvxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtxfZh=66TSTC2B8TdXWP-fsTrYFkfz5aOViYkZmmcvxg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Whl4rsr_N-m4c60BZTZVsVeeb2DVIgpLLU7grglvyxs_1762759622
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Nov 10, 2025 at 03:16:08PM +0800, Jason Wang wrote:
> On Mon, Nov 10, 2025 at 5:41 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Oct 30, 2025 at 10:53:01AM +0800, Jason Wang wrote:
> > > On Wed, Oct 29, 2025 at 11:09 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > >
> > > > The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> > > > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > > > feature in virtio-net.
> > > >
> > > > This feature requires virtio-net to set hdr_len to the actual header
> > > > length of the packet when transmitting, the number of
> > > > bytes from the start of the packet to the beginning of the
> > > > transport-layer payload.
> > > >
> > > > However, in practice, hdr_len was being set using skb_headlen(skb),
> > > > which is clearly incorrect. This commit fixes that issue.
> > >
> > > I still think it would be more safe to check the feature
> >
> > which feature VIRTIO_NET_F_GUEST_HDRLEN ?
> >
> 
> Yes.
> 
> Thanks

Seems more conservative for sure, though an extra mode to maintain isn't
great. Hmm?

-- 
MST

