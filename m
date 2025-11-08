Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F59A2641E7
	for <virtualization@lists.linux.dev>; Sat,  8 Nov 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617725; cv=none; b=afYAQw8grCLum1nFKrRjITOU/fKGc9mBR4rr1u3x17kQhGjIRhPcH4aZ8NIA3nwBTrK3UaI7LCgHmRgfIR5PhJVPhvjYnMxas8eFEL0O6+/iTfBtZ6CRi+RbwCNvKHL/oZt/1kyUQ6YVWg+QTIeto0EjVkw9nsGI1sKBucdr0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617725; c=relaxed/simple;
	bh=oHgjWws1DBoTOYU7ER4ATIFMREmAxgb84D48zVV5FD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjBoQaoe0vj9iEEH2boHOE4nDMrp7mEHUG8rriKI9oMlM4h6fYfH2BT4twQ/dEkI4fetyXVUaxH/+zf+bQ3BRI8hUZi3RKGrLZp7sOT3lVd0HTthTyeK8MzYBPqiz7J9tBVXp1w6dtD8ma/0ba8T/QFJbvrKGMl7laNR5kwxhnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjwEC10c; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjwEC10c"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3437af844afso202728a91.0
        for <virtualization@lists.linux.dev>; Sat, 08 Nov 2025 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617722; x=1763222522; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=golzAGu/U48hdgp+/GOKuXZcnB4/AsbzkE6v0RidcZk=;
        b=BjwEC10cqVuPtNLthtv0gJFCApfXyPS22e8wjQGQS1Uff3jcjkaWHPXPthwvT3EqPe
         h5NbisbrFiMNfnKu7NM+SmwDokGWtNLE8qRKS7DcmMh5tIrxQNbI04MyLx4x61qtd7hL
         WOSzM0hfZ1vpZXufq8txSjlYrBxYZDnWYxWWVr0WIzX9JjNLl6CjAl/eicw8QRTJr100
         fjjg0PDLTQqSofrFuhUwZ1krZ+LHVvKS8yJC6cBcgGAbQ6sycPvn0wNLJNQc+2t2eiH8
         u5NCnf94fpSQhQNlnG2w0DgjjDp7bnbQj+LWnLji4I2PpexhKNgX9BhYgKV7+FGzQkbd
         +QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617722; x=1763222522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=golzAGu/U48hdgp+/GOKuXZcnB4/AsbzkE6v0RidcZk=;
        b=oTQU6D8XnryV73/3BmkVXp+oGf9yaar1e1IEKcSETdk8LtkaOO50pCyTqO78IUyXFf
         Hj8Xilv/63A5MqZbfZLsrlTtdzCoUCjibVZNeKhph8NgUl6gcKnVYEtH2vvUk+SdZrL+
         byPdXbj+S0PaRc0brIA4XdO4bYneOJ+6/6HRI1QLWHjyn67d/bZsNVDMzcXxiTGHAgdS
         6QbPmWdbcff20PRVFi88Qm35qjyrUH9DMHx8uuxIkjLHXEPkUVnrPB1TOLzypAR5iLD1
         4bUjSqHASXKFubSahraU6aAKTaYjiwkLqE7y9xyvCSA4JSrlerX+0pKlsb1zWXK8+DHe
         32hw==
X-Gm-Message-State: AOJu0YxT1BKTtXQTEKH1+mMWRE3+8RuxiI4p2hf3qaYOQ0CSR6XLXBT7
	sbww1mgWzj1KGNngOIp7JwO4aNigrknPflQc92HhSSYx0gp7H6/RQoy0
X-Gm-Gg: ASbGncvFsoN3f2l+jfbmgPZXuc4hwvMY3yyngCUSanNvZwoA46rzbYcPkuvzZGMrCcl
	8vzUMLd8OMMR03anx0sxHJNUzdVW/3dCRYvpPhfUMhAXosrFBWAjnPyf0BFOXFilXrndKeo65Wi
	xgiS3SSgZbcQaLf50Tj0J4V06U3jvpwlLsiIxlneuEaPk0dPpVefKoRZuLEibXHR3YDn6n+Q/Um
	U0QDmHDkrbXNQ3bByTeAIA4TQQNj2QK+tw9B3VNZelPnfV3ulj+K+q2c+B0hHkRWjtcXVee+xkm
	DLjJaI49YQH866MHa9eeblTBHtjzEQTJyRGxxfeAZjQO3ItQi2cTs8nkDxwrIJhQYaFtcTgah3T
	9F6WFw3sQAsCNobwgCU58Bm+rB3AlBCT2SJsrcQLhwU0rigkSXth5OQWeEyFh189sINNJ/1NEbn
	jsa0srgc8=
X-Google-Smtp-Source: AGHT+IH+Vi5K6pMe8JfFAOXim3vTcOSLSn5qC8SzCV1Ipfc/i/Us/WTXuuK7P37jiIt7Ll9os7AY0g==
X-Received: by 2002:a17:90b:2708:b0:340:f7d6:dc70 with SMTP id 98e67ed59e1d1-3436cb89b05mr3302246a91.13.1762617722221;
        Sat, 08 Nov 2025 08:02:02 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343727dcf3dsm2104024a91.19.2025.11.08.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:02:02 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:01:03 -0800
Subject: [PATCH net-next v4 12/12] selftests/vsock: disable shellcheck
 SC2317 and SC2119
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-12-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Disable shellcheck rules SC2317 and SC2119. These rules are being
triggered due to false positives. For SC2317, many `return
"${KSFT_PASS}"` lines are reported as unreachable, even though they are
executed during normal runs. For SC2119, the fact that
log_guest/log_host accept either stdin or arguments triggers SC2119,
despite being valid.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 42e155b45602..c7b270dd77a9 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -7,6 +7,8 @@
 #		* virtme-ng
 #		* busybox-static (used by virtme-ng)
 #		* qemu	(used by virtme-ng)
+#
+# shellcheck disable=SC2317,SC2119
 
 readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
 readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)

-- 
2.47.3

