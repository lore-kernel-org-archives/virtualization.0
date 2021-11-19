Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3033BC433EF
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 17:21:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0D161A79
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 17:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC0D161A79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 899AA400F3;
	Fri, 19 Nov 2021 17:21:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4USbbb4KU4eY; Fri, 19 Nov 2021 17:21:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DFD2D400DA;
	Fri, 19 Nov 2021 17:21:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFF94C002E;
	Fri, 19 Nov 2021 17:21:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8F80C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 17:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5DE0828DF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 17:21:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tDGn2YgGMIx4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 17:21:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC142828B5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 17:21:20 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id m24so8617496pls.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 09:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2U/4HYKnAZR7qNMIeDCg5S//595luEluzFk14uv4gBU=;
 b=FQ6M7eMMvPf80QsdTpoBZi0VrX8bn7QeX7OvbRABdgkNvCMNjXzl7/FKjSfSUjRkzX
 F1usfPnFQYNtajLRg0QRwSSgzt8mzXj0XCG2cnk0+F0m/6Zhw3KmrGwYuAHqWjDxU8h7
 LoqDBYl4kQUeXb8kAZzT8ViJ+hkv5vLV1Goy6Yaluym7CVIoftX3Jldatma/nAYXl27p
 pclrbJHG5C0Blu/232w4rLGJUG53x/PsyFdu4/UMHnSQZ8XMlr5FFqwE0la2E0Wy9pBi
 QLaClBcQjJDmbuAEv+kCOvcY8AEg2J0pE5d377NWsFamWj8v0zJjbYMN2j8PjhK8WH2h
 Pe+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2U/4HYKnAZR7qNMIeDCg5S//595luEluzFk14uv4gBU=;
 b=Vk3o0FX2k02/STs2zrPW9HZoWm10mWyUGcvE9nZnb8aGDbf1jgdf8Ao5++5eDxULkZ
 l3RPh5V+Kr3h5aDZRgOGWeEy81SN6RJIwzbY/4WO1g2UY5h8X0unie2EoQoxu2F0VVQC
 ZrzWgk3WCnzZTL1s4j6gA5st50Z/F4OPZqVCVvzsuDNapc6g01bhgQvZHdlrfzezlZ/q
 /wRo5N/+jhskpiLQw8KGmsSsCReZQCX1iP+2/V1k7pH5lh2dbpHub1O1AkLdOoPy7SAu
 Je8aSfSo5AD2d4PUOJ7a9z3poahv1w4A5/6cLXY1LBkjhcVxx13qkZuAkiaTE147PDSA
 gAzg==
X-Gm-Message-State: AOAM530GpdtqUofq+kIaQDdvhkiX1979eMyBjCOiYtH5Mgx5ZocLLVU9
 5xetDb7VizfhlKTw2yjtJCPZbRlYD9G0SlrSbxXZKA==
X-Google-Smtp-Source: ABdhPJxOTsb7kpZ1mbQBZyHvrw/GjkoPNdlC1Mnmi7QTa5v33P77eZ447VYbGdz8Hsj3aBiYzZhGTejFWOktm98P3BA=
X-Received: by 2002:a17:90b:1e49:: with SMTP id
 pi9mr1505670pjb.220.1637342480174; 
 Fri, 19 Nov 2021 09:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-2-hch@lst.de>
 <CAPcyv4ijKTcABMs2tZEuPWo1WDOux+4XWN=DNF5v8SrQRSbfDg@mail.gmail.com>
 <20211119065645.GB15524@lst.de>
In-Reply-To: <20211119065645.GB15524@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 19 Nov 2021 09:21:09 -0800
Message-ID: <CAPcyv4iFG0n-vdaEi4h5ken6mPrgW6Kz6UXCTRfaHi-c99GBnw@mail.gmail.com>
Subject: Re: [PATCH 01/29] nvdimm/pmem: move dax_attribute_group from dax to
 pmem
To: Christoph Hellwig <hch@lst.de>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
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

On Thu, Nov 18, 2021 at 10:56 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Nov 17, 2021 at 09:44:25AM -0800, Dan Williams wrote:
> > On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > dax_attribute_group is only used by the pmem driver, and can avoid the
> > > completely pointless lookup by the disk name if moved there.  This
> > > leaves just a single caller of dax_get_by_host, so move dax_get_by_host
> > > into the same ifdef block as that caller.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Link: https://lore.kernel.org/r/20210922173431.2454024-3-hch@lst.de
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > This one already made v5.16-rc1.
>
> Yes, but 5.16-rc1 did not exist yet when I pointed the series.
>
> Note that the series also has a conflict against 5.16-rc1 in pmem.c,
> and buildbot pointed out the file systems need explicit dax.h
> includes in a few files for some configurations.
>
> The current branch is here, I just did not bother to repost without
> any comments:
>
>    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dax-block-cleanup
>
> no functional changes.

Do you just want to send me a pull request after you add all the acks?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
