Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5853A325735
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089690; cv=none; b=fycZeHU3VuSspz7FWoVAVV80JfIF0OVnG63J4ciw8anUFSmQlbWUblfLMTYK5h/22alZjlnHMpHe7XkRdUsnojkJ0FcwCQTAlgXDfUjvXkMwpGi4GeqfzY5KXo0UIxNjvG1wHLJ9SZkcWUVHxqMhUn5V7/arbRZNLbeByf+Jy48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089690; c=relaxed/simple;
	bh=M1xVC7gLm/5kXEcyVn8F+hiOuj4fAZSxatNimx4cXKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ar9F5XyynvHixa4hubfUh6OBYJVga3/TtNmQqTd+WrTUQgJK1dQlkPZmqwYeHQtXEKUwkiRySgafiWlWkuI0d6iM3CjPAPxCXo0OZJOsfIxQdutIZmbWiIkNHmmaLLzhxc0I4ICOrDXnmlk8PjnOUNXc0nJs2Xx9E0LxYMi3Qc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICcfg524; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICcfg524"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764089688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VSyjzVF3bRMyEucyth0abh8Rzk8q/nESWV3mm3a9fMs=;
	b=ICcfg524yyWncZ46IOSHVChjwYI3HeeZegxEEnf1aj0wvS26uhPhhTf7QuEdUjkfKny+Bt
	qWX+o4c+Oh5iB/O6+kwYutNmoSeCgJRkIa/p+GEPmcg3Sni/QYjaNOpZHDFLUfvbcJJMmo
	/1GvpdqqIGx6shlUmMvbGw96CdD24YU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-pIYm93CDO72J_8eaYlXF2g-1; Tue, 25 Nov 2025 11:54:46 -0500
X-MC-Unique: pIYm93CDO72J_8eaYlXF2g-1
X-Mimecast-MFC-AGG-ID: pIYm93CDO72J_8eaYlXF2g_1764089684
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775d110fabso50344175e9.1
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 08:54:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089683; x=1764694483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSyjzVF3bRMyEucyth0abh8Rzk8q/nESWV3mm3a9fMs=;
        b=gmB1MJmx21DhTCR444lz0gGYG9gFhhywRz3kL0jSBne5t9yLsa8+aHmOJqj4RbeEc7
         vfqVUqKfAZhVIkBkLf9r2bkD6zF/Vs00fmylahhuQD8QOV9+rF6hFF4JcEu1KU3tgqps
         LTJMJ/ggdYmPdfKfbCiCoTn9KaYAn+rNAy8deqlFIvmeiM7TfqXKsWqNtsJ/rDQ1YhZk
         VlURxTCnE3QSj1eIMeg2M7WZBLBBKvtmT15klHooutXIvlqhPtDGjcb0SxLNyrbIQKWq
         h+XcdEMeYxbyLtGE7g5EiflQ4qjd2UYWloxg86Zxx7Yb39sbICIuzF6fulJ7AQIEduGg
         VduQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPt3JGRLyDYS6q2q9dt6FzG0tqeSjUkvPFGglKBZIcSQ2XAF0aphkojzdMjzJ9gfMb8GGXs16p1PNRdxGv6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNjVlMxVbajvJc7if+WRPiG2XHzCbnh0RmIsqoFc0ZdudG71Wv
	veC17D5qQOyUrb3z7ZtOWdBNx0O5cZEmYPQA0f0fBD6T42EjZu/37Vj9xoLVfKBPM9q4QwrHSWF
	Vr53aOJex9isJt3qDPtStR2cuZebJz1x0PSZNWinq4wODVIPlMIfXVsX2Do5FxsGX+XUx
X-Gm-Gg: ASbGncs3jqcpwoJFCOr4VRScnrRdAhsOCAgLQ+TfEFIQEPTCTCthyNNqoJYkAU/0S85
	ra5lmKCtNhiuNOjH3zGf3TlWrz83G8EOFct51CIWNBPjerOmGfA517+GPVFxVYVMMAlU2POKplx
	bYQkNYOG9END3frrWgPeKsaGtTErBlvb5v29PB+GvRUSOcaIxSQnbQqYGcxuozg14bbGxAmJ9Rx
	eeAQSk2Jtv1pshMnpm38mq7TwH8CKW8TYldrmDtMVAbHzuoMrdq7PrmvcXZ6hp/0zK7emGUZdvD
	Eliw6ONIrSnGMm/EbHfqUQNQM02M4gT8eK0Ecug7fEjv7AzYMVrR5USBW0+pt7APYr3lWTqAw/4
	tHX98vz/p8BBUcYAG7X8eGaMbsZAlDQ==
X-Received: by 2002:a05:600c:c8c:b0:471:1435:b0ea with SMTP id 5b1f17b1804b1-47904b242eemr43823125e9.24.1764089683418;
        Tue, 25 Nov 2025 08:54:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI01s5vSZlwPc1XuZyxkfAjV2ILVY5rmqifLiNvt5a+hPHMgV9ZhgyCmVtX0zbnJSE6jyd/w==
X-Received: by 2002:a05:600c:c8c:b0:471:1435:b0ea with SMTP id 5b1f17b1804b1-47904b242eemr43822735e9.24.1764089682896;
        Tue, 25 Nov 2025 08:54:42 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1e86b3sm317496245e9.6.2025.11.25.08.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:54:42 -0800 (PST)
Date: Tue, 25 Nov 2025 11:54:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	jon@nutanix.com, tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v6 3/8] tun/tap: add synchronized ring
 produce/consume with queue management
Message-ID: <20251125100655-mutt-send-email-mst@kernel.org>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <20251120152914.1127975-4-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251120152914.1127975-4-simon.schippers@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6izYr-4xaoCA1o4SqJnwjqg0k4agm_qv_Upa2rvnXG0_1764089684
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 20, 2025 at 04:29:08PM +0100, Simon Schippers wrote:
> Implement new ring buffer produce and consume functions for tun and tap
> drivers that provide lockless producer-consumer synchronization and
> netdev queue management to prevent ptr_ring tail drop and permanent
> starvation.
> 
> - tun_ring_produce(): Produces packets to the ptr_ring with proper memory
>   barriers and proactively stops the netdev queue when the ring is about
>   to become full.
> 
> - __tun_ring_consume() / __tap_ring_consume(): Internal consume functions
>   that check if the netdev queue was stopped due to a full ring, and wake
>   it when space becomes available. Uses memory barriers to ensure proper
>   ordering between producer and consumer.
> 
> - tun_ring_consume() / tap_ring_consume(): Wrapper functions that acquire
>   the consumer lock before calling the internal consume functions.
> 
> Key features:
> - Proactive queue stopping using __ptr_ring_full_next() to stop the queue
>   before it becomes completely full.
> - Not stopping the queue when the ptr_ring is full already, because if
>   the consumer empties all entries in the meantime, stopping the queue
>   would cause permanent starvation.

what is permanent starvation? this comment seems to answer this
question:


	/* Do not stop the netdev queue if the ptr_ring is full already.
	 * The consumer could empty out the ptr_ring in the meantime
	 * without noticing the stopped netdev queue, resulting in a
	 * stopped netdev queue and an empty ptr_ring. In this case the
	 * netdev queue would stay stopped forever.
	 */


why having a single entry in
the ring we never use helpful to address this?




In fact, all your patch does to solve it, is check
netif_tx_queue_stopped on every consumed packet.


I already proposed:

static inline int __ptr_ring_peek_producer(struct ptr_ring *r)
{
        if (unlikely(!r->size) || r->queue[r->producer])
                return -ENOSPC;
        return 0;
}

And with that, why isn't avoiding the race as simple as
just rechecking after stopping the queue?

__ptr_ring_produce();
if (__ptr_ring_peek_producer())
	netif_tx_stop_queue
	if (!__ptr_ring_peek_producer())
		netif_tx_wake_queue(txq);







-- 
MST

