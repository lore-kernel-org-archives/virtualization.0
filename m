Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912067;
	b=LisG40CPpNFdKdfrPGg5nUlGY4Cc6pK6tpU3+XGFX2F+Vtd+zUOWSl6hoiGMPcS7oZaC
	 PAViy6TP2L4sVBVRdtWeiOLBjuNHcmI2B8bkJVINMIJRhXYZbErADf835xCEC5wxx+zO/
	 ZB19mIE7Sk17+KXfQqOYj1uTZeAEcwBgIbpySdfFuLUa9lsyxT/VDKw1D/Q86wjTpksVc
	 p6uUtJwlyCE1ogSc9bQnJ3yWgoyXHqKBoaiqPfEq9/XcrKkFwpZg2Xl4Um1bE30CwQGYr
	 F7eZ1jrQ3VGeLI0Q7Gt4EueesFCHh7H2RWNpKtC2bP2OgEZ/meHeoVdbkM8/8Si5hww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912067;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:From:To:Subject:Cc:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BYNswcPZGDgSK67bMtBFGEMHtpEdBrVLSwJpO1RCMQI=;
	b=0MfwrKW4DdYGdrk8EjIL7tTxa7Iz2msWuOZZYiUNvkCd9Ib98/9PsL2SS21XHc+dbHh6
	 ODTZMfNkVJZQ8snuBgORhY2y10MVAEcIE27rCdpFwZtGMh5XF6RIQ9kWg4jIqvF0OLXvN
	 EogR+NlE7/PdcKFTHrVoKbSC6RhUssTyxn0z7PgGuc3G3j+Sa8mL8ie2OLzcBgh6O1YgG
	 XmoX40/qzzfv0QO/z6c3hciQ6A6rcSRrDZMZ9Cp1B89l+9mxFcot1ixh7sHCiE2pa5V1l
	 weCDMfff35A4PAQImiDhWy7ofu0KyLMtbdl58A+txOmPfLPGa+xvTz4Fs7aEPK6ePcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S7Q9t4Fc;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B3A606A31B;
	Thu,  5 Nov 2026 20:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09B3A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S7Q9t4Fc
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5HiJ9Q008383;
	Thu, 5 Nov 2026 20:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=BYNswcPZGDgSK67bMtBFGEMHtpEd
	BrVLSwJpO1RCMQI=; b=S7Q9t4Fcp5/uJn5pR3EevUNem54QQKvOoVNL9rvlIsjB
	7XCVcLLvVW/jKJ6JBsRutjEWmX5DBPOLiYxWwGlZ/MxAuOzY6HZAYDQ7vr4sDU7F
	fkx25N6Uys32YF5qupF2Pc8b38z7fmFoTdu2lRFxLxIHy56X4qfFvB/TLMNTsD8w
	ftrP9BqO/5IutTBjq2915MGwI8stsQffwRHYW1z2/rEC5yjTMpHnsULGyL2PEss5
	4HDULA2Eysg1ZTfiWHxueRt7aQxEPlBpGbzcUtY5oDo4G6wIAyCBdeoE0FADiQLP
	p9/1Rhmb1dkRR5lAjSMoErWtduXF03QbaNOU62Eqqg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7yscdva-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 20:54:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5I4xFf2035786;
	Thu, 5 Nov 2026 20:54:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v2aa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 20:54:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5KrWFc22610466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 20:53:32 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 384AC5805A;
	Thu,  5 Nov 2026 20:54:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D93F058052;
	Thu,  5 Nov 2026 20:54:20 +0000 (GMT)
Received: from [9.105.76.126] (unknown [9.105.76.126])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  5 Nov 2026 20:54:20 +0000 (GMT)
Message-ID: <6e6eaf23-9194-488b-8961-63cc062024ca@linux.ibm.com>
Date: Thu, 5 Nov 2026 15:54:20 -0500
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Cam Miller <cam@linux.ibm.com>
To: virtualization@lists.linux.dev, iommu@lists.linux.dev, jpb@kernel.org
Subject: iommu/virtio: design question: hot-removal allowed?
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6aeced00 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=4U0PJRJ9yvyAoT9MvQIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX4MgUzdAXhZzl
 ITWwmHkKwIQh/ctmnb6QwmDq7wWnmOShltGD0pU7UobUcuzJwL+2xujLEz7NflLPsySHQiJp85A
 +aXENF776P52QxtBlncU2AK84aWqy/I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX6R6cWq/PWEys
 7t98IYOR6pxMoMDyB6Dvi2fnMW/Ll9KoEsx/LbQb0lZOJp7cZMnZDYGEljuy8sBetWK0lLjDEQD
 K0geTGyYV8c9jQBvDVf6G0DO1PDuzrLhzvZpMv5jQhwkAFibe2zuVey5Zmtb418X2Olzuwe+rDu
 gItzlLYM+qztyTQ7yp7PcQt1F0ysA+GXvCOQhWCWgbO/FDvfACOavaw/PVI7w2zSY3KW0irS08S
 P/OxEkx3rjAxYqPpBQNOjnOT4JQIQtzPHK9Bpjm1DF3FrYq7Gk2Yh4o76lyGFD4W6WpM8oTF1tC
 iHBXpe2vRnLL5/IEsay32A5W5fAOvx6N3Vi3QUvSkmzyEYsIrGdx7kWy1/r1hAlFT1UAvMEuUOI
 1twD9q78DBYFzBUsLh/CmK3JSrqr+qrmV7e2qI2diaJEk49vTIUyLYyvrT02fdU4LxyeGl0Sj/N
 mrmDl3xPPc4m1l/Gg7Q==
X-Proofpoint-GUID: hIfhNxgk7FEdllp1oliPlI7511L-9pMK
X-Proofpoint-ORIG-GUID: hIfhNxgk7FEdllp1oliPlI7511L-9pMK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050082

Hi,


Testing on x86, I noticed that userspace supplies a mechanism for hot-removing a virtio-iommu device.

  echo 1 > /sys/bus/pci/devices/<virtio_iommu_dev>/remove

Hot-removing virtio-iommu should NOT be supported, right? The intention is clear in the QEMU source,
which fences off hot(un)plugging virtio-iommu devices.

If I am correct, then shall we fence off hot-removal (perhaps by simply omitting this remove file
from sysfs)? Else, keep reading...

...I believe I have found two bugs in viommu_remove() path that I would like to bring attention to.
The first bug is that the echo above causes the following kernel panic.

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

Here is a fix:

  diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
  index 587fc13197f1..a08474eeed58 100644
  --- a/drivers/iommu/virtio-iommu.c
  +++ b/drivers/iommu/virtio-iommu.c
  @@ -1254,8 +1254,8 @@ static void viommu_remove(struct virtio_device *vdev)
   {
   	struct viommu_dev *viommu = vdev->priv;

  -	iommu_device_sysfs_remove(&viommu->iommu);
   	iommu_device_unregister(&viommu->iommu);
  +	iommu_device_sysfs_remove(&viommu->iommu);

   	/* Stop all virtqueues */
   	virtio_reset_device(vdev);

Other IOMMU drivers order iommu_device_unregister() before iommu_device_sysfs_remove(). I would be
happy to elaborate on how exactly I believe that the reverse ordering leads to the NULL pointer
dereference, if desired.

After applying the fix shown above, a second problem is exposed. Unregistering the IOMMU while
endpoints remain active is like pulling out the rug from underneath those endpoints. The following
warning catches this case.

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

Moreover shutting down the system at this point leads to a kernel panic. I believe treating stale
IOVAs as a physical addresses is what causes the page fault.

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

As a crude test, I added a loop to the beginning of iommu_device_unregister() that calls
device_release_driver() on each endpoint. With this change, no longer do the kernel panics/warnings
occur. But still, obviously all PCI IO is remains broken at this point.

...Point being that hot-removing virtio-iommu is currently broken.

In summary:
- Should hot-removal be supported/allowed?
- If no, then how shall we fence it off? Via sysfs?
- Else, there are some bugs that need to be fixed (and I would be happy to work on that if that is
not already evident).


Thank you,
Cam
