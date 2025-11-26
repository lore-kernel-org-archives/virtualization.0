Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24C4C9D
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764139281; cv=none; b=NwRHNXQkbFXWwZB+g6eq2lrk3XNRVb01lQ2ENXA7Y5imYljVzRFD/6TxPO7TAzqpWuZBDJHPrJP6OvywwbpildC2LZU8jzNgikHBikO391jrwrupIiNMW+z9dT/y9DUYoMcb+3wwUXEiYr+6isBEBH0BpEdGw9Kl87vl7UMt9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764139281; c=relaxed/simple;
	bh=QGAnoy4Dpq+iZUpFV+/GD9HeagIzEqq8RFCNZfqkZDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=snZ1zgqLYrgACKiKRips/W/pwovqq2yCwiFLRhEk0TC7dcuiW2NCHNuyr+YHg76jsyfsATfWyKOZTswVvOjW6qmj8ovkAwRAHlqIrag2zNGJWGtNGGFGqKZr4S/fZ56e7RmP+AlnBZBD9lvhfylrJ1vCKpQ1mMg2z+5MkZSQw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VG04zcCh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VG04zcCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764139278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2gwbwF5MFgvvyjCvPMrgDXnD+XmnUmUshXklxp3cjS8=;
	b=VG04zcChr3ZyEginJp68jsnGm5WAW2jn8e+AFKW4JIQlb3QZVCXkijDHn5MaIwdLYFbiXJ
	1UWCVOTavHxV+N59KI9xsJGb5pI/in4AYFUVsaAcCaCCzUn8HiQIR+JedPK5Quhbqd/8Ww
	oHfHAh1A9yMZR0DbVMe7TgYKaKjGjdg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-IYV3plQ3NpOVnjST0lihYQ-1; Wed, 26 Nov 2025 01:41:16 -0500
X-MC-Unique: IYV3plQ3NpOVnjST0lihYQ-1
X-Mimecast-MFC-AGG-ID: IYV3plQ3NpOVnjST0lihYQ_1764139276
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so30715355e9.3
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 22:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764139275; x=1764744075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gwbwF5MFgvvyjCvPMrgDXnD+XmnUmUshXklxp3cjS8=;
        b=R3cs6g9FkcqxE3DBj8EICNCSumZ+9gyFujeXHCVPHx0ZrasASMWZFjpJ0+vSArteYq
         vcbnK3Okv8cAmIOqIa5HyQaPfDtP8+yMOsW4swrgYvxYN2jAfWquUGvPw6mS0spFl5nt
         Ctueh5lzHcm2TxQsd51QMRjcuSjPzBqOw2+OEMTcCKXwIM8/bNod/6/25CAqRaFewWmG
         XmCgvgTIRd7e7YWmK0Y/McX2wuidUIAZPZgzjN21O06aJSBfKmqDg8LgtUnnfqnZN9ax
         u0dSuE8zcdGDTJWI8A9AsOvjhvI3lJB3z+38RAimx7mvB0q+6RoyRTFXZJaTIZ2Ffeun
         Ba6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA7egl8QWNbViuDGR9TIcfAU+SiEpC8LhNnONpBNeAA9WeNasNvcGPCbWcNfCqInUSNZ2AsSOEBCoMlF5sMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy19JpRS+ACbUFASdj2zk5O4VGDwefHgKOYBS2pbaw38hUqVCs0
	o2kSsJFT+FEcbliebbONdhpfwiIGfIx/CmZ5NPClfagxEBjA+ip10FTkwAFxji/VWm07bDRckxL
	4vuHuJIb8Jgg/zUHeJoFigsvjXFifhiRgZuwd4b/DCy+ZZm00j1CowNEoijsqEP9x/TqW1KxGeB
	xl
X-Gm-Gg: ASbGncvct83yXWVxLQguWeCDy0A1cxWMMNypO3OFU+/3fn06RNyOSgv5F2NQVxuwzj+
	LqF0wZ1yCfx0NXIONaUds5VC0kRSqUMeA8nKyoLrChY0Q3rAO++L10K5oaC/EMlrb1WnqbX5VMB
	viWXkAg+WQlrx0uZPWpJ1k7WOF6KE24VxDN5wSn+H6FBhVj8YiqWLTZYPhlTMSzGG8dnRRDJvlx
	DiHgvJztJ6pNCtYJEjIK768ZXXfXRs5hSCiLBL+5jAfbImSYB2GX/Cj6CEW41Hoz4Ceix1WUCTo
	8cVFFqVCxufgME2hJnoUypr9y1tnYnJe2gAytlMJ1uI4IwE3SG/z8AIZHe1urfH/kJ24Ew32D4n
	E3pGp6qNUHPO4UAMlvLOBE3qhzi7eSg==
X-Received: by 2002:a05:600c:474d:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-47904b290bcmr52060315e9.32.1764139275449;
        Tue, 25 Nov 2025 22:41:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDoRireQsP5/XG7ok5T657RYeSY0MQ0WBAZuQRYdeqW40JoE8OKq+SygU0m3K5smDQLLeFzw==
X-Received: by 2002:a05:600c:474d:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-47904b290bcmr52060165e9.32.1764139275010;
        Tue, 25 Nov 2025 22:41:15 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790adddb4bsm25619865e9.7.2025.11.25.22.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 22:41:14 -0800 (PST)
Date: Wed, 26 Nov 2025 01:41:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vhost/net: check peek_head_len after signal to
 guest to avoid delays
Message-ID: <20251126012918-mutt-send-email-mst@kernel.org>
References: <20251125180034.1167847-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251125180034.1167847-1-jon@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7Mu-oDd5L8lioolvOna1_kQYunC6SD-UmGnLccBU7ys_1764139276
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2025 at 11:00:33AM -0700, Jon Kohler wrote:
> In non-busypoll handle_rx paths, if peek_head_len returns 0, the RX
> loop breaks, the RX wait queue is re-enabled, and vhost_net_signal_used
> is called to flush done_idx and notify the guest if needed.
> 
> However, signaling the guest can take non-trivial time. During this
> window, additional RX payloads may arrive on rx_ring without further
> kicks. These new payloads will sit unprocessed until another kick
> arrives, increasing latency. In high-rate UDP RX workloads, this was
> observed to occur over 20k times per second.
> 
> To minimize this window and improve opportunities to process packets
> promptly, immediately call peek_head_len after signaling. If new packets
> are found, treat it as a busy poll interrupt and requeue handle_rx,
> improving fairness to TX handlers and other pending CPU work. This also
> helps suppress unnecessary thread wakeups, reducing waker CPU demand.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  drivers/vhost/net.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 35ded4330431..04cb5f1dc6e4 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1015,6 +1015,27 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
>  	struct vhost_virtqueue *tvq = &tnvq->vq;
>  	int len = peek_head_len(rnvq, sk);
>  
> +	if (!len && rnvq->done_idx) {
> +		/* When idle, flush signal first, which can take some
> +		 * time for ring management and guest notification.
> +		 * Afterwards, check one last time for work, as the ring
> +		 * may have received new work during the notification
> +		 * window.
> +		 */
> +		vhost_net_signal_used(rnvq, *count);
> +		*count = 0;
> +		if (peek_head_len(rnvq, sk)) {
> +			/* More work came in during the notification
> +			 * window. To be fair to the TX handler and other
> +			 * potentially pending work items, pretend like
> +			 * this was a busy poll interruption so that
> +			 * the RX handler will be rescheduled and try
> +			 * again.
> +			 */
> +			*busyloop_intr = true;
> +		}
> +	}
> +
>  	if (!len && rvq->busyloop_timeout) {
>  		/* Flush batched heads first */
>  		vhost_net_signal_used(rnvq, *count);


Looks like this can easily send more interrupts than originally?
How can this be good?

From the description, I would expect the changes to just add another call to
peek_head_len after the existing vhost_net_signal_used.
What am I missing?


> -- 
> 2.43.0

