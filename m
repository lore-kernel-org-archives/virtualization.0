Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC343BBFD0;
	Sun,  6 Sep 2026 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714246; cv=none; b=tYUJtJfEhFAmqfTrGBBSihqN7BQ257zPvgK/9x7+tUNwS+E/ZXpvGXGcYwppReCiCBMQQhI7ABzIRsuAhRxnawlKXgw2sm97Mbyz4aUjVGXqORu5Q3Jx047PX2EZbGsFkVoW4u2jwJaagQIkaGpzgvxbdP2tD7v/Sr7g/jVMzfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714246; c=relaxed/simple;
	bh=6OO0g7KbWg4rTZ/kfO+XVNC+1G7yyq9vnIeCl3ZiZJQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uLGQl1x/bPuTFZ+WIni9RRioOzE2bShuGYpacaci3d3x+nr5ozIZwmUWUTRkT2FVYQS2NXll6Zymtq98w+HflI9cCHo1h1rTxgCVzsUMnIdBP+8OPM/FUgPb6lg0geZL2/vVUu9+aV4PgB8Wb6ZRFdCHmU+DttmmNbKCKbSt9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6vgMuVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6vgMuVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8186A1F00A3A;
	Sun,  6 Sep 2026 17:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788714243;
	bh=86H82WDHmCYRTpw51GzByVGTnw1V93rC0WXlCGRrZ1s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b6vgMuViJ+Z/7lDgiPahOEsdl7xuvLXVEBiLE8YSAJkplXuqroMHTTqpl6FFbfZdH
	 zrp07UbQR2uGNp+EtU8dDi0wLWy0ko+pkL8EsclA8PPzrcZVhXv/iib4xOtr/GajUL
	 1IxQ686pShTG9CczfRg+MKQIrQJUMg5mbNUbimC7CpesMiMOoC4DBsgVuUUx+TJpdo
	 SliynvXQTDq8MMxKMcjAKddEvKQfUSa2WwK19QsPuZWFNnn/RnVB0V9aybOvsvluH6
	 9rd007UeRl4shgxfqa8VD1fL8aYmUFVC0UYQxB3sXeYNxnnJeK5kgsYa53d7vrM6Su
	 2VcC/W7W3fIiw==
Subject: Re: [PATCH net-next 4/6] selftests/vsock: add a helper to assign the
 g2h device to a netns
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
Date: Sun, 06 Sep 2026 17:04:02 +0000
Message-ID: <178871424205.219967.16419914042231050554@kernel.org>
In-Reply-To: <20260902-vsock-guest-ns-v1-4-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-4-9995383e9a8b@meta.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] Concern (validated as a FALSE POSITIVE): the new helper binary
  vsock_assign_g2h_netns was claimed to be built and installed with no…
- [Low] Documentation/admin-guide/sysctl/net.rst (lines 518-534, added by
  "vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS") describes G2H…

--

selftests/vsock: add a helper to assign the g2h device to a netns

This adds a small userspace helper, vsock_assign_g2h_netns, that opens
/dev/vsock and issues IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS so shell based
tests can move the guest vsock device into the caller's network
namespace. The helper exits with the ioctl errno and is added to
TEST_GEN_FILES and .gitignore.

> diff --git a/tools/testing/selftests/vsock/vsock_assign_g2h_netns.c b/tools/testing/selftests/vsock/vsock_assign_g2h_netns.c
> new file mode 100644
> index 000000000000..6f15629af607
> --- /dev/null
> +++ b/tools/testing/selftests/vsock/vsock_assign_g2h_netns.c
> @@ -0,0 +1,45 @@

[ ... ]

> +	ret = ioctl(fd, IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS);
> +	if (ret < 0) {
> +		ret = errno;
> +		fprintf(stderr,
> +			"IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS: %s (errno %d)\n",
> +			strerror(errno), errno);
> +	}

[Severity: Low]
While looking at what errnos a caller of this helper can expect, the
documentation added earlier in the series for this ioctl reads as if the
move always happens.  From the vsock section of
Documentation/admin-guide/sysctl/net.rst:

  In a guest, the vsock device owned by the guest-to-host (G2H) transport
  belongs to one network namespace at a time.  The
  IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS ioctl on /dev/vsock moves it to the
  namespace of the calling process, which requires CAP_NET_ADMIN in the
  initial user namespace.

The uapi comment above the define in include/uapi/linux/vm_sockets.h is
similarly unqualified:

  /* Assign the guest's vsock device to the network namespace of the calling
   * process. Requires CAP_NET_ADMIN in the initial user namespace. To undo an
   * assignment, assign the device to the initial network namespace.
   */

The implementation only allows the move for transports that opt in.  In
net/vmw_vsock/af_vsock.c, vsock_g2h_net_assign() refuses otherwise:

	} else if (!vsock_g2h_netns_assignable()) {
		ret = -EOPNOTSUPP;

and vsock_g2h_netns_assignable() requires the callback:

	return transport_g2h && transport_g2h->netns_assign_allow &&
	       transport_g2h->netns_assign_allow();

Grepping net/vmw_vsock/ shows netns_assign_allow is only provided by
virtio_transport.c (virtio_transport_netns_assign_allow()).
hyperv_transport.c registers with vsock_core_register(&hvs_transport,
VSOCK_TRANSPORT_F_G2H) and vmci_transport.c sets features =
VSOCK_TRANSPORT_F_G2H, and neither defines the callback.

So on a Hyper-V or VMCI guest, does this ioctl always fail with
-EOPNOTSUPP even for a CAP_NET_ADMIN caller, contrary to what net.rst and
the uapi comment describe?  Would it be worth saying in both places that
assignment is transport dependent and that transports which do not opt in
return -EOPNOTSUPP?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902-vsock-guest-ns-v1-0-9995383e9a8b%40meta.com
