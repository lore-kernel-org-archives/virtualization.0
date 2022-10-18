Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79815C43217
	for <virtualization@archiver.kernel.org>; Wed, 19 Oct 2022 00:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB79A404B0;
	Wed, 19 Oct 2022 00:56:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB79A404B0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=Ns4P/hni
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IaA7u2WGeAIy; Wed, 19 Oct 2022 00:56:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 27EC440C19;
	Wed, 19 Oct 2022 00:56:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27EC440C19
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 091E1C0082;
	Wed, 19 Oct 2022 00:56:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 226B1C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 00:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C28F983F14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 00:56:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C28F983F14
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=Ns4P/hni
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qO004cltRDBS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 00:56:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE61D83EFB
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE61D83EFB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 00:56:13 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29INiKMe015121;
 Wed, 19 Oct 2022 00:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=xseYydpUfLuBneMMsSa+Z0sYvhToqtWp3Es7rP3ZOkY=;
 b=Ns4P/hniUWMcqJSLSbePGUzEHhveRZLxf/c9DFLyMNrK2RGstwtBi9tFMWNS8Kh8I0WH
 iVClBhowfy6Tl9tYTWZvu4l57QXm8kIhWrx77DBDya8Q7BbjQSMtSsOpL1m23OF+r/AU
 x1nRMvZAT5IzfHKGrrvIWDeU/7P5T+Id+DmJNw/gtUf5Pmy1t53HkZvE4hANAM/KZHof
 Uit6DFfvSPrudr45oWJJQ+9CA8Ytli39dIaMuJWp01ASkL3KOz5r7WaDtCaWU/TlJTZ6
 7S/Un6VsizuRTVMsxzNOcSg9hSZlSMplnR2XTjr59nb44xX3DCoBHDnUk8uzJvXmow8R 0g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7skyyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Oct 2022 00:56:12 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29ILnUhG016678; Wed, 19 Oct 2022 00:56:11 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3k8htgrhfm-1; Wed, 19 Oct 2022 00:56:11 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com
Subject: [PATCH v2 0/4] vDPA: dev config export via "vdpa dev show" command
Date: Tue, 18 Oct 2022 16:50:28 -0700
Message-Id: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_10,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=993
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190003
X-Proofpoint-GUID: wa8ifZsHyz8Au8A6iFTXwGt6vEsYk02T
X-Proofpoint-ORIG-GUID: wa8ifZsHyz8Au8A6iFTXwGt6vEsYk02T
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Live migration of vdpa would typically require re-instate vdpa
device with an idential set of configs on the destination node,
same way as how source node created the device in the first place. 

In order to allow live migration orchestration software to export the
initial set of vdpa attributes with which the device was created, it
will be useful if the vdpa tool can report the config on demand with
simple query. This will ease the orchestration software implementation
so that it doesn't have to keep track of vdpa config change, or have
to persist vdpa attributes across failure and recovery, in fear of
being killed due to accidental software error.

In this series, the initial device config for vdpa creation will be
exported via the "vdpa dev show" command. This is unlike the "vdpa
dev config show" command that usually goes with the live value in
the device config space, which is not reliable subject to the dynamics
of feature negotiation and possible change in device config space.

Examples:

1) Create vDPA by default without any config attribute

$ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
$ vdpa dev show vdpa0
vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
$ vdpa dev -jp show vdpa0
{
    "dev": {
        "vdpa0": {
            "type": "network",
            "mgmtdev": "pci/0000:41:04.2",
            "vendor_id": 5555,
            "max_vqs": 9,
            "max_vq_size": 256,
        }
    }
}

2) Create vDPA with config attribute(s) specified

$ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
    mac e4:11:c6:d3:45:f0 max_vq_pairs 4
$ vdpa dev show
vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
  virtio_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
$ vdpa dev -jp show
{
    "dev": {
        "vdpa0": {
            "type": "network",
            "mgmtdev": "pci/0000:41:04.2",
            "vendor_id": 5555,
            "max_vqs": 9,
            "max_vq_size": 256,
            "virtio_config": {
                "mac": "e4:11:c6:d3:45:f0",
                "max_vq_pairs": 4
            }
        }
    }
}

---
v1 -> v2:
  - Revised example output to export all config attributes under a
    json object

---
Si-Wei Liu (4):
  vdpa: save vdpa_dev_set_config in struct vdpa_device
  vdpa: pass initial config to _vdpa_register_device()
  vdpa: show dev config as-is in "vdpa dev show" output
  vdpa: fix improper error message when adding vdpa dev

 drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
 drivers/vdpa/vdpa.c                  | 63 +++++++++++++++++++++++++++++++++---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
 drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 +-
 include/linux/vdpa.h                 | 26 ++++++++-------
 8 files changed, 80 insertions(+), 22 deletions(-)

-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
