Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB7302CB6
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035313; cv=none; b=pjvxSCPuat1Qj+YfqRGp9qvd5Wr0WB4pVZ8CWU1yVrGjykDhMLlCAlEr3kQ3NpBL29gnipdYPcDRmaf4JeWPWmk+nCUXG+k40N3yv7y3s4EHqrbHnaAlPuk4mej6iQEJDpZ5eRYOFXDE4elCaPLUq+3Amz3OTdWhWx2pYX3n6aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035313; c=relaxed/simple;
	bh=6b74B6VXDCdcmJHeIm2ZbabEvGQgPJOC4TiiYfNyIxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=l7c7LRitGJNcncWB2hSq6M6lzP4TfqYcyadTkZSTN+e2AtSqTsJ9SldFrqPalSQqvLQLlUDmLhlke8/Lo8bXRbKQDj1kGi6tC1aCvzvGUDCPqueqHHwTQs0oKLvA8Gpf2uUZuMfP76CMF36BAAI3Rp/0ebxDFFx9MRN/zw3Am0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYlcS07v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYlcS07v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761035310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9wgX9rXCO2UPANmfcyjOB2pBN8YmhnWytsGw80sw54k=;
	b=CYlcS07vK4w/UQOtsUYIvNUKE+ZmCWnmNHD5zaCWAxwxHHx7VwMXUMKLP2Q35JZsLYPotj
	CaakgnXqSxGuvAggG1EudK+zPfbclD/vZRRca78EniWtJgkVm2bUoT26jDyTeKLbKBm8wW
	UVPETM5pivLcjrAlNM/e3t2/ymnvNis=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-a6W1r0qJO_yhP8g6pv7bFg-1; Tue, 21 Oct 2025 04:28:29 -0400
X-MC-Unique: a6W1r0qJO_yhP8g6pv7bFg-1
X-Mimecast-MFC-AGG-ID: a6W1r0qJO_yhP8g6pv7bFg_1761035308
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47111dc7bdbso43568375e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 01:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035308; x=1761640108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wgX9rXCO2UPANmfcyjOB2pBN8YmhnWytsGw80sw54k=;
        b=wZEKfU2PaMxKOuOndu9TR5cMCIzVjg2GznYjszKrItGUnbsSVCDxkO4H/bK0K5ZYeD
         vFOxaqyvDyAI+y5J/8cWe/iXWrqGDVDx4hcTm9iBaFwi8Dmea+gFGx3JTv/52m+ALJSj
         WRIrWdjSrB+P90Sr9cEV3IK/5rrfGn1KpYT5ODtaNJCv412Vb4FjQNpseRW4srCuPXeg
         YzdEgM1RYavnBpd0HEFM3OoGnt88HXSZwvI14Ik0kXC/g3m36p1SFv/A30IiUpZG5fGS
         zayoW6WDgqzAmd28LQhZ80b6mFDgmsU+KTt6gT8jVb04O9EVxQAad6Knu7sclXoCezI2
         wtKw==
X-Forwarded-Encrypted: i=1; AJvYcCVvQLcLHev7AHCz+l3DVngSQj9ECCXzcaM/+863qViSJVPyepPGqEWD0KKaK51RsH3+mXq8t8PXR6t32rUJdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEs59KK/FkJZ1uywqxdLAoavQlMYmCs4yN+Xlo3avUyu6B6+7E
	XWiqL99whFdc9zSZZHh8ANKdsMewJlAFYyLA/k+j1TxFUf+RtSEfflKKGizfmJxF6APKveZnMMs
	vWzbG8AHqCzcJd63uoJ97pcyFh1xIqCy24zMuJfR6xetFstZ/hCO9XMHU5sYK2KgsrIa6
X-Gm-Gg: ASbGnctarHcWUk1oQs8+WTXSuWt+q+J6YrC569CObVCg8k7hri80nQCXgcPL+SZKBia
	L35pBIHscysIN4bqIFwiqa3kxAMXG5rWEbc+RwfRICbfIFoxonpW0oIKL2N/L70lcAYRSC8qXvq
	Jhoo9HIjRDbAg3i518p7c5ST/GJmVLuyOZq0k7A/Ic5xLOSujBRH5q9BlaLJKzlU9wSzQeebxrR
	QTuQmP8SS69vKTNOiNPJIKO/yPpReCJtSPZYUlG63d3/9glww4RyTbeb1Nw8V5liOoQdlxSYpQ1
	r7FWY8s5KCnrC/AvdvgTFAi38qtrZ1q7GXAzDHDt9KIqx2Umudq6YTX/n6zwFf1UI3S9
X-Received: by 2002:a05:600d:824d:b0:471:1b25:f9ff with SMTP id 5b1f17b1804b1-4711b25fcefmr68406885e9.39.1761035307822;
        Tue, 21 Oct 2025 01:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGRVyIsfoQR5BPGvrQHdlbSlAJgPiR7tZMRXYjTySH7Todua5vbiJ9sWTo57eh1Pa8fByUpA==
X-Received: by 2002:a05:600d:824d:b0:471:1b25:f9ff with SMTP id 5b1f17b1804b1-4711b25fcefmr68406715e9.39.1761035307261;
        Tue, 21 Oct 2025 01:28:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4714fb1b668sm213055095e9.0.2025.10.21.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:28:26 -0700 (PDT)
Date: Tue, 21 Oct 2025 04:28:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: zero unused hash fields
Message-ID: <20251021042820-mutt-send-email-mst@kernel.org>
References: <20251021040155.47707-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251021040155.47707-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IULwv5wfcf8d6Esm8-hM1xoZU4bE7pGGX8devy1GGes_1761035308
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 21, 2025 at 12:01:55PM +0800, Jason Wang wrote:
> When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
> initialize the tunnel metadata but forget to zero unused rxhash
> fields. This may leak information to another side. Fixing this by
> zeroing the unused hash fields.
> 
> Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO tunneling")x
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/virtio_net.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 20e0584db1dd..4d1780848d0e 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -401,6 +401,10 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	if (!tnl_hdr_negotiated)
>  		return -EINVAL;
>  
> +        vhdr->hash_hdr.hash_value = 0;
> +        vhdr->hash_hdr.hash_report = 0;
> +        vhdr->hash_hdr.padding = 0;
> +
>  	/* Let the basic parsing deal with plain GSO features. */
>  	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
>  	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
> -- 
> 2.42.0

