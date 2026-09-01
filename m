Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4292C364E89
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258677; cv=none; b=eCZvkGkP44RmWQHVUPBoBh19Xky3jOtTSVUR3ZluleiWK0qKS6Fs3WrNZkDfAdiNj0MBC80UKe8/rP12oNdN+dtAOHrk1JbRd1CSzkjLD/yZ5luUfVA/vw9NRuwJIwt3WvY09BW2WXgtu7mKCejhD1AFEuIkMQwkCMTi7sxyUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258677; c=relaxed/simple;
	bh=kNwdYXQxhSnCBMo14LjoO5s99k2b7eHUDeXaniwjW0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDlPYqu25cGNK4i1zKPktnLfc3SjmB9hR4PNwPmJbL6RTpWuyQTUxAjBUBv28ygW9edn6mhSxPkp4JVOrZWNQGc1NyS/Z0gwjWlzP/5IWxUjt9h/LCMQWmczZHxDjuLK0jNL0dahChweqjPfLQqhGF2GzlNaPBZO6cDngWVkCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Udpn1XyE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M1mxtxd5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Udpn1XyE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M1mxtxd5"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJXvD1137380
	for <virtualization@lists.linux.dev>; Tue, 1 Sep 2026 10:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WNBYVEL4VD2Rb1PjIgbFv4Nat0n5GM6fK73Kzf1E+Do=; b=Udpn1XyE8KMUv4dy
	ua7EUwZ7of4nqHKtJLWxgXXho3GiVuCPw6JUwr4R6BF7VCyyyZyfVc+ZChbBGYZP
	9B6NnIycJaXUHWXgEFdZGcOGLU5+t1DrE6QYsT2UeeagN/WctBsDCV/OyDfKlfV7
	qg3OdCmFzTzxC7YUTs/gz3MDnAzqyQuRtoNdyE2fe/+24kXaQRaN3wlHOK6L7m6R
	6lcy6EQBqrtsWqSc1wf8i/bxakgynqKJWqfHHpvkS5QCg7L0RjTHuZdfeidLhOVv
	VtRIQD60r92PP9CkdqFC8mzUwyHkBLSOEIZVr9NbIkfq0ySOsDrsxwqY3v9a7L+s
	655Lvg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdrcshb0w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 01 Sep 2026 10:31:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dbf293831so2026786a91.3
        for <virtualization@lists.linux.dev>; Tue, 01 Sep 2026 03:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788258675; x=1788863475; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WNBYVEL4VD2Rb1PjIgbFv4Nat0n5GM6fK73Kzf1E+Do=;
        b=M1mxtxd5C6ZhUvmelyQfD+o/Ag54Y9b1YYq66CiThDR5J39HGgmLWpWBIFrEV5PQBi
         hGTpGGJvBtK/EQjC+vB778eN8E6JFZla6IzlOXErRIWIoW5uWxHJCs4L2hPiXalgzPFP
         9+DWDgMP/UcEiMAW+OrnynKDTA6htWL+5I1YLRQW89pm2vKUXOdvjNeVW4CoUWJ9fPst
         OzpTCLaIcIs358QE+ytKuwha/8NPBhgtyzudEUO32P3lWcpYTUF+gscND8eegoiWVKqc
         V1x3t8MHms2l0yKkkah7PXHI9/7/g8Q6rpcBbl5mFjW7lvWm1+uabP0Yo4PW//9bQzRp
         QqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788258675; x=1788863475;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WNBYVEL4VD2Rb1PjIgbFv4Nat0n5GM6fK73Kzf1E+Do=;
        b=oC6XAYM9J/kv0O8Ark1Jl+fbcECy1BL+UMeVvi3V7Y33qhbwjg9soPEFn9vIRx/psd
         E3UshPsx9SV4nWD79AolbHxvCVmgg306dfEiQco6kuwGLMr/IpTHTWl2XCdnC8ptseMN
         4fG9PYCkhWfjK4QPEe+E8wFfHGsDEuaSFSKDCOF7kzRJPXralecpd4EWthkExD93lw1e
         hamH03tj7ubpmFEussFmySxQN2Cz+SkQcuTnp3anafyb+/QNqeWS696NljHKefHuobbS
         zXb/yg5RWsGALEd1xqLV/x1XgJ2s3/rcmpiQ2rhohEwn03TIuh/Y71+VhKh+3obuWP9+
         sxOA==
X-Forwarded-Encrypted: i=1; AKwUvBx2ymrJwSFgGAqMt8qyzdlUvyRPYxQPzbrk6n8xFwjXkk9O4xaQZ6VpkGhjVspMAK2dMUTq600NpBlLsRRVvQ==@lists.linux.dev
X-Gm-Message-State: AFuF++msPSTN0pbFO89X4o1zshqvtPUJ8xuviXk8hHOUyYiZBjFLs+vr
	0FAcXZxBS03R8OpP9XFLfQTWLeumyAoKk+/fiDtcCGgmm0P2Wskt+ps1m+UKOqEyGTZWvI/xLeb
	90ncBQkM9TK1M9F0KuylgRi+ykIqP+/M5xZzMT725BhNh8xgmGZk7wzAlt3PV7fF7NdbyLg==
X-Gm-Gg: AYBFou3OdEx4LIEi7C/1WFKpmQJP2DFSlGmol6nXxhItnQ0D1ZRk7+NDz7rRX0vJcIQ
	SPZd439ZGuE1M1jnXu+QtglkZ5DyYwkalntWE7VXxuJVE/g8dHSegx0o+2840BJND/Fvy8qwe2S
	hp2Zi7vXJwZT76AlDEL1t56W2Xr1+DH/NjWaJnTp3AGN/kvZaKYaszbl8FOpRsY/tfIoLArkOBf
	nVDkglfuOtHt1lPHfWxaWWqXcB7rl475yLkpzK5inGETU5muDM3iYccyZQ/a1RLuRc3lHhZDFUl
	oLDy393srIeBn8/AGkliCqE9EzEkx0jptgYEd5taasJI7caBug0iuiPJi8q8pnFCxK388sHa9yF
	WXClERsWR4DvKEbwvONXxS+/w4dw62Vu1yQUv8yXpGJ7GgGYVLHR9h/uT
X-Received: by 2002:a17:90a:4cc2:b0:396:d27b:89b9 with SMTP id 98e67ed59e1d1-396d27bb20fmr26125899a91.10.1788258674561;
        Tue, 01 Sep 2026 03:31:14 -0700 (PDT)
X-Received: by 2002:a17:90a:4cc2:b0:396:d27b:89b9 with SMTP id 98e67ed59e1d1-396d27bb20fmr26125813a91.10.1788258674024;
        Tue, 01 Sep 2026 03:31:14 -0700 (PDT)
Received: from [10.110.34.210] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa37fa5sm40964900eec.29.2026.09.01.03.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 03:31:13 -0700 (PDT)
Message-ID: <40156974-6637-49b7-8629-11e7d0d4e55d@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 18:31:05 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] soc: qcom: crypto_virt: add support for create,
 prepare and import keys
To: Krzysztof Kozlowski <krzk@kernel.org>, ebiggers@kernel.org,
        axboe@kernel.dk, mst@redhat.com, jasowangio@gmail.com,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: neeraj.soni@oss.qualcomm.com, gaurav.kashyap@oss.qualcomm.com,
        mani@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        bvanassche@acm.org, alim.akhtar@samsung.com, avri.altman@sandisk.com,
        stefanha@redhat.com, pbonzini@redhat.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
 <20260827160806.1295313-4-linlin.zhang@oss.qualcomm.com>
 <4594e3db-a8e3-4f8d-95c2-a4edcbc8ca7c@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <4594e3db-a8e3-4f8d-95c2-a4edcbc8ca7c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5MSBTYWx0ZWRfX5Q9Af6WcnHby
 JMkEIp2r7u5x+Q/XFyE9tqZDAPK8TlsODfjPKkEsrGrYmYCunHqj3hbgie7S1cGRlq0ScSDNKS/
 XbTNn3OEJlKmSeoBCQhMWjc7wf+qrww=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5MSBTYWx0ZWRfX8K5qi6S1KNJu
 4LIBU+cqjKXvqKfB16IjaZQorc7PBN/o9c1Nq9jTPCigEZjqBYrQ3wumLcwwBfoJTAIw1X71XSH
 tmELJg1uUEuEgk/LnJN0pUIAj2zOun8v/cy8v8U8nxkx6jkFAae+HoJAODPyph0y220whUjbuR5
 19icJtrlXGlC/pyyE9EePGg7EuT6iySxg5gGZcAiSdrObTt3OTFjd3bODWbnbGkj3sNryN2KNXr
 7967wXzI3yxnsv1PbqJlwosoi9EapR828rAndrylEt1zQ38Imm7p0LA5ympur+tV6Xu0yZhjgOK
 1BZJ3ZTYmHCzui4E4HK1RT5DRwL8PzBs88dxnHR7fDqP9MBBFf6bhjxDzUYv/U6GqAdD0QmBOP+
 HgDltQo5/b9QroyN73Jh14R+rltHvEvi6Isqjiwp6asSvoMdEG+VV0S598C//M7jjWED7LqqSK/
 BBznzpVdO+aLTBvqyww==
X-Proofpoint-GUID: 85yJsKTYRFP345oPXq4dFwFxaBMlGYAE
X-Proofpoint-ORIG-GUID: 85yJsKTYRFP345oPXq4dFwFxaBMlGYAE
X-Authority-Analysis: v=2.4 cv=QsNuG1yd c=1 sm=1 tr=0 ts=6a96a973 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=2tBp2Vdcr-mqUi0jtlkA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010091



On 8/31/2026 2:58 PM, Krzysztof Kozlowski wrote:
> On 27/08/2026 18:07, Linlin Zhang wrote:
>> +static void crypto_virt_remove(struct platform_device *pdev)
>> +{
>> +	virtblk_set_crypto_ops(NULL);
>> +}
>> +
>> +static const struct of_device_id crypto_virt_of_match[] = {
>> +	{ .compatible = "qcom,crypto-virt" },
> 
> Undocumented ABI, also not really allowed. We don't take bindings for
> drivers.
> 

The dt-binding document is included in another patch in this series.
The concern about introducing a DT binding for a software-only driver.
The underlying problem I am trying to solve is how to communicate the
wrapped-key size to the guest.

Because the guest has no access to the ICE hardware, it cannot get
the key size by reading the ICE hardware directly. In the other hand,
the wrapped key size may vary across ICE versions, it's infeasible
to have a fixed wrapped key size in the code. Additionally, wrapped
key size is vendor-specific, it's nor proper to pass it via virtio.

As an experiment, I used a DT property to set this wrapped key and
wanted to get feedback on whether this is a reasonable approach.

Is there a preferred mechanism for handling this kind of vendor-specific
configuration, or are there similar examples elsewhere in the kernel
that I should follow?

>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, crypto_virt_of_match);
>> +
>> +static struct platform_driver crypto_virt_driver = {
>> +	.probe = crypto_virt_probe,
>> +	.remove = crypto_virt_remove,
>> +	.driver = {
>> +		.name = "crypto_virt",
>> +		.of_match_table = crypto_virt_of_match,
>> +	},
>> +};
>> +
>> +static int __init crypto_virt_init(void)
>> +{
>> +	return platform_driver_register(&crypto_virt_driver);
>> +}
>>  module_init(crypto_virt_init);
>>  
>>  #if IS_MODULE(CONFIG_QCOM_CRYPTO_VIRT)
>>  static void __exit crypto_virt_exit(void)
>>  {
>> -	virtblk_set_crypto_ops(NULL);
>> +	platform_driver_unregister(&crypto_virt_driver);
> 
> You just added this line, so previous code was simply wrong?
No. In previous patch, virtblk_set_crypto_ops is called in
crypto_virt_init and crypto_virt_exit. This patch moves the caller
to the driver probe and remove APIs.

> 
> Please read submitting patches doc - you need to organize your work in
> proper commits.

The series adds inline encryption support to virtio-blk as a whole. This
patch implements the wrapped-key handling portion of that support
(generation, preparation, and import), so I included it in the same series.

However, I understand your concern about commit organization. If you think
the DT-based instantiation mechanism should be handled separately, I can
restructure the series accordingly.

In addition, Eric suggested implementing blk_crypto_ll_ops directly in
virtio-blk. If that proposal is accepted upstream, this driver would
likely become unnecessary, as key generation, preparation, import,
programming, and eviction could all be implemented as part of the
virtio-blk blk_crypto_ll_ops backend.

> 
> Best regards,
> Krzysztof

