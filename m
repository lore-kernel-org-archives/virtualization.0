Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535685;
	b=pQhhvWU9er/YerJuelZfqjQivAn0mMY4M8UwJsyrAz10TejZrGMl7Agc34CspDN9tnvN
	 +VYiAn7nmqJXYuzT2exa5eIVhDY1utk/KZG6QAbx5BUkg0K2WTPC4S0ehAe0fQu04NhtK
	 ErFuGQLTk5dVkeQubD3SBoCn2OI4MVIqOXUnntlXDyxSpyh5Apy+y+Sj62NZWaDy4zOLe
	 UmcvDc7aHsSedAd+CfYPhTOYgANdRdMh2KBCbxH6+IAzhVl8sT16EZbFvSNSHaX5MILbQ
	 BNNSubrd1LXwD+YIlMMn1R8oROV8/YXl4xrehYkMoNZa/s5VH95zINOIGZfsK8C3ZeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535685;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0w7QXUVXmIm3EB7GxYB5JSVUXsOWBCtKE77V5GJ69Gw=;
	b=XEp6G462KT9QO4w/27e6t+2WB9PHFJS+5FsfNdOsMXeLNw5X6a6Em4F53zmk+BLG1e6u
	 nwTsj+uyxA/ALC1j46XbIVbPsgaPJ5sVHAXt2mCzg4Ku/0MQ7aqjArrB2ixMJq7avA1Ce
	 1guIxTp2UNzwfG2YsXTVxQ5QjPsSTaFwZvufbnepjBuGBeZxWONFLXh81siFxE/Qv8WgJ
	 AYTxFzTesJAHFy08siFZPLq+7K4s3O455j9M8i/fG/IRspSSnHMd73mDsBe1sbOBFYbc1
	 gG+o4XtII/ACmqy6ZYvFYOt59f9Jh8tytmL+NbDprLLdxxoEl8DIWZOIeMiubl9yzuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ENj9LjHe;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664B60A262F;
	Tue, 24 Nov 2026 15:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C664B60A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ENj9LjHe
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFYa3X2805574;
	Tue, 24 Nov 2026 15:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0w7QXUVXmIm3EB7GxYB5JSVUXsOWBCtKE77V5GJ69
	Gw=; b=ENj9LjHeg3D/5KNeuTe/O4rWa/YFH/R8QQrJ/HqFb56+/C1dzoZyXAkb+
	QDuFs50T4QlgSbcT6SdHgjdtft7c2cxMboj8k3WP5nvPeid/DqOobRofd14tEvqe
	ASHzouM3JohX92j88iblu8C4w3e0suLpFQtE5f6zqZAOuiML/0dz0lEYY1tbiguc
	3PtxplvEuyM1AZvfQjD5qF8s7GpVUfvnkgO83u85RU/aMG5ihOqKsS3Dbf+MkM5R
	Mc/MSY1mdZLf6rGytJhINeF5tfD6vG9RtGwwA0VnFVDNUPNttxwsdFSTN2xd0/gq
	Yh+0kbogqklUitVoWkDKq9TJxASVg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv82nx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:54:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFJLHv495634;
	Tue, 24 Nov 2026 15:54:13 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4hb1sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:54:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOFrKMD31720026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 15:53:20 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A57ED5805C;
	Tue, 24 Nov 2026 15:54:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 153D458051;
	Tue, 24 Nov 2026 15:54:11 +0000 (GMT)
Received: from li-505aefcc-3230-11b2-a85c-f1e8e6da9e06.pok.ibm.com (unknown [9.105.76.126])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 15:54:10 +0000 (GMT)
From: Cam Miller <cam@linux.ibm.com>
To: jpb@kernel.org, joro@8bytes.org, will@kernel.org
Cc: robin.murphy@arm.com, iommu@lists.linux.dev,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [RFC linux v1 0/3] iommu/virtio: fix remove
Date: Tue, 24 Nov 2026 10:54:07 -0500
Message-ID: <20261124155410.768743-1-cam@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b05b325 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=SqMvC5kiAAAA:8 a=Ad2mtP5WQe4-xdD8JBkA:9
 a=_o8VnCo6Hb5Oqlm6Mk7M:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2MSBTYWx0ZWRfX0Uvzki3TdoVm
 /VGhp3MUoWWHmEaJkiio2D0qQNBpXsfsNPm/qAsWpA9waos2CKYM/Mdk1F1d8QcQeKgPAQHQnUX
 GnCH64tW/zX0In1qCiG2IFKsWLyBUwU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2MSBTYWx0ZWRfX8y0Uri6vUQMJ
 OLHSYkx00Me7i6EJXebCisA0GvpSON+wuH/2UsXWzzWKvDEgtWqvRFOToknCjs+fJUqUtqOev49
 WHRei23u5FPKM2caj+V5IsF1CsVV6f70bx93soOO1vtTHJNUsBtIwGgM5CK4jk1BjvDNpdlP5BY
 IcURs3Kp6W5H4A6T1O7aH0FA2xcrGhirs/Bnn0KoEhqXddCviQj5HB0AQG0f0BxnP5237edK6kb
 ntm+SfbiYXZ0/eei81MHqhfYzgOf+owTO6ZxXa9cL+e630qofB7iE46mmV9eieSyEv+vgrUO18T
 g43reqOGhT8TqSlGWCif98EbGfgkD35iIG/8yj/w4Ultly3ZNLs3ELNrPK+gnJuLDqLy+gQeKCG
 MJg+qY0zSm01EBet+ULv8dDdif8YVu/kdrx0axsOmnmhOb3V/8ViN18R0RazbS4P6tK3C0XLXt6
 mX3YzUm0xngpx1f1rZQ==
X-Proofpoint-ORIG-GUID: q6I2LZElTTkzgNIoMwKMp9fbSQ39lzBi
X-Proofpoint-GUID: q6I2LZElTTkzgNIoMwKMp9fbSQ39lzBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240061

This series allows for hot-removing a virtio-iommu device via sysfs to
succeed, by fixing 2 separate day 1 bugs.

Patch 1 addresses a NULL pointer dereference due to a pair of
out-of-order calls. Patch 2 prevents driver unbind via
suppress_bind_attrs. Patch 3 unbinds IOMMU endpoint drivers before
removing the IOMMU.


Bugs
----

Before patch 1, attempting a removal caused the following kernel crash
on x86.

  BUG: kernel NULL pointer dereference, address: 0000000000000030
  --- snip ---
  RIP: 0010:sysfs_remove_link_from_group+0x10/0x40
  --- snip ---
  Call Trace:
   <TASK>
  --- snip ---
   ? sysfs_remove_link_from_group+0x10/0x40
   iommu_deinit_device+0x2a/0xe0
   __iommu_group_remove_device+0xb0/0xe0
   ? __pfx_remove_iommu_group+0x10/0x10
   remove_iommu_group+0x35/0x60
   bus_for_each_dev+0x83/0xd0
   iommu_device_unregister+0x3d/0xb0
   viommu_remove+0x25/0x60
   virtio_dev_remove+0x3c/0x90
  --- snip ---

After resolving this bug with patch 1, a 2nd bug was exposed. Live
endpoints remain active after unregistering the IOMMU. All their IOVAs
become stale, causing page faults.

The following warning catches this case.

  WARNING: drivers/iommu/iommu.c:743 at __iommu_group_free_device.constprop.0+0xb9/0xe0, CPU#1:
bash/1250
  --- snip ---
  Call Trace:
   <TASK>
   __iommu_group_remove_device+0x95/0xe0
   ? __pfx_remove_iommu_group+0x10/0x10
   remove_iommu_group+0x39/0x60
   bus_for_each_dev+0x85/0xd0
   iommu_device_unregister+0x3d/0xb0
   viommu_remove+0x1d/0x60
  --- snip ---

As a consequence, endpoint drivers attempting IO hang.

  igb 0000:01:00.0 enp1s0: NETDEV WATCHDOG: CPU: 5: transmit queue 2 timed out 5120 ms
  igb 0000:01:00.0 enp1s0: Reset adapter
  igb 0000:01:00.0 enp1s0: igb: enp1s0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
  clocksource: Watchdog remote CPU 7 read timed out
  igb 0000:01:00.0: Detected Tx Unit Hang

Shutting down the system at this point leads to a kernel panic.

  BUG: unable to handle page fault for address: ffffee9903ffffc0
  --- snip ---
  RIP: 0010:dma_free_contiguous+0x59/0xb0
  --- snip ---
  Call Trace:
   <TASK>
   __igb_close.isra.0+0xb0/0x1c0 [igb]
   __igb_shutdown.isra.0+0x27a/0x310 [igb]
   igb_shutdown+0x2f/0x90 [igb]
   pci_device_shutdown+0x35/0x60
   device_shutdown+0x118/0x1b0
   kernel_power_off+0x35/0x80
   __do_sys_reboot+0x1d4/0x240
   do_syscall_64+0xbe/0x470
   ? vfs_writev+0xe8/0x3c0
   ? do_writev+0x7f/0x110
   ? do_writev+0x7f/0x110
   ? do_syscall_64+0xfa/0x470
   ? do_user_addr_fault+0x2ae/0x7b0
   ? irqentry_exit+0x40/0x730
   ? do_syscall_64+0x37/0x470
   ? __irq_exit_rcu+0x4c/0x110
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  --- snip ---

Patch 3 resolves this bug using device links. These links ensure that
the IOMMU endpoints get unbound before viommu_remove() runs.


Testing
-------

I tested this patch using a libvirt-managed q35 qemu machine (i.e. x86 guest).

I used default-bus-bypass-iommu=true and placed root disk (as well as
other devices) on the default bus. This way, access to the root
filesystem was not affected by the IOMMU removal.

Libvirt domain XML:

  <domain type='kvm'
    xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>
    <os><type arch='x86_64' machine='pc-q35-9.2'>hvm</type></os>
    ...
    <!-- second host bridge, not bypassed -->
    <controller type='pci' index='15' model='pcie-expander-bus'>
      <target busNr='32'/>
    </controller>
    <controller type='pci' index='16' model='pcie-root-port'>
      <address type='pci' bus='0x0f' slot='0x00' function='0x0'/>
    </controller>
    <!-- test endpoint, behind the root port -->
    <interface type='user'>
      <model type='igb'/>
      <address type='pci' bus='0x10' slot='0x00' function='0x0'/>
    </interface>
    <iommu model='virtio'>
      <address type='pci' bus='0x00' slot='0x04' function='0x0'/>
    </iommu>
    <qemu:commandline>
      <qemu:arg value='-machine'/>
      <qemu:arg value='default-bus-bypass-iommu=true'/>
    </qemu:commandline>
  </domain>

Guest topology (abridged `lspci -tv`):

  -+-[0000:00]-+-00.0  Intel Corporation 82G33/G31/P35/P31 Express DRAM Controller
   |           +-01.0  Red Hat, Inc. QEMU PCIe Expander bridge
   |           +-02.3-[04]----00.0  Red Hat, Inc. Virtio 1.0 block device   <- root disk
   |           +-04.0  Red Hat, Inc. Virtio 1.0 IOMMU
   |           ...
   \-[0000:20]---00.0-[21]----00.0  Intel Corporation 82576 Gigabit Network Connection

Device links created:

  # ls /sys/class/devlink/ | grep virtio0
  virtio:virtio0--pci:0000:20:00.0
  virtio:virtio0--pci:0000:21:00.0
  # cat /sys/class/devlink/virtio:virtio0--pci:0000:21:00.0/status
  active

Removal:

  # echo 1 > /sys/bus/pci/devices/0000:00:04.0/remove
  [  146.791872] igb 0000:21:00.0: removed PHC on enp33s0
  [  147.538710] virtio_iommu virtio0: device removed

I also tested removal with DMA in-flight.  I removed the IOMMU while running
iperf3 from the guest to the host (SLIRP backend).

  # iperf3 -c 10.0.2.2 -t 120 -i 5 &
  ...
  [  5]  10.01-15.01  sec   109 MBytes   183 Mbits/sec    0   68.4 KBytes
  [  5]  15.01-20.01  sec   110 MBytes   184 Mbits/sec    0   68.4 KBytes
  # echo 1 > /sys/bus/pci/devices/0000:00:04.0/remove
  [  5]  30.00-35.01  sec  65.1 MBytes   109 Mbits/sec    1   1.43 KBytes
  [  5]  35.01-40.01  sec  0.00 Bytes  0.00 bits/sec    0   1.43 KBytes
  ...
  # dmesg | tail -n4
  [  234.227669] clocksource: Watchdog remote CPU 15 read timed out
  [  260.920027] igb 0000:21:00.0: removed PHC on enp33s0
  [  261.578453] virtio_iommu virtio0: device removed

The transfer stops because the NIC is unbound, as expected.

Rebinding an endpoint after the removal succeeds.

  # echo 0000:21:00.0 > /sys/bus/pci/drivers/igb/bind
  igb 0000:21:00.0: deferred probe timeout, ignoring dependency
  igb 0000:21:00.0: added PHC on eth0
  igb 0000:21:00.0 enp33s0: igb: enp33s0 NIC Link is Up 1000 Mbps Full Duplex

Rebooting after removal completes cleanly, resolving the oops. After
reboot, the links are active again and everything works.

Thank you.


Cam Miller (3):
  iommu/virtio: Fix out-of-order teardown in viommu_remove()
  iommu/virtio: Prevent driver unbind via sysfs
  iommu/virtio: Add device links for endpoints

 drivers/iommu/virtio-iommu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.54.0

