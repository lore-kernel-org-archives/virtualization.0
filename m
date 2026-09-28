Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6EA4DAFA6
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605157; cv=none; b=bM2DuyJpquv/0p/1YlbNyZwPJ3j1M6jGlAk7jHcjo0ogrH7g6FUn3012Vm5BgSolaDKf6PiRs9MEWbv5JlreQJtcb3qfkJfPme2RLjvyYDjGWJOLp3QeZ2lLb5kN5WKNudiU/0TjIWQ037BKE9TU/XmDQePkyBSwhsxS6Cu5Bjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605157; c=relaxed/simple;
	bh=cHd+AGbgiR6kbIWovPWUkjehsKhorHaJgk8OxjzXVA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDViLysNsd36DvY9BlzOcb3qyfArwvqYzg5wPT0Zc86JSReiledqb/eIRl78yV1K/oU1IyFDvilCujbUB11+4Ij22+J9WSHh9wn01KwNzlsrhimNXK0iGQPqFn2ZKL7lXdE8cxCEZdEJ2fbCN0bZNWfqBX8MF+b5Y1X1XlBhFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dmf4lOKW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aIXmrg9/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dmf4lOKW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aIXmrg9/"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAL9g2404454
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 14:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G1Gq9bso3QuSJSV85bajXkwDOEjJ3tscsrkv0Eiicfs=; b=Dmf4lOKWKQFKbjLC
	dldeUARoifDCTaF7dMN3ZVYYUTqiJiiM0EuZO31lLlqf3QlAXMXURuujrjo+qdue
	18illohXArUq0GAeXN3QUFuio1PcJJHo9VgmL1sjHgZr1tqSMFcecudTP+2nqGTM
	1zNJvPLW4cUfYsg+cSPJGZtiNvZgIjCHoV+rezVf8Xu1iT2L8tfZXbWe/JxpM9Gp
	cd65vcmAyGWiJG4gcUV8d0FI7Kl6Dl9Ed58tFr7/UrkZlWNyr4bYqNJIsiJzshGo
	DO/WDg+c8tDv7R7DoAy9W5dEJg5TusExwlLu0/frWgi/vr4U+M1GUY3m5I77Rden
	ND6cxg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj6t1w9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 14:19:11 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7b58fd86edbso114244137.0
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790605150; x=1791209950; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1Gq9bso3QuSJSV85bajXkwDOEjJ3tscsrkv0Eiicfs=;
        b=aIXmrg9/il50C90J5uSRh25QJVdjgn+AgZw/ZwdYTW+cc3XkKaQW0przC1Xp5Vj4sQ
         qgumquiSTMLcy7/R0zLfbnTu2h6lH1ArKlL4hUWaXz7549nwFvrkpSG0f6ueO1JBV6lQ
         tOhy24XOx4N9T7MXDHHRIYhz21XKORCAC47xqEYl9SA0c6jMXlRpABsMsyOaXuU0p0b8
         mWhnq+fs0M2+VmLyVxScg8XoA4hxak6bIzAT/ucy0nNsZlaBOUWStI3PXiIc8AimnHJD
         xL6JOOxHk0NfrSZO0xeRMi8Ay9pKsdoYfdI0JM8clQb07OB/5LMuUexrS+reV3p3qU2/
         CWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605150; x=1791209950;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1Gq9bso3QuSJSV85bajXkwDOEjJ3tscsrkv0Eiicfs=;
        b=tKmNbsbv9lljzsDUGTcfeGIIL8UgzqUjhM86FIgJI1l6DCUH2mgc67oP1shBVbUg6q
         z0nB/aY7zV57ybPhVsaIVbJuDVTdz2TTayISgRla+vLzpg5xyhvl16K6hQRq0hz1LFol
         PIn32m/7wjry2Z5as25wHxYKjgR9AoTX3tF6ipDj2wrOAvp2q3bBCcDuvb3agTkbI1sv
         PbGlR+To2uXXbuPMwlVAgWCiZqTIzpp3CMIl/QfeEWFYPWbOck97v6BcEyjFNnwfgQNb
         X65ZNNoQ3lYP4sFVnK0X99faXNOvDJeaa2Gegjul4cdK/pORcSBTYW1IPUvF5mU8qux2
         TLIw==
X-Forwarded-Encrypted: i=1; AKwUvBy/yLhXa9D0ex3GcNkYZO6fJaAbvnamIuDB8hdgjzdto1Yw2h6218S/OltB0wvTycqFf7aQXWT7ncY4JlEOjg==@lists.linux.dev
X-Gm-Message-State: AFq9FYL+RnAbxIwxDdCRi0YwG1gmQyP1JYHJa37ARWGwlZoDL8iupp3N
	O8PQz5iPidvxCoizDB4zMHB8a0iLssU22mYJmWm/XbLoWA0gtBD5HE2emwC2TuKu/yb3GdvHHuv
	X0Ddp/WB2EEGJvRs2CImXJiftmjr42pRWgkK7bDEcEtX3WPY3WzQrvfLbfx328Ifx0AfnsA==
X-Gm-Gg: AYBFou0UP5HITyitMpAymkhezi843RiUbKDsHCTzcyV1CETyt+fcEF8g269GYvkdBVl
	DN6jUW+cp7uAAwMuVKM4Ha8Kmg1Ox0LhaXzfv/1hRFjzjOjyqUUG9tJeDyeSvedgpuRKK2FUIu/
	felTCjSvMGOtnypWrIgs9raLoqJ/fNfhBmqUBh60MgasdqXeK9BewnJT1SZlVcoowQM61rRHrmh
	12ZvDLQlg7D9jM6KPKI05FaoCOaFvRWXV3JsToL0bdy74i1SzDQtoAUFQtBZzi+5s4bY6+Q2b/C
	dHcFpWDYoc4lvF5xEg67MPccYFGbSnPaPcWQg3tfunA4o6aNHQ974dOjlfLvfHNdqtCTYiE0U8U
	6FNgpwhrwuN5VKw9cSODmOHYM7MIe0Q==
X-Received: by 2002:a05:6102:5801:b0:785:c39b:6a1 with SMTP id ada2fe7eead31-7af1c99cf51mr3398374137.6.1790605149880;
        Mon, 28 Sep 2026 07:19:09 -0700 (PDT)
X-Received: by 2002:a05:6102:5801:b0:785:c39b:6a1 with SMTP id ada2fe7eead31-7af1c99cf51mr3398358137.6.1790605149168;
        Mon, 28 Sep 2026 07:19:09 -0700 (PDT)
Received: from [10.224.243.150] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2af8ac48ccsm390077966b.38.2026.09.28.07.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 07:19:08 -0700 (PDT)
Message-ID: <b4d8a778-0a32-4d0b-9610-862ec5721be2@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 16:19:06 +0200
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
 <2026092557-condiment-surviving-ec8f@gregkh>
Content-Language: en-US
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
In-Reply-To: <2026092557-condiment-surviving-ec8f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX8rl/1z1s4nDn
 z0z90JMS1E9IdNchNU5c6jOqQ8zgFAf3SzJ6aRD2un7Q7k+vw+zfERqTmL1Bummt7VUdx+IP41c
 h2iB+0b1fbg5LAnBDPp46y9p7+XwP0N++ykXcsDXBEytTbk+xGjab9tf924K8N8pbHIKy1pvVTv
 IY/L69k3mhHxeJWH0lg1Uvx881eAKsb/gKJDUi5zlcvk1v4j3euKs8Oq1IKPbCTnmrt0zvsgqF3
 45nT/A7N+n85ieqb1R92Ghr6Z3te8vj1yFVpmg2vj/PssboG62bbioW3W3OgNXx8nHC0PUGrK4H
 ptjtPhRCwQjy3YMndRAUrjsi9llgJ75MHmmIfPAdmpbTyedHyGWgOUrj4awmYes3gCTVLPGWZJN
 wRvMsrvUQJjIUQgMBbIlvkZifqqZHo43TRli9S9Ok7tIIgJzfpXKsvG7zPlaPkAavxyOO+icMrr
 D7F4ADh/EDquNc/x1Zw==
X-Proofpoint-ORIG-GUID: eN_UExt25hFv_WqbF-lQ6Ubkt4FBI60j
X-Authority-Analysis: v=2.4 cv=dZkVTnXe c=1 sm=1 tr=0 ts=6aba775f cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=LOiNTj8lzfyKgz_g5nQA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: eN_UExt25hFv_WqbF-lQ6Ubkt4FBI60j
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX/+Dkntga7AGw
 rRFJzo5PguAd8eZhxQnZdcGiYg677kv0zjPBnTYir1YFHF2W7gVF/CIBX3ZpyPRJlTmc0rgbGe0
 Iift2vzvjWRtimfO/ASC8Bv057LJ3SU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280057



On 9/25/2026 7:14 AM, Greg Kroah-Hartman wrote:
> On Thu, Sep 24, 2026 at 06:09:00PM +0200, Igor Skalkin wrote:
>> From: Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>
>>
>> Add the virtio_usb device and virtqueue-wrapper skeleton, the
>> protocol header shared with the vhost gadget driver and userspace
>> backend, and probe()/remove() plumbing with no role support yet.
>>
>> Introduce a per-port virtio_usb_port array (vports[]), sized to the
>> device's negotiated port count, ahead of any code that actually
>> populates or reads it. Every later commit that adds a role to a port
>> (host, device, OTG) builds on this same array from the start, instead
>> of the host, device, and OTG subsystems each growing their own
>> separate port-indexed storage that later has to be reconciled.
>>
>> Wire the new drivers/usb/virtio_usb/ directory into the USB
>> subsystem's build (drivers/usb/Kconfig, drivers/usb/Makefile) as a
>> new CONFIG_USB_VIRTIO option, listed alongside the other USB
>> dual-mode controller drivers.
>>
>> Signed-off-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
> 
> Why does this not match the author name?
> 
Sorry, this is an artifact of squashing a much larger internal history
(100+ commits) down to this 8-commit series. Will be fixed.

> thanks,
> 
> greg k-h
Thanks,
Igor
