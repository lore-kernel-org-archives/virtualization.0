Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BA6C43334
	for <virtualization@archiver.kernel.org>; Tue,  7 Jun 2022 14:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B913740614;
	Tue,  7 Jun 2022 14:57:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z-U5MbKXhk7x; Tue,  7 Jun 2022 14:57:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9423F40608;
	Tue,  7 Jun 2022 14:57:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 590C0C0032;
	Tue,  7 Jun 2022 14:57:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2B31C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 14:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BCF9160F30
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 14:57:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ssqKtIR5o1LR
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 14:57:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A466460E6F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AfL2iuaKMIW3GEEXa7GrCIERYid9+IWuPeOvvtY3ld4=; b=fRSk5WhSy4yx86ABGN8DAKmWjC
 5IdJfhP/2tfrBb3qOP67dWCLnwarcUWbjvi3CSZox73Cc2Y1PIwGlfqeGnF3Uxyt0mbA5Mg3BbAic
 u8C1w1Bg+HnPIgHl9bpnhpAGnvXoNlM/riGdn7iNiA4dEw1cH8c3GLB6l+j+CAh8jR4QCRLgjeJYJ
 KjvzVwo8asMupiPKaBH9YNKuxq1ZqBG33mo7YsQtWCkEXiw/2CPMhM29QfN4S2WqjmyhTpN+ujECh
 HLTSFWPPBpUYWjBGjh365kLciirfPTZ2IaAsMeDnES6CMIrk6IVPXnxuuFSWcG0n8eXm6dw3XUxLO
 bUTOI4Jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyadh-00Bioa-Tk; Tue, 07 Jun 2022 14:57:01 +0000
Date: Tue, 7 Jun 2022 15:57:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 04/20] mm/migrate: Convert buffer_migrate_page() to
 buffer_migrate_folio()
Message-ID: <Yp9nPSwPEWoX7Ml+@casper.infradead.org>
References: <20220606204050.2625949-5-willy@infradead.org>
 <202206071139.aWSx4GHH-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202206071139.aWSx4GHH-lkp@intel.com>
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 kbuild-all@lists.01.org, linux-ntfs-dev@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
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

On Tue, Jun 07, 2022 at 11:37:45AM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
> >> mm/migrate.c:775: warning: expecting prototype for buffer_migrate_folio_noref(). Prototype was for buffer_migrate_folio_norefs() instead

No good deed (turning documentation into kerneldoc) goes unpunished ...
thanks, fixed.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
