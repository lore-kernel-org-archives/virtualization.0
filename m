Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE346449EBB
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570412; cv=none; b=oRDQP4jNuSpGwK38/oR+JVTRDS22kTqK7IjbVAhXHw0we7p7FV+2+sPPM+lDHiM2aFkWkkV3zk+0A2zXcY0NnTn6Fd1f+s31U92j/jLY2W32khcRMxGU15WGLCiPoD35vP5ms9yqPuQpR+YNsBnRG8b7uR98pQoZZ6kOMQTIB3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570412; c=relaxed/simple;
	bh=C9nOtZphHGvpRbbB1mh095pYAR4HXW7ByitF0l7nAq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=b2u7mculKbbVc80N+pUXd/tRr4HbMbh/HUabkw2axSRbRDflOZ3+RCV5l77/GRs4atwSmCeOp7SawkmDA9/vAtWAAaZWBXoi8vjGTBMWzuZgy6p1jFqyNv7xtOQfxF3+JFP1EOL2eloIRCYFJPADTDWy4NwH3LxxmG3OQu2B0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/qLRcRr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/qLRcRr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778570406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjTia8hEEWTMEUzJIZRRaWOPCFQqnc9xnPKI05ARaEw=;
	b=a/qLRcRrpV7bC6S1euMGgPpBYOi/lVZ3WoGPZefAZ5arSzWMlsi/v9pIopdBvpcRqqOsTP
	TazwQYW0Act/DJuN4vxWi4FXbT/tYIXvZHaha03usQakdu6yE0SPyIhAvEiO/yKfOUeNSy
	BeL0j7jroPSe/yLV0hVlv6meuGDacrk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-3Yxe1zOzPbKX3Tj74J8LFg-1; Tue, 12 May 2026 03:20:05 -0400
X-MC-Unique: 3Yxe1zOzPbKX3Tj74J8LFg-1
X-Mimecast-MFC-AGG-ID: 3Yxe1zOzPbKX3Tj74J8LFg_1778570404
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d1b294dfeso46753355e9.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 00:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778570404; x=1779175204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjTia8hEEWTMEUzJIZRRaWOPCFQqnc9xnPKI05ARaEw=;
        b=oL5MSPOZue0kQ/2QmMHu8lRp7diYhljuOMpX+s7pQCyC2YJLQNtfG3s3B4EofV8lJi
         iHsvmwdcmAVk6rNoXHC5Y1Cu/mVeQIx8mOwdFK//zMBWbAj95qrNCJoAARpXRZGxMqFw
         nP2chweF1EmyQGMzE9jEl31AkEz8ap3RET4HBNfKEw6x4TT9i79Ohihi+xD3v3i2fx9/
         wNbCBuZnSnSqyTzHOrMiWm3QOfPXl5MJZsnFr+twp7PvY0qUe1zaustpiT+4ivN/h3e+
         tfqwnM2o3Jd2Bq68jaAFTtscRtGw1QXObayeaiStjaBPBUYXOeb8JEzmSudle179J4oX
         LXmw==
X-Forwarded-Encrypted: i=1; AFNElJ9ys7+c8zhwr/dCUaDDfDGe3i+lq81VKevxhTSyAF+LWBKCDZLcZhqD5dPbLJldB2nSYCOG/Q6/lXTj4i9K1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxklLLokoOyQL6NL8IW+KkVpzjOCItfausxLbK4YX+Sbn+DGg4C
	7jq/4LvuDMKyMjUQiWg0W/qkumSMEUt9tFOZTUODGWM6KM62f1F/+I2ibGylNsAZpWKS2S8S7Nn
	rH6kcGWV59OJW/JNnz7HTmeUbxJmdEfgin6HqV+zzVIIVMK3DNsi5IqLq26k4DpbrEMLi
X-Gm-Gg: Acq92OG5eEkSTCu9VU7JNrzwHLiFgSw/E2gWDhyGCwzrv68vlX25kXqV+/8QIDwtSgh
	pPgN3FTtKkcqe5F2ZrfFmsfJ+GQE6AW5FMicr1teCo9sTt+2/v1XHMrfxHINwOdlXgsHyaFORMs
	dQAJr/dTG/cvIkWrmizIhUjST+E/a+TpKsxMRSRin0XzlJwjWJ75GfmTTphOT9cER9lfcs+35Zr
	UMlg7wVnsd7RxyoGo8xJHmN5eSXsPNVZ48qVxhgmXz9SnV1cLmrd2yvOopIWETEP9kvithR1Vpt
	C9ETwR/3UHggLaphLvt1j5+JPX0yzhUqseHJaadbJFOmE/WDmt3kPDNaYPeg+y9TnkIULC+F+0O
	9rzgylVlacCG8N405l+WkL45RotRKOx8NbE+YjXq3mnym4GwwaoGA2br1rVHKarfgq5+XX6MwDQ
	==
X-Received: by 2002:a05:600c:3ba8:b0:48a:97b6:7420 with SMTP id 5b1f17b1804b1-48e707fbac7mr215489095e9.24.1778570403965;
        Tue, 12 May 2026 00:20:03 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba8:b0:48a:97b6:7420 with SMTP id 5b1f17b1804b1-48e707fbac7mr215488205e9.24.1778570403394;
        Tue, 12 May 2026 00:20:03 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e906ae8b5sm44119615e9.6.2026.05.12.00.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:20:02 -0700 (PDT)
Date: Tue, 12 May 2026 09:19:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <agLR7RkX_3kvL_qw@sgarzare-redhat>
References: <20260508092330.69690-1-sgarzare@redhat.com>
 <20260508055125-mutt-send-email-mst@kernel.org>
 <af2y2Fyp7H-om-ur@sgarzare-redhat>
 <20260508063104-mutt-send-email-mst@kernel.org>
 <af28MAV0LF4qHVmB@sgarzare-redhat>
 <CAGxU2F65pw0P1uKOOJpBc4p6KjCz8iePEh9aPybUyECBm1=otg@mail.gmail.com>
 <20260511084551-mutt-send-email-mst@kernel.org>
 <CAGxU2F6TPfRxZ7SX20vXiqDM4_sY3yUQBUSfEM=Nr+TKXwT9mA@mail.gmail.com>
 <20260511164841.7f7ff557@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260511164841.7f7ff557@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H72zQblACCCUt-EAOJEufh13c-PZte8tB4pvzOVwxo0_1778570404
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, May 11, 2026 at 04:48:41PM -0700, Jakub Kicinski wrote:
>On Mon, 11 May 2026 15:17:56 +0200 Stefano Garzarella wrote:
>> > > Okay, I thought it over over the weekend, and I agree that this patch
>> > > still doesn't solve the problem and would still result in packet loss.
>> > > So, until we resolve the issue permanently, and since 059b7dbd20a6 is
>> > > coming to stable, I'd like to rework this patch so that we only start
>> > > dropping packets when the overhead plus the queued bytes exceeds
>> > > `buf_alloc * 2`.
>> > > Removing the other changes to reduce the buf_alloc advertised, but
>> > > terminating the connection so that both peers are aware that something
>> > > went wrong.
>> > >
>> > > Any objections?
>> > >
>> > > Stefano
>> >
>> > Let's try to first fix it upstream properly please. Discuss backporting
>> > later.
>>
>> Commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
>> queue") is already in Linus tree and will land soon on stable. Which
>> issue do you see on having a patch on top of that to close the
>> connection instead of losing data and breaking our test suite?
>>
>> IMO we need that change in any case, because the previous code also
>> discarded packets without any notification, whereas breaking the
>> connection would be better in that case.
>
>Sorry if I'm speaking out of turn or misunderstanding but, like Michael
>says, let's focus on fixing this the way we want it to be fixed?

IMHO, these are two separate issues (related but still separated):

1. taking overhead into account and setting a limit (which Eric started 
doing in 059b7dbd20a6)

2. reducing overhead by also merging SEQPACKET as Michael proposed (we 
already do this for STREAM).

Even with option 2, the overhead won’t disappear, and we should maintain 
a limit as Eric rightly pointed out, especially since the initial 
problem was a flood of EOMs with 0 or 1 bytes, which option 2 doesn’t 
solve, since the overhead will eventually explode.

So I agree that we should implement 2 as Michael proposed, but I think 
we also need to fix 1 by improving it slightly (as I’ve tried here, and 
would like to do in v2).

Since I have v2 ready and tested, I'll send it because I think we should 
have it in any case, even with option 2 implemented.

>IIUC you are trying to minimize the size of the fix, please don't worry
>about the LoC in the diff at this stage.
>

Okay, I'll try to work on it, but this week is a nightmare. I hope to 
come up with something by building on Michael's idea.

Thanks,
Stefano

