Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2156EC433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 08:20:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3D7242547;
	Mon, 13 Dec 2021 08:20:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0rEpH2jGaqdx; Mon, 13 Dec 2021 08:20:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 76A0942542;
	Mon, 13 Dec 2021 08:20:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50BC4C002F;
	Mon, 13 Dec 2021 08:20:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA78EC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA9FF60F0E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:20:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qaa6pU26LYGr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:20:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A67560EFE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:20:26 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 076BF68BFE; Mon, 13 Dec 2021 09:20:21 +0100 (CET)
Date: Mon, 13 Dec 2021 09:20:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 5/5] dax: always use _copy_mc_to_iter in dax_copy_to_iter
Message-ID: <20211213082020.GA21462@lst.de>
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-6-hch@lst.de> <YbNejVRF5NQB0r83@redhat.com>
 <CAPcyv4i_HdnMcq6MmDMt-a5p=ojh_vsoAiES0vUYEh7HvC1O-A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4i_HdnMcq6MmDMt-a5p=ojh_vsoAiES0vUYEh7HvC1O-A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Vishal Verma <vishal.l.verma@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 device-mapper development <dm-devel@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
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

So the conclusion here is that we should always use the mc safe variant?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
