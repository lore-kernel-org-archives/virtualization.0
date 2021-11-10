Return-Path: <SRS0=RKVt=P5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AC1C4321E
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 17:17:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6408A61211
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 17:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6408A61211
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10B6760AE3;
	Wed, 10 Nov 2021 17:17:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D8tL_aPWbNgL; Wed, 10 Nov 2021 17:16:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 925BE6079D;
	Wed, 10 Nov 2021 17:16:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AEA2C0019;
	Wed, 10 Nov 2021 17:16:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 339ECC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 17:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B0EA4015B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 17:16:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VvLFTV8C4xgA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 17:16:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5C4A40063
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 17:16:55 +0000 (UTC)
Received: from [128.177.79.46] (helo=csail.mit.edu)
 by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.82) (envelope-from <srivatsa@csail.mit.edu>)
 id 1mkrDM-000Nx5-Kq; Wed, 10 Nov 2021 12:16:48 -0500
Date: Wed, 10 Nov 2021 09:20:00 -0800
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark VMware mailing list entries as
 private
Message-ID: <20211110172000.GA121926@csail.mit.edu>
References: <163640336232.62866.489924062999332446.stgit@srivatsa-dev>
 <163640339370.62866.3435211389009241865.stgit@srivatsa-dev>
 <5179a7c097e0bb88f95642a394f53c53e64b66b1.camel@perches.com>
 <cb03ca42-b777-3d1a-5aba-b01cd19efa9a@csail.mit.edu>
 <dcbd19fcd1625146f4db267f84abd7412513d20e.camel@perches.com>
 <5C24FB2A-D2C0-4D95-A0C0-B48C4B8D5AF4@vmware.com>
 <1875b0458294d23d8e3260d2824894b095d6a62d.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1875b0458294d23d8e3260d2824894b095d6a62d.camel@perches.com>
Cc: Ronak Doshi <doshir@vmware.com>, Pv-drivers <Pv-drivers@vmware.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Nadav Amit <namit@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Vishal Bhakta <vbhakta@vmware.com>, X86 ML <x86@kernel.org>,
 Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 Keerthana Kalyanasundaram <keerthanak@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Anish Swaminathan <anishs@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zack Rusin <zackr@vmware.com>
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

On Tue, Nov 09, 2021 at 01:57:31PM -0800, Joe Perches wrote:
> On Tue, 2021-11-09 at 00:58 +0000, Nadav Amit wrote:
> > > On Nov 8, 2021, at 4:37 PM, Joe Perches <joe@perches.com> wrote:
> > > On Mon, 2021-11-08 at 16:22 -0800, Srivatsa S. Bhat wrote:
> > > 
> > > So it's an exploder not an actual maintainer and it likely isn't
> > > publically archived with any normal list mechanism.
> > > 
> > > So IMO "private" isn't appropriate.  Neither is "L:"
> > > Perhaps just mark it as what it is as an "exploder".
> > > 
> > > Or maybe these blocks should be similar to:
> > > 
> > > M:	Name of Lead Developer <somebody@vmware.com>
> > > M:	VMware <foo> maintainers <linux-<foo>-maintainers@vmlinux.com>
> 
> Maybe adding entries like
> 
> M:	Named maintainer <whoever@vmware.com>
> R:	VMware <foo> reviewers <linux-<foo>-maintainers@vmware.com>
> 
> would be best/simplest.
> 

Sure, that sounds good to me. I also considered adding "(email alias)"
like Juergen suggested, but I think the R: entry is clear enough.
Please find the updated patch below.

---

From f66faa238facf504cfc66325912ce7af8cbf79ec Mon Sep 17 00:00:00 2001
From: "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>
Date: Mon, 8 Nov 2021 11:46:57 -0800
Subject: [PATCH v2 2/2] MAINTAINERS: Mark VMware mailing list entries as email
 aliases

VMware mailing lists in the MAINTAINERS file are private lists meant
for VMware-internal review/notification for patches to the respective
subsystems. Anyone can post to these addresses, but there is no public
read access like open mailing lists, which makes them more like email
aliases instead (to reach out to reviewers).

So update all the VMware mailing list references in the MAINTAINERS
file to mark them as such, using "R: email-alias@vmware.com".

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Cc: Zack Rusin <zackr@vmware.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Vivek Thampi <vithampi@vmware.com>
Cc: Vishal Bhakta <vbhakta@vmware.com>
Cc: Ronak Doshi <doshir@vmware.com>
Cc: pv-drivers@vmware.com
Cc: linux-graphics-maintainer@vmware.com
Cc: dri-devel@lists.freedesktop.org
Cc: linux-rdma@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-input@vger.kernel.org
---
 MAINTAINERS | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 118cf8170d02..4372d79027e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6134,8 +6134,8 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/vboxvideo/
 
 DRM DRIVER FOR VMWARE VIRTUAL GPU
-M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
 M:	Zack Rusin <zackr@vmware.com>
+R:	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -14189,7 +14189,7 @@ F:	include/uapi/linux/ppdev.h
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
 M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
-L:	pv-drivers@vmware.com (private)
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 L:	x86@kernel.org
 S:	Supported
@@ -20032,7 +20032,7 @@ F:	tools/testing/vsock/
 
 VMWARE BALLOON DRIVER
 M:	Nadav Amit <namit@vmware.com>
-M:	"VMware, Inc." <pv-drivers@vmware.com>
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/vmw_balloon.c
@@ -20040,7 +20040,7 @@ F:	drivers/misc/vmw_balloon.c
 VMWARE HYPERVISOR INTERFACE
 M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
 M:	Alexey Makhalov <amakhalov@vmware.com>
-L:	pv-drivers@vmware.com (private)
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 L:	x86@kernel.org
 S:	Supported
@@ -20050,14 +20050,14 @@ F:	arch/x86/kernel/cpu/vmware.c
 
 VMWARE PVRDMA DRIVER
 M:	Adit Ranadive <aditr@vmware.com>
-M:	VMware PV-Drivers <pv-drivers@vmware.com>
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
 F:	drivers/infiniband/hw/vmw_pvrdma/
 
 VMware PVSCSI driver
 M:	Vishal Bhakta <vbhakta@vmware.com>
-M:	VMware PV-Drivers <pv-drivers@vmware.com>
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/scsi/vmw_pvscsi.c
@@ -20065,7 +20065,7 @@ F:	drivers/scsi/vmw_pvscsi.h
 
 VMWARE VIRTUAL PTP CLOCK DRIVER
 M:	Vivek Thampi <vithampi@vmware.com>
-M:	"VMware, Inc." <pv-drivers@vmware.com>
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/ptp/ptp_vmw.c
@@ -20073,14 +20073,14 @@ F:	drivers/ptp/ptp_vmw.c
 VMWARE VMCI DRIVER
 M:	Jorgen Hansen <jhansen@vmware.com>
 M:	Vishnu Dasa <vdasa@vmware.com>
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	linux-kernel@vger.kernel.org
-L:	pv-drivers@vmware.com (private)
 S:	Maintained
 F:	drivers/misc/vmw_vmci/
 
 VMWARE VMMOUSE SUBDRIVER
-M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
-M:	"VMware, Inc." <pv-drivers@vmware.com>
+R:	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/input/mouse/vmmouse.c
@@ -20088,7 +20088,7 @@ F:	drivers/input/mouse/vmmouse.h
 
 VMWARE VMXNET3 ETHERNET DRIVER
 M:	Ronak Doshi <doshir@vmware.com>
-M:	pv-drivers@vmware.com
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/vmxnet3/
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
