Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04632C38142
	for <virtualization@archiver.kernel.org>; Tue, 24 Jan 2023 06:29:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78C6B60BFF;
	Tue, 24 Jan 2023 06:29:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78C6B60BFF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Y1N1Bp85
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gZ3j7eQOgRys; Tue, 24 Jan 2023 06:29:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 89BE360A69;
	Tue, 24 Jan 2023 06:29:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89BE360A69
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56FE2C0032;
	Tue, 24 Jan 2023 06:29:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56F0AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 06:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E03D60BB0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 06:29:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E03D60BB0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HxD-2Qo6Surl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 06:29:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66C4360A69
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66C4360A69
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 06:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=4u7sdeygL2SI0vuOn3AQXqOOeojipj5nJ8JBXiSMSP4=; b=Y1N1Bp85zWT1Yc4mWO5RM/5swn
 z1s/ae7nZBU1XI2LeDBAOv+06U0Bu1PJWHXCDrEjlbbph1xr+oh6cmoXIod4hdcTSIhg05KsUMsH6
 Mt0SAUZbeNMdj95LikeyPio6/J/WyHzPQbupOE2KMJ+OXZv8xSLLdBNtO7Ot/A8dx2JalSA7ubKi2
 aFuBB1XW7qW1wiu2y2b/BJd4x/N6dLqevlGltWAruZGC7j2J5NPe6Xz6f5IgVH1uIF87LFk4mGzQ9
 1iI2DWcT8gQ30YpVU8YQ5BM2WIzRNm5oNr5lR1NU6lLpwGy0B15qzrZcjDOK9MRUi3zNGYFfM5749
 r4m38yZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1pKCny-002Vim-8c; Tue, 24 Jan 2023 06:29:14 +0000
Date: Mon, 23 Jan 2023 22:29:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alistair Popple <apopple@nvidia.com>
Subject: Re: [RFC PATCH 01/19] mm: Introduce vm_account
Message-ID: <Y896ugI8HoXDRjp3@infradead.org>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <748338ffe4c42d86669923159fe0426808ecb04d.1674538665.git-series.apopple@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <748338ffe4c42d86669923159fe0426808ecb04d.1674538665.git-series.apopple@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-kselftest@vger.kernel.org, rds-devel@oss.oracle.com, daniel@ffwll.ch,
 kvm@vger.kernel.org, linux-rdma@vger.kernel.org, jhubbard@nvidia.com,
 linux-fpga@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, mkoutny@suse.com, jgg@nvidia.com,
 hannes@cmpxchg.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
 surenb@google.com, tjmercier@google.com, io-uring@vger.kernel.org
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

> +/**
> + * vm_account_init - Initialise a new struct vm_account.
> + * @vm_account: pointer to uninitialised vm_account.
> + * @task: task to charge against.
> + * @user: user to charge against. Must be non-NULL for VM_ACCOUNT_USER.
> + * @flags: flags to use when charging to vm_account.
> + *
> + * Initialise a new uninitialiused struct vm_account. Takes references
> + * on the task/mm/user/cgroup as required although callers must ensure
> + * any references passed in remain valid for the duration of this
> + * call.
> + */
> +void vm_account_init(struct vm_account *vm_account, struct task_struct *task,
> +		struct user_struct *user, enum vm_account_flags flags);


kerneldoc comments are supposed to be next to the implementation, and
not the declaration in the header.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
