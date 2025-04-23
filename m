Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8BD17B421
	for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426089; cv=none; b=i80WVC2kKA2qazv7qGfyribBEB/+D7noXpIZ+x8EGsaWRqbkvsgpg2JyPFoMHp3Yr6i5eYwXHs17Xg3K1HYrRAvyNjgCGcludrzi4iVUPHLtKBshGHzylsMOZk999wcxGmHnvL8Xh1Hm/9VVHbK51Tyg7O4i3rq6idh17aZSqT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426089; c=relaxed/simple;
	bh=bXXIovlNwDDSL/qXa0t+pqlwF7YhlNYF0hxtdu3MOBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ff3bOLuNYhf00nleNxBy8EE5C/J76E8Kampgl+vikRxeQAcvVppvXXemEgnyzxQrlJfUpWFVb0EwVfbvZ2hzL5KpfhBiYmWuJRZW0bESzTsY7s4tAofJ2TZhMzLeh487aGpsWQvB65Kfh4q4LxSXNcN8ik7URFAtYWxTt0TCBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RA495emX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RA495emX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745426084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hX0ZWPxzqOkirz1sKOlbutSepxCMmH8RyV6IiHrCUKw=;
	b=RA495emXiGhUHl1NCYXAX9QkJwLCIuyJwrOakGrJrH/o8FzPvqT2+4CcxJDIKXdwac+zIJ
	S3mQPDj2JaNHCQZgP7HY4PdjzCKWzggA93VJ08Ngz0XSazRN7dpIVukTMifc4v9hk0nz2y
	+hrhExEx7W1VYmZ+ln6r8rXCdDvyziU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-SJZ8yxtoNuK_W8YttsmmIw-1; Wed, 23 Apr 2025 12:34:33 -0400
X-MC-Unique: SJZ8yxtoNuK_W8YttsmmIw-1
X-Mimecast-MFC-AGG-ID: SJZ8yxtoNuK_W8YttsmmIw_1745426070
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5c77aff78so6034385a.0
        for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 09:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745426070; x=1746030870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hX0ZWPxzqOkirz1sKOlbutSepxCMmH8RyV6IiHrCUKw=;
        b=TZsBOC2s5p5oVxkU/1DDw8O4MLWeajXF3S2UM9XW3ovidCgzB2C71UTz0/nMq8Rt3z
         64o/N34H/Nu9jdTs+9zQ2yvw+5lUaQODAtLzJ2w9R9bfieFCqyvGlX5fXnVrwTteedGq
         pQeADq4yVIBG2zdbyppknZgcgNTn3i90V1h0gMjsK4QhAgWZ6LUZuPkmInTW3lxMjoCg
         lg+OMjaSU+gnH/RE7pAjigvA2VGBWhn/3cC+6BYzqiQBcQUg4iI/as8ZKMi44Y0J40si
         2+5gmw5ZfjRi7hYIvtAfMc5v6HNmgLEeMyrqtQsL4QYt+p/OUsuM9THu/kIM6Ldu2tE4
         ffaw==
X-Forwarded-Encrypted: i=1; AJvYcCU17rF6n9YUcip2ebO768aIuoGZgxpPgJAjZ5PKxAN9c25hMtUvk+nO6rfuBomx6zbewDX1zsnwwDxfaIpXyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxM5rtxRY3H4mu4Thtw5N+VGVNnWogSaTteHYF2hkVAmagqiwDw
	54XWPu2eVuzgKfSknkY8n2X67hAAG+LwKjhqZbreNHm4sQTHnxcjowNEmwIwvrD+K5SiTIqkkXk
	40BPMLMuhaCBXXZ3QzdjzIdmXW31FFqUtu+pW4h28X6GaYpN48a0Hy0iyJyf3nOvh
X-Gm-Gg: ASbGnctdF/v2A77zuT2WnBtGKOCOiIVWJlbiVU3XT+hp2gvPIIGbbIE7H1yJot+rCX2
	g+fgvFNMShl/ul6Ht1OAWMUFcxiY+hM11icsQgPaIdUnFCxP3nJurtjhj091oEDVZ0Yunvw6JSU
	6Sr+NtbV6pOl21qqbFVKSwiQ+Vnou6cuA5jAB0n19YU+hDS71iSeATNNOVSBoj4q3QdvyOnYkU6
	hJHCUydk5SyN4V+VsGTSUvNW8KBJtyk8jdTFkEBec0aZF+ZIXQH7WJ+hFJf2RDE7j2YfC3Qgiqm
	SxUkg76p1/Y22zIu5Q==
X-Received: by 2002:a05:620a:28d0:b0:7c5:6df2:b7a5 with SMTP id af79cd13be357-7c927fa2b71mr3166544085a.29.1745426070345;
        Wed, 23 Apr 2025 09:34:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/i+wfr+aLg9YJcmFsbtb0FZaYC+Ua4737Sifb8T35B0q4/iqB5jGvO/7HQVtCV2sdLcI6OQ==
X-Received: by 2002:a05:620a:28d0:b0:7c5:6df2:b7a5 with SMTP id af79cd13be357-7c927fa2b71mr3166538685a.29.1745426069796;
        Wed, 23 Apr 2025 09:34:29 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.206.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b69579sm700021485a.91.2025.04.23.09.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:34:29 -0700 (PDT)
Date: Wed, 23 Apr 2025 18:34:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] vsock: Linger on unsent data
Message-ID: <k47d2h7dwn26eti2p6nv2fupuybabvbexwinvxv7jnfbn6o3ep@cqtbaqlqyfrq>
References: <20250421-vsock-linger-v2-0-fe9febd64668@rbox.co>
 <20250421-vsock-linger-v2-1-fe9febd64668@rbox.co>
 <km2nad6hkdi3ngtho2xexyhhosh4aq37scir2hgxkcfiwes2wd@5dyliiq7cpuh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <km2nad6hkdi3ngtho2xexyhhosh4aq37scir2hgxkcfiwes2wd@5dyliiq7cpuh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d0Usj-j19N07AOX3qOeoYzfSHIcILxS79wAYtPek60E_1745426070
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Apr 23, 2025 at 05:53:12PM +0200, Luigi Leonardi wrote:
>Hi Michal,
>
>On Mon, Apr 21, 2025 at 11:50:41PM +0200, Michal Luczaj wrote:
>>Currently vsock's lingering effectively boils down to waiting (or timing
>>out) until packets are consumed or dropped by the peer; be it by receiving
>>the data, closing or shutting down the connection.
>>
>>To align with the semantics described in the SO_LINGER section of man
>>socket(7) and to mimic AF_INET's behaviour more closely, change the logic
>>of a lingering close(): instead of waiting for all data to be handled,
>>block until data is considered sent from the vsock's transport point of
>>view. That is until worker picks the packets for processing and decrements
>>virtio_vsock_sock::bytes_unsent down to 0.
>>
>>Note that such lingering is limited to transports that actually implement
>>vsock_transport::unsent_bytes() callback. This excludes Hyper-V and VMCI,
>>under which no lingering would be observed.
>>
>>The implementation does not adhere strictly to man page's interpretation of
>>SO_LINGER: shutdown() will not trigger the lingering. This follows AF_INET.
>>
>>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>---
>>net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
>>1 file changed, 11 insertions(+), 2 deletions(-)
>>
>>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>index 7f7de6d8809655fe522749fbbc9025df71f071bd..aeb7f3794f7cfc251dde878cb44fdcc54814c89c 100644
>>--- a/net/vmw_vsock/virtio_transport_common.c
>>+++ b/net/vmw_vsock/virtio_transport_common.c
>>@@ -1196,12 +1196,21 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
>>{
>>	if (timeout) {
>>		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>>+		ssize_t (*unsent)(struct vsock_sock *vsk);
>>+		struct vsock_sock *vsk = vsock_sk(sk);
>>+
>>+		/* Some transports (Hyper-V, VMCI) do not implement
>>+		 * unsent_bytes. For those, no lingering on close().
>>+		 */
>>+		unsent = vsk->transport->unsent_bytes;
>>+		if (!unsent)
>>+			return;
>
>IIUC if `unsent_bytes` is not implemented, virtio_transport_wait_close 
>basically does nothing. My concern is that we are breaking the 
>userspace due to a change in the behavior: Before this patch, with a 
>vmci/hyper-v transport, this function would wait for SOCK_DONE to be 
>set, but not anymore.

Wait, we are in virtio_transport_common.c, why we are talking about 
Hyper-V and VMCI?

I asked to check `vsk->transport->unsent_bytes` in the v1, because this 
code was part of af_vsock.c, but now we are back to virtio code, so I'm 
confused...

Stefano

>
>>
>>		add_wait_queue(sk_sleep(sk), &wait);
>>
>>		do {
>>-			if (sk_wait_event(sk, &timeout,
>>-					  sock_flag(sk, SOCK_DONE), &wait))
>>+			if (sk_wait_event(sk, &timeout, unsent(vsk) == 0,
>>+					  &wait))
>>				break;
>>		} while (!signal_pending(current) && timeout);
>>
>>
>>-- 2.49.0
>>
>
>Thanks,
>Luigi
>

