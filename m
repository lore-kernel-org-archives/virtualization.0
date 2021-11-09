Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA91FC433F5
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 00:23:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885A96109D
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 00:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 885A96109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4A53240134;
	Tue,  9 Nov 2021 00:23:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0-ojqAySoFwA; Tue,  9 Nov 2021 00:23:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 82173400E4;
	Tue,  9 Nov 2021 00:23:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32E3DC0019;
	Tue,  9 Nov 2021 00:23:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AED0C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 00:23:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19527605FA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 00:23:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dFsVXVnL7gVA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 00:23:08 +0000 (UTC)
X-Greylist: delayed 00:39:30 by SQLgrey-1.8.0
Received: from smtprelay.hostedemail.com (smtprelay0079.hostedemail.com
 [216.40.44.79])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69AB8605CC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 00:23:08 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 603BE1849A3A9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 00:23:06 +0000 (UTC)
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id C9939180F5D2D;
 Tue,  9 Nov 2021 00:23:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf19.hostedemail.com (Postfix) with ESMTPA id 1A5E920D751; 
 Tue,  9 Nov 2021 00:22:57 +0000 (UTC)
Message-ID: <7f193b68b8eb7ee69e6beb5b93c6dba7475359d3.camel@perches.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark VMware mailing list entries as
 private
From: Joe Perches <joe@perches.com>
To: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 08 Nov 2021 16:22:57 -0800
In-Reply-To: <20211108161631.2941f3a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <163640336232.62866.489924062999332446.stgit@srivatsa-dev>
 <163640339370.62866.3435211389009241865.stgit@srivatsa-dev>
 <5179a7c097e0bb88f95642a394f53c53e64b66b1.camel@perches.com>
 <20211108161631.2941f3a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
X-Stat-Signature: tojmtwftm96reeo3xe8hqq3d5x9nkse7
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1A5E920D751
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19aZonmr5dJiZ7OOfE72tvE17w95gAp7eE=
X-HE-Tag: 1636417377-505114
Cc: Ronak Doshi <doshir@vmware.com>, pv-drivers@vmware.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Nadav Amit <namit@vmware.com>, amakhalov@vmware.com,
 linux-scsi@vger.kernel.org, Vishal Bhakta <vbhakta@vmware.com>, x86@kernel.org,
 linux-graphics-maintainer@vmware.com, linux-input@vger.kernel.org,
 keerthanak@vmware.com, jgross@suse.com, anishs@vmware.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Zack Rusin <zackr@vmware.com>
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

On Mon, 2021-11-08 at 16:16 -0800, Jakub Kicinski wrote:
> On Mon, 08 Nov 2021 15:37:53 -0800 Joe Perches wrote:
> > > @@ -6134,8 +6134,8 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
> > >  F:	drivers/gpu/drm/vboxvideo/
> > >  
> > >  DRM DRIVER FOR VMWARE VIRTUAL GPU
> > > -M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
> > >  M:	Zack Rusin <zackr@vmware.com>
> > > +L:	linux-graphics-maintainer@vmware.com (private)  
> > 
> > This MAINTAINERS file is for _public_ use, marking something
> > non-public isn't useful.
> 
> But Greg has a point. Corporations like to send us code with a list 
> as the maintainer and MODULE_AUTHOR set to corp's name. We deal with
> humans, not legal entities.

MAINTAINERS is used not for corporations private use but
to find out _who_ to send and cc patches and defect reports.

A "private" email address used only for corporate internal review
cannot receive patches.

> I've been trying to get them to use "M: email" without the name,
> but "L: list (private)" also works.
> 
> Either way I feel like we need _some_ way to tell humans from corporate
> "please CC this address" entries.

This is not the way AFAIKT.

> > private makes no sense and likely these L: entries shouldn't exist.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
