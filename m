Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0CD2EF667
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090442; cv=none; b=gq9Kb8miRVC/w8GMrzmFF81RtaYDyjSA1SkVfpVpp1ZOvL0Ul+OHoYjAPozPJS2jKxU426cFT5GRfCFJTP83w/pYEnAFrGGa6r3hCCZRhUrqORuRZJhKiYeA/ujqInEEePFzK1+DNNUV5mrQQJWpYDqaAbqoZVxiCrB9JLuk9Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090442; c=relaxed/simple;
	bh=MF/czfrq9R+gzUXq3nakRInrzOwnmvgXgQyREpFMOsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgrK+n3bKuc5NtMu7FPlBHZEEIw15zMr1UYLUyiTNoqqiYuf8OTZ8ITui4qPFD4Ugd4J4fH6YpBhpUes1D10RRbdwwiJNxJ144Sla8Hwvnf78SEgQpaHu33OU2aBfizt5msuy8FEmU9QBc9d6ttcEsVMTICHYfKdv5nFCZnXStQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0QYIVQs; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0QYIVQs"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so5349991a91.3
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090435; x=1761695235; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6mUZMq9SVTZCVxtIiXitg02c6DGfDqdmAO69aX2eA4=;
        b=S0QYIVQscNEV3OpK79oHoWd0DdJ7uzshqeGZRyQjfWs7POt5h/0W2+TAUp7npjcPr3
         qqfrrj0JcNMLNqtLx0t/ehhJ7+NAvYYcCgFmDvc/4L5pQzrvUexfxssd2jMuNqzVu5WV
         kaxtk9qY1JsbveBZbzjj7dvs8cpddFfaSIIw0ZWDdLUR0enFH5u0OzFmxrv2jku5ocEx
         hZasKLkKyI1FyemRy+ZwZ7dD7+zhbCHGKgTVlauwMCRVKsiPY7uIVvrsYcdDKwel4tAQ
         GIQme69WNUVJhaYPP/K8JhVBhlJRYX9fd3hWvhC/m1hMBWBrBy4Rvf6Qwqat+IOdZaoo
         ooRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090435; x=1761695235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6mUZMq9SVTZCVxtIiXitg02c6DGfDqdmAO69aX2eA4=;
        b=nleGJRGrl2/XHupyuQ49telUlvJZEFeWPxPap1ICqA7s7f7xF0Aaa6XHm7B1hTothA
         xxGk8NUsgQPA1AHmYn4Ry4l+dPtZqgEN7A6RKcwl4zpLDXQuvcU7Mh/FkFcfEfUIGS8T
         Jt7JnRRITPgiCOW9ORdqQ45KMLWOa7vahGMKRo9RKC04x2+8+7+p/apuYKURvJ/fi4qq
         iWJvTzafAuPrSjIYOCBWspfM+tiaOh8lc32SIUaxns5H94g7+C2Zfx2tRZeIyyV8BnRD
         SNhcdN972WNW6U5M1Bbp/998f8wQgbfcBzzdk3PFi4jR/WPMfz+w9tUq3/39CpQlcUUW
         aIRg==
X-Gm-Message-State: AOJu0YxxVAVJwVCwEp5ZEsDU362iIrYJloB+HIP1O8EoyaKOmdOBCRT1
	WpheoyUzPTgNhkhvkQdv5Xo7yJP5zbSEnlTDXQ3PDUojYFqA4dzIFx48
X-Gm-Gg: ASbGnct/TuRuUgdF7aQrFBCWi13CyUht3KomPhM0Uh5RzVE0UmR/mz7IFVQUXA9GiCs
	a4ufkvRbusdQYxfaydV0Ekb5EZbdKUHjdri5HEZcm2OkoKmxx+NYDbIGK4LA5KdA8JXQUL2bDk2
	KgJPNbiAA4EA/CRsx8SZKehf4JFH5t6geO27hMokS/hvZtkawdMxAodRPzDqCw7QNPm+WYGOunl
	1bvWdlNuTPenVzDcQFUx1Bm8EzsG97/KjVHnpUWb3Gd1ZsZ+uFvVOVBm7Pi62TOo8cSjGKXBlYb
	hNehV57Hpso9U7RynqHxDL1Ih+EIISYQkyJ0bbtojBO85LczmIFfA05pZgsrNk+Xr9nyBq5TAl4
	8NoynaJ1jCnC7FPdmxn1rCtVGjmT+LIuuqAVVFIETmmWWu3OeEjrprjDjnwNP5Iub44ZtxDqM
X-Google-Smtp-Source: AGHT+IFVbMkOuOiBDnCJEvlMwLaZ7DlmhKs/V/NW1acHbQ/gNGtWZNBni32L0tz8fkkeIan2KaLV9w==
X-Received: by 2002:a17:90a:d60f:b0:32e:d600:4fdb with SMTP id 98e67ed59e1d1-33bcf8e61b8mr21858888a91.18.1761090435179;
        Tue, 21 Oct 2025 16:47:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223e223esm711430a91.7.2025.10.21.16.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:00 -0700
Subject: [PATCH net-next v7 17/26] selftests/vsock: remove namespaces in
 cleanup()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-17-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Remove the namespaces upon exiting the program in cleanup().  This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test. In that case, this patch prevents the
subsequent test run from finding stale namespaces with
already-write-once-locked vsock ns modes.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 914d7c873ad9..49b3dd78efad 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -145,6 +145,9 @@ vm_ssh() {
 	return $?
 }
 
+cleanup() {
+	del_namespaces
+}
 
 check_args() {
 	local found

-- 
2.47.3

