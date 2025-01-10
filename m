Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06D20C019
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508322; cv=none; b=BcDB3tJB8mFLPCOQVqFbzKnGXEoGcQV22EH6ytPkMzDFyd5mcvAJRTNOwJ8ieTSlC0UnbeQREa4HhFIKsg8rbrIYgzjYcL89NjHJwNVBSwflQQaWEqC2wG68x59XY3HyCTNEsGeyngL3JyHlG2/6snvEdzqxb3tkry/uBllDkJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508322; c=relaxed/simple;
	bh=h+3V8Dg/wI18YbTuYBPBYgVfFTOtZGjB+ocTQMzeqlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F1jSTel/6RL//urKFgofksUa5eLdZrMHS8mWgyRlLNo5qp0ZNPNaZXmgvAKPICFdHeVs3ORvISr2ueHzU87G+3toMNWWAM1SAFQLzEyW8rIqMypZ5W+3uTR/Jni3Hz2N9+f5lk7GpgSjCfghux4vZWNquRQf3OyBHLwVQ46Y4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NffOMgCO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NffOMgCO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736508320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ef2wLHVQGV1IsoMPeKXi5uZyvCqMew4uoHW3wntJAQ=;
	b=NffOMgCOAshceS8GokIk/LdN4Ak1N4IygtCeQDEfNXR8+qKbwrYfvNzrEemycOXSzZtf4J
	WPYi6KlkBD7E0RkDHPFWPNxqB3F4sB15gN/cNtYqJcJrCRJ9sH3+u1FMEkWapm4byuEMJ2
	MBkzEPmS1ydFf6nQRMXtldRz+RowVy8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-qcT3XR_INOuhIQoJya7GTA-1; Fri, 10 Jan 2025 06:25:18 -0500
X-MC-Unique: qcT3XR_INOuhIQoJya7GTA-1
X-Mimecast-MFC-AGG-ID: qcT3XR_INOuhIQoJya7GTA
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa680e17f6dso145554166b.1
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 03:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736508318; x=1737113118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ef2wLHVQGV1IsoMPeKXi5uZyvCqMew4uoHW3wntJAQ=;
        b=pqvQG2M/+XFNVSRceXKvD86QE389oIadyB/7txME8YadH8xb+P+pGtXyV/8XVvch1J
         yUfdFhicecp4wzGqizeBE4m2PUlvsvuMDRq2rDIIEq91xn6+wJzr9pRN447shMAPXxjC
         QChR9gUH3oC1q6sYp58fskYh+dwI8dQsx65hJb6/5H0XAXJYyJNKPdA3L08FZjAWqLTS
         lcn7dsH01KQ044eOGgjEYUD2gY16X9L+msRlQVwhFTkTeM2nJxILIYlAfixd14ucbztP
         1yvuaBLaFRr3Xyk/Bty+jZvt2N8vhELUEov9DW/RRg6QPqjEyxERAKZ37+4SMgv3+usL
         D8pw==
X-Forwarded-Encrypted: i=1; AJvYcCWwFcolCx5qzpFjgi+SGOQWpJQ5IYUQmRsJ4YTd00FmGq6QZldA9wMAoNX2YFlMmmxGPkDz6GriuRvlz4pJtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwD31lS6lSQ50+hzqMFTLDhD4SMz6+/myhm9QVepUw+0bEKdn9x
	c8FCpvqarVteP1AkDZZ3Dz8Okfp/bVTQc1hP6vW8I6noI9hVFTluWaNwhspWq+P1hPPMZlNYkZg
	99+A6Bte+76HwHnQX+BHwstAjUO3uV/n+2JhHgK1Sr9MLQTyjo8GnNUs14YtCui1z
X-Gm-Gg: ASbGncvR1su8M3ti0+jLrj6yrbf9skTVOtA/mRSsgt4Uv35D40vMeRAdyvYh6CpT+PY
	Ww6RWw9PyvdFxf0Pn0BRw0Te/wgpOhyPUKVU7xa/zyHgbgDnEk1bYJ50Tsk+LqhtAS28InTdzNj
	8DCN22dsxL0yjF6LGaCZkuOpocxZvBVE+BeW79gIZvzUAI7ok+Z6W+8iJzn35eeGax+7XEzeU0P
	0GwqNfbl2fMVOtbvI/rUtVu3FzGjFu6aIlcZYKyeGcYqmKz6JiHPvCFqe20xnI=
X-Received: by 2002:a05:6402:5194:b0:5d0:fb56:3f with SMTP id 4fb4d7f45d1cf-5d972e0e341mr23290979a12.12.1736508317703;
        Fri, 10 Jan 2025 03:25:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3mqsKI2idLOS3bFseUHtOVmXbXG31Er639vFwFDT2akA/HfPxaQl8uNFpTeEdJZcPXxQTRg==
X-Received: by 2002:a05:6402:5194:b0:5d0:fb56:3f with SMTP id 4fb4d7f45d1cf-5d972e0e341mr23290897a12.12.1736508317029;
        Fri, 10 Jan 2025 03:25:17 -0800 (PST)
Received: from sgarzare-redhat ([193.207.202.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95af694sm159293266b.144.2025.01.10.03.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 03:25:16 -0800 (PST)
Date: Fri, 10 Jan 2025 12:25:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Wongi Lee <qwerty@theori.io>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, Jakub Kicinski <kuba@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 4/5] vsock: reset socket state when de-assigning
 the transport
Message-ID: <fjx4nkajq3cnaxdbvs3dd2sxtc35tkqlqti3h44t3xuefclwar@havkg6jfisxu>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-5-sgarzare@redhat.com>
 <esoasx64en34ixiylalt2hldqi5duvvzrpt65xq7nioro7gbbb@rhp6lth5grj4>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <esoasx64en34ixiylalt2hldqi5duvvzrpt65xq7nioro7gbbb@rhp6lth5grj4>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OYMt_gOYEiYA2q1IjYlB9Jys51l4GO179DP-9F1H2Hk_1736508318
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jan 10, 2025 at 11:56:28AM +0100, Luigi Leonardi wrote:
>On Fri, Jan 10, 2025 at 09:35:10AM +0100, Stefano Garzarella wrote:
>>Transport's release() and destruct() are called when de-assigning the
>>vsock transport. These callbacks can touch some socket state like
>>sock flags, sk_state, and peer_shutdown.
>>
>>Since we are reassigning the socket to a new transport during
>>vsock_connect(), let's reset these fields to have a clean state with
>>the new transport.
>>
>>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>Cc: stable@vger.kernel.org
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>net/vmw_vsock/af_vsock.c | 9 +++++++++
>>1 file changed, 9 insertions(+)
>>
>>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>index 5cf8109f672a..74d35a871644 100644
>>--- a/net/vmw_vsock/af_vsock.c
>>+++ b/net/vmw_vsock/af_vsock.c
>>@@ -491,6 +491,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>		 */
>>		vsk->transport->release(vsk);
>>		vsock_deassign_transport(vsk);
>>+
>>+		/* transport's release() and destruct() can touch some socket
>>+		 * state, since we are reassigning the socket to a new transport
>>+		 * during vsock_connect(), let's reset these fields to have a
>>+		 * clean state.
>>+		 */
>>+		sock_reset_flag(sk, SOCK_DONE);
>>+		sk->sk_state = TCP_CLOSE;
>>+		vsk->peer_shutdown = 0;
>>	}
>>
>>	/* We increase the module refcnt to prevent the transport unloading
>>-- 
>>2.47.1
>>
>
>Hi Stefano,
>I spent some time investigating what would happen if the scheduled work
>ran before `virtio_transport_cancel_close_work`. IIUC that should do 
>no harm and all the fields are reset correctly.

Yep, after transport->destruct() call, the delayed work should have 
already finished or canceled.

>
>Thank you,
>Luigi
>
>Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
>

Thanks for the review,
Stefano

