Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA26B4DD3D4
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610988; cv=none; b=Ez6HlQbCdxxtfQi2v6VtAuXEYjaDZ6l4L11axrbJbKtH8NYkzwgxxCQm1kbhrY0ewy7r/n12KiblVW6KS+SuJ4phfUzWh0Qb4NSnBXaOZrNBk4Mqi3tLVy6DISU5/nKBNc4iUT77gGwRcGVb1uI8vg4QAlj0yOp6axflgt55sio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610988; c=relaxed/simple;
	bh=0O1HLguXitJU7pbFDlbIuAwqCWTDO9SyY8zR3ZwCaso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbyDRZ5ttuiuulEb47Yz+OKdse1SUcjxbVNSFDX5e8foT6Fduj40pZ8f7v0FTldLNP+cUyoVhMJ7Fjy8AHuT8N4QX+Iqj4tO0XJKcNE/ImdaowpmBD8U9wp9CS87ji05vh/Wu0iOL1YI4AXbZ0hikyvmnaAZbE+pxZUuK/m4Y8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E7byvnuC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R20VMB3D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E7byvnuC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R20VMB3D"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEe6D21647369
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 15:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a7ACtyVsqU7L9W7XLM4ivoSjJiJ1lXbIo60U+PRjjEQ=; b=E7byvnuCPaLq9CnV
	ScrtkhlZPISTlacSjN2kKrDUWa9sfYTSKsE7OMVw8+PvrxAc3xwrfGgH0PcgOm+T
	GZEax3xq4YXvETiLK+M/wMnUOJUQp44LJsPxdGk95Zq3ZmF3AfXeg8/ISK4CO8dV
	QQyMj+YOThJdUUfpEUCLyUpR6SUjandxGQ0zuB2BlWjgl1iCXfHhCGQK0IZgwUYo
	/9itJFtuxyBQMTFGyxUhKHMFiqjIP06AXshb646dIyV2MCswyKYuDKcpSB0ZBSSm
	YqeZcRI3tltgMWial85yLsoAFANaCIUvx/bnIoMmHputYTcpqKoiOfgVluthUUrN
	gA9I3g==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc1j43-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 15:56:25 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7b3beb638e2so1760510137.0
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790610985; x=1791215785; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a7ACtyVsqU7L9W7XLM4ivoSjJiJ1lXbIo60U+PRjjEQ=;
        b=R20VMB3DyqJboRGX3Dhc3QpJZJV5fy5I6vVTsglicS1gkbQEBmPI7M2JDL1tDCTldY
         1VTU+bGtRV3xU1GNLFGrEEXGMzw8nPIoAbS1QBnQoR780uPrY+0cCmIDVrnRMnh641Ap
         6mYNg0M9KJ3mcHhe6ViJ9+H7DHk/NL/NJlZ34kmupweqxNRzVfpS6aKSU//hbEkaiDG3
         4r3R1lUs7S4uypGMSKpdk9Qnut1JC2HFTJo6NQv07g/YA5nBC7r0yEUhTZmAvSnOprgJ
         0uMJ7IISts3q28VRybyLfyXYGWcJaCUM6SrFPnP/dowGzhm5X6AwbTOgOaZr/fWoZsVv
         rnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610985; x=1791215785;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a7ACtyVsqU7L9W7XLM4ivoSjJiJ1lXbIo60U+PRjjEQ=;
        b=w25FjgAa4uBygIfLfQcYVA6dcUdSewaPqZH1Txj8OAmkZiLwE4x/6Lc5zoUY8ahyR2
         bnUke7BNSYdGLERdOty6MjFBd5s6S7KOvuvfKGAeBGf3F/6r0RQ1zb/5VWz/6x5ATgcN
         YEE0rdc4BHebfeybB4LuwOV7TZseG2uYcZzXpaqTySFEUF/sThuRtOugFLCoLWPu2dPY
         3vvletYj2JOruXAPh4MA7EvCj6Wpw0r9zISz7+fA1r6KU3S7ehXlLNk+4N1P5QlWNxQh
         CVIraC7gtLAnr5mGFgwEF5Xzp5ghu5Ir1rNoq6w0lIq2SdqHU9k6H5qxiKocq3ecrhDI
         LX6A==
X-Forwarded-Encrypted: i=1; AKwUvByl+0b5TD2ns8ohpH+nHqmuyZU8pySh7jlONIYb3C+v/X6p+65Vbty1L8X/vNoeuiJ1m4EhQHXlfAu8qW4Bog==@lists.linux.dev
X-Gm-Message-State: AFq9FYJCSrBLbK649Uqf0X2k3H6yFFZGelSwFvAP1G+9WZnRD8HBcZDg
	4Klf0KiIQa1RuIksivUQp6SniTQwKc29Gn7zn9EMGaE8q90KcQaF3rQIUSlC8yn781wumROwV3O
	gaVl4eZxcLc8nKjiQRKDMx5bxc+OKvok4Fd47BLx836UMxQ4vyuaVyzNQmAv8Ur2D4afT2w==
X-Gm-Gg: AYBFou2V6OcJjr0V3QKQ07Ng+P1dH89tXYGz4Tgv8S68evqDLamMHD8q7Mw8b31+CtY
	q6EiNZ6KHCXtdre+WCeWijUJ52//vw8zrTaxUFG7A4KNsjOyZpYnEZr+mOZd04CecD1oFPJsGIJ
	A7+gD+uTEwlIVtwq3pkkXb2+MGSfMTStnrYDdWkjbQ2NUi9fV2LiysgNUmFsalqV52SCRcnMA9y
	yFaL4rdnUxwg1L5VB392FUT5YqF5nrM9sLW5blc05KnkJSUpC/b36nguGT7OJV/2Oepq46JMut0
	52nKXHXIy1y1yupZbIvtJ3ZX/ycDhk2e2u1KMI3FmpCvyavakaPM29BZe49T+PvdEWcOFEWFC2d
	EImaxGgppDTs3GMiO+LWbWjjRo/F1bQ==
X-Received: by 2002:a05:6102:4b04:b0:7ab:1d32:fe30 with SMTP id ada2fe7eead31-7af1ebefd49mr4747172137.25.1790610984913;
        Mon, 28 Sep 2026 08:56:24 -0700 (PDT)
X-Received: by 2002:a05:6102:4b04:b0:7ab:1d32:fe30 with SMTP id ada2fe7eead31-7af1ebefd49mr4747164137.25.1790610984451;
        Mon, 28 Sep 2026 08:56:24 -0700 (PDT)
Received: from [10.224.243.150] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28887916f8f.12.2026.09.28.08.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 08:56:23 -0700 (PDT)
Message-ID: <92343daf-eae9-400e-b865-528569b028b2@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 17:56:22 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] virtio-usb: add dual-role virtio USB driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowangio@gmail.com>,
        virtualization@lists.linux.dev, linux-usb@vger.kernel.org,
        Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>,
        Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>,
        Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
        Trilok Soni <trilok.soni@oss.qualcomm.com>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <2026092520-aerosol-brim-22d1@gregkh>
 <1149e188-7279-4c60-bd96-f8d75d721ae0@oss.qualcomm.com>
 <2026092846-word-shape-dab9@gregkh>
Content-Language: en-US
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
In-Reply-To: <2026092846-word-shape-dab9@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba8e29 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=a2JseCAjfgePHz9dsBkA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: ymm5dJiiaaGmG4RTIij_1NKtqkS1Janw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MyBTYWx0ZWRfX8IlFCVIgArk5
 Kahxq4bGFElEDeKoS1RBAajtx1aTGjRLv8GXFcdh8PQ0Vz0i296/cUPDxTGpD6ly8630vPejVnN
 NRJ48YD0aTT5W/5tk1rRfZcxt5L2HKnjbZjpptzJ5LRwy+mPzIqDLUY0ZfLYbyjf5C/rOWhhFXD
 JAbqnf6BvF1i4eeEQTikxjWmOrROfuXXlQIS1/zUKXW5F4Q2bWhq7Vyy2SZIiWChSQdy2G5gUeO
 eZ+4A66gxIRAMjrDncpnsfa+f9DLou+5CRdcaILAdwQRAHWFJRe/oQ1FzGCrzDCoZh4hKkop98Y
 tyU1HvhoR2fLnwBHGCds9mU/Ku3NxJ6kkz++jFiXypc7I4F+RkhoxUCzFkGu5r3qKij9aFNRGEw
 TIeQUu1KqOz4vE8EnYxUxKdkd1tNTGpXSxGNqiKeTP18G6c8Cs7pTZpO+f5yDnVY6Tgu96jFWXV
 6N4Hlpendu/TICOlxfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MyBTYWx0ZWRfX0lrczioaWOOM
 DVusNHwJvC+e0a6H42DbhpzUQE0ya0oZm+wDCeXbwK33p+8mGHknFOzZjYB5wL83XQtgvR70cfn
 FHW+zFz97UKB8gRTXotQ6vm3mN+47EQ=
X-Proofpoint-ORIG-GUID: ymm5dJiiaaGmG4RTIij_1NKtqkS1Janw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280063



On 9/28/2026 4:44 PM, Greg Kroah-Hartman wrote:
> On Mon, Sep 28, 2026 at 03:55:38PM +0200, Igor Skalkin wrote:
>>
>>
>> On 9/25/2026 7:17 AM, Greg Kroah-Hartman wrote:
>>> On Thu, Sep 24, 2026 at 06:08:59PM +0200, Igor Skalkin wrote:
>>>> This series adds a new virtio-usb driver: a dual-role virtio device
>>>> capable of acting as a USB host controller, a USB device controller,
>>>> or both simultaneously with runtime role switching between the two
>>>> (USB OTG-style role switching) on ports that support it.
>>>>
>>>> The corresponding virtio-usb device specification has been posted to
>>>> virtio-comment for review. This series matches the v2 revision of
>>>> that spec, which reconciles a small number of protocol details
>>>> (per-role virtqueue presentation, host-role vp_idx for hub/multi-VP
>>>> support, and the device-role BIND/UNBIND event split) that were
>>>> clarified while integrating and testing this driver against the
>>>> spec:
>>>
>>> Why do we need this at all when we have other ways of doing usb devices
>>> through virtio?
>>>
>>> Why is a USB virtio spec needed at all, who is going to use it?
>>>
>>>
>> For device classes that already have a virtio equivalent (storage, HID,
>> video, audio) there's no need for virtio-usb: we can use
>> virtio-blk/virtio-input/virtio-video/virtio-snd directly.
>> What virtio-usb actually addresses is different: protocols that are
>> about raw USB semantics itself, not about any particular device class.
>> Two concrete cases we care about. ADB (Android Debug Bridge), a specific
>> USB interface/vendor-class protocol used throughout Android development
>> and debugging, with no meaningful way to express it as a block or HID
>> device. And Android Auto (AOA) / Apple CarPlay, USB-level
>> control-transfer and vendor-negotiation protocols used when a phone is
>> plugged into an automotive head unit.
>> Our motivating use case is automotive cockpit virtualization: a physical
>> USB port where a phone is plugged in needs to be handed to a guest VM
>> running the head-unit stack, and that guest needs to run one of these
>> USB-native protocols. The existing software on both sides already speaks
>> raw USB and works unmodified if it sees a real-looking USB device.
>> virtio-usb lets that keep working, instead of needing a new bespoke
>> virtio spec for every such protocol as new USB-based ecosystems show up.
> 
> So you just want "raw" usb, then why not use usb-ip?  Isn't that what
> it's there for?  Or just mount usbfs and expose that to the host as
> that's what adb is using already, right?
> 
usb-ip's host and guest sides are both Linux-specific - in some of our
target deployments the host OS isn't Linux at all (e.g. QNX), so there's
no usb-ip host-side implementation to use in the first place.
virtio-usb's backend only needs to speak the virtio transport, which is
host-OS-agnostic.
Separately, usb-ip requires explicit manual configuration on both sides
for every device. Its own checklist also calls for disabling SELinux and
opening a TCP port. We're trying to avoid that operational overhead
(ideally - fully virtualized vanilla Android as a guest).
usbfs is a different layer - it lets a local process talk to a
locally-attached device (how the ADB host daemon works today), but
doesn't address getting the USB device into the guest in the first place.
And usbfs is Linux-specific too.
>>>>   [RFC PATCH v2] virtio-usb: Add initial virtio-usb specification
>>>>   Igor Skalkin <igor.skalkin@oss.qualcomm.com>
>>>>   virtio-comment@lists.linux.dev
>>>>   https://lore.kernel.org/virtio-comment/20260924154007.143927-1-igor.skalkin@oss.qualcomm.com/
>>>>
>>>> This driver has been tested end-to-end against our own userspace
>>>> virtio-usb device implementation (host-side backend) in two setups:
>>>
>>> Where is that code and why isn't it part of this submission?
>>>
>> The backend we used for the testing described above is an internal
>> implementation that we're not releasing as part of this submission - it
>> integrates with some systems that aren't ready to be public. We
>> recognize that limits independent verification of our specific test
>> results, and we don't think that's an ideal situation.
> 
> Then we can't even review this at all, sorry, you all know better than
> that.
We're considering publishing a virtio-usb test device for QEMU to make
independent testing easier.>
>>>>   4-5: USB OTG-style role query and role-switching support.
>>>
>>> There's a reason OTG isn't used anymore by devices, how have you
>>> addressed those problems here?  And why duplicate the failures of the
>>> past?
>>>
>> We're not implementing ID-pin detection, HNP, or SRP - none of that.
>> "OTG" here is just a reused name for something much simpler: an explicit
>> role-switch command exposed to the guest via sysfs. Device-to-host is
>> driver-initiated (guest writes to that sysfs entry); host-to-device is
>> host-initiated (the host switches on its own and notifies the guest).
>> Either direction is always granted - no negotiation step to get wrong.
>> Happy to rename the OTG-tagged commands/constants if the naming is
>> causing confusion.
> 
> "OTG" has a _VERY_ specific definition in the USB world, don't attempt
> to re-define it please.  That way lies madness...
> 
>>>>   6:   endpoint-lifecycle robustness rework (async split-phase state
>>>>        machine, replacing an earlier out-of-tree gadget.nonatomic
>>>>        patch that didn't pass upstream review).
>>>>   7:   SuperSpeed device-role support.
>>>
>>> Why should speed settings matter to a virtual connection?
>>>
>> Because the kernel APIs we're implementing on top of are inherently
>> speed-typed, not because of any real electrical/physical constraint.
>> usb_hcd (host role) and the USB Gadget API (device role) both bake speed
>> into their core design - it drives enumeration, bandwidth scheduling,
>> and descriptor selection (e.g. SuperSpeed companion descriptors) in the
>> USB core and in gadget function drivers. dummy_hcd is a good precedent:
>> it's also a purely virtual host controller with no real signaling, and
>> it still has to declare and support different speed configurations,
>> because the framework requires it. We're in the same position -
>> unmodified guest USB class drivers and gadget function drivers depend on
>> accurate speed information regardless of what's actually behind the
>> interface.
> 
> This is a virtual connection, speed means nothing here other than some
> descriptor stuff in a few places.
> 
OK, will change commit message. In this commit I just add some SS
specific details to EP0 processing and fix SS issues.

> Again, try using the existing code, usb-ip or usbfs, don't invent
> something new, especially when it's not even visable to anyone.  Would
> you want to attempt to review something like this in that situation?
> 
Answered both points above (usb-ip/usbfs, and the backend visibility
question) - happy to go deeper on either if those answers don't address
your concern.
> thanks,
> 
> greg k-h
Thanks,
Igor

