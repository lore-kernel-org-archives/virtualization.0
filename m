Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5200C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 12:38:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1903664ED3
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 12:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1903664ED3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DBC9606D6;
	Wed, 24 Feb 2021 12:38:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wnLCTn4txVql; Wed, 24 Feb 2021 12:38:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36100605AC;
	Wed, 24 Feb 2021 12:38:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C784C000A;
	Wed, 24 Feb 2021 12:38:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37049C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 12:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 138B8605D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 12:38:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SfXKb3ojzlu2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 12:38:08 +0000 (UTC)
X-Greylist: delayed 00:07:25 by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 271C6605AC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 12:38:08 +0000 (UTC)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11OCRmhp127435; Wed, 24 Feb 2021 07:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sDGC3IlHnY0OT5SHt5UoDvKYvNTYjnotwLh/JHfl0AQ=;
 b=m0FTg3y/GgC3VwoBsf/sPzK4i5i5Mmn4Dkh7nYS43xoxkXxYrna1o83rsOHeywFpsV+K
 42M9/2DjSNo2+8+16bL99hdE7Qwwxfwboz4dH7maxz4jpfcekDyZ7c047OZZdpnpx92P
 sNAX1JuaPQ/iv0cPq4sgk0DYEkQ8hER3cbg1ZmL+wNGgU0mi+1QwZfuGU9mzrrTcALHz
 lywYuuIgomS/Mp7ZjcbLDcQXMoIW6eXV6UfJr98VzvljXqVPMyWhXabj5xorBZ6mtmb6
 sJ/yJt1vywD5KyIpl022gTHlqjF7N+OLai9AU/DE4sXefdUTVhDpjxDLqbUUXRZ2JBzb tw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 36wptrr23r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Feb 2021 07:30:36 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11OCTIDr130659;
 Wed, 24 Feb 2021 07:30:34 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 36wptrr229-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Feb 2021 07:30:34 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11OCN4ML003610;
 Wed, 24 Feb 2021 12:30:30 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma04fra.de.ibm.com with ESMTP id 36tt289v2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Feb 2021 12:30:30 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 11OCURjk34013614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Feb 2021 12:30:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB4904C046;
 Wed, 24 Feb 2021 12:30:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE97D4C050;
 Wed, 24 Feb 2021 12:30:26 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.95.10])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 24 Feb 2021 12:30:26 +0000 (GMT)
Subject: Re: [PATCH V4 1/3] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com
References: <20210223061905.422659-1-jasowang@redhat.com>
 <20210223061905.422659-2-jasowang@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <536d6fe7-f4b1-09bb-0883-b03d6f60a229@de.ibm.com>
Date: Wed, 24 Feb 2021 13:30:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210223061905.422659-2-jasowang@redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-02-24_04:2021-02-24,
 2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102240096
Cc: shahafs@mellanox.com, Anders Roxell <anders.roxell@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju <naresh.kamboju@linaro.org>,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Guenter Roeck <linux@roeck-us.net>
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



On 23.02.21 07:19, Jason Wang wrote:
> We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
> lot of confusion. E.g it may break various default configs which want
> virtio devices.
> 
> So this patch fixes this by hiding the prompot and documenting the
> dependency. While at it, rename the module to VIRTIO_PCI_LIB.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 86b87c9d858b6 ("virtio-pci: introduce modern device module")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Michael,

Can we please add this NOW to next? virtio-pci is broken without it on
many defconfigs including s390. So linux-next is broken for more than 
2 weeks now and it actively breaks several parts of our CI.
I guess there are other CIs that will not run several testcases because
of this. And Naresh reported that on Feb 9th.
There IS value in CI tools on next. Not caring about regressions introduced
by a tree in next is harmful. Especially when we are close or in the
merge window. So please: either fix things quickly OR revert.

Christian



> ---
>  drivers/virtio/Kconfig  | 11 ++++++-----
>  drivers/virtio/Makefile |  2 +-
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 6b9b81f4b8c2..ce1b3f6ec325 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -12,13 +12,13 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>  	  This option is selected if the architecture may need to enforce
>  	  VIRTIO_F_ACCESS_PLATFORM
>  
> -config VIRTIO_PCI_MODERN
> -	tristate "Modern Virtio PCI Device"
> -	depends on PCI
> +config VIRTIO_PCI_LIB
> +	tristate
>  	help
>  	  Modern PCI device implementation. This module implements the
>  	  basic probe and control for devices which are based on modern
> -	  PCI device with possible vendor specific extensions.
> +	  PCI device with possible vendor specific extensions. Any
> +	  module that selects this module must depend on PCI.
>  
>  menuconfig VIRTIO_MENU
>  	bool "Virtio drivers"
> @@ -28,7 +28,8 @@ if VIRTIO_MENU
>  
>  config VIRTIO_PCI
>  	tristate "PCI driver for virtio devices"
> -	depends on VIRTIO_PCI_MODERN
> +	depends on PCI
> +	select VIRTIO_PCI_LIB
>  	select VIRTIO
>  	help
>  	  This driver provides support for virtio based paravirtual device
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index f097578aaa8f..699bbea0465f 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
> -obj-$(CONFIG_VIRTIO_PCI_MODERN) += virtio_pci_modern_dev.o
> +obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
>  obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
>  obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
>  virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
