Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575787;
	b=NLVzwGKnkCHo6Q8jK30RbwkLK8hQwhBqpV26aXKJmByOcgJxdSrBqg5qE63gXHs8e5h7
	 tHMfOrEa4Lfu6/LaSJWlQUUjYkJMqJ21M861fCtq7HZZRaz7adGhl2uLSLF48e1zrBWjs
	 NLIN2Hw89jVrkoTO/O21/my7T1O1cOONqUwV6Ca+UOvKc3eYCqfJOU6Fxuh1ZeciRvWoh
	 TSq9qa3E6jnC2uk3UtqxZR5L9wGPH/kJxFf76y8QUjDJ+7tpJwC47fiATzeU142Bxsr8P
	 COmh1tSDuBj47qecZtN4iVRldT4M1bm+pBYdVzgD7THxEGZ2SIsGrCBZaVg8FGQX5/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575787;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=/6wg+cGh6J9MYyjTA2bTtWBGWLVofTB+kJ98QIYQnjQ=;
	b=3RabNJCy2LXLs0XGFMD/88vMD372SPS4mp4XGGughotQwoV8FPUYbl9o5wsFjfP+LB3u
	 j76xzWsS6tW9YxQxKA7ybrad4qMwNSlouO6uZAqasxR+cs9YGH9Dhn80q3dOb8RBDGP7W
	 F08PNRPhLIu2P0N3XoylVKied/BzUV8KjNaV/UngfkwCNV/GRbJpIm5sCKPTg7BjPxw2s
	 zH6LG7mB7xqX/tF4HajXTvpix22tODoJhXRCl81k+V3BqCXFrcDFk/FFoJVoM353OSEGl
	 e7RHwD5sXhwDdLHwjoK6OT8G5zbx3uC8j3jWaQMZg2vRb297VmryQ4Jdiwc3x+UcjFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="B3ZX+/X7";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E80606A31A
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 09:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32E80606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B3ZX+/X7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792575786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6wg+cGh6J9MYyjTA2bTtWBGWLVofTB+kJ98QIYQnjQ=;
	b=B3ZX+/X7j8MjrDLCA/QlSGkWKA7Mrsg449QIrswWZ3JtjKChCSSUrvxsTTIAGhf1Tefxog
	n9jwRonwQwhOz/ARUZrlfZ9pMykU6wAdZ3KVBHPlXwS2w3IJFOVC1uY5WAHN9lobGLfSxr
	i8vivZKfTXmeHRr9tOJY7c3SPkrJZ5A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-QSadv1q9OVuFLFFEvSPkmg-1; Wed, 21 Oct 2026 09:43:04 +0000
X-MC-Unique: QSadv1q9OVuFLFFEvSPkmg-1
X-Mimecast-MFC-AGG-ID: QSadv1q9OVuFLFFEvSPkmg_1792575784
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a028616bebso3649095e9.1
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 02:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792575784; x=1793180584;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6wg+cGh6J9MYyjTA2bTtWBGWLVofTB+kJ98QIYQnjQ=;
        b=B8W0gTbiLsE54oNUWY0JEM2eMlxtQe1+ZkqQCNu5pCh0yg/1tT4GvrxXQg/vGEjG0B
         I4tU1ObfbhN0U4GS4vys2J0zPFG9aPBfwj5g03STrdDy3IrVGR2q634FncYHWMcMLoN2
         V//WvMvy5gjjqJL7ij91B8NWE0JUGX/epmS6uDZ5czFY/iBJiCF+BGXM1lY12UILE8sh
         VFDg3PN72nq/eSXn+rvMiKyb56DKnCicZ1S07kabCD8dztrlfGFFp0K9+plm/Ii+00lU
         D4Q+x01OIEX4c1cyP9AR6A/dZ8IDturdeW5AjmEuP/4h2Pw0JZ4tg/V4tZkGLbuHDRWv
         uDBg==
X-Forwarded-Encrypted: i=1; AKwUvBwX9Kd9BroF3T1wBh3/H/4dvfwhCTVmB/wLiGYWFun+jNbOvI+8KRFYEXDqHzfSWtoCOEAwe1ORj1r3KnDayA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLL0hile/O8UP/sjSTR4OHpN5EprdcEkOUVw7lRQj/1FovmarET
	06EixuVOJG32dOh3jR+zCj9YEeM1QJsSlKdP+kPFdFxJbRIiTH16/pVqg4t+5RjYSah2y1Kl5+P
	N0aPGon4wcP/kpGoMmUmxdVRfkZOjNCttK4XnGic7srTmZRvrP7X0LGtobDEDYu8HgCEv
X-Gm-Gg: AYBFou3sOp5DZCXMSOZx2dPbfANWxYEKU+cEcuUxPh0JELn43WUfzYnhL7NzKGWlZ5I
	tjCpgfTmfAeYwlxOvW+HCZpPjstebPl7c5PBRwjhEN7X0NFnUYtEtULZ+gXsHbAHcqSaTHV+Cis
	Ryw+Uac13U5NCOJoMCI9exb19aqEJHA7D1M6TJ0hXYflyQVhJ5Rs+hUegqJmC+DAZDtFJFl9n1s
	5O1FsSnah4voyUu8Kk/n/+n+ufhArKhKzkkHO1+FlhjL3RoQkdZep+6HYbqHuiN4DnV+dbW4Smh
	Op780YNppO2j6KL3Sry4Qkv/K7lsh/bu2lK5v6GzHjnlHKEqU9D+rmm2hT7K5fkGxJLWQmXoHRF
	OKmzInQ==
X-Received: by 2002:a05:600d:864d:10b0:49f:e941:d6e with SMTP id 5b1f17b1804b1-4a1fdd399dbmr19403505e9.21.1792575783753;
        Wed, 21 Oct 2026 02:43:03 -0700 (PDT)
X-Received: by 2002:a05:600d:864d:10b0:49f:e941:d6e with SMTP id 5b1f17b1804b1-4a1fdd399dbmr19402975e9.21.1792575782925;
        Wed, 21 Oct 2026 02:43:02 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.178.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258427cesm4305321f8f.52.2026.10.21.02.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:43:01 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:42:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bobbyeshleman@gmail.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] vsock: support SO_INQ on stream sockets
Message-ID: <atiJD80fftOEaKp-@sgarzare-redhat>
References: <20261016132716.272018-1-devnexen@gmail.com>
 <20261016132716.272018-3-devnexen@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261016132716.272018-3-devnexen@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LOgxdGaU7tEFXxrDv2ZYP2argagZkAcieJxdKrfmrD0_1792575784
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Oct 16, 2026 at 02:27:15PM +0100, David Carlier wrote:
>SO_INQ makes recvmsg() return the bytes left in the receive queue in an
>SCM_INQ cmsg, saving a SIOCINQ call per receive. AF_UNIX stream sockets
>support it, AF_VSOCK fails with ENOPROTOOPT.
>
>Add it for SOCK_STREAM, reusing the hint already computed for io_uring.
>As with TCP_INQ, 1 is reported once the stream is finished so the caller
>reads again and sees EOF, and accepted sockets inherit the setting from
>the listener. No cmsg is sent when the transport cannot report the queue
>length.
>
>SOCK_SEQPACKET is refused, as on AF_UNIX: its transport callback counts
>messages, not bytes.
>
>Signed-off-by: David Carlier <devnexen@gmail.com>
>---
> include/net/af_vsock.h   |  1 +
> net/vmw_vsock/af_vsock.c | 35 ++++++++++++++++++++++++++++++++---
> 2 files changed, 33 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

