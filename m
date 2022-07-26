Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABCBC00140
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 16:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 269B284742;
	Tue, 26 Jul 2022 16:36:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 269B284742
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Bje-2XDIzrd; Tue, 26 Jul 2022 16:36:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 962CA8316F;
	Tue, 26 Jul 2022 16:36:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 962CA8316F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B0ACC0035;
	Tue, 26 Jul 2022 16:36:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B1DFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 16:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7523E83FBE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 16:36:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7523E83FBE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9VvH_5z9kPzn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 16:36:47 +0000 (UTC)
X-Greylist: delayed 00:10:02 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8EAE98316F
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com
 [216.40.44.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8EAE98316F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 16:36:47 +0000 (UTC)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay01.hostedemail.com (Postfix) with ESMTP id B17811C63C5;
 Tue, 26 Jul 2022 16:18:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf09.hostedemail.com (Postfix) with ESMTPA id 3D0AA20024; 
 Tue, 26 Jul 2022 16:18:16 +0000 (UTC)
Message-ID: <1c536f8e9666725ce9f3eb97acc34d08f38d2095.camel@perches.com>
Subject: Re: [PATCH] VMCI: Update maintainers for VMCI
From: Joe Perches <joe@perches.com>
To: Vishnu Dasa <vdasa@vmware.com>, Greg KH <gregkh@linuxfoundation.org>, 
 "rajeshjalisatgi@gmail.com" <rajeshjalisatgi@gmail.com>
Date: Tue, 26 Jul 2022 09:18:15 -0700
In-Reply-To: <47D07B41-C327-4908-A383-683FC6C67040@vmware.com>
References: <20220725163246.38486-1-vdasa@vmware.com>
 <Yt7bfyANrfdPxdS8@kroah.com>
 <FD326388-D2BB-42B4-B217-89DB9C134866@vmware.com>
 <YuAD90UfLnf1Ojso@kroah.com>
 <47D07B41-C327-4908-A383-683FC6C67040@vmware.com>
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: 4ogh8f9z7ycintqz6pitj7rkzrkyccbw
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 3D0AA20024
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19NAXR081PqcA4zDQC4b0ZscieEdEbqVDI=
X-HE-Tag: 1658852296-201436
Cc: Pv-drivers <Pv-drivers@vmware.com>, Bryan Tan <bryantan@vmware.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Tue, 2022-07-26 at 15:55 +0000, Vishnu Dasa wrote:
> > On Jul 26, 2022, at 8:10 AM, Greg KH <gregkh@linuxfoundation.org wrote:
> > On Mon, Jul 25, 2022 at 06:29:25PM +0000, Vishnu Dasa wrote:
> > > > On Jul 25, 2022, at 11:05 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > On Mon, Jul 25, 2022 at 09:32:46AM -0700, vdasa@vmware.com wrote:
> > > > > From: Vishnu Dasa <vdasa@vmware.com>
> > > > > Remove Rajesh as a maintainer for the VMCI driver.
> > > > Why?
> > > Rajesh is no longer with VMware and won't be working on VMCI.
> > 
> > But employment does not matter for maintainership and has nothing to do
> > with it.  Maintainership follows the person, not the company, you all
> > know this.
> > 
> > So for obvious reasons, I can't take this type of change without
> > Rajesh acking it.
> 
> I understand.  After getting in touch with Rajesh, cc'ing him via his
> personal email ID.
> 
> Rajesh, could you please provide your ack if you agree with this patch to
> remove you as the maintainer for VMCI?

If being an employee of a company is a criteria for maintainership
of this subsystem, likely the subsystem entry should be:

"S:	Supported" not "S:	Maintained"

MAINTAINERS:VMWARE VMCI DRIVER
MAINTAINERS-M:  Bryan Tan <bryantan@vmware.com>
MAINTAINERS-M:  Rajesh Jalisatgi <rjalisatgi@vmware.com>
MAINTAINERS-M:  Vishnu Dasa <vdasa@vmware.com>
MAINTAINERS-R:  VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
MAINTAINERS-L:  linux-kernel@vger.kernel.org
MAINTAINERS-S:  Maintained

Likely that's true for every VMware entry.

MAINTAINERS:VMWARE BALLOON DRIVER
MAINTAINERS-M:  Nadav Amit <namit@vmware.com>
MAINTAINERS-R:  VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
MAINTAINERS-L:  linux-kernel@vger.kernel.org
MAINTAINERS-S:  Maintained
MAINTAINERS-F:  drivers/misc/vmw_balloon.c
MAINTAINERS-
MAINTAINERS:VMWARE PVRDMA DRIVER
MAINTAINERS-M:  Bryan Tan <bryantan@vmware.com>
MAINTAINERS-M:  Vishnu Dasa <vdasa@vmware.com>
MAINTAINERS-R:  VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
MAINTAINERS-L:  linux-rdma@vger.kernel.org
MAINTAINERS-S:  Maintained
MAINTAINERS-F:  drivers/infiniband/hw/vmw_pvrdma/
MAINTAINERS-
MAINTAINERS-VMware PVSCSI driver
MAINTAINERS-M:  Vishal Bhakta <vbhakta@vmware.com>
MAINTAINERS-R:  VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
MAINTAINERS-L:  linux-scsi@vger.kernel.org
MAINTAINERS-S:  Maintained
MAINTAINERS-F:  drivers/scsi/vmw_pvscsi.c
MAINTAINERS-F:  drivers/scsi/vmw_pvscsi.h
MAINTAINERS-
MAINTAINERS:VMWARE VMMOUSE SUBDRIVER
MAINTAINERS-M:  Zack Rusin <zackr@vmware.com>
MAINTAINERS-R:  VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
MAINTAINERS-R:  VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
MAINTAINERS-L:  linux-input@vger.kernel.org
MAINTAINERS-S:  Maintained
MAINTAINERS-F:  drivers/input/mouse/vmmouse.c
MAINTAINERS-F:  drivers/input/mouse/vmmouse.h
MAINTAINERS-
MAINTAINERS:VMWARE VMXNET3 ETHERNET DRIVER
MAINTAINERS-M:  Ronak Doshi <doshir@vmware.com>
MAINTAINERS-R:  VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
MAINTAINERS-L:  netdev@vger.kernel.org
MAINTAINERS-S:  Maintained
MAINTAINERS-F:  drivers/net/vmxnet3/
MAINTAINERS-

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
