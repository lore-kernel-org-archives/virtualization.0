Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD954418CB
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033542; cv=none; b=i/2sDXFsVUp7G+LwSzSY9vW091Pks3pNtbPiroM+CPhHxQAfr33TwDYvnMNJ9hvkxXRTYsF1jYIu1fHvPcGUqjEMlRqARF804T+zf9AQXZehPcKyWgJVC6d10vQfuckfLzCLcbMoqWiKjPiig3kTo0JYliygHUOpW28vYprwxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033542; c=relaxed/simple;
	bh=43YZlXDQmW65hszyjr5m3UtpfpB8+72+oSXEtxR8B+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QjGJlL+n+CySxJMlJyn6Y5W8vYFNLgECrXb1vsY8GmYvVBWmBpLSfy7wnubu3evk5ruqrJBx6rQPf/jOpoFwRxuwIX4py1sO1ztDS4Hrr+B26BbgC+la3x47DHKOxqM3gvhKeV5qrk5PtE9HXLMN/9DpXpJtsqJUyFnBJe8JXPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIz+NWSF; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIz+NWSF"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7927541abfaso3189007b3.3
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 14:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033528; x=1769638328; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=VIz+NWSFs5nvmC2nzDzJStk9lhiCpGrWF69FgFOEjTW25ua/0oF5eu7zDJUh28EWgq
         E5tfO1TkaoMLeQRLAZREqWSw2Gc5zXbJ1MSS4QVmMjNaqlV/eAtXNqLZeJkeg76u7Vyq
         bclplcJdgtsL66mtDOAKmrb+KWSvRQoDB7IQyXvfT3+nrn2ZUYE9JGDYWoFyXJv7trQb
         d2Vdmk2bTQAb8vgLwZ7fgq6ARGSue/4ODOMfnnAIgEitqdWXFMle9WnDttpTum6sM5AA
         ui2zfPlP8AZ9Esdhhb1UJe/B/sHv/aGWQAcMCfBp4A85OObdn+HDFQzc9W8lqBmCmgGf
         tPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033528; x=1769638328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=wgqB8KJAqYhDwgX66czUCfr1UOjSL6CQVBjsuSIzq+nY7721lkUnRePGjXt2UneiDC
         Dw0S+q5h13G4OCYefiwqw9IfpgSjQmllA41Jj+dyzHB8sqMlM4LVI/j8wsvc4R3fxOGA
         uf2lhFejS9YBHmg1A1WMb2LJsPTUFapriG4Idi0d/9d/37XZGip+M7bHZ2Da9IakZ+5n
         CFUO5B/NHtsGpgDwz272HeNXjg0cOSI8iR5vSs8ywRJLGUoHfk3WgZQg8dCamjrnZ3Tg
         c/jk7MOkPj0vJBWUD0rFWELDLXkITYkVrVB7FQ5Uz/dAELzb0Ibxf9hnBPGxuHnJ5dtB
         1fJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoJHZKbQ55OkzC3cTgK3it36/X3k86Apt1XkHhx4bDtZBgeLr1jUcFYjIZCgcxjHbc1IIAY8fYx1czqfKxhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyenTDXt46+SB6bRscqmfR0nGfrhGEKzgyZMMrQ280zvfHKvYWd
	pVOi2Mzbfazhtka8kVB+PHzqPQNesZKUCRBOw121D+20/aIzyF4C/dcn
X-Gm-Gg: AZuq6aIYv8+b0NwBh5x8SM85ONpAXIvLzDSYZAbVQdZdRXEkOv6cm1pOl5ev6w0fhQl
	jgpzMc03VU+BV9XniTC7yONhW/hfmBfnlqLJl8+OsbsO7cGmEvybfmC1KwPFPf4KYfZJ9fTAykx
	3T/o/PzXME94BwTABHsSX5O73ZZAGVvJtquTFcnCifPIcvVdSa/U8ife3mVvcVNXWOfTY4cz+LP
	fGtpjlIurCQj0Y8fGOy06duI2gxlmQ41efsN2sXuO8XlU7tlwjpxea5cgDQvZ7JSr8Ie8fE4gHe
	A6WZclej1X3uGe/Pl/tfh3gNDahIEzgpDvi6/E2DoGAeBhFUyBGJC9taSmSpW7k1Sb8n0P3fAM3
	mEaNZXWv3FplpTvcf2trrZNMFic/vS8yFvvqVDeZdnbpMZ5PqXF/Cp9oI54AW9GnXLdS2KDTf8n
	966vQn8HBkgA==
X-Received: by 2002:a05:690e:134c:b0:649:328b:66c1 with SMTP id 956f58d0204a3-6493c85636fmr4655728d50.71.1769033527964;
        Wed, 21 Jan 2026 14:12:07 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6494686dd20sm1661755d50.22.2026.01.21.14.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:07 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:50 -0800
Subject: [PATCH net-next v16 10/12] selftests/vsock: add namespace tests
 for CID collisions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-10-2859a7512097@meta.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests to verify CID collision rules across different vsock namespace
modes.

1. Two VMs with the same CID cannot start in different global namespaces
   (ns_global_same_cid_fails)
2. Two VMs with the same CID can start in different local namespaces
   (ns_local_same_cid_ok)
3. VMs with the same CID can coexist when one is in a global namespace
   and another is in a local namespace (ns_global_local_same_cid_ok and
   ns_local_global_same_cid_ok)

The tests ns_global_local_same_cid_ok and ns_local_global_same_cid_ok
make sure that ordering does not matter.

The tests use a shared helper function namespaces_can_boot_same_cid()
that attempts to start two VMs with identical CIDs in the specified
namespaces and verifies whether VM initialization failed or succeeded.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- check vm_start() rc in namespaces_can_boot_same_cid() (Stefano)
- fix ns_local_same_cid_ok() to use local0 and local1 instead of reusing
  local0 twice. This check should pass, ensuring local namespaces do not
  collide (Stefano)
---
 tools/testing/selftests/vsock/vmtest.sh | 78 +++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 38785a102236..1bf537410ea6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -50,6 +50,10 @@ readonly TEST_NAMES=(
 	vm_loopback
 	ns_host_vsock_ns_mode_ok
 	ns_host_vsock_child_ns_mode_ok
+	ns_global_same_cid_fails
+	ns_local_same_cid_ok
+	ns_global_local_same_cid_ok
+	ns_local_global_same_cid_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -66,6 +70,18 @@ readonly TEST_DESCS=(
 
 	# ns_host_vsock_child_ns_mode_ok
 	"Check /proc/sys/net/vsock/ns_mode is read-only and child_ns_mode is writable."
+
+	# ns_global_same_cid_fails
+	"Check QEMU fails to start two VMs with same CID in two different global namespaces."
+
+	# ns_local_same_cid_ok
+	"Check QEMU successfully starts two VMs with same CID in two different local namespaces."
+
+	# ns_global_local_same_cid_ok
+	"Check QEMU successfully starts one VM in a global ns and then another VM in a local ns with the same CID."
+
+	# ns_local_global_same_cid_ok
+	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
 )
 
 readonly USE_SHARED_VM=(
@@ -577,6 +593,68 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+namespaces_can_boot_same_cid() {
+	local ns0=$1
+	local ns1=$2
+	local pidfile1 pidfile2
+	local rc
+
+	pidfile1="$(create_pidfile)"
+
+	# The first VM should be able to start. If it can't then we have
+	# problems and need to return non-zero.
+	if ! vm_start "${pidfile1}" "${ns0}"; then
+		return 1
+	fi
+
+	pidfile2="$(create_pidfile)"
+	vm_start "${pidfile2}" "${ns1}"
+	rc=$?
+	terminate_pidfiles "${pidfile1}" "${pidfile2}"
+
+	return "${rc}"
+}
+
+test_ns_global_same_cid_fails() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "global0" "global1"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_local_global_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "local0" "global0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_global_local_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "global0" "local0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_local_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "local0" "local1"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
 test_ns_host_vsock_child_ns_mode_ok() {
 	local orig_mode
 	local rc

-- 
2.47.3

