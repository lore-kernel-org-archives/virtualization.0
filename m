Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C1BC19F2D
	for <virtualization@archiver.kernel.org>; Sun, 14 Aug 2022 00:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B5E2040A03;
	Sun, 14 Aug 2022 00:51:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5E2040A03
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=anarazel.de header.i=@anarazel.de header.a=rsa-sha256 header.s=fm1 header.b=W+DbT8Qm;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=3yzg4h3K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id taAkWPu-gg9a; Sun, 14 Aug 2022 00:51:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BAE584014A;
	Sun, 14 Aug 2022 00:50:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BAE584014A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D16EC0032;
	Sun, 14 Aug 2022 00:50:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94059C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 00:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 664E44038B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 00:50:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 664E44038B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a64y7mjDwj7r
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 00:50:57 +0000 (UTC)
X-Greylist: delayed 00:05:26 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2578E4014A
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2578E4014A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 00:50:56 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 736E05C008D;
 Sat, 13 Aug 2022 20:45:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Sat, 13 Aug 2022 20:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
 cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1660437926; x=1660524326; bh=LZE86b7pgO
 EV6yQAAb+JKCUE6gnvsPZRicgidvKJV1M=; b=W+DbT8QmMszRifT+yOaN3gr5E+
 8roWSxmQ0CjGC1ozPfy6CbCZzBqYqWBikLjgYl5vjOnH/d7Q25FLF3ZYgefrn5cn
 qBNetlzTGk4frx8oM2oV5pZvDOkSRl7hWDQLnSHqRSZ9Yl4B0SZh6yGqZpkNAiFm
 g+q9zKrjn2IEXPzNtQ5ZuylGAzPuGAjKnI2Exs8avAMyNmy1UBRK8yDGEo6hHdSV
 CNhYpPphN3EZ93eQQC2A3L/QW0R8JnyKS88Am9Ya5FL/XLeHOWy1VgBgYvfzdN0N
 FwzzSNpKvuWfyZUTbObmgWpyXe2Gsnzg4oQfMrYRYNfx53lhhe6qZJ5UMX5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1660437926; x=1660524326; bh=LZE86b7pgOEV6yQAAb+JKCUE6gnv
 sPZRicgidvKJV1M=; b=3yzg4h3KPcC8jbYF6KrfbEBTG6moadujKMRfuaFGEDmq
 uAcXG4IQYXkNGNpE29Vnu/ZxxwUxQXy/N7i1DpWtVMs1K5+GikWD6P3WRswGJrX1
 506ZU5StcSM6N7TQ+YZtN7OkYa+fFBxGrCfzi9z25yt2rj7pRerVhZ7xZKeaC0pN
 ooxA2HoxOEYK3Y6RMOau94EZqQJKX3u2r9K9/qH+S6oCJfS8eULqNh03C9jDPOPy
 Z4Adjg8Q2RCnC61YYJCUXnFSJwNhQS9Uc6i37wn6jjyIAcIbjuvUZpy3409v9Orz
 S5Y9dMHDohoPQmw2lUmywfPZSwkq6ZW60V+4VvuFZw==
X-ME-Sender: <xms:pEX4Ynd3hY3Gs4nBsOefKPEdxODfCHBCBjzimQGCpHx7RtLOXcRd0A>
 <xme:pEX4YtPj0sb3yjKqdie_P62fK5r3hyxhDfMBtmopoDao090aBt6ybZ_D1M98KdVPJ
 wfgsxlzpZUPQvhVDw>
X-ME-Received: <xmr:pEX4YgjrXhhNPo_CiQg5tIZdsRLuqMroPo5zixWyzVBEN9i-M_sDRYKOgOPvZ0napvC7LS-ZEJ1UlsbnHKC_E-JCxT9ecSfRJkxTUhaajZoa5FRb4Vbix9etuzJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegledgfeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
 vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
 grthhtvghrnhepveejheejhfehheelffeivdejhfdvfeeihffgheelffdthffhhfdthfel
 tdeugfeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpd
 hfrhgvvgguvghskhhtohhprdhorhhgpdhishgtrdhorhhgnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigvlh
 druggv
X-ME-Proxy: <xmx:pEX4Yo-u1ofsDJFiukWWpx8SNV61_JegTuoteobS1qrobaa-QAxo7g>
 <xmx:pEX4YjuRVOGj3cdS-acmTRbusWjrHtzNoO9k-R_uTupN_a9NktCn4A>
 <xmx:pEX4YnF0x3h7SAPGTRqogYkqBQdrVAesedEMSaTfrvFoaZmFBICc7Q>
 <xmx:pkX4Ypqx-QDQh5nLNGhjTY98akmtAZ3LRIU7hrYO_hSQn4eV-kouTQ>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Aug 2022 20:45:24 -0400 (EDT)
Date: Sat, 13 Aug 2022 17:45:22 -0700
From: Andres Freund <andres@anarazel.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [GIT PULL] virtio: fatures, fixes
Message-ID: <20220814004522.33ecrwkmol3uz7aq@awork3.anarazel.de>
References: <20220812114250-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220812114250-mutt-send-email-mst@kernel.org>
Cc: peng.fan@nxp.com, kvm@vger.kernel.org, alvaro.karsz@solid-run.com,
 virtualization@lists.linux-foundation.org, quic_mingxue@quicinc.com,
 syoshida@redhat.com, elic@nvidia.com, eperezma@redhat.com,
 jiaming@nfschina.com, hulkci@huawei.com, liubo03@inspur.com,
 dan.carpenter@oracle.com, kangjie.xu@linux.alibaba.com, robin.murphy@arm.com,
 hdegoede@redhat.com, pankaj.gupta@amd.com, gautam.dawar@xilinx.com,
 suwan.kim027@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xuqiang36@huawei.com, xieyongji@bytedance.com, colin.i.king@gmail.com,
 lingshan.zhu@intel.com, colin.king@intel.com,
 Linus Torvalds <torvalds@linux-foundation.org>
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

Hi,

On 2022-08-12 11:42:50 -0400, Michael S. Tsirkin wrote:
> The following changes since commit 3d7cb6b04c3f3115719235cc6866b10326de34cd:
> 
>   Linux 5.19 (2022-07-31 14:03:01 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 93e530d2a1c4c0fcce45e01ae6c5c6287a08d3e3:
> 
>   vdpa/mlx5: Fix possible uninitialized return value (2022-08-11 10:00:36 -0400)
> ----------------------------------------------------------------
> virtio: fatures, fixes
> 
> A huge patchset supporting vq resize using the
> new vq reset capability.
> Features, fixes, cleanups all over the place.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------

I have a script [1] that daily builds google cloud VM images with a fresh vanilla
kernel for postgres CI testing. The last successful image creation was
7ebfc85e2cd7b08f518b526173e9a33b56b3913b
and the first failing was
69dac8e431af26173ca0a1ebc87054e01c585bcc

Since then creating a new kernel boots but network does not come up.

Looking at the merges between those commit makes me suspect this merge:

69dac8e431af Merge tag 'riscv-for-linus-5.20-mw2' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
6c833c0581f1 Merge tag 'devicetree-fixes-for-6.0-1' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
3d076fec5a0c Merge tag 'rtc-6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
4a9350597aff Merge tag 'sound-fix-6.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
7a53e17accce Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
999324f58c41 Merge tag 'loongarch-5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson
f7cdaeeab8ca Merge tag 'for-v6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply
d16b418fac3d Merge tag 'vfio-v6.0-rc1pt2' of https://github.com/awilliam/linux-vfio
9801002f76c6 perf: riscv_pmu{,_sbi}: Miscallenous improvement & fixes
c3adefb5baf3 Merge tag 'for-6.0/dm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm
7ce2aa6d7fe1 Merge tag 'drm-next-2022-08-12-1' of git://anongit.freedesktop.org/drm/drm
7ab52f75a9cf RISC-V: Add Sstc extension support
36fa1cb56ac5 Merge tag 'drm-misc-next-fixes-2022-08-10' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
da06cc5bb600 RISC-V: fixups to work with crash tool
6de9eb21cd36 Merge 'irq/loongarch', 'pci/ctrl/loongson' and 'pci/header-cleanup-immutable'
3aefb2ee5bdd riscv: implement Zicbom-based CMO instructions + the t-head variant
8f2f74b4b6e6 RISC-V: Canaan devicetree fixes
f94ba7039fb4 Merge tag 'at91-reset-sama7g5-signed' into psy-next

all the drivers/net changes in that commit range were part of this pull
request.


excerpt from serial log for debian sid kernel (sorry for the interspersed logs):

Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 cloud-ifupdown-helper: Generated configuration for ens4
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 kern[  OK  ] Finished Raise network interfaces.
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 systemd[1]: Found device Virtio network device.
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 systemd[1]: Commit a transient machine-id on disk was skipped because of a failed condition check (ConditionPathIsMountPoint[  OK  ] Reached target Network.
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 systemd[1]: Started ifup for ens4.
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 kernel: [    0.354044] x86: [  OK  ] Reached target Network is Online.
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 dhclient[354]: Internet Systems Consortium DHCP Client 4.4.3
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 sh[354]: Internet Systems Consortium DHCP Client 4.4.3
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 sh[354]: Copyright 2004-2022 Internet Systems Consortium.
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 sh[354]: For info, please visit https://www.isc.org/software/dhcp/
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 dhclient[354]: Copyright 2004-2022 Internet Systems Consortium.
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 dhclient[354]: For info, please visit https://www.isc.org/software/dhcp/
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 systemd[1]: Starting Raise network interfaces...
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 ifup[356]: ifup: waiting for lock on /run/network/ifstate.ens4
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 dhclient[354]: Listening on LPF/ens4/42:01:0a:a8:00:07
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 sh[354]: Listening on LPF/ens4/42:01:0a:a8:00:07
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 sh[354]: Sending on   LPF/ens4/42:01:0a:a8:00:07
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 dhclient[354]: Sending on   LPF/ens4/42:01:0a:a8:00:07
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 sh[354]: DHCPDISCOVER on ens4 to 255.255.255.255 port 67 interval 7
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 kernel: [    0.400657] NET: Registered PF_NETLINK/PF_ROUTE protocol family
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 dhclient[354]: DHCPDISCOVER on ens4 to 255.255.255.255 port 67 interval 7
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 kernel: [    0.408289] audit: initializing netlink subsys (disabled)
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 dhclient[354]: DHCPOFFER of 10.168.0.7 from 169.254.169.254
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 sh[354]: DHCPOFFER of 10.168.0.7 from 169.254.169.254
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 sh[354]: DHCPREQUEST for 10.168.0.7 on ens4 to 255.255.255.255 port 67
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 dhclient[354]: DHCPREQUEST for 10.168.0.7 on ens4 to 255.255.255.255 port 67
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 dhclient[354]: DHCPACK of 10.168.0.7 from 169.254.169.254
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 sh[354]: DHCPACK of 10.168.0.7 from 169.254.169.254
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 kernel: [    0.549954] NetLabel: Initializing
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 kernel: [    0.550736] NetLabel:  domain hash size = 128
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 kernel: [    0.551480] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 kernel: [    0.552303] NetLabel:  unlabeled traffic allowed by default
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 kernel: [    0.570445] NET: Registered PF_INET protocol family
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 kernel: [    0.586842] NET: Registered PF_UNIX/PF_LOCAL protocol family
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 kernel: [    0.587916] NET: Registered PF_XDP protocol family
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 kernel: [    0.865585] NET: Registered PF_INET6 protocol family
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 kernel: [    0.872235] NET: Registered PF_PACKET protocol family
rnel: [    1.153962] virtio_net virtio1 ens4: renamed from eth0
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 sh[474]: ens4=ens4
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 systemd[1]: Finished Raise network interfaces.
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 systemd[1]: Reached target Network.
Aug 13 22:44:15 build-sid-newkernel-2022-08-13t22-41 systemd[1]: Reached target Network is Online.

rebooting into the new kernel:

[    0.475837] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.476558] audit: initializing netlink subsys (disabled)
[    0.630598] NetLabel: Initializing
[    0.631503] NetLabel:  domain hash size = 128
[    0.632409] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.632515] NetLabel:  unlabeled traffic allowed by default
[    0.654654] NET: Registered PF_INET protocol family
[    0.672514] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.871362] Initializing XFRM netlink socket
[    0.872171] NET: Registered PF_INET6 protocol family
[    0.875791] NET: Registered PF_PACKET protocol family
[    0.876932] 9pnet: Installing 9P2000 support
[    0.887570] printk: console [netcon0] enabled
[    0.888339] netconsole: network logging started
[    0.943112] virtio_net virtio1 enp0s4: renamed from eth0
         Starting Raise network interfaces...
[  OK  ] Found device Virtio network device.
[    1.876517] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s4: link becomes ready
Aug 13 22:51:16 debian systemd[1]: Starting Raise network interfaces...
Aug 13 22:51:16 debian dhclient[349]: Internet Systems Consortium DHCP Client 4.4.3
Aug 13 22:51:16 debian ifup[349]: Internet Systems Consortium DHCP Client 4.4.3
Aug 13 22:51:16 debian ifup[349]: Copyright 2004-2022 Internet Systems Consortium.
Aug 13 22:51:16 debian ifup[349]: For info, please visit https://www.isc.org/software/dhcp/
Aug 13 22:51:16 debian dhclient[349]: Copyright 2004-2022 Internet Systems Consortium.
Aug 13 22:51:16 debian dhclient[349]: For info, please visit https://www.isc.org/software/dhcp/
Aug 13 22:51:16 debian kernel: [    0.475837] NET: Registered PF_NETLINK/PF_ROUTE protocol family
Aug 13 22:51:16 debian kernel: [    0.476558] audit: initializing netlink subsys (disabled)
Aug 13 22:51:16 debian systemd[1]: Found device Virtio network device.
Aug 13 22:51:16 debian ifup[349]: DHCPDISCOVER on enp0s4 to 255.255.255.255 port 67 interval 6
Aug 13 22:51:16 debian dhclient[349]: DHCPDISCOVER on enp0s4 to 255.255.255.255 port 67 interval 6
Aug 13 22:51:16 debian sh[356]: ifup: waiting for lock on /run/network/ifstate.enp0s4
Aug 13 22:51:16 debian kernel: [    0.630598] NetLabel: Initializing
Aug 13 22:51:16 debian kernel: [    0.631503] NetLabel:  domain hash size = 128
Aug 13 22:51:16 debian kernel: [    0.632409] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
Aug 13 22:51:16 debian kernel: [    0.632515] NetLabel:  unlabeled traffic allowed by default
Aug 13 22:51:16 debian kernel: [    0.654654] NET: Registered PF_INET protocol family
Aug 13 22:51:16 debian kernel: [    0.672514] NET: Registered PF_UNIX/PF_LOCAL protocol family
Aug 13 22:51:16 debian kernel: [    0.871362] Initializing XFRM netlink socket
Aug 13 22:51:16 debian kernel: [    0.872171] NET: Registered PF_INET6 protocol family
Aug 13 22:51:16 debian kernel: [    0.875791] NET: Registered PF_PACKET protocol family
Aug 13 22:51:16 debian kernel: [    0.876932] 9pnet: Installing 9P2000 support
Aug 13 22:51:16 debian kernel: [    0.887570] printk: console [netcon0] enabled
Aug 13 22:51:16 debian kernel: [    0.888339] netconsole: network logging started
Aug 13 22:51:16 debian kernel: [    0.943112] virtio_net virtio1 enp0s4: renamed from eth0
Aug 13 22:51:16 debian kernel: [    1.876517] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s4: link becomes ready
[ ***  ] A start job is running for Raise network interfaces (6s / 5min)
Aug 13 22:51:22 debian dhclient[349]: DHCPDISCOVER on enp0s4 to 255.255.255.255 port 67 interval 13
[***   ] A start job is running for Raise network interfaces (19s / 5min)
Aug 13 22:51:35 debian dhclient[349]: DHCPDISCOVER on enp0s4 to 255.255.255.255 port 67 interval 14
[***   ] A start job is running for Raise network interfaces (33s / 5min)
...


Greetings,

Andres Freund


[1] https://github.com/anarazel/pg-vm-images/blob/main/packer/linux_debian.pkr.hcl#L225
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
