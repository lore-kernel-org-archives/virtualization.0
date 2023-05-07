Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1460FC77B7D
	for <virtualization@archiver.kernel.org>; Sun,  7 May 2023 10:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8863560F96;
	Sun,  7 May 2023 10:40:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8863560F96
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Dzh1GZYd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NFC1-IeF_BZu; Sun,  7 May 2023 10:40:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9363F60A66;
	Sun,  7 May 2023 10:40:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9363F60A66
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 685A4C0037;
	Sun,  7 May 2023 10:40:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B281C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 10:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5127240298
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 10:40:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5127240298
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=Dzh1GZYd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VhttVJxyhCGm
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 10:40:16 +0000 (UTC)
X-Greylist: delayed 01:06:02 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3734F4015A
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3734F4015A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 10:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=8O7iwhKUEtaC+yGWAkkZj8ftLvq2X4vGALr4kxZfwTo=; b=Dzh1GZYdDsBqW+xGH6mcESgJJe
 xYVa9SrJxeDOAI7OzrzmB8R6QChr/xqrADHHkpL26MjtHI5OoH14obPfYqzwRB9ZeELDVO9+Et36+
 Q6rZJeNW7tVCA5t+LCDxQhxOUk8Imn/C8iAWvCyLGMwVAoaxtV4QWXHJJepwbkACiBJxIfV4MF5D2
 am7J2sstO0SlCCs90gz1hMT5MYqDp6p0cq0N8RCKHYsxQb0jhuhBd+0HMXuu8zzngGMSiG3cqtzts
 7yb/70jqAnEZeF8HdZv+F+ErLMrjdAsTVaoAVfqFs2vn901A9gWXOFntuu7Nl/XXCGplhN37cxHjK
 AnMaVepQ==;
Received: from [2a00:23ee:19f0:787b:4aaa:b478:2a2b:a116] (helo=[IPv6:::1])
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1pvak0-004P3l-0G; Sun, 07 May 2023 09:33:41 +0000
Date: Sun, 07 May 2023 10:31:34 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Hao Chen <chenh@yusur.tech>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_virtio=5Fnet=3A_set_default_mtu_to_15?=
 =?US-ASCII?Q?00_when_=27Device_maximum_MTU=27_bigger_than_1500?=
User-Agent: K-9 Mail for Android
In-Reply-To: <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
References: <20230506021529.396812-1-chenh@yusur.tech>
 <1683341417.0965195-4-xuanzhuo@linux.alibaba.com>
 <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
Message-ID: <49455AA8-0606-447E-B455-F905EA184E42@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Cc: zy@yusur.tech, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, huangml@yusur.tech,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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



On 6 May 2023 09:56:35 BST, Hao Chen <chenh@yusur.tech> wrote:
>In the current code, if the maximum MTU supported by the virtio net hardware is 9000, the default MTU of the virtio net driver will also be set to 9000. When sending packets through "ping -s 5000", if the peer router does not support negotiating a path MTU through ICMP packets, the packets will be discarded.

That router is just plain broken, and it's going to break all kinds of traffic. Hacking the virtio-net MTU is only a partial workaround.

Surely the correct fix here is to apply percussive education to whatever idiot thought it was OK to block ICMP. Not to hack the default MTU of one device to the lowest common denominator. 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
