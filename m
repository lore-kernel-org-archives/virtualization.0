Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA61D54EED2;
	Tue, 13 Oct 2026 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931930; cv=none; b=WPmdBDOGsMA8GbmakNflAkVgTthyHQFneaY/SALaE2jzdLLCHtM742X94818RxgUYHraQgpHb0AETc3slZroIefoEFT0rocU//IeouCZP5e8hPAEexjVizkxpcOO2zsYwKvYYzws2GSJP9i7O7D375shjGXi4a3pUKHpSwNtJFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931930; c=relaxed/simple;
	bh=86JppvybnyB3lCNi7hGcAGBAWF6H0lUMWQw/AswC8es=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RhUWZw2w6bo60SCddd2V0txb8UhUEmr8xRikhmRUciSkQYqv8pwo4t6MPhmaBwyMWCSVjqaXKRHRsw6f4GKzDc/Kqe8smBTGmWLnpaJG1midc9cDI+BjYdzW/hR5b0p2Ai7DF7NAYnnUVdUpaVj25sNs9+Ag71VmDqiJXLqJ0YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3XJNWa9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3XJNWa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3E51F00898;
	Tue, 13 Oct 2026 22:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931921;
	bh=lQA2K7G0slA/+sDvMsoSxwgG9JnaLWjLSD+d35CVtHc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y3XJNWa9fOqjl9N1RaZfSzATOXb5L/VWTok5rbJ6jvwe3jB0zVNlfMyqcXOxycdia
	 RyW1Y6MQMz8jv3R2T3/+Q3aC1bkaDcM6vuXNV6ffoOk8FYHLx9PpaA78F5s/TLW/C8
	 nBKJrIf1aqkk+PM8KLh5MM42Ga0pau25JthpobZK7m2V7aCLcW7VScdceR6hGiassW
	 bOSN/OkuwadM9Qexubm3d9eYYgAqHnjB/6roBYwE4ZtY+Gc3NxseDC7Ect9aIC1/xG
	 N551aE9lw54z9pRzuESNBnLOic/7QHyrYdjR7aaOB+eRoAfb3zKG/h+LHqmq3+F+kR
	 t++84nCrRWGSw==
Subject: Re: [PATCH net-next v3 6/7] selftests/vsock: test the guest vsock
 device network namespace
From: netdev-bot+sashiko@kernel.org
To: bobbyeshleman@meta.com
Cc: sgarzare@redhat.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, stefanha@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shuah@kernel.org, rdunlap@infradead.org, donald.hunter@gmail.com,
 edumazet@kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
 bobbyeshleman@gmail.com
Date: Tue, 13 Oct 2026 22:51:59 +0000
Message-ID: <179193191962.434549.16824396981142750170@kernel.org>
In-Reply-To: <20261012-vsock-guest-ns-v3-6-b32447c66b23@meta.com>
References: <20261012-vsock-guest-ns-v3-6-b32447c66b23@meta.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] test_ns_guest_assign_g2h_netns_old_conn_send_fails can report
  KSFT_FAIL on a correct kernel when the guest is slow.
- [Low] Three of the new negative tests pass whenever the host does not
  end up with "TEST" in its output file, whatever the reason.
- [Low] TEST_DESCS says test_ns_guest_assign_g2h_netns_pins_ns_ok checks
  that "the assignment keeps the ns alive when deleted, and that…
- [Low] test_ns_guest_assign_g2h_netns_pins_ns_ok uses a fixed `sleep
  ${WAIT_PERIOD}` (3s) after vm_ns_stop() and then makes one connect…
- [Low] Each new ns_guest_* test ends with vm_ns_stop() and
  vm_reset_g2h(), or ns_old_conn_cleanup().

--

selftests/vsock: test the guest vsock device network namespace

This adds vmtest.sh cases for assigning the guest vsock device to a
network namespace. The cases cover connectivity from local and initial
namespaces, namespace pinning on deletion, and old connections losing
the device. The device is driven through the ynl cli.py, and the ns_guest_
tests are skipped if their dependencies are missing.

> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> index 310dfc2a39ad5..7693d5e0a1d07 100755
> --- a/tools/testing/selftests/vsock/vmtest.sh
> +++ b/tools/testing/selftests/vsock/vmtest.sh

[ ... ]

> @@ -1421,6 +1598,317 @@ test_ns_delete_both_ok() {
>  	check_ns_delete_doesnt_break_connection "both"
>  }
>  
> +# Send a string from the guest to a host listener and leave what the host
> +# received in <outfile>.
> +guest_send_to_host() {
> +	local ns=$1
> +	local nspid=$2
> +	local port=$3
> +	local outfile=$4
> +	local cmd="echo TEST | socat -u STDIN VSOCK-CONNECT:2:${port}"
> +	local pid
> +
> +	socat -u VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
> +	pid=$!
> +	host_wait_for_listener "${ns}" "${port}" "vsock"
> +
> +	vm_ns_exec "${ns}" "${nspid}" "${cmd}" 2>/dev/null

[Severity: Low]

The exit status of the guest command is thrown away here.
host_wait_for_listener() doesn't signal readiness either: wait_for_listener()
exits its for loop with status 0 when it runs out of intervals.

The negative tests then count any empty outfile as success:

test_ns_guest_local_connect_to_host_fails() {
    ...
	if [[ "${result}" == TEST ]]; then
		return "${KSFT_FAIL}"
	fi

	return "${KSFT_PASS}"
}

Several things can leave outfile empty: a transient ssh or nsenter
failure, a socat start failure, or a host listener that never comes up.
Would any of these make test_ns_guest_local_connect_to_host_fails,
test_ns_guest_assign_g2h_netns_init_ns_connect_fails and the first half of
test_ns_guest_assign_g2h_netns_pins_ns_ok report KSFT_PASS, exactly as if
the kernel had refused the connection?

The positive sibling tests use the same paths, so they would catch a
harness that is always broken, but not a transient failure.

Could the result of vm_ns_exec() be checked, so that a harness failure
can be told apart from a refused connect?

> +
> +	timeout "${WAIT_PERIOD}" \
> +		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done'

[ ... ]

> +ns_old_conn_cleanup() {

[ ... ]

> +	vm_ns_exec "init_ns" "" "pkill -f VSOCK-CONNECT:2:${port}" &>/dev/null
> +	terminate_pids "${pid}" "${sender}"
> +	wait "${pid}" "${sender}" 2>/dev/null
> +	rm -f "${outfile}"
> +	vm_ns_stop "init_ns" "${nspid}"
> +	vm_reset_g2h
> +}

[Severity: Low]

This vm_ns_stop() plus vm_reset_g2h() sequence ends every new ns_guest_
test, here and in the test functions themselves. It drops the last
reference on the guest netns, and the teardown then runs asynchronously:

vm_reset_g2h()
  -> vsock_g2h_net_assign()
    -> vsock_g2h_net_release()
         synchronize_rcu();
         put_net_track(old, tracker);
           -> cleanup_net queued on a workqueue

run_shared_vm_test() reads the guest counters as soon as the test
function returns:

	eval test_"${name}"
	rc=$?
	...
	vm_oops_cnt_after=$(vm_dmesg_oops_count "init_ns")
	...
	vm_warn_cnt_after=$(vm_dmesg_warn_count "init_ns")

Could an Oops or WARN from that netns teardown show up after this
sample? It would then be charged to the next shared VM test. If this is
the last test before terminate_pidfiles kills the VM, it would never be
counted.

The commit message says the tests cover "ns destruction", so is it worth
waiting for the teardown to finish before the test returns?

> +
> +test_ns_guest_assign_g2h_netns_old_conn_send_fails() {
> +	local gap=$(( WAIT_PERIOD * 3 ))

[ ... ]

> +	# Send a message, wait, then send another. While waiting, assign the
> +	# device to a namespace. Confirm the second message does not arrive.
> +	vm_ssh "init_ns" -- \
> +		"(echo FIRST; sleep ${gap}; echo SECOND) |" \
> +		"socat -u STDIN VSOCK-CONNECT:2:${port}" &>/dev/null &
> +	sender=$!
> +
> +	timeout "$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))" \
> +		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done'
> +
> +	started=${SECONDS}
> +	if ! vm_ns_assign_g2h "init_ns" "${nspid}"; then

[ ... ]

> +	fi
> +	elapsed=$(( SECONDS - started ))
> +
> +	sleep $(( gap + WAIT_PERIOD ))
> +
> +	result=$(cat "${outfile}")

[ ... ]

> +	if [[ ${elapsed} -ge ${gap} ]]; then
> +		log_host "assign took ${elapsed}s, longer than the ${gap}s gap"
> +		return "${KSFT_SKIP}"
> +	fi
> +
> +	if [[ "${result}" == *SECOND* ]]; then
> +		log_host "old connection still delivered after the assign"
> +		return "${KSFT_FAIL}"
> +	fi

[Severity: Medium]

Can this return KSFT_FAIL on a correct kernel when the guest is slow?

The guest's sleep ${gap} (9s) starts as soon as FIRST is written. The
host stopwatch starts only after the 1s poll loop notices FIRST in
outfile, so the connect and poll delay before started=${SECONDS} is never
counted. On top of that, elapsed has whole-second resolution.

Suppose that delay plus the real assign time (ssh, nsenter, python3,
PyYAML, spec parsing, netlink) goes past 9s while elapsed is still under
9. Then SECOND goes out over the still-attached device before the swap
and reaches the host. The test reports "old connection still delivered
after the assign" instead of the KSFT_SKIP the elapsed check was meant to
give. On TCG or nested guests this seems plausible.

Could the stopwatch start when the sender is launched instead, so the
skip check covers the whole interval?

Separately, the verdict comes from one read of outfile after a fixed
sleep $(( gap + WAIT_PERIOD )), and nothing waits for the sender to
finish. Is that intended?

[ ... ]

> +test_ns_guest_assign_g2h_netns_pins_ns_ok() {

[ ... ]

> +	vm_ns_stop "init_ns" "${nspid}"
> +	sleep "${WAIT_PERIOD}"
> +
> +	outfile=$(mktemp)
> +	guest_send_to_host "init_ns" "" "${port}" "${outfile}"
> +	result=$(cat "${outfile}")
> +	if [[ "${result}" == TEST ]]; then
> +		log_host "device returned to the init ns instead of pinning it"

[Severity: Low]

vm_ns_stop() only waits for the holder process to exit. The netns
teardown (cleanup_net) runs asynchronously after that. Here, a fixed
sleep followed by a single connect from the init ns is the only evidence
that the deleted namespace was pinned.

Suppose a regression stopped the assignment from pinning the netns, and
teardown returned the device to init_net only after more than about 3s
plus the guest_send_to_host() setup. Wouldn't this connect still fail, so
the test passes anyway?

Would it be more robust to query the assignment directly with
dev-netns-get than to rely on a timed connect? It reports
VSOCK_A_NETNS_ID, or NETNSA_NSID_NOT_ASSIGNED when the device isn't in the
caller's ns.

> +		rm -f "${outfile}"
> +		vm_reset_g2h
> +		return "${KSFT_FAIL}"
> +	fi
> +
> +	# Assigning it back is what releases the deleted namespace.
> +	vm_reset_g2h
> +
> +	guest_send_to_host "init_ns" "" "$(( port + 1 ))" "${outfile}"
> +	result=$(cat "${outfile}")
> +	rm -f "${outfile}"
> +
> +	if [[ "${result}" != TEST ]]; then
> +		log_host "device did not come back on reassign: [${result}]"
> +		return "${KSFT_FAIL}"
> +	fi

[Severity: Low]

The TEST_DESCS entry for this test says:

	"Check the assignment keeps the ns alive when deleted, and that reassigning releases it."

Does the test check either half of that? It only checks reachability
from the guest's init ns, before and after vm_reset_g2h().

If vsock_g2h_net_release() lost its put_net_track(), the old netns would
leak and this test would still pass:

net/vmw_vsock/af_vsock.c:vsock_g2h_net_release() {
	synchronize_rcu();
	put_net_track(old, tracker);
}

The test also never checks that the deleted namespace is still alive. A
device that is simply unreachable from init_net, for example one left
pointing at a freed netns, would look the same.

Could the description be narrowed, or could the test check the release
directly?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-vsock-guest-ns-v3-0-b32447c66b23%40meta.com
