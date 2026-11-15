Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794715291;
	b=yi4+o4uAiW49VqL0J1XflTbZwIzfo/Zivbxq19kiPvGBP2Z6+S90dDsGHBZ8RBPfBhDk
	 Nd7LS/yMy17z1yCrGL84EuTQSL5c5zgV7yOsGiFm3VwJLSR+IUgRjuMsifHcHRAM8nPlz
	 qjZMIwMN6wTBAeZTYZgrpG3WyCX8OxCkTNXiRIsPNQCu/askglrgM7FS7a+qeyo2VBZDe
	 QhFFzNjX9a1kOnYZ4vgetbgcyf1PHtbAmBjI+yAayq8BsxatmJ/7ed/c89DshNonVwgvh
	 ciosHLrbMIv5WQVj7HIhj3u5JQG0zP+j+EkaLC7RObeWNvZX3Mhq0Wkqjf6WNCDjYTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794715291;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=j06WsGrPHgOVDywy3vc8XuyLsYq2X//jc3Wbr5nqcdY=;
	b=ZDP0aLfZptQMGNB4HeRNdYy7AGfOCMkLVPWkRL9zSF5REzxCKd1TYi8xUJimznrasrl3
	 InJMDhq+EKUi+VuUz/Uv0OYgwSj1ufds/buimrYEGr+NNL+zApDPjPczWUYoGzZvI8zup
	 d0fYicE+X4/IHowJlwGl+VI5dAjT84d0BbuyDFIyfuLI2fW6JAgmcyvHewURIwVHjOPvu
	 /LxHUyHXwf9e7T6/hxs8296Bxc0dHOUmF+v/SCi2QXFrxSYUPrLlQymSMgOuI25XEj0GT
	 0IGdHgmE1eE/cyOfnFF6VItsPp51keIpw8wFoFzZ8mI5Iw0LGYiJ/XPEpvx2rWHc/YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XBrMEikm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3A606A88E;
	Sun, 15 Nov 2026 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XBrMEikm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39DF1F000C4;
	Sun, 15 Nov 2026 04:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794715291;
	bh=j06WsGrPHgOVDywy3vc8XuyLsYq2X//jc3Wbr5nqcdY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XBrMEikmQ+fuk2yYYfhVFIosfByIR8F6eTTLfBzEREG9WOubVBnUIVUOAyxI+JM/4
	 GvkAvQjgfng9ksOewe7VotSmtb+k28zEslqrERLVK7ZBU/JNpkTEDduaAxeFgkN9Q9
	 xRksSUlbRL6TKJumpuyA3ozAPf67BmDEreBZwYhFXMNBGqpfWHdOgQuq/crBxSSHgB
	 BUTRGA6AkMLxFbZXqjR5Uk04fYuvY3gdddQZDlu36gxaqIEOFBQyS5f9s+0KKIR9s8
	 Yo9+sAeeH50UJcvy4Nf5Iqc+PX2Ay1w1xPYhzDT3EbOyKvYuQuuyDQqJJ8dGkDvhOW
	 K778xanebKiqA==
Subject: Re: [PATCH net-next v6 5/8] vsock: add a netlink command to assign
 the g2h device to a netns
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
Date: Sun, 15 Nov 2026 04:01:29 +0000
Message-ID: <179471528940.2199510.18137700517588437955@kernel.org>
In-Reply-To: <20261113-vsock-guest-ns-v6-5-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-5-3737ce4673c0@meta.com>
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

- [Low] The new `vsock` generic netlink family defines `dev-netns-set`
  (VSOCK_CMD_DEV_NETNS_SET) as a do-request with no reply.

--

vsock: add a netlink command to assign the g2h device to a netns

This patch adds a vsock generic netlink family. VSOCK_CMD_DEV_NETNS_SET
moves the guest's G2H vsock device into a given network namespace, and
VSOCK_CMD_DEV_NETNS_GET reports the assignment as an nsid relative to
the caller. Connected sockets that can no longer reach the device are
closed with ECONNRESET, and an assignment that would cause a CID
collision is refused.

Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/

> diff --git a/Documentation/netlink/specs/vsock.yaml b/Documentation/netlink/specs/vsock.yaml
> new file mode 100644
> index 0000000000000..f260ee88b1402
> --- /dev/null
> +++ b/Documentation/netlink/specs/vsock.yaml

[ ... ]

> +operations:
> +  list:
> +    -
> +      name: dev-netns-set
> +      doc: |
> +        Set the network namespace of the guest's vsock device.

[ ... ]

> +        The assignment holds a reference on the namespace.
> +      attribute-set: vsock
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - netns-fd
> +            - netns-pid

[Severity: Low]
This isn't a bug, but should dev-netns-set have a reply block here?

The spec gives dev-netns-set a request and no reply. As a result,
vsock_nl_dev_netns_set_doit() only returns an errno and the caller gets a
bare ACK.

The netlink guidance for new families says every operation should reply
with a full message that identifies the resulting object. It also says
that once a command only ACKs, the ACK-only behaviour becomes uAPI and
cannot be changed later.

The v3 revision replied with netns-id. The v5 changelog says the reply
was dropped at Stefano's request, so this looks deliberate. Since this
family has not been released yet, could that decision be checked once
more?

A netns-id reply would tell the caller where the device ended up,
relative to its own namespace, without a second dev-netns-get request.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 37abde1ca26cd..d4d88c8cf142f 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c

[ ... ]

> +int vsock_nl_dev_netns_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{

[ ... ]

> +	err = vsock_g2h_net_assign(net, info->extack);
> +	put_net(net);
> +
> +	return err;
> +}

This is where a reply would be built, for example by reusing
vsock_nl_dev_netns_fill() as vsock_nl_dev_netns_get_doit() does.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-vsock-guest-ns-v6-0-3737ce4673c0%40meta.com
