Received: from baidu.com (mx20.baidu.com [111.202.115.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303BCFC1E
	for <virtualization@lists.linux.dev>; Thu, 11 Jan 2024 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "parav@nvidia.com" <parav@nvidia.com>
CC: songyang23 <songyang23@baidu.com>, liubokai <liubokai@baidu.com>,
	"Song,Zhan" <songzhan@baidu.com>
Subject: [RFC] Revert "virtio_pci: Support surprise removal of virtio pci
Thread-Topic: [RFC] Revert "virtio_pci: Support surprise removal of virtio pci
Thread-Index: AdpEbQ0W9HGTHF1qSr6UzsNmXQK48w==
Date: Thu, 11 Jan 2024 09:14:37 +0000
Message-ID: <c45dd68698cd47238c55fb73ca9b4741@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex14_2024-01-11 17:14:37:904
X-FEAS-Client-IP: 10.127.64.37
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM

Revert "virtio_pci: Support surprise removal of virtio pci device"

This reverts commit 43bb40c5b92659966bdf4bfe584fde0a3575a049.

Marking the device as broken will cause the uncompleted IO request on
virtio-blk since virtblk_done will not continue when it find the broken vir=
tqueu
at last it will cause the failure of removal of virtio-blk device because o=
f
uncompleted IO request

The correct fix for the issue that commit 43bb40c5b9 ("virtio_pci:
Support surprise removal of virtio pci device") tried to fix
is that virtio backend always complete the IO request as soon as possible

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/virtio/virtio_pci_common.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci=
_common.c
index 7a55939..d60fe99 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -584,13 +584,6 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
        struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
        struct device *dev =3D get_device(&vp_dev->vdev.dev);

-       /*
-        * Device is marked broken on surprise removal so that virtio upper
-        * layers can abort any ongoing operation.
-        */
-       if (!pci_device_is_present(pci_dev))
-               virtio_break_device(&vp_dev->vdev);
-
        pci_disable_sriov(pci_dev);

        unregister_virtio_device(&vp_dev->vdev);
--
2.9.4
