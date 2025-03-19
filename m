Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1F254844
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376893; cv=none; b=F4ebMf6vIIrCzJ4+ofiiPzscSvAtSGbpkHJ/KrSARsacfqxCRO+BOVqhMo6Z9l3vYM9Cd8jtTt8eT3aumlDCHCV2xtARfWqV7RrmMR6llSsYRZYzpNptNrMVQ0DBduw/KUV1f8Xvt29MWS0vU7ASQ41QGnCcQDN5KBXh2BnMcPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376893; c=relaxed/simple;
	bh=C4DIv8oZS+qrJj6Zfs3h2Hvo2lW9ybZoY/34FlHHAto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hLMJdj8AnDQDp7hDgRiEv97my6LqpOkeaH0/+n6xd+33nEt3pqNQMRKFL285BqxFW5/QeTDum4DvVglmU3Q5Cu0XDAZitOYSOEzCZn4daE/EYNRgarr7RAS2K3rIVKqFiB3tfdFPVepciNDfKpiEe9VX4R8MzEnQun8HvqT1ZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=anYAiJ6M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anYAiJ6M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742376890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVNxeHhRg1FvNFhNzTz9ZRh7kCSoT0iwStWzKcnXSNQ=;
	b=anYAiJ6MR0xYaV4x3y+vo3K7SyTpeevCiCjV7O00Xq0oxDnVzQjZX47GIzJ0TZf0ZW+kwZ
	QFj8UlhCTZZro4Gzt62tUpKvs+nki343t2zsxyf3UkGlM6TkpWuVePw/oDRpoc7KIK6egR
	xtC8Xs7PRci4s9zUnnkp/G3n5yU2624=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-qDp-C1mmMkW0lfFRdvq1dw-1; Wed, 19 Mar 2025 05:34:48 -0400
X-MC-Unique: qDp-C1mmMkW0lfFRdvq1dw-1
X-Mimecast-MFC-AGG-ID: qDp-C1mmMkW0lfFRdvq1dw_1742376887
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so23284455e9.2
        for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 02:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742376887; x=1742981687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVNxeHhRg1FvNFhNzTz9ZRh7kCSoT0iwStWzKcnXSNQ=;
        b=FkbtYNjvTesJk52ogY+14cLcOw4mKjha4VsCfbx7iuUI1VqGNqyVoDWN4g/8XyJzuL
         yMgVLI3NgcRpbmPnAvZ8GouW1fwgjUADuyuP+oly+jdugQTocd5QF6KmIgZqGBOOMUds
         iDB7YohSxPbfwWpHcTwclj+7m7RT2RStZWlU9WVMBWQEBvankhyXh0ytGF5bo/6SOWVA
         8Gla6WTg4E/VEppDiv9whELEw4Q44J1zRDI2GdRngGUnYTbFrciW6iWbQFAfOKaKfjnM
         9pM0juptz9ZUMOjH8vUxoL6yeTSkMq4axBToPWq5rrUhT/2DEcw7uFyZ6htff/U8QJU3
         6Gaw==
X-Forwarded-Encrypted: i=1; AJvYcCXuN8aWWe1sYaI52o19Mm1ijOkq2G7YFleSkcaNjZiZk5Ha0oTG+km/utZW7DQZdEQT2fa809aZsY5Anh9urw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSJuWyutbJ3qXQRXnHqgyKgb0zzwb8BwJALLzp55Xf93vksJty
	8b+bxNH5tB3X0XvbP9EjM7pVmEzp5lVXEASO1tZOCniQa3DsqyYgGfbBp0/jfUyQvqUOK2MsLfv
	1JJUZZ+O2ooeeyp2tzE90D09DrJyifKYEgJr+3FjLzk6cqKwAuJMrq0g2xQFHCeI2
X-Gm-Gg: ASbGncumMU5g2G3ot0ih+NqoPzVasCxOZulzfYEdkzyJ3xZmeqTBv47dwhGVFE+4F+A
	a2+w2cLmFLtcwXtqrx7UA9y/0FTATJefIZ8CXeQBLs2ror+CAgFGCUGqHsKUKtCp+7E6NO7Ucta
	PTKxyGgJ+WZqIFXB1CbrbHF9N8AFRIg7nq1MDqoGpoEPElTuKcxGvaX7SrHlljZvtxlR1h8BYoc
	ZY3iLtaGO1Oa3IfHfGKpr7utEOdKhbhi5pqSgaqie2F1WY78pLp+aZ7zl1AyZEpeXlZywHgTDBI
	epGvC3kHz+b8IX7rWVVoTT6vBVxJDWiJCiiLfrPB1Sm+VSkshBXH0pUy4n0TbQ==
X-Received: by 2002:a05:600c:19d2:b0:43c:f050:fee8 with SMTP id 5b1f17b1804b1-43d437e1703mr13281675e9.20.1742376886678;
        Wed, 19 Mar 2025 02:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcyl7sGUVjNx0FRAWM2mYWonSXDfEE6kxjEilOIRFzREegrn0szutRfjLMxh2v3Cw/i/aPIQ==
X-Received: by 2002:a05:600c:19d2:b0:43c:f050:fee8 with SMTP id 5b1f17b1804b1-43d437e1703mr13281295e9.20.1742376886002;
        Wed, 19 Mar 2025 02:34:46 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-53.retail.telecomitalia.it. [79.53.30.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f5719dsm13432985e9.19.2025.03.19.02.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:34:45 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:34:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] vsock/bpf: Fix bpf recvmsg() racing transport
 reassignment
Message-ID: <c7nnbp3j57mnlcglvczyimdqpc2run5vqhtea4eesymv555du4@ekcyin54mcdn>
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
 <20250317-vsock-trans-signal-race-v4-3-fc8837f3f1d4@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250317-vsock-trans-signal-race-v4-3-fc8837f3f1d4@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0t9M25brKOgP_Irdqfy0jGVBlGgQcqcNctQNCrq0EH4_1742376887
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Mar 17, 2025 at 10:52:25AM +0100, Michal Luczaj wrote:
>Signal delivery during connect() may lead to a disconnect of an already
>established socket. That involves removing socket from any sockmap and
>resetting state to SS_UNCONNECTED. While it correctly restores socket's
>proto, a call to vsock_bpf_recvmsg() might have been already under way in
>another thread. If the connect()ing thread reassigns the vsock transport to
>NULL, the recvmsg()ing thread may trigger a WARN_ON_ONCE.
>
>connect
>  / state = SS_CONNECTED /
>                                sock_map_update_elem
>                                vsock_bpf_recvmsg
>                                  psock = sk_psock_get()
>  lock sk
>  if signal_pending
>    unhash
>      sock_map_remove_links
>    state = SS_UNCONNECTED
>  release sk
>
>connect
>  transport = NULL
>                                  lock sk
>                                  WARN_ON_ONCE(!vsk->transport)
>
>Protect recvmsg() from racing against transport reassignment. Enforce the
>sockmap invariant that psock implies transport: lock socket before getting
>psock.
>
>WARNING: CPU: 9 PID: 1222 at net/vmw_vsock/vsock_bpf.c:92 vsock_bpf_recvmsg+0xb55/0xe00
>CPU: 9 UID: 0 PID: 1222 Comm: a.out Not tainted 6.14.0-rc5+
>RIP: 0010:vsock_bpf_recvmsg+0xb55/0xe00
> sock_recvmsg+0x1b2/0x220
> __sys_recvfrom+0x190/0x270
> __x64_sys_recvfrom+0xdc/0x1b0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/vsock_bpf.c | 23 +++++++++++++++--------
> 1 file changed, 15 insertions(+), 8 deletions(-)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index c68fdaf09046b68254dac3ea70ffbe73dfa45cef..5138195d91fb258d4bc09b48e80e13651d62863a 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -73,28 +73,35 @@ static int __vsock_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int
> 	return err;
> }
>
>-static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>-			     size_t len, int flags, int *addr_len)
>+static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>+			     int flags, int *addr_len)

I would avoid this change, especially in a patch with the Fixes tag then 
to be backported.

> {
> 	struct sk_psock *psock;
> 	struct vsock_sock *vsk;
> 	int copied;
>
>+	/* Since signal delivery during connect() may reset the state of socket
>+	 * that's already in a sockmap, take the lock before checking on psock.
>+	 * This serializes a possible transport reassignment, protecting this
>+	 * function from running with NULL transport.
>+	 */
>+	lock_sock(sk);
>+
> 	psock = sk_psock_get(sk);
>-	if (unlikely(!psock))
>+	if (unlikely(!psock)) {
>+		release_sock(sk);
> 		return __vsock_recvmsg(sk, msg, len, flags);
>+	}
>
>-	lock_sock(sk);
> 	vsk = vsock_sk(sk);
>-
> 	if (WARN_ON_ONCE(!vsk->transport)) {
> 		copied = -ENODEV;
> 		goto out;
> 	}
>
> 	if (vsock_has_data(sk, psock) && sk_psock_queue_empty(psock)) {
>-		release_sock(sk);
> 		sk_psock_put(sk, psock);
>+		release_sock(sk);

But here we release it, so can still a reset happen at this point, 
before calling __vsock_connectible_recvmsg().
In there anyway we handle the case where transport is null, so there's 
no problem, right?

The rest LTGM.

Thanks,
Stefano

> 		return __vsock_recvmsg(sk, msg, len, flags);
> 	}
>
>@@ -108,8 +115,8 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 		}
>
> 		if (sk_psock_queue_empty(psock)) {
>-			release_sock(sk);
> 			sk_psock_put(sk, psock);
>+			release_sock(sk);
> 			return __vsock_recvmsg(sk, msg, len, flags);
> 		}
>
>@@ -117,8 +124,8 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 	}
>
> out:
>-	release_sock(sk);
> 	sk_psock_put(sk, psock);
>+	release_sock(sk);
>
> 	return copied;
> }
>
>-- 
>2.48.1
>

