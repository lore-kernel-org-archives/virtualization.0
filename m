Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795845420;
	b=Y5ownaWDrkUORH3zusTVfabfNMYtgfKp3jHWlrqKpiy8WKRcUHSnC46kHsAcW8Bh/Zg1
	 Ax81eQIx6yWOQW9YpfCboJf8tBtIpDAC7b8OssP4hTlNuHc3d35JofY55+CMtl5Yru/gv
	 lXAHsdQnHTcZRN+xdcIM94KiLDmdVIwx7yJMVH59cSq++nlTSpTkaatWbWb28U/G10mBq
	 eI852gVRwx5ub+xCh68SONrJ2C3EdSXFaFzjN5CoauKHljXQSONEl779I6EHUu7Zgi5nJ
	 BagTN/lCTeeEek9e5xV0gOWbqP4m0KN8GL/hqAEBp8eCCSeQywSmnDxS+/T0p/1tL3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795845420;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lUPgpdHPlR3J4Yi2XfabCNC4Z4k1XlpiTY3GXQ6hiBU=;
	b=n041E5ps7GOYmat7OfIar+lagT5QNEunF6BTfOssugp1nSisOkXOQ2HfJTYvQwLaqXkm
	 R7tihwmfWWzgPydnVScWRFpTFrE91j3w1yw1Rlx6YvHNUL5IC4a3u9gX6TJby6iw15yQR
	 pDKUIXYFVp500dwihK+VpQ0WMIXymf9njA8vi28QPEWByqM0QH4dQf9uYSgWdKnZLnwgl
	 QBiBfq10eWe4R8gXfIvSxfBsaNGzjKFBQcGwQpvtEXLLUMFTItRnAGgNzn0NwO3q+5oQd
	 exgGIiZHwBn25MmowOY8qbjPQxkSnRIITV9V3kfuZHuHEqCK5mM3qjM7h/XF6oO8scA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oBB5qlYh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94174606A31C;
	Sat, 28 Nov 2026 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oBB5qlYh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828481F00893;
	Sat, 28 Nov 2026 05:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795845420;
	bh=lUPgpdHPlR3J4Yi2XfabCNC4Z4k1XlpiTY3GXQ6hiBU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oBB5qlYh0L3fd5Q85CTMpQ0LMV+PHwH/1flaAy+ZhAhM7QNlc/rb2oT11rKJULNme
	 Z87465m/5y6E4t95dVdhoq1EoBvgN4VV+quQo3mUK4FByKeg/eOeJWbiA0cCCyuwAO
	 PK0TrTXMo8h3ek1i9ISjGFpLHDKGYznVS2vHo6l1hefog7pl4CZt3cav1AIWlw1mJd
	 MRHXnQ/8gUpilrXSqnfqBOcSdOLSX68TcdAnZfk7ndEurcvzgI6NASy0cagCgT9EA2
	 fnpjEU3ft0qBcdqYDp7cabY2muboGEXoJZzQsvsuHrIMBMcHuAFTjjuC02+6NBeofc
	 Z3c55fWftO37A==
Subject:
 Re: [PATCH net 2/2] vsock/test: add stream MSG_WAITALL receive timeout test
From: netdev-bot+sashiko@kernel.org
To: weir@nebusec.ai
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 sgarzare@redhat.com, bobbyeshleman@meta.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 horms@kernel.org, arseny.krasnov@kaspersky.com, vega@nebusec.ai,
 caoruide123@gmail.com
Date: Sat, 28 Nov 2026 05:56:59 +0000
Message-ID: <179584541902.3135.8648647638685703469@kernel.org>
In-Reply-To: <503c1d5538f5b41f8eda756f5ea4491f0bd44518.1795591531.git.caoruide123@gmail.com>
References: <503c1d5538f5b41f8eda756f5ea4491f0bd44518.1795591531.git.caoruide123@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new entry "SOCK_STREAM MSG_WAITALL timeout" is inserted in
  the middle of test_cases[] in tools/testing/vsock/vsock_test.c (lines…
- [Low] test_stream_timeout_waitall_client()
  (tools/testing/vsock/vsock_test.c:717-738) only checks that the…
- [Low] In test_stream_timeout_waitall_client()
  (tools/testing/vsock/vsock_test.c:709-717), read_ns = current_nsec() -…
- [Low] In test_stream_timeout_waitall_client()
  (tools/testing/vsock/vsock_test.c:709-731), errno from recv() is not…

--

vsock/test: add stream MSG_WAITALL receive timeout test

This adds a SOCK_STREAM test to vsock_test. The client calls
recv(MSG_WAITALL) with a 1s SO_RCVTIMEO while the peer sends one byte
every 0.8s, and the test checks that the timeout is cumulative. The
client expects recv() to return in under 2s, either with EAGAIN or with a
partial read.

> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 10b9074fb87f7..868792f7729cf 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -662,6 +662,113 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)

[ ... ]

> +static void test_stream_timeout_waitall_client(const struct test_opts *opts)
> +{
> +	char buf[STREAM_RCVTIMEO_DRIP_BYTES];
> +	time_t read_enter_ns;
> +	struct timeval tv;
> +	time_t read_ns;

[ ... ]

> +	read_enter_ns = current_nsec();
> +	n = recv(fd, buf, sizeof(buf), MSG_WAITALL);
> +	read_ns = current_nsec() - read_enter_ns;
> +
> +	/* Unfixed kernels restart the full SO_RCVTIMEO after each partial
> +	 * read, so this recv() returns 6 bytes after ~4.8s. A cumulative
> +	 * 1s timeout returns much sooner; use 2s as the cap so the two
> +	 * outcomes cannot be confused.
> +	 */
> +	if (read_ns >= 2ULL * NSEC_PER_SEC * RCVTIMEO_TIMEOUT_SEC) {

[Severity: Low]
The commit message says:

  With the fix, the call must return around the original timeout, either
  with EAGAIN or with a partial read shorter than the MSG_WAITALL request.

This is the only timing check, and it only sets an upper bound. Would a
kernel that ignores MSG_WAITALL and returns 1 byte at about 0.8s also
pass?

The same question applies to a kernel that sets the remaining timeout to
0 after the first partial dequeue, and to one that returns EAGAIN at once
without waiting. In both cases this is the bookkeeping in question:

net/vmw_vsock/af_vsock.c:vsock_connectible_wait_data() {
    ...
	*timeout = schedule_timeout(*timeout);
    ...
}

With the companion fix ("vsock: preserve receive timeout across partial
reads"), recv() should return 1 byte after about 1s.

Should the test also check for a lower bound near RCVTIMEO_TIMEOUT_SEC,
and that recv() returned the single byte?

[Severity: Low]
read_ns is a signed time_t. The 2ULL makes the right-hand side unsigned
long long, so read_ns is converted to unsigned for this comparison.

current_nsec() reads the wall clock:

	if (clock_gettime(CLOCK_REALTIME, &ts)) {

Suppose CLOCK_REALTIME steps backwards while recv() is blocked, for
example on an NTP step or a guest clock resync after a VM pause. read_ns
would then be negative and compare as roughly 1.8e19.

Can the test then print "recv(MSG_WAITALL) exceeded SO_RCVTIMEO" and fail
even though recv() returned on time?

test_seqpacket_timeout_client() compares against an int constant, so a
backwards step there makes the check pass instead of fail.

Would a signed comparison, or measuring with CLOCK_MONOTONIC, avoid this?

> +		fprintf(stderr,
> +			"recv(MSG_WAITALL) exceeded SO_RCVTIMEO, %lu ns\n",
> +			read_ns);
> +		failed = 1;
> +	}
> +
> +	if (n == sizeof(buf)) {
> +		fprintf(stderr,
> +			"recv(MSG_WAITALL) completed under drip-feed\n");
> +		failed = 1;
> +	}
> +
> +	if (n < 0 && errno != EAGAIN) {
> +		perror("EAGAIN expected");

[Severity: Low]
errno is not saved right after recv(). It is checked only after
current_nsec() runs and, if the elapsed-time check fired, after
fprintf(). Both calls are allowed to change errno even when they succeed.

Could this check and perror() then report an errno that did not come from
recv()?

This only affects the diagnostic messages, not the pass/fail result.
test_seqpacket_timeout_client() checks errno right after read(). Would it
be cleaner to save errno in a local variable right after recv() here?

> +		failed = 1;
> +	}

[ ... ]

> @@ -2739,6 +2846,11 @@ static struct test_case test_cases[] = {
>  		.run_client = test_seqpacket_timeout_client,
>  		.run_server = test_seqpacket_timeout_server,
>  	},
> +	{
> +		.name = "SOCK_STREAM MSG_WAITALL timeout",
> +		.run_client = test_stream_timeout_waitall_client,
> +		.run_server = test_stream_timeout_waitall_server,
> +	},

[Severity: Medium]
The new entry goes into the middle of test_cases[], right after
"SOCK_SEQPACKET timeout", so every later test's ID goes up by one.
vsock_test selects tests only by array index: parse_test_id() feeds
skip_test() and pick_test().

test_ns_same_local_host_connect_to_local_vm_ok() in
tools/testing/selftests/vsock/vmtest.sh hard-codes one of these IDs:

	# Skip test 29 (transport release use-after-free): This test attempts
	# binding both G2H and H2G CIDs. Because virtio-vsock (G2H) doesn't
	# support local namespaces the test will fail when
	# transport_g2h->stream_allow() returns false. This edge case only
	# happens for vsock_test in client mode on the host in a local
	# namespace. This is a false positive.
	host_vsock_test "${ns}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}" --skip=29

After this patch, index 29 is "SOCK_STREAM MSG_ZEROCOPY leak completion
skb". "SOCK_STREAM transport release use-after-free" is now index 30.

Does this make that vmtest.sh case skip the zerocopy completion skb leak
test? It would also run the use-after-free test, which gives the false
failure the skip was added to avoid.

External scripts that pass --skip or --pick IDs would be off by one for
every test after index 8. So would host and guest binaries built from
different trees.

Could the new test be appended at the end of test_cases[] instead, or
could vmtest.sh be updated in the same patch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795587333.git.caoruide123%40gmail.com
