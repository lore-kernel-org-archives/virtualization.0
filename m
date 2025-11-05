Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E933277BA
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352763; cv=none; b=XbTRULCz7/IodJUMCIgECGdk3Ey16EqiWRZo+tOOmzVRu+rq2hHRaekGxT8puFp5NDG8mbE0lNOLWI2XP5e9G/PpW/xw57LDdK01kxvGPYppAC1ks6KpV8JCmWrcqEtSNJrLB+/ck73F5Te9G+yUzn427Op7HGPsz4NYaA4APtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352763; c=relaxed/simple;
	bh=N+EK1Kxp8qxWEiuKYA9xEBkqzBsi1k8ar4ofTabGyVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sxQqC4JMUuGIUdN7q6jCj/ndqHbPJHDwUmWRSHw5TaOV2rjjZBCFGivYzrFrzkPJ1FXnt7P7QRlilJFcvhSdl5jiUwGyM7zA37YaiCTH2mQ8kgghJcJ0S+3XtVEnwd8zaDerxhfMwcWlDypH5GKjolLkbIcIbfrd6QuDSJ0kFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrMHJy5d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrMHJy5d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762352760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Haea4m2+uFf7hS1qpomFR5hmGiTU6exHIPsfHUZpCc=;
	b=GrMHJy5dWuYgR97CEtZq2R55NjWh/3Fo5pyS8xH48d7+p8AIL83g6igQPa58Bu92Ry4U4Y
	9J6Li7Vc02xM40y3UOlJpLjSl/Nz7uIwDB9cyLtzSlK2Zp8kaJbT4ZWPFtOZ4BsFKEld+2
	t2s9wnOy4mgkMfrSn1L8/risfwf/VKI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Dxec-OxNO5Gz0d9-qf4fTA-1; Wed, 05 Nov 2025 09:25:57 -0500
X-MC-Unique: Dxec-OxNO5Gz0d9-qf4fTA-1
X-Mimecast-MFC-AGG-ID: Dxec-OxNO5Gz0d9-qf4fTA_1762352756
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c5c8ae3bso3957323f8f.0
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 06:25:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762352756; x=1762957556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Haea4m2+uFf7hS1qpomFR5hmGiTU6exHIPsfHUZpCc=;
        b=ljTN92ZICNrk0OpPsR0wKzVRVl7wrPTiaAKNYzYkkGvjAwXllslEbqPZdUhwxtAkJA
         +eKU4WmY4jDby9vyFJpMKP0YuEx9B0me9wZyiDB+mh3YAvvD/9fflsWnsh6WUpt3Xv7A
         Um5JXVMc20A3sPC/+xHDaxorFzeAUE1CJVJO4lbRvAPJJjxIM4hQh1qIrvoDHIEwUnTt
         WhPNMyYkc2d9mzadTkhKHBAJprXirSyiXqnNSNoS9fo6qqlYK4e71+3aG3MPbxqCGNop
         lGkJYKoADmgJGYZHVfPmmcy4SsjMocMrFgdcte23X2G7TvnLm0rfL6BaU6zZAYJzZ40M
         cHdA==
X-Forwarded-Encrypted: i=1; AJvYcCUDnG3nnWmvBT9T6SuqSiF9g45+5rH+DyHf7L1LQaOXrb44l4VDYRDh2ONZ2wgHBDbqA4Ahb8vfs8fmHzBk/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVZK8w6UYP2Di9a1LBJvQPRQna6YAcEX5dhD2AHgSg63/GyinD
	9RMnX2rHVGNbnfxHpKyEDyo1yWV+DKEhViEtvlhNXB7HoUBCO0dvvwGb8ota7jjup+tWJLOHCl3
	Pit3o7tUFyUDPnKGvz54MaRM7kBO4k3o+pS/mCoNfmgwK+ur7Lp+kdIQjYWPwctp7Waox
X-Gm-Gg: ASbGnctZ9cI6GpU4phtGsqqG/Lp7qPZz9QMYzMBzJOp2Wo1ubEfNc5+A/ATZaWTv1Uq
	p2N3NhcKHGZvmpLdvJ7+HzMTips775sS2l6qgqr1V+TC+IHzfbiUhFEfjWbAIYB1IqrDlAjlX/d
	9RnHEFzAhYJtyur7h1RoBUKvr01icKbRNv6T4bu1kAkqRq6l+6FiW0uVkdghHXZEGVP+tCd0+Po
	gZodhQzYIqdwHo5+hL+5XkUjzf+THgpAIk+VePoefBRYkVQiC7tf0U1XiU356K84dTAX27zSYvX
	9z/NtyAzZdYtefGbT1q+TfOFx6PPYH9kueRM2CZXX1GtkX+BFLQS7AVvpWNa5i5rnPqT3G8GzG0
	=
X-Received: by 2002:a05:6000:40da:b0:429:ce02:c895 with SMTP id ffacd0b85a97d-429e330c220mr2577743f8f.50.1762352756184;
        Wed, 05 Nov 2025 06:25:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4x/Sllh30KcFpre6XL8hFdFV5BshGdQVTU/zf2P/M8C1K9+V8heW7EYih3ymwmEoRBZPFvA==
X-Received: by 2002:a05:6000:40da:b0:429:ce02:c895 with SMTP id ffacd0b85a97d-429e330c220mr2577713f8f.50.1762352755717;
        Wed, 05 Nov 2025 06:25:55 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc2007afsm11067852f8f.44.2025.11.05.06.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:25:55 -0800 (PST)
Date: Wed, 5 Nov 2025 15:25:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <bvzstd363kuvzfnxg6r3dfxtkqswcdz677rpvutgugfep5ecsx@6rlyaud34g7e>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-3-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-3-ca2070fd1601@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v8ejJF9qMeCxj7Rrvd73EqLE-XSZ-dYpc2uIK0P3GMA_1762352756
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 04, 2025 at 02:38:53PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
>the vsock_test binary. This encapsulates several items of repeat logic,
>such as waiting for the server to reach listening state and
>enabling/disabling the bash option pipefail to avoid pipe-style logging
>from hiding failures.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 130 ++++++++++++++++++++++----------
> 1 file changed, 91 insertions(+), 39 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index da0408ca6895..03dc4717ac3b 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -273,7 +273,77 @@ EOF
>
> host_wait_for_listener() {
> 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+}
>+
>+vm_vsock_test() {
>+	local host=$1
>+	local cid=$2
>+	local port=$3
>+	local rc
>+
>+	# log output and use pipefail to respect vsock_test errors
>+	set -o pipefail
>+	if [[ "${host}" != server ]]; then
>+		vm_ssh -- "${VSOCK_TEST}" \
>+			--mode=client \
>+			--control-host="${host}" \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" \
>+			2>&1 | log_guest
>+		rc=$?
>+	else
>+		vm_ssh -- "${VSOCK_TEST}" \
>+			--mode=server \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" \
>+			2>&1 | log_guest &
>+		rc=$?
>+
>+		if [[ $rc -ne 0 ]]; then
>+			set +o pipefail
>+			return $rc
>+		fi
>+
>+		vm_wait_for_listener "${port}"
>+		rc=$?
>+	fi
>+	set +o pipefail
>
>+	return $rc
>+}
>+
>+host_vsock_test() {
>+	local host=$1
>+	local cid=$2
>+	local port=$3
>+	local rc
>+
>+	# log output and use pipefail to respect vsock_test errors
>+	set -o pipefail
>+	if [[ "${host}" != server ]]; then
>+		${VSOCK_TEST} \
>+			--mode=client \
>+			--peer-cid="${cid}" \
>+			--control-host="${host}" \
>+			--control-port="${port}" 2>&1 | log_host
>+		rc=$?
>+	else
>+		${VSOCK_TEST} \
>+			--mode=server \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" 2>&1 | log_host &
>+		rc=$?
>+
>+		if [[ $rc -ne 0 ]]; then
>+			return $rc
>+		fi
>+
>+		host_wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"

IIUC host_wait_for_listener() doesn't have any input parameter, should 
we add them if we need to call in this way?

Stefano

>+		rc=$?
>+	fi
>+	set +o pipefail
>+
>+	return $rc
> }
>
> log() {
>@@ -312,59 +382,41 @@ log_guest() {
> }
>
> test_vm_server_host_client() {
>+	if ! vm_vsock_test "server" 2 "${TEST_GUEST_PORT}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=server \
>-		--control-port="${TEST_GUEST_PORT}" \
>-		--peer-cid=2 \
>-		2>&1 | log_guest &
>-
>-	vm_wait_for_listener "${TEST_GUEST_PORT}"
>-
>-	${VSOCK_TEST} \
>-		--mode=client \
>-		--control-host=127.0.0.1 \
>-		--peer-cid="${VSOCK_CID}" \
>-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
>+	if ! host_vsock_test "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	return $?
>+	return "${KSFT_PASS}"
> }
>
> test_vm_client_host_server() {
>+	if ! host_vsock_test "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	${VSOCK_TEST} \
>-		--mode "server" \
>-		--control-port "${TEST_HOST_PORT_LISTENER}" \
>-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
>-
>-	host_wait_for_listener
>-
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=client \
>-		--control-host=10.0.2.2 \
>-		--peer-cid=2 \
>-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
>+	if ! vm_vsock_test "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	return $?
>+	return "${KSFT_PASS}"
> }
>
> test_vm_loopback() {
> 	local port=60000 # non-forwarded local port
>
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=server \
>-		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest &
>-
>-	vm_wait_for_listener "${port}"
>+	if ! vm_vsock_test "server" 1 "${port}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=client \
>-		--control-host="127.0.0.1" \
>-		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest
>+	if ! vm_vsock_test "127.0.0.1" 1 "${port}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	return $?
>+	return "${KSFT_PASS}"
> }
>
> run_test() {
>
>-- 
>2.47.3
>

