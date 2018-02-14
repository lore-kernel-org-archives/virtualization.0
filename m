From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [vhost:vhost 22/23] drivers/firmware/qemu_fw_cfg.c:130:36:
	sparse: incorrect type in initializer (different base types)
Date: Wed, 14 Feb 2018 03:31:58 +0200
Message-ID: <20180214033131-mutt-send-email-mst__4402.19268571145$1518571841$gmane$org@kernel.org>
References: <201802140843.NMqq2jAs%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201802140843.NMqq2jAs%fengguang.wu@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, netdev@vger.kernel.org, kbuild-all@01.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 14, 2018 at 08:46:46AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
> head:   3d22d7c1190db3209b644b8a13a75a9802b4587f
> commit: b3a8771f409b74c42deee28aee3092fc5d2c8dab [22/23] fw_cfg: write vmcoreinfo details
> reproduce:
>         # apt-get install sparse
>         git checkout b3a8771f409b74c42deee28aee3092fc5d2c8dab
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__

Please make sure there are no sparse warnings when you build
a driver.


> 
> sparse warnings: (new ones prefixed by >>)
> 
>    drivers/firmware/qemu_fw_cfg.c:108:28: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:108:28: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:108:28: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:108:28: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:108:28: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:108:28: sparse: cast to restricted __be32
> >> drivers/firmware/qemu_fw_cfg.c:130:36: sparse: incorrect type in initializer (different base types) @@ expected unsigned long long address @@ got gned] address @@
>    drivers/firmware/qemu_fw_cfg.c:130:36: expected unsigned long long address
>    drivers/firmware/qemu_fw_cfg.c:130:36: got restricted __be64
>    drivers/firmware/qemu_fw_cfg.c:131:27: sparse: incorrect type in initializer (different base types) @@ expected unsigned int length @@ got ed int length @@
>    drivers/firmware/qemu_fw_cfg.c:131:27: expected unsigned int length
>    drivers/firmware/qemu_fw_cfg.c:131:27: got restricted __be32 <noident>
>    drivers/firmware/qemu_fw_cfg.c:132:28: sparse: incorrect type in initializer (different base types) @@ expected unsigned int control @@ got ed int control @@
>    drivers/firmware/qemu_fw_cfg.c:132:28: expected unsigned int control
>    drivers/firmware/qemu_fw_cfg.c:132:28: got restricted __be32 <noident>
>    drivers/firmware/qemu_fw_cfg.c:142:13: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:142:13: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:142:13: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:142:13: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:142:13: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:142:13: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:96:33: sparse: restricted __be16 degrades to integer
>    drivers/firmware/qemu_fw_cfg.c:96:52: sparse: restricted __le16 degrades to integer
>    drivers/firmware/qemu_fw_cfg.c:96:33: sparse: restricted __be16 degrades to integer
>    drivers/firmware/qemu_fw_cfg.c:96:52: sparse: restricted __le16 degrades to integer
>    drivers/firmware/qemu_fw_cfg.c:96:33: sparse: restricted __be16 degrades to integer
>    drivers/firmware/qemu_fw_cfg.c:96:52: sparse: restricted __le16 degrades to integer
>    drivers/firmware/qemu_fw_cfg.c:96:33: sparse: restricted __be16 degrades to integer
>    drivers/firmware/qemu_fw_cfg.c:96:52: sparse: restricted __le16 degrades to integer
>    drivers/firmware/qemu_fw_cfg.c:660:17: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:660:17: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:660:17: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:660:17: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:660:17: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:660:17: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:96:33: sparse: restricted __be16 degrades to integer
>    drivers/firmware/qemu_fw_cfg.c:96:52: sparse: restricted __le16 degrades to integer
>    drivers/firmware/qemu_fw_cfg.c:670:31: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:670:31: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:670:31: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:670:31: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:670:31: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:670:31: sparse: cast to restricted __be32
>    drivers/firmware/qemu_fw_cfg.c:671:33: sparse: cast to restricted __be16
>    drivers/firmware/qemu_fw_cfg.c:671:33: sparse: cast to restricted __be16
>    drivers/firmware/qemu_fw_cfg.c:671:33: sparse: cast to restricted __be16
>    drivers/firmware/qemu_fw_cfg.c:671:33: sparse: cast to restricted __be16
>    drivers/firmware/qemu_fw_cfg.c:96:33: sparse: restricted __be16 degrades to integer
>    drivers/firmware/qemu_fw_cfg.c:96:52: sparse: restricted __le16 degrades to integer
>    drivers/firmware/qemu_fw_cfg.c:717:22: sparse: cast to restricted __le32
> 
> vim +130 drivers/firmware/qemu_fw_cfg.c
> 
>    103	
>    104	/* qemu fw_cfg device is sync today, but spec says it may become async */
>    105	static void fw_cfg_wait_for_control(struct fw_cfg_dma *d)
>    106	{
>    107		do {
>  > 108			u32 ctrl = be32_to_cpu(READ_ONCE(d->control));
>    109	
>    110			if ((ctrl & ~FW_CFG_DMA_CTL_ERROR) == 0)
>    111				return;
>    112	
>    113			usleep_range(50, 100);
>    114		} while (true);
>    115	}
>    116	
>    117	static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 control)
>    118	{
>    119		phys_addr_t dma;
>    120		struct fw_cfg_dma *d = NULL;
>    121		ssize_t ret = length;
>    122	
>    123		d = kmalloc(sizeof(*d), GFP_KERNEL);
>    124		if (!d) {
>    125			ret = -ENOMEM;
>    126			goto end;
>    127		}
>    128	
>    129		*d = (struct fw_cfg_dma) {
>  > 130			.address = address ? cpu_to_be64(virt_to_phys(address)) : 0,
>    131			.length = cpu_to_be32(length),
>    132			.control = cpu_to_be32(control)
>    133		};
>    134	
>    135		dma = virt_to_phys(d);
>    136	
>    137		iowrite32be((u64)dma >> 32, fw_cfg_reg_dma);
>    138		iowrite32be(dma, fw_cfg_reg_dma + 4);
>    139	
>    140		fw_cfg_wait_for_control(d);
>    141	
>    142		if (be32_to_cpu(READ_ONCE(d->control)) & FW_CFG_DMA_CTL_ERROR) {
>    143			ret = -EIO;
>    144		}
>    145	
>    146	end:
>    147		kfree(d);
>    148	
>    149		return ret;
>    150	}
>    151	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
