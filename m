Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B71C3A5A7
	for <virtualization@archiver.kernel.org>; Tue,  6 Dec 2022 08:47:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC06240441;
	Tue,  6 Dec 2022 08:47:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC06240441
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n_M-SaQ9FniL; Tue,  6 Dec 2022 08:47:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 681F5402A8;
	Tue,  6 Dec 2022 08:47:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 681F5402A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CE51C0033;
	Tue,  6 Dec 2022 08:47:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EDE8C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 08:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F125360BF4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 08:47:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F125360BF4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CDapEW65DT-k
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 08:47:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E29660BC4
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E29660BC4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 08:47:41 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0258B68B05; Tue,  6 Dec 2022 09:47:37 +0100 (CET)
Date: Tue, 6 Dec 2022 09:47:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export
 irq_create_affinity_masks()
Message-ID: <20221206084736.GA9507@lst.de>
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-2-xieyongji@bytedance.com> <20221206081847.GA8771@lst.de>
 <CACycT3sXHGQt_V=rgwvEv4v8+oUaAOu1T=tWrKePdybMHagzng@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACycT3sXHGQt_V=rgwvEv4v8+oUaAOu1T=tWrKePdybMHagzng@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
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

On Tue, Dec 06, 2022 at 04:40:37PM +0800, Yongji Xie wrote:
> With the vDPA framework, some drivers (vduse, vdpa-sim) can create
> software-defined virtio devices and attach them to the virtio bus.
> This kind of virtio device is not a pci device or a platform device.
> So it would be needed to export this function if we want to implement
> the automatic affinity management for the virtio device driver which
> is binded to this device.

Why are these devices even using interrupts?  The whjole vdpa thing
is a mess, I also still need to fix up the horrible abuse of the DMA
API for something that isn't even DMA, and this just seems to spread
that same mistake even further.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
