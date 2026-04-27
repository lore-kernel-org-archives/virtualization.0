Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189183CD8C1
	for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297532; cv=none; b=WPR9Fsk0MVX0gChf1Dx1kquFm9TxuYeFoLITQWeBEOq3vJRqe78SGIi8vkNTuYpfsgglqwd7FXM67jJPoD6V7pH/zPDgjcAQ3lg3zjKt7eSHhBjzG4dmYuL8voY7h9UQkbaYoQjMDi84UrgOO5ZsXcUzZRFz+8EcoVivX4SG/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297532; c=relaxed/simple;
	bh=vdEge6E6gvHM8ffoINkybHalssstepUGTZdrRvykmLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=j+AtWrKuOZaYVs9dKxmAo9VyzxYiooZnTskqdf/SOhc/Oz20u2vuNeF8pX7RWuDowIxd0Rtu0WYXPHrBlr8//1QnaGgDN0RYF5tK17UT1J77BsVaXEgzeR+5B6pEkxwFnBUsRUjcHYKHqvsbMoQ5haYGjZahplQXtJIR+GeCAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yh2TvsmZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yh2TvsmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777297527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tnZE4tGGwssQvL+J9Xkflayp0lDMTh/2EiF7Li6rJVI=;
	b=Yh2TvsmZa5lGirtFSkXowVPjK37Le9v7/hF4L4OKrXkIhMz8I5WZXNdCZs0bareI1mhNNe
	hwFD5yeVuGSmyqrKyQ8zdMn/11414FLrNGVOtP9IK3eXjfKG2CzxYV6dOL6LWr1qAnICq0
	2nRtOYiL0yQtMX4Xvlb9dd5Ng8uxmAM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-PQxPnQ7nMf2HvJohH0OjpQ-1; Mon, 27 Apr 2026 09:45:26 -0400
X-MC-Unique: PQxPnQ7nMf2HvJohH0OjpQ-1
X-Mimecast-MFC-AGG-ID: PQxPnQ7nMf2HvJohH0OjpQ_1777297525
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d1dea12aaso676460f8f.1
        for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 06:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777297521; x=1777902321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnZE4tGGwssQvL+J9Xkflayp0lDMTh/2EiF7Li6rJVI=;
        b=suM3d+UFTNUySexE58fAOXMqXUPgcLcWb7EQ5Vcm2XTWkHvaF5u74HnSGmgqh4x1TH
         Jc2AMqXwbFzTMTUdI4kyeN1Z5hxY8qMT2ZwaBeTxMCZZ2PnIEfgsipFy3EU6h/vpz3Iz
         ywtvL24RngcDUtYcgZvQOjuBs3rcPzZFrTAV21/Qamcqt3Qpjzks9RZ0FBgCYx1d4wYe
         boUjEiPlBg7po2iO2Y3TjF5dBHbsjpnAd/+SF1V6Gkl+shbRCBNHKT7A4nxFiQ+kptQ9
         JtILZAeMKCj5Dv3yUngYn5/89W93mle8W1KF9r4eEFx1Ma9PiUbX2o6S/VP+tB803mo9
         Sn6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+jwa1QEd5h8EO2ieWVg9g49MW9Zld2C6e2Ue6MDzvg+iuIy6XrQH7zNmFCzxppj8bSzQ97YFuc+w/eynbszQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdhMxPZN50M9nT1k9X/3U2tk/jIIxxrVe+kFe0icn8nniwyva8
	SBBTZlmJzW/Vm5jWR4sRG4xRqqw6s8yurqsXef0Xzr2sqm7XWsnckA+joYOB0k1gCaTjMtvp1qy
	EoCwusjyHS7ZtNylGbREO+0SYIjLVX85d2UcO5N2Q/AXwKo7EEKkDp+ZTqWwS9TfsmJE8
X-Gm-Gg: AeBDieuRpzzemgqqNOWzOkYVQUFRm7XEVAe5n5Z2DWA6ePYqFQjlBMM+u3aghjllEgz
	fqVvqUzPNCmJDRxC4m/NdEcqX0OeQztsxoWWR7grpnQjzw56mNE2qPOm3UbFQj2AuGTbq2ddtOz
	0gN73nQWcAdMnVBoyyJAAkLYCww+v8VXOucPauXXYloPJ50yi7tGXDAEZ0Od0/GAyt/LE2W+KGo
	7hosmHfKFHqaZvN3nB0Yqk+1R4g5pSHNVR5CvXjwH0W51ouyAje5TGLawyLIMhZkqegCrUhdELV
	whuVO5DSEKBrIoY9Km0LyUdatIRDHzmlW3MxnKsQ3YO15tSu//PCBE/bdZFw0wHSe91GKOcSbYr
	eBku/tXFRym1gbDo8CYImorxEmJtHd6Zejd+LwTQOCGU2RLifrj3Kpe2l66XlWRu+lnKfXQUPnN
	yLep/dlQ==
X-Received: by 2002:a05:6000:2888:b0:43d:7b23:bc99 with SMTP id ffacd0b85a97d-43fe3dc8152mr68258909f8f.15.1777297520879;
        Mon, 27 Apr 2026 06:45:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2888:b0:43d:7b23:bc99 with SMTP id ffacd0b85a97d-43fe3dc8152mr68258832f8f.15.1777297520331;
        Mon, 27 Apr 2026 06:45:20 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0d51sm81966218f8f.10.2026.04.27.06.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:45:19 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:44:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, stefanha@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Subject: Re: [PATCH] vsock/virtio: fix memory leak in
 virtio_transport_recv_listen()
Message-ID: <ae9ilWoZI_-EMdWQ@sgarzare-redhat>
References: <20260424150310.57228-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260424150310.57228-1-kartikey406@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wPsmIuyQb7A-CIKp4RK5Ek-NExFvMwdlnShLqz94gDg_1777297525
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Apr 24, 2026 at 08:33:10PM +0530, Deepanshu Kartikey wrote:
>Two bugs exist in virtio_transport_recv_listen():

Two bugs, two fixes, two patches usually.

>
>1. On the transport assignment error path, sk_acceptq_added() is called
>   but sk_acceptq_removed() is never called when vsock_assign_transport()
>   fails or assigns a different transport than expected. This causes the
>   parent listener's accept backlog counter to be permanently inflated,
>   eventually causing sk_acceptq_is_full() to reject legitimate incoming
>   connections.

Wait, I can't see this issue. sk_acceptq_added() is called after the
vsock_assign_transport(), so why we should call sk_acceptq_removed()
in the error path of vsock_assign_transport()?

Maybe I'm missing something.

>
>2. There is a race between __vsock_release() and vsock_enqueue_accept().
>   __vsock_release() sets sk->sk_shutdown to SHUTDOWN_MASK and flushes
>   the accept queue under the parent socket lock. However,
>   virtio_transport_recv_listen() checks sk_shutdown and subsequently
>   calls vsock_enqueue_accept() without holding the parent socket lock.

Are you sure about this?

virtio_transport_recv_listen() is called only by 
virtio_transport_recv_pkt() after calling lock_sock(sk), so I'm really 
confused.

>   This means a child socket can be enqueued after __vsock_release() has
>   already flushed the queue, causing the child socket and its associated
>   resources to leak
>   permanently. The existing comment in the code hints at this race but
>   the fix was never implemented.

Are you referring to:
	/* __vsock_release() might have already flushed accept_queue.
	 * Subsequent enqueues would lead to a memory leak.
	 */
	if (sk->sk_shutdown == SHUTDOWN_MASK) {
		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
		return -ESHUTDOWN;
	}

In this case I think we are saying that we are doing this check exactly 
to avoid that issue.

>
>Fix both issues: add sk_acceptq_removed() on the transport error path,

Again, better to fix the 2 issues with 2 patches (same series is fine).

>and re-check sk->sk_shutdown under the parent socket lock before calling
>vsock_enqueue_accept() to close the race window. The child socket lock
>is released before acquiring the parent socket lock to maintain correct
>lock ordering (parent before child).
>

We are missing the Fixes tag, and I think we can target the `net` tree
with this patch (i.e. [PATCH net]), see:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>Tested-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 416d533f493d..fad5fa4a4296 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1578,6 +1578,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 	 */
> 	if (ret || vchild->transport != &t->transport) {
> 		release_sock(child);
>+		sk_acceptq_removed(sk);

Ditto, are we sure about this?

> 		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> 		sock_put(child);
> 		return ret;
>@@ -1588,11 +1589,19 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 		child->sk_write_space(child);
>
> 	vsock_insert_connected(vchild);
>+	release_sock(child);
>+	lock_sock(sk);

IMO this is a deadlock with the lock_sock(sk) called by the caller.

Also a comment would be helpful here to explain why we're doing this.

>+	if (sk->sk_shutdown == SHUTDOWN_MASK) {
>+		release_sock(sk);
>+		sk_acceptq_removed(sk);
>+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>+		sock_put(child);
>+		return -ESHUTDOWN;

Since this is very similar to the error path of 
vsock_assign_transport(), I think it would be better to start by 
defining a common error path for the function and use labels to exit, so 
we can avoid duplicating the code multiple times.

>+	}
> 	vsock_enqueue_accept(sk, child);
>+	release_sock(sk);
> 	virtio_transport_send_response(vchild, skb);
>
>-	release_sock(child);
>-

TBH I'm really worried about this patch since both fixes are completely 
wrong IMO.

Thanks,
Stefano

> 	sk->sk_data_ready(sk);
> 	return 0;
> }
>-- 
>2.43.0
>

