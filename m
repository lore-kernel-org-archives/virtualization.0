Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC842ECAAD1
	for <virtualization@archiver.kernel.org>; Tue, 30 Aug 2022 13:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C30960FC2;
	Tue, 30 Aug 2022 13:40:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C30960FC2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=k5/jiiFg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jnNX05gpVcV7; Tue, 30 Aug 2022 13:40:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E714260FB5;
	Tue, 30 Aug 2022 13:40:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E714260FB5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2C83C0032;
	Tue, 30 Aug 2022 13:40:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42372C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 13:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14E9581570
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 13:40:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14E9581570
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=k5/jiiFg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o3FWo739i-RF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 13:40:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18790813E9
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18790813E9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 13:40:21 +0000 (UTC)
Received: from localhost (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 076266601C4C;
 Tue, 30 Aug 2022 14:40:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1661866820;
 bh=rcImThh2C0VG7MezY1gkK7NeKYQCZ/znLXT8XdXHjCg=;
 h=From:To:Cc:Subject:References:In-reply-to:Date:From;
 b=k5/jiiFgrTtk42inz51Xvn3GrM1hy+5Tn+URVZOT/PPL8pO65JxddAJ8W700GoNJ5
 EfXTtwWha7ppfmMM65QoRGAbjgR0m3pnv5FDd+AnSPmKwM+hUc4qU0NbMlFr324IbE
 HJ6xmir4pEkTrqs2yzgc1iUSMl5/jNZIUdxic31Gpu1XhTaIrbQsrFeCqBa7Nv/DZ+
 Qpmhm7hg047YIxi49jcdObaS8gFxIZp0y+LNORXw0UPFy5S4+eyKUg0cMBjM3/LdyB
 pJbLzY9GvZC3/WFqxKER12VzqXwP3zYRgV3gvC/wZalf86XEkNVmracxDL+9LXN+DP
 d+vRl/XYf1TTw==
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v14 00/42] virtio pci support VIRTIO_F_RING_RESET
References: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
 <20220830091334.umvkmnehvhpubunx@rcn-XPS-13-9305>
 <1661852011.7488828-3-xuanzhuo@linux.alibaba.com>
In-reply-to: <1661852011.7488828-3-xuanzhuo@linux.alibaba.com>
Date: Tue, 30 Aug 2022 15:40:17 +0200
Message-ID: <87pmghu9xa.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Cc: kernel@collabora.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org
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

On mar, ago 30 2022 at 17:33:31, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> Can you test this patch?

It didn't apply cleanly over
git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git (linux-next)

but I applied it manually and it works, thanks!

Cheers,
Ricardo
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
