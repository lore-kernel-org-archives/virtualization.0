Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2FB2F7ACD
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476603; cv=none; b=nQGQJBZDOd6n1EwIB/5k3TtToht5GMDoG9WKt5+Qf3FaFfKMOHYZoDdkv20hMLZF4go0A2wTeSP6T+yBJMKCv+PrN9azJCgKaXYojROrYw3DefY815hVQt1Knn8YNdKd8HLlCIM/6cUWhjfvjy3vl8eRCo3CEYHIBmAmYj3TAxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476603; c=relaxed/simple;
	bh=3X7FcSuFEkDk3JDUhogHRIfC2C0s4TSTiHdkuzapQSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRLufmgKzngkumtdf/1CJ+Je1XqeC+6QTV/4+EBW5VDIhaKjkBl41qJIYcjpFwbfuyoc1ZfmW6WHFBHAplSk8rpCd8MGO6cZI7KHxP956KrHFN09fbhVpzGmHiZLVS2K9wlJZsk+SrdywtDUdsc6TsD8Ldea3Utc7VwPOl1GPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUZwjCN3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUZwjCN3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2955623e6faso1910095ad.1
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 16:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476601; x=1763081401; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08hYWGEnuRuvo8cclYTSCBGU9hHXXt88CsOLxaqCDS4=;
        b=HUZwjCN31xdtQcR1jlmEoZdRLarY0iMdSUI+pQg6wbf3ZM23cwrhxOn5MMp5azQb2z
         4dFSX43NRPgqEikzxcT34W3AWxBiQWcvi/q/b1QaJZaKBrWriVaQJ0+n6XE9MdIAa69u
         t9Z9xxqANDOpvpMmcp2yOft7JWiRG9a+vM+WtkxcfCfPpkvh8awv80ccYNpHUGSpzMIF
         UVg/ePSlMOk5+ygY6zJr8owgEz/h53TSPW+Rk27eLH1GzXDdCmS++Q8TxI4HrbZsmOkT
         ButHt9LfsBSI6VfPUcZdrOGlEnjrMRqFQylpTzmyFof+xwz2rlcKWHUn8hF1mL4jyCRV
         hC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476601; x=1763081401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=08hYWGEnuRuvo8cclYTSCBGU9hHXXt88CsOLxaqCDS4=;
        b=vN/ovTpfyDkDKKLiXlVsPxfhxYbhXxHuU2Z97xn64KWAzLnr4wSQjATfZh3HKiZyfa
         17Z5R1Q6IKnQ3P7WyJYFnborqQANq/Ruac6dY2fxJRCdvjsBgNT+eipJcrLyMVyggzz6
         QSLLenE7/NcDtuVTDWqSxYa/WdAYhg61+gnmsya1AIaVeeXRoj8iQI8qxE9anBmvFNm3
         nAoctyX5HF7cIP1cudkAw7uaLXdqyTz+HvaAPi5a/tRLRElRyWXVZMplknAzFDw1aGy5
         NLE1uZkj/VdyhQ5Fx8TEX7Y58L+4MoZ52RVl4Mn/8Azte8swQZU9iIMWmxezYtrKD4ep
         44Tg==
X-Gm-Message-State: AOJu0YxdYzGk0DHWzY0L6KgM0M9oNfKptrmfBcshjYtqJzEcxVn3C649
	IpsA3M3dyf+cEZZoPplmdMijEMd9MQ2sRAeYTk0gSUW+KwovVxUicaCy
X-Gm-Gg: ASbGncvxGLzkUFPULolsKqaGErEugDDwzEUQVVqQlLiRnzqNXC26GYYmlCi7hpUDYMD
	QkDflVYPqC3dvsFuxt/X1P4iMzp3pHwpDWrBf0TdLFI26MPMFDBSRY6JyXvtbpatVQODMKhcelV
	rRplaM7zfiWVioGplkIDGJoF0QVa67wLm/TToace8Ql5YtboecxXJv0HtBDJDQ+uwY8mphCN4dr
	TCETm+Lc9jVp8g8YpqDD5RGK4z4KVvXj8pt5ezBDj3Zj5RFIyY7lBWrM7OyMqSCWKqus6yGtf8V
	lrDF7lk2Ub3QhaxWzM+uxw2ox69km5q+CpB3DER6VxqXa/U5YaF+AQsaLkwRqO66E6unir8qKAJ
	K1IzWAAkBmXs12dL843/6KN2NCN1PidUf29TB+xGgU6U94IeeN8Z66mhG+v+iEUQFud/jZ3XjfQ
	==
X-Google-Smtp-Source: AGHT+IGJA+8g6wRjaGXZk+uvhQ1e9D6dzx/VUNrIZDpEGW28OcBzHMx9m6/c+9slJaL7jTXyZDCNaQ==
X-Received: by 2002:a17:903:384f:b0:270:e595:a440 with SMTP id d9443c01a7336-297c040a72bmr17286965ad.25.1762476600328;
        Thu, 06 Nov 2025 16:50:00 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7409esm40775685ad.64.2025.11.06.16.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:50:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:53 -0800
Subject: [PATCH net-next v3 09/11] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-9-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 7962bc40d055..a5c33b475a39 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -170,7 +170,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3

