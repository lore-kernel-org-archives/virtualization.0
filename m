Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EC8C54EB4
	for <virtualization@archiver.kernel.org>; Sun, 22 Jan 2023 10:11:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7D9060E4C;
	Sun, 22 Jan 2023 10:11:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B7D9060E4C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MfukHUt8Yg_j; Sun, 22 Jan 2023 10:11:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 37EED60E30;
	Sun, 22 Jan 2023 10:11:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37EED60E30
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15A09C0032;
	Sun, 22 Jan 2023 10:11:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA4BAC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF7A54174D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF7A54174D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yKYEBvl263OO
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5A25416F4
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5A25416F4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:09 +0000 (UTC)
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqINP-1oy0341K9z-00nPdI; Sun, 22 Jan 2023 11:05:33 +0100
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] virtio_net: fix virtnet_send_command() with vdpa_sim_net
Date: Sun, 22 Jan 2023 11:05:26 +0100
Message-Id: <20230122100526.2302556-5-lvivier@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230122100526.2302556-1-lvivier@redhat.com>
References: <20230122100526.2302556-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Provags-ID: V03:K1:YTjFLU1lj+k8vApmSwkjqxN3EBr0drRgQSUre+RfcDGSw4uTA+0
 fpObHvWK8k3li6YWyS80RiUZHOX8MywdgaDytn/6t8T+DiaynYAOSnUv/FWk1HaQEOmrj5S
 KrovGMPtwrXHOQlFb5ZB7KBF2sy6BQdtTORgHlq35jPyVn4D7dbru2lBJVeYHfpcThtGErb
 +Fr/sA0/vvb/ZKDcaf4ag==
UI-OutboundReport: notjunk:1;M01:P0:W/8CbaMJfHI=;CztS2YeNk03sPaZQmk0pcBJ6L43
 XcTq3jVYTR1mPvip15m9kRcm4gx/fCYvZXXAiserRgQ9GFMVi/1LZ0b4jQkbYecKpXXQ+1YOU
 rBpVaXPROlsifSO1bNiEiHYAbudG2KcSeHDa4oueEPlBlJpIcVfy5U+3ZlKYLxT5ZRzdg50Qs
 g/IdVtnBO6yU19WOFGc0dYdOtjbIpFy66HsEykChNF0WWHZQhrOOJ2WhiAuzsvuBRJTgO05cc
 GLWOboaYKXGeWF74daHubX+BlE1K7ZZS9qZ6sIRQ2qMZO+rA8owLFae2Y/cg3W80pIRcNgW47
 jkd67qMPk0vZjxCO9UrPIK3Tls1BKbZ2u91VxEMWay+YYAE1RqV/NhWBUjZ85vf/Jua4dzf9u
 UzzD3cflGJ9vqwlR003dHr1chEHCC6R+ff7po0WY+C8azbOlMMlJlx4lV5ntjVsWQkQgVzihl
 cgg+JKelqfGLSQlRJBSx6aNgedhV/zvuqXKnNPGdNSttYep61gKReoyF4gEDLnVmvpkLkjVzM
 nlV+b2ig0YvJfYiuFp4QMmD4FiCpy5+9MDcBhXTpaiIDFvMhaMsPdgwPCARDGRKYR8/7oPQku
 F5Nzmv3rfaax47qfuviRX2Dq8X+FsMmh0fbGYELuiT9zFEea8uCwaEwaW4BsNrsCbbzen8UtB
 xzMSe0bE+Kdl8LxR2gO5YF/TUzIUv4hfj3/YxuuEzA==
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

virtnet_send_command() sends a command to the control virtqueue
by adding the command to the virtqueue, kicking the queue and waiting
in a loop.

The vdpa simulator simulates the control virqueue using a work queue:
the virqueue_kick() calls schedule_work() to start the queue processing.
But as virtnet_send_command() uses a loop, the scheduler cannot schedule
the workqueue and the virtqueue is never processed (and the command
never executed).

To fix that, replace in the loop the cpu_relax() by a schedule().

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 29b3cc72082d..546c0b2baaca 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2011,7 +2011,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
 	       !virtqueue_is_broken(vi->cvq) &&
 	       !time_after(jiffies, timeout))
-		cpu_relax();
+		schedule();
 
 	return vi->ctrl->status == VIRTIO_NET_OK;
 }
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
