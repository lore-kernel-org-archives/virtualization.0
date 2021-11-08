Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E01C433F5
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 11:23:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B326117A
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 11:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53B326117A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19C2E80BCC;
	Tue,  9 Nov 2021 11:23:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MYb8lkVbCmTj; Tue,  9 Nov 2021 11:23:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C1A1280B9F;
	Tue,  9 Nov 2021 11:23:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 915BBC0019;
	Tue,  9 Nov 2021 11:23:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA71BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 11:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7A284010A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 11:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9nHFuq0YfkvD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 11:23:38 +0000 (UTC)
X-Greylist: delayed 11:00:31 by SQLgrey-1.8.0
Received: from smtprelay.hostedemail.com (smtprelay0155.hostedemail.com
 [216.40.44.155])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E02C40105
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 11:23:38 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 1CC421848AB10
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 23:38:02 +0000 (UTC)
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5411F837F24F;
 Mon,  8 Nov 2021 23:37:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf01.hostedemail.com (Postfix) with ESMTPA id 7C9C917274; 
 Mon,  8 Nov 2021 23:37:54 +0000 (UTC)
Message-ID: <5179a7c097e0bb88f95642a394f53c53e64b66b1.camel@perches.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark VMware mailing list entries as
 private
From: Joe Perches <joe@perches.com>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, jgross@suse.com, 
 x86@kernel.org, pv-drivers@vmware.com
Date: Mon, 08 Nov 2021 15:37:53 -0800
In-Reply-To: <163640339370.62866.3435211389009241865.stgit@srivatsa-dev>
References: <163640336232.62866.489924062999332446.stgit@srivatsa-dev>
 <163640339370.62866.3435211389009241865.stgit@srivatsa-dev>
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
X-Stat-Signature: dabja5iyhi1f3u7sn4gaygkth6wafpyr
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 7C9C917274
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19XvMXBRYU1i3HvRZAoQGyZbMrqYURbOg0=
X-HE-Tag: 1636414674-345765
Cc: amakhalov@vmware.com, Ronak Doshi <doshir@vmware.com>,
 linux-scsi@vger.kernel.org, anishs@vmware.com,
 Vishal Bhakta <vbhakta@vmware.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, keerthanak@vmware.com,
 linux-rdma@vger.kernel.org, linux-graphics-maintainer@vmware.com,
 linux-input@vger.kernel.org, Nadav Amit <namit@vmware.com>,
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

On Mon, 2021-11-08 at 12:30 -0800, Srivatsa S. Bhat wrote:
> From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> 
> VMware mailing lists in the MAINTAINERS file are private lists meant
> for VMware-internal review/notification for patches to the respective
> subsystems. So, in an earlier discussion [1][2], it was recommended to
> mark them as such. Update all the remaining VMware mailing list
> references to use that format -- "L: list@address (private)".
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -6134,8 +6134,8 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	drivers/gpu/drm/vboxvideo/
>  
>  DRM DRIVER FOR VMWARE VIRTUAL GPU
> -M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
>  M:	Zack Rusin <zackr@vmware.com>
> +L:	linux-graphics-maintainer@vmware.com (private)

This MAINTAINERS file is for _public_ use, marking something
non-public isn't useful.

private makes no sense and likely these L: entries shouldn't exist.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
