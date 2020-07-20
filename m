From: Eli Cohen <eli@mellanox.com>
Subject: [PATCH V2 vhost next 00/10] VDPA support for Mellanox ConnectX devices
Date: Mon, 20 Jul 2020 09:54:33 +0300
Message-ID: <20200720065443.31112-1-eli@mellanox.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com, Eli Cohen <eli@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,
please note that this series depends on mlx5 core device driver patches
in mlx5-next branch in
git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.

git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next 

They also depend Jason Wang's patches submitted a couple of weeks ago.

vdpa_sim: use the batching API
vhost-vdpa: support batch updating


The following series of patches provide VDPA support for Mellanox
devices. The supported devices are ConnectX6 DX and newer.

Currently, only a network driver is implemented; future patches will
introduce a block device driver. iperf performance on a single queue is
around 12 Gbps.  Future patches will introduce multi queue support.

The files are organized in such a way that code that can be used by
different VDPA implementations will be placed in a common are resides in
drivers/vdpa/mlx5/core.

Only virtual functions are currently supported. Also, certain firmware
capabilities must be set to enable the driver. Physical functions (PFs)
are skipped by the driver.

To make use of the VDPA net driver, one must load mlx5_vdpa. In such
case, VFs will be operated by the VDPA driver. Although one can see a
regular instance of a network driver on the VF, the VDPA driver takes
precedence over the NIC driver, steering-wize.

Currently, the device/interface infrastructure in mlx5_core is used to
probe drivers. Future patches will introduce virtbus as a means to
register devices and drivers and VDPA will be adapted to it.

The mlx5 mode of operation required to support VDPA is switchdev mode.
Once can use Linux or OVS bridge to take care of layer 2 switching.

In order to provide virtio networking to a guest, an updated version of
qemu is required. This version has been tested by the following quemu
version:

url: https://github.com/jasowang/qemu.git
branch: vdpa
Commit ID: 6f4e59b807db

Eli Cohen (7):
  net/vdpa: Use struct for set/get vq state
  vhost: Fix documentation
  vdpa: Modify get_vq_state() to return error code
  vdpa/mlx5: Add hardware descriptive header file
  vdpa/mlx5: Add support library for mlx5 VDPA implementation
  vdpa/mlx5: Add shared memory registration code
  vdpa/mlx5: Add VDPA driver for supported mlx5 devices

Jason Wang (2):
  vhost-vdpa: support batch updating
  vdpa_sim: use the batching API

Max Gurtovoy (1):
  vdpa: remove hard coded virtq num

 drivers/vdpa/Kconfig                   |   18 +
 drivers/vdpa/Makefile                  |    1 +
 drivers/vdpa/ifcvf/ifcvf_base.c        |    4 +-
 drivers/vdpa/ifcvf/ifcvf_base.h        |    4 +-
 drivers/vdpa/ifcvf/ifcvf_main.c        |   13 +-
 drivers/vdpa/mlx5/Makefile             |    4 +
 drivers/vdpa/mlx5/core/mlx5_vdpa.h     |   91 ++
 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h |  168 ++
 drivers/vdpa/mlx5/core/mr.c            |  473 ++++++
 drivers/vdpa/mlx5/core/resources.c     |  284 ++++
 drivers/vdpa/mlx5/net/main.c           |   76 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c      | 1950 ++++++++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.h      |   24 +
 drivers/vdpa/vdpa.c                    |    3 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c       |   35 +-
 drivers/vhost/iotlb.c                  |    4 +-
 drivers/vhost/vdpa.c                   |   46 +-
 include/linux/vdpa.h                   |   24 +-
 include/uapi/linux/vhost_types.h       |    2 +
 19 files changed, 3165 insertions(+), 59 deletions(-)
 create mode 100644 drivers/vdpa/mlx5/Makefile
 create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa.h
 create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
 create mode 100644 drivers/vdpa/mlx5/core/mr.c
 create mode 100644 drivers/vdpa/mlx5/core/resources.c
 create mode 100644 drivers/vdpa/mlx5/net/main.c
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.c
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h

-- 
2.26.0
