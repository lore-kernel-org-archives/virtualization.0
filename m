Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A837542EEC;
	Tue, 13 Oct 2026 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931930; cv=none; b=cs6NUaiedzijtGwFFLt/X10EOi9uOhuDJEcS2294AZo1yUXIKtHPfTs0K2TOcGiuFBDsOeVZkxHVJEBuExPe5mIxyxcq71bfp3ql2/cc/Tw9s4wlAwiy60YFKtxtyNUaR1492QOHuKTOaI7uZlgq42MQKVF1zAxl8tRLsT/QHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931930; c=relaxed/simple;
	bh=28KNQlMmmO/iFDYjZMBSotS+bLn4f7V4VCoGOUUF8y4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uyfw3iv5L++7pKd98njoOXbUbjJ3hN6DuPQ1fdeS9z6ivs+PgX2RgBC184lPlPqrmmVXDkj/4c4Sdk8UMet92mpUyxu5MhTU3YIaRXt9kkjh2srbSOIqWnGizpoGs/cz3kE+asD6dcE3spHFZ6bZPPOm1RrvDtodXuavkCVUjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1Ualpo+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1Ualpo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0461B1F008A0;
	Tue, 13 Oct 2026 22:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931923;
	bh=kdQWcP2STwJQyxJrJaL+639b6p+ci5eTKj3oS8PV6YY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c1Ualpo+A+pMoSP7Oy/DjCyh+Q9g6y8+ovp35XVqJDeZqDAv8QDZ10Y1Nxsk5GeBw
	 x+zhJ8/+aK59pOuYUs0k5rRSuho6wLQZDU9+uD3WReK7gsSBx4eCrMBBw5+TGsmkvl
	 zPNNPPvFNfNeSCkmCk6NRlif9yS/MG4Do4ZaKal+Cr5h3pWmT/W3C+xW/+EAzQbhMd
	 t562q7pP/ohoy+8aq098D8isNhaPHZtJCTQI/ZEFqakb+ItDd7KYf9Hi1gdJDBj021
	 MtScxDTTFQeVknmO4vqjjhoatovzBZhh7NoaZnzq6VfPUMt6l0aXfT9X7HHfYIS4vA
	 EPYcdTCEi7/hQ==
Subject: Re: [PATCH net-next v3 7/7] selftests/vsock: test the netns assign
 privilege checks
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
Date: Tue, 13 Oct 2026 22:52:01 +0000
Message-ID: <179193192150.434549.17424079500765583387@kernel.org>
In-Reply-To: <20261012-vsock-guest-ns-v3-7-b32447c66b23@meta.com>
References: <20261012-vsock-guest-ns-v3-7-b32447c66b23@meta.com>
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

- [Medium] Neither new privilege test checks why the command failed.
- [Low] Both new tests are in USE_SHARED_VM, but they skip the shared-VM
  cleanup that the other ns_guest_assign_g2h_netns_* tests do.

--

selftests/vsock: test the netns assign privilege checks

This patch adds two shared-VM tests to vmtest.sh. One checks that
VSOCK_CMD_DEV_NETNS_SET is refused without CAP_NET_ADMIN. The other checks
that it is refused when CAP_NET_ADMIN is held only in an unprivileged user
namespace. The patch also adds setpriv to the ns_guest test dependencies
and CONFIG_USER_NS to the selftest config.

> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> index 7693d5e0a1d07..d5d7b0660c5da 100755
> --- a/tools/testing/selftests/vsock/vmtest.sh
> +++ b/tools/testing/selftests/vsock/vmtest.sh

[ ... ]

> @@ -1909,6 +1919,48 @@ test_ns_guest_assign_g2h_netns_pins_ns_ok() {
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

[Severity: Medium]
Does this check show that the refusal came from the CAP_NET_ADMIN check?

vm_ssh returns the exit status of the whole remote command chain, so any
non-zero status counts as a pass here. That includes:

  - ssh transport failure (255)
  - unshare -n failing
  - setpriv rejecting --bounding-set=-net_admin
  - python or ynl import errors, or a genl family lookup failure
  - non-permission errors from vsock_g2h_net_assign(), such as -ENODEV,
    -EOPNOTSUPP, -EADDRINUSE or -EMSGSIZE

test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() below uses the same
pattern. Its skip probe also only runs:

    vm_ssh "init_ns" -- "${unpriv} unshare -U true"

If the -r uid/gid mapping or the -n netns creation fails inside
"unshare -Urn", that test reports PASS instead of SKIP.

The changelog says:

  "Assert only that the command fails, not EPERM: ynl's cli.py does not
  report the errno"

Is that still accurate? In tools/net/ynl/pyynl/cli.py, main() does:

    except NlError as e:
        print(e)
        sys.exit(1)

NlError.__str__() in tools/net/ynl/pyynl/lib/ynl.py appends
os.strerror(self.error), and NlError.error holds the errno itself.

So when the GENL_ADMIN_PERM check on VSOCK_CMD_DEV_NETNS_SET returns EPERM,
cli.py prints "Netlink error: Operation not permitted" to stdout. Here,
&>/dev/null throws that output away.

The commit message says:

  "one confirms that CAP_NET_ADMIN is required even by a privileged user
  and the other confirms that CAP_NET_ADMIN in an unprivileged user ns
  alone is insufficient."

As written, both tests only confirm that the command did not succeed. If
the permission check were removed or relaxed while some unrelated failure
also happened, both tests would still pass.

Could the tests capture the cli.py output and check for "Operation not
permitted"?

> +		log_host "assign unexpectedly succeeded without CAP_NET_ADMIN"
> +		return "${KSFT_FAIL}"
> +	fi
> +
> +	return "${KSFT_PASS}"
> +}
> +
> +test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() {

[ ... ]

> +	vm_ssh "init_ns" -- "${unpriv} unshare -Urn" \
> +		python3 /root/ynl/cli.py --no-schema \
> +		--spec /root/ynl/vsock.yaml --do dev-netns-set &>/dev/null
> +	rc=$?
> +
> +	if [[ "${rc}" -eq 0 ]]; then
> +		log_host "assign unexpectedly succeeded for unprivileged user"
> +		return "${KSFT_FAIL}"
> +	fi

[Severity: Low]
Should this path, and the matching one in
test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails(), call
vm_reset_g2h() before returning?

Both new tests are in USE_SHARED_VM. The other ns_guest_assign_g2h_netns_*
tests, such as test_ns_guest_assign_g2h_netns_pins_ns_ok(), call
vm_reset_g2h() on their failure paths once the device may have moved.

If the assign unexpectedly succeeds, dev-netns-set moves the guest's g2h
vsock device into the throwaway netns created by unshare -n or
unshare -Urn.

The kernel-doc for vsock_g2h_net_assign() says the move "keeps @net alive
until the device leaves again". So after the command exits, the device
stays in that orphaned netns.

run_shared_vm_tests() runs tests in the order given on the command line.
For example:

    vmtest.sh ns_guest_assign_g2h_netns_no_cap_net_admin_fails \
        vm_server_host_client

Here the later shared-VM test would run with the guest's init netns cut
off from vsock, and its failure would be reported against the wrong test.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-vsock-guest-ns-v3-0-b32447c66b23%40meta.com
