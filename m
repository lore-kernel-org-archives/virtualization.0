Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E223F3074B3
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905063; cv=none; b=bzyJNSa19QOOXySwjwDu/BVTxmUF/sCWRggyAl9GL/RzagLF06tOyDHX3fv5RE1o4zXm1TU45I9eIX9kF8LlPXl6md7JWfg3PqV7gmQoyjFCyZw9a0wp8QVhZPS4l0V195QbSOOt2gjLzfBnl7WkazIMOjy8CVYwUVOmkzztcCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905063; c=relaxed/simple;
	bh=Y/X2fWSGYvLP2GbzQgVsXw6QemqhTogGncbWhT+ee+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hjvwducBjsSrO/irB/B4Y0yZUp7VsRhuK4NDJIHiYAg+rM3rBpNMxvnZCYmqBb8i4LH5uw+6uPJvyCEiAO0dTOgd3d/5/ItmZm3VRV7cG+h1r62/eZC3uQ/lr1fyqVzXm6Tb09yK/6OB7yn/9PVRBoy0dAV8NtVeo4IMytwCeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Exi/sR+R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Exi/sR+R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756905059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fu1nRMO4mP7hG3XcSYcXuE1KvbxzA7CKEO6dC9YqXJc=;
	b=Exi/sR+RglCCQh5NKRerIUxe7lNdKnobFr1idk05dobUYMt3zyqsUFNYhmfxu+XcloWcge
	pFIZtHi9wp0ALqJLMGmIMCevOUoF/2Zs+6Ykc+9EaOl5GgGWJXL0a1zxcxpT+CYhdtUNia
	TDzGbSWUwV2hgbWKVlrdRdQoUuil1FA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-5n5g8x2ZO2-PLE6mwixObQ-1; Wed, 03 Sep 2025 09:10:58 -0400
X-MC-Unique: 5n5g8x2ZO2-PLE6mwixObQ-1
X-Mimecast-MFC-AGG-ID: 5n5g8x2ZO2-PLE6mwixObQ_1756905057
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3cca50781ddso2866663f8f.2
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 06:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756905057; x=1757509857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fu1nRMO4mP7hG3XcSYcXuE1KvbxzA7CKEO6dC9YqXJc=;
        b=wESFiy1l1b09Nh0ILVaOy3vtRggrjrqJ0MsiELbjwqzQ1r4ZsvS1do9Aj3GT5SZk8h
         E1pf3P+wH9CL0LmpBqslQNDJ7pUEfiGkAucDz5i2pvAUpFI55ry9YclpdZu2javZyKyk
         quXcvXrv1MF9GJNaKQnU1DZHZdBXyJmWbb3Km72oPYt/jq3ZQ2aLcb2nXWlXhA4N9R9O
         VKOhWQhtnKA1Rb7LFPtOmrM8OasYhUWIQtQSEkTuaDi8CEnIQF6cREBB6c18e5mz8uy0
         aivuGCI0LELXpTRea3/ucKx2lVKOCJ5qbur//xYTzALu3M3QJYDGLeJxSZOSZxWoJPxJ
         42jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAU53F4d0IM21GqSxNPxMjwYC8mJ8rHej3XF5nA0Lj9clnwD1ltBLy+0Nj+PNQgaQW0Lfel7sKj++VTQ3vew==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKzOYAF1sKNsgz3liu627VJCIeIjPqIpQGCGh3BUO29NBtcHWE
	Xw0Txb1L+vONqFvw7RZ2crqYAQWoKUK/xtEmfOJgSysP3PXMs5EXTQOB3SL1ekYSvt6DllHL5/P
	7F9dz3KCWc2iYNtdWnd/tCcpsMDA8O+47zSnn7XQ/7oL8hzM4AB/yfv6aiRr4aPZOpUf58qM4hr
	m1ZoQ=
X-Gm-Gg: ASbGncuRs0N83FmvDHtk0aIK/0bWajgdSfkQc7NARyOyqBywnLpP4StfJ4eLZzHxiKY
	DOJksPC/OXYmvCU6rTR+2NEptpX64FDjEuKvJ/rGJPW7boNlhvJao5vXpvLaXuUiCzegwXiTnC/
	m64Hm+pXhY1phS2bOSar4NKHM/63qz7MT7Tsk0mC8AXj9ftf2zYjBGeArBzcrynNMuEIjq86BkO
	BDBVDgumr5z4l+sgO2urECm23uAuBBUcnuYJvmXFkpnjzy44xsSmME4hXS4FfB3i9Rw70xLp84j
	RfGw8bTMI0a227ZsxKCX/pfV16M6Xw==
X-Received: by 2002:a05:6000:3110:b0:3cc:29e8:d52f with SMTP id ffacd0b85a97d-3d1dea86a76mr12153286f8f.38.1756905057065;
        Wed, 03 Sep 2025 06:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb0624kVbYkja7DUsEoelJ71o6GXCbvgslVOj9fGNi28SVeur6o32uG23Fh/vV7MnRvsF1pw==
X-Received: by 2002:a05:6000:3110:b0:3cc:29e8:d52f with SMTP id ffacd0b85a97d-3d1dea86a76mr12153241f8f.38.1756905056517;
        Wed, 03 Sep 2025 06:10:56 -0700 (PDT)
Received: from redhat.com ([2a0e:41b:f000:0:c4d3:2073:6af0:f91d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e92a42asm237242065e9.20.2025.09.03.06.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:10:56 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:10:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH 2/4] netdev queue flow control for TUN
Message-ID: <20250903090723-mutt-send-email-mst@kernel.org>
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
 <20250902080957.47265-3-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250902080957.47265-3-simon.schippers@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mhokZgvlU6Xtm0pJahjbUkXeTFyY3-z0Ct_8zPm6e-M_1756905057
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2025 at 10:09:55AM +0200, Simon Schippers wrote:
> The netdev queue is stopped in tun_net_xmit after inserting an SKB into
> the ring buffer if the ring buffer became full because of that. If the
> insertion into the ptr_ring fails, the netdev queue is also stopped and
> the SKB is dropped. However, this never happened in my testing. To ensure
> that the ptr_ring change is available to the consumer before the netdev
> queue stop, an smp_wmb() is used.
> 
> Then in tun_ring_recv, the new helper wake_netdev_queue is called in the
> blocking wait queue and after consuming an SKB from the ptr_ring. This
> helper first checks if the netdev queue has stopped. Then with the paired
> smp_rmb() it is known that tun_net_xmit will not produce SKBs anymore.
> With that knowledge, the helper can then wake the netdev queue if there is
> at least a single spare slot in the ptr_ring by calling ptr_ring_spare
> with cnt=1.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>


Oh you just want to know if produce will succeed?
Kind of a version of peek but for producer?

So all this cuteness of looking at the consumer is actually not necessary,
and bad for cache.

You just want this:


Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 551329220e4f..de25fe81dd4e 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -96,6 +96,14 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
 	return ret;
 }
 
+static inline int __ptr_ring_produce_peek(struct ptr_ring *r)
+{
+	if (unlikely(!r->size) || r->queue[r->producer])
+		return -ENOSPC;
+
+	return 0;
+}
+
 /* Note: callers invoking this in a loop must use a compiler barrier,
  * for example cpu_relax(). Callers must hold producer_lock.
  * Callers are responsible for making sure pointer that is being queued
@@ -103,8 +111,10 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
-	if (unlikely(!r->size) || r->queue[r->producer])
-		return -ENOSPC;
+	int r = __ptr_ring_produce_peek(r);
+
+	if (r)
+		return r;
 
 	/* Make sure the pointer we are storing points to a valid data. */
 	/* Pairs with the dependency ordering in __ptr_ring_consume. */



Add some docs, and call this, then wake.  No?

-- 
MST

