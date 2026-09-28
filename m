Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC71E4D90B5
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604122; cv=none; b=blk/NxX7O48tEiwwLQQ88JgNLfgQB87eRAn2hS3PLiUg3X3zagq/pa1F8RG292rGskn3XVH6Q8YfUqYQqZ1SU2ZGa2h+5/q54TLvmrOFb+4hwl+vFxkAirEYOJAXvSqLKIs+AEhDmXeb0exrpnaiC0jquQk4x5lo3Db+ltHsYZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604122; c=relaxed/simple;
	bh=j6IKKHSOAk/HYxjkfsqppu6/7M/o19dHiItXcDuAZbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbvVqGHijCKkQ5SJTIyLIgJr7B0Hk9G6DFoqGqk44UKLqLwHuAmwIvc8oXOJqGRIrWSc/7ijbqd2dbO7S8DldsXXQ+z9+5GpA4EMocw+z2xdfTP+rKFNHjxzcKH2COAhcqzePrVG3WrKTU6W0oV5DZ9PgrqNzwly/aoUaCmAItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KdotMERF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Orem07FN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KdotMERF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Orem07FN"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBALhL1683008
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 14:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lfjqqOB3VBxrec3RIQrCgVLmbWd75rCeJ2KFV/mqCC4=; b=KdotMERFGMBhy1lU
	inwa1Edq6xySXxOF0Mye3eizcNBBmfS61iClF+ZBxjfgtXC/TdUiNdxzxQYZ/HLV
	nwKdJ2TNYcj8Ih0/Pit/0/t39vZ1kjwn4K++t+Mr+zlkEutknFDQMJ9Lf2q6k7yy
	gR5jgvT1iSfssHKOSQY44k0ZThbsUfzFYBG+KMu99+UZokwrLXQCfxuswbQEohk/
	qUCesb4SJck2QT6I7ZFJ5lCpVvAEbykmE+a6nT8skZPM0q8bsjtE/d7ZXWUenIP1
	a18RM+5st0wdB83+ZVLqdAkyTAOBeDGCgr7Z4z1mWeeIGBdeL6si4P3znJF2nXqb
	NdqgHg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynfks0c0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 14:01:59 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-988b5c59668so153416241.0
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790604118; x=1791208918; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lfjqqOB3VBxrec3RIQrCgVLmbWd75rCeJ2KFV/mqCC4=;
        b=Orem07FNRBm2/6utYCxP0NLK5tDV3gW6csl3L5abbSajQf5vh7RhoZZBTpw+pEeCm2
         knV9XjwGlof+afPvQ7SjaufUpDc5GCEMSkUWMEbVbcT+vrUs0Q2KgX+zaPDIxNg2G2uP
         Eq29ziBwV/UJawqZQ2ffCCAfLk6l0HSNM6xQfV/wNYjORXycwYQ5q89rcbQ6ypO6J8XZ
         3NDHGsCTKCk7fMdKuKxG6D2yMJodLcQp6av6JJZO/k4urnUx1XEm4YGzLmhhC1KZ6IwT
         YxVsQIOVRnp82kW0vHLY/apWvsQd4/VzD9R7H4KHM6xECmHL2dW67U45hr1hDHxc4R5l
         787Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790604118; x=1791208918;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lfjqqOB3VBxrec3RIQrCgVLmbWd75rCeJ2KFV/mqCC4=;
        b=LINnjUTXc3rt/rixYLF9QtLcJela43mrX4qGs45RGifN4leQPByglJFmYRXEwagmNo
         WZluEoyeSLw+Rl5RGSST7hdZnZaDngbPTYB65ld64gcxoXQ9P32YwuuLF4cwEHLJQUbo
         WLVtZwaBCM1pkZsmkdICJDvqKMrGMXbtWwKRXEbcNOmp5WPOKe8hiZ6fWvdauLbC9xBY
         ISYA+6Z8hGSO2tUXa7K1qjG5E/lFJd/JrNgmAPzNqTCMlMzRyj0xSGb7gvBtKs8gSfNq
         Z71l5qiAz9W79ns911ZkgLyg2k0fsjwFY+E0t4DZbUL90zny0OOWEaLWqzGZiNZvywSV
         fbmw==
X-Forwarded-Encrypted: i=1; AKwUvBzL5LZHPjV73YdLXjJJSQLOCjWeFZyr3nUQ7YTWziaw5ZbyaLzZW8ci+Xt3YTDUJT02tYqwddPIRC7XurHAzQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLPbhZI7L4NnI/p9v53AKs0UpGf0aZSbtNB77L0PGkHHVxJ6+qZ
	qYgzz4iyl2YgVCcADrmzl5T9E1SfiAqUD3M/hOQFbnknDI+/26PgdEav2x4GxNe3FDCXVT1r5ub
	tLhjXjG3VxxFGF8Y08AA1t28dzkEIfuvbLYuFlp3WEY9Mtx6XchVS3BHTgtoqVn8LqeFImg==
X-Gm-Gg: AYBFou16BHF7Zm0ImfLXV7D+PtHKK9MEH/uerFtD1a+FamqiivQP4XBInYQwPBmlvJk
	++qYfRN3uxnLgiTUTV1K01erxiZhqM68feclkd2qTYl89yv0GXAxl6zcm+bqhMFsO009Vd+8EN8
	tTDqEiSs1bGDF9Hczr2NC0aXvpuS9WuAqRNF4n1xGV3pPTJC2Qn4ERSuRkFW3OH58u2TaKLPgMp
	Qv53LEmaqt0F3K0lSLmiIKauiT2jaamBDUGIlGAnStZVHlJyD682+cxoAYzptXDqFMZMffM4gzn
	S6sFS3CnVNkiGEIFkjMla9bxKne/VD19mY3ccLa5euARfnz8MxEa8oe7kKQGQNH6tbKFcYZhsqs
	moscjkXDBpPZsL71TtDbNqYY/+nUTtQ==
X-Received: by 2002:a05:6102:8099:b0:7b3:4199:2dd4 with SMTP id ada2fe7eead31-7b341a88730mr2300450137.20.1790604118266;
        Mon, 28 Sep 2026 07:01:58 -0700 (PDT)
X-Received: by 2002:a05:6102:8099:b0:7b3:4199:2dd4 with SMTP id ada2fe7eead31-7b341a88730mr2300417137.20.1790604117624;
        Mon, 28 Sep 2026 07:01:57 -0700 (PDT)
Received: from [10.224.243.150] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae84ba822sm478321666b.7.2026.09.28.07.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 07:01:56 -0700 (PDT)
Message-ID: <2c3db726-0024-436f-b33e-3c3475382312@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 16:01:54 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] virtio-usb: add host role (USB Host Controller)
 support
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowangio@gmail.com>,
        virtualization@lists.linux.dev, linux-usb@vger.kernel.org,
        Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>,
        Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>,
        Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
        Trilok Soni <trilok.soni@oss.qualcomm.com>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <20260924160907.145405-3-igor.skalkin@oss.qualcomm.com>
 <2026092531-giddy-annotate-7a58@gregkh>
Content-Language: en-US
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
In-Reply-To: <2026092531-giddy-annotate-7a58@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NSBTYWx0ZWRfX4VpK+vZo0Bm/
 VeTL5wjnyTUJ9sdXyiuIVUPJSBmm6Lfr+Ox0z8P5bc6pv1555YzN82oj/Atfcyn4U2i3jO8n7/U
 LAMQxuUGBMYQT/qzzaRLPtC7UF83y2Km4pXlBMGSKBakFj4witLSIVAyI/Kw+efO0muY35OMa12
 414z+38yCkeLOtWiMWMusuX3vBPg6Mv8I6viXU7KxsOB+9AE4Zpfo9HUi2DXPpottFMdvAJO/d+
 +OrVQKEruNG1+i0/lq+rUIQMmfUQ4Q4TtToVC4vyhlmL9SW0jmlElBfVsxahVOhz0BFIoW/457o
 Ju44pfyi+SZr0cE6uzMOoR6qxL+Owj3ICKqysilnrlm1MRw9N1v2sAtFpTCdTEX9dhneqLQIZRl
 skQ0ZVWdyWk+o+wlpGEFdSmNwELZVcZB5SSoMkrluBt73AXKdj2eYFe4GLSL6jBsIk3JAdI8if8
 dFt0VfHaNyHrfDebyyA==
X-Authority-Analysis: v=2.4 cv=e6aT2qp/ c=1 sm=1 tr=0 ts=6aba7357 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=8ZnIRRjJf6gdNzwMttMA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: ECaYeMX6iALbKDBhjoqYQJVFABGOy2pv
X-Proofpoint-ORIG-GUID: ECaYeMX6iALbKDBhjoqYQJVFABGOy2pv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NSBTYWx0ZWRfX6M8Xtj28KYGJ
 eQjtWqFVpD0o3TM16MLxGoKQ56p3nui4IkMdkBNxBsgqRMFQc50LvSw4hxrTUcmQsQ76qdVGeri
 V6OaNC57ocTFY7U2pxSiAYjG5ydsdXM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280055



On 9/25/2026 7:18 AM, Greg Kroah-Hartman wrote:
> On Thu, Sep 24, 2026 at 06:09:01PM +0200, Igor Skalkin wrote:
>> From: Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>
>>
>> Add the common virtqueue handling code (command, event and data
>> queues) shared by every role, and the virtio-usb host controller
>> (HCD) implementation, wiring it up as the host role of the dual-role
>> driver on top of that common code.
>>
>> Each host-role virtual port gets its own HS+SS usb_hcd pair and its
>> own root hub (struct virtio_usb_hc_vp), with a fixed
>> VIRTIO_USB_VP_MAX_PORTS (8) leaf slots pre-allocated at VP init time
>> and reused across connect/disconnect - never dynamically alloc'd or
>> freed. This lets the backend forward more than one physical socket -
>> and, for host ports behind a physical hub, more than one leaf device
>> per socket - as independent virtual ports from the start, instead of
>> collapsing everything onto a single shared root hub and having to
>> revisit that decision once more than one host-role port needs to
>> exist at the same time.
>>
>> virtio_usb_add_hcd() derives each VP's HCD bus_name from the parent
>> virtio_device with devm_kasprintf() rather than a stack buffer, since
>> usb_create_hcd()/usb_create_shared_hcd() store that pointer as-is in
>> hcd->self.bus_name without copying it - it must outlive the HCD
>> itself.
>>
>> Every port is host-role for now, since no other role exists yet;
>> vports[].role is populated unconditionally until later commits add
>> device role and OTG-based role resolution.
>>
>> Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>
>> Co-developed-by: Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>
>> Signed-off-by: Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>
>> Signed-off-by: Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>
>> Co-developed-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
>> Signed-off-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
>> ---
>>  drivers/usb/virtio_usb/Makefile     |    4 
>>  drivers/usb/virtio_usb/controller.c |  105 ++
>>  drivers/usb/virtio_usb/controller.h |   35 
>>  drivers/usb/virtio_usb/host.c       | 1335 ++++++++++++++++++++++++++++++++++++
>>  drivers/usb/virtio_usb/host.h       |  203 +++++
>>  drivers/usb/virtio_usb/vq_common.c  |  740 +++++++++++++++++++
>>  drivers/usb/virtio_usb/vq_common.h  |  163 ++++
>>  include/uapi/linux/virtio_usb.h     |   16 
>>  8 files changed, 2585 insertions(+), 16 deletions(-)
>>  create mode 100644 drivers/usb/virtio_usb/host.c
>>  create mode 100644 drivers/usb/virtio_usb/host.h
>>  create mode 100644 drivers/usb/virtio_usb/vq_common.c
>>  create mode 100644 drivers/usb/virtio_usb/vq_common.h
>>
>> diff --git a/drivers/usb/virtio_usb/controller.c b/drivers/usb/virtio_usb/controller.c
>> index 2fc6f50..216edfc 100644
>> --- a/drivers/usb/virtio_usb/controller.c
>> +++ b/drivers/usb/virtio_usb/controller.c
>> @@ -6,9 +6,16 @@
>>   */
>>  
>>  #include <linux/module.h>
>> +#include <linux/moduleparam.h>
>>  #include <uapi/linux/virtio_ids.h>
>>  
>>  #include "controller.h"
>> +#include "host.h"
>> +#include "vq_common.h"
>> +
>> +u32 virtio_usb_cmd_timeout_ms = MSEC_PER_SEC;
>> +module_param_named(cmd_timeout_ms, virtio_usb_cmd_timeout_ms, uint, 0644);
>> +MODULE_PARM_DESC(cmd_timeout_ms, "Command completion timeout in milliseconds");
> 
> This is not the 1990's, please do not add new module parameters.  Just
> make it work without manual configuration at module load time.
> 
> If you really need a configuration option, make it per-device and use
> the correct, modern, apis for it.
> 
Agreed, will remove it.

> thanks,
> 
> greg k-h

