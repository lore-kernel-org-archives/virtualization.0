Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA383AFB0B
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408652; cv=none; b=luTROMqXY7NHXoN9lTehjclNYcLZWyWOQrtRNSwtgeqXUvDSPKqGJLoAdDOLP1RVZh4u7sC05XEyK0X3Q87wxZdWH/D98sr4q86G85Tc8WVIR47D+CltCGAWcg2dP28Dzwh94+tHp8OS7Rp4L+GGzTs2aItmJxSU1FXhQzYViaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408652; c=relaxed/simple;
	bh=B+lPh7U2BBZYvgqo0Kv2fRAoVbSnJVu8B5Eu+PFE8t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7wIUa/rz7EVMH44jHFm5whJSKFRSXQ9hnBE/vHqXkOGsQ2afberqORZNdDFnlIrhqBQKHUaJHAm4COnczXcQQNjtCM+MxvVKDIn4fNBrWn2Sz21jRJamA9zqP2sbUYC0ylFVYrpSiYNoU9IMaco4E5bz7aCJ2NT9Y7S14g87c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k6Ih3Ebc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k6Ih3Ebc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6674JHfO2522632;
	Tue, 7 Jul 2026 07:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IqIham
	sJMvdXhwDFFYfxjYJoz/DwwmUXj0bXfsNjXvU=; b=k6Ih3EbccFvPOZbzBxwtba
	drZVTyW2thRH6CSDAD8dstWA0qSDI4ugBd+K0rTBhO9XriynTJeFVdY7GXB60Lbk
	u4UJ6cagPdSC14OB7EDLeL1aNCRt17zutl+sifngF1cnuWpQRsVgWoqK28ELJM5c
	j/GujaKYlLVVLY6taj/cpendPwwMCNSVpP2r2LsimBw7Z2wj7/9666KZ3OyxYcEW
	KLa3Q6gCzJeVZq2ZDgAXKrxvv1ombFRLZA96pgt6+ZmssRDGjCJZJtbx9y60zLb8
	4I8ySTvvsaJfB8e3CfIi1thvlXGDXtuUrc4hSk+JkRtylMCwfADT4rDMSPLvXQmg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkndm1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 07:17:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66774aln006788;
	Tue, 7 Jul 2026 07:17:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg18u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 07:17:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6677HNux49873344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 07:17:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B79022004E;
	Tue,  7 Jul 2026 07:17:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53C2820043;
	Tue,  7 Jul 2026 07:17:23 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 07:17:23 +0000 (GMT)
Message-ID: <3508dbb8-d110-42dc-aa25-4b3e73057422@linux.ibm.com>
Date: Tue, 7 Jul 2026 09:17:23 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vdpa/mlx5: Fix buffer length in create_direct_keys()
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260706141537.3510294-1-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260706141537.3510294-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4ca806 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=vzS-BDN2f1tDwvpw_ikA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TAHAfpf0HGsyEy5TDwYolEbXpBjDJtAQ
X-Proofpoint-ORIG-GUID: TAHAfpf0HGsyEy5TDwYolEbXpBjDJtAQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfX4s7A7+UvIbqe
 9T22Eg6b5Caoiw45XtQQRsWblpCLwJ+ICz4T030pNFvhcOXWXEYLb/8Ruee61Yo4MHptpopNtAI
 28zM5abBLKe8GtXMTLqBQnqEgcWha7Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfXwm7I0eK1df6Q
 vVRlYKlnTjm0HY4oykAzyn2A0nEs3yCWfJ5ZqEJ2PpriJXarJ17fRqMsXNsxIO+udUQM+PbROKq
 WlmlTkcQ5xdBKerP1qNOSRDBJsFIcC1ZYWxfIuyF/JGSs0d6fNni06uyA0LehsRfRX+JyxFvEHj
 8LA85I/sSfFEfGqbqIBAOVVqAqDdMZWXKUkPvg/mm2z/8l5rsSaCPEV/qudr+AsKL9MjkGq7vxF
 QWUZw6CqoIV8hAPQggpK/guwkwlmj0L8uIxLLrWs0u7mrXH1xh56T7c6o/LEQYfNXjq5mMc6ZxN
 ln2evalIpOhHXSUjpsN9qAjmzbNemdtsTSIuKoT4QldK0BScvYBe2D95SoouNgaxiB3CeJ+b5QM
 AM5l/MahakQyuYdBQ9PmZXPiZ/+QiMbE4DFi8VYrm1g/4fAoWvnNcLUbbWRdUqcSbbPl3D2wh2E
 YABCGj0tUtITQZu4eig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070064

Am 06.07.26 um 16:15 schrieb Christian Borntraeger:
> We have seen in our CI the following KASAN message:
> BUG: KASAN: slab-out-of-bounds in cmd_exec+0x550/0xca0 [mlx5_core]
> Read of size 272 at addr 0000000176795020 by task qemu-system-s39/82764
> [...]
> [<000011388ab3a7a0>] cmd_exec+0x550/0xca0 [mlx5_core]
> [<000011388ab3b61c>] mlx5_cmd_exec_cb+0x25c/0x4f0 [mlx5_core]
> [<000011388b21e82e>] mlx5_vdpa_exec_async_cmds+0x22e/0x5e0 [mlx5_vdpa]
> [<000011388b21fd44>] create_direct_keys+0x954/0xef0 [mlx5_vdpa]
> [...]
> The buggy address is located 4128 bytes inside of
> allocated 4384-byte region [0000000176794000, 0000000176795120)
> 
> So in essence we read 16 bytes beyond 4384-byte allocation.
> create_direct_keys calculates the pointer and length for in and out
> buffers.
> The size calculation for in includes the entire structure
> size (out + in + mtt[]) but the pointer passed to cmd_exec points only
> to the 'in' field, skipping the 'out' field.
> 
> This causes mlx5_copy_to_msg() to read beyond the allocated buffer
> by sizeof(out) bytes when copying command data.
> 
> Properly calculate the input size to match the pointer and allocation size.
> 
> Fixes: 0071b138d44a ("vdpa/mlx5: Create direct MKEYs in parallel")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>


Dragos,

With this fix our nighly CI did not result in a kasan message. As I only have
limited test coverage a full regression on your side might still be the right
thing to do.
