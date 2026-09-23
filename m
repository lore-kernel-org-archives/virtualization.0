Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6343569F1F;
	Wed, 23 Sep 2026 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191271; cv=none; b=Ti3f9hU6vR0mLIP56rworNxhnbVr9WWiRd985R77ZTOebTCMhO/3Gj6QA2DewxOK++7hPkmyLivmH+Utf2zZgUmT7eAiqmbvI4fkNyx2vnb3tM/503HB3to5MXvJVzL0eVbBLdJk38fNpPCvrQqCYDFI7Q9yEKIy8hydlrj9sGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191271; c=relaxed/simple;
	bh=JyB88lU8D8plLkT8atp1POiJmxbZ97970p8UnhC5dIY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e3K+pUhI3if/QL7Kfsrh9cO+PcJ9NEdwulD7tpJZ/nvISA55TigSR5d1rKM5m6EFeuCdlT6Gz8X8I3XmrVhVq+XxgUct+bD79WY39vzkfdMQZ17ZYlUmALcaA1mUgrbvOhJNp3glFS62d3KQu1n83b2tZM9VAoIcViFxnkyvjxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XODkItKQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XODkItKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFA21F00893;
	Wed, 23 Sep 2026 19:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790191269;
	bh=MvAguG7XJjS5iXlWWMhU76RJL95W7uHcHbawUFlVNyE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XODkItKQaAOYarTSRjvSHqTRRZDng4evF9SQnTCxxfKxvXVwlGXwlNvA2xO+PZvMA
	 9rg234UN9nnIZV6CT+cpxITrLHKJApSUMzE1pdNzCMnHr7jx8JZcJ90fozg9LKEnAV
	 O1bppkT07sCdBQ/GCEdQa4GcGMRkoiHrwVaCO1uW2x8AtCPa/yGMr/hCzeXyVKIvW9
	 ULlSzSErYp7xykehvOJzQEtDjc79zbWmVioe6qxQ7S2SQ1t7F15olxROeaqEVSstIq
	 rsYOu9VbkP6/uX95VJjQFiFZwG7ouOrBrzObnBzQiGsDsKHspgORIsz2MqWWxxmx7N
	 l3D/qPPmKcPIw==
Subject: Re: [PATCH net-next v2 6/6] selftests/vsock: test the netns assign
 privilege checks
From: netdev-bot+sashiko@kernel.org
To: bobbyeshleman@gmail.com
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, stefanha@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shuah@kernel.org, rdunlap@infradead.org, donald.hunter@gmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
 sdf.kernel@gmail.com, bobbyeshleman@meta.com
Date: Wed, 23 Sep 2026 19:21:07 +0000
Message-ID: <179019126776.2160803.16648507383433583043@kernel.org>
In-Reply-To: <20260921-vsock-guest-ns-v2-6-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-6-693bd78fde9e@meta.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Both new selftests
  (`test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails`,…
- [Low] The two new shared-VM tests omit the `vm_reset_g2h()` cleanup
  that every other ns_guest_assign_g2h_netns_* test in USE_SHARED_VM…

--

selftests/vsock: test the netns assign privilege checks

Adds two vmtest.sh cases that attempt VSOCK_CMD_DEV_NETNS_SET without
CAP_NET_ADMIN and from an unprivileged user namespace, and enables
CONFIG_USER_NS in the vsock selftest config.

> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> index e94cc2fd90ccd..4f42bcdac3f6c 100755
> --- a/tools/testing/selftests/vsock/vmtest.sh
> +++ b/tools/testing/selftests/vsock/vmtest.sh

[ ... ]

> @@ -187,6 +195,8 @@ readonly TEST_DESCS=(
>  	ns_guest_assign_g2h_netns_host_connect_ok
>  	ns_guest_assign_g2h_netns_reset_on_ns_delete_ok
>  	ns_guest_assign_g2h_netns_old_conn_send_fails
> +	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
> +	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
>  )
>  readonly NS_MODES=("local" "global")

[Severity: Low]
Both new tests are added to USE_SHARED_VM but neither calls
vm_reset_g2h() on any exit path, unlike every other
ns_guest_assign_g2h_netns_* test in that list.

Should these follow the sibling pattern?  If the privilege check under
test is broken, the assign succeeds and the guest's single g2h device is
left owned by the transient namespace created by unshare, while the
harness moves on to the next test in the same VM.

The kernel does restore this by itself once that namespace is reaped:

net/vmw_vsock/af_vsock.c:vsock_g2h_net_reset() {
	if (likely(rcu_access_pointer(vsock_g2h_net) != net))
		return;

	mutex_lock(&vsock_register_mutex);
	if (rcu_access_pointer(vsock_g2h_net) == net)
		rcu_assign_pointer(vsock_g2h_net, &init_net);
	...
}

registered as .pre_exit in vsock_pernet_ops, and the next test's
vm_ns_assign_g2h() overwrites the pointer anyway.  The residual window is
the asynchronous teardown that ..._reset_on_ns_delete_ok already documents
("the namespace itself is dismantled from a workqueue, so the device does
not come back the same instant").  Since the new tests are appended last
in TEST_NAMES and USE_SHARED_VM, a default run is unaffected; this only
shows up with selective or reordered invocation.

[ ... ]

> @@ -1832,6 +1842,48 @@ test_ns_guest_assign_g2h_netns_reset_on_ns_delete_ok() {
>  	return "${KSFT_PASS}"
>  }
>  
> +test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails() {
> +	local cmd="unshare -n setpriv --bounding-set=-net_admin"
> +	local rc
> +
> +	vm_ssh "init_ns" -- "${cmd}" python3 /root/ynl/cli.py --no-schema \
> +		--spec /root/ynl/vsock.yaml --do dev-netns-set &>/dev/null
> +	rc=$?
> +
> +	if [[ "${rc}" -eq 0 ]]; then
> +		log_host "assign unexpectedly succeeded without CAP_NET_ADMIN"
> +		return "${KSFT_FAIL}"
> +	fi
> +
> +	return "${KSFT_PASS}"
> +}

[Severity: Medium]
Can this test pass without the capability check ever being reached?  The
only assertion is rc -eq 0 => FAIL, output is discarded with &>/dev/null,
and there is no positive control, so any nonzero status reads as
KSFT_PASS.

A few concrete sources of a nonzero status that are not -EPERM:

net/vmw_vsock/af_vsock.c:vsock_nl_dev_netns_set_doit() {
	int err = vsock_g2h_net_assign(genl_info_net(info));

	if (err == -ENODEV)
		NL_SET_ERR_MSG(info->extack,
			       "no guest-to-host transport is loaded");
	else if (err == -EOPNOTSUPP)
	...
}

and cli.py collapses all of those to the same status as -EPERM:

tools/net/ynl/pyynl/cli.py:main() {
    except NlError as e:
        print(e)
        sys.exit(1)
}

vm_ssh() also returns ssh's own status, so a transport failure (255) or a
remote shell failure (127, e.g. an installed util-linux that does not
accept setpriv --bounding-set=-net_admin) is indistinguishable from the
expected refusal.  A python-side failure such as a missing
/root/ynl/vsock.yaml exits 1 too.

Would it be worth asserting the privileged case succeeds first?  The file
already has the helper the sibling tests use as a precondition:

vm_ns_assign_g2h() {
	local ns=$1
	local nspid=$2

	vm_ns_exec "${ns}" "${nspid}" "python3 /root/ynl/cli.py --no-schema \
		--spec /root/ynl/vsock.yaml --do dev-netns-set"
}

On the changelog note "ynl's cli.py does not report the errno": is that
accurate?  NlError.__str__() in tools/net/ynl/pyynl/lib/ynl.py does:

        msg += os.strerror(self.error)

so the error string is printed and the test could match "Operation not
permitted" instead of sending everything to /dev/null.

> +
> +test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() {
> +	local unpriv_uid=65534
> +	local unpriv
> +	local rc
> +
> +	unpriv="setpriv --reuid=${unpriv_uid} --regid=${unpriv_uid}"
> +	unpriv="${unpriv} --clear-groups"
> +
> +	if ! vm_ssh "init_ns" -- "${unpriv} unshare -U true"; then
> +		log_host "unprivileged user namespaces unavailable, skipping"
> +		return "${KSFT_SKIP}"
> +	fi
> +
> +	vm_ssh "init_ns" -- "${unpriv} unshare -Urn" \
> +		python3 /root/ynl/cli.py --no-schema \
> +		--spec /root/ynl/vsock.yaml --do dev-netns-set &>/dev/null
> +	rc=$?
> +
> +	if [[ "${rc}" -eq 0 ]]; then
> +		log_host "assign unexpectedly succeeded for unprivileged user"
> +		return "${KSFT_FAIL}"
> +	fi
> +
> +	return "${KSFT_PASS}"
> +}

[Severity: Medium]
Same rc != 0 => KSFT_PASS inference here, plus the availability probe is
not the command being measured:

	probe:    ${unpriv} unshare -U true
	measured: ${unpriv} unshare -Urn python3 /root/ynl/cli.py ...

If the extra -r/-n setup or the python startup under uid 65534 fails, the
result is KSFT_PASS rather than KSFT_SKIP or KSFT_FAIL, and the child user
namespace never actually holds CAP_NET_ADMIN, which is the condition the
commit message says is being tested:

    the other confirms that CAP_NET_ADMIN in an unprivileged user ns
    alone is insufficient.

Would checking the reported error string, or asserting the privileged
assign works in the same test, make these two cases fail if
GENL_ADMIN_PERM is ever dropped from VSOCK_CMD_DEV_NETNS_SET?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-vsock-guest-ns-v2-0-693bd78fde9e%40meta.com
