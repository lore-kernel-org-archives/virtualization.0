Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50F826B2DA
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041787; cv=none; b=oe0lfsL2Bl39k2P+AZoLjftS+MOApDTasWQKBfGKnIQv3BHuaZZ52ZuJsEyMlqrL9Xb78Hs4njq3+Qu1pNewE0P3Y7WxnVDOcOUS5q3aK+l+b7u16F+DHls5qQCPWs0aQrf7kL3x1yoqPcZP1N7Kqc9jO9W8YRdiGgufKwBcVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041787; c=relaxed/simple;
	bh=j/tykCLYMVPv4okg4jOLs6OL2zbPF97MyTVI2DDLQU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DDOIvAJRmlosjx7F/VCd/dSFCof6BDY7IXHR/i5jZ8U1VO1Kg17Uz6AkDW+wEvDD3OIUasJuvStsWn2RvzhIxjNxhO2NPEqEemksrVv+XwYRcaAQGdBKXCI2wf4F02YZPIL94Uy0CVpxh3okV6M9lKiOieINIykeNRyb9EK1emE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTryhe7G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTryhe7G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761041784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=38nSAhbfi4ehpjgsufWbpogOPVTna/oXQfCfSbQLrsk=;
	b=BTryhe7Gc76kEQIq0JKRrlFzIDXg1QcDdjp9Xjo65cIBqlG5sAoJue0jfTSJcPAIVeGuBy
	3dZJ5Un7Brskv6uDNVHvhtKqtHGdwnvtsY53q+n2Uw1Mya79v5Jslxh0iFewUamIQ6NOd0
	W7BRT1CA36E3LjTpiQiUE+xm558Qoe0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-EfZcsbVgO4ORrunKSdq44w-1; Tue, 21 Oct 2025 06:16:23 -0400
X-MC-Unique: EfZcsbVgO4ORrunKSdq44w-1
X-Mimecast-MFC-AGG-ID: EfZcsbVgO4ORrunKSdq44w_1761041782
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-470fd5ba449so18331465e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 03:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041781; x=1761646581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJYhMYYkH+gP1AV8KxmcpA9zINZajsuC9HdWMXBqSjE=;
        b=Lje+XXvRs+zpltNiaotu+BoYa3P6mS37i00bpzNmJPx9H2S7+5khBWOUCxjyGU+JRS
         qWCYgNSGdM1jiF9k9i5NGFJi6ff+Y8rnOailEmPVeDBDHv5jMHGXAfftlWjRKw1N2R5x
         gHx4DHBXwqJDewDriew4d+NhjECuAMxnrgovW88qGGyMNa8xF/Ch+n5Sc1aM/vBi7cdx
         OqW64bYGOefoha/sta1G6614EWxUPwXGGnZsvLaBCQgxJLsO7ulNGV5xZUyOFLTjZ9MT
         aFK+2wbOLkmzvEn5HK7ORrRv9O61e0rmujhKKRwuvXrHC4HU0wIGEV1YDKyflyfVgGst
         vXJA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ6qO6G1RWSJDmc88IkCrGubmXTj2dge7J9wugQhhBlZXA1o0prPai46Az1zjMySNopRUv1ALdK2sLrlZpvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8pxb84R1ZLq4RojlqBbVOtoQ6Xm+HnHoVl5br4gb8pt/H4g/W
	KoAnFQUgv1SgSzA71no4q19oTrkUAQyyw1r53xHPpkTYIBus/fbhVSew4usqEKs08EwBay2qc/j
	1Ax2F8pJrRAmpCVxrO3y8Tir9cTLb6xoMf2RAeZlo421ZzZ62qO3VifRT0owzFwcFCY1q
X-Gm-Gg: ASbGncsKUoDx6o0a0XF3NL/FgIQ4edZlixbmnMinZuSTGi10astsoUEqmlIsSYqhpe4
	kFCIr/6Uh0h69mAF0rlGt/qWsOxw0lCRK9vZpyfqATU28i8fXENyAg1XGoiw5g6WkiFedudRYZw
	D7nN5QdsnkJ1ru/19tYxfDe/5npwvZzXVzBHCqr2Oyk/Pw+ikLHQEBdtl27qMw8dRPqWE+fjCyM
	umwqzAwpDpMW5K2d+/wmBpIsNSFU0ZmlsrF1hqz7aOqLaJ0o7yuNoSPj4e949FUowK9D8iovDqv
	MmAZaGFiqkSMnSSQsn37KIaYcoZC/fiIayB55zbZXRs2vucIg+e03zMYqb+vA4sbU6AGrFI2eSt
	79UIKCL4gh0NdOGuqZuEhIV/2QEf5IgJKKQKV7comOW4e7J0C/OU=
X-Received: by 2002:a05:600c:a088:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-47117315d8emr128167575e9.16.1761041780843;
        Tue, 21 Oct 2025 03:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi58yEM3Ci3GlIQ7LRsfZT8Jz32v9v6BKO98V35kuEXc5OOA/pGgs/FK9jj1Yuy4hgaCi++g==
X-Received: by 2002:a05:600c:a088:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-47117315d8emr128167295e9.16.1761041780382;
        Tue, 21 Oct 2025 03:16:20 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c82c9sm272580385e9.14.2025.10.21.03.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:16:19 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:16:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
Message-ID: <u6mwe4gtor7cgqece6ctyabmlxcaxn7t2yk7k3xivifwxreu65@z5tjmfkoami7>
References: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: OnaZYhFae3ZxXIA9rKDQDetG9KZ0PxNZqgd1307Z3eI_1761041782
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="ixrysslziegqmao6"
Content-Disposition: inline

--ixrysslziegqmao6
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


--ixrysslziegqmao6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-TODO.patch"

From c32c21ea301aadc56160a57ddcd99f836a49f028 Mon Sep 17 00:00:00 2001
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Oct 2025 12:12:24 +0200
Subject: [PATCH] TODO

From: Stefano Garzarella <sgarzare@redhat.com>

---
 net/vmw_vsock/af_vsock.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 4c2db6cca557..5434fe6a1d6b 100644
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
 
-	/* First ensure this socket isn't already bound. */
-	if (vsock_addr_bound(&vsk->local_addr))
-		return -EINVAL;
-
-	/* Now bind to the provided address or select appropriate values if
-	 * none are provided (VMADDR_CID_ANY and VMADDR_PORT_ANY).  Note that
-	 * like AF_INET prevents binding to a non-local IP address (in most
-	 * cases), we only allow binding to a local CID.
-	 */
-	if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
-		return -EADDRNOTAVAIL;
-
 	switch (sk->sk_socket->type) {
 	case SOCK_STREAM:
 	case SOCK_SEQPACKET:
@@ -991,15 +987,33 @@ vsock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 {
 	int err;
 	struct sock *sk;
+	struct vsock_sock *vsk;
 	struct sockaddr_vm *vm_addr;
 
 	sk = sock->sk;
+	vsk = vsock_sk(sk);
 
 	if (vsock_addr_cast(addr, addr_len, &vm_addr) != 0)
 		return -EINVAL;
 
+	/* Like AF_INET prevents binding to a non-local IP address (in most
+	 * cases), we only allow binding to a local CID.
+	 */
+	if (vm_addr->svm_cid != VMADDR_CID_ANY &&
+	    !vsock_find_cid(vm_addr->svm_cid))
+		return -EADDRNOTAVAIL;
+
 	lock_sock(sk);
+
+	/* Ensure this socket isn't already bound. */
+	if (vsock_addr_bound(&vsk->local_addr)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = __vsock_bind(sk, vm_addr);
+
+out:
 	release_sock(sk);
 
 	return err;
-- 
2.51.0


--ixrysslziegqmao6--

