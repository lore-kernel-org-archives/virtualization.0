Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D9284880
	for <virtualization@lists.linux.dev>; Sat, 14 Feb 2026 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771112991; cv=none; b=Yml9HsllNTbTLY0dG2Z8rKRy/WvH1PX2MxVjaTSNKgICZySJKzN+HkQTr5hLF1RnhQhivrFxcSkMA1EqaN4DIfbBXLL10N8EdCirgOK3IvpgUag8/scADHpJyE4r9jgZJ4eLOPmloTBVcUkUYnpEQgHtVRSDf7Alg9j05ICoHA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771112991; c=relaxed/simple;
	bh=0teZB9CPEF5sbUbIUadXWlFPJ6ba1v4ykNaYGomwB0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UPTlQibvsxEkmlAfD6Ny1nbctD2E/pevs4KP7B+fJWfo4shhGWE4THMfp6e8daUdbEW5ausbjnwY2D/xRADKjR6onU0NiH9OT5fmbW+VJ6GRRVqfBQbp1gdTQpM6/nHvx2gmjTLH1Uzfw7iamfIQwJM8kEhp+fouTsm1o3eVz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCSwp0pa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCSwp0pa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771112989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oa/MMBMnbn+u985OU8+Ei4K9m3xtsJNKiEfMcHtZPG4=;
	b=UCSwp0pan/TKJosNZiXpVaj96v1p/09BOyWqUSwG58Lf9nVKI+MR864lhl5Ae6a0F/5+J6
	G7CWgt0EfYgjoz2PV8zdzd8w61H3I639H9vysiiEUesh2BS+yEGax1ZXE12moqfyU6it7J
	Edqg9xfKlGwCQSGk5Il9NBwKOWQVli8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-zN10DED1Ng-66AaJMIExOg-1; Sat, 14 Feb 2026 18:49:48 -0500
X-MC-Unique: zN10DED1Ng-66AaJMIExOg-1
X-Mimecast-MFC-AGG-ID: zN10DED1Ng-66AaJMIExOg_1771112987
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837c597cd5so3774135e9.3
        for <virtualization@lists.linux.dev>; Sat, 14 Feb 2026 15:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771112986; x=1771717786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oa/MMBMnbn+u985OU8+Ei4K9m3xtsJNKiEfMcHtZPG4=;
        b=jo4ezAy8MVe1D6HXxsf/mISa5h0Qb0jYNH920zqFFGRY1jKNo9WmGXUkm0Hcqqn+kR
         FjT5Ii2LKeb8e7n9sZyA3CZrOUDLZdZFfzebBgucdD630RfCQHm6cvEv17V8h2cU08eI
         rowcrfNZL/otSu9TP7D67UjUq4Q6lHGgHLosQ7WC9UaOjtzAoVEs0PR3/nsIxjt0QxVB
         VHxe72CBobz1JiCrcL3hx3V7NmCTBSsficNXcwHcnJRv4v5xfrC/4J4kRJ5cO55uK89J
         g9FfagzVQqFfgunyZMYOzY01c/fIlOeC48R95vKBiTWQcGUAWAFeCD7WnTULgoJrv+bG
         iiow==
X-Forwarded-Encrypted: i=1; AJvYcCXi7kVAyIr7V0UKIfV+F18OTfruYqZTaNtUJ6aMrNcuYGTFdJ9iJlbmAPxLPPhqZSW9R0k1TTeA1GTjKkemNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwpHJRIhNDheBz7QM6rpu65Z6vV3JOrLWStUhSHaXvkT7QOmCc
	2374XBWQQlgcEKQl49WbHfe+AzJqXuUx6fBEr+1YWv4IFZ6U+dSK2C/HTl+OGGC7v/XJK8ab0F9
	2Bpf30w4aqsaxWHuc99iTVy+mi3os66MDHw+feJPqbVx+vgi+Lyq2N01fmCnCcvB2UUwkA/4mR5
	kl
X-Gm-Gg: AZuq6aLJysAhLrFD6nI3AntPNlOkgMbFUXhh6r9kw/ILJ5nsvigdcYdGpaPEELOV9Lj
	vMCdkaO5O3RmXhrPJUpp37/6M/FxXIwoVbKzSgDsHHliHg9uldjjdFR/eZkLj9ukzHiSlZHe8xC
	1bXXNV4w989F6PgJMDhkmTLes6vyXlHEaDWe6BwPxorDf3SCQ0vPJiAQrGwXKXQCo8wMruDP21d
	GrVuSSJDkEnKsRTpCv3AHUu1/tysLfXdPUj8qUCtGS+KKXki4lthmDcARIAJSYPYcdxXzuIOqEh
	ENlsSPOaoHyW2ed9nwe96UxetVafk4K+JX1oc9aHm4Z213VgP1GtsCUYxxgbA4P7sx9mqn8puGL
	NQQLCnM6BcL2lUjkJMKmbgIrwavHoCJ7tw0litHSwh6hImw==
X-Received: by 2002:a05:600c:818c:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-48373a5d230mr97085745e9.19.1771112986581;
        Sat, 14 Feb 2026 15:49:46 -0800 (PST)
X-Received: by 2002:a05:600c:818c:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-48373a5d230mr97085445e9.19.1771112986103;
        Sat, 14 Feb 2026 15:49:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6b563sm16099143f8f.12.2026.02.14.15.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 15:49:45 -0800 (PST)
Date: Sat, 14 Feb 2026 18:49:42 -0500
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
Message-ID: <20260214184851-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: 2jLWNHRI7ZfN9eJe8HDBZisuF13bdtSrKbso9mS5pr4_1771112987
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

OK

