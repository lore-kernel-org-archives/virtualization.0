Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAF352C4F
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710198; cv=none; b=AogiaZgApTS/394bf7qeUcVLE6tyHuq4NbgxuizkGCl+EAcIpbND44/vp26NM/A/afXxcTnbHynumfObvHlvItrpWf4LM2MwTooLWEbGm9OlS8nFG5oRN74q/5BWaiwNJ4kJyfqnqmZK6DLsGyYjOxg979VfT+aH1qBfhv2ZQEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710198; c=relaxed/simple;
	bh=PjgjwZnGgTn6iqnEiUJ3bPEVMifERR8pCitafp8p2xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MGzIR0Fh+q/9XOp9YrjywZ0VGdQte0LfZX9JutNarq9rVhZFE7i5jfEQDygI5BUqro/27Oqm+ax9XTOoR70hbOP7QQAyL+AgA8uFrntUNuBeWQm0bWbTsKGBwt5t9/pFUJDoLwWIR2LjLzHrrudbPdmbHeRrFEOQBQ+qJYIyxEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NyfKtwFJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyfKtwFJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786710195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PdXWuErOvyDV9Y8ztCqoO/f6xuxZcnsGekDRRKOGqDQ=;
	b=NyfKtwFJg40KApYJl7HMc5X/BHYsCfipWWJbE7G7rfTniXhpV3Nc6eTpW4ZuRC82N5pjW4
	7A7BqGs5QBltHw9v7MohdKA1sku94li4uveIlVNoG6HJcML18GOgSnHYVNCy6MhphoHq+L
	VaGxxw/XbM75XpoSmIFFnN349SGHZjQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441--weuqWC-PeOQ6qpCHUF0vA-1; Fri, 14 Aug 2026 08:23:14 -0400
X-MC-Unique: -weuqWC-PeOQ6qpCHUF0vA-1
X-Mimecast-MFC-AGG-ID: -weuqWC-PeOQ6qpCHUF0vA_1786710193
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495529a93f9so9511395e9.3
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 05:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786710193; x=1787314993;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdXWuErOvyDV9Y8ztCqoO/f6xuxZcnsGekDRRKOGqDQ=;
        b=bAGNa3rllmXB4hsXAaQGrxHwALlqqoOeHgFo3OUM+Uh0Z3h2wnUDdaRfg/K/n7vSYt
         tkXG9q3OaQMh1xRLyvJGglG0GfgjC0rEI/OAtujpsG5ct/lbdUHziEW8LvpYHv+sg04v
         JNKrU1/tfkadqSMf2bZrWO1hZYhXlLIrPaum3NZPFEr/n3oasLpQxPOCkjbPoK3tXQbs
         6IycUuUo9XZ2/JvritqSBhMjcmNAtteLIGZoBJB2I41HT1oqqE5SIaxPeFVXtI6nm7I6
         DDQ2TtXvDO3gllnp0PdX//YZ1oBPeV1vAUs8pqy/r1bjlMV8Gw/WThIAl0SmZkwafDsV
         uT/A==
X-Forwarded-Encrypted: i=1; AHgh+RpX9qblIuKfye4ocmp7SBsZcLYC7e5YyaRr91dRRGKCDGsifrru57TA3PHVUZ26cMuVC7HbSNIZ6qNvcACrtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUBYW8NmnYh6x1xkAFVBRix0FQe1aH7YKqFxsWmK0gwrudiNGX
	10ys5Ph9mmTyi/edTg6btVh0+CmPQsa8zQH2g0xaSfI3rvfa1gvrEo+0XroJNv5Wx3FqgORBNb0
	aiI9k/PbkYazmklhC2aV0Luy1mKI9gT+qvQfk4eHxZM8mei2gMmJSAsuw3eW/sCUxfW7Q
X-Gm-Gg: AR+sD13JlZVLWQGP9aUnzwZAmFF+GluLhd0Kmh/gXfZweQ4ecBt9uoQg2wteZ0krQ1Z
	p2DUMIiLexTJtDsVM4OkVQUfAVb/DqCCw7trNKwK8+htatNWx2BAAb/LIMel6vlD9w49igLovwO
	u3sjNXz1qlHjMpelFf9U/6MYRh5+1cbwbVuPZosztAIbJnJVa5iEhfTItyZsEqAvkwZdJk7hu8m
	K5VqcSAl1N6jDBcYl1BddEKfO5oxKBtzU8+GLzZ0Gp0aDX8D2qA3cnoTlDMXxHWlOpxonKkkOPz
	x+vKM4oy0tx725BaLjpR5yo7goFfCWYpUWcJJr0KYR6dTfBIEw5uDa2H7yDaXDnVE84wHCMnKWL
	/7LZ7k298MGqrDZM2jerzuREOxd7vmxoP1UKWtn7RLB369Lvwbimd
X-Received: by 2002:a05:600c:1d1e:b0:496:bbcb:b0bb with SMTP id 5b1f17b1804b1-49987992addmr59968695e9.18.1786710193302;
        Fri, 14 Aug 2026 05:23:13 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1e:b0:496:bbcb:b0bb with SMTP id 5b1f17b1804b1-49987992addmr59967975e9.18.1786710192832;
        Fri, 14 Aug 2026 05:23:12 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b27bfsm7763993f8f.23.2026.08.14.05.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:23:12 -0700 (PDT)
Date: Fri, 14 Aug 2026 14:23:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: validate packet source for connected
 sockets
Message-ID: <an7vDxDT-N6xi-3l@sgarzare-redhat>
References: <20260813121236.2328599-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260813121236.2328599-1-4ncienth@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -iKRPBUItrvZH8rDsD8lnHs9tKBqwA31Y9wUoumMLng_1786710193
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Aug 13, 2026 at 09:12:36PM +0900, Daehyeon Ko wrote:
>virtio_transport_recv_pkt() first looks up a socket using the full source
>and destination tuple.  If that misses, it falls back to a bound-socket
>lookup using only the destination address.  The fallback is needed for
>listening and connecting sockets, but it can also select an established
>socket that remains in the bound table.
>
>As a result, a packet from an unrelated source can be dispatched to a
>non-listening socket.  In TCP_SYN_SENT, a source-blind RESPONSE marks the
>selected socket established while retaining its original remote address.
>Subsequent RW packets can likewise be delivered through the
>destination-only fallback.
>
>This was reproduced with two capless processes under different UIDs.  The
>attacker discovered the victim tuple through unprivileged AF_VSOCK
>sock_diag and injected a chosen 16-byte payload into the victim established
>loopback socket.  The legitimate peer received none of those bytes.

I don't understand this, what it means? If the receiver doesn't receive
those injected bytes, should be fine, no?

>
>After taking the socket lock, verify that packets for non-listening sockets
>come from the peer stored in remote_addr.  Listening sockets continue to
>accept packets from any source.

IMO this description should be improved, it's quite hard to follow.
This is an idea IIUC the issue:

   virtio_transport_recv_pkt() looks up sockets in two steps: first by
   the full source and destination tuple in the connected table, then by
   destination only in the bound table. The fallback is needed for
   listening and connecting sockets, but it never validates the source
   address in the packet header. Since sockets remain in the bound table
   after connect(), a packet from any source can be dispatched to a
   non-listening socket.

   An unprivileged process can discover the target tuple through AF_VSOCK
   sock_diag (no capabilities required), send a forged RESPONSE to a
   TCP_SYN_SENT socket to establish the connection, and then inject
   arbitrary data through subsequent RW packets, all delivered via the
   destination-only fallback.

   After lock_sock(), verify that the packet source matches the
   remote_addr stored during connect().

>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Cc: stable@vger.kernel.org
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 8becad812..f73e0406a 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1822,11 +1822,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>
> 	lock_sock(sk);
>
>-	/* Check if sk has been closed or assigned to another transport before
>-	 * lock_sock (note: listener sockets are not assigned to any transport)
>+	/* Check if sk has been closed, assigned to another transport, or if the
>+	 * packet is from a different peer than the one connected to sk.  These
>+	 * properties could have changed before lock_sock.  Listener sockets are
>+	 * not assigned to any transport and accept packets from any peer.

Please keeps changes minimal, why adding "These properties could have
changed before lock_sock." and changing the phrase related to listener
socket?

Also the new part is not clear IMO, we should explain why we are adding
this new check, not what we are doing which is clear looking at the
code.

IMO we should just add something like this (feel free to change it):

   Also verify the packet source: the bound-table fallback lookup
   matches by destination only, so a non-listening socket can be
   reached by a packet from an unrelated peer. Drop it unless the
   source matches the peer the socket is connecting or connected to.

> 	 */
> 	if (sock_flag(sk, SOCK_DONE) ||
>-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>+	    (sk->sk_state != TCP_LISTEN &&
>+	     (vsk->transport != &t->transport ||
>+	      !vsock_addr_equals_addr(&src, &vsk->remote_addr)))) {

Do we need to add the same check also in the VMCI transport?

Hyper-V seems different.

Thanks,
Stefano

> 		(void)virtio_transport_reset_no_sock(t, skb, net);
> 		release_sock(sk);
> 		sock_put(sk);
>
>base-commit: 9006c116dd111d457bf5d074990210f70a4ad2c8
>-- 
>2.54.0
>

