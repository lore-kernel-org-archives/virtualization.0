Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAC5C433EF
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 11:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9AB3403E5;
	Wed, 24 Nov 2021 11:44:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S7Uu6VgQgxLa; Wed, 24 Nov 2021 11:44:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4487C40371;
	Wed, 24 Nov 2021 11:44:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1746CC001E;
	Wed, 24 Nov 2021 11:44:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD975C0036
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 11:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9C0B60619
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 11:44:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=armlinux.org.uk
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rSVPnO7XZ93v
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 11:44:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 01C4E60BFE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 11:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LNu4AykOPGTGRWShRdT+QGUAXF7U4RU104garBUKgaA=; b=Kl6Wq5os68RBQahJ224rY3eb68
 RGwfznLW2AcUbJFhcDKyzFfbeuU27I+4y77xbyQTOTxwoXAvP2JZbcksotMqRoCL7q/yLFZTYSZeF
 vd43e986TTXq6aliGAX9sgXpqa6GqbsVLXF037rG1goY2zT/19AuX+Et/IPgflPCfUl0mEsu5rzZz
 KWVD1uT/X5GsN5a5lPU6O+E0/lFpg+WKmQoehD61Gs3n5vgzc1S/BxnqMNYcbmWne17sydJ6liEwb
 J1WVC/95J/EgYKsIHjfYUrrejtSlkiMjKDh5oEH6Zqy+pEGM4umUaUtgOhbFrbAryjrdVkXcXYcPj
 Bw/C31Kg==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55842)
 by pandora.armlinux.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <linux@armlinux.org.uk>)
 id 1mpqWZ-0000Wd-20; Wed, 24 Nov 2021 11:33:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1mpqWP-00019h-7L; Wed, 24 Nov 2021 11:33:05 +0000
Date: Wed, 24 Nov 2021 11:33:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: Re: [PATCH v2 net-next 08/26] mvpp2: provide .ndo_get_xdp_stats()
 callback
Message-ID: <YZ4i8fQcM47wDbeS@shell.armlinux.org.uk>
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
 <20211123163955.154512-9-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211123163955.154512-9-alexandr.lobakin@intel.com>
Cc: Song Liu <songliubraving@fb.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yonghong Song <yhs@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Andrei Vagin <avagin@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Arthur Kiyanovski <akiyano@amazon.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Noam Dagan <ndagan@amazon.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Cong Wang <cong.wang@bytedance.com>,
 Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, KP Singh <kpsingh@kernel.org>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Martin Habets <habetsm.xilinx@gmail.com>, Shay Agroskin <shayagr@amazon.com>,
 Marcin Wojtas <mw@semihalf.com>, Leon Romanovsky <leon@kernel.org>,
 David Arinzon <darinzon@amazon.com>, David Ahern <dsahern@kernel.org>,
 Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Yajun Deng <yajun.deng@linux.dev>, netdev@vger.kernel.org,
 Saeed Bishara <saeedb@amazon.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, bpf@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>
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

On Tue, Nov 23, 2021 at 05:39:37PM +0100, Alexander Lobakin wrote:
> Same as mvneta, mvpp2 stores 7 XDP counters in per-cpu containers.
> Expose them via generic XDP stats infra.
> 
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
