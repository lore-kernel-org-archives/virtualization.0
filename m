Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E6D39850
	for <virtualization@lists.linux.dev>; Tue, 19 Dec 2023 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFn1R/5e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703010992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v47UTmHzAdl2Nt8HKA6jp1il3Lpc0GyKxIVnJREGniE=;
	b=gFn1R/5etANBA0Ps/hdSIAO/R+EDZGciNVY4mz85QiqoCMisUlrZnODBcW3FQ2OEu4r51c
	Ayluk0J0qy+uSBDaHYjp1ocqq7HJ95NQT/2/b2Kf5IN2sIEXAZmHtRwfxA1HgVvGTTgFgs
	woIm2oNo8/gUxRxULxoXWlrj2g+xij0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-2HYIwY9ZMqGAKEnApCEKlw-1; Tue, 19 Dec 2023 13:36:29 -0500
X-MC-Unique: 2HYIwY9ZMqGAKEnApCEKlw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d2f91c2aaso3660165e9.0
        for <virtualization@lists.linux.dev>; Tue, 19 Dec 2023 10:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703010988; x=1703615788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v47UTmHzAdl2Nt8HKA6jp1il3Lpc0GyKxIVnJREGniE=;
        b=NUohFKsyaXaMswX2rUmxJc3efap+3XX+B++Q+PGJ4sNLy0eui832YPudTg0KkgVgCu
         wZQGh+kBqqSPbv3Wcsqkd7QpPj1b9wUAhHjsj8BdNSn1NEg66WM2hvEw4J9ffcdj2RIQ
         /FpDx4+l0SR8Og6SnqE314YwYdulRLNe+f+HgISNbFFvLlaVfuOtVAzeVa6yo2JvLKkT
         fKP6TrIphEUo8nU4W3lpVVKOALG4kLeDtqe6M8qO2LhudZrt6kTbF4hFjKC4/DL8EPDt
         sIbl8Rp2vGx9VFmkzkHuB/tKaoOam1scYYLoNndPbv2np2XhvzpMNvI4BD0mqgfPKafG
         okrw==
X-Gm-Message-State: AOJu0Yzib/ZSsnglxTsvqvoNCAdBY1hNA8PDgwZg3axBZMxBmlOZGiX4
	Y1jiTmAHYKDFvgfsutoT7kz6IL9xbOw/D0uyoHCoptuYbt00cnbgQxiwqqCg9ntHkLiKfaAHuXb
	qsCrIDgY8wz5efIC6OgovJtd0IW8=
X-Received: by 2002:adf:fc43:0:b0:336:73ea:b831 with SMTP id e3-20020adffc43000000b0033673eab831mr846384wrs.50.1703010988639;
        Tue, 19 Dec 2023 10:36:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7ZDUfdCp8TeJng+VjBTvRf6OjZ70v7Qzcn/FZ5sz+Lbr05EsgZlGNV4j59UjFadCCiaJivQ==
X-Received: by 2002:adf:fc43:0:b0:336:73ea:b831 with SMTP id e3-20020adffc43000000b0033673eab831mr846375wrs.50.1703010988261;
        Tue, 19 Dec 2023 10:36:28 -0800 (PST)
Received: from redhat.com ([2.52.148.230])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d48d0000000b0033616ea5a0fsm26973853wrs.45.2023.12.19.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:36:26 -0800 (PST)
Date: Tue, 19 Dec 2023 13:36:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH RFC 1/4] virtio-net: support transmit hash report
Message-ID: <20231219133545-mutt-send-email-mst@kernel.org>
References: <20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de>
 <20231218-v6-7-topic-virtio-net-ptp-v1-1-cac92b2d8532@pengutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231218-v6-7-topic-virtio-net-ptp-v1-1-cac92b2d8532@pengutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 18, 2023 at 12:37:08PM +0100, Steffen Trumtrar wrote:
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index cc65ef0f3c3e2..698a11f8c6ab9 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,7 @@
>  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_TX_HASH	  51	/* Driver sends hash report */
>  #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
>  #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
>  #define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */


Please make sure to register the feature bit with virtio tc
to avoid collisions.

-- 
MST

