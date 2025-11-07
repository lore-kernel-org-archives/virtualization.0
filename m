Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6532EA481
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476595; cv=none; b=FVugv2c1gNjevkzRaH+P7datlWRnuN0gRpc6eP0EsRqp1HXrYUhQbSxA2uHRVDnI1TJhC77Dpx74K1C/1BCqzZE3pTQQjprAhIH+/mpRF3bi7Vhs7ExeMGKFUbU5hJQlZctJnqeKpdW/bBsW6LckZLFsDGAGeOyOq/E/33JtHAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476595; c=relaxed/simple;
	bh=koFlOU8nPr40dYCnNR2Kb1hX/evxzyHNeLTqs2N9DX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XxMlpaZZC3KPrf5UNKUAFLVn8oiWs0JKY03tpPcKtBeqQdonz+UPPMLilq7bcs76h1hjjjRlg084xcEuFOno2VdVMVkx2hYJnhvqnAd0F0C3aLKrjlr9OsJHkUyAVU+saab3lVw5wL+aohnppCxbWVR9EeUaN/9gUIkP6dV87+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N96IjQkX; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N96IjQkX"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-341b2e98486so191901a91.2
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 16:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476593; x=1763081393; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bHLKHBydWD3BQnmasHq5DNEmPhWMbiyT3gusZiID5w=;
        b=N96IjQkXNyPBFwPLbADGF5DNFcj5gx6BP0Kn2xxbgHVc8sRPvhtITC1rC+/i1OQ9j0
         yZ9CCduukgBhCQHhjpPmmMVI5I7FEYSmWeAWhIR4Nvl92zeabHkwLDLBks7SJbHfzjLB
         sO7p8pvBd6lTA3dMbjLUlO/7R4yh4FUM7vpJQar19emcCOIlS1xJ65mYaG3gl13c4ddJ
         c3w6mPTtfqwej+mGOyRgzLMRroBWXUpTkWQm7PKcOnFWNDnvbFWPLeumC/U2UMyog7Ow
         0JrNOo+TraKOUihUiUpn6j8zDbraO34efYIrmAIompw9F5hSUVLfzM3MPc+eRk7FrCE/
         xlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476593; x=1763081393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+bHLKHBydWD3BQnmasHq5DNEmPhWMbiyT3gusZiID5w=;
        b=HXrWiux+/RJTYBb1O97836fbESDL7Uf/a2VGU+Qaja9NUPaCvuBGQKlX+32lXB7tiJ
         Ykf38J565H7JvT27BlXkurVT45pl2epAHqANkrLIkTkz4SyP7Z2I/bPbVTzTHolUnvbT
         SM0SBxA8npVIIc/sWetLy7FqtfE7P4/l+EE0RAqZH5/mxxZS9jHN9D6sK0Wn8zcIAlD4
         IvQ2va7Nk5SEfGj4pfxaHxZBN1kTep3dWT89Dt+W8KIRLijnH5LSuKQZJg99flYx4o9P
         bVcUmsxHRx2JL/NooJ498pM6BT8qQRZdVhKlmyLTZNJT+HzcSWSK9mLZ04mQ8VQNFuFj
         Wngg==
X-Gm-Message-State: AOJu0Yzb6+Up0hj/+NcINtSqCkYF5Yj4aLabuU6NRSeZVJx97HzzmRT0
	9otJLApdjaj7QAzS43jDOg0HFkywpvHrZ6PTXEpo0RN1rBeVd+HKe2XC
X-Gm-Gg: ASbGncvP+qmHQQHjMvpPk3uBxzJPXRhUVPcOnBhy6+MIQdN2rESwERM10vX2xJY2YE+
	m5OmIt3NxU6eOwiUZPqt85b46Xcv1FZ32ONKPJqPzmJ9kTagpmkjwv0Q1YSsl8pB9PkD0GMuCjF
	uCt2K7GSpTLqza9QpCLC4n0h+yXhOoiWZ/DMcNuBwB3TydiOFYI7vqQ7T905xDY0MWmdM6aA5Q2
	iiG/q3Jq5qPvZKICr6A9cPtqzPgNR/+jm76tTOSvIG31YeTE6QfIFnL7WXxClbOHAF/35U22lRz
	lh6fytK27Vv9qiPlya3GbY8NVPNDxv1aLi1h9sl3To1EkAl9U3pyfCBEok5msk82Npn8Tger539
	oofCNQpakaQ/uMgF+qB3CfXuaitUjtt00OpfbMdcD+Nv6c+KhiU59i8cVvJJm/1f0ACG76AXs8A
	3L6pe4WRpq
X-Google-Smtp-Source: AGHT+IGGoy9wEEdfN0EFLwAgMu/11l3zKvwUuDnYxOVJXD1G2hGNpGxEh0fLCyEjaIvkGIR6LPuB/Q==
X-Received: by 2002:a17:90b:2ec7:b0:340:a19f:c25b with SMTP id 98e67ed59e1d1-3434c55b5b5mr1365389a91.24.1762476593115;
        Thu, 06 Nov 2025 16:49:53 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d08afb02sm2233539a91.0.2025.11.06.16.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:52 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:46 -0800
Subject: [PATCH net-next v3 02/11] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-2-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Rewrite wait_for_listener()'s pattern matching to avoid tripping the
if-condition when pipefail is on.

awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
exiting upon finding a match causes false-positives when the pipefail
option is used (grep exits, SIGPIPE emits, and awk complains with a
non-zero exit code). Instead, move all of the pattern matching into awk
so that SIGPIPE cannot happen and the correct exit code is returned.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- use awk-only tcp port lookup
- remove fixes tag because this problem is only introduced when a later
  patch enables pipefail for other reasons (not yet in tree)
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 54bae61bf6d4..d936209d3eaa 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -251,9 +251,11 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
 	for i in $(seq "${max_intervals}"); do
-		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
-		   grep -q "${pattern}"; then
+		if awk -v pattern="${pattern}" \
+			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
+			/proc/net/"${protocol}"*; then
 			break
 		fi
 		sleep "${interval}"

-- 
2.47.3

