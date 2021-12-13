Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA182C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 08:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8845D401D6;
	Mon, 13 Dec 2021 08:27:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fStXlzuNI0l9; Mon, 13 Dec 2021 08:27:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DC4D74011D;
	Mon, 13 Dec 2021 08:27:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAEE2C002F;
	Mon, 13 Dec 2021 08:27:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51E11C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35A2A401D6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:27:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ln71CwhR3taj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:27:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 789454011D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:27:19 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8C12868BFE; Mon, 13 Dec 2021 09:27:15 +0100 (CET)
Date: Mon, 13 Dec 2021 09:27:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/5] uio: remove copy_from_iter_flushcache() and
 copy_mc_to_iter()
Message-ID: <20211213082715.GD21462@lst.de>
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-2-hch@lst.de>
 <CAPcyv4gwfVi389e+cES=E6O13+y36OffZPCe+iZguCT_gpjmZA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gwfVi389e+cES=E6O13+y36OffZPCe+iZguCT_gpjmZA@mail.gmail.com>
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

On Sun, Dec 12, 2021 at 06:22:20AM -0800, Dan Williams wrote:
> > - * Use the 'no check' versions of copy_from_iter_flushcache() and
> > - * copy_mc_to_iter() to bypass HARDENED_USERCOPY overhead. Bounds
> > + * Use the 'no check' versions of _copy_from_iter_flushcache() and
> > + * _copy_mc_to_iter() to bypass HARDENED_USERCOPY overhead. Bounds
> >   * checking, both file offset and device offset, is handled by
> >   * dax_iomap_actor()
> >   */
> 
> This comment change does not make sense since it is saying why pmem is
> using the "_" versions. However, I assume this whole comment goes away
> in a later patch.

It does not go away in this series.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
