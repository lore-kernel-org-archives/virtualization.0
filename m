Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0AD3A8724
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291365; cv=none; b=BQwbi5PaMF+eCXwolzw4jlLpQqKIBqy59K4DEaAHRplO5iClDIUmrP4x+QFRykOdrDROiOZSwGMUZyhjTmt8xuCjqtY9INCI+o3mzWOSuPgexsb2qGDhGHDBLEiUSPpsii+iTjT+NgzHUSRdNX8VEshJjvAo1n6expMu0Y2MMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291365; c=relaxed/simple;
	bh=NF17neuBAb5a8ZbW82OAWrN4gb0hnuoHKYOLDGcV2ME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rqYW/cYlBDdP2+P4bSljaXFtSkITjoToTat2870hvhAxgsfkKNc2aWtFUp6ZyhHmUpXuYUYwkYbMavpNQn/yaPN0pJlUPpCFbyKA7R/WLbrnXojEUOXGrQc15mIphvjq5AvR77LoUiUUJnqkgWAB/HVHzWvPhhwDU5KIjw2yHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na5xhJlc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na5xhJlc"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36ba3ea5c46so866268a91.1
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781291363; x=1781896163; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ct/qd6zlmAVpaNbmF/piz+twUpeV9ONsk7D+rB9vo00=;
        b=na5xhJlcmB6WZntKwGy0cVjYtzvc0Gcz+UhpmilV2kxwt+eWGEMzsap3l2qT7WfVuz
         27QGsF0u4pj+g7AjTJo8TZT6lSEUY9+KgskLBH59y8oJ3fRJlAmMvFrzo56oUWCwOXpF
         aCjMKmzdB8Zdm3+vvOUbwUdUgAhSRT1asCUt2AwI4eNtM+a4jjvHJF0VvmLBjeZKxdb/
         wEymn8ZqFWm+mWXYK4JxbaP70940uFs+8YnNjCv1iqqXWxUc8GqrzN/3JOGxYbhTcnVO
         EMI9xkp3eI5SCuMw2sE8RWqvqL3BQwHWUntvlbtjA4xsXj3quiCxKIjyniG0zmcZhatM
         QEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291363; x=1781896163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ct/qd6zlmAVpaNbmF/piz+twUpeV9ONsk7D+rB9vo00=;
        b=O7wioXD7LKKeCSnntjy1Tgr9wkwPBOFWkY+aajL5E+WpBkq2oizZZRR0tnBJziqBrs
         v7WsVpyHm7o8DiehJAXsm9BQ0h8ocht8sUTL6u7m+iAyKRooG++njfxl8Uecg4yJAraV
         KGpfZwLbqEiHJOr/3+7xymfKki3uGsZu4aIr6v/ssgIwrut+FxAqVsb2HxPjysQfwbCf
         bKVSlXiceL6oHtoufxVSsNocTVYt14pZNaB4Lw4/luKegJFsaih93aq30uLDKvucs6je
         plSv56KRwBRbvMgcCa/U/xfyjHkRIRCzy1mAngVi9oUtA+EjN1tjSo+1kc+YXwSO/myk
         O1sg==
X-Gm-Message-State: AOJu0Yx2tOLxMVf90xLRwRxMWn3nMSOs+RQAU+lUWzhNYBXJh8FERcVv
	8z/k6nhEjjAmYdD5qGVpWCysJ5NTVuPu4fdWWxIF3sK6XO/dxweQ3DQ11W3I7OCh
X-Gm-Gg: Acq92OF8ffi+1Lo/1P3n5Hor+ySHaSoA8+C4mDmFTMwwh8AOnSaKPMRt1HDRPW7NnbT
	ayIOT+rm5GnnGSshvxNp/IRI73YmdHYVve4UCxIX2DYm/VSqY5wv0eC4jtr70lrdiRdbwNN58Sg
	L3WOFV6gzDXGDDQ09I6ks0PseLzvYlS9MVhmmmvaKAITndW7IUfYnIJFpJY1JMN92BLyUfRCR9T
	4G3fd2RBE7enOClZ4M81GCkYu8tKUXSECk3pZ1E2pRh7CVzkSKeWuzqm8ErM952RZYQQk8S3UYB
	31sBq4SUK0CWH6TzzUMzQYebkGzOVgqSSc7tO3MG048PGE0F/IA9pZTAsXWyAoZhBhuhV4cnpxt
	4n5xFnyS8KTpbyMNb5AMKWtoeX8qYxuG7VO7aslDFOccgYrev424ktbAFJ+aHW4KaI4GvWk/Oxi
	E0UfEkruRZ0e3Lodpc2bc=
X-Received: by 2002:a17:90a:dfd0:b0:369:2e00:1ff0 with SMTP id 98e67ed59e1d1-37a024176dbmr4400885a91.6.1781291363277;
        Fri, 12 Jun 2026 12:09:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a233f58ccsm2848924a91.3.2026.06.12.12.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:09:23 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 12 Jun 2026 12:08:42 -0700
Subject: [PATCH net-next 2/2] selftests/vsock: skip vng setsid workaround
 on >= 1.41
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-vsock-test-update-v1-2-7d7eeed3ac8f@meta.com>
References: <20260612-vsock-test-update-v1-0-7d7eeed3ac8f@meta.com>
In-Reply-To: <20260612-vsock-test-update-v1-0-7d7eeed3ac8f@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

virtme-ng 1.41 ships the upstream fix for the SIGTTOU hang
(https://github.com/arighi/virtme-ng/pull/453), so the setsid wrapper in
vng_dry_run() is no longer needed there. Gate the workaround on the vng
version: setsid is used for vng < 1.41, and vng is invoked directly on
>= 1.41.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index ee69ac9dd3dc..310dfc2a39ad 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -445,8 +445,14 @@ vng_dry_run() {
 	# stopped with SIGTTOU and hangs until kselftest's timer expires.
 	# setsid works around this by launching vng in a new session that has
 	# no controlling terminal, so tcsetattr() succeeds.
+	#
+	# Fixed in 1.41 (https://github.com/arighi/virtme-ng/pull/453).
 
-	setsid -w vng --run "$@" --dry-run &>/dev/null
+	if version_lt "$(vng --version | awk '{print $2}')" "1.41"; then
+		setsid -w vng --run "$@" --dry-run &>/dev/null
+	else
+		vng --run "$@" --dry-run &>/dev/null
+	fi
 }
 
 vm_start() {

-- 
2.53.0-Meta

