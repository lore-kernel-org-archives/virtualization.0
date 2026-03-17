Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC34364EA2
	for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785387; cv=none; b=CU5rdInhS/Xrbr4iniSuvJECGvocGF/xZsudRT3A4g8RPvYsTAE4gHlsb5C9YUTEZgAjVAzWwDCWLPzbJiKX3o8h+hlwgj6O6XtZfIinXESctqyUMYFUJSiNQRU2TbLFeY3SXhweMBiSz8Ow57dY+kE7eYQ8Lx9qBaJS3Sr/oP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785387; c=relaxed/simple;
	bh=FBy8AtaAcW3f/5x6drndhY5A+fYaOe5p6SxUT4nTXdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y8jEZ8sSu2gjky/CCM+v6qSLL2XrHZJ/F3FqAPqt/xEt7Vdp1Kq+fmpziQRr3+mkC6Y3Xq65nnwnMgJUuVH08C3TfA0Vq2F/9WLY1elQmfjMi68dfxkvDql6JdDZzQndMivTAlTA8SiO7rMXB3wQQykDXAQqVuJcJiUAGa+SGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxV01Ysj; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxV01Ysj"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-798374d0f44so5905717b3.0
        for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773785385; x=1774390185; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjfBq/ftguqa5YG03YiYsY84WTL2L0ZPXeWuB5y9CnI=;
        b=WxV01YsjJocoGCpKNoTTpVpktSQv2RINWV4QPIsoz4DcNoHV07e5UJKr5JTiPqFngf
         1KC0bywrYRUaXvVb+kRSd3WGwUDGTBUVbIJekSDW8F7VtqrOvaX/GCsOSqsN6ZymwvTC
         iUnb8OmHWdgIehAnHB6rzgXz6qVoL4+AKb62pMgTPKjAbtgFcigVKbxvRlQPJcdcEb0Z
         RjE8WIvUse9q/+gHcpoH3nTGuFllE7OgScxTrcbul9Nu+PItfqTpr9F8myd+9m6d8fkk
         p25P6zplDTaqx0P0syWK4CBR+EQkKEat7rQTLK+q0AiZfWl6aviUjw8H0RC2p4+MafzH
         0EVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773785385; x=1774390185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TjfBq/ftguqa5YG03YiYsY84WTL2L0ZPXeWuB5y9CnI=;
        b=bulCSd4CK4yMkEAOBUO1bDPdYcK62ZUcBk7HAb1qnG+oOdImR96m2NiiT0eqN+SKXu
         C8wSiopbJbvLdaMF+Ep+hGVjfkMbFCwvh3xSmmWg8frhO6dsPeyCDk9irtFL5qP9nDH6
         5RYRZTbq1Fux/Ha5CAthaUKoS6iH4unaUiwJm2GrT0WkLMhjIEKuGnVSY/1CgUER9gr2
         Qd1ETZi+G0KcpJ7e/1PQcXLZghhMPAf5DR53LgDYP5hS3lwF0eay9Nh5kxB0brn3orgX
         jC4V4ONGNmSCLlXJ9edlDuguieo5fVcHAsPIPLbzQKIDuD29Gdd3+wG4bSW2l0UjScyc
         3XSA==
X-Gm-Message-State: AOJu0YwUWIP1fIPxb2s6QsHDhV7X3JNY37zQleyiTjnh2QHC/reMnXrx
	H/hw36qveTJ+0QJkSK0IKjxWvP/VwsTXV4p7vdw6egsueKoHyE+sKq99
X-Gm-Gg: ATEYQzyUHbqg0tXEqNdarh1n6/hr/oawHvJtdlScRa05bQPfCIGASQtoF4Wbyltt6lV
	ISTvM01/xySXOxnkX8YGbRgrAY2XmjBC9K0KIg77DEdzNPAPyKNQpGKF2bMevxIjnPiFQ4MyhrS
	gv6wX3CV/fGcAxxrCzO4IKKkbJ7qOyD6zQeL4ImN15hZ1JxFZW/1mh8XMrCTBdxC860AjPluBVx
	2wA16sZ/vxeNh8jSYlGT9B+8rtLCbtNe78gP6jJxnclEmivNeCeh4OJ+LDiHnVuk9Mz0mnAuQ9P
	g/A7z1VGm5E3WCk6HSKaPL2+5MusXykDbpvkm7H8uikPMb2PeOBMU0DQPrbRH9Wr8qyuetBr+Pd
	/mJuiVMRE7LMlAz8KkcMlSTpxhZ/A2cEItWYgy6DJcY1QbvS1AU6338j1hFZlLJIwfSph8uF8H/
	BIHuL+kLeQS4v6oQC5XMWe2g==
X-Received: by 2002:a05:690c:6ac1:b0:79a:3e64:c15d with SMTP id 00721157ae682-79a61930f27mr46203767b3.31.1773785385300;
        Tue, 17 Mar 2026 15:09:45 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a713d9d98sm5600677b3.15.2026.03.17.15.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 15:09:44 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 17 Mar 2026 15:09:36 -0700
Subject: [PATCH net-next v2 2/2] selftests/vsock: fix vsock_test path
 shadowing in nested VMs
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-vsock-vmtest-nested-fixes-v2-2-0b3f53b80a0f@meta.com>
References: <20260317-vsock-vmtest-nested-fixes-v2-0-0b3f53b80a0f@meta.com>
In-Reply-To: <20260317-vsock-vmtest-nested-fixes-v2-0-0b3f53b80a0f@meta.com>
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
index a4b56322ce9b..30c06544f2e5 100755
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

