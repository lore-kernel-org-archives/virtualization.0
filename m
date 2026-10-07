Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789045D90B;
	Wed,  7 Oct 2026 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365144; cv=none; b=XnG95yszCXeOOiH+OJMVGD4pmLzgKByWltJ4S7F7vwEXutiLAAWi+BWUAtwkTgd8FMNqdKIi/NkFoRpCyp12qE3GEFeXeJA5ofE0AvBHB8EuaiOOEIH2qzQ77tdfdk8JuTAO4Qbi7il5D4UUxf88gLSzGacJD/re2HVHN/uZdec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365144; c=relaxed/simple;
	bh=X1iQiZAoBlGzZUp8UHo6VqQTPEenXfO56TjfxrcDB+w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Uaz7w5W6FcYpHDaaVXt18wrrriXgVE7EyPEqVXbtqnEyzz4h0wRKagSRhEbkwf32NN6ndX/9jNhUtUzkits8fqhJ+/PxA4GilsTilO5G7iD2AgGndm1kCFUFyeC0NdQg1s47tQZh2Pl2QKPUpIO6KzVHGg3gFkIEHwzJrUoeeQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ghiKbUID; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ghiKbUID"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xENtW-000pSp-GI; Wed, 07 Oct 2026 11:25:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=XVG330B7pnghrp1aXOfIvxamKNeiNYv7XmyKw+Y1T/o=; b=ghiKbUIDhVEpwH9HlKToSn+s7v
	bQ+RslnEJbUiBRNk30S3ItncCWxSiWk7Ne5qrw0RWdHbMRB8u0NB5RfWA2QLVRWnCgGej89EjKvZa
	ekXr4Ir55im2JKzO+yQWSNkflICWZl4/UkHMJkuADa47NRmlfLcBNR6pDSeTFE8IjiyvbKxHW08Hp
	MQpwdslAJ7mBpwUwrZDodqcxGBfzhKndf/hJ4eXdwNCgpCUrdYh44UfEbSC22snD/Ov7x/RnD8+RV
	uKevxzj2ddcwYuEv7Tf9Kaa+cU/XwtMjGweK3k3BfBK92Cupse31F5jObPRUv52suGwOvr01/mwyP
	wiq5xu3A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xENtK-0005HW-Fz; Wed, 07 Oct 2026 11:24:50 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xENt7-002JEu-C3;
	Wed, 07 Oct 2026 11:24:37 +0200
Message-ID: <011a9085-0bb4-433b-afc5-9c787cde0e12@rbox.co>
Date: Wed, 7 Oct 2026 11:24:32 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v4] vsock: treat TCP_CLOSING as once-established
To: netdev-bot+sashiko@kernel.org
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, edumazet@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
References: <20261005-vsock-connect-reset-closing-v4-1-15d41cfda3ed@rbox.co>
 <179133282699.434549.6239722975007408103@kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <179133282699.434549.6239722975007408103@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/26 02:27, netdev-bot+sashiko@kernel.org wrote:
> [Severity: High]
> Can vsock_connect() still reset a socket that is already linked in
> vsock_connected_table? This check only covers TCP_ESTABLISHED and
> TCP_CLOSING. At least two transports move an established socket that is
> already in the table straight to TCP_CLOSE, and neither one unlinks it.
> 
> net/vmw_vsock/virtio_transport.c:virtio_vsock_reset_sock() {
> 	sk->sk_state = TCP_CLOSE;
> 	sk->sk_err = ECONNRESET;
> 	sk_error_report(sk);
> }
> 
> virtio_vsock_event_handle() calls this for every connected socket on
> VIRTIO_VSOCK_EVENT_TRANSPORT_RESET. It does not take lock_sock().
> 
> net/vmw_vsock/vmci_transport.c:vmci_transport_handle_detach() {
> 	...
> 			sk->sk_state = TCP_CLOSE;
> 		}
> 		sk->sk_state_change(sk);
> 	...
> }

Right, that's a known issue[1], to be handled separately.

> [ ... ]
> sk_state does not seem to track table membership reliably. Would it be
> more robust to check sock->state == SS_CONNECTED instead (the transports
> set it together with vsock_insert_connected()),

vsock_shutdown() complicates this. It can flip SS_CONNECTED to
SS_DISCONNECTING.

> or to check membership in
> connected_table directly? That check would have to guard both the
> signal/timeout reset inside the loop and the sock_error() reset after the
> loop.

Lack of membership check for connected_table is not the root cause of the
issue. But, sure, we can discuss adding it as a sanity check.

[1]: https://lore.kernel.org/netdev/arpBYXWb9pohx-8v@sgarzare-redhat/
