Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F32340DA6;
	Wed, 23 Sep 2026 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126325; cv=none; b=F/WWbrN8teRl95kW2minGVjgL2nhqZE43jqn1wVbjoTeUHihksH2gk7flIoHYi9aUaLvjoggUG+gknwQdLeYwhRl2Lxfb2tNp7ILB6x394BUvmZ8XL0lJCX3ERw4F+5MB1GTs8F1/+euvgptitENvQGIlKTUoPoER3rtfMdysGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126325; c=relaxed/simple;
	bh=4BV+HwI1ACa9Zsd9ly0jL0jEayoCCZ4s5uXxmwwjzzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bqAKuyGBe3YnxE5nSfpINssV3Od7CA9GvFwJx+KTIgetmRx+FRNqTD+KcPJuAXaFaY6/+zRJPStzhEFTV//ZFeh79V15ZRYt2FkUJdnaEWDukAlqYh1/X3zTNbtKeQ/1h4ozQfz6PETkrOVJuHBexu2fO+0//dWH1ovjc1fWK6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYNRoIMr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYNRoIMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694B61F00893;
	Wed, 23 Sep 2026 01:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790126323;
	bh=1SnI9hePbSyR4iRoKRRFbHjzo38fDyJjxnY8EDzk0kI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TYNRoIMr6Y+Lt+VT8BARlq96aeX8hU1WKzlxTnNP3GPOWWKkSjSsPpUO579SxWHLl
	 beH7s7PQwM6GwPyTvS7R9DxKuVqW5o59fHmeF1Hqil2s8/QB/zHRvIc2xN73KncI1O
	 /zoTaJ9i69JtsGRhNV/Fb++27VYiizJauvObLLBwx4j7CIvrsdx79ZSEnlU6RCd5Ds
	 bxvmwFSeIi19gMSmWU0NUB50QMerYCCD7A+abt4YUe10sM5hbWcSrqEik/pIpftEiQ
	 crciC83xpPJzqKFA8NGzZlCRKGy2wssQNcwbevvAX4+CqeNyjQOn+KZGhD8HfIm0Ua
	 JSQQtAS8Eme9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 5/6] selftests/vsock: test the guest vsock
 device network namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260921-vsock-guest-ns-v2-5-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
 <20260921-vsock-guest-ns-v2-5-693bd78fde9e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 01:18:43 +0000
Message-Id: <20260923011843.694B61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] kselftest/vsock: missing TEST_FILES breaks make install
- [Medium] netlink: vsock dev-netns-set violates uAPI by not replying
- [Medium] kselftest/vsock: subshell termination leaks ssh and socat proces=
ses
--

commit 3122f274adb12a4633dc3d5fee699cdb3ce877cf
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests/vsock: test the guest vsock device network namespace

Add tests for guest vsock device namespace assignment, including ns
destruction and the device moving between namespaces.

> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/self=
tests/vsock/vmtest.sh
> index 310dfc2a39ad5..e94cc2fd90ccd 100755
> --- a/tools/testing/selftests/vsock/vmtest.sh
> +++ b/tools/testing/selftests/vsock/vmtest.sh
> @@ -17,6 +17,8 @@ readonly KERNEL_CHECKOUT=3D$(realpath "${SCRIPT_DIR}"/.=
./../../../)
>  source "${SCRIPT_DIR}"/../kselftest/ktap_helpers.sh
> =20
>  readonly VSOCK_TEST=3D"${SCRIPT_DIR}"/vsock_test
> +readonly YNL_CLI=3D"${KERNEL_CHECKOUT}"/tools/net/ynl/pyynl/cli.py
> +readonly VSOCK_SPEC=3D"${KERNEL_CHECKOUT}"/Documentation/netlink/specs/v=
sock.yaml
>  readonly TEST_GUEST_PORT=3D51000
>  readonly TEST_HOST_PORT=3D50000

[Severity: Medium]
Does this break running the tests from an installed location (via make
install)? Since cli.py and vsock.yaml are not added to TEST_FILES in the
selftests Makefile, they won't be copied during installation.

When check_deps() runs in the installed environment, it will fail to find
these files at the hardcoded ${KERNEL_CHECKOUT} paths and unconditionally
skip the test suite.

[ ... ]

> +vm_ns_assign_g2h() {
> +	local ns=3D$1
> +	local nspid=3D$2
> +
> +	vm_ns_exec "${ns}" "${nspid}" "python3 /root/ynl/cli.py --no-schema \
> +		--spec /root/ynl/vsock.yaml --do dev-netns-set"
> +}

[Severity: Medium]
Does dev-netns-set in vsock.yaml violate the Netlink subsystem guidelines?
The operation in vsock.yaml is defined as "do: {}" with no reply, but the
guidelines require that all new operations must reply with a full message
(such as the assigned netns ID) rather than just an ACK to ensure future
extensibility.

[ ... ]

> +host_send_to_guest() {
> +	local ns=3D$1
> +	local nspid=3D$2
> +	local port=3D$3
> +	local outfile=3D$4
> +	local cmd=3D"socat -u VSOCK-LISTEN:${port} STDOUT"
> +	local dst=3D"VSOCK-CONNECT:${VSOCK_CID}:${port}"
> +	local pid
> +
> +	vm_ns_exec "${ns}" "${nspid}" "${cmd}" > "${outfile}" 2>/dev/null &
> +	pid=3D$!

[Severity: Medium]
Does this leak the ssh client and remote socat processes? vm_ns_exec is a
bash function, so backgrounding it means $! captures the local subshell's
PID rather than the ssh client's PID.

When terminate_pids sends SIGTERM to the subshell, the subshell exits, but
bash does not forward the signal to its children (the ssh client).

The orphaned ssh process keeps the connection open. Because no PTY is
allocated, the remote sshd does not send SIGHUP, leaving the remote socat
process running and holding the port open, which could cause EADDRINUSE
failures in subsequent shared VM tests.

[ ... ]

> +test_ns_guest_assign_g2h_netns_old_conn_send_fails() {
> +	local gap=3D$(( WAIT_PERIOD * 3 ))
> +	local port=3D12346
> +	local outfile
> +	local result
> +	local sender
> +	local nspid
> +	local pid
> +
> +	nspid=3D$(vm_ns_start "init_ns")
> +	if [[ -z "${nspid}" ]]; then
> +		log_host "failed to create a namespace inside the guest"
> +		return "${KSFT_FAIL}"
> +	fi
> +
> +	outfile=3D$(mktemp)
> +	socat -u VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
> +	pid=3D$!
> +	host_wait_for_listener "init_ns" "${port}" "vsock"
> +
> +	# Send a message, wait, then send another. While waiting, assign the
> +	# device to a namespace. Confirm the second message does not arrive.
> +	vm_ssh "init_ns" -- \
> +		"(echo FIRST; sleep ${gap}; echo SECOND) |" \
> +		"socat -u STDIN VSOCK-CONNECT:2:${port}" &>/dev/null &
> +	sender=3D$!

[Severity: Medium]
Similarly here, does backgrounding the vm_ssh bash function cause it to
orphan the ssh and socat processes when sender is killed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vsock-gues=
t-ns-v2-0-693bd78fde9e@meta.com?part=3D5
