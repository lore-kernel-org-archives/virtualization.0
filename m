Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66A3372B57
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781239964; cv=none; b=CPkGtaOzDYdZj4L2VLu4psul3H18nApzgPKpY/34lV+3tFhGY5FpS6ELLhSg7Nb54NG2C0zJDsUZd9RYFo7j+PYfd+Gt1ydeenQVTH9OvvcKK4PVMwxhe+jCy7xl29G/ijLFKBFDpwRcql0W1yU5C0u1Gvv7n0ZhqXBQfQb3c2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781239964; c=relaxed/simple;
	bh=zdaEu/0sGHSxLts/pXqiH8HAfsnfc5XaTao1qtpd/l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E80jaoTspuks2S3H6usEDfOBNQA2lAZBZPTIY4//tBvLxxBQmVGeXA0x9Q5IxrNrnwXDLM/6+SKWOG3UBaJEg5aO3KbF7BNBzG3JhSUx7DchuakYOJ8MHUk12hqKxe0DXjCHzBhUbALl7lfJs0p8X/a/DsjH+4hVg9Dr96kJQt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFqaDFiD; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFqaDFiD"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c857fba35cfso247793a12.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 21:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781239962; x=1781844762; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHhZvAyUhq+bTu4qJb4yo1RwwXiAsC79cYT+Ge8q5D4=;
        b=YFqaDFiD1KmQFgH/K+bhpVudKSi5di8RVRBVTw2S/0fdiEBBUbAnLd4EdEXug7Y65O
         tDMz/9sK9I1kUwRm7DGssDPj7kB3uQhvM8KGzu1O5QPHnZrKDv0WX6nzMu+4Flx/MsiP
         Z9R8G3aQh7KSveIMGH6DnwazOXYIjLLvka/qBsPEvlk/nyURKO+0EgIPpe0HRr8cZ81G
         20vYfaPTNxTexy6Pdzfx3jHILvAfhXBJqT/OrYkM6bWntkgoiIML1yXEcYQ80/6bq1iZ
         kex9OK+Pw5f60YucMCcjT5e7pelQBy0ThDYHDRGMsh0py5i5PIdT3vDSvq+znuqt43OI
         OnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781239962; x=1781844762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HHhZvAyUhq+bTu4qJb4yo1RwwXiAsC79cYT+Ge8q5D4=;
        b=Xp4QPxidww/WzeKQTOidnHli5qp1W7fBrnzK38tpEl1hnwqCYv/yD91TH/Yz32/rrW
         39SKmBVe7SxkCXxaP4MGow4WEhsEpT3hQ6jW6OzTSZ9Vm1B+izfl/3vqbYkAAwcTa1XW
         G16D4ZO68BbtN+oQfRZny/IsQ6hecPnQme0Qmqcoi8IsWRG3zb4uonDBFvJGXsdp3bby
         fY7M3ohA2DeGgOkGztvvWPHPuLPegBD+zsYIne2pgokHMDNN/VDUHB1QdgcxtW93cimN
         slnnplMJhJb7HpOIalyzAKhPcuxnAFA+Z24AKRK9u2P7nJOkQmdJ/zUaGGTK+PoFDjSE
         ketQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NCfgBe8W3Z9jtLBHcJs8/dHE5E3EkfaI1xBxYZ5uc+oT4NIeO0wxitbiKtsw/5OaUbczSm67WRqthLGVryg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKLTp65R7USG3OSRxeXVLyO0bwpMeV1UtVQhA6cSxHjIixTTiz
	HdhT2BHv/GjBDbymC5dJKdzd9So6O+uvJaG9QrZ84VDX7J0nK6O9lDQ=
X-Gm-Gg: Acq92OGD57x6JP1yxDJxvZgDJPjWI92VPYmm5ANgW5YnxHRPu78SVOxfWM7IxJHxV1q
	zYpuCHqoooxfsLHwbptdivaVCI2R8+VFMdV6DNz7xfpSpSRPxUCvtbqTZgGN9FzmksG0iK2cyZW
	dI07xROon+wqyxfvfuq3XJHREY1eT1BunsbYNmoUibCmG9/2fAWQ1bPt8u3IqLrrFkDN+tls9di
	c5X3EFNMyF5DVMepQZ+jiinR8EWdQczXxNV0nDSKA0178ojdzYphlrJhdhR1bOkf95Ko8UDinxH
	fVqVigKTjgVAiExw0UK7zrmk0cFGAPP8b1MqTZz8g9MCbJSNDC+nHHJ14WRqXXrQsS6PCIrBXB6
	uwK6q9b+LUtue0PEJ1o1duKpqBMDSQIQjbXF/2RkL6e1WazJOlXAOXGjLkyws6ykU5fmEEMiSbH
	k55yg9YelqlhZjlHvK+xqIaBvUzCr9Ut10D4ibf/nqABjv73JXIukc0xlPX1XdEsaf7/g=
X-Received: by 2002:a05:6a20:9f4d:b0:3a3:327:c5c8 with SMTP id adf61e73a8af0-3b78356a9f7mr1582389637.0.1781239962240;
        Thu, 11 Jun 2026 21:52:42 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm827558a12.5.2026.06.11.21.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:52:41 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com,
	leonardi@redhat.com,
	horms@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v3 2/4] vsock: fold sk_acceptq_added() into vsock_add_pending()
Date: Fri, 12 Jun 2026 04:52:14 +0000
Message-ID: <20260612045216.105796-3-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612045216.105796-1-rafdog35@gmail.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move sk_acceptq_added() into vsock_add_pending() so callers cannot
forget it. vmci is the only transport using the pending list and
is updated accordingly.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/af_vsock.c       | 1 +
 net/vmw_vsock/vmci_transport.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 1f94f0d44c..6cfa89b6f3 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -483,6 +483,7 @@ void vsock_add_pending(struct sock *listener, struct sock *pending)
 	sock_hold(pending);
 	sock_hold(listener);
 	list_add_tail(&vpending->pending_links, &vlistener->pending_links);
+	sk_acceptq_added(listener);
 }
 EXPORT_SYMBOL_GPL(vsock_add_pending);
 
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 635ebf9da4..c2db016cca 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1109,7 +1109,6 @@ static int vmci_transport_recv_listen(struct sock *sk,
 	}
 
 	vsock_add_pending(sk, pending);
-	sk_acceptq_added(sk);
 
 	pending->sk_state = TCP_SYN_SENT;
 	vmci_trans(vpending)->produce_size =
-- 
2.54.0

