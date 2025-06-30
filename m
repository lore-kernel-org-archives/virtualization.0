Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CD7291C13
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301198; cv=none; b=bODvZFYVbHcl6YJ1hLgEvxUqlCnEX1LBrIQWMjCg9PDFlqk8fXtwSy2qI/pj7COmd8HzZVrqt9KtepJgppRvuwEQWY8HhrR5iow90k2IU7smNa3aEWyTNKjHBbtywfcdxzOK/TEEiCQ7wAH5RqJgGn8N9oZNrFZpk+tQc9rng3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301198; c=relaxed/simple;
	bh=/1mZkg9E1CztpAIZTDXcSM72W7GdGrTSeNoLQv6fDzM=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=kA0uFxqyfjLqISKCiPDXtfEC+YehGZL34EgtJUmT0v+525DAPzKQljv+qlue76hWqjHx7twvPCweKDi3/Wnz0GE8bnYrNGD26tEPtm3rA+nziqY6C/WiWu0NwsWhY85ZdXwaheLF7NRTxP7IBfHcliQHExAtrzZ1own9ULGy8rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSmdwLcj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSmdwLcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751301194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTsSQg95XhUJtNWRtD1zSv7COm3LSbhhvPf6ApdLYIE=;
	b=fSmdwLcj0yJfO93cIIgVYx6paZ05ALpsHnRQj8+27JnyNLQjGAnDR0wa+Wf1euxl+8bw35
	dGuem3+CTTRQyu3jKKRSYcyJnFPiVDxeN9l7ye19IT91vm6QYKEC+3T2E9XB6FzWCAStp3
	63BSwLcrmxceECpnMnn3XtKbQ3me2vM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-8ybWAFjfM8mNh8XfQ4-3lg-1; Mon, 30 Jun 2025 12:33:12 -0400
X-MC-Unique: 8ybWAFjfM8mNh8XfQ4-3lg-1
X-Mimecast-MFC-AGG-ID: 8ybWAFjfM8mNh8XfQ4-3lg_1751301191
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45311704d22so16660855e9.2
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 09:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301191; x=1751905991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTsSQg95XhUJtNWRtD1zSv7COm3LSbhhvPf6ApdLYIE=;
        b=mwBOq94Za0WFSDky3VI5EJOFFLT8nR9+Dth7F5rHs+M+nIU8n32pDwOCd4afX8vqcJ
         BY06wkeMCI6KAdoVDCKPhPjA2N0KN09aFcOm9ESNyJ8iC/e5Lf+RDvttL8EdfKeWsEli
         ApO+9Qp/QPKW1NFR99izSLZ/U0WEsAyhVo1/e7kxVwltkzM2sqZFJNvTNzB7vtLVLP5k
         hAbYmeZzNvr1zPhNS2oHBi1T3BnPZkQ8khm2NZrEt88hWMr+2R8BPR8EJN4/s/c4gFuP
         R36pnRVKsVJpFqE+PkNjhxZwDD9OicWjC6SmnrTwldgXjJjYRjPd235vA3+NS0zg6t5a
         QrUQ==
X-Gm-Message-State: AOJu0YxswcLziRLczQ/eIn6ie0mFq2ptrIqeFPqdZMIBoW16zWnLixaK
	5BVgyKf/OQ0FQAynmTixaSFvaFG4T2M5vLXPmsVgX1cKFqFizlHXs6vh18xhEwC6YTkvEELPRmZ
	PVKTUMyWVXb1NYm/S5fo2pUwacW2xbrFUFQ7fW30j6exnckPjRtF/rxDw90fxqcCmMJQM
X-Gm-Gg: ASbGncu17sDlOzDzJ8QZekJKBgTibDuWpUuFjNracAAAy5kflbPRn+kyNaVRWTWdarw
	WAzQbQkcLmkunS0+aB8mXwVMQBZtsodgCgnVkBHzw2DJRJ0/+++qWnAke4b6V7+g+qVGAxySxKZ
	WVDyifaG0T6s+lNa3MpvCKVT14QmP+FW/J/r08CkoMfvWBvoaLu5DwllSjwUrN2nDycUCvvODDn
	qY/PxgqGhOcJXyE5SruKYZ61YW++F7NBlSkhx4Q63oDiDUIbDjrAuF81mKCVCrtxNOVaB7OMXkY
	JDUFIz9VuZQUKzvMvVvcnjulkz0ISXhyIUGU12gJae2psfbQL6PusA==
X-Received: by 2002:a05:600c:5298:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-4538ee61e72mr107704335e9.20.1751301191458;
        Mon, 30 Jun 2025 09:33:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfyROXvO4meZTA+eBrF6ZQx2AlPL1v9K81ASsw27IwZVehxZ2JH+GDPwndnAfiwnao4RKYTA==
X-Received: by 2002:a05:600c:5298:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-4538ee61e72mr107704055e9.20.1751301191020;
        Mon, 30 Jun 2025 09:33:11 -0700 (PDT)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a406ab6sm142554375e9.30.2025.06.30.09.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:33:10 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 30 Jun 2025 18:33:03 +0200
Subject: [PATCH net-next v5 1/2] vsock/test: Add macros to identify
 transports
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20250630-test_vsock-v5-1-2492e141e80b@redhat.com>
References: <20250630-test_vsock-v5-0-2492e141e80b@redhat.com>
In-Reply-To: <20250630-test_vsock-v5-0-2492e141e80b@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: puR4RQRw-xa_Jt44ZI3WbL-wE1RZ-RINzksIVkG5zI0_1751301191
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add three new macros: TRANSPORTS_G2H, TRANSPORTS_H2G and
TRANSPORTS_LOCAL.
They can be used to identify the type of the transport(s) loaded when
using the `get_transports()` function.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/util.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 71895192cc02313bf52784e2f77aa3b0c28a0c94..fdd4649fe2d49f57c93c4aa5dfbb37b710c65918 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -33,6 +33,10 @@ static const char * const transport_ksyms[] = {
 static_assert(ARRAY_SIZE(transport_ksyms) == TRANSPORT_NUM);
 static_assert(BITS_PER_TYPE(int) >= TRANSPORT_NUM);
 
+#define TRANSPORTS_G2H   (TRANSPORT_VIRTIO | TRANSPORT_VMCI | TRANSPORT_HYPERV)
+#define TRANSPORTS_H2G   (TRANSPORT_VHOST | TRANSPORT_VMCI)
+#define TRANSPORTS_LOCAL (TRANSPORT_LOOPBACK)
+
 /* Tests can either run as the client or the server */
 enum test_mode {
 	TEST_MODE_UNSET,

-- 
2.50.0

