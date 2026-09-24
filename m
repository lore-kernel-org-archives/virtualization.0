Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2230D41E
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210586; cv=none; b=apBYBw4m7NhbnFbTsVp3gh/sXvViApBvJYEqgDbQqAwq2zjJ2c2rOk1ZVdWSUuc0R6huUuk6boq6uO27S0qlt7v3d4pbZ7ytYN46H6aHttXrN7JnArBNmqgvP/gqceqXSlORzvmeb9LmRyyDz2+LogBftOjQSpReo3TPV3AnWi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210586; c=relaxed/simple;
	bh=m8u3oQbPv4jMGTm/bHOzZ2Qdj+gjEErwltYZOk/wC0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGS7eq0p+MrH8B95cIl91pxi5ZZwGgRy+yJKMVA9NhtQyEE3ukVWT/ODRUtful02qH8PV7yt1qqDGCjx6w6YVqSB0Ygi8ZfYFf6EGHNjd6aBzFUkzVL9zENMIGPlrd7Jxbr/SRwYTceL9Vag8tpHv7QuqedO4epifSrvoXQ7z6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEfJqYvl; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEfJqYvl"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6b1ae6b2010so1014760eaf.0
        for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 17:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790210582; x=1790815382; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+NqaMWzaYI2s7PjxVuerr3kXsAdaWSdDakA2uCUhrW4=;
        b=YEfJqYvlPYRMfJxlXV4Iki/AGQg3Ny/42IDEqzlWQ1IwDQrD+RF3vQEchgjF7Mep2n
         Q7KoxuPXTdJ/2qltL2WA/Mz8MfNqsrMIB7vJ8k66WXMI8QrmsL/9wZZBxi1eRdAlyT2Y
         HkfMcUMzdZpZ5L9yk14Y3ahW/mIuX6KomEFd8nuUoAzkThXcUBMsByAJcCWlFRdIuSXH
         gChEE3Kr1C28PC8lXQM68DVfbQWEV1go8QgWvBo61oZAeXPiHuWw20cUqSX9YKDkvBAm
         Gulv1iN3cjwFx9pOikYZ1/HnDOX8smi9R9g25pS6c00JisVIF0E9MgWWNTghCNB2DrLJ
         BfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790210582; x=1790815382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+NqaMWzaYI2s7PjxVuerr3kXsAdaWSdDakA2uCUhrW4=;
        b=BHIlygF1e5+LSLxbpbTYJz8HhZ/kZT6oakM3oP5dVwuKjNO9eNIoQ1fEj3C2uMJUki
         ocnoZD/U6BpWlHLEYX/UFmz2Q6VLVEI3hIVDLbBqn9Hjz4XP7+JFz6Z/BvTK3OGB3kie
         v3S2Uqy8xOx9a0A/U9vh+TOpcWnU1bZ+dG47frbuP9rFrMpv34EZZQdv4LC2fOwsfGb5
         du0AXwjoREoh291+tvRXwo3kaujElZ/UFAyHKvlz/uyFnlJL3ubSDC+oybK2JmU4eBON
         +Scg9JN+X9n76AA/IfIuyUNd8l66MHewYUq6j4nYhmt7Q1ojWxl5hU0r9mVMfKwjn3Mz
         f+gg==
X-Forwarded-Encrypted: i=1; AKwUvBw+PKzwx2Tlg7/1/0V1fqK3JW08Qbdkiue9nEacD1ejLYri/r03Fv9LXvasfl0+g3/P2Vcd6RV6oDu8q5mx4g==@lists.linux.dev
X-Gm-Message-State: AFuF++mzYau+81wZuIVO9iD24iHqLZGE3OOflmu8MrzBjpybROeNx1aa
	G+kZsVltHMt0J7QX9v2V0bT4pwVBmEIKazhBSkjtkkWl3E0IJc6qNng6
X-Gm-Gg: AYBFou32GoNxwRYqhQjRlrI467ljjFIJvnrr9XmM2IykzkouQ+Q1nDo7Eo0AI5Je0rI
	OXQu1K0GBNjBK7f8+tGzagSPhlPrcppTRIA/kMVXmSuUDa4MDtzd2ln4pEs3SkR9X8HK0R949V9
	gsEtie8xFJDa3SEt7rHjXh1Qr9+XQtsThJYObY+jWo47nzfMnoSi/4D+71xOw44QonAXAZnIc9p
	HUtNQYW0m+ZCggL8Hk+me1l3pdP7/cyBMnHrZ/rq60pVNEU9SHx2W1nKnyMatmb6Iu6j3/rPfgb
	ACyYc71YzrBDq5hQI0oI7QzBjLsF29XIzD8PkiUsH8RSsGxgDJtvlHBSKxvRWTUCZkh64Cg3bDH
	DSDpRnIwv9fWZIpjq6gjvXqamKY5KjH65BtYQJ9jtWwxSD+97WXgTekBlGDRJFzpFxgx50HfYCl
	y+BefYkJK1+PczzO7cBjC5x7MNehUsPeMku1TI0W8IzIOxDGLq4mY+k/ZY/OE4lOO0OEZ20usxX
	x/1pOR9842N5fWdiNn1
X-Received: by 2002:a4a:e911:0:b0:6cd:3fcc:96cd with SMTP id 006d021491bc7-6d440727618mr932662eaf.75.1790210581830;
        Wed, 23 Sep 2026 17:43:01 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491edb6559esm1021895fac.13.2026.09.23.17.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 17:43:00 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:42:56 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org, stefanha@redhat.com,
	mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shuah@kernel.org, rdunlap@infradead.org,
	donald.hunter@gmail.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
	sdf.kernel@gmail.com, bobbyeshleman@meta.com
Subject: Re: [PATCH net-next v2 5/6] selftests/vsock: test the guest vsock
 device network namespace
Message-ID: <arRyEMltRgwxJIbI@devvm29614.prn0.facebook.com>
References: <20260921-vsock-guest-ns-v2-5-693bd78fde9e@meta.com>
 <179019126563.2160803.9263469000405874269@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179019126563.2160803.9263469000405874269@kernel.org>

On Wed, Sep 23, 2026 at 07:21:05PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 4 · Low: 2 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] check_deps() in tools/testing/selftests/vsock/vmtest.sh now
>   hard-requires two files that live outside the selftests directory —…
> - [Medium] vm_ns_start() (vmtest.sh:588-596) reports success even when
>   the guest-side namespace setup fails.
> - [Medium] test_ns_guest_assign_g2h_netns_old_conn_send_fails()
>   (vmtest.sh:1594-1653) orders three concurrent actors — the guest…
> - [Medium] host_send_to_guest() (vmtest.sh:1582-1591) and
>   test_ns_guest_assign_g2h_netns_old_conn_send_fails()…
> - [Low] guest_send_to_host() (vmtest.sh:1568) and host_send_to_guest()
>   (vmtest.sh:1591) release their background listeners with…
> - [Low] vm_ns_start() (vmtest.sh:594-595) backgrounds `unshare -n sleep
>   infinity` in the guest and immediately echoes `$!`, with no…
> 
> Pre-existing issues:
> - [Low] The new helpers splice an unquoted path into a string handed to
>   an inner shell: `timeout "${WAIT_PERIOD}" bash -c 'while [[ !
> 
> --
> 
> selftests/vsock: test the guest vsock device network namespace
> 
> This adds six new shared-VM tests to vmtest.sh that exercise assigning the
> guest vsock device to a network namespace, using tools/net/ynl/pyynl/cli.py
> plus Documentation/netlink/specs/vsock.yaml to drive dev-netns-set.  The
> dependency checks in check_deps() gain unshare, python3 and PyYAML.
> 
> A few questions about the new harness code below.
> 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index 310dfc2a39ad5..e94cc2fd90ccd 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -17,6 +17,8 @@ readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
> >  source "${SCRIPT_DIR}"/../kselftest/ktap_helpers.sh
> >  
> >  readonly VSOCK_TEST="${SCRIPT_DIR}"/vsock_test
> > +readonly YNL_CLI="${KERNEL_CHECKOUT}"/tools/net/ynl/pyynl/cli.py
> > +readonly VSOCK_SPEC="${KERNEL_CHECKOUT}"/Documentation/netlink/specs/vsock.yaml
> 
> [ ... ]
> 
> > @@ -314,6 +347,18 @@ check_deps() {
> >  		printf " Please build the kselftest vsock target.\n"
> >  		exit "${KSFT_SKIP}"
> >  	fi
> > +
> > +	if ! python3 -c "import yaml" &>/dev/null; then
> > +		echo -e "skip:    python3 yaml module not found!\n"
> > +		exit "${KSFT_SKIP}"
> > +	fi
> > +
> > +	for dep in "${YNL_CLI}" "${VSOCK_SPEC}"; do
> > +		if [[ ! -r "${dep}" ]]; then
> > +			printf "skip:    %s not found!\n" "${dep}"
> > +			exit "${KSFT_SKIP}"
> > +		fi
> > +	done
> >  }
> 
> [Severity: Medium]
> Does this turn the whole suite into a skip when vmtest.sh is run from an
> installed tree?  Both new dependencies are anchored at KERNEL_CHECKOUT
> (SCRIPT_DIR/../../../../), so they only resolve inside a kernel source
> tree, and check_deps() exits before any test is selected:
> 
> 	readonly YNL_CLI="${KERNEL_CHECKOUT}"/tools/net/ynl/pyynl/cli.py
> 	readonly VSOCK_SPEC="${KERNEL_CHECKOUT}"/Documentation/netlink/specs/vsock.yaml
> 
> tools/testing/selftests/vsock/Makefile still ships only:
> 
> 	TEST_PROGS += vmtest.sh
> 	TEST_GEN_FILES := vsock_test
> 
> There is no TEST_FILES entry for cli.py, its pyynl/lib package, or
> vsock.yaml, so after "make -C tools/testing/selftests install" the new
> check can never be satisfied, and the 24 pre-existing tests that do not
> need ynl at all are skipped too.  Would adding these to TEST_FILES (the way
> tools/testing/selftests/net/ovpn/Makefile lists
> ../../../../net/ynl/pyynl/cli.py) work here, or alternatively limiting the
> skip to the six new tests instead of the whole script?
> 
> [ ... ]

valid, will fix.

> 
> > @@ -528,6 +584,59 @@ vm_wait_for_ssh() {
> >  	done
> >  }
> >  
> > +# Create a local mode namespace in the VM and echo the pid holding it open.
> > +vm_ns_start() {
> > +	local ns=$1
> > +
> > +	vm_ssh "${ns}" -- \
> > +		"echo local > /proc/sys/net/vsock/child_ns_mode" &>/dev/null
> > +
> > +	vm_ssh "${ns}" -- "unshare -n sleep infinity" \
> > +		'>/dev/null 2>&1 & echo $!'
> > +}
> 
> [Severity: Medium]
> Can vm_ns_start() ever report failure?  The remote shell runs
> 
> 	unshare -n sleep infinity >/dev/null 2>&1 & echo $!
> 
> so the pid is printed at fork time, regardless of whether unshare actually
> ran (missing binary, missing privilege, immediate exit).  The write to
> /proc/sys/net/vsock/child_ns_mode is also discarded with &>/dev/null and
> its status is never looked at.
> 
> That makes the guard used by all six new tests unable to detect the
> condition its message names:
> 
> 	nspid=$(vm_ns_start "init_ns")
> 	if [[ -z "${nspid}" ]]; then
> 		log_host "failed to create a namespace inside the guest"
> 		return "${KSFT_FAIL}"
> 	fi

valid, will fix.

> 
> For the two negative tests, test_ns_guest_local_connect_to_host_fails()
> and test_ns_guest_assign_g2h_netns_init_ns_connect_fails(), the pass
> condition is an empty outfile:
> 
> 	if [[ "${result}" == TEST ]]; then
> 		return "${KSFT_FAIL}"
> 	fi
> 
> 	return "${KSFT_PASS}"
> 
> An empty outfile is also what a broken harness produces, since vm_ns_exec()
> discards stderr and does not check the status of nsenter, and
> wait_for_listener() always returns 0.  Would it make sense to verify the
> namespace exists before testing, for example comparing
> readlink /proc/<nspid>/ns/net against /proc/self/ns/net, so a setup failure
> cannot be reported as ok?

Sure, if that is the only way the test could break. Will look into and
fix / find a better way.

> 
> [Severity: Low]
> Separately, is there anything ordering the unshare against its first use?
> The pid is echoed as soon as the child is forked, and the consumer is a
> later, separate ssh invocation:
> 
> 	vm_ssh "${ns}" -- nsenter -t "${nspid}" -n sh -c "'${cmd}'"
> 
> If the guest child has not reached unshare(CLONE_NEWNET) yet,
> /proc/<nspid>/ns/net is still the guest's initial netns, so dev-netns-set
> targets the initial namespace and the _ok tests fail while the _fails tests
> assert nothing.  The window looks small, because a fresh SSH connection has
> to be set up first, but nothing structurally prevents it.

ssh is unlikely to win this race, but wierder things have happend. I
guess we can wait until the ns exists before proceeding.

> 
> > +
> > +# Returns once the holder is gone, so that the namespace is unreferenced and
> > +# the kernel can start tearing it down.
> > +vm_ns_stop() {
> > +	local ns=$1
> > +	local nspid=$2
> > +
> > +	vm_ssh "${ns}" <<-EOF &>/dev/null
> > +		kill ${nspid}
> > +		for ((i = 0; i < ${WAIT_PERIOD_MAX}; i++)); do
> > +			kill -0 ${nspid} 2>/dev/null || break
> > +			sleep 1
> > +		done
> > +	EOF
> > +}
> > +
> > +# Runs in the guest's initial namespace when <nspid> is empty. The command must
> > +# not contain single quotes.
> > +vm_ns_exec() {
> > +	local ns=$1
> > +	local nspid=$2
> > +	local cmd=$3
> > +
> > +	if [[ -z "${nspid}" ]]; then
> > +		vm_ssh "${ns}" -- "${cmd}"
> > +		return
> > +	fi
> > +
> > +	vm_ssh "${ns}" -- nsenter -t "${nspid}" -n sh -c "'${cmd}'"
> > +}
> 
> [Severity: Low]
> This isn't a bug introduced by this patch, and the same idiom already
> exists in vm_start() and check_ns_delete_doesnt_break_connection(), but the
> quoting here rests on a comment rather than on the code: vm_ns_exec()
> builds a remote root command as sh -c "'${cmd}'" and the new wait loops
> splice an unquoted path into an inner shell:
> 
> 	timeout "${WAIT_PERIOD}" \
> 		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done'
> 
> Whitespace or shell metacharacters in the path (for instance through TMPDIR
> affecting mktemp) would be interpreted by the inner shell and the wait loop
> would return immediately on a parse error.  Would passing the path as a
> positional argument to bash -c be preferable?

won't fix in this series.

> 
> [ ... ]
> 
> > @@ -1421,6 +1546,292 @@ test_ns_delete_both_ok() {
> >  	check_ns_delete_doesnt_break_connection "both"
> >  }
> >  
> > +# Send a string from the guest to a host listener and leave what the host
> > +# received in <outfile>.
> > +guest_send_to_host() {
> > +	local ns=$1
> > +	local nspid=$2
> > +	local port=$3
> > +	local outfile=$4
> > +	local cmd="echo TEST | socat -u STDIN VSOCK-CONNECT:2:${port}"
> > +	local pid
> > +
> > +	socat -u VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
> > +	pid=$!
> > +	host_wait_for_listener "${ns}" "${port}" "vsock"
> > +
> > +	vm_ns_exec "${ns}" "${nspid}" "${cmd}" 2>/dev/null
> > +
> > +	timeout "${WAIT_PERIOD}" \
> > +		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done'
> > +
> > +	terminate_pids "${pid}"
> > +}
> 
> [Severity: Low]
> Can the host listener still hold the port when the next test binds it?
> terminate_pids() only signals and returns:
> 
> 	terminate_pids() {
> 		local pid
> 
> 		for pid in "$@"; do
> 			kill -SIGTERM "${pid}" &>/dev/null || :
> 		done
> 	}
> 
> There is no wait, and the six new shared-VM tests reuse hard-coded ports
> (12345 in four tests, 12345..12349 and 12346 in the last two) back to back
> in the same VM.  socat's stderr goes to /dev/null so an EADDRINUSE is
> invisible, and host_wait_for_listener() would then be satisfied by the
> stale listener because wait_for_listener() just greps
> ss --listening --vsock for the port, leaving the new test reading an outfile
> nothing writes.  Would a wait on the pid, a bind-success check, or unique
> per-test ports close that?

will fix by waiting on pid.

> 
> > +
> > +# Send a string from the host to a listener in the guest and leave what the
> > +# guest received in <outfile>.
> > +host_send_to_guest() {
> > +	local ns=$1
> > +	local nspid=$2
> > +	local port=$3
> > +	local outfile=$4
> > +	local cmd="socat -u VSOCK-LISTEN:${port} STDOUT"
> > +	local dst="VSOCK-CONNECT:${VSOCK_CID}:${port}"
> > +	local pid
> > +
> > +	vm_ns_exec "${ns}" "${nspid}" "${cmd}" > "${outfile}" 2>/dev/null &
> > +	pid=$!
> > +	vm_ns_wait_for_listener "${ns}" "${nspid}" "${port}" "vsock"
> > +
> > +	echo TEST | socat -u STDIN "${dst}" 2>/dev/null
> > +
> > +	timeout "${WAIT_PERIOD}" \
> > +		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done'
> > +
> > +	terminate_pids "${pid}"
> > +}
> 
> [Severity: Medium]
> Which process does pid=$! name here?  vm_ns_exec() is a shell function with
> several commands, so backgrounding it makes bash fork a subshell, and $! is
> that subshell rather than ssh.  terminate_pids() then SIGTERMs only the
> wrapper, while the ssh child and the guest-side
> socat -u VSOCK-LISTEN:<port> STDOUT keep running.
> 
> The same applies to the sender in
> test_ns_guest_assign_g2h_netns_old_conn_send_fails():
> 
> 	vm_ssh "init_ns" -- \
> 		"(echo FIRST; sleep ${gap}; echo SECOND) |" \
> 		"socat -u STDIN VSOCK-CONNECT:2:${port}" &>/dev/null &
> 	sender=$!
> 
> If that is right, then the v2 changelog entry
> 
> 	"Terminate the guest socat sender too, it sometimes outlived the
> 	 test and kept holding on to a port the next test binds"
> 
> does not have the described effect, since killing a local wrapper subshell
> cannot terminate the remote process.
> 
> A leftover guest socat also keeps a reference on the namespace created by
> vm_ns_start(), so the postcondition documented on vm_ns_stop()
> 
> 	# Returns once the holder is gone, so that the namespace is unreferenced and
> 	# the kernel can start tearing it down.
> 
> may not hold, which is exactly what
> test_ns_guest_assign_g2h_netns_reset_on_ns_delete_ok() relies on.  Would
> killing the remote command explicitly (or using ssh with a process group /
> pkill inside the guest) be more reliable?
> 
> > +
> > +test_ns_guest_assign_g2h_netns_old_conn_send_fails() {
> > +	local gap=$(( WAIT_PERIOD * 3 ))
> > +	local port=12346
> 
> [ ... ]
> 
> > +	outfile=$(mktemp)
> > +	socat -u VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
> > +	pid=$!
> > +	host_wait_for_listener "init_ns" "${port}" "vsock"
> > +
> > +	# Send a message, wait, then send another. While waiting, assign the
> > +	# device to a namespace. Confirm the second message does not arrive.
> > +	vm_ssh "init_ns" -- \
> > +		"(echo FIRST; sleep ${gap}; echo SECOND) |" \
> > +		"socat -u STDIN VSOCK-CONNECT:2:${port}" &>/dev/null &
> > +	sender=$!
> > +
> > +	sleep "${WAIT_PERIOD}"
> > +
> > +	if ! vm_ns_assign_g2h "init_ns" "${nspid}"; then
> 
> [Severity: Medium]
> Is a fixed sleep enough to order these three actors?  The guest sender, the
> host listener and the assign are only sequenced by sleeps, and nothing
> confirms FIRST actually arrived before the assign (unlike
> guest_send_to_host(), which polls the outfile).
> 
> If ssh plus socat startup in the VM takes longer than WAIT_PERIOD (3s), the
> assign happens first, the connection is never established, the outfile stays
> empty, and the test reports
> 
> 	log_host "no connection before the assign: [${result}]"
> 
> against a correctly behaving kernel.
> 
> > +		log_host "failed to assign the vsock device to the guest ns"
> > +		terminate_pids "${pid}" "${sender}"
> > +		rm -f "${outfile}"
> > +		vm_ns_stop "init_ns" "${nspid}"
> > +		vm_reset_g2h
> > +		return "${KSFT_FAIL}"
> > +	fi
> > +
> > +	# Let the second write happen and land, if it is going to.
> > +	sleep $(( gap + WAIT_PERIOD ))
> 
> [Severity: Medium]
> And in the other direction, can the assign lose the race against the
> sender's gap?  vm_ns_assign_g2h() is an ssh connection plus nsenter plus a
> python3 interpreter start and a PyYAML spec parse.  If that exceeds the
> sender's sleep of 9s, SECOND is delivered before the device moves and the
> test reports "old connection still delivered after the assign" for a kernel
> that is behaving as intended.
> 
> Could the same polling already used in guest_send_to_host() be applied
> here, waiting for FIRST in the outfile before the assign and for the assign
> to complete before the second write is expected?
> 

This is probably the right thing to do... though I'm not a big fan of
having a custom wait_for_X function for every single type of event.
I'll explore if its possible to have more generic/reusable coordination,
or otherwise fix this as is.
