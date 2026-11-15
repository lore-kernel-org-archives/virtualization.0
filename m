Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794715296;
	b=l0NmgcllpF9IUhg9q9IV/Z3alzI4B/fq6BgWTxYDbNzvtLWQ4hfVfWzIeqyQVsjjh/Jm
	 XaCnoV1BFdFvv5QerTo/ri80oLiQDD8TKHXSnmVCtmxpZTlB5k2EhQk+5CxsgXAEvSsVQ
	 sQVKHIOaA+xmM88qQijkEy59Tc+FcEPIfDL+tKjyWwTpeliUJJWLni8GH8Z/lySWoSB8Z
	 WMAG5yrd3gQ62o6WV49+PmUdRWLAYFLy0ZcTN4uu9RHNEK36JstsAPThWbbcrZm2FHu+y
	 LcnQ8B6IRK5f+3Uw67YWQfbfnYccx41tWwIjGiRS+B+DmC6Nm+k4DetCkvaKaUOcTlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794715296;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mQ41D0RFdPBdqBw0em5Io1Uv2R7+l3MmTeIFj/fg/z0=;
	b=5BojM9CX8KNNqeQ61uA+ubvPDxlXi3NEJMDv5vhTxOssywq98PpbI8TYH6rdiL5LTFqF
	 3gcWH5qj93jhUqOsVCGcOkMwZvFhOSJTKZ1M8iDJ3T9gcoTL0f1iy1wErF3neJX6MrNjN
	 tcVL/sSVXVJZhoIBDmEnFpsoQ0/vvOGr4PMy//5c4A2L8RSEGMrZBYNy/Vcg4IxFVXP3S
	 K/czqsJ08JFY1bgD1k3PN5Nqj2W3YIrtfA5B6W/XUl9J8fYZPvzZ2SEw/ufO2XeNKnG9j
	 2qwZ27+dv9+PvC3ruPQzMRAi1DXh2it52wi6BuUEovi7g56EaQIryGC4X2fmE/DxiOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8rpKOY0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618E606A337;
	Sun, 15 Nov 2026 04:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8rpKOY0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8131F000D0;
	Sun, 15 Nov 2026 04:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794715295;
	bh=mQ41D0RFdPBdqBw0em5Io1Uv2R7+l3MmTeIFj/fg/z0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G8rpKOY0VyAfh5Gym/6Gg5m3nJtGqp7mYo1Gft9W98f6d62Rm/pBfXHzOlcxApYQ3
	 IowyS+wW05dBFnX0YodphJsVgwDqI2f0MClndfJM7LlQcorKXK0YhjcjCW+qPO/sul
	 e2RljcaZ3xpjsKRRU1BTkq5nUpD3tpI2zHnaRKwUL6g9BmzU1BjsAR/XvnQfokau+Y
	 pWg2enyymbYyPDXkrzcOZ8EV9DloKbzDaHBl8DIjNLHnTeGYrmVHK0V+FthhCD4TfA
	 hS+DE8iDS5KoFQhy91GXLAcHvR1txaFSKz7W91lJCvlgV0cBMru4R+x6MS3cHdekx1
	 YHGOOTsdjrGuA==
Subject: Re: [PATCH net-next v6 7/8] selftests/vsock: test the guest vsock
 device network namespace
From: netdev-bot+sashiko@kernel.org
To: bobbyeshleman@meta.com
Cc: sgarzare@redhat.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, stefanha@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shuah@kernel.org, rdunlap@infradead.org, donald.hunter@gmail.com,
 edumazet@kernel.org, georgezhang@vmware.com, acking@vmware.com,
 dtor@vmware.com, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
 bobbyeshleman@gmail.com
Date: Sun, 15 Nov 2026 04:01:33 +0000
Message-ID: <179471529389.2199510.13389069542322602119@kernel.org>
In-Reply-To: <20261113-vsock-guest-ns-v6-7-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-7-3737ce4673c0@meta.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] test_ns_guest_assign_g2h_netns_pins_ns_ok in
  tools/testing/selftests/vsock/vmtest.sh checks less than its…
- [Low] The ynl CLI's output goes straight onto the script's stdout,
  which is also the KTAP stream.
- [Low] vm_ns_stop() (vmtest.sh:657-667) waits for the namespace holder
  to go away with `kill ${nspid}` followed by up to WAIT_PERIOD_MAX (60)…

--

selftests/vsock: test the guest vsock device network namespace

This adds vmtest.sh tests for assigning the guest vsock device to a
network namespace. They cover namespace destruction and the device moving
between namespaces. The tests use the ynl cli.py and unshare, and a
missing dependency skips only the ns_guest_ tests.

> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> index 310dfc2a39ad5..a800b63dfbb11 100755
> --- a/tools/testing/selftests/vsock/vmtest.sh
> +++ b/tools/testing/selftests/vsock/vmtest.sh

[ ... ]

> @@ -528,6 +618,82 @@ vm_wait_for_ssh() {
>  	done
>  }
>  
> +# Create a local mode namespace in the VM and echo the pid holding it open.
> +vm_ns_start() {

[ ... ]

> +	nspid=$(vm_ssh "${ns}" -- "unshare -n sleep infinity" \
> +		'>/dev/null 2>&1 & echo $!')
> +	if [[ -z "${nspid}" ]]; then
> +		return
> +	fi

[ ... ]

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

[Severity: Low]
Can this loop run for the full WAIT_PERIOD_MAX seconds even after the
holder has exited?

vm_ns_start() starts the holder in the background from an ssh shell that
exits right away. The sleep process is then reparented to the guest's
PID 1, and nothing in the script waits on it.

kill -0 succeeds on an unreaped zombie. If the guest init does not reap
adopted orphans, every vm_ns_stop() call would run all 60 iterations,
even though the task has already dropped its netns reference.

vm_ns_stop() runs at least once in each of the seven ns_guest_ tests.
That could add 7+ minutes, against the 1200 second timeout in
tools/testing/selftests/vsock/settings. Whether this happens depends on
whether virtme-ng's init reaps orphans, and I could not confirm that.

Would checking /proc/${nspid}/status for state Z, or comparing
/proc/${nspid}/ns/net, remove that dependency?

[ ... ]

> +vm_ns_assign_g2h() {
> +	local ns=$1
> +	local nspid=$2
> +
> +	vm_ns_exec "${ns}" "${nspid}" "python3 /root/ynl/cli.py --no-schema \
> +		--spec /root/ynl/vsock.yaml --do dev-netns-set"
> +}
> +
> +vm_reset_g2h() {
> +	vm_ns_assign_g2h "init_ns" "" &>/dev/null
> +}

[Severity: Low]
Does the cli.py output end up mixed into the KTAP stream here?

dev-netns-set has no reply attributes. For the empty response, ynl.py
_ops() appends None, and cli.py main() then pprints it:

tools/net/ynl/pyynl/cli.py:main() {
    ...
            reply = ynl.do(args.do, attrs, args.flags)
            output(reply)
    ...
    except NlError as e:
        print(e)
}

As a result, every successful assign prints a bare "None" line. On
failure, cli.py prints the NlError to stdout as well.

Only vm_reset_g2h() redirects this output. Five tests call
"if ! vm_ns_assign_g2h ...", and test_ns_guest_assign_g2h_netns_by_pid_ok()
calls cli.py directly. In all of these, the output passes through ssh
onto the script's stdout, in between the "ok N <test>" lines that
check_result() prints. Assign failures also never reach ${LOG} through
log_host.

Should these calls redirect the output, or capture it and pass it to
log_host?

[ ... ]

> @@ -1421,6 +1603,354 @@ test_ns_delete_both_ok() {

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
Does this test check what its TEST_DESCS entry says?

  "Check the assignment keeps the ns alive when deleted, and that
  reassigning releases it."

Both assertions are connectivity checks run from the guest's init ns.

The first one only shows that the device did not return to init_net
after the holder exited. A dangling or freed netns would also make that
connect fail, and would only be caught if it happened to oops or warn.

The second one only shows that init_net works again after
vm_reset_g2h(). Nothing checks that the reference taken by
get_net_track() in vsock_g2h_net_swap() is later dropped by
put_net_track() in vsock_g2h_net_release(). So the claim in the comment
above vm_reset_g2h() is never verified.

If a later change leaked the netns reference on reassign, would this
test still return KSFT_PASS? Could the description be narrowed, or the
test extended to check that the namespace is actually released?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-vsock-guest-ns-v6-0-3737ce4673c0%40meta.com
