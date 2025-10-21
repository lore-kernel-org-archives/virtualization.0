Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D325A659
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044355; cv=none; b=R5jS2yHK8hXOPtZrW/Exew+jJAEAjdRhH7da2y4/jdfcWmBya++AWYG5P9+TZr69eQxNa9W3TBwOSkDwtV3OXXIyJxgt7OGh/Pe0zZbmEwhAVM6TVTkDWn/3T4hjPlZ7LGdTrKiAzB1dwYDA/wAxzKL24V4Qo9id3fAif3foxlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044355; c=relaxed/simple;
	bh=zJsh72s9qAO57ew78vLDqGVvhctpyptn4B35fvtLOgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HigdUrvw7S9WdK6yFD82v8kn/r/kfZpk6FneQM4pNiPABfF9wxxdSd0sJc+BFQsrDpfvg5jAILxuhFmUbx8e/rUyhryaJY1kZhAgUL3ThVSFtZXfBTYlgk9JTAi6w+qKS1qTVSdOeqRM3vYr02hbVvY1H0it75+QtG5gw0Yz61o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVjyBg4q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVjyBg4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761044352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTUz+fu5sH1+ixG7wtLTpUgncyrxFE7aBKVNRCkg50g=;
	b=gVjyBg4qmFGSUyjY9HPvFfkQw2qxfLW8RteYenstcjpE5tBQpRzao1FZYzC5zs8lJMtkS3
	4l9IqVmtYL5nQnA60tkRiB/f96LkETIUb3SOEe295/0W8CVO1z55IYyujj08uR7e2nqtv1
	jI3MqrzcS5oQ3+pg4mvDKKJENH3l00I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-HBjywhGcNRmW_526X5325Q-1; Tue, 21 Oct 2025 06:59:10 -0400
X-MC-Unique: HBjywhGcNRmW_526X5325Q-1
X-Mimecast-MFC-AGG-ID: HBjywhGcNRmW_526X5325Q_1761044349
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46fa88b5760so18519985e9.3
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 03:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761044348; x=1761649148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLu0P37OAGAyXjDXsy8rw7Ys47RNWwlPbkWxUF81WlI=;
        b=H8cgH2QUounOphb4ILC9p0VW9TR67tGQfrnt3DNm08fRn+WTBzhBF52bGJI76sY6ga
         jGL2qp4QdCrLpKmXX/KyBYHUNpU6KbZR7MszN5jW1IOkE3ssT+i7Hp8p2xWLDKs8bqKa
         Baoujn4oy49OCVt+gmqud1ZOzmAqYVrf6TmvfblWn6WwKjk58ut9XiQ6FrT+pihVrkVv
         OB+ghfH360ywqjH8GcsBG6hw6QWGB++KfjbifVPosd79fRBCswiYrn+ABk99P/BFYfup
         rYJwWL1dori6AOyYW4Uu1/7pmYRN1ViN7/D/8HcrH32mhd5oGz2dycpGCXBUhhD3PMf3
         pOcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBibvnhTYPGS7B5LIGQNxZpLO5yzZANzMtaHrEa5eoHybT7uKSML3CKlPW/31j1jE2vwiXDBeJtuIKQ5qeuw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf8MDtoCu8ACQaL37YgyvoE8Us21WKyBVvnOrIzcCuZuMQxJ/y
	0j73WxigD9+5rd860KuWbrtuzMOuV96eDKuOjx+LUXFvaY94zq2RSZ3VVdyyX9b/Rmt+CMOPkhC
	TNAB6+7lHnvEbgAin66Z0nZ3Rj1dMJCPfIH3FzKXFsjZpeK+WDTewQviCuL4PENgNkn36
X-Gm-Gg: ASbGncu+aIsrmwdVgAtDnzYUBuZ1FX5xdfo4gic1VU3c/7hyvZTdoWut/jvTRytQQ+f
	6MyWfwPh1TYJoogMtOhWKDAh2n2wwV1E18KBumchn/ckYcKxj1sKNPa2blQRFd+W6isB8ysWcYT
	GQxHPD2EKJ9h4oKkblp8CvslGXYUkoYNS9vne+UcKmEYdoJxB7ekDqWgP+Eh7rAF1chYS8Uw7Iz
	b5F9C714v1SD9rFI8mRSxz+W5HETeNrM9iEgbPtmWTgFw9OPkuVQZzT6SmpKBwCQvfKUivCPsf9
	h2QFIbf0p4MAB44YJC7cufpK/2+20+H5Nue77R92DqlxdJEwY/uxkGttLq7p34M6nRPPZLdQTi3
	SaNdjFIRkn1fqq/3WI2Ch/1St4SV8q8dviTUUlHCwScgz+q8VQ+4=
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id 5b1f17b1804b1-471179041b6mr123011205e9.25.1761044348698;
        Tue, 21 Oct 2025 03:59:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElT2F8lQ+p8bxtIuwKf2xRtiJ6w0kOux1TMQx/TUc2Rs90xo8tgHVCnbIlBYxYvSBRdYtGnQ==
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id 5b1f17b1804b1-471179041b6mr123010905e9.25.1761044348244;
        Tue, 21 Oct 2025 03:59:08 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ba070sm20000648f8f.42.2025.10.21.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:59:07 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:59:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
Message-ID: <jms5wjabuhoohobldv4zzfa6gurpnbw5xb5ejeha7md4z7atpj@r5b7mk5mn4n3>
References: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: KYOHwSTFR8V-npdTYxzlvm02JeUmbbN9m1IHzL5PDao_1761044349
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="smrpmekyls2luon6"
Content-Disposition: inline

--smrpmekyls2luon6
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


--smrpmekyls2luon6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-TODO.patch"

From 456534cbdbc7312fa1cddfb7aa50b771725c0a53 Mon Sep 17 00:00:00 2001
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Oct 2025 12:51:45 +0200
Subject: [PATCH] TODO

From: Stefano Garzarella <sgarzare@redhat.com>

---
 net/vmw_vsock/af_vsock.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 4c2db6cca557..89b4dbb859a5 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -487,12 +487,26 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		goto err;
 	}
 
-	if (vsk->transport) {
-		if (vsk->transport == new_transport) {
-			ret = 0;
-			goto err;
-		}
+	if (vsk->transport == new_transport) {
+		ret = 0;
+		goto err;
+	}
 
+	/* We increase the module refcnt to prevent the transport unloading
+	 * while there are open sockets assigned to it.
+	 */
+	if (!new_transport || !try_module_get(new_transport->module)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* It's safe to release the mutex after a successful try_module_get().
+	 * Whichever transport `new_transport` points at, it won't go away until
+	 * the last module_put() below or in vsock_deassign_transport().
+	 */
+	mutex_unlock(&vsock_register_mutex);
+
+	if (vsk->transport) {
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
 		 * have already held the sock lock. In the other cases, this
@@ -512,20 +526,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		vsk->peer_shutdown = 0;
 	}
 
-	/* We increase the module refcnt to prevent the transport unloading
-	 * while there are open sockets assigned to it.
-	 */
-	if (!new_transport || !try_module_get(new_transport->module)) {
-		ret = -ENODEV;
-		goto err;
-	}
-
-	/* It's safe to release the mutex after a successful try_module_get().
-	 * Whichever transport `new_transport` points at, it won't go away until
-	 * the last module_put() below or in vsock_deassign_transport().
-	 */
-	mutex_unlock(&vsock_register_mutex);
-
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
 		    !new_transport->seqpacket_allow(remote_cid)) {
-- 
2.51.0


--smrpmekyls2luon6--

