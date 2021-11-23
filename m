Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775DAC433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 05:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1B1660610;
	Tue, 23 Nov 2021 05:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gtTqdgGN-c3r; Tue, 23 Nov 2021 05:56:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A5BF3605D7;
	Tue, 23 Nov 2021 05:56:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DD66C002E;
	Tue, 23 Nov 2021 05:56:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 797C9C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 05:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5312740103
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 05:56:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Of2lUC9jgD4a
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 05:56:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8067D400F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 05:56:21 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 97B5168AFE; Tue, 23 Nov 2021 06:56:16 +0100 (CET)
Date: Tue, 23 Nov 2021 06:56:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 02/29] dm: make the DAX support dependend on CONFIG_FS_DAX
Message-ID: <20211123055616.GA13711@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-3-hch@lst.de>
 <CAPcyv4iPOcD8OsimpSZMnbTEsGZKj-GqSY=cWC0tPvoVs6DE1Q@mail.gmail.com>
 <20211119065457.GA15524@lst.de>
 <CAPcyv4iDujo8ZZp=8xNEhB3u6Vyc6nzq_THGiGRON7x3oi9enw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4iDujo8ZZp=8xNEhB3u6Vyc6nzq_THGiGRON7x3oi9enw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>
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

On Mon, Nov 22, 2021 at 06:54:09PM -0800, Dan Williams wrote:
> On Thu, Nov 18, 2021 at 10:55 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Nov 17, 2021 at 09:23:44AM -0800, Dan Williams wrote:
> > > Applied, fixed the spelling of 'dependent' in the subject and picked
> > > up Mike's Ack from the previous send:
> > >
> > > https://lore.kernel.org/r/YYASBVuorCedsnRL@redhat.com
> > >
> > > Christoph, any particular reason you did not pick up the tags from the
> > > last posting?
> >
> > I thought I did, but apparently I've missed some.
> 
> I'll reply with the ones I see missing that need carrying over and add
> my own reviewed-by then you can send me a pull request when ready,
> deal?

Ok.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
