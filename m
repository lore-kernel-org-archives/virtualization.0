Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B01DC43334
	for <virtualization@archiver.kernel.org>; Tue,  7 Jun 2022 15:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A38E960FA6;
	Tue,  7 Jun 2022 15:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oPKLLkW8boa9; Tue,  7 Jun 2022 15:03:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4D516605B1;
	Tue,  7 Jun 2022 15:03:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08452C0039;
	Tue,  7 Jun 2022 15:03:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57F97C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 15:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4672D40602
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 15:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r5KBTub5VN_H
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 15:03:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB01C40162
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=4jzHTv5Sc0MldAT+k988WZMZ/PcoJBlwM2totgWZy1o=; b=kAmWthY2O8UluBnxjle5Z4b8CR
 wMBrQhwOGev5bLR4SD2g4KFCVqn0rNm7UKcacjYNHOp4Zi9DN4hFNNpg/rdYnkQ2Bitnt2jS/8yep
 J4RQx8E76Apo84LVth+zXy/EGiNNhGntaPmOyPt7MAf32pEy9j0ya4oCKAyveSeAvj+/Bahjw/WS5
 PkxrMT8th9jzoXK8Ozl9TZiDmysXQUNCSiVKvMvkBzEn1CjwgpXgRMlrbmn3RA54WDQPV+9+5Dfdw
 DH8s3QnSLteEcLhDUV0m22q0hL+gDPGr4PGZVl9no1Krcd/RbUTmqDuxBUlxLXzpM46q69eZL4xIc
 YyTs3kwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyajP-00Bj6v-LJ; Tue, 07 Jun 2022 15:02:55 +0000
Date: Tue, 7 Jun 2022 16:02:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 14/20] hugetlb: Convert to migrate_folio
Message-ID: <Yp9on0GvbGbdN+cv@casper.infradead.org>
References: <20220606204050.2625949-15-willy@infradead.org>
 <202206071414.41wGG8fp-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202206071414.41wGG8fp-lkp@intel.com>
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

On Tue, Jun 07, 2022 at 02:13:26PM +0800, kernel test robot wrote:
>    fs/hugetlbfs/inode.c: In function 'hugetlbfs_migrate_folio':
> >> fs/hugetlbfs/inode.c:990:17: error: implicit declaration of function 'folio_migrate_copy' [-Werror=implicit-function-declaration]
>      990 |                 folio_migrate_copy(dst, src);
>          |                 ^~~~~~~~~~~~~~~~~~
> >> fs/hugetlbfs/inode.c:992:17: error: implicit declaration of function 'folio_migrate_flags'; did you mean 'folio_mapping_flags'? [-Werror=implicit-function-declaration]
>      992 |                 folio_migrate_flags(dst, src);
>          |                 ^~~~~~~~~~~~~~~~~~~
>          |                 folio_mapping_flags
>    cc1: some warnings being treated as errors

Thanks, fixed.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
