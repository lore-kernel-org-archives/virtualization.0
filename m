Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD052E8B66
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090435; cv=none; b=hL/FM5kNAJG3hKtyUmTUyPYJi9a0Wcsx/TrFxM42I3F9n355gJCiOj2/7HJYC+sq+1An1JayW7OWhUondRBRmOZ8HDjlt8eW5LFccfyvL92Pok2c9IyQkfmqBzcqzz8+FW38b7LhvRgy9LxVHKEEvvDbsJ+jzBQ1hPmjFp9dWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090435; c=relaxed/simple;
	bh=Ah75iXsh0T8yhCIpU6zRS0eJQetFgIMRMgUlS91SRJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o31YDNfZmXphQs9sJqeaHD4SCMGEpi0+ZkhZmMdvfhRE+BKWpEVWo0MV0ZfSm9Z7MENJvsnMf88oo7IXWzIZv7PtEOedmtYKoYOYq208xpSy/DWy7VduTm7YHBoAqFd2aRa0de8FlQ5tub955mrD9vkZ3Q47s4ifuPjLBkc3Lq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSuPfgHf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSuPfgHf"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781206cce18so511077b3a.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090431; x=1761695231; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnzs2zs6t5aqxB+IKVfd3RCQCLiGKiLLTWmUAKIpb/I=;
        b=hSuPfgHfQrjAs80dDGv48TfaACZ2X7BwyhERVp8Pybzd7oX3XTgtQ9tjGopfQib1+N
         t5+wwiDZZswULbWQY34DiHQmYHZsMqii4yJXNo8e+kSjN9W4VPuYFEkyYtmZ+HsqYn9I
         SoSzx7vxQWl2/jraLpA8emyLVJOMlqZUqnblSr7gTKDYYQhnpNp+x2DycHdv1nqQBrpB
         RbaY02Sh1+gpE98cB+fkjiKAQ2qm9fN5L8noSCUyKSUty9iHDe8aHrlBDLPEqwDf1Co+
         ou7lgSzAyQB3fq9gWAxcCWWgGdmfsk4tEmbcK3k3cBFxx/K9xMQQF3NurRFfmVQI/1g8
         4Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090431; x=1761695231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnzs2zs6t5aqxB+IKVfd3RCQCLiGKiLLTWmUAKIpb/I=;
        b=JyORvwAhiN9YgGEsujTBQdpPtAoWfTw1rWfDoPl6dtE2pqth2+xuYnb5J845sP7ByX
         tN7fDGKHT3uGOf6E2LKKWO/l+T0+s9brCYwLe5n+yd+GALSiR8dt46AdBDqkBM2CBnpO
         SiaAkCJgNVRluYu0dHjNwX3QCPkC+rrLQA1XBM7sUIWDxesI3eVEHRO3ybXJipf3TUSf
         fO/CVTQIOCmqvBll9LbkmpDytkMBa9AggpuSbMtVmCPgvPxS8nco5VX/ouR+XMhIJqKc
         25XWiN29iCWYwktmIL3PW2EMjJwvIc5nFbm/gyJk+n5/EUUmS0TJkiZ0pcLAAR6N1zkm
         ZFUQ==
X-Gm-Message-State: AOJu0YyVmy2c10qUYEmjUPXfbbD5bVOZVBRk84mRZu0KRxGJFuPwWD7S
	YpAN/S5RDnCnn0ftXCqlk4ELP8rBufyPrWYujdYRPAP9nRo4OEN5TvvG
X-Gm-Gg: ASbGncsy7crCwgXqu/ZtTpJ1cTvgH1nkGs5hU4jdUPum1TuQiG5tu/p99mmYuO2a8G1
	xN+ds+cK0qyLVIhf3FyWKKqkmXAXrjLxvYp2pJSxDafws2J26+mw8XhYRhxoiftaBDk7sshSTa0
	tpecR5OyzokgqSmoh+N6B+69HwPCtnglfZgWDVXGOEZa1QqjR015dxhPQiT947VUHzQcb1rrYyi
	V621zwbiBQ9mdzvSeuyR3Nff8ZPY7SFs2u2Y16Nt+663RSvKwRpi3C4jX1umevq4T288sbOvMxV
	eo/OpuylpM7x6D0Ipefeq1YsKTpEGLVWcVxJ5X8XRLR7g7j+6LWA/sQTYQn+dcvl17t8BkZnY/e
	LrONZaVGV6GJM26ueV/zvqwTGDU+Z4vWplzqF7vAf7EY2kAvGkFGyYxyGfZPUVU83U1/PXDtDdo
	+KLHdzM7GX
X-Google-Smtp-Source: AGHT+IFbTUe9F4h1LyVbUwgCQ1C/DV9vJaiYH1suq6bPPsdLXWTdUfcRVma8kaGj52ddQduYiLM0Cg==
X-Received: by 2002:a05:6a20:6a1e:b0:339:7f7c:bce5 with SMTP id adf61e73a8af0-33a9fb9f872mr2206937637.9.1761090431314;
        Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7664b30dsm11118178a12.7.2025.10.21.16.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:56 -0700
Subject: [PATCH net-next v7 13/26] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-13-0661b7b6f081@meta.com>
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

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index d53dd25f5b48..020796e1c31a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
@@ -221,7 +221,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3

