Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6B230BF2
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973434; cv=none; b=Q8J/kgW16XFXEG+j4WQsvbJ4akWhrs/R/q8oNlikD+gomM+0lkcssV0f4F7Z9lh+uKC8iQrM2s+K0Pu6YGPFsxZliqYh2cej+/hJtpv6LGT0SrKfeBxt8ZxHOlvFccfFkjEeGx9fMmJtVKl1WUY46IpxPmbi9+IjTuQ0HxmNYRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973434; c=relaxed/simple;
	bh=SW4IfHix+f4Je4esfBdglGbT4aI4+HKwBw41uiZTcKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=mPCHJmeYAV0vRkvmxmSskCt026RPKN9HLkyi4ewUsYjE1mPtjhG6ZaYDphWdVXCKQzHSxffyJW5fj1eAVLNxS5L9/wC782yanpX3MdJy3rSqOXVlJMNg23pW9OE2jGyNju7KDRf9Y8yiz95TXgl1XRcJdvUOXDpYOhpByE/baTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwLymmjy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwLymmjy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751973430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hLJpDQTyK8jsS2YvDzZqaAeQiFLy072zwpHz83Qr2vg=;
	b=YwLymmjy7ZZat8ggC+aZPcZOi5UPbPzn2Xvim0WS12SwxHfNH75NQs2oH1+aXvsXky6KcO
	9Y4Xc3yeo0x/66uGWCnojwmBwYsr4VRzt0ZH5fRMf8PGn58zMLCMAQGGzhEXBoobjZZAAD
	rI2VYQeeOZaXlOriwcjd3U+15FXwzHA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-oqB1VFmVPymZKiEAHg_Mig-1; Tue, 08 Jul 2025 07:17:09 -0400
X-MC-Unique: oqB1VFmVPymZKiEAHg_Mig-1
X-Mimecast-MFC-AGG-ID: oqB1VFmVPymZKiEAHg_Mig_1751973429
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb3bb94b5cso73777506d6.2
        for <virtualization@lists.linux.dev>; Tue, 08 Jul 2025 04:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751973429; x=1752578229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLJpDQTyK8jsS2YvDzZqaAeQiFLy072zwpHz83Qr2vg=;
        b=NyQxFcwcatKsWENEDpC5rJKGNNN0sKOs4i+3Uze7jCRypTzD+kUKp0QD7y5qwtnmiZ
         sKWXfHfO/65gIEk4eQTQ++SucGPKnt8YoP8xr8n3Ka68yogY0rdIC2KOK5iYorwN+bEA
         lN6ddkTcmMzfWgFmYop+3uCEAsxbn268ZI6mLqsRKzKWNFe9WaTP298DS839N/Cxo3H2
         Oy6GsmrThiREywo8jGNfsM6RioSzbWFbWEdhIAY5kItjKxS3g+U2Jmx/1t1dRjiZkmgR
         6KY5sgo0AIQcYPCSh3HPllmmZ8sKyfG0wJ2N0+2I1RGzmA+grTNwW1ZQhUMGPL0VNGGF
         Y5PQ==
X-Gm-Message-State: AOJu0YwJsv1Vdx+P/0/pYilbBSj0UucikUvfXQALy0COFbfEt/WikV9K
	9d7ONDtfTPCj0AjSGV6wi6H5IbVFIcFJQC/hMhVIY0B2jUmqziyfEb8TYMYWQoy//QruDiDKJkD
	moC1uuHWxohxF5j8hrIoSBW3UcqGiwYWjhZF/boNO8/BGKTv21eIOwp1AxEG1kt3FEiya
X-Gm-Gg: ASbGncutnmvtrkOdVW4vkq6N8UmwpwJVJT7C0IaN+GGQjtpPGOtfqanh1kBSYAZcWUn
	700fXa2gzXR+gjiqSevJrXo40zZW+YV1yQYloA9S0o3WK8/loC3ro47ciiCvJJgWYbnluOWCNhs
	aLP3s51MjbyVH2RTnUYOwMQIjk2FGSPk3qsKRCefRZfYkTl3qZ+yn9/96IihjRs3iWbtiDgAA70
	Z0VIn3Jt2uF6HhfGa1+FPgf7dDezWw1JGG5grJRU+dkjQv06al1Iew/Nfm5LDfm91GpQY9MrHG7
	Im8ERPyCNo6Y2FYpf0KrX2xqZfi65g==
X-Received: by 2002:a05:6214:1c49:b0:702:d9d7:b6e2 with SMTP id 6a1803df08f44-7047daea654mr37844136d6.34.1751973428728;
        Tue, 08 Jul 2025 04:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmdZdg7FkyHCs2tm7yZmuVxog/GLdnlBjbdngjYdDrQNIKIT5juBSVSyb2m4opt+Qg+0n1ew==
X-Received: by 2002:a05:6214:1c49:b0:702:d9d7:b6e2 with SMTP id 6a1803df08f44-7047daea654mr37843036d6.34.1751973427927;
        Tue, 08 Jul 2025 04:17:07 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.147.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d5ac2csm74424756d6.95.2025.07.08.04.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:17:07 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net-next] vsock/test: fix test for null ptr deref when transport changes
Date: Tue,  8 Jul 2025 13:17:01 +0200
Message-ID: <20250708111701.129585-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8prGgkhAvV1S3ecXR4Unio6_2SxxGEiDN8eTQbRWg9g_1751973429
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

In test_stream_transport_change_client(), the client sends CONTROL_CONTINUE
on each iteration, even when connect() is unsuccessful. This causes a flood
of control messages in the server that hangs around for more than 10
seconds after the test finishes, triggering several timeouts and causing
subsequent tests to fail. This was discovered in testing a newly proposed
test that failed in this way on the client side:
    ...
    33 - SOCK_STREAM transport change null-ptr-deref...ok
    34 - SOCK_STREAM ioctl(SIOCINQ) functionality...recv timed out

The CONTROL_CONTINUE message is used only to tell to the server to call
accept() to consume successful connections, so that subsequent connect()
will not fail for finding the queue full.

Send CONTROL_CONTINUE message only when the connect() has succeeded, or
found the queue full. Note that the second connect() can also succeed if
the first one was interrupted after sending the request.

Fixes: 3a764d93385c ("vsock/test: Add test for null ptr deref when transport changes")
Cc: leonardi@redhat.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index be6ce764f694..630110ee31df 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1937,6 +1937,7 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
 			.svm_cid = opts->peer_cid,
 			.svm_port = opts->peer_port,
 		};
+		bool send_control = false;
 		int s;
 
 		s = socket(AF_VSOCK, SOCK_STREAM, 0);
@@ -1957,19 +1958,29 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
 			exit(EXIT_FAILURE);
 		}
 
+		/* Notify the server if the connect() is successful or the
+		 * receiver connection queue is full, so it will do accept()
+		 * to drain it.
+		 */
+		if (!ret || errno == ECONNRESET)
+			send_control = true;
+
 		/* Set CID to 0 cause a transport change. */
 		sa.svm_cid = 0;
 
-		/* Ignore return value since it can fail or not.
-		 * If the previous connect is interrupted while the
-		 * connection request is already sent, the second
+		/* There is a case where this will not fail:
+		 * if the previous connect() is interrupted while the
+		 * connection request is already sent, this second
 		 * connect() will wait for the response.
 		 */
-		connect(s, (struct sockaddr *)&sa, sizeof(sa));
+		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
+		if (!ret || errno == ECONNRESET)
+			send_control = true;
 
 		close(s);
 
-		control_writeulong(CONTROL_CONTINUE);
+		if (send_control)
+			control_writeulong(CONTROL_CONTINUE);
 
 	} while (current_nsec() < tout);
 
-- 
2.50.0

