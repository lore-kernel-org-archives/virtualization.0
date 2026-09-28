Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832C4D795D
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603746; cv=none; b=r9NttBrNH3q9AMzAkJ5tISjZ8rAOAxD/TL5E0hTycpmHXWDusDfrqlBPT3FrBfqlcfxy7gBkmlKDZjlkRfGeDbHHqja2QS1E7HSgC43FMzEKIMUYbI5Q15S2wrpYKJkuFqwxMRXaN9A9DnObdqadW/iS7k6CxP/4A4Ka+nNMCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603746; c=relaxed/simple;
	bh=vI9c5rTuv2MFHLpc0LO69CguN4V55h1LfmXgqKewMEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzJ0uzxD6LhyjZOj290vPhhs7bsVbluyrziSNjVu/i4128kMeB9dHgA/d7PURVQtcQZ3DHV8mUK7rZG39P6V5s8RG+nHkFVnUeGzhcEy8CVqXLqDO40FNd8JI6v+Wj8MIAXGFrR+CYJUEaB5mL2drUUWOdZxaGzjWRQhXhVX4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M/iUjaJ+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BpQ6jHF+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M/iUjaJ+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BpQ6jHF+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBABRv1189373
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 13:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B/rtoACE7wUdC1UOb3HizFNURHsO85oBdpIJtVTpcEE=; b=M/iUjaJ+jvmdz08+
	CclFxiu4LpKG7Z3Fd409uYT4MDYtmzLAUZu41W0PcGVxug0IyZzBXPl9G9/O00Q7
	60JwvfvSorWh8DUzDMQhQbtfcgox1NvqbzWKlXCs9/a+6Di5MRKQhlSgbPbX4CYf
	aHi/wv//FatohnKGVboMFF5/uHT0lfUIK+rWWyZUBewz2tpR1DpOyaYfanjOXbV0
	XFjQuSbbtuJA8qUiDbDvLXVuPtR/h0optUyiZ/KXtefgNnH4wX528KA5uNCsfM6k
	6NsicbgGuR2BMe8T+D9gaFql+I2LmqHovsd2Dn+hEQCR/EhYzNqreN1sL6WCYv3Y
	TzSmcA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc0yyt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 13:55:43 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7b4f8ea38f7so1349783137.2
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790603742; x=1791208542; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/rtoACE7wUdC1UOb3HizFNURHsO85oBdpIJtVTpcEE=;
        b=BpQ6jHF+GU+OXv4bsQSFhqzPRjSXAX5qklc8X6FHOx3MYLiwvnaadePThmlXqP5Xrx
         SmO4c32ZpKMNQeKiObbNo6CVLdrBgPv5NH8HisFomFumhULjuptobTbHkDJuumJ8wIeP
         fOOk+f47UK58dAbOB8/zdnbTchfqsnLOe+nYtkoeO0JgQ4uIAGNk7JFRtABs9ZkT1UuS
         I1TLYtdarvWedXkO68HPE7ZFbtAyuMRMWY7PFjYDL/cI+rj5cK0lWWKzB4C1Rvv+MYLa
         WdRbSStroVwvJaXwQjmhqprINERBIX0+Aqu7+hFt6aOjvOitGFm02zMait9xAAR9zWxO
         x60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603742; x=1791208542;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B/rtoACE7wUdC1UOb3HizFNURHsO85oBdpIJtVTpcEE=;
        b=LRdJekLYyqx93Kx7qryAmAeSBytIv/Q7v4tTkPyHmxvWTuj1nYv3yI3WJtA2XlJOZJ
         pWoJUyb/oK734EooTKV0+Yl6NgDfOpgy59WrhHFjvEq+nTUETLJeRJ/oo+VGOA+FfVSO
         3O0gQM3Eil5iPzv4ErBn85crgYrC5QeowdiJABI7vdglG02V2gKFEJtcFxxWGEma5/kC
         lnN1tRQ/0R+cxrJZYjK6ChAzNSzqDy94zc712mLuUKOr2Ku17o3IbpJeDUYEMBqHYof2
         eQsd7W7soAhriMvZ/hg5/qT3ZNQ5bTMuhCG8FdcRIYBAQEF6mVdbH0y63XMpyDoc65T3
         GRcw==
X-Forwarded-Encrypted: i=1; AKwUvBxkezy6HqaCpQ66eUDVCxDAK6s2qEREis6/voN/JCJgwFzaVVCDm6iplaOIUR3jGHetfBUoU04nSi7uPDe4ig==@lists.linux.dev
X-Gm-Message-State: AFq9FYLY44rcnyj35Iy4jb7g+wSOUVwwtEzuVwKjqH1IMPawsNYKgXA5
	QV2oNv2AvrcYsIeotc8j5q0OvjmCOQTBui7SoEUEb8YTLXeQh6c7pRWOAcrCCWT+FAZzxhlWCCw
	1xzNqLodrygeIFAnJz6KYY+nPl3vtgQlMvobZemk6kuypLTgVA9z51F+nQ+Dbw4qXGTQ1Ug==
X-Gm-Gg: AYBFou3/bKNBlbruw5fx8VE9ojW2O0Dq144QD70DwVzVNwr3ylBfFKjWw/rgzCcrKVU
	y7Pu0OBfb+68h7Tg0297c7nMSkbI5V7u/5htdl4NFLVDguL/KM+ffZQRGO+YrlwgYrE+AWO+/Qb
	q62LeTvDMhoMZ1GsNDn2NtL/Vphh7Dc6fXC5pxpNKmwpVRgvU1Mh8tHGyQxsfvTFn0wdXf/FENF
	wFiHnVO0ibXrOLL6S0A3lWpcBUuHs7SOXWU/DF4C6QczI8xkEdo7S7FfedZXcdLPYQFUG/XCTWR
	CqITczUA0QnsmREHWwQjxASdwiDGnJId9GZ/qw+HuUYEZZM1/zCTiZjh9bhak8yzHEYBq1KnQyE
	c11XA/TteOL75gCflZrH0BuLVETvo7Q==
X-Received: by 2002:a05:6102:5129:b0:7a1:f7c3:3a41 with SMTP id ada2fe7eead31-7af1c17d7a0mr5392807137.14.1790603742298;
        Mon, 28 Sep 2026 06:55:42 -0700 (PDT)
X-Received: by 2002:a05:6102:5129:b0:7a1:f7c3:3a41 with SMTP id ada2fe7eead31-7af1c17d7a0mr5392797137.14.1790603741799;
        Mon, 28 Sep 2026 06:55:41 -0700 (PDT)
Received: from [10.224.243.150] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5dc1fd9sm4031577a12.16.2026.09.28.06.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 06:55:40 -0700 (PDT)
Message-ID: <1149e188-7279-4c60-bd96-f8d75d721ae0@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:55:38 +0200
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
Content-Language: en-US
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
In-Reply-To: <2026092520-aerosol-brim-22d1@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba71df cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=f4vCLKy3AMPYjWFKXbUA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: CZPeTwSIZAAhs8JbYwZ93R8Vh_0gvM6u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NSBTYWx0ZWRfX1pXKXaP6M1zU
 m5a5WhxTvkeL4C2S1GFk+aNBMeftlsnFlARHUki7gm3oiDDS/sElxYlqub2WIzf5tyFBQ+lgnPM
 av5dB60djXQb1aSsqr+GXrINv2Ifm8E9O4DlbDpF9qN23vzXQRubGFqDSowUaILvLupkqBTm0wT
 2lsg9GGcezfY7qzF8sRIVYYoh7b5QvWtzFXbKpXd5RdniSou1qw8PUMP5OWddTkZdnpsHuzcToa
 iGVtVI9DvgFQnjSBvb5b97DI2ml7j5H/wWLqVKVnoCAGztzd/1q8w3+VOSnV1Tv6vw08r3eVzZ0
 PSKUV5gcDO86SAiTVR+cGYx5GcWXwos287eS4Sddh3dT0322cHrOlbE2HD1u3tGQBy51J77dqEC
 umTgBcRuEuB4lhDm0z9FJuBAYVB+hcp9/r355LNI7T03URU1uGDGoqm2FSWFHQUWyCySDRlXeDk
 jGzVDegGIDacezrxj9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NSBTYWx0ZWRfXzRBid5sTRvNp
 NwG2wud0/LNsct48OLdqA/ojsLLoEtDpuUd7ahHQzjHxYjaGa5ielOlBiLrdoszA9CZF+u3vRXg
 w5X7MLDHGihFO7pRqM5HV59B+DMrlec=
X-Proofpoint-ORIG-GUID: CZPeTwSIZAAhs8JbYwZ93R8Vh_0gvM6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280055



On 9/25/2026 7:17 AM, Greg Kroah-Hartman wrote:
> On Thu, Sep 24, 2026 at 06:08:59PM +0200, Igor Skalkin wrote:
>> This series adds a new virtio-usb driver: a dual-role virtio device
>> capable of acting as a USB host controller, a USB device controller,
>> or both simultaneously with runtime role switching between the two
>> (USB OTG-style role switching) on ports that support it.
>>
>> The corresponding virtio-usb device specification has been posted to
>> virtio-comment for review. This series matches the v2 revision of
>> that spec, which reconciles a small number of protocol details
>> (per-role virtqueue presentation, host-role vp_idx for hub/multi-VP
>> support, and the device-role BIND/UNBIND event split) that were
>> clarified while integrating and testing this driver against the
>> spec:
> 
> Why do we need this at all when we have other ways of doing usb devices
> through virtio?
> 
> Why is a USB virtio spec needed at all, who is going to use it?
> 
> 
For device classes that already have a virtio equivalent (storage, HID,
video, audio) there's no need for virtio-usb: we can use
virtio-blk/virtio-input/virtio-video/virtio-snd directly.
What virtio-usb actually addresses is different: protocols that are
about raw USB semantics itself, not about any particular device class.
Two concrete cases we care about. ADB (Android Debug Bridge), a specific
USB interface/vendor-class protocol used throughout Android development
and debugging, with no meaningful way to express it as a block or HID
device. And Android Auto (AOA) / Apple CarPlay, USB-level
control-transfer and vendor-negotiation protocols used when a phone is
plugged into an automotive head unit.
Our motivating use case is automotive cockpit virtualization: a physical
USB port where a phone is plugged in needs to be handed to a guest VM
running the head-unit stack, and that guest needs to run one of these
USB-native protocols. The existing software on both sides already speaks
raw USB and works unmodified if it sees a real-looking USB device.
virtio-usb lets that keep working, instead of needing a new bespoke
virtio spec for every such protocol as new USB-based ecosystems show up.

>>
>>   [RFC PATCH v2] virtio-usb: Add initial virtio-usb specification
>>   Igor Skalkin <igor.skalkin@oss.qualcomm.com>
>>   virtio-comment@lists.linux.dev
>>   https://lore.kernel.org/virtio-comment/20260924154007.143927-1-igor.skalkin@oss.qualcomm.com/
>>
>> This driver has been tested end-to-end against our own userspace
>> virtio-usb device implementation (host-side backend) in two setups:
> 
> Where is that code and why isn't it part of this submission?
> 
The backend we used for the testing described above is an internal
implementation that we're not releasing as part of this submission - it
integrates with some systems that aren't ready to be public. We
recognize that limits independent verification of our specific test
results, and we don't think that's an ideal situation.

>>   4-5: USB OTG-style role query and role-switching support.
> 
> There's a reason OTG isn't used anymore by devices, how have you
> addressed those problems here?  And why duplicate the failures of the
> past?
> 
We're not implementing ID-pin detection, HNP, or SRP - none of that.
"OTG" here is just a reused name for something much simpler: an explicit
role-switch command exposed to the guest via sysfs. Device-to-host is
driver-initiated (guest writes to that sysfs entry); host-to-device is
host-initiated (the host switches on its own and notifies the guest).
Either direction is always granted - no negotiation step to get wrong.
Happy to rename the OTG-tagged commands/constants if the naming is
causing confusion.

>>   6:   endpoint-lifecycle robustness rework (async split-phase state
>>        machine, replacing an earlier out-of-tree gadget.nonatomic
>>        patch that didn't pass upstream review).
>>   7:   SuperSpeed device-role support.
> 
> Why should speed settings matter to a virtual connection?
>
Because the kernel APIs we're implementing on top of are inherently
speed-typed, not because of any real electrical/physical constraint.
usb_hcd (host role) and the USB Gadget API (device role) both bake speed
into their core design - it drives enumeration, bandwidth scheduling,
and descriptor selection (e.g. SuperSpeed companion descriptors) in the
USB core and in gadget function drivers. dummy_hcd is a good precedent:
it's also a purely virtual host controller with no real signaling, and
it still has to declare and support different speed configurations,
because the framework requires it. We're in the same position -
unmodified guest USB class drivers and gadget function drivers depend on
accurate speed information regardless of what's actually behind the
interface.
> thanks,
> 
> greg k-h
Thanks,
Igor

