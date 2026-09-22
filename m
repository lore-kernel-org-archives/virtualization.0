Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56947C0EE
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085396; cv=none; b=R2lSYX6AMHbWMlA5V25ZPvxqDPE9EaAw0OO6Gzx9OU12igNilR3AsXiKCMlJAEQic+hbbsMdr1bi3NHC2M/X9suFWqP/i6GDBDW4TZ7we6nKIoRYwkpCEl0gOf1SzYH14/cliUijdDdQS6XrR0Mf/P5sLY7dB0mpYIDuVyaa7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085396; c=relaxed/simple;
	bh=xpzff7gTANmin7ayImKqNSwtv/jMmdVMSrHmqXKpE6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Gcd32rIl9kFGe7J7b51/+zGk6ZRhQuuADk4mQtNbcGMcLWOwUliuvhkDFzTyS4yaUfsi24EdgwzzQxih7J5vIyFy/RIh6lmGBWfdSDAy3CK/ARc/JLR5P5Kv1ysXIREkTR9poB8912QWyZiqEIswXx+OXEKcvFgoz6x03n0XR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ht7ELrCF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ht7ELrCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790085393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CSAJceS2lTxo7RYYkwSiAWcerJGzn5wbrFBMDwrG220=;
	b=Ht7ELrCFsQ0Re0Qwpyi//HdhycAci3yKV9Q/Eyz+W8SoIbQ0JccJPHzDjUnhcFErv8BFL0
	Oqj49gRZj4N59R0CDQlTx8S47pGeaotpTELHx2AnrIyVulz3edGQj2LxjiNkHYRRXiMCtU
	UR9KjUXV647r3ruMUCCHCaVfBgB/Obg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-s3siVB9cNe6lPwELFhuioQ-1; Tue, 22 Sep 2026 09:56:29 -0400
X-MC-Unique: s3siVB9cNe6lPwELFhuioQ-1
X-Mimecast-MFC-AGG-ID: s3siVB9cNe6lPwELFhuioQ_1790085388
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49b0e6638e3so35212785e9.2
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 06:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085388; x=1790690188;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CSAJceS2lTxo7RYYkwSiAWcerJGzn5wbrFBMDwrG220=;
        b=x82E6+Hx2u9I77/ZXxmETGOBfm24sHDUXTbSRe2qYGQEaebJ2VT63HYnAwWOp/260a
         Bb/a2D4PNYo5PHwuEGeeqltUVa4F0cjqYqzI6OOfcAK/ujNdls2tqv/wOEqnDS7Ja1OB
         b3l95vjRz0bwzlAWIllAa0LMie1FBfffOFAPfAc+S5kd0xOR8PpS/p+QtgTXEZH4Flrh
         WS+hl2TCV431Uo33zZzOAOjFUoY/PAclBUJNHyQBez1brA19d7zWnC5sKCeCyOmyHz7o
         4xxHOIwZ71hqoviXTJkFsz92236dRSqATiLfIS4JrfxT+F+Au74WjqMn2HsrsnqWs5QR
         cn9g==
X-Forwarded-Encrypted: i=1; AKwUvBwIY4r+0BF1xzor7HAp48A8DrU4tFPwuPo2T2T2le5JW3/vXQA8xiFI9y7BVt5NvCw7IT5CpvrOuRJDje3m6A==@lists.linux.dev
X-Gm-Message-State: AFuF++lowmV5jWpxATCkgf2QC1WKJlSpdWrwuvoholKPxt7+ylvPS+A0
	kIxc13E17bbnmFgn8nknNX0mVBiS2ocbDZiK57S/AU4pVn7rdO2xMps5dkO3l121AZIclf24LW+
	xeJME9shcj3zMvqdaYeLXriFy+79nVhGEkOM47H6kITJIXcKW/Fj0J5qoZnERfjYKAcIT
X-Gm-Gg: AYBFou1gWPiOmd9gnjStNFTdLgkDnBenwrMcY0r5B2uHP0+YnZIq+7trRG1udIuCoxr
	dt6urMtormYxSXmpwNVFKBc61WYAuNvNk2ze9bktC3y3/SmNRqufGcASBbmHcIOH6F7kdxg2ldQ
	+OP2yh3BtF4JANLno1e6Cra9dEG/VRpSICftlY1D7xMRulU5ABCBasF9uGF5OseSWZPN7mow94J
	2SUjKWBPSf4f+cyLg2CpiUW6DN0yIYl+Gl43dfNETiqytjtiEi6vufh4OHowPj3lfywo52OW+UM
	YhlNix4QXInuUGJ1X0u2Ec1Lre3aKWBrI6IaB7Tj/YCpeoorFrijFo5YCIFjwcJDRiNjLRp6FPa
	gNwH39/ioVIsEylzOrzJFJa5cpqKoxQK+Qdnt+mIESKooWsSARQ4=
X-Received: by 2002:a05:600c:6298:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49fc5687adamr193025365e9.1.1790085388315;
        Tue, 22 Sep 2026 06:56:28 -0700 (PDT)
X-Received: by 2002:a05:600c:6298:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49fc5687adamr193024815e9.1.1790085387814;
        Tue, 22 Sep 2026 06:56:27 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdace7941sm63084875e9.2.2026.09.22.06.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:56:27 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:56:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] vsock: report pending receive data to
 io_uring
Message-ID: <arKF7P9gqq7ehX-k@sgarzare-redhat>
References: <20260920194710.1114748-1-devnexen@gmail.com>
 <20260920194710.1114748-2-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260920194710.1114748-2-devnexen@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BQqoQmm0yP1VQqkwHXJsNFlTWKPQBqbjEuDigi1ShsA_1790085388
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Sep 20, 2026 at 08:47:09PM +0100, David Carlier wrote:
>AF_VSOCK stream receives never fill msghdr.msg_inq, so io_uring cannot set
>IORING_CQE_F_SOCK_NONEMPTY and retries a multishot receive even after the
>queue has been drained.
>
>Fill the hint at the common receive exit using the transport callback that
>SIOCINQ already uses, and report 1 once the connection is finished so the
>caller performs the receive which observes EOF, as TCP does after a FIN.
>
>A vsock loopback ping-pong with io_uring multishot receive drops entries
>into __vsock_connectible_recvmsg from 1.97 to 1.00 per delivered message,
>and receiver CPU time by about 3% (25 runs of 50000 messages, p=0.006).
>
>Signed-off-by: David Carlier <devnexen@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 39 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 39 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f840498b58af..63309708c916 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2543,6 +2543,38 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
> 	return err;
> }
>
>+/* Bytes a following receive can consume, 1 if it would only see EOF, or a
>+ * negative value to leave the caller's hint alone.
>+ *
>+ * Called under the socket lock after a nonnegative stream receive, so a NULL
>+ * transport implies SOCK_DONE.
>+ */
>+static int vsock_inq_hint(struct sock *sk)

can we add "stream" in the name so it's clear that is stream only?

(e.g. vsock_stream_inq_hint)

>+{
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+	s64 data;
>+
>+	if ((sk->sk_shutdown & RCV_SHUTDOWN) ||
>+	    (sock_flag(sk, SOCK_DONE) && sk->sk_state != TCP_ESTABLISHED))
>+		return 1;
>+
>+	if (!vsk->transport)
>+		return 1;

Can we squash this in the previous block?

>+
>+	data = vsock_stream_has_data(vsk);
>+	if (data < 0)
>+		return -1;
>+	if (data > 0)
>+		return (int)min_t(s64, data, INT_MAX);

nit: IMO we can remove the int cast.

>+
>+	/* Empty but finished: keep the caller reading so it sees EOF. */
>+	if (sock_flag(sk, SOCK_DONE) ||
>+	    (READ_ONCE(vsk->peer_shutdown) & SEND_SHUTDOWN))
>+		return 1;
>+
>+	return 0;
>+}
>+
> int
> __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 			    int flags)
>@@ -2606,6 +2638,13 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
>
> out:
>+	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM) {

Why only STREAM?
A comment here and in the commit would be nice.



>+		int inq = vsock_inq_hint(sk);
>+
>+		if (inq >= 0)

Why assigning only >= 0 values?

Thanks,
Stefano


>+			msg->msg_inq = inq;
>+	}
>+
> 	release_sock(sk);
> 	return err;
> }
>-- 
>2.55.0
>

