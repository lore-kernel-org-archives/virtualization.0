From: kbuild test robot <lkp@intel.com>
Subject: [vhost:linux-next 2/23] include/linux/swiotlb.h:99:22: error: static
	declaration of 'swiotlb_max_mapping_size' follows non-static
	declaration
Date: Wed, 6 Feb 2019 03:37:12 +0800
Message-ID: <201902060310.jNXgj4pr%fengguang.wu__16793.8597312727$1549446251$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joerg Roedel <jroedel@suse.de>
Cc: kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, kbuild-all@01.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
head:   104f89a60ef5ec77d6f559eac4676844b3480740
commit: 951a381d4c0d45a9b44de30228c6ef17083854ea [2/23] swiotlb: Introduce swiotlb_max_mapping_size()
config: i386-tinyconfig (attached as .config)
compiler: gcc-8 (Debian 8.2.0-14) 8.2.0
reproduce:
        git checkout 951a381d4c0d45a9b44de30228c6ef17083854ea
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):


vim +/swiotlb_max_mapping_size +99 include/linux/swiotlb.h

    75	
    76	bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
    77			size_t size, enum dma_data_direction dir, unsigned long attrs);
    78	void __init swiotlb_exit(void);
    79	unsigned int swiotlb_max_segment(void);
    80	#else
    81	#define swiotlb_force SWIOTLB_NO_FORCE
    82	static inline bool is_swiotlb_buffer(phys_addr_t paddr)
    83	{
    84		return false;
    85	}
    86	static inline bool swiotlb_map(struct device *dev, phys_addr_t *phys,
    87			dma_addr_t *dma_addr, size_t size, enum dma_data_direction dir,
    88			unsigned long attrs)
    89	{
    90		return false;
    91	}
    92	static inline void swiotlb_exit(void)
    93	{
    94	}
    95	static inline unsigned int swiotlb_max_segment(void)
    96	{
    97		return 0;
    98	}
  > 99	static inline size_t swiotlb_max_mapping_size(struct device *dev)
   100	{
   101		return SIZE_MAX;
   102	}
   103	#endif /* CONFIG_SWIOTLB */
   104	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--SUOF0GtieIMvvwua
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--SUOF0GtieIMvvwua--
