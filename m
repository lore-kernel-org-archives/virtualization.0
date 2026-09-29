Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991F339CD0B
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 19:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708567; cv=none; b=EDmgqGz3dPd140c2w9KBzYAyKiEZEDdL3cu1DcKoeoVA1CKAyZYqTLFr2Xn5vmZTBx5CLuFYFwJKzVNXVAk0RjtvReHsnniepMPy0jRmXqA3bAkwCkb0sDJ/FElatmC/qSPSbR48oyGrlXZ0W9mkHRgfSopRVhn459ssLdfyoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708567; c=relaxed/simple;
	bh=jNRH5BqIa8CLiIo1TgQ/cxLnU9M6+fxsZzA+ZzbXKBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAIFWOvj+G0CDqGviDFmTsZBHRIZ282+sTpaXJiFVO1rrrmBHLdlHcG8mA4Dskx8Y1M///P+omJ3L/ggxUrdlp3oVm59vZ3tLzH1qViE/drp7yNfjgtNNn7Xt3/ehFyb12qP7his9ea/DpTKS2cM6XFRyfSLy0Njyg0d2WMRsok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sy+W3wK4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IhQYf0VI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sy+W3wK4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IhQYf0VI"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68THSWmm3842777
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 19:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WXNCz46k7inLhAGcrdOXQlSVT645cR4KpzAAvLFxPh4=; b=Sy+W3wK4gPHOxVqU
	c5ceYXUvpWa/tDGZ1pcfS1ut/OL0+yn6l4NL5AEPkQtdj6iqxuJy86LqdLFWHDlZ
	HK+aoYXPSrsThYzhCV8SbEs6X/7H3+nlIyJIS/hkgI19FD5cMDSPhBqtsu0s7aAK
	1380Cnk4d+s/pd6d6kCxb7Ki9KfQ/AMD3A2CNnjC9qCpjgEDnZp6G0wVveJC5T/Q
	DntPKhp5fEpIjuQlZ98dM/dMnZyKEy1GnhZrNVdy9zKwqdVxm8U4FRJHtJXr6ns2
	21lx0dl16v3qlacMJ38tNIJVtrwTbj4HBB3YzKCl1RRUhCRw2Z8+9MKBbhyjQy1m
	f/aLiw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0b0vagjv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 19:02:44 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5ce04f57aaeso530522e0c.1
        for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790708563; x=1791313363; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXNCz46k7inLhAGcrdOXQlSVT645cR4KpzAAvLFxPh4=;
        b=IhQYf0VI8lj7d1+bsZzo27UL96C/sK8PxrMazDZS67iQTw96/uziPycXC7Pd0YVCcp
         IBcjnhhI+kmzMESsvwCDM7esFjVosV2SafpkzgxYkb+c3g6/IYasmejUnRTBFFZy1m/V
         ediyAIbb/X9GRlr/tYfcBPjZLv4FUYkR+nZahuy89gf5Xhu0Yb9lm1fQAFtbHbCX0z/h
         rUCOdQg4vVOSETudtpNDe4Izt9LgxfAJAv8S8xspzqKtuXiCHJ7ns7fa05Qsxb1XeX2B
         rpQ/3n7cRXdkwqftskJTNWeLP/rvJCLOwSkrcr0CizSb6J9F/ZYfkYF7pOFV88G/XTHF
         OXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790708563; x=1791313363;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WXNCz46k7inLhAGcrdOXQlSVT645cR4KpzAAvLFxPh4=;
        b=lweo8u4w8VgEvMfmLrst0X7Gy9+EV5Rksr8YDXEiYR338OJcDjpwGPTn+KL0YPm1fK
         hNSNKTU3DwoNJKZULEue/NpAYqETW/vvdRHORWkOPBQechwRfS6ldVxpuBHMy0U8Y1m5
         bv3YudSZlCv0i9JHlqCo+D8N530Ht9bNfKOHj6NQ46KtC2Y66eWgrVtNjnxbNIlbB14j
         rdxjbReFWcRfVkkzkuf6bdHIb3yqR/PPcENeby112kn5rQDhTw9IJ7L/HoXHzz3GtC0z
         LJfSaGt3XW3J2kW8XEPQIycD0KWd7JgzsH9DXVvRTtNocJzFybGBTAJVN+ijN1UIIA+V
         NngQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+RAqMXCJG0xV0Bo1UI39mvAl77iu2zAbBfACOUb3YiVIgh2fXsgIHMFjrksYLliIcHl1NNtWllVJTw0y+zQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLj5Gviz60XnfEXZCxlsRYtipFocdC2axxrItSAuQgTsdZ53EqX
	MbWn9TcoqpwDjDJMZyLXLQg1P1E99uJqBTQSboXtguVzkwoe3IWHDNQloWKYcFMsx4+5eHKS3kW
	p2ro95CT9QIxNXcw1RxLRf7HynDzmoywwe0lTQSmYtCg/D0H7SbRuu0PxjpP/XnO68yELYA==
X-Gm-Gg: AYBFou1UavQ/j2xB/Guvfaq5YOQ7O+ZitTaJtikBGMg1tBILOxv10D1dwe/hWSkmIPH
	kUgpcLtADNAQ1umur+ox6kz/SU7V4uFpypvhymi/Mng/Kq2hmbbjb5UDEVX83xxi3sw5OtmVxfA
	/blIzpBnXWu1qYNoBu0kLe1b/dEg/gDUd7KkLrVR0JWHTOWlUE025rh3NzI4hM+3S8CftxRDS8b
	CF1BL+DHThU78tjDeaFgAi1QehJ9PuTtQeOhPimhtY1hzbIn+CzWqPOweHCWptEWchVk8RNAttM
	jwW8VBCC+ZF2DI20/bPE7n7I2+tJZX1caV+aApbY+LeFnxfWEYxgUgvpx/g38bvPT83zx/Yhijj
	42qEQLhVpTMf2j4mvoQ3dOrWg84HkjOn9HRKBGDSmvow7F7CdjPlN57YbbPMQ
X-Received: by 2002:a05:6122:32c5:b0:5bf:a179:b2be with SMTP id 71dfb90a1353d-5d5192ee53amr149430e0c.7.1790708563141;
        Tue, 29 Sep 2026 12:02:43 -0700 (PDT)
X-Received: by 2002:a05:6122:32c5:b0:5bf:a179:b2be with SMTP id 71dfb90a1353d-5d5192ee53amr149377e0c.7.1790708562357;
        Tue, 29 Sep 2026 12:02:42 -0700 (PDT)
Received: from ?IPV6:2a01:586:269:1:add2:27e1:9b51:f8d5? ([2a01:586:269:1:add2:27e1:9b51:f8d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a014f77b7csm3138535e9.8.2026.09.29.12.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 12:02:40 -0700 (PDT)
Message-ID: <0c7ff5fe-1c11-40c6-9082-8ad63db1e45f@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 21:02:32 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] virtio-usb: add dual-role virtio USB driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Skalkin <igor.skalkin@oss.qualcomm.com>,
        Jason Wang <jasowangio@gmail.com>, virtualization@lists.linux.dev,
        linux-usb@vger.kernel.org,
        Aiswarya Cyriac
 <aiswarya.cyriac@oss.qualcomm.com>,
        Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
        Trilok Soni <trilok.soni@oss.qualcomm.com>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <2026092520-aerosol-brim-22d1@gregkh>
 <1149e188-7279-4c60-bd96-f8d75d721ae0@oss.qualcomm.com>
 <20260929054346-mutt-send-email-mst@kernel.org>
 <2026092928-borough-tried-1ea7@gregkh>
Content-Language: en-US
From: Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>
In-Reply-To: <2026092928-borough-tried-1ea7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xF8rgWGZ-BWXaLNmgK1NIGFMWGf_QWe4
X-Proofpoint-GUID: xF8rgWGZ-BWXaLNmgK1NIGFMWGf_QWe4
X-Authority-Analysis: v=2.4 cv=Z+55j3RA c=1 sm=1 tr=0 ts=6abc0b54 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=S3klGuCvEsm81xsjPWUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3NSBTYWx0ZWRfXxq+g/MWcinEL
 rIJ4cBSPgIqFGwNYoX/BxKB856uohcnfn57uhIiypL/zSTYZni+LafQI+bwS5eTdVjlTv2E33uj
 f7FyNcKa7f/1y1CC/eThQ3UjSZBvOSogN7YxrDoeph7JxNZdLWVyJXUJqxSd3jefEFzfmRQHd1y
 FtOVzusxbjmFm5ZTx27btBaxlwBqN8YJYbw/Lm6kZyXQCDLYDzCTWJ4j6XDOUBNkr2EGOf9OSJT
 NResgrsbpCdj9Ox3c5HquQrd9HorWzFD24lQvZmlBTDWf5JhjxT8xT3FYz9J3dP9OuSf9xaJQlb
 2cDkatOQvj1ZdXWTsJhJGO/cusoAy334bvTg4M+YYe5vrnfd8o3bmG6xY0rDiuQfQ9+n6+4tUOF
 rzBT3hKvx5/NlC5aEdP4wrhFWiNI5uw6zncYyM5Wv25nZWDmGWbsNO9xFRl2hLokcozxAjgLIMU
 KzkgmrVYkT374x6Dwtw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3NSBTYWx0ZWRfXwxmCyiPRdQcj
 6fFBqHC9FOSOcrc2Uftzc/kjzj8XJW81FSBabNGnV8ZUmH8Cfx8FbVroNeQH4tRrGP8yFW9aPR1
 IDq5mJGsODWydhlVIDxhs2DMrHWXXjg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290075

Hi all,

I'd like to join the discussion and share my perspective.

Greg's main concern is: "Why is this needed at all?" Let me explain.

First of all, our primary focus is embedded systems, including the
automotive
industry, particularly infotainment systems. In this area, the easiest
way to
provide USB access to a GVM is to pass the USB device directly through
to the
guest. This is even simpler than usb-ip, since we can rely on the
standard Linux
USB driver.

And it works well until we need more flexibility, such as:
- Sharing different USB devices connected to the same USB host among
multiple
  VMs (for instance, assigning one USB stick to the AGL GVM, another to the
  Android GVM, and a sound card to the PVM).
- Sharing multiple USB gadget functions from several VMs through the
same USB
  gadget port (for instance, providing ADB connectivity to all VMs,
including
  the PVM and both GVMs).

Once this level of flexibility is required, simple passthrough is no longer
sufficient, and we have to rely on USB sharing mechanisms.

And this brings us to your main concern: Why not simply use usb-ip to
share USB devices between the PVM and GVMs? Why introduce an entirely new
transport for USB virtualization instead of relying on existing solutions?

There are several reasons for this.

First, we aim to support not only Linux-based hosts. The host could be
running
QNX or even a bare-metal (no-OS) environment, where usb-ip and usbfs are not
available. Igor has already explained this point. However, as you rightly
pointed out:

> Or more realisticly, why should _I_ care about anything other than
Linux?  :)

It seems, you are right: why you should pay efforts reviewing our
patches, while
no one except us will be able to utilize this for non-Linux based
workspaces. In
reality, the opposite is true: if VirtIO USB becomes a standard part of the
open-source Linux kernel, USB virtualization will become
hypervisor-agnostic.
For end users who rely on open-source or commercial hypervisors, it will not
matter which hypervisor is running under the hood (for example, QNX or
QEMU).
They will be able to use the open-source Linux kernel out of the box,
without
any modifications. If they later decide to migrate to a different hypervisor
that supports the standard, the transition will require little to no effort.
Therefore, the Linux community should, in principle, be interested in
supporting
this effort.

Furthermore, this is not only about host OS, this also about guests.
Let's imagine
you want to run QNX or VxWorks image under qemu on Linux Host. Both GVM OS
supports OASIS Virtio Standard, but does not support usb-ip. Therefore,
we would
like to introduce a common approach that works across all operating systems.

And we also plan to add virtio-usb support to QEMU as well. This
approach will
be available to the broader community as well, not just as a proprietary
solution.

The second important reason is that one of the key virtio-usb features
we need,
and which partially motivated this work, is support for a dual-role USB
controller for Apple CarPlay. usb-ip cannot provide this because it
lacks OTG
support.

Third, performance is another reason for introducing a new solution.
Igor has
already partially explained this point. Existing solutions such as
usb-ip rely on sockets and therefore introduce additional overhead. This
becomes
particularly important in resource-constrained embedded systems. With
our own
implementation, we can avoid this overhead.

Fourth, as Igor has already mentioned, usb-ip and usbfs do not work out
of the
box. They still require additional configuration on the GVM side to function
properly. Yes, this is standard Linux administration, but it still requires
additional configuration and maintenance effort. In contrast, a vanilla
Linux
kernel with VirtIO USB support will boot and operate as is, requiring zero
additional effort.

And last but not least, let's be honest: usb-ip is not really about
virtualization.
Its primary goal is to share USB devices over a network. This is a perfectly
valid solution, but it serves a different purpose than virtio-usb. By
the same
reasoning, one could ask: "Why do we need virtio-gpu when we can simply
use RDP
over IP?". In other words, this is not about inventing a brand-new
transport. It
is about defining and standardizing an existing approach as an open industry
standard.

Thanks,
Vasilii Ianikeev

On 9/29/2026 6:01 PM, Greg Kroah-Hartman wrote:
> On Tue, Sep 29, 2026 at 05:47:30AM -0400, Michael S. Tsirkin wrote:
>> On Mon, Sep 28, 2026 at 03:55:38PM +0200, Igor Skalkin wrote:
>>>>>   [RFC PATCH v2] virtio-usb: Add initial virtio-usb specification
>>>>>   Igor Skalkin <igor.skalkin@oss.qualcomm.com>
>>>>>   virtio-comment@lists.linux.dev
>>>>>   https://lore.kernel.org/virtio-comment/20260924154007.143927-1-igor.skalkin@oss.qualcomm.com/
>>>>>
>>>>> This driver has been tested end-to-end against our own userspace
>>>>> virtio-usb device implementation (host-side backend) in two setups:
>>>> Where is that code and why isn't it part of this submission?
>>>>
>>> The backend we used for the testing described above is an internal
>>> implementation that we're not releasing as part of this submission - it
>>> integrates with some systems that aren't ready to be public. We
>>> recognize that limits independent verification of our specific test
>>> results, and we don't think that's an ideal situation.
>> Supporting vhost-user with a backend doing pass-through shouldn't be too hard.
> Wait, if all you want is adb to work, why not just use it in network
> mode?  That should work find across a virtual machine, right?
>
> thanks,
>
> greg k-h
