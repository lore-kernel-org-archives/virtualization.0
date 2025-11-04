Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30293148D8
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295956; cv=none; b=i8alaXGQ2RgyUAQeJPdhaGq0xApukLzWnNqXe8aPM4FIn2/bAC8bN7YuI3IN9bQsAa0DsYOwJW1KuRa/FBN12Zo6VqFjQk8b1aRFwNv1zlv/KJ78n5uzr7ePeXi/pPD30XHjWEb/ONnupQtnPeKMp7/QY5DGPOdUKmmbGTcfMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295956; c=relaxed/simple;
	bh=dKYcrUk99CdeL/H3uIfsCxfnuKjJF+qFwDzoOr7kT4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYYF3tXba0sbVAbFFL9AvPT5yfF57f+JVPnwjjXNYa9XnjAHGg1zq4u2+QvlYhEoO+q+N9sGgWk1vKHa96UsmKVUGmUIpC4LRk6989trQnhmHlyBFzWaPhcAVvXrh17WxcFee+blK+tHWleBielMmF2u4wHsB+jv1f0N6aSeDdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H06XCH7t; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H06XCH7t"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2956d816c10so37015875ad.1
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 14:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295954; x=1762900754; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDZPS+JOEPYnU4eck4h/T1RWdETtnpWwlslVEykWAIA=;
        b=H06XCH7tybA5+0RsMriKn1y7BR8wr2dBgyZMmYcMvdMcLZI/kSyVzhaQrLDjiI9KqB
         A29+GVpgsTXIHf5mALo0lJ7A6Dgad5k1JQwa5ef6SqVCdFlz1o81hNNITmF2VuwBsHkS
         zkzgAMFBzA5KcfMrfbsNN9tTSn62CQKKP2OJG51RvtiA0YDS2AntxNBKxpGQ4/VviYv+
         mghdH5nQ9chQiWy8EgaI/I7X4VL4Oik4y+djVBcQNBmVfOTHaMKy9Mxue0fV5UG3nENu
         HqbEb1OU2ZuduzFye6xI6NDnRIXDPtlHfG6kaJxi0GJyjX6pFh7IH9bwdd75CquGk+o3
         lgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295954; x=1762900754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDZPS+JOEPYnU4eck4h/T1RWdETtnpWwlslVEykWAIA=;
        b=rQg75nPhAIQ5vIBk3bjcfFIyWsJ6P2v9Rr5E1FClY7wiFaO6xh3xW2QdIiIzUJMuWf
         zRrzmS2Zbn7hKKjfgJo60baYQBhid2BtcfLOHUC1O2zqUrEMxVxAukbHQ1whudkVd72o
         z8+BV7TQuEQ3SPfTjY9yfcnquDUBOxOxyph0FQjLwVQE6S+BpGSVktu+74v/jfDQthJo
         k9kSGNJg8W9liEjdB1oSKf4Acoh6sg5ErSxkZ1yVWhymUhJJySaFua0k3KZR62K15ItP
         rkKSuitwQa6wOgAwzJTeMJ0GcJox/3zAPt7BeNz9J/DGJ9GJNwNfiBXCyjsAlqhLR3mK
         GnxA==
X-Gm-Message-State: AOJu0YxeBHl5rSozO4scCkiyKbONMRJ7MnCySxHSNcvNNYsvT3cmFmah
	UcKtbJ8jQ6yXMiOUTgHB+11RGvRJdwKRt8tI0tyuUvZGJfgyMVKEDPvA
X-Gm-Gg: ASbGncu3a4jk7QKE1eMHFjdQI9+cRbc37E1wF2j8OXfSkwYNvXxGADmogwQGR9ZhHym
	Ljh7SyR/s9M7yWnC2T/SrAGK2tJzALn2/FDbqcu9vaze5QDTo/Z0brrAPyOjWH9010ib2DLl+Pv
	E9e7aEl4Aqe46bI4dXSYC/mWlnJkfFL17WKbndEpa1IolvjotY74NLhHdvCDdCHv6xxBxxvZVw9
	PEdiU68JQi9FkjQ6JwkyzQ69ucJQrZiaQPEEysjyBdSAHWooxU5hnffjjBWgebZJdxPQpuxXQN+
	XECf6No7QpwrkL0DX6jfX5TVwNaq6lI3v9tj6s0qqgiL8+Ufxn0pBnrCs06Q7SIMk0YIeBS8iSf
	W2tI5+1XjyW8bQWg88hNu7jSFJugoxvsrtQKnFC6XNRmaV0USnSs+wM2KH/mYiGbF/ZJ8zmUf
X-Google-Smtp-Source: AGHT+IGfGmQ8EXplL0hPzNqnOeWP5or72IZ12giPyrZz4vb4nazXJcS6uZFq2FRiYWZU3H7Y1pH3yg==
X-Received: by 2002:a17:902:ce89:b0:290:b14c:4f37 with SMTP id d9443c01a7336-2962ad95560mr17604575ad.30.1762295953856;
        Tue, 04 Nov 2025 14:39:13 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a36sm39340475ad.1.2025.11.04.14.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:13 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:55 -0800
Subject: [PATCH net-next v2 05/12] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-5-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

If QEMU fails to boot, then set the returncode (via timeout) instead of
unconditionally dying. This is in preparation for tests that expect QEMU
to fail to boot. In that case, we just want to know if the boot failed
or not so we can test the pass/fail criteria, and continue executing the
next test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 5637c98d5fe8..81656b9acfaa 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -221,10 +221,8 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
-		die "failed to boot VM"
-	fi
+	timeout "${WAIT_TOTAL}" \
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 
 vm_wait_for_ssh() {

-- 
2.47.3

