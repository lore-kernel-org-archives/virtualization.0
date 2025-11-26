Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CAC2DCC03
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147419; cv=none; b=MqQEsDcw2zcu1VKzF9+bTdxAJCE8EOt1H2p4hKwRoMITdlzMoJuHE1/zIxzm1/BUZDrkw7vmbkrZajaYuMVGNsyiERqEHNQEIYyzwZWCF2t8AkhZtOattTQnUC55RFKEu2fkJIgrhhQA8coaIm9IcDBDWnf9x5MYHEEUd+XWz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147419; c=relaxed/simple;
	bh=6t9MHJvf6sqh5JX+QcZaEOpVyD9pO0GspMuqeY837mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fUZKejoxfL5Uo+ktOBhMckzUp8pPZ/j/ipqkHf8JfHeThpKzsjM6ln+UFfvbtnm+gKmNNOp0SPYEq4KWsrYRCTt+ggptbZLeXGLp3FN71UcWwn9wu+m09vQMnIunbEBG90EFNp7r9lEz/e99FTHfqN6dtpmcAIfMapdKhR5yx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bcZdu+6j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcZdu+6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764147416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kip/JEcZ74T1Ftt4LkCGX9wwyy/CfbbaxlGjsxIU+gQ=;
	b=bcZdu+6jDkGblo3ux+/ZnH17VCKYFdVEmKH4baCKMVn9orSUKIQx34Zgmq5uhHsjebXN9u
	kRL1QZ4vJ71nnfVxl5bzJa2pnWsynBOPjN20vpiP6ynm50UiVl3tZVTFv8vryyDJgr7OdX
	hjGV6ur+wwUkjIGC7Z6/mtMZnIzrzr0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-6FiL_U1bPhGtywj3GGlzwQ-1; Wed, 26 Nov 2025 03:56:54 -0500
X-MC-Unique: 6FiL_U1bPhGtywj3GGlzwQ-1
X-Mimecast-MFC-AGG-ID: 6FiL_U1bPhGtywj3GGlzwQ_1764147413
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429cd1d0d98so5316475f8f.3
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 00:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147413; x=1764752213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kip/JEcZ74T1Ftt4LkCGX9wwyy/CfbbaxlGjsxIU+gQ=;
        b=pb76KQjaJVvVE5HAg9/wb7nR62K1KTaFA7PrIqz+7nOBDnn9tYykwqGOFIn/4a8WKf
         EQYMcwphoqShEQifsLY8i44PLUUHocr5FESJBVsU2EYfGsyB+J6RhwNz6aeDLhz8me0a
         VF3y8zuKsp+H1XtKFZlt+uxbeE0EZVJqNDnSk5knh0RMEnfE7MO5jYcoeEwsjhDX0dXa
         KhNxnOXrfmGLOOIAqCS7VALWZCOftZwp1PEi9Dw3tE4C6hXzomjUxo1Yx5P3pbJalHJ+
         dCFtTXRJiZ4squJeVyUHRu30HCklEWBbwGe7l9u6S8jCzDtNZl9DY3PyqEmi73rMCnxz
         c31w==
X-Forwarded-Encrypted: i=1; AJvYcCULOW/Kgo6msMN+JnyfcrV/oHTTtwc72bpy4vCMXj4/cCcEmK6n7i7yxM9JKWP+5Dq8hNIEox/j6IlFFaSDtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfZgvJut8S7B+STjTgVgLAd2gOU6rlWtgPUlxYAfBlsyP0ZE/v
	JS556hrgAvpd8rECB6KjQZQZDLOFqp3EHtS6Apqovbpf/9yZUiTF35MBQF5L+F+1BmjiiEQ8M4x
	hq1vhPM6eeRdBSMb9iwcWmPLt8+8mEHtY8sKGVb6g/6lnHGwwbkhiUtDIWJncgXAPOt7K
X-Gm-Gg: ASbGncux4ihZMIi4kaUOXl7mG25/wrxgZNK6N+bh1B4C1Hh+ivix4uZeVS8arXPk4pQ
	5PpjiLkXhrWkWk5ytwOOZYilNrBYrRlw9rlCqTWNqpJVP+c5Zt874vC6L369sDPAEK26y+qddcL
	BNbvWDAdvN+9UZLUsBWiRYaEkF+pRIRnHcFCl3Y/aiPxXhRfY8yzIGxUVNd2sEZVjyCO9P31emr
	uyMWP60N8BbAS+SUTFeC2sSZK5/ElWgIfnmsPRw7I00iieyI9ptKfhlCWwQ+t/oJ1u9d7u9Pfng
	P5+zgirbMOZmfkCBXYzFOyGE6T8Mt490E2n07nC7KDncBtplsSgt5DY11m7QUOsv45AT0oTjsqd
	h5R/TlLag8bfuVpqm3oUqLoaEWPp5XA==
X-Received: by 2002:a05:6000:26cf:b0:429:d66b:507f with SMTP id ffacd0b85a97d-42e0f34f9a3mr6307243f8f.48.1764147413175;
        Wed, 26 Nov 2025 00:56:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHNNJ+IsPSYIWyu2oPIp2uYsK6e3LWHa7plQXIOftsh9/qPOW1IRQVxpm4kwwQqwDr9WWQeQ==
X-Received: by 2002:a05:6000:26cf:b0:429:d66b:507f with SMTP id ffacd0b85a97d-42e0f34f9a3mr6307216f8f.48.1764147412671;
        Wed, 26 Nov 2025 00:56:52 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3592sm37810702f8f.21.2025.11.26.00.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:56:52 -0800 (PST)
Date: Wed, 26 Nov 2025 03:56:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vhost/net: check peek_head_len after signal to
 guest to avoid delays
Message-ID: <20251126035449-mutt-send-email-mst@kernel.org>
References: <20251125180034.1167847-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251125180034.1167847-1-jon@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ha1C-JQBTU-sYPPGSBgXEOuzZ_wqSywY2yXih73tFGM_1764147413
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


I also wonder why don't we assign len here.
I get the point about being fair to TX but it's not
indefinite poll, just a single peek ...

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
> -- 
> 2.43.0

