Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2433A9F8
	for <virtualization@lists.linux.dev>; Fri, 21 Aug 2026 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302283; cv=none; b=XigAEzD8m7cvMazQbSv2PcDpL9dH5Ixb7HryVsIollxKtEpuej+/oENVmqM4ozavRUPhMIOE5rtboZYCJ70zS4pYKTeIygWhasKM3/CljeVXsGxRWz+RFMigHNoPFSatvX838Oda1rdyM1eDgE70A/4Ym9S/aEYLT5dpg94uVZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302283; c=relaxed/simple;
	bh=1Tod6uMNvMI753P4muUbJppzBeqFN07J+ccstjPlhiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ozuHM+Exhi/IgLrexcSZGuNKPocDI8/o8Xf1hvVwCNuuvi5B5aLzF+8p5rMHcF/EvxWz/ZFN+M/lFtoZRIMgili2gFpCrYEZrYT1CnjIaBfjL46sAWJQWsjXx2IiR/Tw8L+631EaYeu7PE9GS7gRq36EesfKglnxJ8hoF7gUEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpKmr0W5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpKmr0W5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787302280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dAMfT7dZIDZktTjpF23N4xlIpV3/mfSKrwhJnlOP5bk=;
	b=cpKmr0W5/TNE2aPIm04bU3gb0r4SZ8VS/PQ2fuerPr7jRy1B4P7RQfTZ3eU77vE18H/ziS
	K0J8SmldN+XqeQXsO0EVrxpi4NDRxTVvaSw3bQjH4AaIlZvcER+4gwiDZCdmvMYaabGqEi
	2kGcF6Aut/yeJ7ptyqSn6j2n2Sg9HoM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-8V6sLUJQPa-JSzcQJqU1Cg-1; Fri, 21 Aug 2026 04:51:18 -0400
X-MC-Unique: 8V6sLUJQPa-JSzcQJqU1Cg-1
X-Mimecast-MFC-AGG-ID: 8V6sLUJQPa-JSzcQJqU1Cg_1787302278
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c11f2b9f62fso52747266b.2
        for <virtualization@lists.linux.dev>; Fri, 21 Aug 2026 01:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302277; x=1787907077;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAMfT7dZIDZktTjpF23N4xlIpV3/mfSKrwhJnlOP5bk=;
        b=Q5Nx6PEsdhDTNtF2FXyFFXne8tf/Wo2HeJN9OWCMhupI1hYGIDNVvxbINwairOwAf8
         mYw1gOYFZiB9RmAZW0MyicjFWO4QJg82S9s8PZSrROr1dKPm9UVDmxGVrzou3bMFwtNE
         ks3jWJXnDYp3FlvouZpyptiFcS4EY77aKdOF137J1tP4lUMUNlhAXvjeoap8JliEExbN
         cNKj84+79eyk1M0ZuEpnHyaedCz+jUeWf0A6X75ZIuRBDz+kr3kaH2xqSzQkuAF6tfg8
         zw/xWZBqze3oHo377wgtsCFRwdo5MfgbtIjNVXnIVhkHE+uc6/jWJveLC9ywQssE9vYy
         roeA==
X-Forwarded-Encrypted: i=1; AHgh+RpkGtKjoeZH336W/HDFPVlwEhdjFp+P8bXCEl7jZBePSb5/TvjMeKZRbany25sYJMekbDQHKb4kozhNWC2GYg==@lists.linux.dev
X-Gm-Message-State: AFuF++kQvBmG6MBjep/KFOT3deVz+KqlTMKZKzLim1VzEjRqDztA5V8u
	oWoSDthTwO4QTIkuEySPA40bX0ksW+kphl09Z+0PgxkblmtSqq7TFnaCQuvZxabATIWFrhx886q
	AR1xgCd1LYuKRX2Hlq5Lb3h97fh9b8AyVB/Yhq8js4hhJRofsZbjRs+IvMMaoF9KcxdGs
X-Gm-Gg: AR+sD13PuYgzK1hKYWT0Z1nl+UwGft5F3ve9B29UDmBWBQ9uFbBCtB1DJ8neqogNy9M
	jjRHffalFw+Bsii3yGJM1gbBlt33J8UZtnDzL30IPGteFE3n5NSe0ADygs1Glvfh9dEiLrcBSve
	kuronSiDWjZPYjx1hm+PoBBhkNqO9irZWaj3ScqGq+F+UyclORs9hEXhPyygeCuTAWTnDdJsTNb
	GHTR0ruFjIU0goxx8uFgQ4fz9ZAHjavwKk02wE/B/7UdovAt1x9R5KODiBGdvJxudK1Nzzvp+Sq
	F7iwgYCq0xwme22zDwRlDNUl8m3X7w0Xj0fMfp+p4azjxZ11LDbX4GekyoIgyyHkSCbeEDuRMDT
	QsQ==
X-Received: by 2002:a17:906:6b86:b0:c21:74ad:8b7a with SMTP id a640c23a62f3a-c246a398994mr383580366b.9.1787302277588;
        Fri, 21 Aug 2026 01:51:17 -0700 (PDT)
X-Received: by 2002:a17:906:6b86:b0:c21:74ad:8b7a with SMTP id a640c23a62f3a-c246a398994mr383574666b.9.1787302277050;
        Fri, 21 Aug 2026 01:51:17 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.88.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2458b09349sm360276866b.19.2026.08.21.01.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:51:16 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:51:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@gmail.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net v2] vsock/virtio: validate packet source for
 connected sockets
Message-ID: <aogL1SZD9lsE5qyC@sgarzare-redhat>
References: <20260820001517.2148196-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260820001517.2148196-1-4ncienth@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8VxPiWxMCEOhnXlrUgexf_IowNTqPZ79YGzJiahRduM_1787302278
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Aug 20, 2026 at 09:15:17AM +0900, Daehyeon Ko wrote:
>virtio_transport_recv_pkt() looks up sockets first by the full source and
>destination tuple, then by destination only in the bound table.  The
>fallback is needed for listening and connecting sockets, but sockets remain
>in the bound table after connect(), so it can also return a non-listening
>socket.
>
>The fallback does not validate the source address.  In TCP_SYN_SENT, a
>RESPONSE from an unrelated source can transition the victim socket to
>TCP_ESTABLISHED while its stored remote address remains unchanged.
>Subsequent RW packets from that source are delivered through the same
>destination-only fallback.
>
>This was reproduced with capability-empty processes under different UIDs.
>The attacker discovered the target tuple through unprivileged AF_VSOCK
>sock_diag and caused the victim socket to read 16 attacker-chosen bytes;
>the intended peer-side socket read 0 of those 16 bytes.
>
>After lock_sock(), reject packets for non-listening sockets unless their
>source port matches the stored remote port.  Require the CID to match too,
>except that the loopback transport uses VMADDR_CID_LOCAL as the packet
>source for connections addressed through its valid CID aliases.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Closes: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/
>Cc: stable@vger.kernel.org
>Assisted-by: Codex:gpt-5.6-sol
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---
>Changes in v2:
>- Preserve valid loopback CID aliases by matching the source port and
>  accepting VMADDR_CID_LOCAL only for the loopback transport.
>- Rewrite the commit message and receive-path comment for clarity.
>
>v1: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/
>
> net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++++++--
> 1 file changed, 22 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 8becad812..d8990f5f6 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1764,6 +1764,21 @@ static bool virtio_transport_valid_type(u16 type)
> 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> }
>
>+static bool virtio_transport_source_matches(const struct virtio_transport *t,

This doesn't seem virtio-specific, so why introducing this function 
here?

IIRC we agreed that also VMCI has the same issue, so what about adding 
this function in af_vsock.c?

Also I don't see VMCI changes, why not doing them together in a series 
since they are strictly related?

>+					    const struct sockaddr_vm *src,
>+					    const struct sockaddr_vm *remote)
>+{

What about moving here also the transport check?

So we can have something like this (with some documentation):

bool vsock_check_source(const struct vsock_sock *vsk,
			const struct vsock_transport *transport,
			const struct sockaddr_vm *src)
{
	if (vsk->transport != transport)
		return false;

	if (src->svm_port != vsk->remote_addr.svm_port)
		return false;

etc.

>+	if (src->svm_port != remote->svm_port)
>+		return false;
>+
>+	if (src->svm_cid == remote->svm_cid)
>+		return true;
>+
>+	/* The loopback transport represents its peer as VMADDR_CID_LOCAL. */
>+	return t->transport.get_local_cid() == VMADDR_CID_LOCAL &&
>+	       src->svm_cid == VMADDR_CID_LOCAL;

Could this be just `t->transport.get_local_cid() == VMADDR_CID_LOCAL` ?

I guess the source is trusted and if we are in a local transport, it's 
always set to it, no?

Thanks,
Stefano

>+}
>+
> /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>  * lock.
>  */
>@@ -1823,10 +1838,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 	lock_sock(sk);
>
> 	/* Check if sk has been closed or assigned to another transport before
>-	 * lock_sock (note: listener sockets are not assigned to any transport)
>+	 * lock_sock (note: listener sockets are not assigned to any transport).
>+	 * The bound-table fallback matches only the destination, so reject packets
>+	 * from a peer other than the one stored in the socket.
> 	 */
> 	if (sock_flag(sk, SOCK_DONE) ||
>-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>+	    (sk->sk_state != TCP_LISTEN &&
>+	     (vsk->transport != &t->transport ||
>+	      !virtio_transport_source_matches(t, &src,
>+					       &vsk->remote_addr)))) {
> 		(void)virtio_transport_reset_no_sock(t, skb, net);
> 		release_sock(sk);
> 		sock_put(sk);
>
>base-commit: e2466392a0b8496000e12181cb1ee1535eb0da25
>-- 
>2.54.0
>

