Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF3630BBA3
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353155; cv=none; b=I4NUg5hTt/yAsnHtCGQcdWdFv7x9cu0dCeq3E+f1dh6v7BYjjWvx1ADkQ+ukHHCxi23/61oh0cHu6rcsu59krFCkZktfee6dLFUxipc03ADD1uUtizBDhHR9ErbD6rNoS6bvgG0NIz4aYcFUaj5WlnYDybvf59naJCj5rvrJD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353155; c=relaxed/simple;
	bh=RRH8LLT4tnEW2zr9zEsEkvqzLS8Y6JH+rXqaTOe68tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GABcGydUMtuiwrk186YR9ATMM4zcMlcuS7DP64yvzh5E2DRtCNpheVlZWMjSMaU6DCXtQqNad/Hv1Bph/778e5fc2K4egFQ8BLe6AUGX4RkLZE1AgO79e1vY7aezly0739IcE8Nzw0TcWVBICfyuxyEZ0U5p9XM0TPKSW10AOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0OheZnm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0OheZnm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762353150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kX3VzHZS/HGSzq6tZ4+jI+/5hajDd1Zm9Mx0FurYGLQ=;
	b=F0OheZnmnw2i69VJQ+GoiBpWNETegL6m6jdyt5u0pN9BsfcAgwwPRkXxGPasw4VCNWJVnZ
	nojR6AXNnpLm08DwxtDTvm68YKccQk1e++3CvWRudR80UhiQY5fHvIoizpOE4CH2qPnNS3
	4Vf48YE5QIb46Ru4DwNleBdqCLJ4a04=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-kBxP6Yp-MPWH6M40x8b6ag-1; Wed, 05 Nov 2025 09:32:28 -0500
X-MC-Unique: kBxP6Yp-MPWH6M40x8b6ag-1
X-Mimecast-MFC-AGG-ID: kBxP6Yp-MPWH6M40x8b6ag_1762353147
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47717c2737bso29988275e9.2
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 06:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353147; x=1762957947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kX3VzHZS/HGSzq6tZ4+jI+/5hajDd1Zm9Mx0FurYGLQ=;
        b=wGiKQqcWY4Na1+I3ih+9hpd7I8CXGKzB7IeYFLspBhn5c2zSi4M0QKOQQQIWIbn5uj
         f31SCtqpVrlZgi0NLuOT4bgxl2CGFpUTVEr33CUhfsb9Ynsvyy3xE3t4CVtAyuKgBLiA
         mn9Y4oYh4zIzcTP/1sc9LeiY5v8n9QItR7WQfBB82UftVTW6UgJjFUhXMYNVX7P+v3Sv
         ZIrFivOjd4jNHdzvKJ52WRUY5QAmuUIAeBwlOb8LeLK/0BfCMw2zSA2ProPXTunnJy1A
         QorSfkN6UPsDcRF+2GKIfjJD++PsQKFWu7gbSOCxDRVypqmSbFqdX0JgjllzAJXYC+cB
         t6dg==
X-Forwarded-Encrypted: i=1; AJvYcCVapa55GSL9WtBAT0YNQ6QaxmJn9xborESxTE/6FeKEy3OdbKsj59ns9l/yIB+CPyUIc055i6Ks60DkMhI9hQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrIL7sEacS5t7PrbPeiZaoDeM7fzYzEtKDPmUjYDH8XYn1iayF
	nz/GVpRKcLdFYWvE5OQMUGkTij4Ew5NdcJBgOE3weiy6+dUTfU6k2129jcgGCVHXw6WsBPIWj85
	w0DqPfl4Wq/pudgOtFkjskfHSxj9GaldWkxl3A0xOXdyklQ/sQoS9aJy+HZVj2Q8A5/Fh
X-Gm-Gg: ASbGnctMjtJL9aLucBBOkx4+5Uae3ocJaW+1hmgRA0dPCcZ0fvy7zU33BQrAi6m732B
	IyHue1ESg4vikFUN5J06tsJgQGY6/7BnxYiIYY+oAWfvi7amdoEtRsI369hKVozei/c0s59ypFJ
	zcVl4yq73aR3vImNFqlbya3LLK0piKr4rgLPgqTEBLUBS5VvhfCcSJNl/xlzJZD2Xj67PuwbUWC
	8qTyKECKX0EbD1peiKWcy1E5He24QU99L7r1LGPcOJ4VuBA1iB/xx9eFIuKHDlWb2Luxf0eXiLd
	gwgmNACWK+OJUQSnKHlBLLfkuiEheHgu7zofGHG6HGcg7m+KV+FyOiCMbS6Kd0Y2BB0gtXwpVKU
	=
X-Received: by 2002:a05:600c:8b88:b0:471:145b:dd0d with SMTP id 5b1f17b1804b1-4775cde3b1cmr24454615e9.24.1762353147137;
        Wed, 05 Nov 2025 06:32:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWyogJkKQrbfKs51nTFgSZd3l651tt4j8gql/Hcm4StJEJE6IWfnkUPmlhXIXKjxU9KUzKHg==
X-Received: by 2002:a05:600c:8b88:b0:471:145b:dd0d with SMTP id 5b1f17b1804b1-4775cde3b1cmr24454345e9.24.1762353146660;
        Wed, 05 Nov 2025 06:32:26 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558d983fsm43454025e9.8.2025.11.05.06.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:32:25 -0800 (PST)
Date: Wed, 5 Nov 2025 15:32:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 04/12] selftests/vsock: avoid multi-VM
 pidfile collisions with QEMU
Message-ID: <3osszz3giogog7jzs37pdqhakcrveayrqu6xduztuwrftkwrad@gjj3cyvmypw3>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-4-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-4-ca2070fd1601@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uKz7Qe5fmq7CM92B88sXUSZRGEGeZtdInTNeDe2QrjY_1762353147
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 04, 2025 at 02:38:54PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Change QEMU to use generated pidfile names instead of just a single
>globally-defined pidfile. This allows multiple QEMU instances to
>co-exist with different pidfiles. This is required for future tests that
>use multiple VMs to check for CID collissions.
>
>Additionally, this also places the burden of killing the QEMU process
>and cleaning up the pidfile on the caller of vm_start(). To help with
>this, a function terminate_pidfiles() is introduced that callers use to
>perform the cleanup. The terminate_pidfiles() function supports multiple
>pidfile removals because future patches will need to process two
>pidfiles at a time.
>
>Change QEMU_OPTS to be initialized inside the vm_start(). This allows the
>generated pidfile to passed to the string assignment, and prepares for
>future vm-specific options as well (e.g., cid).
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v2:
>- mention QEMU_OPTS changes in commit message (Simon)
>---
> tools/testing/selftests/vsock/vmtest.sh | 53 +++++++++++++++++++--------------
> 1 file changed, 30 insertions(+), 23 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 03dc4717ac3b..5637c98d5fe8 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -23,7 +23,7 @@ readonly VSOCK_CID=1234
> readonly WAIT_PERIOD=3
> readonly WAIT_PERIOD_MAX=60
> readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
>-readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
>
> # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
> # control port forwarded for vsock_test.  Because virtme-ng doesn't support
>@@ -33,12 +33,6 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
> # add the kernel cmdline options that virtme-init uses to setup the interface.
> readonly QEMU_TEST_PORT_FWD="hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
> readonly QEMU_SSH_PORT_FWD="hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
>-readonly QEMU_OPTS="\
>-	 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
>-	 -device virtio-net-pci,netdev=n0 \
>-	 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
>-	 --pidfile ${QEMU_PIDFILE} \
>-"
> readonly KERNEL_CMDLINE="\
> 	virtme.dhcp net.ifnames=0 biosdevname=0 \
> 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
>@@ -89,17 +83,6 @@ vm_ssh() {
> 	return $?
> }
>
>-cleanup() {
>-	if [[ -s "${QEMU_PIDFILE}" ]]; then
>-		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
>-	fi
>-
>-	# If failure occurred during or before qemu start up, then we need
>-	# to clean this up ourselves.
>-	if [[ -e "${QEMU_PIDFILE}" ]]; then
>-		rm "${QEMU_PIDFILE}"
>-	fi
>-}
>
> check_args() {
> 	local found
>@@ -188,10 +171,26 @@ handle_build() {
> 	popd &>/dev/null
> }
>
>+terminate_pidfiles() {
>+	local pidfile
>+
>+	for pidfile in "$@"; do
>+		if [[ -s "${pidfile}" ]]; then
>+			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
>+		fi
>+
>+		if [[ -e "${pidfile}" ]]; then
>+			rm -f "${pidfile}"
>+		fi
>+	done
>+}
>+
> vm_start() {
>+	local pidfile=$1
> 	local logfile=/dev/null
> 	local verbose_opt=""
> 	local kernel_opt=""
>+	local qemu_opts=""
> 	local qemu
>
> 	qemu=$(command -v "${QEMU}")
>@@ -201,6 +200,13 @@ vm_start() {
> 		logfile=/dev/stdout
> 	fi
>
>+	qemu_opts="\
>+		 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
>+		 -device virtio-net-pci,netdev=n0 \
>+		 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
>+		--pidfile ${pidfile}
>+	"
>+
> 	if [[ "${BUILD}" -eq 1 ]]; then
> 		kernel_opt="${KERNEL_CHECKOUT}"
> 	fi
>@@ -209,14 +215,14 @@ vm_start() {
> 		--run \
> 		${kernel_opt} \
> 		${verbose_opt} \
>-		--qemu-opts="${QEMU_OPTS}" \
>+		--qemu-opts="${qemu_opts}" \
> 		--qemu="${qemu}" \
> 		--user root \
> 		--append "${KERNEL_CMDLINE}" \
> 		--rw  &> ${logfile} &
>
> 	if ! timeout ${WAIT_TOTAL} \
>-		bash -c 'while [[ ! -s '"${QEMU_PIDFILE}"' ]]; do sleep 1; done; exit 0'; then
>+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
> 		die "failed to boot VM"
> 	fi
> }
>@@ -480,8 +486,6 @@ do
> done
> shift $((OPTIND-1))
>
>-trap cleanup EXIT
>-

Why avoiding the cleanup on exit?
Should we mention this change in commit description?

Thanks,
Stefano

> if [[ ${#} -eq 0 ]]; then
> 	ARGS=("${TEST_NAMES[@]}")
> else
>@@ -496,7 +500,8 @@ handle_build
> echo "1..${#ARGS[@]}"
>
> log_host "Booting up VM"
>-vm_start
>+pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"
>+vm_start "${pidfile}"
> vm_wait_for_ssh
> log_host "VM booted up"
>
>@@ -520,6 +525,8 @@ for arg in "${ARGS[@]}"; do
> 	cnt_total=$(( cnt_total + 1 ))
> done
>
>+terminate_pidfiles "${pidfile}"
>+
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>
>-- 
>2.47.3
>

