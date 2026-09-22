Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5ED376475
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 01:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039923; cv=none; b=Ww/0K2I4CXvzEfz77hEHa2deRqMQTZsHkALYkbZgHpxUL1yDNmqn8u12UJO4bnyV7OBhqxOwJMJ+15nMXP+b4u5owWpqGvsrFIWwvtq04St4mZx7qF0uoltLBa02bpT1/FgELI47yYzBVZoBgfCR4kKK+uqVwjG8N6Qv/mkSToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039923; c=relaxed/simple;
	bh=iVYKuJ2DcdFXVTgCRt4VjQYmkYPGzA6mYOOB5aRIk7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HqSLipsmkVoHUr5Qboo/7r30zLP3k9Wc/UWhzMWkhSThG9hXGYcfIXBX9dxei4h7MdRmjdxYGJSli2tx/BxQwn+Wo2DJpLEyFy6IkrHnIIFxwU3F2oTppQUUYjky+cWCVwVdGjjDdaz8vp7bN4YwRgKrX737UeC7VXEi5++Z15c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2qDriEh; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2qDriEh"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4be07e7c54dso402890b6e.1
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 18:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039919; x=1790644719; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45Bl+e2P9YwHGQJKKsleiX3YXi1lYrJXOyTW+Ow8cCQ=;
        b=X2qDriEhpBIFMubI1l6yoQJW2W4PuI31P9t6+IJm5gfsatWpm3kaJY1Id/FG5Qzzui
         t+z5aOQFly5UGXBsoGEYtH99z68PHTeRZLMsbVU68pf+m54v6i1PWlymwfiwQveG8sPs
         8NT/Tl56Fbbcp9Mw9yaGbKn5aMS4UtS9dthCuJ127wUo+Lishpg7c47beB6E464BChGI
         vJJ+yqEqe/xyCYPta1+RNnMF+yBiHNgvu1rYuR9lGvLNRpYG/1VmOerG+S+C35Asa/qR
         P2jGCO3EehlsAbYNuYE4Y0Pxs/PO5SKk0gBq9nsM6iw83zVGksuQSY6+Akz3y6nfnSUb
         Pw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039919; x=1790644719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=45Bl+e2P9YwHGQJKKsleiX3YXi1lYrJXOyTW+Ow8cCQ=;
        b=uxk3k70ueiA3v3/V1VX1ln32KE24ZeXsgD+WWB/PTCW1KrKCAd3ji0BQr+NUld30Jn
         DdEtmQyI0Z8OkO2QLGBAJlAc6nGP8f/97m0LABvFTjLodz3k1RzreJz6+WxWpX3mNduk
         Z9aK3z4xMVkHVZW28s2+9hWTLymlclyUhvn3qeZ5/RoQxDbiYLlcRUl9V1Tx6eM5MLQP
         olLPhXjLykPk7UbMLluQxri9WxWWUdGvtVhpjWkZ0MdnyHYb9M3jOtbN9nmrkt1KKsRo
         W7Is9LlzbMXedNr+XiBJwkLe6w3kioNf4MJYIWIbReav9Z1FsO/py9MFkAn7utBg6k73
         3FcA==
X-Gm-Message-State: AFuF++ngZkzDJvRA85PhwtdqNVJe+z2NgC9kNHTQmTgXIh2QU/fYPEAl
	stmnneChJvUTdS2pfIFcBqm2N5/Hphc/HUdFqMPR+OBpjIirDpVOBkbM
X-Gm-Gg: AYBFou08ihqymAyVOKXGOfI9M86mQ5udDPXQHFvLzcRXregaJpXIiVwUFGU/wYFjjkx
	3cREfV9zvrG5O6zBJRBzfxF56seB+Es8QHC995/zHz4xUoX9TM0uyAicFUa5fnEZVkMrYGH4MWP
	jJawSeAl/9kfyV08iJ1s6Lp0SozDtbwqCfmsj5Inb1132c1EVdVZdfs88YU2S8fmN/T1xifrdUi
	abRQB5ULK7/0I0WK+4ea09+xUHjcpSNpg+118l2rgG2Zt+DOQVua3qXnIU9F3eoxuwtnhYH/nan
	qDu4JoDB810Vg9yANSaG66Bh95wl1w/fYBM0cbdGbtAtqkNZi7XnMbDhfbcsdDLNaqziB52/Dud
	L6Lce1H5LdjeO181Qaud7Fd/8pZZtk3jBYjBfkIQje1Q3TshUjods15xsxvyNfrQsDEv2LjSVfz
	xnwTuV1MW5FyaZ4zG1FXBure5MUFVBRBPsdCDK8GgU7Lc00LEw9Y229HTBG+Exp/OMvfk=
X-Received: by 2002:a05:6808:1818:b0:4b8:4703:db88 with SMTP id 5614622812f47-4d4388a7358mr1277287b6e.17.1790039918606;
        Mon, 21 Sep 2026 18:18:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d4bb6be7b3sm129951b6e.0.2026.09.21.18.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:18:37 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 21 Sep 2026 18:18:09 -0700
Subject: [PATCH net-next v2 6/6] selftests/vsock: test the netns assign
 privilege checks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vsock-guest-ns-v2-6-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
In-Reply-To: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Stanislav Fomichev <sdf.kernel@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

VSOCK_CMD_DEV_NETNS_SET refuses callers without CAP_NET_ADMIN in the
init user namespace.

Add two tests: one confirms that CAP_NET_ADMIN is required even by a
privileged user and the other confirms that CAP_NET_ADMIN in an
unprivileged user ns alone is insufficient.

CONFIG_USER_NS is needed to test the CAP_NET_ADMIN + unprivileged user
ns case.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- Assert only that the command fails, not EPERM: ynl's cli.py does not
  report the errno (Sashiko)
- Use ynl cli.py for the assign
---
 tools/testing/selftests/vsock/config    |  1 +
 tools/testing/selftests/vsock/vmtest.sh | 54 ++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

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
index e94cc2fd90cc..4f42bcdac3f6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -81,6 +81,8 @@ readonly TEST_NAMES=(
 	ns_guest_assign_g2h_netns_host_connect_ok
 	ns_guest_assign_g2h_netns_reset_on_ns_delete_ok
 	ns_guest_assign_g2h_netns_old_conn_send_fails
+	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -175,6 +177,12 @@ readonly TEST_DESCS=(
 
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
@@ -187,6 +195,8 @@ readonly USE_SHARED_VM=(
 	ns_guest_assign_g2h_netns_host_connect_ok
 	ns_guest_assign_g2h_netns_reset_on_ns_delete_ok
 	ns_guest_assign_g2h_netns_old_conn_send_fails
+	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
 )
 readonly NS_MODES=("local" "global")
 
@@ -335,7 +345,7 @@ check_args() {
 
 check_deps() {
 	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter unshare \
-		python3; do
+		setpriv python3; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -1832,6 +1842,48 @@ test_ns_guest_assign_g2h_netns_reset_on_ns_delete_ok() {
 	return "${KSFT_PASS}"
 }
 
+test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails() {
+	local cmd="unshare -n setpriv --bounding-set=-net_admin"
+	local rc
+
+	vm_ssh "init_ns" -- "${cmd}" python3 /root/ynl/cli.py --no-schema \
+		--spec /root/ynl/vsock.yaml --do dev-netns-set &>/dev/null
+	rc=$?
+
+	if [[ "${rc}" -eq 0 ]]; then
+		log_host "assign unexpectedly succeeded without CAP_NET_ADMIN"
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() {
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
+	vm_ssh "init_ns" -- "${unpriv} unshare -Urn" \
+		python3 /root/ynl/cli.py --no-schema \
+		--spec /root/ynl/vsock.yaml --do dev-netns-set &>/dev/null
+	rc=$?
+
+	if [[ "${rc}" -eq 0 ]]; then
+		log_host "assign unexpectedly succeeded for unprivileged user"
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

