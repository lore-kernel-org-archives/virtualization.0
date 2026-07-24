Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C1041E6DF
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886283; cv=none; b=uN2T3K+BhiIEHPC2coXuee2a5kKTpF5s3hsXW6SAx0AcXouYTglaRNfkwConPpTSA657b1NRaruUTtoHV+o+55KHCQNmxVqrYkyyr/lJpP9bjdb9m6d5T0spyGuql6nEzzTeCwHGSlfuACm+JFGE4lPdzZTzSRXT8gHMJ5gTje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886283; c=relaxed/simple;
	bh=9oz0DmGGIwoN3oJPVd2acvSqAiJ100/9JM53YR+bd30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kFFJI13wE4F1YoTs+Ky9dc9pkrXd8ulpaYZNS/HCpnqstheLp6qbuAR2cY+vTgcyYbRgzi4BuofK4Kpxz4GLr66353gDystuQl7BfWkBvXt5cswxb4hx414ZgMfyFwjwg/V3zHHCCvf4AmgENNVxYwiVfAyh4cvfdYP0UF+ItN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/dcIDqy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/dcIDqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784886281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TL1dpV09gXHXK6xRcsFV3muEnvSe+yt82N35mULst6g=;
	b=U/dcIDqy487RdqR3rJEQWT6IXhYfcT/rc15opIAkO4E+6ulQwCgPquo5lCRrzNz5iKPeHS
	ufZ6L/F6quZ6um+AJ+YUnFS9mV41GkOW09AXPrquEpauCB7uxTBPaK0bo7ZgRfMEiocaFk
	g2aJ/6epJTkLVVmZKTUUplPRjWVFSOU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-QiBIbT7WOmKq5awx-Je1Og-1; Fri, 24 Jul 2026 05:44:37 -0400
X-MC-Unique: QiBIbT7WOmKq5awx-Je1Og-1
X-Mimecast-MFC-AGG-ID: QiBIbT7WOmKq5awx-Je1Og_1784886276
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f726186c4so175114f8f.2
        for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 02:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784886276; x=1785491076;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TL1dpV09gXHXK6xRcsFV3muEnvSe+yt82N35mULst6g=;
        b=rwzdjMjhX0c0zIykZNz68sf1Wq7J8cSjEOfhfJJ931BwscXmK2waTbPqOsETYD7Ggx
         W1nw/PKRWWxnzuZG+IfjDkY3twKRqI86wtLRazATxuiKwHLWiDvfBB/IVirQEicAuwWe
         COh6L2Vh5b15pqzw2YSXG9RSnYyRN3hj+8CswHYyQb6P2CvrZBxRopgKP4eWE1hh9q9l
         FbVTG1jrdz92KByPQzDEw9f0BYjnAKqSwWd6g9Cdz5Ys2sG64jhCQ7En8BWdJZAQYmNc
         QjrD5bXKguKDFZiLUltrd0I7/XdnxPcTd1rLms+vXjToXh/gFfa8TgCj8vYlXMrjYupF
         v8jQ==
X-Forwarded-Encrypted: i=1; AHgh+RqetVm7LJZia0tbxpnUXPVvqDUYrK2y53MrNLYLBdlvckUK4/qLALcsdrx7L8Nb+ToS5/iBrhHXsZ6WeR0XaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyM4JdrXsd4ctdsAE4cTr22vS8ueiExVp37YHj8l2L1wHrAqf+3
	JTWFKgkXlKbS4tC9l6hu8iMRN5qTBxipHZIQOoXN455ZvMPDIUWRMvQ24Q4ITSvYDQ7/TaOmQUI
	QO5bLXwuCZouF8p0EJiGX60qGZD7QOi5qWcaRwOVcx7Lm28A4ivNVNq1k00uw50CkbZPm
X-Gm-Gg: AR+sD13QBfiMOz781Qugh7XEPTtRf30JJSvzw+vBWeJsvyeUMkmNX3It1E+CmiE1iJI
	b90+0ucRfgj4e+PFRc3ued45ixqD2+e8Dp2iiua3hOB6wajV8yx29PhiJc9qSGd0OZwk4pSaqoL
	sHF0JNGVKecS5F4vffnVSrJlsepmJO2KkpfL5Kv/+0FT38yUZYlNcNyvymBqKWB+Qcgg8wik6b3
	BX7yxAgowgufvYIkk6SUTc4DOrDABImqy731ajlQyA+yBrlLUx9LrP2IA/dKFBR0+dfbqDLerAp
	oz54HUOBrHw0uy68pfC+F6SPx233mTxOsLV1bJFNogpyOwhB2zQGShsW9gkTVppVzi15y5p07I8
	7NW3Qc0MVugRrU1Pf33OMow==
X-Received: by 2002:a05:6000:2904:b0:46e:624e:3c2f with SMTP id ffacd0b85a97d-47f8dc8565cmr8118749f8f.47.1784886275810;
        Fri, 24 Jul 2026 02:44:35 -0700 (PDT)
X-Received: by 2002:a05:6000:2904:b0:46e:624e:3c2f with SMTP id ffacd0b85a97d-47f8dc8565cmr8118706f8f.47.1784886275279;
        Fri, 24 Jul 2026 02:44:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f96d4656bsm4931053f8f.21.2026.07.24.02.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:44:34 -0700 (PDT)
Date: Fri, 24 Jul 2026 05:44:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com,
	virtualization@lists.linux.dev,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH] hw/net/virtio-net: Remove dangerous cast in
 receive_header
Message-ID: <20260724054210-mutt-send-email-mst@kernel.org>
References: <20260724093809.810263-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260724093809.810263-1-xiongwm2026@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7-8FSccgCuWd3lVv57RT9hKA4hJMjrt1Ncuiillc_8k_1784886276
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2026 at 05:38:09PM +0800, Weimin Xiong wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> 
> The receive_header() function contains a "FIXME this cast is evil"
> comment. The code does:
>     void *wbuf = (void *)buf;
> 
> This cast from 'const void *' to 'void *' removes const qualifier which
> could lead to unintended modifications.

... and so you cast to uint8_t * instead, removing const qualifier.

> Instead, use a properly typed
> pointer and pass it correctly to work_around_broken_dhclient().
> 
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  hw/net/virtio-net.c | 12 +++++++----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 1234567890ab..fedcba098765 4321006
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1716,12 +1716,14 @@ static void receive_header(VirtIONet *n, const struct iovec *iov, int iov_cnt,
>                             const void *buf, size_t size)
>  {
>      if (n->has_vnet_hdr) {
> -        /* FIXME this cast is evil */
> -        void *wbuf = (void *)buf;
> -        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
> -                                    size - n->host_hdr_len);
> +        const uint8_t *wbuf = buf;
> +        uint8_t *payload = (uint8_t *)(wbuf + n->host_hdr_len);
> +

Forgive me how is this better?
what is properly typed and correctly about casting to uint8_t *?
As far as I can see all you did is remove a comment.

> +        work_around_broken_dhclient(wbuf, payload,
> +                                    size - n->host_hdr_len);
>  
>          if (n->needs_vnet_hdr_swap) {
> -            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
> +            virtio_net_hdr_swap(VIRTIO_DEVICE(n), (void *)wbuf);
>          }
>          iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hdr));
>      } else {

