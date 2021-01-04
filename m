Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57134C433E0
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 03:32:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E241220DD4
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 03:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E241220DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A5A0B20520;
	Mon,  4 Jan 2021 03:32:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DausTohbHM2u; Mon,  4 Jan 2021 03:32:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 390171FEF0;
	Mon,  4 Jan 2021 03:32:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C099C0893;
	Mon,  4 Jan 2021 03:32:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8C42C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:32:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CCC3286821
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:32:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5YUlOzzVlg0M
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:32:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A93468680C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:32:17 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5ff28c410000>; Sun, 03 Jan 2021 19:32:17 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Mon, 4 Jan 2021 03:32:16 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 0/7] Introduce vdpa management tool
Date: Mon, 4 Jan 2021 05:31:34 +0200
Message-ID: <20210104033141.105876-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112064005.349268-1-parav@nvidia.com>
References: <20201112064005.349268-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1609731137; bh=VWEj3029SIsYfpGWtDFsCRPZSRP9LMEAt5loHvhcasc=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=kMiVmC46jABVP0jOWmjkk/q+dGVtAM/KfzMKcVsb2HbHVMOaCbhGeFfHg0hyVuivf
 5R6nu+38FL3tpbYKbxyOOR/LIFJe9zSAap2VFvtWQ7SC2/40g8I3Q8MizkMVOeXu60
 uPJt56CZxA+amLzU/M4HYEvy0opJV/+1cvCvCwTJWEzvbHuDwAsKcMyRBCqaGF4iCn
 7/zUCn9TKIaAjdrnmUy84uM8y9VjR9rRXGtAe/0+Vl44i/CvwdDMJKuXLrDlczUuw9
 eCIrL6QElViK0W2ZFXjAWJrcWC1Ew0HmHQh6Nmnftw4bdXrCWdEur0Z38wiWiH8Q4r
 EeIcB0p3gwRJQ==
Cc: netdev@vger.kernel.org, elic@nvidia.com, mst@redhat.com
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

This patchset covers user requirements for managing existing vdpa devices,
using a tool and its internal design notes for kernel drivers.

Background and user requirements:
----------------------------------
(1) Currently VDPA device is created by driver when driver is loaded.
However, user should have a choice when to create or not create a vdpa device
for the underlying management device.

For example, mlx5 PCI VF and subfunction device supports multiple classes of
device such netdev, vdpa, rdma. Howevever it is not required to always created
vdpa device for such device.

(2) In another use case, a device may support creating one or multiple vdpa
device of same or different class such as net and block.
Creating vdpa devices at driver load time further limits this use case.

(3) A user should be able to monitor and query vdpa queue level or device level
statistics for a given vdpa device.

(4) A user should be able to query what class of vdpa devices are supported
by its management device.

(5) A user should be able to view supported features and negotiated features
of the vdpa device.

(6) A user should be able to create a vdpa device in vendor agnostic manner
using single tool.

Hence, it is required to have a tool through which user can create one or more
vdpa devices from a management device which addresses above user requirements.

Example devices:
----------------
 +-----------+ +-----------+ +---------+ +--------+ +-----------+ 
 |vdpa dev 0 | |vdpa dev 1 | |rdma dev | |netdev  | |vdpa dev 3 |
 |type=net   | |type=net   | |mlx5_0   | |ens3f0  | |type=net   |
 +----+------+ +-----+-----+ +----+----+ +-----+--+ +----+------+
      |              |            |            |         |
      |              |            |            |         |
 +----+-----+        |       +----+----+       |    +----+----+
 |  mlx5    +--------+       |mlx5     +-------+    |mlx5     |
 |pci vf 2  |                |pci vf 4 |            |pci sf 8 |
 |03:00:2   |                |03:00.4  |            |mlx5_sf.8|
 +----+-----+                +----+----+            +----+----+
      |                           |                      |
      |                      +----+-----+                |
      +----------------------+mlx5      +----------------+
                             |pci pf 0  |
                             |03:00.0   |
                             +----------+

vdpa tool:
----------
vdpa tool is a tool to create, delete vdpa devices from a management device.
It is a tool that enables user to query statistics, features and may be more
attributes in future.

vdpa tool command draft:
------------------------
(a) List management devices which support creating vdpa devices.
It also shows which class types supported by this management device.
In below command example four management devices support vdpa device creation.
First is PCI VF whose bdf is 03.00:2.
Second is PCI VF whose name is 03:00.4.
Third is PCI SF whose name is mlx5_core.sf.8

$ vdpa mgmtdev list
vdpasim_net
  supported_classes
    net
pci/0000:03.00:0
  supported_classes
    net
pci/0000:03.00:4
  supported_classes
    net
auxiliary/mlx5_core.sf.8
  supported_classes
    net

(b) Now add a vdpa device of networking class and show the device.
$ vdpa dev add mgmtdev pci/0000:03.00:0 name foo0

$ vdpa dev show foo0
foo0: mgmtdev pci/0000:03.00:2 type network vendor_id 0 max_vqs 2 max_vq_size 256

(c) Show features of a vdpa device
$ vdpa dev features show foo0
supported
  iommu platform
  version 1

(d) Dump vdpa device statistics
$ vdpa dev stats show foo0
kickdoorbells 10
wqes 100

(e) Now delete a vdpa device previously created.
$ vdpa dev del foo0

vdpa tool support in this patchset:
-----------------------------------
vdpa tool is created to create, delete and query vdpa devices.
examples:
Show vdpa management device that supports creating, deleting vdpa devices.

$ vdpa mgmtdev show
vdpasim_net:
  supported_classes
    net

$ vdpa mgmtdev show -jp
{
    "show": {
       "vdpasim_net": {
          "supported_classes": {
             "net"
        }
    }
}

Create a vdpa device of type networking named as "foo2" from the
management device vdpasim:

$ vdpa dev add mgmtdev vdpasim type net name foo2

Show the newly created vdpa device by its name:
$ vdpa dev show foo2
foo2: type network mgmtdev vdpasim vendor_id 0 max_vqs 2 max_vq_size 256

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

vdpa tool support by kernel:
----------------------------
vdpa tool user interface will be supported by existing vdpa kernel framework,
i.e. drivers/vdpa/vdpa.c It services user command through a netlink interface.

Each management device registers supported callback operations with vdpa
subsystem through which vdpa device(s) can be managed.

Patch summary:
--------------
Patch-1 Makes mac address array static
Patch-2 adds module parameter to avoid breaking backward compatibility
        for default device
Patch-3 Extends API to accept vdpa device name
Patch-4 Defines management device interface
Patch-5 Extends netlink interface to add, delete vdpa devices
Patch-6 Extends netlink interface to query vdpa device attributes
Patch-7 Extends vdpa_sim_net driver to add/delete simulated vdpa devices

FAQs:
-----
1. Where does userspace vdpa tool reside which users can use?
Ans: vdpa tool can possibly reside in iproute2 [1] as it enables user to
handler vdpa network devices.

2. Why not create and delete vdpa device using sysfs/configfs?
Ans:
(a) A device creation may involve passing one or more attributes.
Passing multiple attributes and returning error code and more verbose
information for invalid attributes cannot be handled by sysfs/configfs.

(b) netlink framework is rich that enables user space and kernel driver to
provide nested attributes.

(c) Exposing device specific file under sysfs without net namespace
awareness exposes details to multiple containers. Instead exposing
attributes via a netlink socket secures the communication channel with kernel.

(d) netlink socket interface enables to run syscaller kernel tests.

3. Why not use ioctl() interface?
Ans: ioctl() interface replicates the necessary plumbing which already
exists through netlink socket.

4. What happens when one or more user created vdpa devices exist for a
management PCI VF or SF and such management device is removed?
Ans: All user created vdpa devices are removed that belong to a
management device.

[1] git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Next steps:
-----------
(a) Post this patchset and iproute2/vdpa inclusion, remaining two drivers
will be coverted to support vdpa tool instead of creating unmanaged default
device on driver load.
(b) More net specific parameters such as mac, mtu will be added.
(c) Features bits get and set interface will be added.

Parav Pandit (7):
  vdpa_sim_net: Make mac address array static
  vdpa_sim_net: Add module param to disable default vdpa net device
  vdpa: Extend routine to accept vdpa device name
  vdpa: Define vdpa mgmt device, ops and a netlink interface
  vdpa: Enable a user to add and delete a vdpa device
  vdpa: Enable user to query vdpa device info
  vdpa_sim_net: Add support for user supported devices

 drivers/vdpa/Kconfig                 |   1 +
 drivers/vdpa/ifcvf/ifcvf_main.c      |   2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |   2 +-
 drivers/vdpa/vdpa.c                  | 503 ++++++++++++++++++++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |   3 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |   2 +
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 135 ++++++-
 include/linux/vdpa.h                 |  44 ++-
 include/uapi/linux/vdpa.h            |  40 +++
 9 files changed, 707 insertions(+), 25 deletions(-)
 create mode 100644 include/uapi/linux/vdpa.h

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
