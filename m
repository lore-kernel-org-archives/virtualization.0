Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210B4BCADD
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561915; cv=none; b=QTx/vdn/c4TfcVYMMp7o5OsVhQGAwv/vZfib/cSt7ku0wqL3Rvb/Fx+04kP02WNmdhUWicuVkeY8nEjs5pTpj+aFkCFLl1HhtS+is2rGK2fMOl3mJP9EVhOJM/l9j2OKUjTYr4ND1Ei8rB4pfES18FwppXnyOHCoz8wjm8fYwIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561915; c=relaxed/simple;
	bh=nhAs5NaETTRV4ggb9S2xjW6cdn9Yst6vjKb89fLknJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V1JW5Ah1KLxInWkHXC6ZTNpab8ilTrl5dX9fIJJqxaD+SrzW1yk00EmMYEEwxBxM2g4BoMO4bXp3plgXPxReOBD3FPVHT61p3YUT5BNmyMUKn6ZIyGN02PT0v1g2oD1qV5keuNcRF/KX33m6gj5jZN1WiqRNs3mZ45aYAHkqZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+ydnonu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+ydnonu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789561903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuADGtRtcHr4ScjMyRSxePIFnAMKQr7pseg7z3igueM=;
	b=O+ydnonucX8HNLxnzVdGJ9nCFLv7a1rpvd7nNRTXU/0fuLKjlPDg0l4jeTL5Th3asDyn5R
	aig1ZuOpgPbjMciIB0qUOHvQEhNjItMD1fejRLxSO6Ahb5FhoGUyP9es02nWBUbMhcTJoB
	ViA715ktmeBlxoRk3Uy7yjl+sSLyG8I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-CUzIP3zmPfKj1RIGkeB82A-1; Wed, 16 Sep 2026 08:31:42 -0400
X-MC-Unique: CUzIP3zmPfKj1RIGkeB82A-1
X-Mimecast-MFC-AGG-ID: CUzIP3zmPfKj1RIGkeB82A_1789561901
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e76a80fe5so41557455e9.2
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 05:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561901; x=1790166701;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MuADGtRtcHr4ScjMyRSxePIFnAMKQr7pseg7z3igueM=;
        b=1s68r4JzwQQlgeDqrUzMGC+6tgS+HFzyKQDzbUCBsUNs6wC9I7XXENeVbZvPV8T2Kk
         xKK2rnSDUvZbguQYqj3pgzs5xw9kwOUV7uQn54bGS1KfNAXXljj0hHoi2kXCqb6K4ix+
         mYVeUIO72l5qcGW/53y72w99mbzVZbxie5XLNGRswvNxRHIqrpTg4KqkvZfSb2NRhaB0
         oL7MmBKzE5FDskKPHJ/vDbc9RcyxdqlT32n759aY/9OYjisAnB7Ju7b+bJ4uw5ByoIIG
         Ij4FYYRTxJHJ72brWbMTlX/kzxpl5TVQht+4Hjbb8kKpi67DFKT2yi2KpfYBaSQud20b
         tCKA==
X-Forwarded-Encrypted: i=1; AKwUvByfYf8zCl2mZAY/Qec8sZWNoP/NSCw6yOf3HcvsZj9I8e4sA967o/hmUznLhfxh0U6zZgknPQSCwq6W1Ccmlw==@lists.linux.dev
X-Gm-Message-State: AFuF++nogcJFbjsRdtUD7PjjvA/1op7xJpDWarIDXzyJZs6Q9dvON2wp
	Q4j53bFtNZKHQplAW/2NyzAji0Ll7+WP4yL2grVaUnWJH9eVziZ6it5PUwyNNWviEEFnAS4J+N0
	PMnIRiqrPLDvdnt2OYBUvDVX2Qnmh1nP1Gi7rKVEkFCsYE5408FZUY7hoVzJPFbcuUK6x
X-Gm-Gg: AYBFou3yLdBTc/wKCtaxn9zaX2K4QPt9yz/NviaamIByMa67NWmsjspsnf+8bn1XsS0
	OH+lUBGXToZ0N3t3ARzbVqCCVuHJ8NjH6G9xRaZxs8zgeUmyHY8kKrLhqN80kHd3k+lHZyOFHit
	i+FofSQOJ1+Wb46sqDWNc2TVSGf0DulR5+uOLWLEOEcyPT83E1F6r7kOb4F4Ph3YQvoniJdP0Ok
	Z2N2VF5jpGh0bU39GJh1rWApRiCQQ/sR9VSaGf8jqohfgFga8jpuPQ6+KqNsgd1UfPyLKJgdyT6
	9HkVriGd0VWIkdg3ZHLpWG/ZAsJ3q9CyWHpLAJT7k4TD+l+NlUm0qAi/WWKJJtxRle4gcwrc3gU
	03N+N+NJMf7epWdOQc2lLvQnwjRshqIWQzD19aFv6aPxX2g==
X-Received: by 2002:a05:600d:640e:10b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49eb7314c13mr20983705e9.6.1789561900492;
        Wed, 16 Sep 2026 05:31:40 -0700 (PDT)
X-Received: by 2002:a05:600d:640e:10b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49eb7314c13mr20983095e9.6.1789561899813;
        Wed, 16 Sep 2026 05:31:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e847fcbdfsm43541255e9.4.2026.09.16.05.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:31:39 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:31:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 5/5] vsock: Handle sudden TCP_CLOSE during connect
Message-ID: <aqqIuUadZ_E1skmR@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-5-a1d9abb472f7@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-5-a1d9abb472f7@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: El1Hj_3Y9-8klyPppoFWecgm2HgX10zAlyWoMNxPYb8_1789561901
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Sep 15, 2026 at 03:15:16PM +0200, Michal Luczaj wrote:
>Virtio/PM events are serviced by virtio_vsock_reset_sock(), which resets

What "PM" means here?

>each connected socket. The reset is done under vsock_table_lock but without
>taking lock_sock(), so from the point of view of vsock_connect() -
>locklessly. The same pattern exists in VMCI's
>vmci_transport_handle_detach() and vhost's vhost_vsock_reset_orphans().
>
>The complexity of connect() comes from the fact that:
>1. the virtio transport can be reassigned, so the old transport must be
>   safely released;
>2. a failed connect can be followed by a retry, so the socket must be
>   reverted to a sensible state.
>Both cases apply only as long as the socket has not yet established a
>connection.
>
>While connect() waits for TCP_SYN_SENT -> TCP_ESTABLISHED, other
>transitions can also occur:
>
>  TCP_SYN_SENT -> TCP_CLOSE on connection failure, timeout or signal
>  TCP_SYN_SENT -> TCP_ESTABLISHED -> TCP_CLOSING on VIRTIO_VSOCK_OP_RST
>  TCP_SYN_SENT -> TCP_ESTABLISHED -> [TCP_CLOSING ->] TCP_CLOSE on event
>
>This further complicates connect(). Rather than making every event handler
>drop the socket from connected_table or adapting connect() to handle more
>transitions (while missing proper locking), use vsk->peer_shutdown as a
>poison flag. Whatever state an event leaves the socket in, the flag bricks
>it and prevents suspicious transport reassignments or TCP_SYN_SENT
>retransmissions.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index adf3f018347e..972952d04a81 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1743,6 +1743,12 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 			goto out;
> 		}
>
>+		/* Virtio/PM events are serviced locklessly. */

IMO we should be generic here (i.e. don't mention virtio or mention it 
like one of the transport, but IIUC also VMCI does something similar) 
and also we should explain better why we are doing this, like you did in 
the commit description.

Maybe we should document this behaviour also on top of this file.

>+		if (READ_ONCE(vsk->peer_shutdown)) {
>+			err = -ECONNRESET;

Is ECONNRESET a valid connect() error to return?

>+			goto out;
>+		}
>+

 From LLM reviewing, can you check if it's valid? :
   - M (net/vmw_vsock/af_vsock.c:1747): VMCI regression.  vmci_transport_handle_detach() sets
     peer_shutdown = SHUTDOWN_MASK unconditionally and then special-cases TCP_SYN_SENT with the
     comment "we treat the detach event like a reset" — i.e. a connect() retry is the expected
     recovery. It is reachable for a non-connected socket via vmci_transport_peer_detach_cb() (which
     uses trans->sk, not the connected table). Since vsock_assign_transport() only clears
     peer_shutdown when the transport actually changes (af_vsock.c:671-689), the retry now hits the
     new check and returns -ECONNRESET forever: the fd is permanently bricked where it previously
     reconnected.

Thanks,
Stefano

> 		/* Set the remote address that we are connecting to. */
> 		memcpy(&vsk->remote_addr, remote_addr,
> 		       sizeof(vsk->remote_addr));
>
>-- 
>2.55.0
>

