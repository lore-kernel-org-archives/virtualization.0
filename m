From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3] virtio: new feature to detect IOMMU device quirk
Date: Sun, 24 Jul 2016 05:32:14 +0800
Message-ID: <201607240533.WFU0YTi2%fengguang.wu@intel.com>
References: <20160719053823-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160719053823-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kbuild-all@01.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

[auto build test WARNING on stable/master]
[also build test WARNING on v4.7-rc7 next-20160722]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Michael-S-Tsirkin/virtio-new-feature-to-detect-IOMMU-device-quirk/20160724-030032
base:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:232:8: sparse: attribute 'no_sanitize_address': unknown attribute
   drivers/virtio/virtio_ring.c:1109:22: sparse: undefined identifier 'VIRTIO_F_IOMMU_PASSTHROUGH'
   drivers/virtio/virtio_ring.c:1113:50: sparse: undefined identifier 'VIRTIO_F_IOMMU_PASSTHROUGH'
>> drivers/virtio/virtio_ring.c:1109:22: sparse: incompatible types for 'case' statement
   drivers/virtio/virtio_ring.c:1109:22: sparse: Expected constant expression in case statement
   drivers/virtio/virtio_ring.c: In function 'vring_transport_features':
   drivers/virtio/virtio_ring.c:1109:8: error: 'VIRTIO_F_IOMMU_PASSTHROUGH' undeclared (first use in this function)
      case VIRTIO_F_IOMMU_PASSTHROUGH:
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/virtio/virtio_ring.c:1109:8: note: each undeclared identifier is reported only once for each function it appears in

vim +/case +1109 drivers/virtio/virtio_ring.c

  1093	}
  1094	EXPORT_SYMBOL_GPL(vring_del_virtqueue);
  1095	
  1096	/* Manipulates transport-specific feature bits. */
  1097	void vring_transport_features(struct virtio_device *vdev)
  1098	{
  1099		unsigned int i;
  1100	
  1101		for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++) {
  1102			switch (i) {
  1103			case VIRTIO_RING_F_INDIRECT_DESC:
  1104				break;
  1105			case VIRTIO_RING_F_EVENT_IDX:
  1106				break;
  1107			case VIRTIO_F_VERSION_1:
  1108				break;
> 1109			case VIRTIO_F_IOMMU_PASSTHROUGH:
  1110				break;
  1111			case VIRTIO_F_IOMMU_PLATFORM:
  1112				/* Ignore passthrough hint for now, obey kernel config. */
  1113				__virtio_clear_bit(vdev, VIRTIO_F_IOMMU_PASSTHROUGH);
  1114				break;
  1115			default:
  1116				/* We don't understand this bit. */
  1117				__virtio_clear_bit(vdev, i);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
