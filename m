Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700E73C09E2;
	Sun,  6 Sep 2026 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714248; cv=none; b=qfMae9R5UjrAtD4pwMlWKOVKnM2ltLloSW8I21uCj4OZtr0OwwF3HHzfGJxvyxxDINqW0SVmsBikf/+To0T+0rJglkFvp+SIoEmMR2Jc3FSh+HdDrGvhMYKq8SxdiCICgo//eJPBDsTselg698iN0FT7HqEdVOUBe3tlaeImF9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714248; c=relaxed/simple;
	bh=TrKO+IVafCylphDuUg7oVb018fGOfOedf1V80FIj00A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rzWshhj4gknw2tPb7gk7nYYflTsaijJnDMntwQA1HWkP9K2AcDN5B9WSWwBFKdU+cMHVb+92HinZSS74W0ALCtjiB0e63TS5UvPdC6Alals2dlpurQk7mhpqUnc8q+QhKLkFHkmgks7Ba3vd+pi+8rQNYj6O5KoMqH3aXMsTkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dA8c/Lp4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA8c/Lp4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791831F00A3D;
	Sun,  6 Sep 2026 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788714245;
	bh=XoV3UQ1Na6kJ5zELnSnG7wXXxc4owyx3o0WZmyN5d+E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dA8c/Lp4agP1zz7eF6KXQkQ58xBR6VDO/qFg9NyRu6Ob8002qwyTQvRig5Jqu1l1D
	 aA+XZuZ7dApgkvZhMZUMjWSBg6c9SBl2l6yVyJ7cCqeG2OlsBDNq/CyyhosAX6VWus
	 V6ciwkeOI/EpuOnQ7JJcVrjpNNANW1Rb05lYRxOvzZjeaQzH3SOHO/yj0e9hMsqUoD
	 ovOFoZ2WP4AeA58mVM0KDRTU7/GYDm8fFLVvGNYY10aneA4SBrUUXdC20rHqzBXowc
	 2J92qriMyxkVvX38/5hWrBaSq1OtrEYK8MXJfIU7V6/HYswVepQCPvcyXYruiwvLh/
	 iRNnZeI3jfnlg==
Subject: Re: [PATCH net-next 5/6] selftests/vsock: test the guest vsock device
 network namespace
From: netdev-bot+sashiko@kernel.org
To: bobbyeshleman@gmail.com
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, stefanha@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shuah@kernel.org, rdunlap@infradead.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
 bobbyeshleman@meta.com
Date: Sun, 06 Sep 2026 17:04:04 +0000
Message-ID: <178871424404.219967.10677105499849976882@kernel.org>
In-Reply-To: <20260902-vsock-guest-ns-v1-5-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-5-9995383e9a8b@meta.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 4 · Low: 5

- [Medium] Vacuous PASS in the new negative tests: vm_ns_start() always
  emits a non-empty PID (even when `unshare -n` failed) and…
- [Medium] check_deps() makes the new vsock_assign_g2h_netns helper a
  hard prerequisite for the entire suite (a missing helper now skips…
- [Medium] guest_send_to_host()/host_send_to_guest() tear down their
  socat helper with terminate_pids() (bare SIGTERM, never `wait`), and…
- [Medium] test_ns_guest_assign_g2h_netns_old_conn_send_fails() orders
  three concurrent actors (the backgrounded guest sender, the host…
- [Low] The header comment of vsock_g2h_net_get()
  (net/vmw_vsock/af_vsock.c:754-756) states it returns the g2h device's…
- [Low] In test_ns_guest_assign_g2h_netns_old_conn_send_fails() the long-
  running sender is backgrounded (`vm_ssh ... &`) but its PID is never…
- [Low] host_send_to_guest() captures `$!` of the local backgrounded
  `vm_ns_exec ...` (a subshell running the ssh client), not of the…
- [Low] vm_ns_start() publishes the backgrounded `unshare -n sleep
  infinity` PID with no barrier proving that unshare(2) has already…
- [Low] Five of the six new tests return immediately after
  vm_ns_stop()+vm_reset_g2h() while the guest's netns dismantling is…

--

selftests/vsock: test the guest vsock device network namespace

This adds six vmtest.sh cases around the guest vsock device namespace
assignment: guest to host and host to guest transfers, namespace deletion,
and moving the device between namespaces while a socket is live.  The
namespaces are created inside the guest with unshare -n and held open by a
sleeping process.

A few questions about the new helpers and the pass/fail criteria below.

> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> index 310dfc2a39ad..53591fa07f1a 100755
> --- a/tools/testing/selftests/vsock/vmtest.sh
> +++ b/tools/testing/selftests/vsock/vmtest.sh
> @@ -17,6 +17,7 @@ readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
>  source "${SCRIPT_DIR}"/../kselftest/ktap_helpers.sh
>  
>  readonly VSOCK_TEST="${SCRIPT_DIR}"/vsock_test
> +readonly VSOCK_ASSIGN_G2H_NETNS="${SCRIPT_DIR}"/vsock_assign_g2h_netns
>  readonly TEST_GUEST_PORT=51000
>  readonly TEST_HOST_PORT=50000
>  readonly TEST_HOST_PORT_LISTENER=50001

[ ... ]

> @@ -302,18 +333,20 @@ check_args() {
>  }
>  
>  check_deps() {
> -	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter; do
> +	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter unshare; do
>  		if [[ ! -x $(command -v "${dep}") ]]; then
>  			echo -e "skip:    dependency ${dep} not found!\n"
>  			exit "${KSFT_SKIP}"
>  		fi
>  	done
>  
> -	if [[ ! -x $(command -v "${VSOCK_TEST}") ]]; then
> -		printf "skip:    %s not found!" "${VSOCK_TEST}"
> -		printf " Please build the kselftest vsock target.\n"
> -		exit "${KSFT_SKIP}"
> -	fi
> +	for prog in "${VSOCK_TEST}" "${VSOCK_ASSIGN_G2H_NETNS}"; do
> +		if [[ ! -x $(command -v "${prog}") ]]; then
> +			printf "skip:    %s not found!" "${prog}"
> +			printf " Please build the kselftest vsock target.\n"
> +			exit "${KSFT_SKIP}"
> +		fi
> +	done
>  }

[Severity: Medium]
Should a missing vsock_assign_g2h_netns skip the whole suite?  check_deps()
runs before any test selection, so with this loop "vmtest.sh vm_loopback" in
an environment that only installed vsock_test now exits KSFT_SKIP and the
pre-existing tests lose coverage too.

Related question on the other side: is there a gate for a kernel that does
not implement the assign ioctl?  vm_ns_assign_g2h() just propagates the
helper's exit status:

vm_ns_assign_g2h() {
	local ns=$1
	local nspid=$2

	vm_ns_exec "${ns}" "${nspid}" ./vsock_assign_g2h_netns
}

and all five callers turn a non-zero status into KSFT_FAIL:

	if ! vm_ns_assign_g2h "init_ns" "${nspid}"; then
		log_host "failed to assign the vsock device to the guest ns"
		...
		return "${KSFT_FAIL}"
	fi

On a kernel without the feature the ioctl fails and the tests report FAIL
rather than SKIP.  check_netns() already has the precedent of skipping only
the ns_* tests when the capability is absent:

	if [[ "${tname}" =~ ^ns_ ]] &&
	   [[ ! -e /proc/self/ns ]]; then
		log_host "No NS support detected for test ${tname}"
		return 1
	fi

Would a similar per-feature gate fit here?

[ ... ]

> @@ -528,6 +562,58 @@ vm_wait_for_ssh() {
>  	done
>  }
>  
> +# Create a local mode namespace in the VM and echo the pid holding it open.
> +vm_ns_start() {
> +	local ns=$1
> +
> +	vm_ssh "${ns}" -- \
> +		"echo local > /proc/sys/net/vsock/child_ns_mode" &>/dev/null
> +
> +	vm_ssh "${ns}" -- "unshare -n sleep infinity" \
> +		'>/dev/null 2>&1 & echo $!'
> +}

[Severity: Medium]
Can the two negative tests pass without ever running anything in the guest?
The remote shell prints $! as soon as the job is forked, so vm_ns_start()
emits a non-empty PID and returns 0 even when unshare immediately fails (no
CONFIG_NET_NS in the guest, EPERM, exec failure).  The write to
child_ns_mode above it is also &>/dev/null with its status ignored.

The only setup validation in each new test is:

	nspid=$(vm_ns_start "init_ns")
	if [[ -z "${nspid}" ]]; then
		log_host "failed to create a namespace inside the guest"
		return "${KSFT_FAIL}"
	fi

which cannot fire in that case.  With a stale PID, vm_ns_exec() runs
"nsenter -t <dead pid> -n sh -c ..." which exits non-zero without executing
socat, and guest_send_to_host() discards that status:

	vm_ns_exec "${ns}" "${nspid}" "${cmd}" 2>/dev/null

The poll then just times out, and both
test_ns_guest_local_connect_to_host_fails() and
test_ns_guest_assign_g2h_netns_init_ns_connect_fails() evaluate an empty
file against:

	if [[ "${result}" == TEST ]]; then
		return "${KSFT_FAIL}"
	fi

	return "${KSFT_PASS}"

so "the command never ran" is indistinguishable from "the kernel blocked the
connection".  Would checking the exit status of the guest command, or adding
a positive control to these two tests, make the difference visible?

[Severity: Low]
A second question on the same helper: is there a barrier proving unshare(2)
has already run before the PID is used?  unshare execs, calls
unshare(CLONE_NEWNET), then execs sleep, while callers immediately use the
published PID as an nsenter target:

	vm_ssh "${ns}" -- nsenter -t "${nspid}" -n sh -c "'${cmd}'"

If /proc/<pid>/ns/net is still the initial netns at that moment, the command
runs in the guest's initial namespace instead.  In practice every consumer
first pays a fresh ssh round trip, so the window is small, but a poll until
readlink /proc/${nspid}/ns/net differs from the initial namespace would
close it.

> +
> +# Returns once the holder is gone, so that the namespace is unreferenced and
> +# the kernel can start tearing it down.
> +vm_ns_stop() {
> +	local ns=$1
> +	local nspid=$2
> +
> +	vm_ssh "${ns}" <<-EOF &>/dev/null
> +		kill ${nspid}
> +		for ((i = 0; i < ${WAIT_PERIOD_MAX}; i++)); do
> +			kill -0 ${nspid} 2>/dev/null || break
> +			sleep 1
> +		done
> +	EOF
> +}
> +
> +# Runs in the guest's initial namespace when <nspid> is empty. The command must
> +# not contain single quotes.
> +vm_ns_exec() {
> +	local ns=$1
> +	local nspid=$2
> +	local cmd=$3
> +
> +	if [[ -z "${nspid}" ]]; then
> +		vm_ssh "${ns}" -- "${cmd}"
> +		return
> +	fi
> +
> +	vm_ssh "${ns}" -- nsenter -t "${nspid}" -n sh -c "'${cmd}'"
> +}
> +
> +vm_ns_assign_g2h() {
> +	local ns=$1
> +	local nspid=$2
> +
> +	vm_ns_exec "${ns}" "${nspid}" ./vsock_assign_g2h_netns
> +}
> +
> +vm_reset_g2h() {
> +	vm_ns_assign_g2h "init_ns" "" &>/dev/null
> +}
> +

[ ... ]

> @@ -1421,6 +1521,290 @@ test_ns_delete_both_ok() {
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
> +
> +	timeout "${WAIT_PERIOD}" \
> +		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done'
> +
> +	terminate_pids "${pid}"
> +}

[Severity: Medium]
Can consecutive tests collide on host vsock port 12345?  The listener here
is torn down with terminate_pids(), which sends SIGTERM and never waits:

	for pid in "$@"; do
		kill -SIGTERM "${pid}" &>/dev/null || :
	done

so the socket may still be bound when guest_send_to_host() returns.
test_ns_guest_local_connect_to_host_fails,
test_ns_guest_assign_g2h_netns_connect_to_host_ok,
test_ns_guest_assign_g2h_netns_init_ns_connect_fails and
test_ns_guest_assign_g2h_netns_host_connect_ok all declare "local
port=12345" and run back to back in the same host namespace.

If the previous socat is still bound, either the new bind fails with
EADDRINUSE, or ss() sees the old listener whose stdout points at the
previous, already-deleted outfile.  Either way the new outfile stays empty,
and the failure is silent because wait_for_listener() breaks out of its loop
on timeout and returns 0 with no caller checking it.

test_ns_guest_assign_g2h_netns_reset_on_ns_delete_ok already uses
"$(( port + i ))" per retry.  Would a per-test port, or a wait after the
kill, help here as well?

> +
> +# Send a string from the host to a listener in the guest and leave what the
> +# guest received in <outfile>.
> +host_send_to_guest() {
> +	local ns=$1
> +	local nspid=$2
> +	local port=$3
> +	local outfile=$4
> +	local cmd="socat -u VSOCK-LISTEN:${port} STDOUT"
> +	local dst="VSOCK-CONNECT:${VSOCK_CID}:${port}"
> +	local pid
> +
> +	vm_ns_exec "${ns}" "${nspid}" "${cmd}" > "${outfile}" 2>/dev/null &
> +	pid=$!
> +	vm_ns_wait_for_listener "${ns}" "${nspid}" "${port}" "vsock"
> +
> +	echo TEST | socat -u STDIN "${dst}" 2>/dev/null
> +
> +	timeout "${WAIT_PERIOD}" \
> +		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done'
> +
> +	terminate_pids "${pid}"
> +}

[Severity: Low]
Does terminate_pids() reach the guest-side listener here?  The captured $!
is the local subshell running the ssh client, not the nsenter/socat inside
the guest namespace.  ssh is invoked without a TTY, so killing the local
side does not signal the remote process group, and a socat blocked in
accept() does not notice the closed channel.

vm_ns_stop() then waits only for the sleep infinity holder, so its documented
postcondition:

# Returns once the holder is gone, so that the namespace is unreferenced and
# the kernel can start tearing it down.

does not hold while that leftover socat still references the namespace.  In
the passing path the host does connect and send, so the guest socat sees EOF
and exits on its own; the leftover appears when the transfer fails.

> +
> +test_ns_guest_assign_g2h_netns_old_conn_send_fails() {
> +	local gap=$(( WAIT_PERIOD * 3 ))
> +	local port=12346
> +	local outfile
> +	local result
> +	local nspid
> +	local pid
> +
> +	nspid=$(vm_ns_start "init_ns")
> +	if [[ -z "${nspid}" ]]; then
> +		log_host "failed to create a namespace inside the guest"
> +		return "${KSFT_FAIL}"
> +	fi
> +
> +	outfile=$(mktemp)
> +	socat -u VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
> +	pid=$!
> +	host_wait_for_listener "init_ns" "${port}" "vsock"
> +
> +	# Send a message, wait, then send another. While waiting, assign the
> +	# device to a namespace. Confirm the second message does not arrive.
> +	vm_ssh "init_ns" -- \
> +		"(echo FIRST; sleep ${gap}; echo SECOND) |" \
> +		"socat -u STDIN VSOCK-CONNECT:2:${port}" &>/dev/null &
> +
> +	sleep "${WAIT_PERIOD}"

[Severity: Medium]
Can a correct kernel hit either FAIL verdict in this test?  Three actors are
ordered with fixed sleeps only.

If the assign lands too early: the guest sender is backgrounded and the
script waits just "sleep ${WAIT_PERIOD}" (3 s).  Bringing up a fresh ssh
session into the 9p-rootfs VM, starting socat and connecting can exceed that
on a loaded host, in which case the device moves before the connection
exists, FIRST never lands, and the test reports:

	if [[ "${result}" != *FIRST* ]]; then
		log_host "connection did not work before the assign: [${result}]"
		return "${KSFT_FAIL}"
	fi

If the assign lands too late: the assign is itself a new ssh session plus
nsenter plus the ioctl, while the second write happens at gap =
WAIT_PERIOD * 3 (9 s) after the sender started and the assign is issued at
about 3 s.  If the assign round trip exceeds the remaining 6 s, SECOND is
delivered legitimately and the test reports "old connection still delivered
after the assign".

Would polling the outfile for FIRST before doing the assign, using the same
"timeout ... while [[ ! -s file ]]" idiom already used in
guest_send_to_host(), make this deterministic?

[Severity: Low]
Separately, is the backgrounded sender ever reaped?  No $! is captured here,
so it is not passed to terminate_pids() and not registered with the PIDFILES
map used by the EXIT trap:

cleanup() {
	terminate_pidfiles "${!PIDFILES[@]}"
	del_namespaces
	rm -rf "${TEST_HOME}"
}

On the assign-failure early return the host ssh client and the guest-side
subshell still have "sleep ${gap}" (9 s) to run, and on script interruption
they outlive the script.  Every other background job in this script is
tracked either with pid=$! plus terminate_pids or via create_pidfile().

> +
> +	if ! vm_ns_assign_g2h "init_ns" "${nspid}"; then
> +		log_host "failed to assign the vsock device to the guest ns"
> +		terminate_pids "${pid}"
> +		rm -f "${outfile}"
> +		vm_ns_stop "init_ns" "${nspid}"
> +		vm_reset_g2h
> +		return "${KSFT_FAIL}"
> +	fi
> +
> +	# Let the second write happen and land, if it is going to.
> +	sleep $(( gap + WAIT_PERIOD ))
> +
> +	terminate_pids "${pid}"
> +	result=$(cat "${outfile}")
> +	rm -f "${outfile}"
> +
> +	vm_ns_stop "init_ns" "${nspid}"
> +	vm_reset_g2h
> +
> +	if [[ "${result}" != *FIRST* ]]; then
> +		log_host "connection did not work before the assign: [${result}]"
> +		return "${KSFT_FAIL}"
> +	fi
> +
> +	if [[ "${result}" == *SECOND* ]]; then
> +		log_host "old connection still delivered after the assign"
> +		return "${KSFT_FAIL}"
> +	fi
> +
> +	return "${KSFT_PASS}"
> +}

[ ... ]

> +test_ns_guest_assign_g2h_netns_reset_on_ns_delete_ok() {

[ ... ]

> +	vm_ns_stop "init_ns" "${nspid}"
> +
> +	# The holder is gone, but the namespace itself is dismantled from a
> +	# workqueue, so the device does not come back the same instant. Retry
> +	# until it does, rather than expecting the first send to succeed.

[Severity: Low]
This comment documents an asynchronous teardown that only this test waits
for.  The other five return right after vm_ns_stop() plus vm_reset_g2h()
while the guest namespace is still being dismantled, and
run_shared_vm_test() snapshots the dmesg warn count per test:

	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")

	name=$(echo "${1}" | awk '{ print $1 }')
	eval test_"${name}"
	rc=$?

so a warning emitted by test N's in-flight teardown is charged to test N+1.
Would a short wait for the teardown in the other tests avoid that
misattribution?

The device state itself does look well defined: vsock_g2h_net_reset() in
net/vmw_vsock/af_vsock.c returns early unless the dying net is the current
one:

	if (likely(rcu_access_pointer(vsock_g2h_net) != net))
		return;

so a late teardown cannot pull the device out of a later test's namespace.

[ ... ]

One more note, on the kernel side of this series rather than on this patch:

[Severity: Low]
The header comment of vsock_g2h_net_get() in net/vmw_vsock/af_vsock.c says:

/* Return the g2h devices' namespace with a reference held, or NULL if that
 * namespace is being destroyed.
 */

but in exactly that case the function can return a reference to a different
namespace instead of NULL:

	if (!net && vsock_net_check_mode(&init_net, assigned))
		net = get_net(&init_net);

The in-function comment just below explains the init_net fallback, so only
the header sentence looks out of date for an exported symbol that callers
such as virtio_transport_rx_work() rely on.  Could the header comment
mention the init_net fallback?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902-vsock-guest-ns-v1-0-9995383e9a8b%40meta.com
