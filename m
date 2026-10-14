Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDB34F646B;
	Wed, 14 Oct 2026 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975575; cv=none; b=WQj/HtkwNeb6HMa8PuOROuvs3BlB6WbB7yIACUhB2J3vj7ToNWtCh0f/LjZW/X5g8irN2J2C68+U1pzJWB6mt0lyygl1leoZj7s5s4FZScSufPYnuB4xwUFNsh/85uFHdYgoGBMZwwpaK3+6vGHVzB5ulObwzwU+6+HywOLQpeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975575; c=relaxed/simple;
	bh=9qLrsK/XOPNFxBX3O2L5OOexDG1GOH6RCGUE2WiDRBY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VqsYw/dj7/fh7MfXZ3HlR2ubKqyIsAcpjxUc8EgqOhnSn0dn2YV0GmY5xCfMR4OmrFx30G/rIVCZl5fPVBreO6DfHmXCpv4EQIjaTczAeVs9Q30M4S6wL8y+zlmrX0mrkbjZF/ZhozX2jREXA2sVASWEQqw5sPxECmHrXEILi9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPcx40NK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPcx40NK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0441F00898;
	Wed, 14 Oct 2026 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791975573;
	bh=6owXyhGg5y7dgKkf99MVJ+bgutRtoQS/J9i2gOP+fK4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SPcx40NKWp7QDFzDfcRRhBesACKaBL8tRx9/xxf7GnjrisVseDfd/rPqgt9+djPLr
	 H70BIWv/i8THAKBPYQo749kyVNipJ0UxgVajHlJcINwfjUNy3dw8fHuqWW36HI3KlN
	 ZVx3jCJCG/RDeWFVFpKZx3KRZmjLrrXH8jcRS91D90xgVDf/srwmMdmUTZrRKcYbZ+
	 pZqD3j4GMR18UidQB0kuE3qEVAMP9Wapa06rfdvmkrss6hZ6dPPfQlYPOtr6cnCizq
	 Uu49FsjJt2+g7RUdTS4YPJbyvivM1+Sp0eVhCUDA2+Bbqimw4BUy+yfBEztYOhXJrY
	 ew7Ul7fp82RaA==
Subject: Re: [PATCH net-next 4/4] net: account for ingress-resolved virtio net
 hdr state
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, maxk@qualcomm.com, rusty@rustcorp.com.au,
 horms@kernel.org
Date: Wed, 14 Oct 2026 10:59:32 +0000
Message-ID: <179197557205.434549.14468645046355875778@kernel.org>
In-Reply-To:
 <d82518764906d3b552fd3ade65b96ac741197d4e.1791887415.git.mst@redhat.com>
References:
 <d82518764906d3b552fd3ade65b96ac741197d4e.1791887415.git.mst@redhat.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch silently fixes a packet-drop regression introduced
  by the previous commit in the series, "net: resolve uncommon partial…
- [Medium] tun_get_ethtool_stats() assigns `data[0] =
  atomic_long_read(&tun->rx_csum_sw);` straight into the u64 ethtool…
- [Low] The trailer `Fixes: f43798c27684 ("tun: Allow GSO using
  virtio_net_hdr")` names a July 2008 commit by Rusty Russell (verified…

--

net: account for ingress-resolved virtio net hdr state

After this commit, virtio_net_hdr_to_skb() returns 1 when it completes an
uncommon checksum in software at ingress. The converter call sites in tap,
tun, virtio_net and af_packet now test for a negative errno. tun counts
these events per device as rx_csum_sw and exposes the counter through
ethtool -S.

> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")

[Severity: Low]
Is this the right Fixes: target? f43798c27684 is the 2008 commit that
added GSO via virtio_net_hdr to tun.

Software checksum completion in the converter first appears in the
previous patch in this series, "net: resolve uncommon partial checksums
at ingress". So does the positive return value this patch accounts for.
At the baseline there is no skb_checksum_help() call in
include/linux/virtio_net.h.

Stable tooling that follows this tag could offer the patch to every
stable branch since 2.6.27. On those branches the "return err ?: 1"
hunk has nothing to apply to, and rx_csum_sw would always read 0.

Should the tag be dropped? If it is meant to cover the call site fix
below, should it point at the previous commit in this series instead?

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 8b82a7fe6ec7f..b8961229737fd 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -1935,11 +1936,19 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		break;
>  	}
>  
> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> +	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
> +	if (err < 0) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		err = -EINVAL;
>  		goto free_skb;
>  	}

[Severity: Medium]
Does this change also fix a regression from the previous patch in the
series, "net: resolve uncommon partial checksums at ingress"?

That commit already made virtio_net_hdr_tnl_to_skb() return 1 on the
UDP tunnel path after a successful software checksum:

include/linux/virtio_net.h:virtio_net_hdr_tnl_to_skb() {
    ...
	ret = skb_checksum_help(skb);
	return ret ?: 1;
}

At that commit, the tunnel converter callers still treated any nonzero
return as a failure:

tun_get_user():
	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
		atomic_long_inc(&tun->rx_frame_errors);
		err = -EINVAL;
		goto free_skb;
	}

tun_xdp_one() had the same pattern. virtnet_receive_done() went to
frame_err and printed a "bad gso" warning.

Take a UDP tunnel header with these properties:

  - NEEDS_CSUM is set.
  - The payload is no larger than gso_size, so skb_is_gso() is false.
  - The inner csum offsets fail virtio_net_csum_partial_ok_at_offset().

With only the previous commit applied, such a packet would have its
checksum completed and then be dropped as a frame error. tun write()
would return -EINVAL for it.

This commit message describes the "< 0" changes only as accounting
plumbing. To keep the series bisectable, could the call site changes be
folded into "net: resolve uncommon partial checksums at ingress"?
Alternatively, could this commit message say that it fixes that commit?

> +	if (err > 0)
> +		atomic_long_inc(&tun->rx_csum_sw);

[ ... ]

> @@ -3739,7 +3751,35 @@ static void tun_get_channels(struct net_device *dev,

[ ... ]

> +static void tun_get_ethtool_stats(struct net_device *dev,
> +				  struct ethtool_stats *stats, u64 *data)
> +{
> +	struct tun_struct *tun = netdev_priv(dev);
> +
> +	data[0] = atomic_long_read(&tun->rx_csum_sw);

[Severity: Medium]
On 32-bit builds, atomic_long_t is an atomic_t and atomic_long_read()
returns a signed long. Once rx_csum_sw passes 2^31, can the implicit
conversion to u64 sign-extend the value? ethtool -S would then report
something like 0xffffffff80000000.

tun_net_get_stats64() in the same file avoids this for the sibling
counter:

	stats->rx_frame_errors +=
		(unsigned long)atomic_long_read(&tun->rx_frame_errors);

Should this read use the same (unsigned long) cast?

> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791887415.git.mst%40redhat.com
