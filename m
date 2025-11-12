Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD32F2EE612
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946396; cv=none; b=ZgclUhz8so5uPIqru/v+HOW1exyOC1vVTuAXbcS1CRxs0DaU+vYh/YZ3uw7IiGLrg3qPWIxKMnQMv0Dw4cs7eHf0sVC+hmyub14RXb4yOCqCyQRr8hlHwvv2wCBzlDMdsFCdj/FlrZ5Lw9hktnkQEiYxKN43xEGWMifh7+an+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946396; c=relaxed/simple;
	bh=OKClyKv8Ey4yyuKqx+8b/7B4wt73VZkmnz6uZGpZgUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cinULAk1lHV6KnMh8F3wgzNnAxWkZoUnYuoQnzicXf9/wgmsl664v3uxKZUfLC0JkAiHKo49tDhN0dHbsp9WPBOUVvb99QpFEu3iHz3WiGsoOaFKM2ZIHxBshmYRpLo0szCsvDu31N21ux4l3RXRwLC5c1y1nyyzdaQt4uLFG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMO8Lprp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMO8Lprp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5FDYwKVcD0dlATlv10YwLZFZcLbAZEaa4NsDrv83O14=;
	b=DMO8LprpeCMvGkiN1r2bMLNGq4XPClpPe1sKWaXDoTh+SeS096bb9V8UhnKS4i510hSXUT
	z35WTYT0vv+iLm5rRR2hg1QC/IUp2NMTpqZXtLviB9E/cy0LIdxyuM+onKozulBZaU6BvP
	I8/z31aEvgo2AdguN1ZFQHks3R7QmCE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-yLaLaqEuOryeyUZaw-dsZA-1; Wed, 12 Nov 2025 06:19:52 -0500
X-MC-Unique: yLaLaqEuOryeyUZaw-dsZA-1
X-Mimecast-MFC-AGG-ID: yLaLaqEuOryeyUZaw-dsZA_1762946392
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b12cde7f76so187011485a.0
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 03:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946392; x=1763551192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FDYwKVcD0dlATlv10YwLZFZcLbAZEaa4NsDrv83O14=;
        b=MEHF26Ly9zD03S49SomQBOchPCajlNCUMziMbitN5sIm1t27KFujUVFwehx+u5QjDJ
         prHURyPwJK0nwN9Tjy8AONO9y03l30eSkOkui+gLrsMStVXrccfsaWdNcfz+TZf9H2dD
         Z3fw5wk7lQBkuNuXBI9X9NqoCMoClLrcb01clG6IYsBb60Y+rSLUzM0YsuurqbecS4L8
         8gGOGc3Bfh25LWlWY3UvnwidjTguSDBDorjgX3o/7/nG58HMJm714LExxOy1m85hKQG4
         4H79iTH5gNLjzgDnfgADQgiSHsG+h8hsucyCieBS0BrGyr+4gP0eOGpp6UmMyAHaCCVp
         15Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVaITAblkzjNGf4boX880NoZey6l8A1KSZ07RrW7kBde8F8VcWt6wDxKjxrXWTSddcBUCr4a7DN5gkKJ87lcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDMZxgw3BQTrMSJhpTo71UXbVfGdFcBcIozcVpbpORFDeHqFVT
	GCwy08PXSpSTO7Rve5kqsN6KOzpv1fSG5m600NGH0qKsYiWncI+KM/Qcr0k9+Du6MmVgEWPHmTD
	GnCVVM6iblN1t+1VemLRuS/qoJu63EPtm2h2XfOcgSxDX0WnMf3hsRkjUj8HWn+Ot0o83
X-Gm-Gg: ASbGnctqZ+6dY9O7QH30tM1xfi4uVdOPljuGzJHPNmAk3n0J6wDgcaAV7W1rKBIeWub
	NGKppLsNFoC/iCqRQNBC1RO6R1x/upMb7RDVyDamYj5W1265LNKDGGWrwNjrsWZX34J+1pOJzRN
	bg9q2ui6SfiSTRIYQ1+h51LqsQOsuauSdYkfqauqLLHUFEt+NvMIRrxppSWfdvdqiZHffKuanZ4
	PAm+Iw8S5hRNoMFIp2NCv4o+TUDRZPyZ4XxcNQt8T6yZ8R7IKk45bwONgGr/+Rc0D5ynmu/pwTh
	jfvfaywrytzEnSEKiNHheNxSI7D72iZCECnMaHStS9nfAr4F0JzU1ykc2l/LFFYp/PN2La3lJkS
	06VE8Vf7Q6NTa2cx9pyOS9sEbwj7zHYcMd06Tj1qlO2yrqXMweQc=
X-Received: by 2002:a05:620a:199f:b0:8b2:1fa8:4684 with SMTP id af79cd13be357-8b29b567d9dmr336593585a.2.1762946392089;
        Wed, 12 Nov 2025 03:19:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJO/67hI3KgrbQB/aVYyZeSEB0IiwCxk5hDgSYA6vjxGWk6oN9tzaQ+qo21OHmRNB+WCUySA==
X-Received: by 2002:a05:620a:199f:b0:8b2:1fa8:4684 with SMTP id af79cd13be357-8b29b567d9dmr336591285a.2.1762946391690;
        Wed, 12 Nov 2025 03:19:51 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e6f2fsm171012785a.33.2025.11.12.03.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:19:50 -0800 (PST)
Date: Wed, 12 Nov 2025 12:19:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <ydpi67iu224lkrmwzq7ibpupnllvwhsdp4nxtmdjsoyvotsdug@p3rtp4f4fulg>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-3-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-3-d5e8d6c87289@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XOcrMMItw7obFUiHEOwTDtZn6QdHLXBjoG0kDUqSHjI_1762946392
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Nov 08, 2025 at 08:00:54AM -0800, Bobby Eshleman wrote:
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
>Changes in v4:
>- remember to disable pipefail before returning from host_vsock_test()
>
>Changes in v3:
>- Add port input parameter to host_wait_for_listener() to accept port
>  from host_vsock_test() (Stefano)
>- Change host_wait_for_listener() call-site to pass in parameter
>---
> tools/testing/selftests/vsock/vmtest.sh | 135 ++++++++++++++++++++++----------
> 1 file changed, 95 insertions(+), 40 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 01ce16523afb..3bccd9b84e4a 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -272,8 +272,81 @@ EOF
> }
>
> host_wait_for_listener() {
>-	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+	local port=$1
>
>+	wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
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
>+
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
>+			set +o pipefail
>+			return $rc
>+		fi
>+
>+		host_wait_for_listener "${port}"
>+		rc=$?
>+	fi
>+	set +o pipefail
>+
>+	return $rc
> }
>
> log() {
>@@ -312,59 +385,41 @@ log_guest() {
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

