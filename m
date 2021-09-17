Return-Path: <SRS0=2Qdu=OH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5028AC433EF
	for <virtualization@archiver.kernel.org>; Fri, 17 Sep 2021 06:02:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE20761130
	for <virtualization@archiver.kernel.org>; Fri, 17 Sep 2021 06:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE20761130
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8325E4020A;
	Fri, 17 Sep 2021 06:02:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6kzBlE7HWY-o; Fri, 17 Sep 2021 06:02:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DACB0400DB;
	Fri, 17 Sep 2021 06:02:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5C64C0011;
	Fri, 17 Sep 2021 06:02:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 048DAC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 06:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E157F83F1C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 06:02:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oVSgvloz87uP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 06:02:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5820683F10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 06:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=KAOT1QriVAB4eECc9vz5PA1mRndKDvWQNMUrIEYWTzY=; b=jCZORZklm63UqwMLJXpjQ2dudy
 DYOj986Ojkr/OVt9ajFXRE8UE3zvbrF2FnBbfnN2JiljfGCOl+cxXH07SwrL8oFywRMkUiVnDKg5x
 CoL+AHQMfH3sOyqhCz5sIKvyTSE4EGUMdPBzEjoRafaG8YssbtlAmPZMgMvyKetgiFMo8NvCRMe8c
 MqvV8YtiHzSGESvrBSad03r3TxJhYuDpE1UeJdpK4M3zdNx17K33n9YRHxYD1CRuKOv5emRrZFKeH
 xYYX/FC+qRm4F9rWKjvBDbm6Ul2KYDBWS4CaVGpEH7pkH3dCR05nP0Jf5ITd0eNywEnUxBzvq72cj
 VDAh08BQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mR6vL-00HYMi-IS; Fri, 17 Sep 2021 06:01:06 +0000
Date: Fri, 17 Sep 2021 07:00:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/8] fork: add helper to clone a process
Message-ID: <YUQvAy8HDh5oYyqn@infradead.org>
References: <20210916212051.6918-1-michael.christie@oracle.com>
 <20210916212051.6918-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916212051.6918-2-michael.christie@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 christian.brauner@ubuntu.com
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

On Thu, Sep 16, 2021 at 04:20:44PM -0500, Mike Christie wrote:
> The vhost layer has similar requirements as io_uring where its worker
> threads need to access the userspace thread's memory, want to inherit the
> parents's cgroups and namespaces, and be checked against the parent's
> RLIMITs. Right now, the vhost layer uses the kthread API which has
> kthread_use_mm for mem access, and those threads can use
> cgroup_attach_task_all for v1 cgroups, but there are no helpers for the
> other items.
> 
> This adds a helper to clone a process so we can inherit everything we
> want in one call. It's a more generic version of create_io_thread which
> will be used by the vhost layer and io_uring in later patches in this set.
> 
> This patch also exports __set_task_comm and wake_up_new_task which is
> needed by modules to use the new helper. io_uring calls these functions
> already but its always built into the kernel so was not needed before.

Can you build proper APIs please?  e.g. the set_task_comm users
generally want a printf-like varargs caling conventions.  I'd also
much prefer to hide as much as possible in the actual helper.  That is
build a helper that gets the name, a flag to ignore the singals etc
instead of exporting all these random low-level helpers.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
