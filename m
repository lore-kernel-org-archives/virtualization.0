Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D63284884
	for <virtualization@lists.linux.dev>; Sun, 15 Feb 2026 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771151945; cv=none; b=E0fEWEP+yPg+FWv8gDopfEreJLPp7hL5G/tqYUnZuaDtDG9mekAynGCkcoa3JhACc/Tz6vsKl+5vqg1Gy2P1JM3huzrVsYLyb/Ci/2yzqVmCPL5w//V/pfl5ZaTQ5Ctu1Nfs9cQ5eS3N8DddWLGWBKSGfCbTvGRCZkrdXWyTjNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771151945; c=relaxed/simple;
	bh=s0Gz1lbX6oWHaXjniFNDuQXFzRewjGHyGyA3SEPcAvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mHREvW+WMqC5TJSAACrrtwbtMYYqsAi1TjeyunxaFNUfkZGNUEPNArgrJiOQdb3w0b8a8Af6y/3dbwupyWthBQ4devltMoSFDgSnBZCRGuhVldJSybHFpFTxaHejXstqzXLbVUWKVR/avND4irmeIeRPm5WQB7jmaoMP8T801yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFztg3Ui; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFztg3Ui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771151943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OaK+6zMcYsiCWtoK8iSxqAKGi6QUUb+Bn/H6Es8PiBw=;
	b=ZFztg3UiRYdFfJXbeFjUZxd0Qs/UNBZ4HXWrIwC1N+VzUkYEDctO/G90819GpWCEZWMGHe
	ktw+BM1vx2hO2m9dx8ypX85EaZIj4CcPRkKxWOkRk9ZTX0ogo5S3I/dXsSeH7qmaV6kQ9E
	yfUz6tlGAS2P8exkQ4nfVTnrl7pI2uk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-p1sQXOPcOcagaj0Lm2XvqQ-1; Sun, 15 Feb 2026 05:39:01 -0500
X-MC-Unique: p1sQXOPcOcagaj0Lm2XvqQ-1
X-Mimecast-MFC-AGG-ID: p1sQXOPcOcagaj0Lm2XvqQ_1771151940
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4376b624589so2342936f8f.3
        for <virtualization@lists.linux.dev>; Sun, 15 Feb 2026 02:39:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771151940; x=1771756740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaK+6zMcYsiCWtoK8iSxqAKGi6QUUb+Bn/H6Es8PiBw=;
        b=oyGITlQeyEcJFmjpwmbcnG73KVlrDohsrZaw1mY/iyI2if1u2beGpF2h/9Rl7yVOxf
         785ys9iJewn57FiqscpCw1NDhWz/Wa5c/+7Is72XA4rSXMIVMpT7E4wAG4tV5fcxNkpO
         iuxcPSezRzmvxck4bSbF35TmYlhc03a8+LLO0V/zBOXeOtKLpSC8GTuCK7wtuut+79k8
         oH1ibHVPu/GMlxiu7G5nkzaCAtEsu3pA0YulrBtVawU6i2o8xSGqByox3yMo4E2ZZ9O9
         1QWewOOCX6yKYMiQS9r1BxlgjD1d1dOJyVFzi8HNsjJsW6JuG2xYja8q9spR14sfqSFu
         WYBw==
X-Forwarded-Encrypted: i=1; AJvYcCXWBCKQKKswgnHmfdv99BOg0pgIhbuVwMGA6mrVGWHRwJRh+OXSdRVmtnFizFFjps6UQXO8xk+wktDT8p6XqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjX01fIM+mAfZZbuY6BA7t8lwU4V2IEbRRcALm6rPa06efu1ew
	diCaGUBN4YOC2J9qcI354SEpbfUI0YMbbxDLPbhqNoHskYSQgXvv5t10vnXKrUV+30/5D2n7r5/
	PfhHhei5cSv4noj8L7zrgr46Ksdfl+JN4t8xREYiBg1cyZ8c+tAJzXEJOm7FEOyeugxGi
X-Gm-Gg: AZuq6aJlIi/04iQxyk2tU3a4ul8msYxfp8JFJVXwu7wsNzZ1uWwWS0h0CdeInisbHOW
	oWCQr89QTPAMEu/xFgs/WNePsSJEPqownPOHtqKkn33ed7pqHhWG2DvKIh+dorscW1Cng2qFzNZ
	eYPtZ9Tb99dCNpgxmsmtmF3NA6o8/pOnPk8cnKw9x3S4xphNAGjfEeXdx8+tABDzskF4DNN4jKM
	aSJ6ePRe1UXkBIvIdKwXZLKYDUXVV1uAHb1pYt64PGuFgodPbfF+13Z4gg7JQ73C5zpeDANfWQF
	KDfm68Cdrq2bQB16AXPFR3Rl0jZ57X3hqoTnhE8XXce+w40jsDQ9iIMJ8P/1PUNWzFtRNrLKnN9
	eBB2ztMSUxtYLsskYC1Bpw7WNg3+bTZaO/vANycjG1DVznQ==
X-Received: by 2002:a05:6000:26cd:b0:435:a815:dd8d with SMTP id ffacd0b85a97d-43796b04f57mr14262757f8f.55.1771151940324;
        Sun, 15 Feb 2026 02:39:00 -0800 (PST)
X-Received: by 2002:a05:6000:26cd:b0:435:a815:dd8d with SMTP id ffacd0b85a97d-43796b04f57mr14262729f8f.55.1771151939812;
        Sun, 15 Feb 2026 02:38:59 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad112bsm19183634f8f.36.2026.02.15.02.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 02:38:59 -0800 (PST)
Date: Sun, 15 Feb 2026 05:38:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v7 3/9] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
Message-ID: <20260215053411-mutt-send-email-mst@kernel.org>
References: <CACGkMEsJtE3RehWQ8BaDL2HdFPK=iW+ZaEAN1TekAMWwor5tjQ@mail.gmail.com>
 <197573a1-df52-4928-adb9-55a7a4f78839@tu-dortmund.de>
 <CACGkMEveEXky_rTrvRrfi7qix12GG91GfyqnwB6Tu-dnjqAm9A@mail.gmail.com>
 <0c776172-2f02-47fc-babf-2871adca42cb@tu-dortmund.de>
 <CACGkMEte=LwvkxPh-tesJHLVYQV1YZF4is1Yamokhkzaf5GOWw@mail.gmail.com>
 <205aa139-975d-4092-aa04-a2c570ae43a6@tu-dortmund.de>
 <CACGkMEtRikexX=cJz8zmuvW7mcO7uCFdG7AoHQLOezrsb5nbgQ@mail.gmail.com>
 <59529fd2-2a08-4a89-a853-27198b76f842@tu-dortmund.de>
 <20260214131703-mutt-send-email-mst@kernel.org>
 <1ab166aa-8e9c-4742-a80a-c2fa806218db@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1ab166aa-8e9c-4742-a80a-c2fa806218db@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9v34ENuGKooAHawBlU-xadp06mI930Gyq1BhY8wNgbA_1771151940
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 14, 2026 at 08:51:53PM +0100, Simon Schippers wrote:
> On 2/14/26 19:18, Michael S. Tsirkin wrote:
> > On Sat, Feb 14, 2026 at 06:13:14PM +0100, Simon Schippers wrote:
> > 
> > ...
> > 
> >> Patched: Waking on __ptr_ring_produce_created_space() is too early. The
> >>          stop/wake cycle occurs too frequently which slows down
> >>          performance as can be seen for TAP.
> >>
> >> Wake on empty variant: Waking on __ptr_ring_empty() is (slightly) too
> >>                        late. The consumer starves because the producer
> >>                        first has to produce packets again. This slows
> >>                        down performance aswell as can be seen for TAP
> >> 		       and TAP+vhost-net (both down ~30-40Kpps).
> >>
> >> I think something inbetween should be used.
> >> The wake should be done as late as possible to have as few
> >> NET_TX_SOFTIRQs as possible but early enough that there are still
> >> consumable packets remaining to not starve the consumer.
> >>
> >> However, I can not think of a proper way to implement this right now.
> >>
> >> Thanks!
> > 
> > What is the difficulty?
> 
> There is no way to tell how many entries are currently in the ring.
> 
> > 
> > Your patches check __ptr_ring_consume_created_space(..., 1).
> 
> Yes, and this returns if either 0 space or a batch size space was
> created.
> (In the current implementation it would be false or true, but as
> discussed earlier this can be changed.)
> 
> > 
> > How about __ptr_ring_consume_created_space(..., 8) then? 16?
> > 
> 
> This would return how much space the last 8/16 consume operations
> created. But in tap_ring_consume() we only consume a single entry.
> 
> Maybe we could avoid __ptr_ring_consume_created_space with this:
> 1. Wait for the queue to stop with netif_tx_queue_stopped()
> 2. Then count the numbers of consumes we did after the queue stopped
> 3. Wake the queue if count >= threshold with threshold >= ring->batch
> 
> I would say that such a threshold could be something like ring->size/2.


To add to what i wrote, size/2 means:
leave half a ring for consumer, half a ring for producer.

If one of the two is more bursty, we might want a different
balance. Offhand, the kernel is less bursty and userspace is
more bursty.

So it's an interesting question but size/2 is a good start.

