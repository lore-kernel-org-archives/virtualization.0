Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE692153F5
	for <virtualization@lists.linux.dev>; Thu,  9 Jan 2025 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414679; cv=none; b=Ws4ebtpi67C2UrPgZ/EaFm/Jrch2QIaDgBk4cdPny0iTee2hbFkzeWs/M7nV3l3OmSXmcLA1pyGV00WUOv1cYW2GNq64zpBIong29SnOb7shGL8nHLmVXz7wkVmm6mxGTxn7X1GVW6lVX7vsER9RgvoartKaqU+h1EmZ7u0uBRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414679; c=relaxed/simple;
	bh=jlK8j4aB/doijMgWbUxTmxGTZMXqwrbD1dH/0gqbpUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eBL3RLadDrPnUkyA9Q03+Nh9mZUgqBzDaUa9Nym0UiRYSPek8y1AJyVLDS7b9pEdoqooJZgvi2Nt1d3irpQNWDVhgD7i3ECPYyKdL8fODfEAdy87v59hFiMEByqupFOXnbkyl4dvxj6ZY5LGyiAQ43cLSBL/W+d56661IDp7HvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPpnh0xd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPpnh0xd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736414676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uQouyoUVw3UF/y4WVQgr7kFf7syR/XKsLwR+hpvWeXU=;
	b=DPpnh0xdQs/XiE+OQlteE6nPL5uVrY/A+YvnwpL6X09hslvSIryf3moZ5Gd4M4VwqlFcE7
	G5gaGA9R7VrOqqqOP7IWxfVy0bI/e4S/o6bif4M25JjrQ/8oGCB6OgiJQM4jbInAHzXxII
	m047D6CRzV1mfAS+omtDExR7SzIihQo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-SgkvGFsoN4mXuZ4M21cvuw-1; Thu, 09 Jan 2025 04:24:34 -0500
X-MC-Unique: SgkvGFsoN4mXuZ4M21cvuw-1
X-Mimecast-MFC-AGG-ID: SgkvGFsoN4mXuZ4M21cvuw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4362b9c15d8so3435225e9.3
        for <virtualization@lists.linux.dev>; Thu, 09 Jan 2025 01:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736414673; x=1737019473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQouyoUVw3UF/y4WVQgr7kFf7syR/XKsLwR+hpvWeXU=;
        b=Zog6CNtSjqqNLPis5TnLB4TGvPlz7peU2cQVf2bcZsZU2p72Kpbn4R22j+NolLE52u
         PQc6TSiTTJTUCBUcu+/ntCT7GdmeUuKu7q0WTWKF2s72Y+MV5wq3n9O0Rn80qohzc4TV
         k7I7BS0iFLUqu1BoQYhG6rlggpBJcIjLn4wTqP7zSRUxthOqhHo0PcxL+0V08osB5Swb
         xDIL9h9vvBKeIhd035O8pOVT3aI45LlxIFV/gHCkmH1sqhkAOkKlZqiFqOobmaapTE3p
         B2djT+kxSuO6bL73GgONgXhQ9uqVxfRWDcB9XG4dWgQ9OZRAg7cxfKjceVKZUiFc2Mzb
         px4w==
X-Forwarded-Encrypted: i=1; AJvYcCUOifxdakNwqX8B/vbG/Of/n/I4TztCgqeMQa01KqPubP+PO2LgQYMEEqHj+VAV+d0utYc6/sjqbcq/G4B2pA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyp8ZxaO33nggk5djyUFKKY44L1jOQ3N2F401wZlcO4arbfEboe
	nHkGk9Qr6hcQeerxbx5xZ/D26oVUa8Q6Bwfzct8LQNxzmUbqBu+rdhhVA5h82NvqOfluf/QjQSF
	4NcQ76KtHIt+Q7x0Ii4/EScYAp788hjPDVREXrXYxv+Biy/kjkz9VNg9ir+SHTWr3
X-Gm-Gg: ASbGncvF96NUJmpByWTvogzRkkSCePgkm5XHOzYi2fcNRofB80npaAbCz+6aXlt2NKf
	nVKFY6sAIqUFKwwNNFCKWctf+zmjkZPnAH+FbHRu4fu9q059fwLXBx2UeWxq8xkBPbDHMquGF+M
	cEnxACVvEolrquiTW5V/jA/wi3P9xhduOYEJzXsXbX1M/um+TqCTUUDVLGBxzq9c2q4rNFv4tYX
	Rx7/Id+4fAQ1L0ipYR/wtDezlj9YGVKKhwPytiem8VbKCy2aP0842h9yxrk
X-Received: by 2002:a05:600c:8706:b0:434:f0df:9f6 with SMTP id 5b1f17b1804b1-436e2677356mr48292255e9.3.1736414673542;
        Thu, 09 Jan 2025 01:24:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF9yOFWG608kMqPxd4403ULCrAWAOMeA3kgACaIOLpshtLvQXF4xTWy4dUUWcivL4hxRInjA==
X-Received: by 2002:a05:600c:8706:b0:434:f0df:9f6 with SMTP id 5b1f17b1804b1-436e2677356mr48291885e9.3.1736414673125;
        Thu, 09 Jan 2025 01:24:33 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddd013sm49297785e9.24.2025.01.09.01.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 01:24:32 -0800 (PST)
Date: Thu, 9 Jan 2025 10:24:30 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wongi Lee <qwerty@theori.io>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	virtualization@lists.linux.dev, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Hyunwoo Kim <v4bel@theori.io>, Michal Luczaj <mhal@rbox.co>, 
	kvm@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/bpf: return early if transport is not
 assigned
Message-ID: <sho5ird455tiirzbsgjug6owi2leknai4xu45ddnesynb632oz@owq5b56n3f6h>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250108180617.154053-3-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9DPx6AAk7EUSlsQUH3WV5xz07pv9hwrcGQSszILT2vs_1736414673
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jan 08, 2025 at 07:06:17PM +0100, Stefano Garzarella wrote:
>Some of the core functions can only be called if the transport
>has been assigned.
>
>As Michal reported, a socket might have the transport at NULL,
>for example after a failed connect(), causing the following trace:
>
>    BUG: kernel NULL pointer dereference, address: 00000000000000a0
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 12faf8067 P4D 12faf8067 PUD 113670067 PMD 0
>    Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>    CPU: 15 UID: 0 PID: 1198 Comm: a.out Not tainted 6.13.0-rc2+
>    RIP: 0010:vsock_connectible_has_data+0x1f/0x40
>    Call Trace:
>     vsock_bpf_recvmsg+0xca/0x5e0
>     sock_recvmsg+0xb9/0xc0
>     __sys_recvfrom+0xb3/0x130
>     __x64_sys_recvfrom+0x20/0x30
>     do_syscall_64+0x93/0x180
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>So we need to check the `vsk->transport` in vsock_bpf_recvmsg(),
>especially for connected sockets (stream/seqpacket) as we already
>do in __vsock_connectible_recvmsg().
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Reported-by: Michal Luczaj <mhal@rbox.co>
>Closes: https://lore.kernel.org/netdev/5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co/
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/vsock_bpf.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 4aa6e74ec295..f201d9eca1df 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -77,6 +77,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 			     size_t len, int flags, int *addr_len)
> {
> 	struct sk_psock *psock;
>+	struct vsock_sock *vsk;
> 	int copied;
>
> 	psock = sk_psock_get(sk);
>@@ -84,6 +85,13 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 		return __vsock_recvmsg(sk, msg, len, flags);
>
> 	lock_sock(sk);
>+	vsk = vsock_sk(sk);
>+
>+	if (!vsk->transport) {
>+		copied = -ENODEV;
>+		goto out;
>+	}
>+
> 	if (vsock_has_data(sk, psock) && sk_psock_queue_empty(psock)) {
> 		release_sock(sk);
> 		sk_psock_put(sk, psock);
>@@ -108,6 +116,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 		copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
> 	}
>
>+out:
> 	release_sock(sk);
> 	sk_psock_put(sk, psock);
>
>-- 
>2.47.1
>
LGTM!

Reviewed-By: Luigi Leonardi <leonardi@redhat.com>

