Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A655642C51C
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080402; cv=none; b=Z/i2dTfA3dWfP8ebJ8zXqg9tZCX7BzCa9HWxrBB9uoePVbnU+ds7tveQutkLYdXG7SRCcpeULQsNPOrnl4lKtcQzV4fGzVkqHiQr4ros1QTTv0rafAGUj7wFx0ZtjLRXTj53yihzFIlyLA79mNpXBJQFUjnk3BFLkOZ1W048dvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080402; c=relaxed/simple;
	bh=xNKemUhCfIwyBaFE3dn18rH9FQX5gQ/I3YDv1HbBj6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=e3jOkS93ZVG0Gzs5MmbDiltUGfLQMB2JPKLbS/HKyo8986kocsmsKXJQ/iJ0tLcK/zUHV4kJDJUkRsBhV/tZUGXjpyVbOHvpDRiHVKDD7a6l12k8Uh4AZtqeSlLKd5kAbdWmQFKZ6OuYgoz2RV4/cCeQOy3BtxCy2UtAjhPr0WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzyJucyg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzyJucyg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790080398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gp/RspYrZJwOpb3gUhpDI38PyXinoO4/BBI7aDbJ9o0=;
	b=fzyJucygqZn4ysJVgYNRGT/X67qefxq+MuWgtjWbaxIyS/dLFllVWzU4VVj5Z4S0+l35bm
	m/3NR/meIv7ZJ60QpL2pQUz0UlKXzsCF78O7l/HZ4uTrhda/L9tHzPvKm2EOcAR3jv5J3C
	WSzRz2/2lAsTf6+aqYrqvYE6C3QRpRw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-B-VRLqNHODie0ZL8XjU8mA-1; Tue, 22 Sep 2026 08:33:17 -0400
X-MC-Unique: B-VRLqNHODie0ZL8XjU8mA-1
X-Mimecast-MFC-AGG-ID: B-VRLqNHODie0ZL8XjU8mA_1790080396
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so45804665e9.1
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 05:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080396; x=1790685196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gp/RspYrZJwOpb3gUhpDI38PyXinoO4/BBI7aDbJ9o0=;
        b=lO0enGm44v7JkWeIFX61WNtk3KshjuwatHR8nJAJjonWoT4twEGwab8hZbKvaBSASM
         mtemkuVjTPRJ5bNpuTgxuWBzTTHd/ybOMn8EU03nNsMmXm5J5AAIpk27dAlU+4rlbLYT
         lVdSYjRndYbNEpnzzJl6cqh4/xtdcIUJ0yCaQ1oMxg2TwRLCIyW3C0oWAlqTP55xlo/2
         wpLis4ngjyQZ7Fis2x/I5rbKw2cibKJ3/NxQVcDtm/MHgi8hIUCiYTmsVjkq8jGestHC
         eAcTyvbgBETIK0vL3cV59G+9Z2unuVgOUSXH7rs13/R+qXg7hhjfjD5DDN43PoH4QbO0
         pbag==
X-Forwarded-Encrypted: i=1; AKwUvBzvV5uP+cOgegjGhO8YqukbPR16LTpmO7D5Xch/VTTO6DBTCjIyCV3W4KE0oO2cOF3qKkQv6WNDkFapmWw4Ww==@lists.linux.dev
X-Gm-Message-State: AFuF++l6GYPq9fHV+iNTXgIZH3BpcsYtrosysDl6K5jgRthy8prrA+1c
	DSuvPW6tyTibVfENaPLVu3nqkmtAy5Q0mVrfSH58PdN92RX5d0A4wTaUkBlO68r9rdH5BvKT5HX
	9DM7xs6Ob1qlTFP3xdDmRncPLNKduzhEq6nZqEOq4SznQMrknjlMZoxm3mphuGJxSwVsB
X-Gm-Gg: AYBFou2AQGZSn2qj5UxVjnIWSpnNYh8PSNCFcPMQhg5DZeM+zZnMKo8eDwLsSodAhou
	6+UyVUVeK2T/fTXOmgbQt0AZh7D8i26sZgnEYvbf5EunR5//Pow1XP321PT/05KIyKQQFxdtfmR
	PIAHWRiSGtvzhze33VoXTeP5FbNKzj/xulE5PCaA/A3UbQVjTvf9RgvLrZUT7mpgOs3v8GPvU+Y
	MBhC7Hwo9hYPqDx0sGdEXoBXWwzuV5vRwHDqJ3MN8qchCkT6tw/yKTBl/avox4i1hojic0AhrcZ
	FYMGY64K5p0clIn4it0cHi1nogkQVBUqAY87IKxZquAnyBvg6nHPd3PXDvZosbrIzxXyr6JSF0d
	lwzRoqzxfS3EYN2Jbtub/vx836XyhkWm1VuypUHi2m+OsSBslBn4=
X-Received: by 2002:a05:600c:34d0:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49fc5671650mr196407515e9.3.1790080395940;
        Tue, 22 Sep 2026 05:33:15 -0700 (PDT)
X-Received: by 2002:a05:600c:34d0:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49fc5671650mr196407095e9.3.1790080395480;
        Tue, 22 Sep 2026 05:33:15 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488627314d2sm4904907f8f.2.2026.09.22.05.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:33:14 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:33:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: =?utf-8?Q?Bart=C5=82omiej?= Dmitruk <bartlomiej.dmitruk@isec.pl>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsock/hv_sock: don't finish a connection on a socket
 being released
Message-ID: <arJ0NhXGdCOqRjlj@sgarzare-redhat>
References: <20260919123128.28868-1-bartlomiej.dmitruk@isec.pl>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260919123128.28868-1-bartlomiej.dmitruk@isec.pl>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OHgg6egpQsvvPfs5hjYMB_AzXgu_6rM_MF-YzApl4wo_1790080396
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Sep 19, 2026 at 02:31:27PM +0200, Bartłomiej Dmitruk wrote:
>hvs_open_connection() only checks sk->sk_state (TCP_LISTEN for a
>host-initiated connection, TCP_SYN_SENT for a guest-initiated one) before
>proceeding. __vsock_release() sets sk->sk_shutdown = SHUTDOWN_MASK and, for
>a listener, flushes the accept queue, while leaving sk_state unchanged. A
>VMBUS channel offer that races close() therefore still passes the state
>check and either enqueues a child onto the already-flushed accept queue
>(conn_from_host) or completes a connection on a socket being torn down
>(!conn_from_host); the socket and its VMBUS channel then leak.
>
>The virtio transport guards the listener case in
>virtio_transport_recv_listen(); hv_sock has no equivalent. Add a
>sk_shutdown == SHUTDOWN_MASK check to the common path right after
>lock_sock(), so both the host- and guest-initiated paths bail out.
>hv_sock holds lock_sock(sk) across hvs_open_connection(), so the check is
>race-free.
>
>This was found by code inspection; I do not have Hyper-V hardware to test on.
>
>Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
>Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
>---
>v2: move the SHUTDOWN_MASK check to the common checks after lock_sock() so it
>    also covers the guest-initiated (!conn_from_host) path; add Fixes tag
>    (Stefano Garzarella).
>v1: https://lore.kernel.org/netdev/20260917220156.56015-1-bartlomiej.dmitruk@isec.pl/
>

About v1, I see sashiko reporting some pre-existing issues
https://lore.kernel.org/netdev/179003264046.2160803.3176959842906352107@kernel.org/

The critical one seems real, can you check?
Maybe it should be fixed before this change.

Stefano

>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -322,6 +322,15 @@
> 	    (!conn_from_host && sk->sk_state != TCP_SYN_SENT))
> 		goto out;
>
>+	/* __vsock_release() may have already set sk_shutdown = SHUTDOWN_MASK
>+	 * (and, for a listener, flushed the accept queue) while leaving the
>+	 * socket in TCP_LISTEN/TCP_SYN_SENT.  Proceeding would enqueue a child
>+	 * onto a released listener, or complete a connection on a released
>+	 * socket, leaking it and its VMBUS channel.
>+	 */
>+	if (sk->sk_shutdown == SHUTDOWN_MASK)
>+		goto out;
>+
> 	if (conn_from_host) {
> 		if (sk_acceptq_is_full(sk))
> 			goto out;
>

