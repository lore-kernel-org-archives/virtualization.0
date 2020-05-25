From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [PATCH v2 0/5] Add a vhost RPMsg API
Date: Mon, 25 May 2020 16:44:53 +0200
Message-ID: <20200525144458.8413-1-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

v2:
- remove "default n" from Kconfig
- drop patch #6 - it depends on a different patch, that is currently 
  an RFC
- update patch #5 with a correct vhost_dev_init() prototype

Linux supports RPMsg over VirtIO for "remote processor" /AMP use
cases. It can however also be used for virtualisation scenarios,
e.g. when using KVM to run Linux on both the host and the guests.
This patch set adds a wrapper API to facilitate writing vhost
drivers for such RPMsg-based solutions. The first use case is an
audio DSP virtualisation project, currently under development, ready
for review and submission, available at
https://github.com/thesofproject/linux/pull/1501/commits
A further patch for the ADSP vhost RPMsg driver will be sent
separately for review only since it cannot be merged without audio
patches being upstreamed first.

Thanks
Guennadi

Guennadi Liakhovetski (5):
  vhost: convert VHOST_VSOCK_SET_RUNNING to a generic ioctl
  vhost: (cosmetic) remove a superfluous variable initialisation
  rpmsg: move common structures and defines to headers
  rpmsg: update documentation
  vhost: add an rpmsg API

 Documentation/rpmsg.txt          |   2 +-
 drivers/rpmsg/virtio_rpmsg_bus.c |  78 +-------
 drivers/vhost/Kconfig            |   7 +
 drivers/vhost/Makefile           |   3 +
 drivers/vhost/rpmsg.c            | 372 +++++++++++++++++++++++++++++++++++++++
 drivers/vhost/vhost.c            |   2 +-
 drivers/vhost/vhost_rpmsg.h      |  74 ++++++++
 include/linux/virtio_rpmsg.h     |  81 +++++++++
 include/uapi/linux/rpmsg.h       |   3 +
 include/uapi/linux/vhost.h       |   4 +-
 10 files changed, 547 insertions(+), 79 deletions(-)
 create mode 100644 drivers/vhost/rpmsg.c
 create mode 100644 drivers/vhost/vhost_rpmsg.h
 create mode 100644 include/linux/virtio_rpmsg.h

-- 
1.9.3
