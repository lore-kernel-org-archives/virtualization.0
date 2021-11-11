Return-Path: <SRS0=fJjx=P6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522EDC433EF
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 13:39:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D437760E54
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 13:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D437760E54
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9570680DA0;
	Thu, 11 Nov 2021 13:39:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YqRCyuJZ_9Qz; Thu, 11 Nov 2021 13:39:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 55A8E80D60;
	Thu, 11 Nov 2021 13:39:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 190F1C0020;
	Thu, 11 Nov 2021 13:39:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54BB1C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 13:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F30D404FE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 13:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0yIBk-5rCHpV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 13:39:21 +0000 (UTC)
X-Greylist: delayed 07:00:01 by SQLgrey-1.8.0
Received: from smtprelay.hostedemail.com (smtprelay0093.hostedemail.com
 [216.40.44.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D749401D6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 13:39:20 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 37867184F4E94
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 05:20:03 +0000 (UTC)
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id 8B8FC101EABB1;
 Thu, 11 Nov 2021 05:20:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf18.hostedemail.com (Postfix) with ESMTPA id 1C9ADC0002F4; 
 Thu, 11 Nov 2021 05:19:53 +0000 (UTC)
Message-ID: <d7f3fec79287a149d6edc828583a771c84646b42.camel@perches.com>
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Mark VMware mailing list entries as
 email aliases
From: Joe Perches <joe@perches.com>
To: Jakub Kicinski <kuba@kernel.org>, "Srivatsa S. Bhat"
 <srivatsa@csail.mit.edu>
Date: Wed, 10 Nov 2021 21:19:53 -0800
In-Reply-To: <20211110173935.45a9f495@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <163657479269.84207.13658789048079672839.stgit@srivatsa-dev>
 <163657493334.84207.11063282485812745766.stgit@srivatsa-dev>
 <20211110173935.45a9f495@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
X-Stat-Signature: ztcifz3jtb55m8w5484sjq3xynbqoduh
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1C9ADC0002F4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+SDIVTNx+3zME4BO7OMP/EAp4Y+zdx/2M=
X-HE-Tag: 1636607993-497590
Cc: Ronak Doshi <doshir@vmware.com>, pv-drivers@vmware.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Nadav Amit <namit@vmware.com>, amakhalov@vmware.com,
 linux-scsi@vger.kernel.org, Vishal Bhakta <vbhakta@vmware.com>, x86@kernel.org,
 linux-graphics-maintainer@vmware.com, linux-input@vger.kernel.org,
 rostedt@goodmis.org, keerthanak@vmware.com, jgross@suse.com, anishs@vmware.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Zack Rusin <zackr@vmware.com>
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

On Wed, 2021-11-10 at 17:39 -0800, Jakub Kicinski wrote:
> On Wed, 10 Nov 2021 12:09:06 -0800 Srivatsa S. Bhat wrote:
> >  DRM DRIVER FOR VMWARE VIRTUAL GPU
> > -M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
> >  M:	Zack Rusin <zackr@vmware.com>
> > +R:	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
> >  L:	dri-devel@lists.freedesktop.org
> >  S:	Supported
> >  T:	git git://anongit.freedesktop.org/drm/drm-misc
> 
> It'd be preferable for these corporate entries to be marked or
> otherwise distinguishable so that we can ignore them when we try 
> to purge MAINTAINERS from developers who stopped participating.
> 
> These addresses will never show up in a commit tag which is normally
> sign of inactivity.

Funny.

The link below is from over 5 years ago.

https://lore.kernel.org/lkml/1472081625.3746.217.camel@perches.com/

Almost all of those entries are still in MAINTAINERS.

I think the concept of purging is a non-issue.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
