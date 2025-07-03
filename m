Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2892DE6E2
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539898; cv=none; b=OMWUO+NzE0e+5fOK+cfErNSYbSjgfa/yKHFU4ZuyiZjPG4rPcS03YiqfIh6b0eeSzFuO09/7Aog0LE2Gf4dZB0JFlOCmUhrdY/jDvTkoz9euuxPNWHQT7O3dLCaCjCAJBpOHbaS+oZuF0VlFjR5+j3l9dN+erxb1PcG1flopV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539898; c=relaxed/simple;
	bh=OqvSnj012lk+x7sxrjtbztoI/YmrJYSA0WWNrX5Fpj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=izTdBnntTc0GfqqJIGgufXoruao5f32LVadM85OMM1YseE8S2CsR30tor7+4TujfvDQLkBKxSjmV2oYTvFDRkdgNUitJcwtYsacebLFIdOajVJzJlD7lik2J7tvy8m6ixExvBrs3YyLx1+WzDaLk+RIMpPJyvk7YflA1j9LF28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3N5BSfF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3N5BSfF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751539895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PTP2cROOIMAlCq/5T6gTKModShdkxtZnGGTA7OvrtwI=;
	b=H3N5BSfFWDrDRV95R4aNyBp5ThsfEFj0ZFfB5N4BWe0DoBQDyFqXGqxUA2iiMrflhrngaI
	tqOuScSSAMqeuWdoypEPKy+oITZSNvdDc65GjFNU9Ma9TKW/8r9m/ouFLgJQmKDwpSXugy
	s4MJFShFlRIz4oCl2Fkjg5jZU9aLGMw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-LS3EAyETNCmI23KLxCzXcw-1; Thu, 03 Jul 2025 06:51:34 -0400
X-MC-Unique: LS3EAyETNCmI23KLxCzXcw-1
X-Mimecast-MFC-AGG-ID: LS3EAyETNCmI23KLxCzXcw_1751539893
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so3323420f8f.1
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 03:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751539893; x=1752144693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTP2cROOIMAlCq/5T6gTKModShdkxtZnGGTA7OvrtwI=;
        b=vLGUMFWMRydIcKHuRDaMAKdl+rfzKF3SNE1tqyEpZNpF1CNUGT0f4oRY/GFK4vxZ7G
         rvSc/X+rvOB4PSnqGl9/IgMtfsBMd1y6XPVuHaCQ1eoDrFXTjkU3A9DBJ9ngPlvmoa4L
         edDHujsAcEcMr0NXoJFiHIo+STajF4hcAhrp16dlGPx2DGvtt+LwFjdnBvH8XvisA7e3
         0WC4SeQ/vFO6kdLjSKAv15YKxCu62b4rbNnoWhdELYzkPT6UAVEbU3UO7ckiTHIP6Do2
         sO0gpHImTDFQI/sFY2hcRKcSwOrYWAqFz8jNqg3ASR8i1fm2/5Qr2A2eUD9s07p2V/lh
         BrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM/We00PdAYvMyoaLYhxIy1c3ZTfUKV3kpdRBbv+FN9ywBK6XkP9icxWaMIjxAX7WT6yCMrfHkeRv9YtHz9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzB09v+PrJWdUKtvDmc/FJErV2FhEyCHakIMKi3d1DTFHAyZaED
	LLzAE1O6kTY+1UQhwHIrSoUrnKvkVDdgqdqFW5mGtrA+uTCDeoJpBzUBZ22qoZaDuJQ8ghurlFY
	R0Q8PmjGMrdb2fqIZODeEDU0jizKdptEIbTyS9fV7ahi4wPPQhJIsbyAG1V0jvZ3lCM08
X-Gm-Gg: ASbGnctWgTPpCKQI8fDPMG4LTw/pkKwh1bjbS68s1Y4Ez5lJ9i6UuP+zFCfghI+tJFp
	R65vWWC2wLuBLgntUJZxfJKkhFqKXibXFL+Jj+ksPmww9SSNVzE9E0/UdiFmqbMQcWO9F4bnIcy
	WGMZOzzgv3M0Pyu1Uu18CB+yJGO+RCVMj4vA+8wyr+0VvPqqCNFQ0fWZ8nuQziE8eBkyEn+x3j7
	VGUEMW9ZNKVDsTCCjuHnZmXnEcpvdU2w+0ciaJwKitZcvfCvdxvy4/4KudADsqZFlAoUwWzN9Xo
	iW0vPjcAzBIoH3noKN1pSL+p8/UM
X-Received: by 2002:a05:6000:98a:b0:3a0:aed9:e34 with SMTP id ffacd0b85a97d-3b32fa3aaa1mr2092531f8f.48.1751539893410;
        Thu, 03 Jul 2025 03:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaIrtPC6+L1M9apwjRSTfcpVN1M7WJhIIwoutF3s+xjdaNvBgiwXew6JQLCZDeO5sbSJK9KA==
X-Received: by 2002:a05:6000:98a:b0:3a0:aed9:e34 with SMTP id ffacd0b85a97d-3b32fa3aaa1mr2092503f8f.48.1751539892823;
        Thu, 03 Jul 2025 03:51:32 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.161.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e62144sm18619571f8f.92.2025.07.03.03.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 03:51:32 -0700 (PDT)
Date: Thu, 3 Jul 2025 12:51:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	HarshaVardhana S A <harshavardhana.sa@broadcom.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	stable <stable@kernel.org>
Subject: Re: [PATCH net] vsock/vmci: Clear the vmci transport packet properly
 when initializing it
Message-ID: <ktxstfr4rxrvk4pvdreumdch55ieexfclozovszm24o6xmb7zd@nmo2w2ffu2kw>
References: <20250701122254.2397440-1-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250701122254.2397440-1-gregkh@linuxfoundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: atys_VCjRaywB437o8nCWVs7wY3pNkM3RvZ7YCAH188_1751539893
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 01, 2025 at 02:22:54PM +0200, Greg Kroah-Hartman wrote:
>From: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
>
>In vmci_transport_packet_init memset the vmci_transport_packet before
>populating the fields to avoid any uninitialised data being left in the
>structure.
>
>Cc: Bryan Tan <bryan-bt.tan@broadcom.com>
>Cc: Vishnu Dasa <vishnu.dasa@broadcom.com>
>Cc: Broadcom internal kernel review list
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Paolo Abeni <pabeni@redhat.com>
>Cc: Simon Horman <horms@kernel.org>
>Cc: virtualization@lists.linux.dev
>Cc: netdev@vger.kernel.org
>Cc: stable <stable@kernel.org>
>Signed-off-by: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>---
>Tweaked from original version by rewording the text and adding a blank
>line and correctly sending it to the proper people for inclusion in net.
>
> net/vmw_vsock/vmci_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Patch LGTM, we can fix the switch later.

Stefano

>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index b370070194fa..7eccd6708d66 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -119,6 +119,8 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
> 			   u16 proto,
> 			   struct vmci_handle handle)
> {
>+	memset(pkt, 0, sizeof(*pkt));
>+
> 	/* We register the stream control handler as an any cid handle so we
> 	 * must always send from a source address of VMADDR_CID_ANY
> 	 */
>@@ -131,8 +133,6 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
> 	pkt->type = type;
> 	pkt->src_port = src->svm_port;
> 	pkt->dst_port = dst->svm_port;
>-	memset(&pkt->proto, 0, sizeof(pkt->proto));
>-	memset(&pkt->_reserved2, 0, sizeof(pkt->_reserved2));
>
> 	switch (pkt->type) {
> 	case VMCI_TRANSPORT_PACKET_TYPE_INVALID:
>-- 
>2.50.0
>

