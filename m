Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398028CF4A
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041380; cv=none; b=DoaeV2gzg9HPFXnQ4RKzUPbEnap4JfCrgxLE2RRhkE66MB/szpmXPZPO/zKi7Hd1Mbq6jDyMZ2dedNYwh2vGhq9Kxqc7+cIZQQGYAleLuu1ZZSeFqd3abDF7Vj9d4UI/EsWV4AvhWp6tAJP4LBzDc3xO9bZtNrmjMhKAC9A7iHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041380; c=relaxed/simple;
	bh=qoH56t7LT6g6R7/qe0J5UEvQjGQX9Eg9cPbyxQT+sZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kYI8p28fJKDaQ9A1mxuDE4Wgi9h2zmhik1QhOqupMAKFLXgpv4oSRolgErkOWYJjBMazRyEk8pxV25kstcnk9q3BWP1UhIiAZBFFbs5kihriNnCncnGZCSy3nj0OPQgo3ePMchSg4KBsKhrHzIsNugHxqGi1lXlOFecrUKakPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SjWAzHO/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjWAzHO/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761041378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Smx6c92DDCn6W6yHcZqgijD0yczmTJbxbgpAffJprT8=;
	b=SjWAzHO/aywVWg/VOUGQdvUjMsVs8Sug1r3GpW+hjChSDFxztqg6pEYvgCm9HAwX24k7Ty
	Rl6KJM00KqSsdAOT6IOombKrHCuIuhyKzBeMaejXYJOffdr15PeO0Wg2UnLE7jSWFRSdw7
	yAWrwxTbmMhu70mgi9s7q0lU0jcmw9g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-aKo2_eCGP7mfUW3LM0dMSA-1; Tue, 21 Oct 2025 06:09:37 -0400
X-MC-Unique: aKo2_eCGP7mfUW3LM0dMSA-1
X-Mimecast-MFC-AGG-ID: aKo2_eCGP7mfUW3LM0dMSA_1761041376
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-427013eb71dso5866603f8f.2
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 03:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041374; x=1761646174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Smx6c92DDCn6W6yHcZqgijD0yczmTJbxbgpAffJprT8=;
        b=Mj/zd9RqqMmHYNpOcebhZyYSshbfWdTuK6PZk+equFpbYzsLTExvtp/wNoOss1+FBA
         ItmCYan/D56sVClvRiNNUF3JwtXgDR26Aw5SOiJZAekwavRasSpT9tT25UMQlakqZZ43
         fKBvpwx8eo1iXkoZ1lBdAwVULsABqBPnPoAutdW2f6ANa460REdGIPikiTRRhdMUyGzh
         bff971b8JnqAenhYYvqUsXv5OmvRiPpPkW1N8Y/RqsFcLmoOxftqUTCupnuuF4toutxf
         nXonioBc6IkgcG03yP/zATtnWVnKY1PKsE6Wgpt0XrNAJenKRFcMUVDtiSDiIvGswUnd
         YTJw==
X-Forwarded-Encrypted: i=1; AJvYcCU5ed7DqhPBLcQMGg9tcEbnVcg0iCE7HNrioiAGUEkusbQbv9jcVzU/zNwpXf4Ssry7Qhhcrk2ueVkqg1HL3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKPwmE9HyluWNPyPSic6xV9uCrPQgRgBZUDtHoPkoxlbuiAXO5
	v59VWLD8MIZqN+E/9YsiULjAprA3yUTHMtPvSorkB6/FPbwsPVd3BDek/O2d1oYb48fdrlTy+PG
	KEcKnb1/NQjU0RN8wlXLhTw6p1thwY/up6Zmc4vsu6vvCp7c+/NnWXVXi72ZF3+aqLQyk
X-Gm-Gg: ASbGnculQqHPREK9cRux7+owqzyUpLOVmGj7WBlIEeqVpFwQw+Z5ntHfcwD94ZD4MOY
	M5SeH4q0XKi80lefG7K9jw6736RKzyR/6lDUJTtxUf+wOsw/ALctLkHNDqjwr3DeuDARcVRWEsb
	WZm6jUzmTvjtA1Eh3tPKXeI0x8JSWJwHCDhc2MdnmK8EGMqu+2sY08rNlXY1uJUpaNRngSHq1s5
	Ny3PrujpZSC27wMtxFp6twStppmY81HVz/Nd2WTstYfe4C6qjOp19hx/yCyTDuOkCqDx/DMoTTA
	Arw5mJCS1L+z7rD6yuTrWTNYxAf1A1hucrrn0uQuPC07+eX619FHZLnH9r/rWCiwCB9SsoHQj/h
	lfsqNW400NrnLbD54cj60yxdSg/lgyYREicmLuchHfrW69WDV1lI=
X-Received: by 2002:a05:6000:1aca:b0:428:3f32:a947 with SMTP id ffacd0b85a97d-4283f32a9edmr7496029f8f.58.1761041373987;
        Tue, 21 Oct 2025 03:09:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG3vsiZzr/8K6/PVlmWld696ekgX7HFbOE3sJab5hvSA8I4JhACaeH9zgeRKYP34Ujun0gUA==
X-Received: by 2002:a05:6000:1aca:b0:428:3f32:a947 with SMTP id ffacd0b85a97d-4283f32a9edmr7495998f8f.58.1761041373485;
        Tue, 21 Oct 2025 03:09:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm20168191f8f.28.2025.10.21.03.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:09:32 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:09:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	Michal Luczaj <mhal@rbox.co>
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
Message-ID: <mpv4ljrxyucr23x4hj7k7s4vmtvv3bgeq7uct3t44ghaw35l4r@wanp7mklhw7x>
References: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: qZpwgvZbGTAnyUODVOikD4bd2xt9vtkPNQWFQp_qwg8_1761041376
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Oct 20, 2025 at 05:02:56PM -0700, syzbot wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    d9043c79ba68 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
>git tree:       upstream
>console output: https://syzkaller.appspot.com/x/log.txt?x=130983cd980000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
>dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
>compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f0f52f980000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ea9734580000

#syz test

--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -565,6 +565,11 @@ static u32 vsock_registered_transport_cid(const struct vsock_transport **transpo
         return cid;
  }

+/* vsock_find_cid() must be called outside lock_sock/release_sock
+ * section to avoid a potential lock inversion deadlock with
+ * vsock_assign_transport() where `vsock_register_mutex` is taken when
+ * `sk_lock-AF_VSOCK` is already held.
+ */
  bool vsock_find_cid(unsigned int cid)
  {
         if (cid == vsock_registered_transport_cid(&transport_g2h))
@@ -735,23 +740,14 @@ static int __vsock_bind_dgram(struct vsock_sock *vsk,
         return vsk->transport->dgram_bind(vsk, addr);
  }

+/* The caller must ensure the socket is not already bound and provide a valid
+ * `addr` to bind (VMADDR_CID_ANY, or a CID assgined to a transport).
+ */
  static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
  {
         struct vsock_sock *vsk = vsock_sk(sk);
         int retval;

-       /* First ensure this socket isn't already bound. */
-       if (vsock_addr_bound(&vsk->local_addr))
-               return -EINVAL;
-
-       /* Now bind to the provided address or select appropriate values if
-        * none are provided (VMADDR_CID_ANY and VMADDR_PORT_ANY).  Note that
-        * like AF_INET prevents binding to a non-local IP address (in most
-        * cases), we only allow binding to a local CID.
-        */
-       if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
-               return -EADDRNOTAVAIL;
-
         switch (sk->sk_socket->type) {
         case SOCK_STREAM:
         case SOCK_SEQPACKET:
@@ -991,15 +987,33 @@ vsock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
  {
         int err;
         struct sock *sk;
+       struct vsock_sock *vsk;
         struct sockaddr_vm *vm_addr;

         sk = sock->sk;
+       vsk = vsock_sk(sk);

         if (vsock_addr_cast(addr, addr_len, &vm_addr) != 0)
                 return -EINVAL;

+       /* Like AF_INET prevents binding to a non-local IP address (in most
+        * cases), we only allow binding to a local CID.
+        */
+       if (vm_addr->svm_cid != VMADDR_CID_ANY &&
+           !vsock_find_cid(vm_addr->svm_cid))
+               return -EADDRNOTAVAIL;
+
         lock_sock(sk);
+
+       /* Ensure this socket isn't already bound. */
+       if (vsock_addr_bound(&vsk->local_addr)) {
+               err = -EINVAL;
+               goto out;
+       }
+
         err = __vsock_bind(sk, vm_addr);
+
+out:
         release_sock(sk);

         return err;

