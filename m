Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AFE399017
	for <virtualization@lists.linux.dev>; Sat,  9 May 2026 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366701; cv=none; b=pmOnH8+z4rAJtNv6aJdvC4O6EtJRmgnsvcPLE4+1FTWjn08i41cPhMd3nxJYuVWG0K8ksiNinra/Hic0+9Eo0NwfzqFm9o+4zt53jJg6m3pgD9G0gY8mMgkOx2SorciLbyH0To16KGbG2YtAJlp/Di7lpwsHXjryVfrt53iP5zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366701; c=relaxed/simple;
	bh=I1uaCfP7MUFzA0C5hMsAjutKxQqou3ouWa1Ws0Uyyh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JIDjcesrcPdATr8Q5Ed9SDwCrLfedA1nMGngabtkiH1GQXUhKM1PY4E2OVOOf7godzLhFEPGnFbMOa2CcmRBmJjDv7kee+Rjpe/w+XDWOz2Xm6iWrVxv0i4+Q05TKVBpUfogD1eX8CGha3v3WeHsj4DNGg7bJ4Vjq1gKFUGHQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icDk8l7h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icDk8l7h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778366698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RMLC0/7OpZlfwin12rT49rU9O67TrMCpNs0CyOiqETU=;
	b=icDk8l7h68RejWheeD+g0aFYJIrCKMwIiNdTqPW1b2mTWwwTiq8xLLmilDf0g3aqdf4W3m
	qF7M2S7WmboAxUh6FqW89t9HyqWDIg6o0GXS9W/f1rFWhMSCuFed5DAKMsMTNFZ+g4wCmG
	cYPeaflLnpAbfV+qKlo8ihmE9UbZ3jU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-p-aekxHLMWOMc0Va3SbkqA-1; Sat, 09 May 2026 18:44:57 -0400
X-MC-Unique: p-aekxHLMWOMc0Va3SbkqA-1
X-Mimecast-MFC-AGG-ID: p-aekxHLMWOMc0Va3SbkqA_1778366696
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a589c7879so32149285e9.1
        for <virtualization@lists.linux.dev>; Sat, 09 May 2026 15:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778366696; x=1778971496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMLC0/7OpZlfwin12rT49rU9O67TrMCpNs0CyOiqETU=;
        b=As3T/V0A87nXG1SDt+mHnTF/h44Jo2bmgacFDhIabOKVkGRxWYZZ61spnEfTNJG7xh
         gjHUEjv6RHWXbqtVbhSgefIhzINjzzXTEqUwW5Ov5F0cqC09tmDfHBL0wdWt+J+c7MK2
         awNe6ZmLp8DpzKd6KXpJlKErzzE253Ov1uc4MttAcqtTFGmoiyLvgqNLzBNTO02e44Zm
         zWoJk/SM8o4zsJPJ5Rpa9WbGLSELMnbZFfsAcr29B0E0TPMvG3BhuEp6DUdP3FgE9iip
         3Uiu5HuS0KvB2zPuV86bQXgBQWk/44qgYGy92JQ+n1+LWmQuyrVYR81SsvbaBnPPkxcc
         YrzA==
X-Forwarded-Encrypted: i=1; AFNElJ/bPkw87r3c9SuoVOqnc07gyEr4YpDBKj3d33/YFRNI5o4KXEn8O784J5hmSzfldp9KlA8FGn5pI/l8rECtGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDRyF7tYvy1CQQvcMamRM0kxm9+QNlJ5zLgKJw3EB2lQ5XEznE
	BZBO17UTRQaah6BFWRSXVvhVdd0KPUxnHOgsehyTtFpMjFcE5WVT5AUHFmXSd6cebyoV39s83jc
	sVryzA/M9PlhbR3t/Ts4VYBNQN2CWKDpPCmRXMv0FnxQSb41BpJ/xqbkYyL/7Dv962zHM
X-Gm-Gg: Acq92OEph8/Vv0iVNirW6rQcrhv8lzctoY1egDxdX9PWHZr0U9JxwFoQr/zqjW6ZkU3
	8KSPrnv3LmGC33Mj62DYJRAIIRePbCbZp6tzTaYvbENQeOf1nZgMFyBqlZZlCXdqYWQ9xsMwgGD
	tE51Rx0cuhHs9/Ub6UkSx02P6lZZCclqRRwwBblW0sVNAH+PttH1LQ4e5Sf9nt23Pe0jPlGXA4t
	SJu9Nd6x6lZM/AZLhT+tlZ4hHmBmCrXJggEVw3oelz/iB6JdF2ZnwEnpa2xELl7bOsZ3fzLuS6g
	dydai+1fpq/3qCkj/NU3+oeNzkgc7EL5se/yI/hmRN8y9zcOSvWekEh+JVG+cZ8wqKLHHS++/tB
	OLbXH7X/8qUoX1ubRL85qxfK3vepDbYvi2vmpQWrd
X-Received: by 2002:a05:600c:3b8f:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48e642deefamr148087295e9.7.1778366695916;
        Sat, 09 May 2026 15:44:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8f:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48e642deefamr148086915e9.7.1778366695323;
        Sat, 09 May 2026 15:44:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dafa6c2sm42673165e9.5.2026.05.09.15.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 15:44:54 -0700 (PDT)
Date: Sat, 9 May 2026 18:44:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v11 1/4] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
Message-ID: <20260509183518-mutt-send-email-mst@kernel.org>
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
 <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xJh56QjSMWCAk4o2RD2K-t4VifA4KrqQIMrWkl1W2p4_1778366696
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 09, 2026 at 06:31:47PM +0200, Simon Schippers wrote:
> On 5/8/26 17:10, Simon Schippers wrote:
> > +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
> >  {
> >  	void *ptr;
> >  
> > -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
> > +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
> >  		tun_ptr_free(ptr);
> >  
> >  	skb_queue_purge(&tfile->sk.sk_write_queue);
> 
> Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
> operates on a tfile that is being torn down. Its queue_index is no
> longer valid. After the swap in __tun_detach(), it points to the
> netdev subqueue of a different tfile.
> --> We should not wake there.

Does it not exactly point at ntfile which is what we want to wake?


> I will swap tun_ring_consume() with ptr_ring_consume() again and
> submit a v12 :)

If so then maybe
netif_tx_wake_queue(netdev_get_tx_queue(tun->dev, index));



-- 
MST

