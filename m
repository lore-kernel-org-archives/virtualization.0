Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740D0C433FE
	for <virtualization@archiver.kernel.org>; Sat, 19 Feb 2022 07:37:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDAB283F6D;
	Sat, 19 Feb 2022 07:37:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SV-xWrd3mjzf; Sat, 19 Feb 2022 07:37:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3359C83F4D;
	Sat, 19 Feb 2022 07:37:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E873BC0011;
	Sat, 19 Feb 2022 07:37:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B1D7C000B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 07:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E71BD83F6D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 07:37:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fWCA09zkgh0l
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 07:37:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75EEE83F4D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 07:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=h57KiAEVSKkzXdNc8Dx5lCWM++DN28M84mRcDiV5fkY=; b=KsxrcfYaerfj7S4ITWFvQAQ0x6
 24aeSlzHZ3cmMdzzDJjwD5MH7BiCBtomrZK+sUouoLD9vIJHuUOIq8hNC2rT9TREsjqowo7ZigLPU
 llG/bACQNWJM62cm7Wc1o0o5yl4BeuJOK1InpRSg6F2nlLE+wMwB6Sr0Gv2APOv6ZKnh4XB2/bx0q
 pO/NM0jEjfo63HNdo4QypAR7fM098sBkqtoJnexaTDGT2EC9VuGERlxc6rMnA1xJW3+p1h+TLVuCS
 Lhtn1UlZlZPW5MAURTUYVTtlIOcC7djUDixNNJ6pg7uXqJlAMgXvaRfk2N49sHxK0dt49GFiuTp9+
 u3rD/Uaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nLKIh-00GNfs-Pt; Sat, 19 Feb 2022 07:37:03 +0000
Date: Fri, 18 Feb 2022 23:37:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
Subject: Re: [PATCH RFC v1 0/5] Add SCSI per device tagsets
Message-ID: <YhCeHweaO5ugY5aC@infradead.org>
References: <20220218184157.176457-1-melanieplageman@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220218184157.176457-1-melanieplageman@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: tyreld@linux.ibm.com, linux-hyperv@vger.kernel.org, mst@redhat.com,
 benh@kernel.crashing.org, mikelley@microsoft.com,
 R-QLogic-Storage-Upstream@marvell.com, paulus@samba.org, wei.liu@kernel.org,
 sthemmin@microsoft.com, linux-scsi@vger.kernel.org, mpe@ellerman.id.au,
 sathya.prakash@broadcom.com, decui@microsoft.com, kashyap.desai@broadcom.com,
 njavali@marvell.com, MPT-FusionLinux.pdl@broadcom.com, haiyangz@microsoft.com,
 mpi3mr-linuxdrv.pdl@broadcom.com, suganath-prabu.subramani@broadcom.com,
 jejb@linux.ibm.com, john.garry@huawei.com, stefanha@redhat.com,
 storagedev@microchip.com, virtualization@lists.linux-foundation.org,
 megaraidlinux.pdl@broadcom.com, sreekanth.reddy@broadcom.com,
 martin.petersen@oracle.com, shivasharan.srikanteshwara@broadcom.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 sumit.saxena@broadcom.com, andres@anarazel.de, pbonzini@redhat.com,
 don.brace@microchip.com
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

On Fri, Feb 18, 2022 at 06:41:52PM +0000, Melanie Plageman (Microsoft) wrote:
> Currently a single blk_mq_tag_set is associated with a Scsi_Host. When SCSI
> controllers are limited, attaching multiple devices to the same controller is
> required. In cloud environments with relatively high latency persistent storage,
> requiring all devices on a controller to share a single blk_mq_tag_set
> negatively impacts performance.

So add more controllers instead of completely breaking the architecture.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
