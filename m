Return-Path: <SRS0=TOd4=GZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC005C433E0
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 11:27:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCF222DCC
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 11:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCF222DCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2F8588736C;
	Fri, 22 Jan 2021 11:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ho8ahjrd2ngG; Fri, 22 Jan 2021 11:27:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8240D87366;
	Fri, 22 Jan 2021 11:27:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F8FEC08A1;
	Fri, 22 Jan 2021 11:27:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEC46C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 11:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E7D1D869DE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 11:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JZtSaSW-J+jL
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 11:27:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 65E6184EA0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 11:27:15 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B600ab6920001>; Fri, 22 Jan 2021 03:27:14 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Fri, 22 Jan 2021 11:27:13 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
 <dsahern@gmail.com>, <stephen@networkplumber.org>, <mst@redhat.com>,
 <jasowang@redhat.com>
Subject: [PATCH iproute2-next 0/2] Add vdpa device management tool
Date: Fri, 22 Jan 2021 13:26:52 +0200
Message-ID: <20210122112654.9593-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611314835; bh=2ZB/XEEklof71qF9Kn209ervpR48S1+tZlHCq86dS/Y=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy;
 b=mTzBk+eFhnZKeUczG6WyoLHNrGcMEZCLz0CtR12iHvTdBKIxELmqzYuXnnk7dGnvd
 0CdI1lcKcQ8EBIwFEBBPwtnVe+C9SHaiCQICX9lo4toohbtlT3iXy/QKDG/M/X0+Db
 lk9BZEk5RdMV14xeEaHpMzu1O6WAdoM+9syvX2mjgbPyR60+0LrSkctBpWEr6Bbkrl
 8dHzYhreJjL1MrhtXvuBVMkDnEIb+0oO2z3L/IY95GMVORnNUTsc3maEruRgSvLMx9
 ysPm3P76GA9BXSNFHix0PeH4ags6a4ZIEeejOVUzOnVMZ5AC8wghaf0OQZDKYwVDmU
 n53d1QH0IUy3w==
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

Patch summary:
Patch-1 adds kernel headers for vdpa subsystem
Patch-2 adds vdpa tool and its man pages

Kernel headers are from the vhost kernel tree [1] from branch linux-next.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git

Parav Pandit (2):
  Add kernel headers
  vdpa: Add vdpa tool

 Makefile                        |   2 +-
 include/uapi/linux/vdpa.h       |  40 ++
 include/uapi/linux/virtio_ids.h |  58 +++
 man/man8/vdpa-dev.8             |  96 ++++
 man/man8/vdpa-mgmtdev.8         |  53 ++
 man/man8/vdpa.8                 |  76 +++
 vdpa/Makefile                   |  24 +
 vdpa/vdpa.c                     | 828 ++++++++++++++++++++++++++++++++
 8 files changed, 1176 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/vdpa.h
 create mode 100644 include/uapi/linux/virtio_ids.h
 create mode 100644 man/man8/vdpa-dev.8
 create mode 100644 man/man8/vdpa-mgmtdev.8
 create mode 100644 man/man8/vdpa.8
 create mode 100644 vdpa/Makefile
 create mode 100644 vdpa/vdpa.c

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
