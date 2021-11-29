Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8455CC433EF
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 10:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A6AB403B0;
	Mon, 29 Nov 2021 10:22:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id knsQfQN-ebjX; Mon, 29 Nov 2021 10:22:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 713AC40134;
	Mon, 29 Nov 2021 10:22:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DF6EC002E;
	Mon, 29 Nov 2021 10:22:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80294C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 611E541C16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TuMTTqcScJWo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1DD841C12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=y+N6T9OX7HOXSR0XwGBs9AqYCmtI5mlyJgGLesZ2HD4=; b=WyDrKe/Bh7nQ7b/8LTVDbNFSYn
 EXxq5n73/ibf7zm6FmAT7XVapvybXUPlIXP78x4LNgdHQjtaVpQbj3XC2X3raEe99lvIRSxOmR7wW
 HiLQFMH92Ia/3oGO/pOBIv+fFbSdLCDdMhrsch/OnvhZd5mpH/29mtxEaEAJmrkCBxOc1wfFWNiM6
 rh/11Uz6PTBjfTQAj6T0jTJTP6rj3K0mpycAiDunQm4hT8eUpq7Ss6q5cooBawGxSohnff0n4TPZ4
 A9BNZkhL6PdqBIQElzxZLhNJAaZpf1SaVpH4aSbq7eHNN5/AkQlQrGoHjmlPCKPlRx4cjrl73Dh/y
 2ICGPwQA==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrdnP-0073IP-RJ; Mon, 29 Nov 2021 10:22:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: decouple DAX from block devices v2
Date: Mon, 29 Nov 2021 11:21:34 +0100
Message-Id: <20211129102203.2243509-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
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

Hi Dan,

this series decouples the DAX from the block layer so that the
block_device is not needed at all for the DAX I/O path.

Changes since v1:
 - rebase on latest v5.16-rc
 - ensure the new dax zeroing helpers are always declared
 - fix a dax_dev leak in pmem_attach_disk
 - remove '\n' from an xfs format string
 - fix a pre-existing error handling bug in alloc_dev
 - fix a few whitespace issues
 - tighten an error check
 - use s64/u64 a little more
 - improve a few commit messages
 - add a CONFIG_FS_DAX ifdef to stub out IOMAP_DAX
 - improve how IOMAP_DAX is introduced and better document why it is
   added
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
