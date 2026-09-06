Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D767A36197A;
	Sun,  6 Sep 2026 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714249; cv=none; b=XbwtuJqtx/QVEncYny7yMsxuxPHFe3jCqVSOtTehkhM2iCsr9KStwDOB/Mc2li1rK8+sPPgYzIhSHqupQvm6mKtEvIW8VDzuqN+x3tbBzc+04oWV33wApzZ86C30ZrfWnEEEyWw+HXGmQDuohb1XUjekSaPBe5oK1t+pAhpuS9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714249; c=relaxed/simple;
	bh=uGPegOZ4x6exHDrJaJIMYvVtnTBGa3syLmKxGKgaxXI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VjDhoAjaPp5iFskVlEB8Sbqx9eSx57/1EAtOc+m29QxyuHTrHHl5GRh+vFp8Y6KcJNCkBvYDHEOEJBO/KpymtKIf9MSyiDz9M8h7h+iaN2E34oo7EK44qEF7whd/MI8rwxbgYE6t6tCpcsMW8/XjU6muRnP7+ZDcnhang8c3UCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvNOGGY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvNOGGY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737AA1F00A3A;
	Sun,  6 Sep 2026 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788714247;
	bh=MhZAd/uwsSOpdpQgbrG1EQklPb0e0DHCvfNgsLIvO44=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LvNOGGY3DOdN/gj49elHglokg730mBEOFGrXeKRC5SnOZ/KjLEAQzLYZpm5H07Tsy
	 zlcqbTyyRJ3e1JYYuohLKBPstEiUZVgU2npXniFu8oaeoXaE+GXKZIc2Vp4yTICKdV
	 4YMF6uKiwwPr3ovJXWfi7qPVCB48M5cji+Ijn3K3JamnkNfSRnduB9/HA/3QfR+JoP
	 NDPLaWbrYpBjHShrBOx9Gr/6dmFo6aLPSZV7zBvesXWCya42birl3zQrnvzoCy8E0W
	 ZzT81PjlgZcnU7HuPVqpjMc3dQZf8O9LYUN5oArqvOAeWPupL6zN9qmHwrZScT83mn
	 1h165F9GwO1xA==
Subject: Re: [PATCH net-next 6/6] selftests/vsock: test the assign ioctl
 privilege checks
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
Date: Sun, 06 Sep 2026 17:04:06 +0000
Message-ID: <178871424602.219967.12071178745366323858@kernel.org>
In-Reply-To: <20260902-vsock-guest-ns-v1-6-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-6-9995383e9a8b@meta.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails()
  (tools/testing/selftests/vsock/vmtest.sh:1835-1863) runs the helper as…
- [Medium] Both new tests equate a remote command exit status of 1 with
  'the kernel returned -EPERM from IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS'.
- [Low] Both new shared-VM tests (vmtest.sh:1820-1833 and 1835-1863) are
  added to USE_SHARED_VM but omit the `vm_reset_g2h` teardown that every…

--

selftests/vsock: test the assign ioctl privilege checks

This adds two vmtest.sh cases around IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS on
/dev/vsock: one drops CAP_NET_ADMIN via setpriv, the other runs the helper
as an unprivileged uid inside a new user plus net namespace.  Both expect
the helper to exit with the ioctl's errno, and CONFIG_USER_NS is added to
the config.

No Link: tags are present in the commit header.

> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> index 53591fa07f1a..efb94d17d997 100755
> --- a/tools/testing/selftests/vsock/vmtest.sh
> +++ b/tools/testing/selftests/vsock/vmtest.sh
> @@ -28,6 +28,7 @@ readonly WAIT_PERIOD=3
>  readonly WAIT_PERIOD_MAX=60
>  readonly WAIT_QEMU=5
>  readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
> +readonly EPERM=1
>  declare -A PIDFILES

[ ... ]

> @@ -333,7 +344,8 @@ check_args() {
>  }
>  
>  check_deps() {
> -	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter unshare; do
> +	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter unshare \
> +		setpriv; do
>  		if [[ ! -x $(command -v "${dep}") ]]; then
>  			echo -e "skip:    dependency ${dep} not found!\n"
>  			exit "${KSFT_SKIP}"

[ ... ]

> @@ -1805,6 +1817,51 @@ test_ns_guest_assign_g2h_netns_reset_on_ns_delete_ok() {
>  	return "${KSFT_PASS}"
>  }
>  
> +test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails() {
> +	local cmd="unshare -n setpriv --bounding-set=-net_admin"
> +	local rc
> +
> +	vm_ssh "init_ns" -- "${cmd}" ./vsock_assign_g2h_netns &>/dev/null
> +	rc=$?
> +
> +	if [[ "${rc}" -ne "${EPERM}" ]]; then
> +		log_host "expected EPERM (${EPERM}) without CAP_NET_ADMIN, got ${rc}"
> +		return "${KSFT_FAIL}"
> +	fi
> +
> +	return "${KSFT_PASS}"
> +}

[Severity: Medium]
Can this test pass without ever issuing the ioctl?

The helper turns errno into its own exit status:

tools/testing/selftests/vsock/vsock_assign_g2h_netns.c:main() {
	ret = ioctl(fd, IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS);
	if (ret < 0) {
		ret = errno;
	...
	return ret;
}

so "the ioctl returned -EPERM" is encoded as exit status 1, which is also
the generic EXIT_FAILURE of the two wrappers that are prepended here.  If
util-linux unshare cannot create the network namespace, or setpriv was
built without libcap-ng and cannot handle --bounding-set=-net_admin, the
wrapper exits 1 before exec'ing the helper, rc is 1, and the test returns
KSFT_PASS with vsock_dev_do_ioctl() never reached.

The &>/dev/null redirection discards the wrapper's own error message, so
that outcome is silent.

check_deps() only verifies that the setpriv binary exists, not that
--bounding-set is supported, so an unsupported setpriv becomes a pass
rather than a skip.

The same conflation applies to the second test below: the pre-flight probe
runs only "unshare -U true", while the command actually executed is
"${unpriv} unshare -Urn ${helper}".  A failure of the -r or -n part, or of
setpriv --reuid/--regid/--clear-groups, also exits 1 and is read as the
ioctl's EPERM.

Would it be better for the helper to report a distinct sentinel exit code
(or print a machine-checkable marker) for the ioctl result, so that the
kernel's capable(CAP_NET_ADMIN) check in vsock_dev_do_ioctl() cannot be
weakened without these tests noticing?

> +
> +test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() {
> +	local helper=/tmp/vsock_assign_g2h_netns
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
> +	# The home shared with the guest is root-only, so place the helper where
> +	# an unprivileged user can execute it.
> +	vm_ssh "init_ns" -- \
> +		"cp ./vsock_assign_g2h_netns ${helper} && chmod 755 ${helper}"
> +
> +	vm_ssh "init_ns" -- "${unpriv} unshare -Urn ${helper}" &>/dev/null
> +	rc=$?
> +
> +	if [[ "${rc}" -ne "${EPERM}" ]]; then
> +		log_host "expected EPERM (${EPERM}) for an unprivileged user, got ${rc}"
> +		return "${KSFT_FAIL}"
> +	fi

[Severity: Medium]
Can uid 65534 open /dev/vsock in this guest at all?

The node is created from a miscdevice with no .mode:

net/vmw_vsock/af_vsock.c
static struct miscdevice vsock_device = {
	.name		= "vsock",
	.fops		= &vsock_device_ops,
};

misc_devnode() only overrides the mode when c->mode is non-zero, and
devtmpfs_create_node() then applies mode 0600 with uid/gid
GLOBAL_ROOT_UID/GLOBAL_ROOT_GID.  In the bare virtme-ng guest this script
boots there is no udev rule loosening it, so /dev/vsock is 0600 root:root.

With unshare -Urn only kuid 65534 is mapped, so the inode's kuid 0 is
unmapped in the new user namespace and capable_wrt_inode_uidgid() cannot
grant CAP_DAC_OVERRIDE.  open("/dev/vsock", O_RDONLY) then fails with
EACCES and the helper does:

tools/testing/selftests/vsock/vsock_assign_g2h_netns.c:main() {
	fd = open("/dev/vsock", O_RDONLY);
	if (fd < 0) {
		fprintf(stderr, "open /dev/vsock: %s\n", strerror(errno));
		return -1;
	}

which is exit status 255, so this rc check reports "expected EPERM (1) for
an unprivileged user, got 255" and returns KSFT_FAIL even though the
kernel behaved as intended.  The stderr message explaining why is dropped
by &>/dev/null.

Would it make sense to test whether the unprivileged uid can open
/dev/vsock first and return KSFT_SKIP if it cannot, so that an
inaccessible device node is distinguished from a refusal by the
CAP_NET_ADMIN check?

> +
> +	return "${KSFT_PASS}"
> +}
> +

[Severity: Low]
Both new tests are listed in USE_SHARED_VM but neither calls vm_reset_g2h,
while every other g2h-assign test does so on both the success and failure
paths, for example test_ns_guest_assign_g2h_netns_connect_to_host_ok(),
..._init_ns_connect_fails(), ..._host_connect_ok() and
..._reset_on_ns_delete_ok().

If the capable(CAP_NET_ADMIN) gate in vsock_dev_do_ioctl() is ever
weakened, the assign succeeds inside the throwaway unshare -n or
unshare -Urn namespace and these tests return KSFT_FAIL with the guest's
vsock device still owned by a dying namespace.

The neighbouring test already documents that the hand-back is not
immediate:

	# The holder is gone, but the namespace itself is dismantled from a
	# workqueue, so the device does not come back the same instant. Retry
	# until it does, rather than expecting the first send to succeed.

Could the following shared-VM tests then run while the device is still
unavailable, turning one real failure into a series of spurious ones?
Should these two tests call vm_reset_g2h before returning, like the others?

>  shared_vm_test() {
>  	local tname
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902-vsock-guest-ns-v1-0-9995383e9a8b%40meta.com
