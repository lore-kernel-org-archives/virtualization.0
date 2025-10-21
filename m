Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC512F12D3
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090444; cv=none; b=ea/6gmzCohfx0cIEgn5LsPOKIdcStvypOOtPja4ZE18pl+9tTNDQRDRhYwUhZhnZWWfbTByqnE/ZT9dZFLmWjGdGfSTuY1O/M7ORAuk1YF8BxGxkN6wK0a45XkFcCRnjepdnzSY9gK9evuEfuJaMd4TITeWpemkDaABs+fsuaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090444; c=relaxed/simple;
	bh=Vq3JxLDexMAZpBZBOMz7RcnedkE0owAELSAnlUsmBpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6aIIeGzsK7O7N8WXLWhTmJOFeQXeq8MtWmJ/d0XTp2Bj7l2YyRnpxFXM/kyDvspSNzpQQiRSpAlpjDzY4TZaaz0ODZhDjEHaowbPmR2NE7yWdU0UFUnpWe2A052qJvq5Px1hG7gXsImvsqxhGzgzmyLe8EthgeE1bAtF7wCeoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5AH/jtu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5AH/jtu"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b556284db11so5178375a12.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090437; x=1761695237; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ziglltQonD40PF3NaoQP9RaIb5nYxZqEFCDNXD/J6U=;
        b=A5AH/jtuzryxoBlLPsPTV0cA4rvnWW7kud7B44/o1EMXSmYv4fu/n6lb+sYQ9RajlJ
         1WpdtKdMJssySHiu61Fz0s7WvPq+TxlIT5O1AGB3RiXWfyvG58svXd682sVK6q/PlhzB
         0a4frZPxKIiLFRnIcFLiHO7Hd3Mq8vlGU1QUItEB1PbjXODA9n0NEA5TCkuXv4AWCAhJ
         pOUV8E7HU7Z36WA47ipkeUDh+jduJXURsm2F/wEme8R9xYXEAMfUfQQLof7svI/YG/C1
         6EQcqbj7KfDODTQnq0vat2oPXAw43R2CIObaiKTy3WMgulwV3nUTIPsmEKyt5ZUIa0oD
         uSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090437; x=1761695237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ziglltQonD40PF3NaoQP9RaIb5nYxZqEFCDNXD/J6U=;
        b=Be3DU78jNwkwoKC8Dd4KD27RQKU4dBcftdQghAaVKhVZx5leGWKj3hrmH7nqf957jU
         ypI41mJv3OZDXzNFQEzMTZnH7rFbi31VKckF+lBtMFDauBu3ct7xlCZIRTdcyOIs4jl+
         pF317VEE0ZAkNA4PR21/cS+5XmgoOpCidB4BTyoTW1QCdyi0x0D6bD+o9xCAmfujbxzw
         +zgDfsnr49KAlMTmP7WBEYEpsT6NLyfFRMPJSL3oPBAYNFIiqTamG9YDX8UiONAXXret
         e/sdZ1S1hH4j5+t1FTSLgLK9bCPaUZWm7q2blUVrvOpeJgZklJgDqY0a/wbiLA+OsrV3
         6SNg==
X-Gm-Message-State: AOJu0YwETOYwxoHe73PgU6qYufEo+RHkN0ZPAwKxlvbL84yoa2Cjxf0U
	j/Fjf9wVXTfyWrbZwVO+/bBmBszNwrGV/SSvxvGSf7VBpXSrujpAPwp5
X-Gm-Gg: ASbGncvqqcrQQf1RLmsALJ3zBQyEfcQI4/af1NvI6jvLUFFsdEtYFX6ZUudPFo03mfE
	D82mHwhxccmKIxvOeSENdry4+dw+xx2dLvLpwBxZCGInondVqWP+1DbqxkDcywo1VpIh3AO+aDD
	cHQcc22W0Lay8Pj0u+RqPokGpvdEt1qIhlxU3/WnVUs8wYOjWTQw0hIwsr4+hck8PGcAHsV0awW
	Dv2YjDkcY8+W0zHXNubxPe4xEhv6/v1JRhBtOygGpytmausFkRqosh+Vq/E9cI8XvvnaTeqv8FI
	SV0n0a8vFY0d6K3TpXaui6mc404+6NAN8g3Jo6ThZhLHeHDdHKR6d4d37MShqmoJAaGC32sw7Tt
	LyNeeVkWPFuIiKxptcBwKEs9U2T2z+aUJRWOEISMlc7HgvSeUa/suaJxqo0yW+scCc3wan5JUWj
	BvSCKl5Onx
X-Google-Smtp-Source: AGHT+IG5dGgoFfjLOrDybopHtR5kmquL2RmRYL/ZwgLqL0f5q8OPShyxosfyQ4g18ky0R7BE1MkTfw==
X-Received: by 2002:a17:902:e84b:b0:290:c0ed:de42 with SMTP id d9443c01a7336-290caf8582emr300060005ad.36.1761090436967;
        Tue, 21 Oct 2025 16:47:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdd10sm120304085ad.83.2025.10.21.16.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:16 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:02 -0700
Subject: [PATCH net-next v7 19/26] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-19-0661b7b6f081@meta.com>
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

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index e8f938419e8e..9afe8177167e 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -626,6 +626,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3

