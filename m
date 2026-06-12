Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A173A7D98
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291364; cv=none; b=UpWSoZe3fDQmiw2InDo2qlL8yNZxkLCFWUWsDXFY0RxBk9jnm+iq/qWH+QDdNoMEsSRnE0tNVUy9vQBrgBRScIZbvX4VGSxK+7avzD3vSVJF+ZUlKhfrSe7CS0pM/uXDO+SQElgyQ1HYPliz+QsPu4BmJ9eWgg4aAReOoYLaMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291364; c=relaxed/simple;
	bh=bPlI/2xmJK0Qts5eddw/Vh21IiHuQaslrq963O+3tzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QVILhJ+jGva9G22bSWdMwQfQglDyKO2eO1Lvuwqf+i5niw2e6iUvMVMkXQQ/AEy9kBw7S38iMOYbk51azYDAc4QqazRVKmkJWigJxgPN/ZvRiZcpj0PU+otKlGAh6xiomj0WN4r9gfsex/5xjU9OejC7amtaFsje0bgSNiAXn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sCj3AN+d; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCj3AN+d"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so9767615ad.0
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781291362; x=1781896162; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRg96KjMZPBuPn1RKC3qLwa0FZMA6GdGbqmzSwsfaRM=;
        b=sCj3AN+dP/z61bU6VU58bzbTj0SzPZe1RuUJA5Qt/JGnU6zv+1r1k1ujJapl41MFRd
         OQxvKEEvvBf685lGDrDMlaIDUWXN49FFh+A+EdOgAvyDJpVB6kZYC2clRJ/lX6XsZ1vc
         z3izZEYhqvTtv1z/hMQFeYmQfoBC5dMGfhePEs0H87ETzwz4qotDGQdRz4Yua7RN2kt1
         iLXF/zrok1zj2qstcQsHXVkZiecJROgU567bdxvWBUO3WBbmR8LTfwoJoy8TVMUoF1H6
         DBkjxbOp0P8RKBzsUJ5twr8NZGWsc4zSpUk8sGdjlMYeTprXUZwv5cuWF7BTqFgYBrjb
         ycBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291362; x=1781896162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XRg96KjMZPBuPn1RKC3qLwa0FZMA6GdGbqmzSwsfaRM=;
        b=iunSmkuK7NFD7GU2vxEzGSou0cN87Vp71R5mGVXqLY39nOJwQJCxpfsU7UVtxpkR/N
         dHEfg0DrhwiS8UfjjTMR+Sh+8qJesgo0hX2M5LuHEjppyOhPIp6B75CXO5nqc/t3gRqs
         XYXSX48dVlYlPT1C/FoG+UzCr7mlJ6tjc0lsgB+wSJJGx6ic+j5IcYH+mnHHO64vZlZS
         tSLuiyAHfpxfksN1JFdCCaKjutUPnHr6NYcpFOcRuUx6eXjDW8LST6wptI7+onbdgchJ
         Lok7R7EsVCcdacxWQNFlDh5YAf4HEjnVSJMjmPfkOQf0/MO6blDyxs+1/azETFkty8D7
         IWZQ==
X-Gm-Message-State: AOJu0YzAe99fAHLa/tr1uoXEFqyv+C1NiA/cX85OnIOCmoT4T0BEacI/
	A5bARDb9oaXodEOcdaf+Vk9bTqiPWp73EQBRpepjeYWWZDQwXBhAUVwwM4au8/xr
X-Gm-Gg: Acq92OFKxRXT34yiIlxs2gj50UustUqVpCkfY+aezxH5dRr0LKW8sZSnS0LrIzadVvW
	zWGoxsA4uufkhjVXfqRyxwwdW6VvgaTd1/ZCPoNLjcmydsH5M3uLENKUq+1QKLnehEYz0cG9JeL
	iiyDADE65+RkdvAT/ZGOHhPSXViKcbiH3Ei9F1KgocCW1+e0JNczAOSMig8TsWQH82C95s1T1y5
	0+nB9A2cD9VpT7kL6wseaFdBmDqFMlgbgBdjAJPgyR4ksML32PZHjqy1+ODB3u+xU3diCl2sYIz
	U8t/k8UZWk7jAoGiVtNe+wG8wEuEx27JimVQEK+3ruw7mOHl2voEGQ0wucsoIsuJQq4lFgNSg4N
	be4xSOgd1sIB8uQIWX7ASa7GvuurtF4PeJ8dv6IGb5shmlLMWlGb+4S37qRYvgpNUcRwYjDGL/g
	i+lm/59sksddcUJijaNX8=
X-Received: by 2002:a17:902:ced2:b0:2bd:7684:34b0 with SMTP id d9443c01a7336-2c4105092a4mr52571515ad.15.1781291362268;
        Fri, 12 Jun 2026 12:09:22 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433460a60sm34934225ad.76.2026.06.12.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:09:22 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 12 Jun 2026 12:08:41 -0700
Subject: [PATCH net-next 1/2] selftests/vsock: accept vng 1.33 or >= 1.36
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-vsock-test-update-v1-1-7d7eeed3ac8f@meta.com>
References: <20260612-vsock-test-update-v1-0-7d7eeed3ac8f@meta.com>
In-Reply-To: <20260612-vsock-test-update-v1-0-7d7eeed3ac8f@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

The current vng version check uses a discrete allowlist of "1.33",
"1.36", and "1.37", which forces a script update on every new release
even though all post-1.36 releases work.

Replace the discrete list with: "1.33", or any version >= 1.36. 1.34
and 1.35 are skipped because they were not tested. Add a version_lt()
helper that compares MAJOR.MINOR numerically, so the check reads as a
straightforward version comparison.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 39 +++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index d97913a6bdc7..ee69ac9dd3dc 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -330,27 +330,34 @@ check_netns() {
 	return 0
 }
 
+# Compare MAJOR.MINOR versions numerically. Returns 0 (true) if $1 < $2.
+version_lt() {
+	local -a a=(${1//./ })
+	local -a b=(${2//./ })
+
+	if [[ "${a[0]}" -lt "${b[0]}" ]]; then
+		return 0
+	elif [[ "${a[0]}" -gt "${b[0]}" ]]; then
+		return 1
+	elif [[ "${a[1]}" -lt "${b[1]}" ]]; then
+		return 0
+	fi
+
+	return 1
+}
+
 check_vng() {
-	local tested_versions
 	local version
-	local ok
 
-	tested_versions=("1.33" "1.36" "1.37")
-	version="$(vng --version)"
+	version="$(vng --version | awk '{print $2}')"
 
-	ok=0
-	for tv in "${tested_versions[@]}"; do
-		if [[ "${version}" == *"${tv}"* ]]; then
-			ok=1
-			break
-		fi
-	done
-
-	if [[ ! "${ok}" -eq 1 ]]; then
-		printf "warning: vng version '%s' has not been tested and may " "${version}" >&2
-		printf "not function properly.\n\tThe following versions have been tested: " >&2
-		echo "${tested_versions[@]}" >&2
+	# Supported: 1.33, or any version >= 1.36. 1.34 and 1.35 are untested.
+	if [[ "${version}" == "1.33" ]] || ! version_lt "${version}" "1.36"; then
+		return
 	fi
+
+	printf "warning: vng version '%s' has not been tested and may " "${version}" >&2
+	printf "not function properly.\n\tSupported: 1.33 or >= 1.36\n" >&2
 }
 
 check_socat() {

-- 
2.53.0-Meta

