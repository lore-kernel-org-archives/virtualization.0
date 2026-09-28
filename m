Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B464CC610
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604886; cv=none; b=iHfFm8WYKFyQj9a+16Ewo7clEt5q9POiF5hNkMF4cYx+n6tnNxjUvN5OrDJc33hEgSFpD8xlS/ZYP9VJAEX7NkElqcoFaK2BUCt69GuMF8i1gmmhont1Mk/4yslxNdz2Cyx1g4DL0j5FowsOPLW4QkAJz+EOSYkaUSEAyEFEe00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604886; c=relaxed/simple;
	bh=7fmmu/OsS0ybDnKRBy1YDaqCk6xFwY4kjcPp6hJw3mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeTYhcy8vlck+47I4nqFtcUkLozbN2hpRASemGez7RxCV+uJ1wF3Bso1Bt3Ezc3VNzqxQk+1m2sJ/yH5s1R3FzASQ+Feat8ySXTZ3h/FGTH+6WYVJAN6aNxLY55X4tHV9HaLNiEz/f4SlDxK8XiFgIk8PKeXH3dUQkav/LidV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l1yBh6J0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PkKeYTvQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l1yBh6J0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PkKeYTvQ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAHC31189568
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 14:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iBhwQB4VLhD/2KWOJXfWnm00PDgiRoZsF7cvuVs80Tw=; b=l1yBh6J0Z+4UcHz1
	kIGKj8nZxJHDk2Y4yrxHqbBIou+0lb0yKLg4f9USDqIPhC8KI9hi8Lwgl5k37373
	/SvlyLihFIAdIy9gpk5hJTyXAz/gxMR//Hm9FHyyVkNDJr8tGGQotHkb7XLRrp43
	6JGmx7+g+DTjp/fnWOLjCXO365GhpK2CUh6dYmK6lGrX7yP0WOhzwmkjU0/jYWR1
	Ljc8ChLQM+1X3dhZ1h8iH9NQBbhVLm/CQm5rvyAVxO1zw9snqnf3/TfNEXw5TKTN
	e4ULcTDV6DW7UZr3Fm8uAOxOkGBOrz/kZZvng6BEus3UEyLrh1Xlt6O5om8kSkRn
	Env+1A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc13fc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 14:14:43 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-78d25a8ff32so773131137.2
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790604882; x=1791209682; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iBhwQB4VLhD/2KWOJXfWnm00PDgiRoZsF7cvuVs80Tw=;
        b=PkKeYTvQ3WIbSvrlc8npV+rLenEaWx8/XpyfgzvQT1HeZESPFvCoMEezHS5RXtNTjo
         +Eu74lVx8EVIDqct4b1moK622gUrRK2BT8nVYWukf0weaBnoGJrY0mtVAiK2e5pgKdSW
         FcTCgXKEeSylvuPvPm587aTbWySVr9Nd7r19JAPAcrA5W1uBBmeKpxeA8QEHvKjicmix
         ePDDothZshXU6iVcHomB7FusbeSX9eU81lnke4JTieNXdiTi28ktYuoF/dYfk2Lgl5et
         RX8Qlc49F4ULdvY6Le0lsT4/7tVCYxZPEB0D92j39NTI9zVjL+0ZzTkxjR/que0RmBzp
         DShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790604882; x=1791209682;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iBhwQB4VLhD/2KWOJXfWnm00PDgiRoZsF7cvuVs80Tw=;
        b=J/+GGp+VOrdXPiViNtMxxllncAlGzEbpDkJ2XhdJcUOtkKyn3nPDt+MfjyZ39Sy9Bd
         PpA3LyLjsuIjRyLEjVmnj6SC6bt/aN/+5MiZRe8khEQbdQ1cx1pJmLeLXitp5u3528Qm
         9G+NmkSehrZZGdephL2P1DXnJx58O32UPYUAV85MKwlQ0duVkTys1lARLP0Xc4Tg90fV
         FGA3ANA4SS9ySnsSu/ZKzEJtbwuobtJbpLHrtO2vfg6iq3JAnPITL1Pmj6FdqyCb7tTF
         arFbWZh+FvWCbCeKjq4Mz14rVnPHoNV8gU/YNgE1EVrzwNdEQiOzqp355aY1JchpRcjC
         A5Cw==
X-Forwarded-Encrypted: i=1; AKwUvBxlqKRNakEPPl6iVbJQpn/VgK7UFjGzO4ATOYWjLeZfoP3CydKNQN6+hFAgLZr7TomB/2S9kjlmG8cwLdlQTQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJtkUa61CJzsmsDuSmx33bnDXTuCa8yAjAIXRBeFodMVfitzT9B
	Xwx3LHTax6cFBxhdHzpgwIC3TC3qcCI9giF/70weFUnxCLujbCCkqNOLhfVjmmV7hOq7urje3s/
	m3BCwew4cnkJ06iKo9gEiGsIXjOKl+xRcrk+/Odq8XBGPxb5mnD4mF4++4V8YQGLSlw1lMw==
X-Gm-Gg: AYBFou15Sqp6VuF62a3Q1jOnKAx+rzJxHxdqKESUhTVuCpoVNYk9IdFvuoVNZJ5gHAA
	EMgBPs760khsRbRKlgARQxmU4e+/iw3xXjLNTIyqmvs/fHUxxoolqXde5TYzeDJmaEcC9cFYrsy
	flrHRDu2o1J0I+PTXZR/OcoIPW13zXBKEaY25ccf4algS8U9HQ+xm5MN2EN/09RWu5W+Ix5pUt+
	jmDVk+FZjCWrT1thZUTvSMxVDb6jYgswm1qdeGf5moP9mvqOhbTtKOIWwPUm09wR1R2bLTSphms
	m+I6nOboSaI2W7t2+yZWTvDQfYGKz0HLANj5VxFMi3gQ4V6zAcMnPmwzzuMOcGO3KV/YNqFV/me
	ciyliyOSNlqoPLqaBaJ98cvOYeYyDVQ==
X-Received: by 2002:a05:6102:e10:b0:790:c7bb:43fd with SMTP id ada2fe7eead31-7af1c58e8a4mr3937084137.8.1790604882597;
        Mon, 28 Sep 2026 07:14:42 -0700 (PDT)
X-Received: by 2002:a05:6102:e10:b0:790:c7bb:43fd with SMTP id ada2fe7eead31-7af1c58e8a4mr3937070137.8.1790604882052;
        Mon, 28 Sep 2026 07:14:42 -0700 (PDT)
Received: from [10.224.243.150] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae600684esm4601864a12.30.2026.09.28.07.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 07:14:40 -0700 (PDT)
Message-ID: <477aa40b-8116-4b00-81ad-b726a83f2bfd@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 16:14:38 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] virtio-usb: add protocol header and skeleton
 dual-role driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowangio@gmail.com>,
        virtualization@lists.linux.dev, linux-usb@vger.kernel.org,
        Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>,
        Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>,
        Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
        Trilok Soni <trilok.soni@oss.qualcomm.com>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <20260924160907.145405-2-igor.skalkin@oss.qualcomm.com>
 <2026092509-slightly-driver-1b18@gregkh>
Content-Language: en-US
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
In-Reply-To: <2026092509-slightly-driver-1b18@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba7653 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=yoz57VtyOFrzIFqIlQoA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: e6BqquAFOIaFQ7B36BRpCXw9xKOKJTJD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NiBTYWx0ZWRfX9hgs1ajViEYe
 sDtmUXlB+ftVqikUZS87jCcEEArULeuVpERn/z2ZondocUPbhlHsPEeuDqpf8ozlhzrq+V8qGXn
 aS8QpbhU6yHlWt4+MlX/mRmQ4/507M1wtds0OUYioRb/R/FIYDzKU5Z3VbP4biJNcPRuthxw/XH
 UaaCwjeiQIWm/oybJ4rkeqweVzF6hzoLbeTO1SFC0rLzDKvW+to69xkjus1HQf5h1FIV08iCXfv
 W8PrmP7MYBNUtCYDEm8U9SYcMpFTSQ/Rsh3z9CETl98V7vB5vtnpZeIgWtGxuh7GgudFLEHj56Z
 a7l990GETRNsakBRBsgtmNrGfpx4tvbXhW06ePPR/GG/XFxU4RdY0f98QEz2XQSj9k8cp5RKmyl
 6rPOXdQPNFnyjbyR4Ip3bBqKrcwFv55Vzq/dtd1I3mpmO4SexgHgdUsQmyXu8t2qvMP+p/LuTAt
 Z1TTNeuYd5HKDln4syw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NiBTYWx0ZWRfX9lQtQE6hI8Gp
 2io94BRktS9Lib8GP1pLoL3Fj9cbY5GFQp3FAvOUFXSV/xE7CMp3gFvh7BG94hfYctsX1l7iUyR
 6/8Vf6jS3L7QD0SGK8cPxa44v+3ZG8A=
X-Proofpoint-ORIG-GUID: e6BqquAFOIaFQ7B36BRpCXw9xKOKJTJD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280056



On 9/25/2026 7:21 AM, Greg Kroah-Hartman wrote:
> On Thu, Sep 24, 2026 at 06:09:00PM +0200, Igor Skalkin wrote:
>> +/* VIRTIO_USB_EVT_HOST_PORT_CONNECTED/DISCONNECTED */
>> +enum {
>> +	VIRTIO_USB_SPEED_UNKNOWN = 0,
>> +	VIRTIO_USB_SPEED_LOW,
>> +	VIRTIO_USB_SPEED_FULL, /* usb 1.1 */
>> +	VIRTIO_USB_SPEED_HIGH, /* usb 2.0 */
>> +	VIRTIO_USB_SPEED_WIRELESS, /* wireless (usb 2.5) */
>> +	VIRTIO_USB_USB_SPEED_SUPER, /* usb 3.0 */
>> +	VIRTIO_USB_SPEED_SUPER_PLUS, /* usb 3.1 */
> 
> Please enumerate all of your enums with explicit values as these are
> going to userspace.
> 
Will convert these to #define constants.

>> +};
>> +
>> +struct virtio_usb_host_port_event {
>> +	__le32 code; /* VIRTIO_USB_EVT_HOST_PORT_XXX */
>> +	__le32 port_id;
>> +	__le32 speed; /* VIRTIO_USB_SPEED_XXX */
>> +	__le32 padding;
> 
> All of your padding fields MUST be verified to only be set to 0.
> 
> These are basic "how to write a uapi" things, did you all not read the
> in-kernel documentation for this?
> 
Agreed, will be fixed.

> thanks,
> 
> greg k-h

Thanks,
Igor

