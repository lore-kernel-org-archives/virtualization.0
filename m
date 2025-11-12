Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DAE2E8B83
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946571; cv=none; b=NJvwz39qdLPDuSocGaiMtjE0sftc7QP6DoZo5HF/BduC3HhReE8bTz6x8nlZW6SIMY+zF0QRDR9kjFWHdH1KPLLUl0NL0I0FYv1bm9LR3mGj7qChCcDwlq7qAOyEeWDeqs5rC/EfnJRhqdaUaHBsSpaHzfi+FVU4QC2/5QtJEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946571; c=relaxed/simple;
	bh=VscW6L4TRLVaUV+OMnFLbNYIs/Ms82BMyVM2NevGrMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fmJUFhjDn9YYdp18cPzbCkvUazQ2LWaVg/jWhVi6LDC+nXwiVQWcrvu+HhT0SoiXV3Cu1IPXSHyqjvYF4w60ZSq+xOnoS0Nrn549iBQ9GsjpJCpd/D+k10VzydBWqCol8UJH3cwIPOhK973CoCMR229TgdH90htLXsZ8gVYLRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5aHRasN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5aHRasN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NQOIQDhY7o0sAkMRKEMYJWvC/pedPTBEzV4lKuummL0=;
	b=U5aHRasNgER3C4j+/zEJAKvGj05FDIEqXbA4/0ltQDAuAO7uUPWx61PkiPCn3Qjk0qzHbk
	LtUrGJMCm0DYcWZh0vsiyXq7Wf0msfbf1fIW/A25IIGAuxMMCdzUZpYewNnzmaRXPtJA1j
	zWUzn+Y9pfTIK8RnJ1C2w+OkjoJnuyU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-xWGwp1ggNFidd8AtSw8U3Q-1; Wed, 12 Nov 2025 06:22:47 -0500
X-MC-Unique: xWGwp1ggNFidd8AtSw8U3Q-1
X-Mimecast-MFC-AGG-ID: xWGwp1ggNFidd8AtSw8U3Q_1762946567
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8823acf4db3so17546016d6.3
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 03:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946567; x=1763551367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQOIQDhY7o0sAkMRKEMYJWvC/pedPTBEzV4lKuummL0=;
        b=MKavmsAH2DWZABkWm7kY6RQaUuA3h06Tm2ogOp36GOSnibHIoUVWRqgAOOK58Za0uY
         Igim1H9RaBTDYiYsBexcXGQp4HcVgHCjM4i32bs3B5aDuIZiWZf8Mm9ofSzE0Al5bxV0
         p4kQjfLaHpXl6GYDo22g0dmyISUoRcX4eP3EAwiST/xqKbY34KQ7MC6PgTAOVUD5Hyvv
         MWiSIXlmjtc4mtDCYTUMvOu8wMFL5uWEU/2qcFEKbj1fkj2xliJyxF1Xb7H8ieqMbx1O
         O2wxn2tT257VH21d8+1X6awQVaGGxar+esAdImktBBE2YL9kigPyisTyxAT4B0GpyVMk
         uhDA==
X-Forwarded-Encrypted: i=1; AJvYcCU9O+N5XjdVDf1dWOaSOGwOvODbV4zm7f75b4pOkyBRxPwgynCxQNkEGZ/lYNlDf/2gRka/VeeQyMjfyVcwog==@lists.linux.dev
X-Gm-Message-State: AOJu0YzISmqla5A9uH2Uw6bxys/QPFVu6QyaruNAkKRoXc3q5DommyYh
	8m1GzrUXHgTcG2NBEliNgbB/zhaG67Xz1e5P+4T/NPeCab+LUS4bqAcYzadGaavh/GEeBjbXeb2
	tjiOO8PB2EzV2LuNpxHD4MtdeK8ZXpB1cM9OFHmypPPkFUwwZgwQperNnWvmCDctxD4T3
X-Gm-Gg: ASbGncsYI7VJUXksFFwXx2p8N46SdB5GRgU2SQfvfWgzJomI9WCFLcpNTbYqPRNJfHC
	xaXP/ul/drWM4P/V5E8ZFps0OmFOUKc5NpXpBkN4uR95qkC8NXIHd+4N4sDgbpDx1tgf9viSsJX
	r65Zv6+XnN+d/48r32XbI9K1V8/tEbm3oEuO+bDUYk5o1CGVV0hGuRVgADOw+Q6P78HKabi/ZTw
	J/Pt4ORsKcFmTeoazQPZ2q7UMbGENClxG53ocMGZQR2mW2TQqbQGlZDAgDQl7dpG2L+rwchFKKG
	7ulfJAqh9Vm4/ZWMrgOC4n15hcoJ/7+spZKeZbWCJvWbKAXYtUkOBUTTOMnhZR4aIjD5MFVDAO1
	qMYVMSGCbe83qPbPqMHeTFifVsS11lBsyw8GrBjsI0K0aDslYPFM=
X-Received: by 2002:a05:6214:628:b0:882:44cc:f590 with SMTP id 6a1803df08f44-8827196c120mr33091916d6.17.1762946566924;
        Wed, 12 Nov 2025 03:22:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqYLLUPKJIhO1usMYZBZTm6T+uWhl/OzYeE42ktzFP1X9W5/fpalqufI3dtFeRXv+BAFIHsg==
X-Received: by 2002:a05:6214:628:b0:882:44cc:f590 with SMTP id 6a1803df08f44-8827196c120mr33091756d6.17.1762946566474;
        Wed, 12 Nov 2025 03:22:46 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b2936asm89469516d6.31.2025.11.12.03.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:22:45 -0800 (PST)
Date: Wed, 12 Nov 2025 12:22:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 04/12] selftests/vsock: avoid multi-VM
 pidfile collisions with QEMU
Message-ID: <sljr5fiyqg4syuhpfvese2dflrbse4cej5ydpazbphon2qr57w@vyn7athtpyf2>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-4-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-4-d5e8d6c87289@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jc-0wdu_KcTOA5XgfjIQpdsdJV4JWOAHwP2sU_k_JhQ_1762946567
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Nov 08, 2025 at 08:00:55AM -0800, Bobby Eshleman wrote:
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
>Change QEMU_OPTS to be initialized inside the vm_start(). This allows
>the generated pidfile to be passed to the string assignment, and
>prepares for future vm-specific options as well (e.g., cid).
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- use terminate_pidfiles() in cleanup (Simon)
>- use associative array for PIDFILES and remove pidfiles as they are
>  terminated (Simon)
>
>Changes in v3:
>- do not add unneeded -u to mktemp (Stefano)
>- quote $PIDFILE_TEMPLATE (Stefano)
>- do not remove cleanup(). Though it is expected that vm_start() does
>  not exit(2) and its caller is responsible for pidfile cleanup,
>  retaining cleanup() on EXIT is worth keeping as ill-timed kill signals
>  (i.e., during manual runs) may leak those files.
>- add create_pidfile() function to generate pidfile and automatically
>  add it to array for cleanup() to terminate and remove later.
>
>Changes in v2:
>- mention QEMU_OPTS changes in commit message (Simon)
>---
> tools/testing/selftests/vsock/vmtest.sh | 62 +++++++++++++++++++++++----------
> 1 file changed, 43 insertions(+), 19 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 3bccd9b84e4a..13b685280a67 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -23,7 +23,8 @@ readonly VSOCK_CID=1234
> readonly WAIT_PERIOD=3
> readonly WAIT_PERIOD_MAX=60
> readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
>-readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
>+readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
>+declare -A PIDFILES
>
> # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
> # control port forwarded for vsock_test.  Because virtme-ng doesn't support
>@@ -33,12 +34,6 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
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
>@@ -90,15 +85,7 @@ vm_ssh() {
> }
>
> cleanup() {
>-	if [[ -s "${QEMU_PIDFILE}" ]]; then
>-		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
>-	fi
>-
>-	# If failure occurred during or before qemu start up, then we need
>-	# to clean this up ourselves.
>-	if [[ -e "${QEMU_PIDFILE}" ]]; then
>-		rm "${QEMU_PIDFILE}"
>-	fi
>+	terminate_pidfiles "${!PIDFILES[@]}"
> }
>
> check_args() {
>@@ -188,10 +175,37 @@ handle_build() {
> 	popd &>/dev/null
> }
>
>+create_pidfile() {
>+	local pidfile
>+
>+	pidfile=$(mktemp "${PIDFILE_TEMPLATE}")
>+	PIDFILES["${pidfile}"]=1
>+
>+	echo "${pidfile}"
>+}
>+
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
>+
>+		unset "PIDFILES[${pidfile}]"
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
>@@ -201,6 +215,13 @@ vm_start() {
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
>@@ -209,14 +230,14 @@ vm_start() {
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
>@@ -499,7 +520,8 @@ handle_build
> echo "1..${#ARGS[@]}"
>
> log_host "Booting up VM"
>-vm_start
>+pidfile="$(create_pidfile)"
>+vm_start "${pidfile}"
> vm_wait_for_ssh
> log_host "VM booted up"
>
>@@ -523,6 +545,8 @@ for arg in "${ARGS[@]}"; do
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

