Return-Path: <SRS0=bIcn=PX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F394DC433F5
	for <virtualization@archiver.kernel.org>; Thu,  4 Nov 2021 18:10:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D0D60EC0
	for <virtualization@archiver.kernel.org>; Thu,  4 Nov 2021 18:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92D0D60EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E906405DF;
	Thu,  4 Nov 2021 18:10:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vhn8V3cvRaEm; Thu,  4 Nov 2021 18:10:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 05772405DE;
	Thu,  4 Nov 2021 18:10:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE4ECC0019;
	Thu,  4 Nov 2021 18:10:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2995C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 18:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9DA22405DF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 18:10:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VDv_ofQKP1_D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 18:10:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E9626405DE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 18:10:30 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id t21so8593050plr.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Nov 2021 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7mdrEIaynFJhMAYVbY2RCFSQ3xBs/5manpadoyeA8Jg=;
 b=0YEcomScst+1AzYcEtB+P3/DmeUM77501UDi4utLMr5xdKJlnd8UevBd12j9FnZ3vM
 pfReEE9Mys+ZVEwliSTF7urxA8Wo0+Hi1QGvdNyLT71G18SgBjzWHXiXc01F/GMcT30o
 4sj59niVU83geSVU+jTxOcRmF241hREk19CsoBH8kxr2RQdc6rHN1RFVCxVTxuFK53C5
 ubx4NqJpME+C1zDILd+MfHjSjbqUFn2nDpjUaVUu+wM8te1yVWJyRStj28nUJ7WDbMUk
 H2RDjE1nkFNI+5JNwfhWiSHo+ZLBnVukougjDJ/S9PImKe7sfLSLlzrr4uAIBYjBE48z
 eouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7mdrEIaynFJhMAYVbY2RCFSQ3xBs/5manpadoyeA8Jg=;
 b=uj6D6xuGsq4PDxMJR/Yx/ryeVSfp7gK2cGx63kxmo+XcvEDwjzHAwK9tuYjUZ7Aq2k
 PajypDn+vzivO9xLYD3mgbaeIWYd5sj1UFieNDcBPN/ZQuQJioFUks/Me6DIDcg+TEqb
 dShaFD3DNutB8nc2iXvgXMxiyy7yd/AvPQgkMekoEM/catFUgJTVMhJOidhwfH4drd5e
 HOYCKFFU1c3hj3/OL20INFkdZfJb4PW8rg8xN+EQrgCqDR60jdG781uT2oRo2ZJjG5A3
 ZMr1yYLa4OA6bNbp9jxWh+l/joMGQz+XxljOMGc5Uh67ruuJskaaSu2glkl7CdRjwJUC
 Iyvw==
X-Gm-Message-State: AOAM532rETXmpBn4lIHHyZpfxannGQzsuT9RVObhV3ROgqXTB4IPWY9F
 WHt+Phj+POMo7bMlBMtCm7x0MGjIpfcRo+ehu6kB9w==
X-Google-Smtp-Source: ABdhPJxpE7179nYWnBAffbsem/btoh3olrocKEPy5McMuIBWtGLmZ02iwXqFLVvSNceMnE3VXVk1wLsDAvNCq2GAmrQ=
X-Received: by 2002:a17:902:b697:b0:141:c7aa:e10f with SMTP id
 c23-20020a170902b69700b00141c7aae10fmr33445935pls.18.1636049430346; Thu, 04
 Nov 2021 11:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net>
 <20211104081740.GA23111@lst.de> <20211104173417.GJ2237511@magnolia>
 <20211104173559.GB31740@lst.de>
In-Reply-To: <20211104173559.GB31740@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 4 Nov 2021 11:10:19 -0700
Message-ID: <CAPcyv4jbjc+XtX5RX5OL3vPadsYZwoK1NG1qC5AcpySBu5tL4g@mail.gmail.com>
Subject: Re: futher decouple DAX from block devices
To: Christoph Hellwig <hch@lst.de>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, linux-erofs@lists.ozlabs.org,
 Mike Snitzer <snitzer@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
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

On Thu, Nov 4, 2021 at 10:36 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Nov 04, 2021 at 10:34:17AM -0700, Darrick J. Wong wrote:
> > /me wonders, are block devices going away?  Will mkfs.xfs have to learn
> > how to talk to certain chardevs?  I guess jffs2 and others already do
> > that kind of thing... but I suppose I can wait for the real draft to
> > show up to ramble further. ;)
>
> Right now I've mostly been looking into the kernel side.  An no, I
> do not expect /dev/pmem* to go away as you'll still need it for a
> not DAX aware file system and/or application (such as mkfs initially).
>
> But yes, just pointing mkfs to the chardev should be doable with very
> little work.  We can point it to a regular file after all.

Note that I've avoided implementing read/write fops for dax devices
partly out of concern for not wanting to figure out shared-mmap vs
write coherence issues, but also because of a bet with Dave Hansen
that device-dax not grow features like what happened to hugetlbfs. So
it would seem mkfs would need to switch to mmap I/O, or bite the
bullet and implement read/write fops in the driver.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
