Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EAF85C46;
	Wed, 24 Apr 2024 03:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713929039; cv=none; b=QJrhXItTe5WCzeVWObJsN0ZnvR7OlUX8cVbHkF1TEsmWecVWkpoLAI7IkPLPtA7XcpiP0PoRlwaM48rwdauSd4g+NuExO0Ku6SkbSmnCYJZHZaFsc1rqLgw/mq7JeYt3Ow/TUVRl/AvIfWprXLx69vFwnNLYp3+db+a1Pd/WJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713929039; c=relaxed/simple;
	bh=2ilosTxuAhCUG2qY58ePq0iv0kOfTTUijwPy3GQzft4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Vs6Gv3yZw9Kpjyy7FPV4DRzT9XUUj1CFUqtQbjOMWbTeTHa1pVpgQ3YMz+IDPk+WcE6A3gvqprF4JVikKMwK/qjn4UbbvYNBFs4TkMspw4/tRUfWg/XQcLlNEiW7o+AkFqEvczghLkvHY4aj1m2bpabOiBKWZPI+YkAbpIcQgJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U9xwLpBk; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U9xwLpBk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713929035; h=Message-ID:Subject:Date:From:To;
	bh=TUh+RkRklYBJ+mkvjkcUkywnqg3ifKSp6udIGGXSugo=;
	b=U9xwLpBkODOtpfajSsuyTw1YcoVaOUpzjNlctdJ3l/DxOZ4YjkV8hyeRcV5D3I9T9iDjpDRzzpgfTAe6dnGWpwFLVG9S2bzm3hIuiUWkXbm+vw2VdaG3kEMEPgERziurc58JdB/+okqM55nnGCQHMCnpjc2mOnu1+dDKdPskkiA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0W5Alh-O_1713929031;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5Alh-O_1713929031)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 11:23:52 +0800
Message-ID: <1713928975.976684-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v8 6/6] virtio_ring: simplify the parameters of the funcs related to vring_create/new_virtqueue()
Date: Wed, 24 Apr 2024 11:22:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: <oe-lkp@lists.linux.dev>,
 <lkp@intel.com>,
 =?utf-8?q?IlpoJ=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jason Wang <jasowang@redhat.com>,
 <virtualization@lists.linux.dev>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Hans de Goede <hdegoede@redhat.com>,
 Vadim Pasternak <vadimp@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 <linux-um@lists.infradead.org>,
 <platform-driver-x86@vger.kernel.org>,
 <linux-remoteproc@vger.kernel.org>,
 <linux-s390@vger.kernel.org>,
 <kvm@vger.kernel.org>,
 <oliver.sang@intel.com>
References: <20240411023528.10914-1-xuanzhuo@linux.alibaba.com>
 <20240411023528.10914-7-xuanzhuo@linux.alibaba.com>
 <202404221626.b938f1d6-oliver.sang@intel.com>
In-Reply-To: <202404221626.b938f1d6-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 22 Apr 2024 22:26:23 +0800, kernel test robot <oliver.sang@intel.com> wrote:
>
>
> Hello,
>
> kernel test robot noticed "BUG:kernel_reboot-without-warning_in_boot_stage" on:
>
> commit: fce2775b7bb39424d5ed656612a1d83fd265b670 ("[PATCH vhost v8 6/6] virtio_ring: simplify the parameters of the funcs related to vring_create/new_virtqueue()")
> url: https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_balloon-remove-the-dependence-where-names-is-null/20240411-103822
> base: git://git.kernel.org/cgit/linux/kernel/git/remoteproc/linux.git rproc-next
> patch link: https://lore.kernel.org/all/20240411023528.10914-7-xuanzhuo@linux.alibaba.com/
> patch subject: [PATCH vhost v8 6/6] virtio_ring: simplify the parameters of the funcs related to vring_create/new_virtqueue()
>
> in testcase: boot
>
> compiler: gcc-13
> test machine: qemu-system-riscv64 -machine virt -device virtio-net-device,netdev=net0 -netdev user,id=net0 -smp 2 -m 16G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +-------------------------------------------------+------------+------------+
> |                                                 | 3235a471eb | fce2775b7b |
> +-------------------------------------------------+------------+------------+
> | boot_successes                                  | 30         | 2          |
> | boot_failures                                   | 0          | 28         |
> | BUG:kernel_reboot-without-warning_in_boot_stage | 0          | 28         |
> +-------------------------------------------------+------------+------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202404221626.b938f1d6-oliver.sang@intel.com
>
>
> Boot HART PMP Granularity : 4
> Boot HART PMP Address Bits: 54
> Boot HART MHPM Count      : 16
> Boot HART MIDELEG         : 0x0000000000001666
> Boot HART MEDELEG         : 0x0000000000f0b509
> BUG: kernel reboot-without-warning in boot stage
> Linux version  #
> Command line: ip=::::vm-meta-11::dhcp root=/dev/ram0 RESULT_ROOT=/result/boot/1/vm-snb-riscv64/debian-13-riscv64-20240310.cgz/riscv-defconfig/gcc-13/fce2775b7bb39424d5ed656612a1d83fd265b670/6 BOOT_IMAGE=/pkg/linux/riscv-defconfig/gcc-13/fce2775b7bb39424d5ed656612a1d83fd265b670/vmlinuz-6.9.0-rc1-00009-gfce2775b7bb3 branch=linux-review/Xuan-Zhuo/virtio_balloon-remove-the-dependence-where-names-is-null/20240411-103822 job=/lkp/jobs/scheduled/vm-meta-11/boot-1-debian-13-riscv64-20240310.cgz-fce2775b7bb3-20240417-37917-x2hsv1-16.yaml user=lkp ARCH=riscv kconfig=riscv-defconfig commit=fce2775b7bb39424d5ed656612a1d83fd265b670 nmi_watchdog=0 intremap=posted_msi vmalloc=256M initramfs_async=0 page_owner=on max_uptime=600 LKP_SERVER=internal-lkp-server selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw rcuperf.shutdown=0 watchdog_thresh=240 audit=0


cmd: ~/lkp-tests/bin/lkp qemu -k build_dir/arch/riscv/boot/Image  -m modules.cgz job-script

Boot HART ID              : 1
Boot HART Domain          : root
Boot HART Priv Version    : v1.12
Boot HART Base ISA        : rv64imafdch
Boot HART ISA Extensions  : time,sstc
Boot HART PMP Count       : 16
Boot HART PMP Granularity : 4
Boot HART PMP Address Bits: 54
Boot HART MHPM Count      : 16
Boot HART MIDELEG         : 0x0000000000001666
Boot HART MEDELEG         : 0x0000000000f0b509

I do not encounter this problem.
Do I miss something?

Thanks.



>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240422/202404221626.b938f1d6-oliver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
