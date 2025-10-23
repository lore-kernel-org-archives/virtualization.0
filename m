Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1A26E71F
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181239; cv=none; b=i0WpAcgnkBAavJ1iQACf6wYMJ8/XxB/qVRtrba/aCwZRVSJ/cJwAix8tRvzbjN8MLc+Xcl58nqUzSP54c8PE2mYOCO8Pysio4BGM1Mdq8yutbv0PLzAgZ2f3PjqkaSWXAIkTSAfyNiIpRNVeIq72op6yKIrEKxdVW+T91ihcN58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181239; c=relaxed/simple;
	bh=94uzV3VFEsNc5hciZIog7zBBbpwZzL3cEkwJ4Knqo18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TopbspA7LztVQnY4AC+TUZlQXhq8w2T4uaqnma0IQhUypdQ6hfPz2fTdgg5bB3IbbOz87I0GhRbU5w7rwosKkXoGWlTYgjCNE+34GdquGeVbhE7FJDUJV21sz5WAtrBXEBQ1/sUJlotcLJGKhV3XdLa3nSDHtJu0fZGGMMy3InA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2SgPhNk; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2SgPhNk"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so313919a91.1
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181236; x=1761786036; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KyrEoOAeZKPRfbyTnz5cosCWFxdbO0nbS1ytMd/2Og=;
        b=S2SgPhNkcLcsWpPq4KLlhZBZ9j6bD6ayQ2J46x75idTzKLiExWXrK18uiZMLVDXV1y
         9ROIfcQSOtbj3NhZlo8rRdF6Q0ZJFUp8dg8OCENOrUE+Top4S+9Qg4kcPVjcWk1+iOzn
         Dbh/0l9S2jHk12H76C5kbO2Yng2t9t2H46GajS2znsVdTkoaX7KBJIiWlptf44Jp4rRX
         J3i/wqWuLJZ3iFpNbSIC0B5lGo25LpbLsuNMLbhbUYSNtjPvnBnin6QHUW9cKdGKb7qL
         IMUahH3KHOJ3BZMYQADBT++enctFIL9n4HPEvPu2OJwpbMsVstQb6rCHzixWVaT5M87D
         P/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181236; x=1761786036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KyrEoOAeZKPRfbyTnz5cosCWFxdbO0nbS1ytMd/2Og=;
        b=Tt14Q4cmpuRESOx96B3yvtntY6c1KU4ipBAo49SaoJqBCh5tCpc3/oyMlDfxHIeECT
         Aea44VxOR9DqW4SPI+2vNZMiUNXbdesmJCjmfD8ou8ixgJpkHlKlU7Q94FxknRQ24DCs
         KNXbdhK6wwRNkphgpW+ZQltaGxvfwE3Xllbd1B51Sdsd4esoVjwtW7X8sSJPIYPnzTGt
         +9ww3f/id16IVnIELXEm9rpfB2NR+Lgk64J01OGk4QSOhJnGMbkahboFnJgqhSpkycyq
         Ii9UREwkCHNs58dSVUr1UKvZhtUUxIJBvL3Swv7uzFKIOKbfMmsQWRsCp7lQYlY8eZAe
         GyeA==
X-Gm-Message-State: AOJu0Yzs8igEnTC+8p2ohCQv0+YmuCtER2Ev99hhXIHs7k61MILXxQOd
	F/rdVrYaAaqNKnqzYf2I8ax+JqA35dsUNSZY7Wl/d0hgDW6GpwiZrGr66pQVZvZu
X-Gm-Gg: ASbGncuU9+funIASAd5wiOas7QdSEmB7KW3CtslKcbncgp/fvyGeZ7LyPMONdOlrsmn
	qhN9h3CB/UPrZvEM1/EgJ3qjfckDbNqDsv4SSwCDrJRQv/AroPajOS4sscthDhijCe+QRRfJ+TN
	lUVFTveziopHPZlXgdwkKuYYQt5wPsn9w7IHXajFLouWv+gwTTcllLt5Z7rjsrhmwq8Loj1OOdI
	9i0Iau7tnTzDlmA/Rn7xqP9/hq+0TnrWPVoPy9BujbTjG52tBDQu4R4nlt14kfLL2Lui2NI2xKh
	zCzuCCguc8zRU9YgPq+x47zG2kRg7GCa1gtGK8YMpiksT3W4hF15PYPzetsDUBabTPOjT8+9oqT
	vyZDr9s4T7dlMCqL7hrigU0taYeWoj5HCQCJaO5S2Lw12G0eXQkKXgzS0/5TTa98/fXh4/azhT0
	LLECtVUBnB3fHSNlXbNw==
X-Google-Smtp-Source: AGHT+IEOXbL7VuQGK4ycx5x+XFWwQbZrBd+2XbxwOLCxBAkNJU5f38Hm416YN0mJLPBe2ibivOPQGg==
X-Received: by 2002:a17:90b:5343:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-33bcf84e1edmr30854960a91.8.1761181235816;
        Wed, 22 Oct 2025 18:00:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb9027sm360734a12.6.2025.10.22.18.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:35 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:15 -0700
Subject: [PATCH net-next 11/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-11-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index aa7199c94780..038bb5e2b5e2 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -152,7 +152,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3

