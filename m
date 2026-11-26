Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795687443;
	b=QzVQUMfRUoy33/r7VtkVPLWs0z5Wy7fXQ+jOA18pokFLBxgsLFSzZENuW63AgjI5WCuK
	 PZmdCoxaY+BUpbLVaAqOLI6LgCa5zuciXfWb11t7aYV3Z/gjNGj6A0Hl5tJi9MDgc1OaT
	 7/j1mF6MIfORSlEV5sxMzTBxslXBJjTe/ilLan0U/LdqE8rZiEXyeo/6owlFaMJj29evQ
	 B3LAI2kxK1uCR7vNXMMGOJdNgLbVi5/L3kEwd3u7JJMipRuAXm2lxssyabvtUWBAnEvfT
	 Ok7lJlPdbu0vQFFjZCWqYzYbQHHxSkJSaTv9qWJLDMaVeNa5hEZ/VoEX1XuTjGFezQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687443;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=AnhYG98epmOlL/nJZmae6Tnb19IOlGihaMzySm6TLlY=;
	b=OYuH/9P3LvCsR/583SY1oWlhmjoDM5E+a6BffqIXCUmhNtPz6F4mpQ/paYtVABLEYvH8
	 BSq9dfIV3XvQPqgwDyYOWBUzicChWhqB1vjBunNwvxiwV4NSmEa+sw7cThPCNg0tyGd3i
	 PSylE0szjVj4DxvZ0Ab6DPxDFVljxsvINeyiX6sM8VxrzXQcgxMt/T8BfHXNl31UFUQ4Z
	 wUM82b11bIrsgoY81i7Nl21rKG8yH8KJq/G2RSZLl/axkpZfgP4VD8ze+lVHxJfQdqpF2
	 zgx3XYjDxr1TawBNCTStIG0PA6GaU3WBOE0sidhwVWy3m/y94MDt1ilzjJxQl6lMK+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YvCNB1KV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="YUtu2/tN";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24412606A31C
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 10:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24412606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YvCNB1KV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YUtu2/tN
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7B4aU2595120
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 10:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AnhYG98epmOlL/nJZmae6Tnb19IOlGihaMzySm6TLlY=; b=YvCNB1KVTF4sdh2Q
	uiTkomCtxUq/ILFO/ztOnZcJUKany0NwCoRajo2x4lDXeosmopZfFsRounVGJby9
	UQ1VanPnOS6FogxKw8JUCP5IwiIyMBg+BuJtHU4NTy5GDhcTO1TCxkGFXsgHJvvh
	z+rG3huR5rwgFpLjyBnAEM2kAudGCTpFzdg7p0plSsVQTuWUeKcPxHehH0GHcEpv
	iAh7yEtyxyp14QopM1zyhtFElEnhB1ZRMkMj0+a+Thc/ra/csD4Wj31FyhIpW3vv
	NBsW4MtOM4UdSJ149BYVUNJopXLXH2oEtOfeXtoROMO+onq60Lv2VhQzD1frmpcA
	AdT+4w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662sam6u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 10:04:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so8134171a91.3
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 02:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795687440; x=1796292240; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AnhYG98epmOlL/nJZmae6Tnb19IOlGihaMzySm6TLlY=;
        b=YUtu2/tNhJK9xgt+ZRSBCvI6H4Ao9sN2nEL5kodZhZIE9zUvepTTSk/RT+ykDeVcY5
         uLTyF5E45J6iN1cplZc1W0RtcAQip+tzp9gxPaBfsplOec/dwQyyoAIsamLSyZqoSlfV
         AezB7AplZgTMGSZPAeRttfYOq3LLmWlo1qwC/ZuzSmL/G1nkDq/1SF+DM+IlSlVxPyPu
         5Nq0DucjcMRFQxKIvT43yg9EBruIGVL392q4ImOO9rx9s0/rHaXm9n27Q/VFaC/UzHb8
         D6Zll6+NAhQLneaYszQ55MPX3nc1os45/ilI8h3xq1s1+FD4bv85DUcGuwyO/F61JQKr
         UmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795687440; x=1796292240;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AnhYG98epmOlL/nJZmae6Tnb19IOlGihaMzySm6TLlY=;
        b=wUPlQh2oSNYOIcwZSkQTWpz6E44XboykVD1fR/AM6Z8O1OIMHXDnAL7wHVTwFWvCZP
         sEUHr7E9ka5Z2wKyzQ3ucMMZjM5uak3+dOau5BdaJ5B/WPO8gtR5XJldqbsUSq1E7MGv
         6uLc5n1s0Ijrrn3x6yN+Vd4Mq3O7Pb4YwhRZzHWO+mFt6+3UYFGRJpV0XhyqAO9uz4Lm
         bYL74Hpbc6U61BqFlBP0/AzNjTcY/OM/aIrgW321mSLUPnHZ/a2Xq6UfItjLY8Tk3jAm
         HvASN/fs1sOmH5Q5e8tx/mNPopNiIKChGkgwPgiLoXpipji9g3UUnH3PdlWB5c+JrpEi
         6NYQ==
X-Forwarded-Encrypted: i=1; AL+hErGbVG6IqL0p1ps6ZdCujqqot6wLWkNUrgMRgj6e7cA+Qc5k02U4dw72CFtNvUmVEtWrDUDFFNCfEz+rwE5w3A==@lists.linux.dev
X-Gm-Message-State: APuU4Z83AlLBMyoqpNl61l2uz03gvvNO5s/L/QiMF7reI1qt9s6UpgkK
	kgh4ZC4Rxwx4XmUZOeD1c6DwRuJc6hN3/Imb8zUEkNlbLb/XYHXN5PtEGxNCeq6H2NBQQY4FkZL
	K7kaiQxe7l7Rhx7LY1BxlQ4zriPDJIak3JxPFuYwly2DieTkXtaekeL9mxVN31XMdOEGI8g==
X-Gm-Gg: AZFdTZcDl2bCNN+gPQJdO8lxaQXQs69cLO/VeeoGGAknFMC9lWeXMqn+zM6NAo2hiFt
	ShpXCVl3DUKJ/iJdBsZJBSxVtEjIOByAsUgiEVcRmJstVDUngvnMNI/zTucWimacOclH2Duxs0I
	QgV0fOL51a0e4FYgiqQt6YfFr/jAW8/umgQ4+qOcZ3risPT6BBdRjcUPz6/R3k2NAYVJGDCifce
	OS67f+v55fIrwPJeDWzpPejHOJVcqtDYB3pMJWFvDqL7siuD96IGn7DCughyl41rdPAmr8p7WyC
	KwOD98ax65xN5db7eGLlsZYJNMYWo/ZjfbWFRsTK1EQ/cuGVXncAJBEgO7qvXa37ixbAZx+YH7/
	0z0mdJVNMOyDD3gEeFIkCIgqCqTeWzo3k4D2Mo3sEYHBoOl4j/tozTtssbkSiCHDABvugQZ8IhE
	UqGMjjvYKb
X-Received: by 2002:a17:90b:50:b0:3b4:139d:33ba with SMTP id 98e67ed59e1d1-3b41c7e166amr20648440a91.4.1795687440222;
        Thu, 26 Nov 2026 02:04:00 -0800 (PST)
X-Received: by 2002:a17:90b:50:b0:3b4:139d:33ba with SMTP id 98e67ed59e1d1-3b41c7e166amr20648396a91.4.1795687439486;
        Thu, 26 Nov 2026 02:03:59 -0800 (PST)
Received: from [10.91.115.190] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4dfbe54a2sm11254010a91.17.2026.11.26.02.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 02:03:59 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <1515086f-ff6c-4a4e-b74e-f43b13eed713@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:33:53 +0530
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
Subject: Re: [PATCH 3/3] virtio: Add Qualcomm VirtIO transport wrapper
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261126-jshekhar-qcom-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com>
 <20261126-jshekhar-qcom-virtio-dcp-v1-3-7b49bda74916@oss.qualcomm.com>
 <20261126012921-mutt-send-email-mst@kernel.org>
Content-Language: en-US
In-Reply-To: <20261126012921-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6b080411 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2bmipTvaJngT8L5-zw0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: dNJQH2FDNKCw8Jsvs18JuXWSzU1OyZov
X-Proofpoint-ORIG-GUID: dNJQH2FDNKCw8Jsvs18JuXWSzU1OyZov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzOCBTYWx0ZWRfXxBhZQICNSeA9
 e/1B226Hu7n7NsSBH+hbH9SGvv14cr94Ycc6GT4oiywwZLjfNp3Cmbb89ywm2/oInnPjldOVQVS
 QjSQ17ADu0twRPCy4JWXFvE28nMFapda9ByI8kKPvKdbV71Qxwb5flE9RS7DvD+PyBpPvuMYsqj
 vDtr3a7C0oIzH66kwIP3OwRMlHgRAInGpE6za0Q5Q56Pp3rldZsfCXBYFxDyYEUDk1TuNlQrMgU
 817JMcoUUADKSXT2YvbppzMab2Bp2d7p5XxDeSK5b+ymYdtH7Vb7nDuxo36KEQtLu3GwN/NTIZ1
 ps62JjEx7rqdV6syr/hBIUflrGVdqgpt0hDUBdTXDeEtcI4QGvz2KLmmplWYVT3SEdqDuFL8RFg
 go6qZnnKjM8oBvWduXZMqjoTGXO/Sp8X+ypvUgrL7vVDtwMV/+0ZaZnrPv7POnnPZQoYFXCeNTz
 RshIhbiLQrvWsKPHTCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzOCBTYWx0ZWRfXzHjWWl3/B/7s
 Y9R5+ufRf70oqEaoNXYnbi64EatXaOfMY9hMCT6Mcxv+XnyZxnTlzcQ7rMse31E9AjCwjWrrkyl
 5yUr195Go4E0RGAVsPFFPbwJ1HxvFdE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260038


On 26-11-2026 12:05, Michael S. Tsirkin wrote:
> On Thu, Nov 26, 2026 at 11:54:01AM +0530, Jayant Shekhar wrote:
>> Add the Qualcomm-specific VirtIO transport required by DCP firmware.
>>
>> The transport sends an IPCC power notification before accessing the
>> VirtIO MMIO registers, then registers a VirtIO device directly.
>>
>> Implement MMIO configuration access, feature negotiation, virtqueue
>> setup, interrupt handling, reset, DMA setup, and suspend/resume
>> sequencing in the transport. Keep power-management ordering in the
>> transport so VirtIO queues are quiesced before DCP power changes.
>>
>> Assisted-by: LLM
>> Signed-off-by: Jayant Shekhar<jayant.shekhar@oss.qualcomm.com>
> So VIRTIO_ID_VENDOR you defined in patch 2 is completely unused?
> Why did you bother?
>

I have split the DCP driver series into two:

1) Adds Add the Qualcomm-specific VirtIO transport (this one)

2) Add Qualcomm DCP display support (separate series)

https://lore.kernel.org/all/20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com/

Below patch uses the VIRTIO_ID_VENDOR

https://lore.kernel.org/all/20261126-jshekhar-v3-dcp-v3-18-f1e9d7505039@oss.qualcomm.com/


>> ---
>>   drivers/virtio/Kconfig                |  11 ++
>>   drivers/virtio/Makefile               |   2 +
>>   drivers/virtio/virtio_mmio.c          |  17 +--
>>   drivers/virtio/virtio_mmio.h          |  21 +++
>>   drivers/virtio/virtio_qcom_dcp.c      | 273 ++++++++++++++++++++++++++++++++++
>>   drivers/virtio/virtio_qcom_dcp_ipcc.c | 193 ++++++++++++++++++++++++
>>   drivers/virtio/virtio_qcom_dcp_ipcc.h |  41 +++++
>>   7 files changed, 544 insertions(+), 14 deletions(-)
> Oh great a pile of vendor specific code in virtio, with the vendor
> explicitly saying on the virtio ML that no specs will be published,
> ever.  And it seems to be your assumption that I'll be signing up to
> maintain this?
>
>
The transport uses the standard VirtIO-MMIO register layout and 
virtqueue operations; it does not define a new MMIO protocol. IPCC is a 
Qualcomm platform sideband needed to wake DCP before MMIO access and to 
signal response-queue notifications.

I agree that the maintenance ownership is separate concern that need to 
be addressed.


>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> index ce5bc0d9ea28..838ae5671c28 100644
>> --- a/drivers/virtio/Kconfig
>> +++ b/drivers/virtio/Kconfig
>> @@ -160,6 +160,17 @@ config VIRTIO_MMIO
>>   
>>    	 If unsure, say N.
>>   
>> +config VIRTIO_QCOM_DCP
>> +	tristate "Qualcomm DCP VirtIO transport"
>> +	depends on VIRTIO_MMIO
>> +	depends on QCOM_IPCC
>> +	depends on OF
>> +	help
>> +	  This driver provides the Qualcomm DCP-specific platform transport for
>> +	  QPSFI VirtIO devices. It reuses the standard VirtIO-MMIO configuration
>> +	  and virtqueue support, and handles the IPCC power-notification channel
>> +	  used to wake DCP and forward response notifications.
>> +
>>   config VIRTIO_MMIO_CMDLINE_DEVICES
>>   	bool "Memory mapped virtio devices parameter parsing"
>>   	depends on VIRTIO_MMIO
>> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
>> index eefcfe90d6b8..c922fb5bff16 100644
>> --- a/drivers/virtio/Makefile
>> +++ b/drivers/virtio/Makefile
>> @@ -3,6 +3,8 @@ obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
>>   obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
>>   obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
>>   obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
>> +obj-$(CONFIG_VIRTIO_QCOM_DCP) += qcom_dcp_virtio.o
>> +qcom_dcp_virtio-y := virtio_qcom_dcp.o virtio_qcom_dcp_ipcc.o
>>   obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
>>   obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
>>   virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
>> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
>> index c403a025006e..348809b9ebfe 100644
>> --- a/drivers/virtio/virtio_mmio.c
>> +++ b/drivers/virtio/virtio_mmio.c
>> @@ -71,7 +71,7 @@
>>   #include <uapi/linux/virtio_mmio.h>
>>   #include <linux/virtio_ring.h>
>>   
>> -
>> +#include "virtio_mmio.h"
>>   
>>   /* The alignment to use between consumer and producer parts of vring.
>>    * Currently hardcoded to the page size. */
>> @@ -81,18 +81,6 @@
>>   
>>   #define to_virtio_mmio_device(_plat_dev) \
>>   	container_of(_plat_dev, struct virtio_mmio_device, vdev)
>> -
>> -struct virtio_mmio_device {
>> -	struct virtio_device vdev;
>> -	struct platform_device *pdev;
>> -
>> -	void __iomem *base;
>> -	unsigned long version;
>> -
>> -	/* True if enable_irq_wake() succeeded for the shared IRQ. */
>> -	bool wake_irq_enabled;
>> -};
>> -
>>   /* Configuration interface */
>>   
>>   static u64 vm_get_features(struct virtio_device *vdev)
>> @@ -536,7 +524,7 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
>>   	return true;
>>   }
>>   
>> -static const struct virtio_config_ops virtio_mmio_config_ops = {
>> +const struct virtio_config_ops virtio_mmio_config_ops = {
>>   	.get		= vm_get,
>>   	.set		= vm_set,
>>   	.generation	= vm_generation,
>> @@ -551,6 +539,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
>>   	.get_shm_region = vm_get_shm_region,
>>   	.synchronize_cbs = vm_synchronize_cbs,
>>   };
>> +EXPORT_SYMBOL_GPL(virtio_mmio_config_ops);
>>   
>>   #ifdef CONFIG_PM_SLEEP
>>   static int virtio_mmio_freeze(struct device *dev)
>> diff --git a/drivers/virtio/virtio_mmio.h b/drivers/virtio/virtio_mmio.h
>> new file mode 100644
>> index 000000000000..a80904ed73e2
>> --- /dev/null
>> +++ b/drivers/virtio/virtio_mmio.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef _DRIVERS_VIRTIO_VIRTIO_MMIO_H
>> +#define _DRIVERS_VIRTIO_VIRTIO_MMIO_H
>> +
>> +#include <linux/io.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/virtio.h>
>> +#include <linux/virtio_config.h>
>> +
>> +struct virtio_mmio_device {
>> +	struct virtio_device vdev;
>> +	struct platform_device *pdev;
>> +	void __iomem *base;
>> +	unsigned long version;
>> +	/* True if enable_irq_wake() succeeded for the shared IRQ. */
>> +	bool wake_irq_enabled;
>> +};
>> +
>> +extern const struct virtio_config_ops virtio_mmio_config_ops;
>> +
>> +#endif /* _DRIVERS_VIRTIO_VIRTIO_MMIO_H */
>> diff --git a/drivers/virtio/virtio_qcom_dcp.c b/drivers/virtio/virtio_qcom_dcp.c
>> new file mode 100644
>> index 000000000000..a5443f2dbc4b
>> --- /dev/null
>> +++ b/drivers/virtio/virtio_qcom_dcp.c
>> @@ -0,0 +1,273 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * Qualcomm DCP VirtIO transport.
>> + */
>> +
>> +#include <linux/dma-mapping.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>> +#include <linux/virtio.h>
>> +#include <linux/virtio_config.h>
>> +#include <uapi/linux/virtio_mmio.h>
>> +
>> +#include "virtio_mmio.h"
>> +#include "virtio_qcom_dcp_ipcc.h"
>> +
>> +struct dcp_virtio_transport {
>> +	struct virtio_mmio_device mmio;
>> +	struct virtio_config_ops config_ops;
>> +	struct dcp_ipcc ipcc;
>> +};
>> +
>> +static struct dcp_virtio_transport *
>> +to_dcp_virtio_transport(struct virtio_mmio_device *mmio)
>> +{
>> +	return container_of(mmio, struct dcp_virtio_transport, mmio);
>> +}
>> +
>> +static void dcp_virtio_synchronize_cbs(struct virtio_device *vdev)
>> +{
>> +	struct virtio_mmio_device *mmio =
>> +		container_of(vdev, struct virtio_mmio_device, vdev);
>> +	struct dcp_virtio_transport *transport = to_dcp_virtio_transport(mmio);
>> +
>> +	virtio_mmio_config_ops.synchronize_cbs(vdev);
>> +	dcp_ipcc_synchronize(&transport->ipcc);
>> +}
>> +
>> +static int dcp_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>> +			       struct virtqueue *vqs[],
>> +			       struct virtqueue_info vqs_info[],
>> +			       struct irq_affinity *desc)
>> +{
>> +	struct virtio_mmio_device *mmio =
>> +		container_of(vdev, struct virtio_mmio_device, vdev);
>> +	struct dcp_virtio_transport *transport = to_dcp_virtio_transport(mmio);
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	ret = virtio_mmio_config_ops.find_vqs(vdev, nvqs, vqs, vqs_info, desc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < nvqs; i++) {
>> +		if (vqs[i] && vqs_info[i].name && !strcmp(vqs_info[i].name, "resp")) {
>> +			dcp_ipcc_set_resp_vq(&transport->ipcc, vqs[i]);
>> +			break;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void dcp_virtio_del_vqs(struct virtio_device *vdev)
>> +{
>> +	struct virtio_mmio_device *mmio =
>> +		container_of(vdev, struct virtio_mmio_device, vdev);
>> +	struct dcp_virtio_transport *transport = to_dcp_virtio_transport(mmio);
>> +
>> +	dcp_ipcc_set_resp_vq(&transport->ipcc, NULL);
>> +	virtio_mmio_config_ops.del_vqs(vdev);
>> +}
>> +
>> +static void dcp_virtio_release_dev(struct device *dev)
>> +{
>> +	struct virtio_device *vdev = container_of(dev, struct virtio_device, dev);
>> +	struct virtio_mmio_device *mmio =
>> +		container_of(vdev, struct virtio_mmio_device, vdev);
>> +	struct dcp_virtio_transport *transport = to_dcp_virtio_transport(mmio);
>> +
>> +	kfree(transport);
>> +}
>> +
>> +static int dcp_virtio_init_device(struct dcp_virtio_transport *transport,
>> +				  struct platform_device *pdev)
>> +{
>> +	struct virtio_mmio_device *mmio = &transport->mmio;
>> +	unsigned long magic;
>> +	int ret;
>> +
>> +	mmio->vdev.dev.parent = &pdev->dev;
>> +	mmio->vdev.config = &transport->config_ops;
>> +	mmio->pdev = pdev;
>> +
>> +	mmio->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(mmio->base))
>> +		return PTR_ERR(mmio->base);
>> +
>> +	magic = readl(mmio->base + VIRTIO_MMIO_MAGIC_VALUE);
>> +	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
>> +		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
>> +		return -ENODEV;
>> +	}
>> +
>> +	mmio->version = readl(mmio->base + VIRTIO_MMIO_VERSION);
>> +	if (mmio->version < 1 || mmio->version > 3) {
>> +		dev_err(&pdev->dev, "Version %ld not supported!\n", mmio->version);
>> +		return -ENXIO;
>> +	}
>> +
>> +	mmio->vdev.id.device = readl(mmio->base + VIRTIO_MMIO_DEVICE_ID);
>> +	if (!mmio->vdev.id.device)
>> +		return -ENODEV;
>> +
>> +	mmio->vdev.id.vendor = readl(mmio->base + VIRTIO_MMIO_VENDOR_ID);
>> +
>> +	if (mmio->version == 1) {
>> +		writel(PAGE_SIZE, mmio->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
>> +		ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
>> +		if (!ret)
>> +			dma_set_coherent_mask(&pdev->dev,
>> +					      DMA_BIT_MASK(32 + PAGE_SHIFT));
>> +	} else {
>> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>> +	}
>> +	if (ret)
>> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>> +	if (ret)
>> +		dev_warn(&pdev->dev,
>> +			 "Failed to enable 64-bit or 32-bit DMA. Trying to continue, but this might not work.\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static int dcp_virtio_transport_probe(struct platform_device *pdev)
>> +{
>> +	struct dcp_virtio_transport *transport;
>> +	struct virtio_mmio_device *mmio;
>> +	int ret;
>> +
>> +	transport = kzalloc_obj(*transport);
>> +	if (!transport)
>> +		return -ENOMEM;
>> +
>> +	mmio = &transport->mmio;
>> +	mmio->vdev.dev.release = dcp_virtio_release_dev;
>> +	transport->config_ops = virtio_mmio_config_ops;
>> +	transport->config_ops.find_vqs = dcp_virtio_find_vqs;
>> +	transport->config_ops.del_vqs = dcp_virtio_del_vqs;
>> +	transport->config_ops.synchronize_cbs = dcp_virtio_synchronize_cbs;
>> +
>> +	ret = dcp_ipcc_init(&transport->ipcc, &pdev->dev, 1);
>> +	if (ret) {
>> +		kfree(transport);
>> +		return ret;
>> +	}
>> +
>> +	/* Wake DCP before the first access to the VirtIO MMIO registers. */
>> +	ret = dcp_ipcc_send_power_notify(&transport->ipcc);
>> +	if (ret)
>> +		goto err_ipcc;
>> +
>> +	ret = dcp_virtio_init_device(transport, pdev);
>> +	if (ret)
>> +		goto err_ipcc;
>> +
>> +	platform_set_drvdata(pdev, transport);
>> +
>> +	ret = register_virtio_device(&mmio->vdev);
>> +	if (ret) {
>> +		platform_set_drvdata(pdev, NULL);
>> +		dcp_ipcc_deinit(&transport->ipcc);
>> +		put_device(&mmio->vdev.dev);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_ipcc:
>> +	dcp_ipcc_deinit(&transport->ipcc);
>> +	kfree(transport);
>> +	return ret;
>> +}
>> +
>> +static void dcp_virtio_transport_remove(struct platform_device *pdev)
>> +{
>> +	struct dcp_virtio_transport *transport = platform_get_drvdata(pdev);
>> +
>> +	/* Keep the embedded virtio_device alive until IPCC teardown is complete. */
>> +	get_device(&transport->mmio.vdev.dev);
>> +	unregister_virtio_device(&transport->mmio.vdev);
>> +	platform_set_drvdata(pdev, NULL);
>> +	dcp_ipcc_deinit(&transport->ipcc);
>> +	put_device(&transport->mmio.vdev.dev);
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int dcp_virtio_transport_suspend(struct device *dev)
>> +{
>> +	struct dcp_virtio_transport *transport = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = virtio_device_freeze(&transport->mmio.vdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = dcp_ipcc_enable_irq_wake(&transport->ipcc);
>> +	if (ret)
>> +		goto err_restore;
>> +
>> +	ret = dcp_ipcc_send_power_notify(&transport->ipcc);
>> +	if (ret) {
>> +		dcp_ipcc_disable_irq_wake(&transport->ipcc);
>> +		goto err_restore;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_restore:
>> +	virtio_device_restore(&transport->mmio.vdev);
>> +	return ret;
>> +}
>> +
>> +static int dcp_virtio_transport_resume(struct device *dev)
>> +{
>> +	struct dcp_virtio_transport *transport = dev_get_drvdata(dev);
>> +	struct virtio_mmio_device *mmio = &transport->mmio;
>> +	int ret;
>> +
>> +	ret = dcp_ipcc_send_power_notify(&transport->ipcc);
>> +	if (ret) {
>> +		dcp_ipcc_disable_irq_wake(&transport->ipcc);
>> +		return ret;
>> +	}
>> +
>> +	dcp_ipcc_disable_irq_wake(&transport->ipcc);
>> +	if (mmio->version == 1)
>> +		writel(PAGE_SIZE, mmio->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
>> +
>> +	return virtio_device_restore(&mmio->vdev);
>> +}
>> +
>> +#endif
>> +static const struct dev_pm_ops dcp_virtio_transport_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(dcp_virtio_transport_suspend,
>> +				dcp_virtio_transport_resume)
>> +};
>> +
>> +static const struct of_device_id dcp_virtio_transport_of_match[] = {
>> +	{ .compatible = "qcom,dcp-virtio" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, dcp_virtio_transport_of_match);
>> +
>> +static struct platform_driver dcp_virtio_transport_driver = {
>> +	.probe = dcp_virtio_transport_probe,
>> +	.remove = dcp_virtio_transport_remove,
>> +	.driver = {
>> +		.name = "qcom-dcp-virtio",
>> +		.of_match_table = dcp_virtio_transport_of_match,
>> +		.pm = pm_sleep_ptr(&dcp_virtio_transport_pm_ops),
>> +	},
>> +};
>> +module_platform_driver(dcp_virtio_transport_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm DCP VirtIO transport");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/virtio/virtio_qcom_dcp_ipcc.c b/drivers/virtio/virtio_qcom_dcp_ipcc.c
>> new file mode 100644
>> index 000000000000..1d83bcc69d5c
>> --- /dev/null
>> +++ b/drivers/virtio/virtio_qcom_dcp_ipcc.c
>> @@ -0,0 +1,193 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * DCP IPCC power-notify mailbox client. It wakes DCP during power
>> + * transitions and routes firmware notifications to the VirtIO response
>> + * queue.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/string.h>
>> +#include <linux/virtio.h>
>> +#include <linux/virtio_ring.h>
>> +
>> +#include "virtio_qcom_dcp_ipcc.h"
>> +
>> +#define DCP_IPCC_POWER_NOTIFY_TIMEOUT_MS	10000
>> +
>> +static void dcp_ipcc_handle_rx(struct dcp_ipcc *ipcc)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ipcc->state_lock, flags);
>> +	if (ipcc->shutting_down) {
>> +		spin_unlock_irqrestore(&ipcc->state_lock, flags);
>> +		return;
>> +	}
>> +
>> +	complete(&ipcc->power_notify_done);
>> +	if (ipcc->resp_vq)
>> +		vring_interrupt(0, ipcc->resp_vq);
>> +
>> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);
>> +}
>> +
>> +static irqreturn_t dcp_ipcc_power_notify_irq(int irq, void *data)
>> +{
>> +	struct dcp_ipcc *ipcc = data;
>> +
>> +	dcp_ipcc_handle_rx(ipcc);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void dcp_ipcc_rx_callback(struct mbox_client *cl, void *data)
>> +{
>> +	struct dcp_ipcc *ipcc = container_of(cl, struct dcp_ipcc, client);
>> +
>> +	dcp_ipcc_handle_rx(ipcc);
>> +}
>> +
>> +static void dcp_ipcc_free_channel(void *data)
>> +{
>> +	mbox_free_channel(data);
>> +}
>> +
>> +int dcp_ipcc_init(struct dcp_ipcc *ipcc, struct device *dev, unsigned int irq_index)
>> +{
>> +	int irq, ret;
>> +
>> +	memset(ipcc, 0, sizeof(*ipcc));
>> +	init_completion(&ipcc->power_notify_done);
>> +	mutex_init(&ipcc->power_notify_lock);
>> +	spin_lock_init(&ipcc->state_lock);
>> +
>> +	ipcc->client.dev          = dev;
>> +	ipcc->client.tx_block     = false;
>> +	ipcc->client.tx_tout      = 0;
>> +	ipcc->client.knows_txdone = true;
>> +	ipcc->client.rx_callback  = dcp_ipcc_rx_callback;
>> +
>> +	ipcc->power_chan = mbox_request_channel(&ipcc->client, 0);
>> +	if (IS_ERR(ipcc->power_chan)) {
>> +		ret = PTR_ERR(ipcc->power_chan);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "IPCC: failed to get DCP power channel: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_add_action_or_reset(dev, dcp_ipcc_free_channel,
>> +				       ipcc->power_chan);
>> +	if (ret) {
>> +		ipcc->power_chan = NULL;
>> +		return ret;
>> +	}
>> +
>> +	irq = of_irq_get(dev->of_node, irq_index);
>> +	if (irq <= 0) {
>> +		ret = dev_err_probe(dev, irq ? irq : -EINVAL,
>> +				    "failed to get required power notify IRQ\n");
>> +		goto err_free_channel;
>> +	}
>> +
>> +	ret = devm_request_irq(dev, irq, dcp_ipcc_power_notify_irq, 0,
>> +			       "dcp-power-notify", ipcc);
>> +	if (ret) {
>> +		ret = dev_err_probe(dev, ret,
>> +				    "failed to request power notify IRQ %d\n", irq);
>> +		goto err_free_channel;
>> +	}
>> +
>> +	ipcc->power_notify_irq = irq;
>> +
>> +	return 0;
>> +
>> +err_free_channel:
>> +	devm_release_action(dev, dcp_ipcc_free_channel, ipcc->power_chan);
>> +	ipcc->power_chan = NULL;
>> +	return ret;
>> +}
>> +
>> +void dcp_ipcc_set_resp_vq(struct dcp_ipcc *ipcc, struct virtqueue *resp_vq)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ipcc->state_lock, flags);
>> +	if (!ipcc->shutting_down)
>> +		ipcc->resp_vq = resp_vq;
>> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);
>> +}
>> +
>> +void dcp_ipcc_synchronize(struct dcp_ipcc *ipcc)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ipcc->state_lock, flags);
>> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);
>> +}
>> +
>> +void dcp_ipcc_deinit(struct dcp_ipcc *ipcc)
>> +{
>> +	struct device *dev = ipcc->client.dev;
>> +	unsigned long flags;
>> +
>> +	mutex_lock(&ipcc->power_notify_lock);
>> +
>> +	spin_lock_irqsave(&ipcc->state_lock, flags);
>> +	ipcc->shutting_down = true;
>> +	ipcc->resp_vq = NULL;
>> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);
>> +
>> +	devm_free_irq(dev, ipcc->power_notify_irq, ipcc);
>> +	devm_release_action(dev, dcp_ipcc_free_channel, ipcc->power_chan);
>> +	mutex_unlock(&ipcc->power_notify_lock);
>> +}
>> +
>> +int dcp_ipcc_enable_irq_wake(struct dcp_ipcc *ipcc)
>> +{
>> +	return enable_irq_wake(ipcc->power_notify_irq);
>> +}
>> +
>> +void dcp_ipcc_disable_irq_wake(struct dcp_ipcc *ipcc)
>> +{
>> +	disable_irq_wake(ipcc->power_notify_irq);
>> +}
>> +
>> +int dcp_ipcc_send_power_notify(struct dcp_ipcc *ipcc)
>> +{
>> +	unsigned long timeout;
>> +	int ret;
>> +
>> +	mutex_lock(&ipcc->power_notify_lock);
>> +
>> +	reinit_completion(&ipcc->power_notify_done);
>> +
>> +	ret = mbox_send_message(ipcc->power_chan, NULL);
>> +	mbox_client_txdone(ipcc->power_chan, ret);
>> +	if (ret < 0) {
>> +		dev_err(ipcc->client.dev,
>> +			"IPCC TX: power notify failed: %d\n", ret);
>> +		goto out_unlock;
>> +	}
>> +
>> +	timeout = wait_for_completion_timeout(&ipcc->power_notify_done,
>> +					      msecs_to_jiffies(DCP_IPCC_POWER_NOTIFY_TIMEOUT_MS));
>> +	if (!timeout) {
>> +		dev_err(ipcc->client.dev,
>> +			"IPCC power notify acknowledgment timed out\n");
>> +		ret = -ETIMEDOUT;
>> +	} else {
>> +		ret = 0;
>> +	}
>> +
>> +out_unlock:
>> +	mutex_unlock(&ipcc->power_notify_lock);
>> +	return ret;
>> +}
>> diff --git a/drivers/virtio/virtio_qcom_dcp_ipcc.h b/drivers/virtio/virtio_qcom_dcp_ipcc.h
>> new file mode 100644
>> index 000000000000..f855fe8adec1
>> --- /dev/null
>> +++ b/drivers/virtio/virtio_qcom_dcp_ipcc.h
>> @@ -0,0 +1,41 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * IPCC power-notify mailbox interface for DCP firmware.
>> + *
>> + */
>> +
>> +#ifndef __VIRTIO_QCOM_DCP_IPCC_H__
>> +#define __VIRTIO_QCOM_DCP_IPCC_H__
>> +
>> +#include <linux/completion.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/mutex.h>
>> +#include <linux/spinlock.h>
>> +
>> +struct device;
>> +struct virtqueue;
>> +
>> +struct dcp_ipcc {
>> +	struct mbox_client client;
>> +	struct mbox_chan *power_chan;
>> +	struct virtqueue *resp_vq;
>> +	struct completion power_notify_done;
>> +	/* Serializes concurrent power-notify transactions. */
>> +	struct mutex power_notify_lock;
>> +	/* Protects callback state and response queue access. */
>> +	spinlock_t state_lock;
>> +	bool shutting_down;
>> +	int power_notify_irq;
>> +};
>> +
>> +int dcp_ipcc_init(struct dcp_ipcc *ipcc, struct device *dev, unsigned int irq_index);
>> +void dcp_ipcc_set_resp_vq(struct dcp_ipcc *ipcc, struct virtqueue *resp_vq);
>> +void dcp_ipcc_synchronize(struct dcp_ipcc *ipcc);
>> +void dcp_ipcc_deinit(struct dcp_ipcc *ipcc);
>> +int dcp_ipcc_send_power_notify(struct dcp_ipcc *ipcc);
>> +int dcp_ipcc_enable_irq_wake(struct dcp_ipcc *ipcc);
>> +void dcp_ipcc_disable_irq_wake(struct dcp_ipcc *ipcc);
>> +
>> +#endif /* __VIRTIO_QCOM_DCP_IPCC_H__ */
>>
>> -- 
>> 2.43.0
