Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D881A681D
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 00:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446454; cv=none; b=OwKTf8KtK4SbU48C7UqGm9JlHFzDj0jhRmDmVyuFNoOh+eg0WEvlCRNQz2Pk0/xQFzCyU9Kxck8WkbgzJjU4TutgpkFtc8/gisHYZDs6RDVatjst0Ldrh6cXPkAOaNhgkhvmYDtAls0zTkNezvvvWXxRYoHNLpewISUt0Rh8Ryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446454; c=relaxed/simple;
	bh=qQSv/5WdpZH4XBXZwbx9dzgQ4o8yOA7GNQGX0IAwggY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dXWpBe9bE6452+qq5XuEtHBfYaw9s/yf2gyFikEmMHhUkaWf9qtzTBC0E321vXtupUZHC3ihbc8em4GudF9sUroB2DTZqZAwmv+ti6dbWOvCJTWRr+w/PjaztudKNkfRWqhAWOLwatQlsH6oD4o/ygOVY+nuXsIboZ3Rz86auLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4LLk7ah; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4LLk7ah"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79801df3e42so39686877b3.0
        for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 17:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773446452; x=1774051252; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W86A6Y/31ihOHZ6/xNMK1KyCGKpHT+7je3oM4+QBYPA=;
        b=A4LLk7ahWU7ggyEb+Fq6IwD2XPELonMtzqLlSaaYZvoLei7HpRTkb33o1vPbWjrx7L
         GjzwO5jtSdEXmgQ1TFLvUY0XCoQmEYIkhvA9G9GHKil88JQPkIJxefOBD7E/2WEi84os
         +xIYWirGknROT3XH23ydGkZW1Mb0Qa+aIdHgNHvEG9jOs1ekc+Wlm4KlNkJO0aUnGAxV
         Z94pppgMQB0aW2W7+I9pcCVA0Kw7CkwGHN+gUN5O4SRKoylweeIysZfIGTcnbDSrq+3s
         oTxDIb1TICoCmc4nGpYVxPuCo7yXFcPT1Q6YwCNtoDHems+s/WBU3ZF4FNPM7oBhqzQ5
         YLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773446452; x=1774051252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W86A6Y/31ihOHZ6/xNMK1KyCGKpHT+7je3oM4+QBYPA=;
        b=rEm2AWMz+JeTLaOgj1t7CPmfVpPYc0jLXHMLxQJ9R3ISZ4zohWos3CW2qw9L23lL9f
         aqg3nil1wwYAbVmLuQiJRVrVKSNrTNwT7bYPidms3/0RLEQLAyr2TVsLPYtKSftV8vnq
         CFdjy+w413SZ5igTzA+6Fy/VSzWDgz9utc4DeFouvABmHqyNn8O3Qdsu4rpuEQAfMzww
         d7LH26V2gxTGQe/iY304tpXByMur+rEFS/wgZYj1tCLVrBO+55H/8ql+9nrI6zFRfN2b
         v0FmmZUqPxJ1vR1dJKp7XS1YSnBoXP0GhKT3ASYtWVRe1PN1BuAbA+9NUeY5NBXUojbi
         6ewA==
X-Gm-Message-State: AOJu0YxniC8l+QUp8gS/IXDCIPu960bXkmFTZ3RT7p/ulxBPIQoWhnZv
	dvl8pvkOMLfrUfKGcfn6/c+fcB25rZJhy5y/dLFIU77gROwy5pxjQLiw
X-Gm-Gg: ATEYQzyhPsrHgFYkLeQ7o8dZBZ/k8FJbPwEU47Wq2ePIVMOx0AGYciNpw2CTcDUVBLl
	CI0QYo4XAPyAveD7No29t1/Pcqfbt/rSebsInSTETSZP5B0mykuMMV4RJ1NQ5atJ1wabghlR7lN
	URbopumaM5afyzw2UzEA2e9v35QZik9sEmhT9F1WMfmq3vAw4R8eOL390AAlzrpoFUUgFqhZfNe
	2UGV6xOXnBZtyLGoXaHHRgnnyxlQ6yPkG02ZYThsa1cIck4ilXVBSpsxuCd2k4Mvxf5EV7rIj8p
	8xnbluOYpNL2xTOe2u8cXXBv26CM3WHTPV3Gh22tpFmeBG/h9yluFzPT3NFayh1iM0Q0mBci2XH
	jOVmeqUlelwotaARLSUDp78Xl3rLrIaWKjDy6qqVX75L10qqDqrUn2IgnGabU3Ldq6lnw4bUwuR
	Xzxcee8Mp+CBEvbEHW2jQo+Q==
X-Received: by 2002:a05:690c:348a:b0:794:a8ea:f04a with SMTP id 00721157ae682-799475ee218mr90550227b3.20.1773446452052;
        Fri, 13 Mar 2026 17:00:52 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f1ecd9sm54769307b3.45.2026.03.13.17.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:00:51 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 13 Mar 2026 17:00:15 -0700
Subject: [PATCH net-next 2/2] selftests/vsock: fix vsock_test path
 shadowing in nested VMs
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-vsock-vmtest-nested-fixes-v1-2-d0e6274c3193@meta.com>
References: <20260313-vsock-vmtest-nested-fixes-v1-0-d0e6274c3193@meta.com>
In-Reply-To: <20260313-vsock-vmtest-nested-fixes-v1-0-d0e6274c3193@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

The /root mount introduced for nested VM support shadows any host paths
under /root. This breaks systems where the outer VM runs as root and the
vsock_test binary path is something like:

/root/linux/tools/testing/selftests/vsock/vsock_test

Fix this by copying vsock_test into the temporary home directory that
gets mounted as /root in the guest, and using a relative path to invoke
it.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c2cfcdf05d99..8182c748f214 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -393,6 +393,7 @@ handle_build() {
 setup_home() {
 	mkdir -p "$(dirname "${SSH_KEY_PATH}")"
 	ssh-keygen -t ed25519 -f "${SSH_KEY_PATH}" -N "" -q
+	cp "${VSOCK_TEST}" "${TEST_HOME}"/vsock_test
 }
 
 create_pidfile() {
@@ -601,7 +602,7 @@ vm_vsock_test() {
 	# log output and use pipefail to respect vsock_test errors
 	set -o pipefail
 	if [[ "${host}" != server ]]; then
-		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
+		vm_ssh "${ns}" -- ./vsock_test \
 			--mode=client \
 			--control-host="${host}" \
 			--peer-cid="${cid}" \
@@ -609,7 +610,7 @@ vm_vsock_test() {
 			2>&1 | log_guest
 		rc=$?
 	else
-		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
+		vm_ssh "${ns}" -- ./vsock_test \
 			--mode=server \
 			--peer-cid="${cid}" \
 			--control-port="${port}" \

-- 
2.52.0

