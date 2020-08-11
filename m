Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3354C433E0
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 02:21:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BDC2075D
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 02:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYz3tdpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BDC2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 694B685D56;
	Tue, 11 Aug 2020 02:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zGml4pUQPh7v; Tue, 11 Aug 2020 02:21:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D1ADE854A7;
	Tue, 11 Aug 2020 02:21:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B306EC013C;
	Tue, 11 Aug 2020 02:21:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B044C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 02:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5E568878A0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 02:21:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hB8c3ca0vP0d
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 02:21:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E29428789D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 02:21:19 +0000 (UTC)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net
 [73.231.172.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 376E1206DC;
 Tue, 11 Aug 2020 02:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597112479;
 bh=HU0RLG4moDfMRlsMhMfGS7F281kMpizylGvKs2qA890=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gYz3tdpYES59ro1cZ97vrJAQzeLwlHDeZOhKcJ7DNekx2+kaotF2mfR5AdLR5Iu8U
 /SMS6huxJx945h2reSvWrz6XAOXSKptdBVMxWPozVO9ku7jebtUdlRH9MItxgbZsFx
 TlgbS1AMQK/dXjzlQKfK9XLoYPgiOUrN9aumVyP8=
Date: Mon, 10 Aug 2020 19:21:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 0/6] mm / virtio-mem: support ZONE_MOVABLE
Message-Id: <20200810192118.34a33d64e357ce5dd6f7614d@linux-foundation.org>
In-Reply-To: <baaf5992-cf43-69c1-7257-a5aa0a470ab8@redhat.com>
References: <20200804194142.28279-1-david@redhat.com>
 <baaf5992-cf43-69c1-7257-a5aa0a470ab8@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Baoquan He <bhe@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Qian Cai <cai@lca.pw>, Mike Rapoport <rppt@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>
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

On Mon, 10 Aug 2020 09:56:32 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 04.08.20 21:41, David Hildenbrand wrote:
> > @Andrew can we give this a churn and consider it for v5.9 in case there
> > are no more comments?
> 
> @Andrew, Ping, so I assume we'll target v5.10?

Yep, sorry.  Merging a significant patch series during the merge
window(!) would be quite extraordinary and I don't think that anything
in this patchset justifies such an action?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
