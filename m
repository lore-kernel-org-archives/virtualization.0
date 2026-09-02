Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B825782D
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390103; cv=none; b=oZUgLydONfWoZXuKdkoms8GCb31Dz3KREsllHUAYVaHLP4sPc6YThCbSNF5KDLAuEMbLSnVmLrdqHebyF9FQMfSQIQpvjps0lpaa94CDLwzT9tTVUeOMiBNUpN3D8sECBmA7cvRNErMzyxx0kDuoYJkZGCyarSocnqJN/rZjXa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390103; c=relaxed/simple;
	bh=kcIMEAxlbhdfWGQi3kEqTjk3KEi3PkKRsRCd1DxpZ8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S729ro4A/wiJk10bkpFYIeX7lOn2fGJMkX7PSC9PaSlDqLgiPZjkUF14H+bkua5PcFgPSk+qOkTrdjMdEMyGBEaYaXVt6QK8Aq2MJQhOl2THKp5tW6sqVLpXHNLyy0RLNqWTT8G542vOJo4Ei9ccWsT2p2JDoQzWQi1/cuIXPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOtUDWeT; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOtUDWeT"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b3b1b3b992so1037094b6e.1
        for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 16:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390091; x=1788994891; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7bD7DqrZxcDKFi14tO3Iywp9XBJtjTzYJFW9TgEI/w0=;
        b=GOtUDWeTeYWMAR8iN9ksskuldTeE93Nsm3/bYtte2eVueQNQ3NJ5PCpdmwLg4CsyrG
         R02gqT5YsFHnbZAenVW01fWKhKsD4zFVrvYsZsqaB4y2KDZLpdP+dhaSaXPGWKM1+EFY
         38M0YXygacT5kfMzhl6wtlVPTX+bdX4XPoJzpYmfNpj37mZqd6zuw2rWG+EXnoa/snGq
         5+e4j+t1BqUQJwBDSZc/nMkx2SohBes/v949J1cz3ad74bqMFr5tWJQwDY8xOD5KyYg8
         7evkGsOvAcntOhoy440TMO688rRErYzAfMWAAyuPzuP/FgR0LZ58uTZLQvBCxOeIy6Cq
         FhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390091; x=1788994891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7bD7DqrZxcDKFi14tO3Iywp9XBJtjTzYJFW9TgEI/w0=;
        b=KOJlvkzh2A88pkGrcUkquY8fVOcJDisQMFvNz0eYH5hcSSZdufnAIXiEtbaa+FA4Wq
         umvh4i2jmfyYOSIzQUl/aD0Qnv4fSIuvzf/moqFnAAuNUlVAzGA5/GNj6gFGtva/CXBw
         Q+Z8UFtM4C1KIpagsh0Mril7dE/8oW8G6TdkWttJ/Z5Iz+OIMt5jDIHI1aMbLEN45eE6
         YXGk1PGWt51VsTdW7VF9kwiBwp9HuQv4quRC6HuCjc8evVXDWGa10I8rJeak0Z0FZU2F
         VClqNOnv46/Nxyl7yocKvDi7QUL6iHKUSLNr64xEa8hciP6Z+d/El0OMljPeeGKgTK/J
         Uo/g==
X-Gm-Message-State: AFuF++nx//3f0RGTURi91ceKnZ7Z1r4IOC8SHynT5BuJlkaT6i4rhbHs
	NSTiuzL15uXPglIC5kFq3V+cPSIIEI8HrKQldFejeuWNsCbNDAJh1fpo
X-Gm-Gg: AYBFou0wNaHpheTdQxwPHDRRdR2ObWDJO6FX9TFdI6YQFLISt8IfL3Mrv/gImwcGLAm
	td7hnq6+Z2K+IZRGqEe0P/DtD1nXb+BuUR/MczqvvfrcLCyINMvGByEH/+h2lSLd+OANYmHPARf
	QaM/AA+U2pqRzal7/mvU2+8GNTB9v6jCrF1sxDeZwTPludjn0H3b+f8q2Mn0xtYGE3c9Ded8FgH
	xwOuRbuYvEfrD5O1fZ2Eb8Kr/18klW2q1e05y+vBavykKkVFGtee1CnHd9z/QK35H0lMmP2Msaz
	Wy9tTeJXMkjMmjFI2Ir+CV+WetFbIwccXdxh907x1q1C/jZlN65Gkoj6iI1nycqIHe3vsNUOlKF
	RDe4bKt7Tnj58WBOWbTea+V64N9DKr5+shrneqlbXXH64b+X77/Pzsnum0s7bQ5LJjVjuFqd5O7
	a4w5prnd2VHV7WZcrply3MiaB7r4+cBu5VDcok+ui3cunqh6CuguPIb8KP
X-Received: by 2002:a05:6808:c1e8:b0:493:a860:5809 with SMTP id 5614622812f47-4b6bc459a08mr7099648b6e.4.1788390090927;
        Wed, 02 Sep 2026 16:01:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:12::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b69b820671sm3086593b6e.15.2026.09.02.16.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:01:29 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 02 Sep 2026 16:00:52 -0700
Subject: [PATCH net-next 6/6] selftests/vsock: test the assign ioctl
 privilege checks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-vsock-guest-ns-v1-6-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
In-Reply-To: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

/dev/vsock IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS has refuses callers without
CAP_NET_ADMIN in the init user namespace.

Add two tests: one confirms that CAP_NET_ADMIN is required even by a
privileged user and the other confirms that CAP_NET_ADMIN in an
unprivileged user ns alone is insufficient.

CONFIG_USER_NS is needed to test the CAP_NET_ADMIN + unprivileged user
ns case.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/config    |  1 +
 tools/testing/selftests/vsock/vmtest.sh | 59 ++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/config b/tools/testing/selftests/vsock/config
index 5f0a4f17dfc9..4b31085558fa 100644
--- a/tools/testing/selftests/vsock/config
+++ b/tools/testing/selftests/vsock/config
@@ -109,3 +109,4 @@ CONFIG_FS_DAX=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_ZONE_DEVICE=y
+CONFIG_USER_NS=y
diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 53591fa07f1a..efb94d17d997 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -28,6 +28,7 @@ readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
 readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
+readonly EPERM=1
 declare -A PIDFILES
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
@@ -80,6 +81,8 @@ readonly TEST_NAMES=(
 	ns_guest_assign_g2h_netns_host_connect_ok
 	ns_guest_assign_g2h_netns_reset_on_ns_delete_ok
 	ns_guest_assign_g2h_netns_old_conn_send_fails
+	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -174,6 +177,12 @@ readonly TEST_DESCS=(
 
 	# ns_guest_assign_g2h_netns_old_conn_send_fails
 	"Check connections made before the assign stop sending once they lose the device."
+
+	# ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	"Check assigning the guest's vsock device to a namespace needs CAP_NET_ADMIN."
+
+	# ns_guest_assign_g2h_netns_unpriv_user_ns_fails
+	"Check an unprivileged user cannot claim the guest's vsock device via a user ns."
 )
 
 readonly USE_SHARED_VM=(
@@ -186,6 +195,8 @@ readonly USE_SHARED_VM=(
 	ns_guest_assign_g2h_netns_host_connect_ok
 	ns_guest_assign_g2h_netns_reset_on_ns_delete_ok
 	ns_guest_assign_g2h_netns_old_conn_send_fails
+	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
 )
 readonly NS_MODES=("local" "global")
 
@@ -333,7 +344,8 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter unshare; do
+	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter unshare \
+		setpriv; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -1805,6 +1817,51 @@ test_ns_guest_assign_g2h_netns_reset_on_ns_delete_ok() {
 	return "${KSFT_PASS}"
 }
 
+test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails() {
+	local cmd="unshare -n setpriv --bounding-set=-net_admin"
+	local rc
+
+	vm_ssh "init_ns" -- "${cmd}" ./vsock_assign_g2h_netns &>/dev/null
+	rc=$?
+
+	if [[ "${rc}" -ne "${EPERM}" ]]; then
+		log_host "expected EPERM (${EPERM}) without CAP_NET_ADMIN, got ${rc}"
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() {
+	local helper=/tmp/vsock_assign_g2h_netns
+	local unpriv_uid=65534
+	local unpriv
+	local rc
+
+	unpriv="setpriv --reuid=${unpriv_uid} --regid=${unpriv_uid}"
+	unpriv="${unpriv} --clear-groups"
+
+	if ! vm_ssh "init_ns" -- "${unpriv} unshare -U true"; then
+		log_host "unprivileged user namespaces unavailable, skipping"
+		return "${KSFT_SKIP}"
+	fi
+
+	# The home shared with the guest is root-only, so place the helper where
+	# an unprivileged user can execute it.
+	vm_ssh "init_ns" -- \
+		"cp ./vsock_assign_g2h_netns ${helper} && chmod 755 ${helper}"
+
+	vm_ssh "init_ns" -- "${unpriv} unshare -Urn ${helper}" &>/dev/null
+	rc=$?
+
+	if [[ "${rc}" -ne "${EPERM}" ]]; then
+		log_host "expected EPERM (${EPERM}) for an unprivileged user, got ${rc}"
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
 shared_vm_test() {
 	local tname
 

-- 
2.53.0-Meta

