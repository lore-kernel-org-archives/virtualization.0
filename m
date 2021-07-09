Return-Path: <SRS0=F8NL=MB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7BDC07E9C
	for <virtualization@archiver.kernel.org>; Fri,  9 Jul 2021 15:33:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BDD3613C3
	for <virtualization@archiver.kernel.org>; Fri,  9 Jul 2021 15:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDD3613C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D1AA6405FF;
	Fri,  9 Jul 2021 15:33:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qNI5__Xmp1Pr; Fri,  9 Jul 2021 15:33:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6B3A4401CA;
	Fri,  9 Jul 2021 15:33:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39E85C001A;
	Fri,  9 Jul 2021 15:33:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C1D0C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 15:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4FB8C6FCAD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 15:33:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SfAW78znuajN
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 15:33:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F2176FCAC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=y7YLHiF0t+l7CAiXRoEvkaZFeIRtHz06yPRep3Kg/LM=; b=cBaSGviwrp/QKpIQbEzA+mZFQt
 gwNGWcl04gu8kPnL199xu/bBhXuhbNZRbCFyLnnY6WTYlGlXWVhJu0+MXdkdYFiI/6yYbV3bl32s0
 JWG9A0CdPvNcpYS1YUnAv8QgA/UymEqfFn8bzWbKCHXwaWKUDNvPXQ16pM55my0DJt0ntdPFILt4E
 uN2RM+XpsviEXdDjdC1SiPe1jN9t9R/U9mYpIViX4Ug97nhwdepiGqHj5+kYfhd7C7tMCdpr1/Ae2
 JmCWzLhVPcTns+75Q1+sGe6vZFgLsSZR8BPvVXWz3N6IghXCyUFWCizmSgFMHhPnolCcE43NaSgk5
 Rn3Q10SQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m1sUi-00EdZV-PT; Fri, 09 Jul 2021 15:32:50 +0000
Date: Fri, 9 Jul 2021 16:32:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wei Liu <wei.liu@kernel.org>
Subject: Re: [RFC v1 7/8] mshv: implement in-kernel device framework
Message-ID: <YOhsIDccgbUCzwqt@casper.infradead.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-8-wei.liu@kernel.org>
 <YOhIzJVPN9SwoRK0@casper.infradead.org>
 <20210709135013.t5axinjmufotpylf@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210709135013.t5axinjmufotpylf@liuwe-devbox-debian-v2>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, pasha.tatashin@soleen.com,
 Jonathan Corbet <corbet@lwn.net>, kumarpraveen@linux.microsoft.com,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Muminul Islam <muislam@microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Lillian Grassin-Drake <ligrassi@microsoft.com>
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

On Fri, Jul 09, 2021 at 01:50:13PM +0000, Wei Liu wrote:
> On Fri, Jul 09, 2021 at 02:02:04PM +0100, Matthew Wilcox wrote:
> > On Fri, Jul 09, 2021 at 11:43:38AM +0000, Wei Liu wrote:
> > > +static long
> > > +mshv_partition_ioctl_create_device(struct mshv_partition *partition,
> > > +	void __user *user_args)
> > > +{
> > [...]
> > > +	mshv_partition_get(partition);
> > > +	r = anon_inode_getfd(ops->name, &mshv_device_fops, dev, O_RDWR | O_CLOEXEC);
> > > +	if (r < 0) {
> > > +		mshv_partition_put_no_destroy(partition);
> > > +		list_del(&dev->partition_node);
> > > +		ops->destroy(dev);
> > > +		goto out;
> > > +	}
> > > +
> > > +	cd->fd = r;
> > > +	r = 0;
> > 
> > Why return the fd in memory instead of returning the fd as the return
> > value from the ioctl?
> > 
> > > +	if (copy_to_user(user_args, &tmp, sizeof(tmp))) {
> > > +		r = -EFAULT;
> > > +		goto out;
> > > +	}
> > 
> > ... this could then disappear.
> 
> Thanks for your comment, Matthew.
> 
> This is intentionally because I didn't want to deviate from KVM's API.
> The fewer differences the better.

Then don't define your own structure.  Use theirs.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
