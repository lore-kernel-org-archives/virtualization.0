Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0AAC5479D
	for <virtualization@archiver.kernel.org>; Wed,  4 Jan 2023 12:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 630CE80D37;
	Wed,  4 Jan 2023 12:43:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 630CE80D37
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=R/7nfHYE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id abfbADk2f1bW; Wed,  4 Jan 2023 12:43:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DD30980C02;
	Wed,  4 Jan 2023 12:43:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD30980C02
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6EAFC0032;
	Wed,  4 Jan 2023 12:43:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55917C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 12:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36AD44038D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 12:43:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 36AD44038D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=R/7nfHYE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VuH2a0igRlbi
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 12:43:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41BE84012B
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41BE84012B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 12:43:50 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8BD46B8162B;
 Wed,  4 Jan 2023 12:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CEAC433EF;
 Wed,  4 Jan 2023 12:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1672836226;
 bh=gKK35ke75uzbLNdiFo+ZUF6+OSLS2q0DB62aiLXqFus=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R/7nfHYE0649pnd56Dza8eBumthC+1bmiU/8A0efpKWDA9tLXbh+bR/ew+v+6yt7S
 r98T4XdbtBoNszBgq6/jjGeVS955ekatwSuOgQ1l1gBR4yVM8M/H57jlug9U8wYQrd
 rhqBIzXzaf6LhifUtNuy4PDCFiCNOYwIwU6c2XNs=
Date: Wed, 4 Jan 2023 13:43:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH 0/2] net/af_packet: Fix kernel BUG in __skb_gso_segment
Message-ID: <Y7V0f77yhwYplQQz@kroah.com>
References: <20221222083545.1972489-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221222083545.1972489-1-tudor.ambarus@linaro.org>
Cc: willemdebruijn.kernel@gmail.com, mst@redhat.com, netdev@vger.kernel.org,
 willemb@google.com, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 syzkaller@googlegroups.com, liuhangbin@gmail.com, joneslee@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Dec 22, 2022 at 10:35:43AM +0200, Tudor Ambarus wrote:
> The series is intended for stable@vger.kernel.org # 5.4+
> 
> Syzkaller reported the following bug on linux-5.{4, 10, 15}.y:
> https://syzkaller.appspot.com/bug?id=ce5575575f074c33ff80d104f5baee26f22e95f5
> 
> The upstream commit that introduces this bug is:
> 1ed1d5921139 ("net: skip virtio_net_hdr_set_proto if protocol already set")
> 
> Upstream fixes the bug with the following commits, one of which introduces
> new support:
> e9d3f80935b6 ("net/af_packet: make sure to pull mac header")
> dfed913e8b55 ("net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO") 
> 
> The additional logic and risk backported seems manageable.
> 
> The blammed commit introduces a kernel BUG in __skb_gso_segment for
> AF_PACKET SOCK_RAW GSO VLAN tagged packets. What happens is that
> virtio_net_hdr_set_proto() exists early as skb->protocol is already set to
> ETH_P_ALL. Then in packet_parse_headers() skb->protocol is set to
> ETH_P_8021AD, but neither the network header position is adjusted, nor the
> mac header is pulled. Thus when we get to validate the xmit skb and enter
> skb_mac_gso_segment(), skb->mac_len has value 14, but vlan_depth gets
> updated to 18 after skb_network_protocol() is called. This causes the
> BUG_ON from __skb_pull(skb, vlan_depth) to be hit, as the mac header has
> not been pulled yet.
> 
> The fixes from upstream backported cleanly without conflicts. I updated
> the commit message of the first patch to describe the problem encountered,
> and added Cc, Fixes, Reported-by and Tested-by tags. For the second patch
> I just added Cc to stable indicating the versions to be fixed, and added
> my Tested and Signed-off-by tags.
> 
> I tested the patches on linux-5.{4, 10, 15}.y.
> 
> Eric Dumazet (1):
>   net/af_packet: make sure to pull mac header
> 
> Hangbin Liu (1):
>   net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO
> 
>  net/packet/af_packet.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)

Now queued up, thanks.

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
