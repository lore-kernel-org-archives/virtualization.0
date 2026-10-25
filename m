Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792906266;
	b=ukbPaBgr4/gqmFZM7Dtijn0pF6QTwWcawmv9i6USfZXbWFgaZEqv0IXOfs0zAdwI2UVn
	 1EeUEBnpfxrdTkjL8gKKcb0zjNGTs+dchkDQ1+DF12dj3MzUGJpl4Jnn/Xjo9iKWYN53/
	 zGYONd00JUTvZqp73mOyKznKwWbas91kBgkqSOqVmMfcZ59s31k2winS9KkloQv0+SR+B
	 0qI9iwnqvJ/LgKZLPl2eSr/Gs3LuWd1tYClu8h9yyNsfuujBaggqqp9lNt0AXX5IdKYO8
	 yp2l6lKdN3oolw04sWi9vVi9fBjd4OXO5YnkPiaBFObBug4HLtR8Tvm90MStEql7zQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792906266;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gMQhvSd2iPBWErQGGLe8rTomz1iYiodhFjO262Nxpo8=;
	b=QVpKJcYs6YnE9YDHHZ8yJ8H7S86bLVfNS7FYPW/TIit+em9+jz8gO+KwxDjHZFNO7Bg8
	 5v+q1bfeOe2n2oQTumfGB9kIQjaj7UdJ96wW9vKki3CZs+ImSCf6rsZUob1T0sap7f7TV
	 USJAvOMCR8QFnpxFZaxdAxnlpNRAXY37rYrY9Byz1VAxC5LYs5ezgU2pxTPS3cOQWqTlc
	 1gBtxvP/MRmUVIRuDNWjVYZMzUgPd60aluEzlPI3rWlQuNWnLsA7fzXYSw7+kYQRMHjRe
	 lauxfbiTrbjn4vchn0Bh8BjPiAAUGfwuoTevrSeRPXmWK/Ofu64IQ2NOQmdNj1UH1MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nCY/YaKj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6101D606A32A;
	Sun, 25 Oct 2026 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nCY/YaKj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5671F01829;
	Sun, 25 Oct 2026 05:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792906265;
	bh=gMQhvSd2iPBWErQGGLe8rTomz1iYiodhFjO262Nxpo8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nCY/YaKjdjX0OFYSJrJ14LPouFw76wJy3tzwjRrde+XbOOT03Egi2EGQQv/wsyS1T
	 B84fZRix4Fq4njlx7C8H/8U0pOPXfUFaxXAW7p/4NRgD03zXBENtLA8BjlxYLHTgJq
	 ybUmWq9hszt1feKSZiCCpSstI5xdABoH2fyIoAChJXDDjNPWO3FCT7OPkbfxf381Zn
	 zWTLwLVoGXMC0iB4HmfriULKG77vhc+jpIYVawKLkd7wPMYuxMiIahCBhrU2Pj0DJI
	 V4FHzfoY56hXIOaU/klRp/rLAkBOk9aLzJCOHkheQBKuGwR2AgnDyeCZDzBiOVNcKE
	 MmoFR9C2c0NDA==
Subject: Re: [PATCH net v5 5/7] net: add a sysctl to opt out of virtio net hdr
 checksum validation
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 carges@cloudflare.com, bjorn@kernel.org, phil@nwl.cc, jasowangio@gmail.com,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev, maxk@qualcomm.com,
 rusty@rustcorp.com.au
Date: Sun, 25 Oct 2026 05:31:04 +0000
Message-ID: <179290626462.3134.18093593044848809481@kernel.org>
In-Reply-To:
 <2beba4c8b84c811120b6100bcccd8b90e7458787.1792668082.git.mst@redhat.com>
References:
 <2beba4c8b84c811120b6100bcccd8b90e7458787.1792668082.git.mst@redhat.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] virtio_net_hdr_validate_disabled() reads
  dev_net(skb->dev)->core.sysctl_virtio_net_hdr_validate with no RCU…

--

net: add a sysctl to opt out of virtio net hdr checksum validation

This adds a per-netns sysctl, net.core.virtio_net_hdr_validate. Host root
can use it to turn off the virtio net header checksum validation added by
the previous patch. A static key gates a lockless read of the per-netns
value in virtio_net_hdr_validate_disabled(), and that helper is checked
at the start of the csum and tunnel offset validators.

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 52852a33a2db7..cea70ccf0ed4b 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

[ ... ]

> @@ -78,6 +79,20 @@ static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
>  	*thoff = nhoff + iph->ihl * sizeof(u32);
>  	return iph;
>  }
> +/* Defined in net/core/dev.c, enabled while any network namespace
> + * has net.core.virtio_net_hdr_validate set to 0.
> + */
> +DECLARE_STATIC_KEY_FALSE(virtio_net_hdr_validate_disabled_key);
> +
> +/* Failsafe: a namespace can disable the check with
> + * net.core.virtio_net_hdr_validate.
> + * The caller must keep the netns of skb->dev alive.
> + */
> +static inline bool virtio_net_hdr_validate_disabled(struct sk_buff *skb)
> +{
> +	return static_branch_unlikely(&virtio_net_hdr_validate_disabled_key) &&
> +	       !READ_ONCE(dev_net(skb->dev)->core.sysctl_virtio_net_hdr_validate);

[Severity: Medium]

Can this read hit a freed struct net? There is no rcu_read_lock() here
and no reference on the netns.

dev_net() is read_pnet(), which is just a plain load of dev->nd_net. The
comment asks the caller to keep the netns of skb->dev alive, but the
callers don't appear to do that.

For example, tun_get_user() gets here from preemptible process context,
before either of its rcu_read_lock() sections. The only thing it holds is
the device reference taken by tun_get():

tun_get_user()
  tun_vnet_hdr_tnl_to_skb()
    ...
      virtio_net_hdr_validate_disabled()

packet_snd() and tpacket_snd() reach virtio_net_hdr_to_skb() the same
way, also holding only a device reference.

Here is one possible sequence:

  - The writer loads dev->nd_net (net_B) and is preempted.
  - The device is moved from net_B to net_C. tun does not set
    netns_local, and dev_change_net_namespace() does not wait for
    device references.
  - The last reference to net_B is dropped and cleanup_net() runs.
    This reader is not in an RCU read-side section, so the
    synchronize_rcu() there does not wait for it, and net_B is freed.
  - The writer resumes and reads sysctl_virtio_net_hdr_validate from
    the freed net_B.

The window is small. It needs the static key enabled (some netns has
the sysctl set to 0) and a privileged netns move with teardown.

Would it be better to do the read under rcu_read_lock() and use
dev_net_rcu(), something like this?

	bool disabled;

	rcu_read_lock();
	disabled = !READ_ONCE(dev_net_rcu(skb->dev)->core.sysctl_virtio_net_hdr_validate);
	rcu_read_unlock();

> +}
>  
>  /* Where does the L3 header start, and what protocol is it?
>   * Handles Ethernet and VLAN headers; other devices use the

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.v5.git.mst%40redhat.com
