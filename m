Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186534EF05
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585311; cv=none; b=rh0z6+OiFxGwIn3eKq3I1AztfVXXUDL2Jq9Lc5+FYBg9dsbwCegxQdUM6B8cva6z1LZcEyX07Grz0sOfMh5dIon0oNy6JMBmFMN/0UBtH7CM1NePlIflLuMgen4y0nQoHmgQEAER3Vxs2YFeWxqmixnxTS7+DB+XHT4NCQbj+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585311; c=relaxed/simple;
	bh=r/rHkUQ0To2LK/DP/a0iz3f5RRaVDmoYPoQWPBHiRjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JEx4yFdliGLKy55PaAJiFkUj+nGnT5C5JlYJbRspU+mk5zL1YW30LYlzyNYOx1wVlPzxfEWq6JCSP689u8rUzzBNHL1tBZb9fxGWrqrUu2g99GO8ZfVRVAJah7Kc7XBtRx559ycTrcolWuJ59nGMHv4XdZBhssHFfSZLkdGjpUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlExrAN/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlExrAN/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775585309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iI1O2Z+j6pYuLKSHesam2+WBzFiXKpHPKyu0Xt/DEBc=;
	b=hlExrAN/BXcLJ58YpvBme2JYNFbzI5G8tOfkoD/QQmGqB5Gpap7C/Qk7qVQhzAzY+qQoXv
	KGY4/0U7FzpwHVFPjCilAUD4NeyL6PcbNSRX6Vu+iEYV2k9IW20/yNnqlNVOuQVWLiXGHR
	JfOx4Eo4ZNW0kEPJJLDe+Qv+y7Xk1mk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-T3r4OanRMHyGvaOaSkNyAw-1; Tue, 07 Apr 2026 14:08:27 -0400
X-MC-Unique: T3r4OanRMHyGvaOaSkNyAw-1
X-Mimecast-MFC-AGG-ID: T3r4OanRMHyGvaOaSkNyAw_1775585307
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8a965acd0b3so83958686d6.0
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 11:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775585307; x=1776190107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iI1O2Z+j6pYuLKSHesam2+WBzFiXKpHPKyu0Xt/DEBc=;
        b=dKEgIRW6qHLF1dk3wckYaIyjV6VdYFYFeOhm5/BNifx8wBtW3HfjVfmFzYwUThZK2u
         fPXCIzKBrduthWAnAQ4+kxxPbzqLoZJ3bI93f+rkUD0L5Bz2RgdFOIy4FkgLRWppfxco
         6LpF6XZCI6CD3gcizXSNE+EBynChqm+K0WqFfIbw7vcwP8UdpegYZB72vyXj20lsG4HZ
         bzWer2VcCtSlSiJJrU+dO5ktaIFXzM0vs6hK/Wljyu7mNeBIjUMeHmw9849fuvUhyCbQ
         bNUf7iKIpPceBSVpAzJ7SHks68fRNZTfVCymbdVZvZNju0QKRX8YiNBEx22ZnOmVR7nX
         g7fA==
X-Forwarded-Encrypted: i=1; AJvYcCX5+HJF7YqH3wMnoDiLcBvPECn7pmhCXAqgemeQhV5CGWAPpuJy+t+Mxu4uHUGnRiTTeJt4NLxgVoMHD/O37Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqgFwZyIdYHTpqf3H60S338LPqRonh/lCuGA258ZzrFhISBO9N
	Cx/7tw8KaVe9AZfMhn7NI2bwxZvDNdflx1z88QYanW7CBpnSsEuuJpiU4J4s31w5rSA0ZmKahBt
	HLJgtGc0N57SMTR7x6mogQIhNuemlhe/F5JdA2JKs7EtLwJBpBoUFkUlI4md6vSzRKJl2
X-Gm-Gg: AeBDiesNgCNEb+GiuInBROsWuwQDXfj8X+PTRwFDp5fQ6UJLwK3Ur41AY68oBYRH+Py
	KZJsaf9W3CwE89QJL2GplFRX/rGdi7nyfc2iSAPeQA3T5cSjHq/0BFP0FCQQWE4iaNTifbnNloU
	23XcQ7ykXi6UG7tH9QGlDr9QzD7sBZ6XNDBIxxk2+tXl1ErnVjUUcszsmFbsMzxrSHdMZvknOzK
	mm/tDCb7+pV1NdpWLlZ1n1Ohedh8pkv9kk6/oEuTyu6baVNtUvd5DEwVuInAamSS3o3vYgSJIFg
	EfoVSzA/mTLgbANkviQYAqExLW7hAV6xwajOsK5A5qeBc8L+wCyLMbZ/ESoCXksLwA3Wa9ogBva
	6i7YDQpu987DR
X-Received: by 2002:a05:6214:20cf:b0:8a0:93c7:82ba with SMTP id 6a1803df08f44-8a7027a91e0mr277869016d6.14.1775585306693;
        Tue, 07 Apr 2026 11:08:26 -0700 (PDT)
X-Received: by 2002:a05:6214:20cf:b0:8a0:93c7:82ba with SMTP id 6a1803df08f44-8a7027a91e0mr277868016d6.14.1775585305890;
        Tue, 07 Apr 2026 11:08:25 -0700 (PDT)
Received: from redhat.com ([37.19.196.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596e03cd8sm145693476d6.33.2026.04.07.11.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:08:25 -0700 (PDT)
Date: Tue, 7 Apr 2026 14:08:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 4/4] virtio_ring: preserve VIRTIO_F_RING_RESET in
 transport features
Message-ID: <20260407140713-mutt-send-email-mst@kernel.org>
References: <20260407123904.6390-1-astellman@stellman-greene.com>
 <20260407123904.6390-5-astellman@stellman-greene.com>
 <20260407122025-mutt-send-email-mst@kernel.org>
 <CAChPuV92aD4BibJiGfMASQVQBHAoz+3OgzQS6Hb2Dw7JDcRJTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAChPuV92aD4BibJiGfMASQVQBHAoz+3OgzQS6Hb2Dw7JDcRJTQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jQ2XGW1Z1qJ29AJRPQzsCshpa16dOo6NguwhmU2IL4w_1775585307
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 07, 2026 at 01:33:39PM -0400, Andrew Stellman wrote:
> Code analysis only — not observed in practice. And you're right that on PCI it
> doesn't matter: vp_transport_features() re-sets the bit after
> vring_transport_features() clears it, so PCI never actually loses the feature.

Oh. please do test patches, or note they were not tested.
how were rest of patches here tested?

> 
> The gap is for transports that call vring_transport_features() without
> independently re-setting VIRTIO_F_RING_RESET afterward. Whether any current
> transport hits this in practice I'm not sure — it may just be a whitelist
> consistency fix at this point.
> 
> Happy to add a Fixes tag and resend, or drop it if you think the PCI-level
> re-set makes it unnecessary.
> 
> Fixes: 04ca0b0b16f1 ("virtio_pci: support VIRTIO_F_RING_RESET")


surely not this because pci is fine.

> On Tue, Apr 7, 2026 at 12:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Tue, Apr 07, 2026 at 08:39:04AM -0400, Andrew Stellman wrote:
>     > vring_transport_features() whitelists known transport feature bits and
>     > clears the rest via __virtio_clear_bit(). VIRTIO_F_RING_RESET is
>     > missing from the whitelist, so it is unconditionally cleared during
>     > feature negotiation. Drivers that depend on ring reset capability
>     > silently lose the feature.
> 
>     Hmm was this observed in practice or just from code analysis?
>     And on which transport?
>     Because
> 
> 
>     static void vp_transport_features(struct virtio_device *vdev, u64 features)
>     {               
>             struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>             struct pci_dev *pci_dev = vp_dev->pci_dev;
> 
>             if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
>                             pci_find_ext_capability(pci_dev,
>     PCI_EXT_CAP_ID_SRIOV))
>                     __virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
> 
>             if (features & BIT_ULL(VIRTIO_F_RING_RESET))
>                     __virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
> 
> 
>     ...
> 
> 
> 
>     }
> 
> 
> 
> 
>     > Add VIRTIO_F_RING_RESET to the switch statement, matching the other
>     > transport-level features.
>     >
>     > Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
>     > ---
>     >  drivers/virtio/virtio_ring.c | 2 ++
>     >  1 file changed, 2 insertions(+)
>     >
>     > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>     > index fbca7ce..2cb643f 100644
>     > --- a/drivers/virtio/virtio_ring.c
>     > +++ b/drivers/virtio/virtio_ring.c
>     > @@ -3524,6 +3524,8 @@ void vring_transport_features(struct virtio_device
>     *vdev)
>     >                       break;
>     >               case VIRTIO_F_IN_ORDER:
>     >                       break;
>     > +             case VIRTIO_F_RING_RESET:
>     > +                     break;
>     >               default:
>     >                       /* We don't understand this bit. */
>     >                       __virtio_clear_bit(vdev, i);
>     > --
>     > 2.34.1
> 
> 

