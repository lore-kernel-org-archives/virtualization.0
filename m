Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05BD23BCE4
	for <virtualization@lists.linux.dev>; Fri,  2 May 2025 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181376; cv=none; b=X9LeC4COs1tpKcdi8tlqWyDqrpxmXp2aq4ft2o4aQ+eNoSx4vbdSw+3MnmOyM6WOZQpOK7TCueoR1i+QS8orSmlGRExDwjxR7Nrjgn/EPk+3qaDuijbNZ6R8r9zTDwx4oUymu9HnhQNw9p1No2rPMgtbvChabmJpJJ3r5sy5g/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181376; c=relaxed/simple;
	bh=i0/o7pVkw7duSUK3m7urAHcNVUQGmAMppqUpi02REMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6VPYQ4sf+07xweyHT92UniFFMkMe9kOh2fPuR3XDOPat7IHVsWBJMrc8RXFtuKchjo7dj4rf29JmDMsPSvf/MuztiH2stiPEpGfS8WRfa2dOywsxJJUrzC9m2ynKlP4dXv/HrpQ5CptOp/zaCXFzFLDwt3okL1qHJyF0sq3mz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-g8Dg4S-EOLKqm8YgnECtrg-1; Fri, 02 May 2025 06:22:50 -0400
X-MC-Unique: g8Dg4S-EOLKqm8YgnECtrg-1
X-Mimecast-MFC-AGG-ID: g8Dg4S-EOLKqm8YgnECtrg_1746181369
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-391315098b2so547250f8f.2
        for <virtualization@lists.linux.dev>; Fri, 02 May 2025 03:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746181369; x=1746786169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPxLSU1XqT/NXlV7eFy5ZcbBJizdwKiKGPSIW+m2/2o=;
        b=WsWs+5eoY9E5sjQVACcp9gWiKU+GZedJkRcuDwZ4nS1eER6yxK/ErpCoN5qMGLS3QW
         SSnrmsKpEKElSuFkNY089Oz3b3gSH41nrLc5c8hbyYon8jwMQnsb9t9a3FZq+o9kJ6dj
         3mdF+pxPuoKXYoWUtqRBnUeZS7aBY2I67Sp4nFLz77EovtAAt7xhjdEcMtSMIeVXvMDZ
         8t7+71bhrqRAjvOvU6XZoO+x7tigL4XrAn5FknOkbHQPOJQzULMzMHx83mGNOudTJmsR
         zkxsx/H4fG8A2JGV9gIdIH3pP+CGK0hFEud42VrdyLawrtYYAAoMpY+vWU4p+O7nZhV/
         ed9g==
X-Forwarded-Encrypted: i=1; AJvYcCUfvM0FUj/6ELzqNXR5jFYZXk5pwuOUTWCJ7VIox/yUfu1KS8dLP+VRdwU1JLiVJA3Ky+4xsYBmbpp6NUB6iw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyjm/6AvagZFeCmoEJY36llUPhpE7eFDzpyR9QxDI70mfVL0dHP
	gPTsSwWYkqYr180Oi22OczYQe2EVhWICZYQ/34YMCqQVQwxZplEHy+sY6yMc5GoR/Pb7G8dTap7
	i0I+2kLv7ouOBXIIqz29KBSIOW+s2K9PuxPoIjLDe4okeA0lkGByJJ1NOHXNW+Zea
X-Gm-Gg: ASbGncuo3xB8i+GfUVBuni/jRF0CoNc2YGY8kRtYaLCMsLGT2N2Uj/ZvM2YMcMtep4T
	EoZ6w79irlYXvJJc4a6ypcZbVqsKbTcRGjaqhHvKx/iOvAw48zae6OhDi/GknIjzgLhKVyJEsjc
	tIOvCRwxDnfPu7PEQI5xgE6mw4HhWdFC74ZM6tED2gB7d2UqLpZwl1fgJKeS79l4o7hO5o809xJ
	2vtDerVdUC3jp34xx9p0aZjqmzXw4latk+82vFBOLle8p8sHOxGgLeq239tQdL3jJ2rnA9t4qMd
	ktgq5mM7ra94xOZnxOg=
X-Received: by 2002:a05:6000:4387:b0:391:4674:b10f with SMTP id ffacd0b85a97d-3a099ae9774mr1913558f8f.36.1746181369499;
        Fri, 02 May 2025 03:22:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzkS1lKR2T7hyh9gkaUuVs/7+Dq04YWJdFuTxAo1hUYcodL6jGaO9eOC3AbB7PExj+iPODSw==
X-Received: by 2002:a05:6000:4387:b0:391:4674:b10f with SMTP id ffacd0b85a97d-3a099ae9774mr1913529f8f.36.1746181369141;
        Fri, 02 May 2025 03:22:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:246d:aa10::f39? ([2a0d:3344:246d:aa10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0c25sm1762567f8f.17.2025.05.02.03.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 03:22:48 -0700 (PDT)
Message-ID: <3e3eea6b-10a6-4a32-aa12-ef6fdf2eeeb8@redhat.com>
Date: Fri, 2 May 2025 12:22:46 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] selftests/vsock: add initial vmtest.sh for
 vsock
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250428-vsock-vmtest-v3-1-181af6163f3e@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250428-vsock-vmtest-v3-1-181af6163f3e@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qv435e58_YCqcD5YabW1SE_hce0CcukQH7Mz8UjVj80_1746181369
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 1:48 AM, Bobby Eshleman wrote:
> This commit introduces a new vmtest.sh runner for vsock.
> 
> It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
> H2G, and loopback. The testing tools from tools/testing/vsock/ are
> reused. Currently, only vsock_test is used.
> 
> VMCI and hyperv support is automatically built, though not used.
> 
> Only tested on x86.
> 
> To run:
> 
>   $ tools/testing/selftests/vsock/vmtest.sh
> 
> or
> 
>   $ make -C tools/testing/selftests TARGETS=vsock run_tests
> 
> Results:
> 	# linux/tools/testing/selftests/vsock/vmtest.log
> 	setup:  Building kernel and tests
> 	setup:  Booting up VM
> 	setup:  VM booted up
> 	test:vm_server_host_client:guest:       Control socket listening on 0.0.0.0:51000
> 	test:vm_server_host_client:guest:       Control socket connection accepted...
> 	[...]
> 	test:vm_loopback:guest: 30 - SOCK_STREAM retry failed connect()...ok
> 	test:vm_loopback:guest: 31 - SOCK_STREAM SO_LINGER null-ptr-deref...ok
> 	test:vm_loopback:guest: 31 - SOCK_STREAM SO_LINGER null-ptr-deref...ok
> 
> Future work can include vsock_diag_test.
> 
> vmtest.sh is loosely based off of tools/testing/selftests/net/pmtu.sh,
> which was picked out of the bag of tests I knew to work with NIPA.
> 
> Because vsock requires a VM to test anything other than loopback, this
> patch adds vmtest.sh as a kselftest itself. This is different than other
> systems that have a "vmtest.sh", where it is used as a utility script to
> spin up a VM to run the selftests as a guest (but isn't hooked into
> kselftest). This aspect is worth review, as I'm not aware of all of the
> enviroments where this would run.

I think this approach is interesting, but I think it will need some
additional more work, see below...

[...]

> diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
> new file mode 100644
> index 0000000000000000000000000000000000000000..e7b9417537fbc4626153b72e8f295ab4594c844b
> --- /dev/null
> +++ b/tools/testing/selftests/vsock/settings
> @@ -0,0 +1 @@
> +timeout=0

We need a reasonable, bounded runtime for nipa integration.

> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..d70b9446e531d6d20beb24ddeda2cf0a9f7e9a39
> --- /dev/null
> +++ b/tools/testing/selftests/vsock/vmtest.sh
> @@ -0,0 +1,354 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2025 Meta Platforms, Inc. and affiliates
> +#
> +# Dependencies:
> +#		* virtme-ng
> +#		* busybox-static (used by virtme-ng)
> +#		* qemu	(used by virtme-ng)

You should probably check for such tools presence and bail out with skip
otherwise.

> +
> +SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
> +KERNEL_CHECKOUT=$(realpath ${SCRIPT_DIR}/../../../..)

This is not going to work if/when the self-tests are installed in their
own directory via `make install` in the tools/testing/selftests/
directory, and that use case is supposed to work.

At very least you should check for the expected layout and skip otherwise.

> +QEMU=$(command -v qemu-system-$(uname -m))
> +VERBOSE=0
> +SKIP_BUILD=0
> +VSOCK_TEST=${KERNEL_CHECKOUT}/tools/testing/vsock/vsock_test
> +
> +TEST_GUEST_PORT=51000
> +TEST_HOST_PORT=50000
> +TEST_HOST_PORT_LISTENER=50001
> +SSH_GUEST_PORT=22
> +SSH_HOST_PORT=2222
> +VSOCK_CID=1234
> +WAIT_PERIOD=3
> +WAIT_PERIOD_MAX=20
> +
> +QEMU_PIDFILE=/tmp/qemu.pid
> +
> +# virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
> +# control port forwarded for vsock_test.  Because virtme-ng doesn't support
> +# adding an additional port to forward to the device created from "--ssh" and
> +# virtme-init mistakenly sets identical IPs to the ssh device and additional
> +# devices, we instead opt out of using --ssh, add the device manually, and also
> +# add the kernel cmdline options that virtme-init uses to setup the interface.
> +QEMU_OPTS=""
> +QEMU_OPTS="${QEMU_OPTS} -netdev user,id=n0,hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
> +QEMU_OPTS="${QEMU_OPTS},hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
> +QEMU_OPTS="${QEMU_OPTS} -device virtio-net-pci,netdev=n0"
> +QEMU_OPTS="${QEMU_OPTS} -device vhost-vsock-pci,guest-cid=${VSOCK_CID}"
> +QEMU_OPTS="${QEMU_OPTS} --pidfile ${QEMU_PIDFILE}"
> +KERNEL_CMDLINE="virtme.dhcp net.ifnames=0 biosdevname=0 virtme.ssh virtme_ssh_user=$USER"
> +
> +LOG=${SCRIPT_DIR}/vmtest.log
> +
> +#		Name				Description
> +avail_tests="
> +	vm_server_host_client	Run vsock_test in server mode on the VM and in client mode on the host.	
> +	vm_client_host_server	Run vsock_test in client mode on the VM and in server mode on the host.	
> +	vm_loopback		Run vsock_test using the loopback transport in the VM.	
> +"
> +
> +usage() {
> +	echo
> +	echo "$0 [OPTIONS] [TEST]..."
> +	echo "If no TEST argument is given, all tests will be run."
> +	echo
> +	echo "Options"
> +	echo "  -v: verbose output"
> +	echo "  -s: skip build"
> +	echo
> +	echo "Available tests${avail_tests}"
> +	exit 1
> +}
> +
> +die() {
> +	echo "$*" >&2
> +	exit 1
> +}
> +
> +vm_ssh() {
> +	ssh -q -o UserKnownHostsFile=/dev/null -p 2222 localhost $*
> +	return $?
> +}
> +
> +cleanup() {
> +	if [[ -f "${QEMU_PIDFILE}" ]]; then
> +		pkill -SIGTERM -F ${QEMU_PIDFILE} 2>&1 >/dev/null
> +	fi
> +}
> +
> +build() {
> +	log_setup "Building kernel and tests"
> +
> +	pushd ${KERNEL_CHECKOUT} >/dev/null
> +	vng \
> +		--kconfig \
> +		--config ${KERNEL_CHECKOUT}/tools/testing/selftests/vsock/config.vsock
> +	make -j$(nproc)
> +	make -C ${KERNEL_CHECKOUT}/tools/testing/vsock
> +	popd >/dev/null

I think it would be better to avoid the kernel rebuild. A possible
alternative could be including in 'config' the needed knobs for vng's
sake and re-use the running kernel.

Cheers,

Paolo

