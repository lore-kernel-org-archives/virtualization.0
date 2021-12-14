Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5037EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 13:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D52CD40641;
	Tue, 14 Dec 2021 13:59:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eA0aJZOomKZS; Tue, 14 Dec 2021 13:59:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9540E402E9;
	Tue, 14 Dec 2021 13:59:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 678D7C002F;
	Tue, 14 Dec 2021 13:59:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E769FC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 13:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC16940146
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 13:59:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kLXafbuZvnJy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 13:59:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1DFC3400DA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 13:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639490347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m/5pRcl9h3yj8MAkqvRPCHvPcL0c1vkmrKvq7UUnKBk=;
 b=R3Pf0BtheeKCR+6DQSyWJYaEe4fbm54u+afSsZqD8yWyWP0PptSLbc90j0aBv1rbRkpBqr
 fV+lHDJzyENjvDJoW5BjuykfC4VW1hTtJSHQl7dI9bnRCxTQzh2kPA0eTkNaZPAN+Id1Oa
 0pDAhTOYKzR3UlEmF7pQyMadKJzDpUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-0kDh8FCsOqi2t6NYQJXz-g-1; Tue, 14 Dec 2021 08:59:04 -0500
X-MC-Unique: 0kDh8FCsOqi2t6NYQJXz-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA20F1966320;
 Tue, 14 Dec 2021 13:59:01 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25B375BE02;
 Tue, 14 Dec 2021 13:59:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id A5F242233DF; Tue, 14 Dec 2021 08:59:00 -0500 (EST)
Date: Tue, 14 Dec 2021 08:59:00 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 5/5] dax: always use _copy_mc_to_iter in dax_copy_to_iter
Message-ID: <YbijJOjhLAwvyNag@redhat.com>
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-6-hch@lst.de> <YbNejVRF5NQB0r83@redhat.com>
 <CAPcyv4i_HdnMcq6MmDMt-a5p=ojh_vsoAiES0vUYEh7HvC1O-A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4i_HdnMcq6MmDMt-a5p=ojh_vsoAiES0vUYEh7HvC1O-A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Vishal Verma <vishal.l.verma@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 device-mapper development <dm-devel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>
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

On Sun, Dec 12, 2021 at 06:48:05AM -0800, Dan Williams wrote:
> On Fri, Dec 10, 2021 at 6:05 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Thu, Dec 09, 2021 at 07:38:28AM +0100, Christoph Hellwig wrote:
> > > While using the MC-safe copy routines is rather pointless on a virtual device
> > > like virtiofs,
> >
> > I was wondering about that. Is it completely pointless.
> >
> > Typically we are just mapping host page cache into qemu address space.
> > That shows as virtiofs device pfn in guest and that pfn is mapped into
> > guest application address space in mmap() call.
> >
> > Given on host its DRAM, so I would not expect machine check on load side
> > so there was no need to use machine check safe variant.
> 
> That's a broken assumption, DRAM experiences multi-bit ECC errors.
> Machine checks, data aborts, etc existed before PMEM.

So we should use MC safe variant when loading from DRAM as well?
(If needed platoform support is there).

Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
