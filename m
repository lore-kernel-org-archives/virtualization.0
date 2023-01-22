Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08857C38142
	for <virtualization@archiver.kernel.org>; Sun, 22 Jan 2023 10:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC7E3416E4;
	Sun, 22 Jan 2023 10:11:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC7E3416E4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Js_iFQBgymip; Sun, 22 Jan 2023 10:11:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B2BA4170D;
	Sun, 22 Jan 2023 10:11:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B2BA4170D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D39D9C0032;
	Sun, 22 Jan 2023 10:11:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33037C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D074E41682
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D074E41682
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Acojfw17Tq2v
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 97673415DF
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97673415DF
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:04 +0000 (UTC)
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mtxxk-1oPdmn1xOO-00uJdX; Sun, 22 Jan 2023 11:05:29 +0100
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] virtio_net: vdpa: update MAC address when it is generated
 by virtio-net
Date: Sun, 22 Jan 2023 11:05:22 +0100
Message-Id: <20230122100526.2302556-1-lvivier@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:yq7SLpOrrrwYVuK/Tdk6ssgdcQ6R8SuLVoPPYJezo5ADX4BjNKy
 jPDNlUIGwIUmFhylv5V6HcgBQNaEyIiXaqQowDqi8e4rgKiPvAEhdshNHaqBw48ZIrSEx04
 mGDb2jrNB0YFnhYouLuagZLWB45N6Id3Kx/yqqZbmuDSupW+masgienmCgt/r20QktmRkO4
 MSOX1Ugsi04mspkV6F8KA==
UI-OutboundReport: notjunk:1;M01:P0:8zp5s8d3byQ=;VxTDJnXgSWcqoj9jK6Z0jrgUKRV
 xdIXae7LSGr11uz887/DmX+feK/EuW2DkElSDBcPwoMbBS0EKDziZmY8n3lhk0VlIeoOtHSms
 0mdDqhAEgVNanjszFxz62e13szM8r8LHBbTD/ToCB1fRPwLttuQp0kghoy/hYcbehmyQVFHOe
 KKbok64aSuwX7Lnyng57IQ5IHRvmLwatggE2O79/BDsMn99YrVrNFmk1AONbeLrsPm+WWvTZb
 FfWojLxucdiWbpaLcQgl5k8H1qcXE7sLze9Ye2xoM/WmAL5ZQDbMM1QLJo+wuNseA6RGNtvOS
 F+EWCzzrPalH1hqUroL6DfQyjfpAINgqTOxRFDvrfKSadWzGz/aBN+g/Lnl3DwtX4RkJFcrnq
 iLSDWAb4+mDRPXSW/aTWRlET2gcVsnTZnGtWkZUMvDL4ghWvB6xrTgoT08LzdfB4tvB/AUV7U
 VCIv8jO/Zn285MXjBpBODkmTHnr75YJd8T0txWkFb7WDtWLSOLNJ4+RRdRF4p5GYtJhbH7tkf
 NM+O9rtYdXzUFdd7L8P6fx7F5Qo5c8Kc97k7l5nBOXvv6EESCiAgNMdlb7uaH3bHjSERXlKdd
 YRtZPUBJ23dBznF4RhF5yYpbyviDStqJOFx65aVrEASqGAWqOzNA5pWVWHe5l1F/b/epjkN9i
 29YMG/gPjx2ZyDMv2Wvn/p02BVQ8esMyvRdw9v77Qw==
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eli Cohen <elic@nvidia.com>,
 Gautam Dawar <gautam.dawar@xilinx.com>
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

When the MAC address is not provided by the vdpa device virtio_net
driver assigns a random one without notifying the device.
The consequence, in the case of mlx5_vdpa, is the internal routing
tables of the device are not updated and this can block the
communication between two namespaces.

To fix this problem, use virtnet_send_command(VIRTIO_NET_CTRL_MAC)
to set the address from virtnet_probe() when the MAC address is
randomly assigned from virtio_net.

While I was testing this change I found 3 other bugs in vdpa_sim_net:

- vdpa_sim_net sets the VIRTIO_NET_F_MAC even if no MAC address is
  provided. So virtio_net doesn't generate a random MAC address and
  the MAC address appears to be 00:00:00:00:00:00

- vdpa_sim_net never processes the command and virtnet_send_command()
  hangs in an infinite loop. To avoid a kernel crash add a timeout
  in the loop.

- To allow vdpa_sim_net to process the command, replace the cpu_relax()
  in the loop by a schedule(). vdpa_sim_net uses a workqueue to process
  the queue, and if we don't allow the kernel to schedule, the queue
  is not processed and the loop is infinite.

Laurent Vivier (4):
  virtio_net: notify MAC address change on device initialization
  virtio_net: add a timeout in virtnet_send_command()
  vdpa_sim_net: don't always set VIRTIO_NET_F_MAC
  virtio_net: fix virtnet_send_command() with vdpa_sim_net

 drivers/net/virtio_net.c             | 21 +++++++++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  6 ++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
