Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC89ACA5A
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765202; cv=none; b=CfWA1KyK2fyHxFGnywXfT8isOmZzKOzAC3B4r0+/0KB2qjimYe2XK38Jhi1O3CQP2jHYrPmxIO/++6zWdshefC0putzYnyyyHJwGPJFC9jAZrrYtiFCBL1bsZ6EM7pDW6q/L17CMZkXPPPzlrchbyK4EPzwzPP+JPwUViMt9G4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765202; c=relaxed/simple;
	bh=bPoqUeI0w81fhtEAjtDVf+m4QR0ei2EHtrHu0hVxMw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dtm63tH5drKA2ZT8z5LjWNsxS5+m0GankjHmPX6IB4sNHrwKEOnXD+c2xGm011X0eZB3r/DQdDoPth0wl4z4SwvR91/P0JSQqgO2+LWWB83crOjjceHn0gEAhiTgrp9mintbGCFTB2bEzm4w8Ap3NiCczhINoYC8GWp305gQaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLjFPqLY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLjFPqLY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778765193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=megH/KafnN6bx24pbYimiNaRlToZucSV9fHWitX3fzE=;
	b=bLjFPqLYSESN5lL4tJOdWWUfxnrTcV33AlpkJSQfXaVUXDMp6rZ9dV3x1apqa4wn6gba6c
	tkPQha1U55rFQ2KBiT42FU9lK5zDQ+wL9V++kDCXiRSPLu6krMZOxf/wyt5bt42s++tzex
	I4sjBA0YqlfmGlBrgE0OYHBtyNXeQNI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-93v232T3NLOnGOn9GIrW3g-1; Thu, 14 May 2026 09:26:32 -0400
X-MC-Unique: 93v232T3NLOnGOn9GIrW3g-1
X-Mimecast-MFC-AGG-ID: 93v232T3NLOnGOn9GIrW3g_1778765191
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d046fac74so46769215e9.3
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 06:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778765191; x=1779369991;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=megH/KafnN6bx24pbYimiNaRlToZucSV9fHWitX3fzE=;
        b=JFW1v7tq5HY8yV+qkfKdr7g8JNA8Up/dkJPc3tV5wo3I1WXXA80x/XoqATKeC+WaKr
         Gje9BQYbmIuecpwC54rsIRo1Cm9U0LvFZc5QlBO2SKHoX5V1Wu5/HUNPH1Tv6RKIyDBY
         4G/kAG/VWr7P373ZH72k0zxsAfpKi3+N1hWE19WLfX2hH/XSa+K4I+Gpay2FIU2NPIOQ
         O8Ccvu/n/18y/oHsvuMzljv+ka+sLaSpwRvwnK5h7o1AaAYAinFJzLb+/aldwd3J2UyG
         H3U2Mrng1Jn5gOl421g/ezPxc1R4TlGkYGA/eDKOPyMGXzavbYH/VCwsEixPPoC7xEbg
         3MUg==
X-Forwarded-Encrypted: i=1; AFNElJ9UZ8DhSfFCiYKU+O/b4AF0eXxxJJACS55XqHWvd5fjUJ3vomQ/9U1rBg2XDcB1yLSC92F9g5hFnM6iFK8Nxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwN5gY4/AlC20vP1jo0F19XQGxRh8KIRWBEIz+E220xHYQHYA5o
	0J6+lgbbYAl6HyJlLhv22tIAA+ff3VZmCLxcZ3sGUHnKPkEZZl7SJ2aEyWvkb9aFCtY+Qg0JcIL
	kUo5xSvZ+9TAyDQGWJnqNtOgrgJ/xexUD5zS0ilD8WEU2NS6RUsok5wKtg0SM4+okdS2H
X-Gm-Gg: Acq92OGs4jrqOjgfUPPrW3DbKWliDAZvVrZfVdb7VAsZw9vfnFJ8KIplEcZEwF7YPqZ
	ob2qnvKrn4Ul2yBRg61NK+JM2P8HuVacdm+KmrAYKwUT4mWFEX4/+gyaD2QQssMSRs7wun3yz/F
	j750um0EW/5HA6M4SuUMrp6N4hkFVEgv5+bq1gr06dupe3iD+rT4cGbS5Xf2xRc4HY7xnr5h/Ug
	iBT0zT1ncUjMeOgzHSWDhkQ9M+Fr77CJY19DyOg9VGPZZDw8UCEKCoA1whZ/XhqIypn06NJQv3S
	efh45NCXO3V6/rfhISvVpoolSZZ/4DyrSpbBs1R1ofQI9kwnWEqZkiAbAAvaPo6cKopXPcg8Wn/
	XXy8oQGZpKS77wFAaydNDT5AdlXlexQnkODWpfQ1H6qNP/hLjEk65ho0=
X-Received: by 2002:a05:600c:3e0c:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-48fc9a2ca70mr111956975e9.15.1778765191309;
        Thu, 14 May 2026 06:26:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0c:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-48fc9a2ca70mr111956425e9.15.1778765190797;
        Thu, 14 May 2026 06:26:30 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd7694754sm19931255e9.34.2026.05.14.06.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 06:26:30 -0700 (PDT)
Message-ID: <3518e2b5-b669-4aaa-82ca-bbf479a85889@redhat.com>
Date: Thu, 14 May 2026 15:26:28 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] vsock/vmci: fix UAF when peer resets connection
 during handshake
To: Minh Nguyen <minhnguyen.080505@gmail.com>,
 Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa
 <vishnu.dasa@broadcom.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Al4BhoNiKQxQ1dKLRmEgyoYFNRWMuLHiT_KplPDJp9U_1778765191
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 4:58 AM, Minh Nguyen wrote:
> vmci_transport_recv_connecting_server() jumps to its destroy: label
> and performs an unconditional sock_put(pending) to release the
> explicit sock_hold() taken by vmci_transport_recv_listen() before
> schedule_delayed_work().  The existing comment claimed this was safe
> because the listen handler removes pending from the pending list on
> the way out, which would prevent vsock_pending_work() from dropping
> the same reference later.
> 
> That assumption breaks for a peer RST.  The default arm of the packet
> switch sets:
> 
> 	err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;
> 
> and vmci_transport_recv_listen() only calls vsock_remove_pending()
> when err < 0:
> 
> 	if (err < 0)
> 		vsock_remove_pending(sk, pending);
> 
> For RST (err == 0) the socket stays on the pending list, so when
> vsock_pending_work() fires it takes the is_pending=true path and
> drops all three references itself: the pending-list reference via
> vsock_remove_pending(), then the two trailing sock_put(sk) calls.
> The unconditional sock_put() in destroy: had already dropped the
> explicit sock_hold() reference, so the second trailing sock_put(sk)
> in vsock_pending_work() is a write into the freed AF_VSOCK slab
> object.  KASAN reports a slab-use-after-free write of 4 bytes from
> refcount_warn_saturate() on the workqueue path:
> 
>   BUG: KASAN: slab-use-after-free in refcount_warn_saturate
>   Write of size 4 at addr ffff88800b1cac80 by task kworker
>   Workqueue: events vsock_pending_work
>   Call Trace:
>    refcount_warn_saturate
>    vsock_pending_work
>    process_one_work
>    worker_thread
> 
> Triggering the bug requires only the ability to open a VSOCK
> connection to the target and send a RST before the listener accepts.
> 
> Skip the sock_put() in destroy: when err == 0 so it only compensates
> the cases where vmci_transport_recv_listen() actually calls
> vsock_remove_pending().  RST is the only path that reaches destroy:
> with err == 0; every other path produces a negative value, so their
> behaviour is unchanged.
> 
> Verified on lts-6.12.79 with KASAN enabled (CONFIG_KASAN_INLINE=y,
> kasan_multi_shot): same trigger binary, same VM, 100 iterations:
> without this patch 52 KASAN slab-use-after-free reports fire; with
> this patch applied, 0 reports.
> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
> v2:
>   - Resubmit to netdev per Stefano Garzarella's request after v1 review.
>   - Retested the PoC with the patch applied on lts-6.12.79 with KASAN
>     enabled: 52/100 unpatched -> 0/100 patched (same trigger binary,
>     same VM, 100 iterations); test summary captured in the commit
>     message.
>   - Changed Cc: stable@kernel.org -> stable@vger.kernel.org now that the
>     bug is no longer embargoed.
>   - Rebased onto net/main (no functional change to the diff).
> 
> v1 was sent to security@kernel.org on 2026-05-10 (not on lore archives;
> no public link available).  v1 review summary, for reference:
>   - Stefano Garzarella (vsock maintainer): "Overall LGTM, but I'd wait
>     vmware guys on this that know this code better."  Asked for retest
>     and resubmission via the net tree workflow.
>   - Bryan Tan (VMCI maintainer): "Thanks for the fix, it looks good to
>     me."  Also noted that no modern VMware product allows guest-to-guest
>     VMCI communication, so the practical attack surface is host -> guest.
> 
>  net/vmw_vsock/vmci_transport.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 4296ca1..88d7128 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1269,14 +1269,16 @@ vmci_transport_recv_connecting_server(struct sock *listener,
>  destroy:
>  	pending->sk_err = skerr;
>  	pending->sk_state = TCP_CLOSE;
> -	/* As long as we drop our reference, all necessary cleanup will handle
> -	 * when the cleanup function drops its reference and our destruct
> -	 * implementation is called.  Note that since the listen handler will
> -	 * remove pending from the pending list upon our failure, the cleanup
> -	 * function won't drop the additional reference, which is why we do it
> -	 * here.
> +	/* Drop the reference taken by vmci_transport_recv_listen() before
> +	 * schedule_delayed_work() only on real errors.  For a peer RST
> +	 * (err == 0) the listener leaves pending on the pending list, and
> +	 * vsock_pending_work() will drop that reference itself when it
> +	 * later cleans the socket up.  Calling sock_put() here in that
> +	 * case would be a double-put and free the socket while
> +	 * vsock_pending_work() still holds it.
>  	 */
> -	sock_put(pending);
> +	if (err < 0)
> +		sock_put(pending);

Sashiko says:

---
Could this change lead to a socket memory leak if another packet arrives
before vsock_pending_work() executes?
If a peer RST is received (err == 0), the socket stays on the
pending_links list with its state set to TCP_CLOSE, and the base
reference is kept.
If the peer then sends another packet (such as another RST) within the
delay window before vsock_pending_work() runs,
vmci_transport_get_pending() might find this same socket.
Since its state is TCP_CLOSE, vmci_transport_recv_listen() would hit the
default switch case, set err = -EINVAL, and call vsock_remove_pending().
This removes the socket from the list and drops the list reference, but
it bypasses vmci_transport_recv_connecting_server(), meaning the base
reference is never dropped.
When vsock_pending_work() runs later, vsock_is_pending() evaluates to false.
This sets cleanup = false and bypasses the sock_put(sk) call, leaking
the pending socket.
While not introduced by this patch, does this error path leak
sk_ack_backlog slots on failed handshakes?
If a handshake fails due to an error, vmci_transport_recv_listen()
handles it by calling vsock_remove_pending(). This removes the socket
from the pending_links list but does not call sk_acceptq_removed(sk).
When vsock_pending_work() runs later, vsock_is_pending() evaluates to
false because the socket is no longer in the list. This causes the work
function to skip its own sk_acceptq_removed(listener) call, meaning the
listener's sk_ack_backlog is never decremented.
---

it looks like the above is trading an UaF for a leak ?!?

