Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB9536F91B
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569627; cv=none; b=AgCTyzQxM7crKUaEqsKL7tNaaCKryKgSylCPjYdntsSYPbPDlkyMepukBFBlBc69/Upk2jKxaRJIWoW78dcWSXtfoo7LPukX8g5YOi8gSJR+44f5Bkkua+6pSAzg1Lg/zTNVdiV6/7vfk/tcKqC+IdYjG+SUaFjdNHifAeW9hfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569627; c=relaxed/simple;
	bh=vS9bD3PJ6QBZRXfBeufUTv14f2N0oWCBZ2zQWoQYBfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MOk3LZR17Y2MXH9ZkhHxhVV8Jo4cuQYQC9hcMVPPJNKHKyrBG9v2fsIZr9GwNmcTq5veh4VucDELI9mRPKKqzUaUesPPWpu2IjfaKgnp4Qm3uG9k4GT0zPD5RUyvH0tuoRSAf5AbNbDOMYEbOIFwpPptbbsbfulwgRDEDxcA8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJMwEO8t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJMwEO8t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778569617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gAb8hIM0aTA1jBLlkdpVPpG/v1UTe85oY7sMeZc2mf0=;
	b=GJMwEO8tv6QtR6qDflyt0mCGRnsiVChuyroUbQYLzhc/3v/oqUeeq5K39rcP7XPyQY8lyK
	w/Pv+rwgo2T41bqh+FJ+ZyKZ39Sb4r1/7w1wGoAFAxX+eucBhguyXF0cD0fQvZlcWjMRG4
	pBcPhmYvlqMKjbTQcVGev0hlrg4Mw9c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-Y1XCTiiDMhW9DIRdXYeU8A-1; Tue, 12 May 2026 03:06:56 -0400
X-MC-Unique: Y1XCTiiDMhW9DIRdXYeU8A-1
X-Mimecast-MFC-AGG-ID: Y1XCTiiDMhW9DIRdXYeU8A_1778569615
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4411a36715dso3715654f8f.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 00:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778569615; x=1779174415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAb8hIM0aTA1jBLlkdpVPpG/v1UTe85oY7sMeZc2mf0=;
        b=lG9FFICGZGG3OPuw14pW4izYh2L9Zd34014JmXcY2PbCqQsEXS+KRfCS8eegfvZrQu
         uU1p4P/HRrutBZP7rmY08aUuOuqFHcSQREbz8u2MhZq4h61bWWdF4LQ1Hgg6wmmYbEA1
         6F1pMVGLG0KaZp3G4lKoj9OfGlEvmugE5g2EL9m0mG+F5g9xyf1XOm6VyGXn8YAl2Hh9
         zxtbMAo/j0/299Mj00jASagSCFMGm9WJdO/U9bdGj3ti61CZbxgEp7PuK8M1vzjF3B8+
         mzRlYTnJ5BgZbtDp18wqGeFiu+r/Ug9HqMI4KpMprppkDkihEMJgIxF7sNjmkRTkyQeH
         wp/A==
X-Forwarded-Encrypted: i=1; AFNElJ8N4c0WCTO7gznaReyFxWpkulM1T7oJOVIi4+hSE7FP5Ed0GQUdhZ0NLzrzp4s9dB39dqkGl/aGctNXwtuIqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIUr2jrJfaL5MZnLh8vpnc2hf1Cm328KuvNlMp/wyoB7D8aPSn
	4vzs2tOMJldRwqyJX9xMDpR6m9izVxBfMDhCaqOo8IZplQBtJRBmuYR8TdqO8ESR11xY1UPFv1y
	tE8tAGEBlEY1X4q6r/kOIBG20b5cJCb/4xo2q7nQcJ4877QlNiEpSUO0PKZ2JTJJriIWa
X-Gm-Gg: Acq92OHtDMS4dHAk4n6sw+JikEvE4DBueAmc44J0Kl7MO62TyHyGnLgYHvNc2EnzV5X
	HLQbM9AhHkwngKkAOInO35qxYq8tJv3CsH0EpzRirk04H02ubaYt0VW4FnxW81Ki4prw4Hgqn6+
	UaViazoyPCHo7uaZGxGz6A9/qfq4E7zfewLGtBcOV5TJotX0EmKl0CzJjSJ997Wlr02L7QFauLu
	BAAHG+xiWbHZ/C/e8bHoPexAuBNjJyvxqyv8fOdr7taoN7xvH/kIActxAGlE40+OPaanMEnLz8x
	EsiZi5dQ1GEXO2p2xoXi7gSdIavaeqQV8wxTK0017mGEe5FPBCFHUOEvhefyjmaMQKUMD9/vqQ5
	u0LD+mu5c/ncyNSe1D8ENQdBqqLFv05EkwpT3M5PPd7vYkBmhBNvzVjxSRhg5O6pPbZcT7n8vaw
	==
X-Received: by 2002:a05:600c:3b08:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-48e8fe80569mr22965965e9.28.1778569614936;
        Tue, 12 May 2026 00:06:54 -0700 (PDT)
X-Received: by 2002:a05:600c:3b08:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-48e8fe80569mr22965345e9.28.1778569614432;
        Tue, 12 May 2026 00:06:54 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e9052cd24sm24611725e9.3.2026.05.12.00.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:06:53 -0700 (PDT)
Date: Tue, 12 May 2026 09:06:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Minh Nguyen <minhnguyen.080505@gmail.com>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] vsock/vmci: fix UAF when peer resets connection
 during handshake
Message-ID: <agLRfHBHJ2990NJo@sgarzare-redhat>
References: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WVHdANhESWGyijswj_s3SGvMP47C0W6Vw2o8fEYA0VE_1778569615
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, May 12, 2026 at 09:58:51AM +0700, Minh Nguyen wrote:
>vmci_transport_recv_connecting_server() jumps to its destroy: label
>and performs an unconditional sock_put(pending) to release the
>explicit sock_hold() taken by vmci_transport_recv_listen() before
>schedule_delayed_work().  The existing comment claimed this was safe
>because the listen handler removes pending from the pending list on
>the way out, which would prevent vsock_pending_work() from dropping
>the same reference later.
>
>That assumption breaks for a peer RST.  The default arm of the packet
>switch sets:
>
>	err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;
>
>and vmci_transport_recv_listen() only calls vsock_remove_pending()
>when err < 0:
>
>	if (err < 0)
>		vsock_remove_pending(sk, pending);
>
>For RST (err == 0) the socket stays on the pending list, so when
>vsock_pending_work() fires it takes the is_pending=true path and
>drops all three references itself: the pending-list reference via
>vsock_remove_pending(), then the two trailing sock_put(sk) calls.
>The unconditional sock_put() in destroy: had already dropped the
>explicit sock_hold() reference, so the second trailing sock_put(sk)
>in vsock_pending_work() is a write into the freed AF_VSOCK slab
>object.  KASAN reports a slab-use-after-free write of 4 bytes from
>refcount_warn_saturate() on the workqueue path:
>
>  BUG: KASAN: slab-use-after-free in refcount_warn_saturate
>  Write of size 4 at addr ffff88800b1cac80 by task kworker
>  Workqueue: events vsock_pending_work
>  Call Trace:
>   refcount_warn_saturate
>   vsock_pending_work
>   process_one_work
>   worker_thread
>
>Triggering the bug requires only the ability to open a VSOCK
>connection to the target and send a RST before the listener accepts.
>
>Skip the sock_put() in destroy: when err == 0 so it only compensates
>the cases where vmci_transport_recv_listen() actually calls
>vsock_remove_pending().  RST is the only path that reaches destroy:
>with err == 0; every other path produces a negative value, so their
>behaviour is unchanged.
>
>Verified on lts-6.12.79 with KASAN enabled (CONFIG_KASAN_INLINE=y,
>kasan_multi_shot): same trigger binary, same VM, 100 iterations:
>without this patch 52 KASAN slab-use-after-free reports fire; with
>this patch applied, 0 reports.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Cc: stable@vger.kernel.org
>Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
>Assisted-by: Claude:claude-opus-4-7
>---
>v2:
>  - Resubmit to netdev per Stefano Garzarella's request after v1 review.
>  - Retested the PoC with the patch applied on lts-6.12.79 with KASAN
>    enabled: 52/100 unpatched -> 0/100 patched (same trigger binary,
>    same VM, 100 iterations); test summary captured in the commit
>    message.
>  - Changed Cc: stable@kernel.org -> stable@vger.kernel.org now that the
>    bug is no longer embargoed.
>  - Rebased onto net/main (no functional change to the diff).
>
>v1 was sent to security@kernel.org on 2026-05-10 (not on lore archives;
>no public link available).  v1 review summary, for reference:
>  - Stefano Garzarella (vsock maintainer): "Overall LGTM, but I'd wait
>    vmware guys on this that know this code better."  Asked for retest
>    and resubmission via the net tree workflow.
>  - Bryan Tan (VMCI maintainer): "Thanks for the fix, it looks good to
>    me."  Also noted that no modern VMware product allows guest-to-guest
>    VMCI communication, so the practical attack surface is host -> guest.
>
> net/vmw_vsock/vmci_transport.c | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 4296ca1..88d7128 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1269,14 +1269,16 @@ vmci_transport_recv_connecting_server(struct sock *listener,
> destroy:
> 	pending->sk_err = skerr;
> 	pending->sk_state = TCP_CLOSE;
>-	/* As long as we drop our reference, all necessary cleanup will handle
>-	 * when the cleanup function drops its reference and our destruct
>-	 * implementation is called.  Note that since the listen handler will
>-	 * remove pending from the pending list upon our failure, the cleanup
>-	 * function won't drop the additional reference, which is why we do it
>-	 * here.
>+	/* Drop the reference taken by vmci_transport_recv_listen() before
>+	 * schedule_delayed_work() only on real errors.  For a peer RST
>+	 * (err == 0) the listener leaves pending on the pending list, and
>+	 * vsock_pending_work() will drop that reference itself when it
>+	 * later cleans the socket up.  Calling sock_put() here in that
>+	 * case would be a double-put and free the socket while
>+	 * vsock_pending_work() still holds it.
> 	 */
>-	sock_put(pending);
>+	if (err < 0)
>+		sock_put(pending);
>
> 	return err;
> }
>
>base-commit: be48e5fe51a5864566307998286a699d6b986934
>-- 
>2.54.0
>

