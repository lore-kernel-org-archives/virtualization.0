Return-Path: <SRS0=T/77=JT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18E7C433B4
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 12:56:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6592A61424
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 12:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6592A61424
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B3FC40201;
	Thu, 22 Apr 2021 12:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YL4OwABUQjJ7; Thu, 22 Apr 2021 12:56:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 87D974021E;
	Thu, 22 Apr 2021 12:56:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DDB0C000F;
	Thu, 22 Apr 2021 12:56:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B621C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 12:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D29583C89
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 12:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=messagingengine.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p44x5lCaXWyW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 12:56:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECC2B81C67
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 12:56:02 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id EE97A12D4;
 Thu, 22 Apr 2021 08:55:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Thu, 22 Apr 2021 08:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=hUnsJZ
 Fx912SJYArMekrpRTZwS0S1MC2Jac58P5q++4=; b=eve03P83F0ISBTb4gv6srU
 awbNzfW+2lwSL2sjSqjLhEdjRE0eXAWjMSVCvbwumpSOxXuW5BKm3ofRd0DUTDM7
 3/vUBgxY4RK+0RLwpbB65mQH8yFnk7ddEq/vTv/kZIN0RNKm2pi2LB8anWBlCwS0
 QpFk1TG1kq76OAetpXSFNOSejgZ7IpBmYkfSgjFahjPD2Ny5xWPXZwMvRV/qQpjX
 AtNWue2rEV3ekOGVoRAKEpWL8pRpqRvDscHtIU1CE/twt6COPt5j++0XIZBylGVH
 fVH0UDN0+RqIg2mjaZvuGbFIzUvdKtrKWMVr2pkK1ECZz39Y3w64vhHMlRsZCmSw
 ==
X-ME-Sender: <xms:XHKBYLOSp5iiCem4v81ARl2kHhpxxS4bigrSvnkGe0ji7grgVegQkg>
 <xme:XHKBYF9kIEwl4a9_ftKqNcSwRvqq_HhC_TwiY8ylOeo8giL5NbojCAdm98Nlu_JiT
 aVhdjCwvxvaiCc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddutddgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
 tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
 gvrhhnpedtffekkeefudffveegueejffejhfetgfeuuefgvedtieehudeuueekhfduheel
 teenucfkphepkeegrddvvdelrdduheefrddukeejnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:XHKBYKRu7GRQVIfMu65atxeMRJYH8wUbFpfydDTitx4Ftwu6yakh9g>
 <xmx:XHKBYPvfJeBHQxqojVnSfMvguIGjIzDGU_a__mxsb126tQLDjtZWaQ>
 <xmx:XHKBYDekA9nMJqXWhGdlcGe0mwf4jWxcYuV3h0OjNT1_lKEUyrv-nA>
 <xmx:XXKBYK7cCFfDzqGbINwSqs5_-mlvVZ9R6d2kYmOKaF7Gm5LNmE16-g>
Received: from localhost (igld-84-229-153-187.inter.net.il [84.229.153.187])
 by mail.messagingengine.com (Postfix) with ESMTPA id 4510F240057;
 Thu, 22 Apr 2021 08:55:56 -0400 (EDT)
Date: Thu, 22 Apr 2021 15:55:53 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] virtio-net: page_to_skb() use build_skb when
 there's sufficient tailroom
Message-ID: <YIFyWbmtnM5IcHl8@shredder.lan>
References: <YIFaYBAryfCEBhln@shredder.lan>
 <1619093551.9680612-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1619093551.9680612-1-xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

On Thu, Apr 22, 2021 at 08:12:31PM +0800, Xuan Zhuo wrote:
> Thank you very much for reporting this problem. Can you try this patch? Of
> course, it also includes two patches from eric.
> 
>  af39c8f72301 virtio-net: fix use-after-free in page_to_skb()
>  f5d7872a8b8a virtio-net: restrict build_skb() use to some arches

Applied your patch on top of net-next, looks good. Feel free to add:

Tested-by: Ido Schimmel <idosch@nvidia.com>

Thanks for the quick fix
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
