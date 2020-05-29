From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [RFC 00/12] Audio DSP VirtIO and vhost drivers
Date: Fri, 29 May 2020 09:37:10 +0200
Message-ID: <20200529073722.8184-1-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

This patch set is a follow up to "Add a vhost RPMsg API" [1], it is
marked as an RFC because firstly it depends on the RPMsg API series
and secondly it is currently being reviewed on ALSA and SOF mailing
lists, but any early comments from virtualisation developers would be
highly appreciated too!

Thanks
Guennadi

[1] https://mailman.alsa-project.org/pipermail/sound-open-firmware/2020-May/003879.html

Guennadi Liakhovetski (12):
  ASoC: add function parameters to enable forced path pruning
  ASoC: SOF: extract firmware-related operation into a function
  ASoC: SOF: support IPC with immediate response
  ASoC: SOF: add a power status IPC
  ASoC: SOF: add two helper lookup functions
  ASoC: SOF: add an RPMsg VirtIO DSP driver
  ASoC: SOF: use a macro instead of a hard-coded value
  ASoC: SOF: add a vhost driver: sound part
  ASoC: SOF: VirtIO: free guest pipelines upon termination
  vhost: add an SOF Audio DSP driver
  rpmsg: increase buffer size and reduce buffer number
  rpmsg: add a device ID to also bind to the ADSP device

 drivers/rpmsg/virtio_rpmsg_bus.c |    1 +
 drivers/vhost/Kconfig            |   10 +
 drivers/vhost/Makefile           |    3 +
 drivers/vhost/adsp.c             |  618 +++++++++++++++++++
 include/linux/virtio_rpmsg.h     |    4 +-
 include/sound/soc-dpcm.h         |   28 +-
 include/sound/soc-topology.h     |    3 +
 include/sound/sof.h              |    4 +
 include/sound/sof/header.h       |    3 +
 include/sound/sof/rpmsg.h        |  196 ++++++
 include/sound/sof/topology.h     |    9 +-
 include/uapi/linux/vhost.h       |    5 +
 include/uapi/linux/vhost_types.h |    7 +
 include/uapi/linux/virtio_ids.h  |    1 +
 sound/soc/soc-compress.c         |    2 +-
 sound/soc/soc-dapm.c             |    8 +-
 sound/soc/soc-pcm.c              |   98 ++-
 sound/soc/sof/Kconfig            |    7 +
 sound/soc/sof/Makefile           |    2 +
 sound/soc/sof/core.c             |  114 ++--
 sound/soc/sof/ipc.c              |   34 +-
 sound/soc/sof/loader.c           |    4 +
 sound/soc/sof/ops.h              |   10 +-
 sound/soc/sof/pcm.c              |   13 +-
 sound/soc/sof/pm.c               |    6 +-
 sound/soc/sof/rpmsg-vfe.c        |  881 ++++++++++++++++++++++++++
 sound/soc/sof/sof-audio.c        |   33 +
 sound/soc/sof/sof-audio.h        |   21 +
 sound/soc/sof/sof-priv.h         |   48 ++
 sound/soc/sof/topology.c         |   71 ++-
 sound/soc/sof/vhost-vbe.c        | 1258 ++++++++++++++++++++++++++++++++++++++
 31 files changed, 3391 insertions(+), 111 deletions(-)
 create mode 100644 drivers/vhost/adsp.c
 create mode 100644 include/sound/sof/rpmsg.h
 create mode 100644 sound/soc/sof/rpmsg-vfe.c
 create mode 100644 sound/soc/sof/vhost-vbe.c

-- 
1.9.3
