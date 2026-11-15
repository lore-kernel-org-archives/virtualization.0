Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794715298;
	b=shw6l2JzdnaVoeGZuKgUklvWut0NpF1/oETr6tQ4eIo+TY5S6QkuZts/sJCl3fMi1X/F
	 Bnoc5tfvibsZrZ+AbuqLDWmykDY8hmNatk8yy4Yxs2PGYTZ4lmDt6vDtiVKAEvfkHftDU
	 Rd3Kl3m6IVMzkyaw1BZlg6B43FG47dANFlpX1msvyOJK02lfiy2DZbaHMIyobO7Y65RdI
	 fEYDT5DUXvldlXhy26Ih14cjK1HpNVMfmgyCj6cboi9g1zVRFQF9M6XOPTTmTeAVrBUkq
	 Al3mqqqO5mIw9u/ne4k7nh5I2ct+Rq4OUXmpLtZ0KxLL31cmkloUZo4dGMpWLCo7X3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794715298;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ekNkURalsL5MHlKPQd8PSLVr4r63qFXeHmS9Q5qJzWc=;
	b=wi6JTxj1aEjxMO6g79VNfLwv7ZA6BCYsgXaoCQH3nIAWOqUNg7vDxZ+8IzoIf3hkaN7s
	 dHPvcpx7pUWTk/V4mNuleRIZR3u/RXwhH2MKEJVoxEgpAzXmPMmHePR6IPfVG8nmZLGbT
	 HDqkcbW0ewRF2iSiJsmu5V8muLu8K+updwVLoXUYyKVvZxna0XlvqD1qPEgj5Busb+cW9
	 UymuLsn7jzrc0PsUIzGUD+LKRkrdyywwXP72l/Tzw4yEycrteUkFymgMNOPJbl3L2PZ+S
	 V5CmmY2sCS4nKkjPkRyDZWerYXKQnGg1cKzq+ARBLblHQrnUqzJbjEmcFc09bhzQe8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESfALudJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8060A263A;
	Sun, 15 Nov 2026 04:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESfALudJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A65B1F0089E;
	Sun, 15 Nov 2026 04:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794715297;
	bh=ekNkURalsL5MHlKPQd8PSLVr4r63qFXeHmS9Q5qJzWc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ESfALudJy8ftNw12uUwTT+1vSTxumbbmBxmqHmGUBKsCIHNWDJ0bugt4k4xK1yC+7
	 R0ABn1p6C+oJTmT9MvC2sngyDKZYitJyqsCt6xIcp80uFT99BsBs4/8PFdjwzqEQUE
	 +pG1Y878LTmdQGS1L8A3RgzwIMLUN6jqoEtfoO0UUPELYPMUtL/QQpQ0yTQevewvJf
	 YXmdLsC2ZtiN32GVuIuKu1V9hBThAKHXMNnXWbGAGKcfSYL/Vt/SmlSXt/oLD9P1wg
	 jLNekQI7MRo7YO24e5Eq80oE9BGk0bld/g2Mv4i0W7FfC/9+P+tTCs0dpEfNtYq0Hm
	 aQSNmKv1TxjYg==
Subject: Re: [PATCH net-next v6 8/8] selftests/vsock: test the netns assign
 privilege checks
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
Date: Sun, 15 Nov 2026 04:01:35 +0000
Message-ID: <179471529588.2199510.6165788075802667955@kernel.org>
In-Reply-To: <20261113-vsock-guest-ns-v6-8-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-8-3737ce4673c0@meta.com>
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

- [Low] In tools/testing/selftests/vsock/vmtest.sh,
  check_assign_g2h_eperm() returns KSFT_FAIL from the "assign…
- [Low] In tools/testing/selftests/vsock/vmtest.sh,
  check_assign_g2h_eperm() passes whenever the ssh command fails and the…

--

selftests/vsock: test the netns assign privilege checks

This adds two vsock selftests that check VSOCK_CMD_DEV_NETNS_SET is
refused without CAP_NET_ADMIN in the init user namespace. One test drops
net_admin from the bounding set, and the other runs as an unprivileged
user inside a new user ns. The patch also adds CONFIG_USER_NS to the
config and makes setpriv a dependency for these two tests.

> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> index a800b63dfbb11..9614532a56285 100755
> --- a/tools/testing/selftests/vsock/vmtest.sh
> +++ b/tools/testing/selftests/vsock/vmtest.sh

[ ... ]

> @@ -1951,6 +1970,44 @@ test_ns_guest_assign_g2h_netns_pins_ns_ok() {
>  	return "${KSFT_PASS}"
>  }
>  
> +check_assign_g2h_eperm() {
> +	local wrapper=$1
> +	local out
> +
> +	if out=$(vm_ssh "init_ns" -- "${wrapper}" python3 /root/ynl/cli.py \
> +		--no-schema --spec /root/ynl/vsock.yaml \
> +		--do dev-netns-set 2>&1); then
> +		log_host "assign unexpectedly succeeded under '${wrapper}'"
> +		return "${KSFT_FAIL}"
> +	fi

[Severity: Low]
If the GENL_ADMIN_PERM check ever regresses and dev-netns-set succeeds
here, where does the guest's G2H device end up?

The request carries no netns fd or pid attribute. In that case
vsock_nl_dev_netns_set_doit() assigns the device to the netns the
request came from, which here is the throwaway netns created by
unshare -n or unshare -Urn.

test_ns_guest_assign_g2h_netns_pins_ns_ok() notes that this kind of
assignment keeps the namespace pinned after its process exits:

	# Assigning it back is what releases the deleted namespace.
	vm_reset_g2h

Both new tests are in USE_SHARED_VM. That means run_shared_vm_tests()
keeps running tests on the same VM while the device is still stuck in
a dead netns. With the default order only the second new test is hit.
With a user-chosen order, more of the later shared-VM tests could fail
for unrelated reasons.

The other assign tests in this file call vm_reset_g2h on their failure
paths. Should this branch also call it before returning KSFT_FAIL?

> +
> +	if [[ "${out}" != *"Operation not permitted"* ]]; then
> +		log_host "no EPERM under '${wrapper}': [${out}]"
> +		return "${KSFT_FAIL}"
> +	fi
> +
> +	return "${KSFT_PASS}"
> +}

[Severity: Low]
Could this match an EPERM that never came from the netlink request?

The substring check runs against the combined stdout/stderr of the
whole wrapper chain. Suppose unshare -n or setpriv
--bounding-set=-net_admin fails with EPERM in the guest. The output
would then contain something like:

    unshare: unshare failed: Operation not permitted

and check_assign_g2h_eperm() would return KSFT_PASS even though cli.py
never sent VSOCK_CMD_DEV_NETNS_SET.

test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() probes its
wrapper with "unshare -Urn true" first and skips if that fails.
test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails() below has no
such probe.

cli.py prints kernel errors through NlError.__str__() in
tools/net/ynl/pyynl/lib/ynl.py, which starts with the "Netlink error: "
prefix followed by the strerror. Would it be tighter to match on that
prefix, or to probe the wrapper in the no_cap test as well?

> +
> +test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails() {
> +	check_assign_g2h_eperm "unshare -n setpriv --bounding-set=-net_admin"
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-vsock-guest-ns-v6-0-3737ce4673c0%40meta.com
