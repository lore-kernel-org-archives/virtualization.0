Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E36C433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 18:35:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C9E64DD4
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 18:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C9E64DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0D60086A56;
	Wed, 10 Feb 2021 18:35:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5TAfhPLnedTL; Wed, 10 Feb 2021 18:35:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 050ED86A6C;
	Wed, 10 Feb 2021 18:35:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E198BC0174;
	Wed, 10 Feb 2021 18:35:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40ED2C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 18:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2C21186DD9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 18:35:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w9sOFahzgsMp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 18:34:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7F47386C32
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 18:34:59 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B602427530000>; Wed, 10 Feb 2021 10:34:59 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Wed, 10 Feb 2021 18:34:58 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
 <dsahern@gmail.com>, <stephen@networkplumber.org>, <mst@redhat.com>,
 <jasowang@redhat.com>
Subject: [PATCH iproute2-next v5 0/5] Add vdpa device management tool
Date: Wed, 10 Feb 2021 20:34:40 +0200
Message-ID: <20210210183445.1009795-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612982099; bh=JrBd8bjR5X17Xw0ChiwqzFey7ZoXv5uySBPzIFsCoUA=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy;
 b=f6FOaAeHA2hWq/ocBmDBGtHHialpopwaAGRPPSgmOsN0XEFcN8sz0BZ3icXJ9H4Y/
 wN//pSsWnoh/qDdFLsr5wHfHdXKGt2gTGaXrIYy3kSrmco4smExqqu8EfIbotox1YD
 Fy3OJEiHsoXgH1P42ESgZnrbWVdYdxsXOnA5HMLk8qbJaU9tHAfvGlCg2L4fPMjWEI
 Pb38H7t5Kk/h+Htcc+pbCeSK/+2TzZkaT8eNaMdrMWtUm8zi5+IP3S+46t+G266p3N
 Qze9D0MWKpzrQ79PZZ1txLUeeLso/HqrDiLPy7ymgKnS8g84cNWzgu4ZmIdWOw7IrA
 9AkWhbJBCTzIw==
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

Linux vdpa interface allows vdpa device management functionality.
This includes adding, removing, querying vdpa devices.

vdpa interface also includes showing supported management devices
which support such operations.

This patchset includes kernel uapi headers and a vdpa tool.

examples:

$ vdpa mgmtdev show
vdpasim:
  supported_classes net

$ vdpa mgmtdev show -jp
{
    "show": {
        "vdpasim": {
            "supported_classes": [ "net" ]
        }
    }
}

Create a vdpa device of type networking named as "foo2" from
the management device vdpasim_net:

$ vdpa dev add mgmtdev vdpasim_net name foo2

Show the newly created vdpa device by its name:
$ vdpa dev show foo2
foo2: type network mgmtdev vdpasim_net vendor_id 0 max_vqs 2 max_vq_size 256

$ vdpa dev show foo2 -jp
{
    "dev": {
        "foo2": {
            "type": "network",
            "mgmtdev": "vdpasim_net",
            "vendor_id": 0,
            "max_vqs": 2,
            "max_vq_size": 256
        }
    }
}

Delete the vdpa device after its use:
$ vdpa dev del foo2

An example of PCI PF, VF and SF management device:
pci/0000:03.00:0
  supported_classes
    net
pci/0000:03.00:4
  supported_classes
    net
auxiliary/mlx5_core.sf.8
  supported_classes
    net

Patch summary:
Patch-1 adds kernel headers for vdpa subsystem
Patch-2 adds library routines for indent handling
Patch-3 adds library routines for generic socket communication
PAtch-4 adds library routine for number to string mapping
Patch-5 adds vdpa tool

Kernel headers are from the linux-next [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

---
changelog:
v4->v5:
 - avoided UAPI prefix in the vdpa.h header file
 - updated commit id to commit of linux-next tree
v3->v4:
 - relocated vdpa headers to vdpa/include/uapi/linux
 - added new headers path to CFLAGS of vdpa tool
v2->v3:
 - addressed David's comment to split patch for utils and other parts
 - rebased
 - using newly added helper routine for number to string mapping
v1->v2:
 - addressed below comments from David
 - added and used library helpers for socket communication
 - added and used library functions for string processing helpers
 - added and used library functions indent processing helpers


Parav Pandit (5):
  Add kernel headers
  utils: Add helper routines for indent handling
  utils: Add generic socket helpers
  utils: Add helper to map string to unsigned int
  vdpa: Add vdpa tool

 Makefile                             |   2 +-
 include/mnl_utils.h                  |  16 +
 include/utils.h                      |  20 +-
 lib/mnl_utils.c                      | 121 +++++
 lib/utils.c                          |  83 +++-
 man/man8/vdpa-dev.8                  |  96 ++++
 man/man8/vdpa-mgmtdev.8              |  53 +++
 man/man8/vdpa.8                      |  76 +++
 vdpa/Makefile                        |  25 +
 vdpa/include/uapi/linux/vdpa.h       |  40 ++
 vdpa/include/uapi/linux/virtio_ids.h |  58 +++
 vdpa/vdpa.c                          | 675 +++++++++++++++++++++++++++
 12 files changed, 1261 insertions(+), 4 deletions(-)
 create mode 100644 man/man8/vdpa-dev.8
 create mode 100644 man/man8/vdpa-mgmtdev.8
 create mode 100644 man/man8/vdpa.8
 create mode 100644 vdpa/Makefile
 create mode 100644 vdpa/include/uapi/linux/vdpa.h
 create mode 100644 vdpa/include/uapi/linux/virtio_ids.h
 create mode 100644 vdpa/vdpa.c

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
