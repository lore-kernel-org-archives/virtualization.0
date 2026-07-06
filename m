Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589473033F5
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332841; cv=none; b=JQW/QJsObL3LdN3d8jC1k4uFYAFBbcCkBJm28MTxPPPGOXYb4HY3h50EKoLEDDd6X00CJDZqmk96hN7vKm9A3IJ4cFMpjP8SoXSOtIZBDKah+0A5GB2Rumt2MPWUnN+gI7vXCQKE1gsekT+KcB5GS6/8tGNpj9C1mCPl0cX7Zfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332841; c=relaxed/simple;
	bh=cFFd6capVQ43SEGeX4lnvc9YYxV8qC7D1AiorcI8/Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9KyzTYE7LI6IviMwn73gdkCNOxTlsVZZJz4jHB7HKcLRDs5DifI/UDhqtva2zCbjeu0zSjFrhE3RkRrVdhzSOKP9Y0oYLsQCEIXOdTUYVZbdqw2G5PVXg2SAnASfYDSZ6v2JGSGRIROZ/Q1oZFPzJRW9apOw4t+BcQAVrdY5GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kuGPR03N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kuGPR03N"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669IcCD3826562;
	Mon, 6 Jul 2026 10:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PLdGpr
	1loR0QWkUSKmb1OG+49nVr4w/mszpVi5Hg7Rc=; b=kuGPR03NRyC1bUx8YauQAH
	WzQQSH2732pd1Z/dXSJ954sHE9ljZ5sEJx0rOux98R2Uu42o0fASgPfGckAKgayM
	jLfGlNf5ApoMiK2Jj94ocFoajq1qv657n0GRjDr7Qsg8/Ko2rHD6lH45eKHBKMrm
	YshwkfT3wmutJ6tZNwQNLshNtfpuoeD5gMa6nq5lR625mq5RC8lLVubUrSIpNXTS
	jogvBgQkLMhbOjrAzVaZWB0KQF9OkfuAqr4sjQXZKKcGHQQoFpcMh31HpS0L2RGc
	PqBeG2zchzbSMP2xmvpzdmsVitnAbJyC8en3M8QEL/1zc8gECStSl/8IGYoL38Cw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn90am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 10:13:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666A4asv020826;
	Mon, 6 Jul 2026 10:13:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfvvnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 10:13:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666ADuJE49414488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 10:13:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B78E2006A;
	Mon,  6 Jul 2026 10:13:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C52020065;
	Mon,  6 Jul 2026 10:13:56 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 10:13:56 +0000 (GMT)
Message-ID: <06b371e3-418c-41d8-8c06-1971cc24d8d4@linux.ibm.com>
Date: Mon, 6 Jul 2026 12:13:55 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH] vdpa/mlx5: Fix buffer length in create_direct_keys()
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260706100129.1541140-1-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260706100129.1541140-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4b7fe7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=gjSsBFNJ2Uktv7ck9yoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lBfZTknOkrt9GsIYB5JR48Q1F41CgGNV
X-Proofpoint-ORIG-GUID: lBfZTknOkrt9GsIYB5JR48Q1F41CgGNV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5OSBTYWx0ZWRfX5p0oPrVqi9L/
 PMzM9LvbkqOWhNpQisbsdzHju6UiEDLkKaSU/ECc8ncqZNml32k8BmovplamJwt0i0MSCQXzRTR
 qxbGJ+6Cdw+EN3KX2kjQgGEOy4BulX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5OSBTYWx0ZWRfX4q14k6IfYGIb
 mkBPZk0PVmHOA0vK2S5efIqv6jomHvR4bzOmGZlpHBsOOI4iOBf65s6UvXtZnPQCH4d8gssWILW
 CZEznilE+ZUOSO3V9j3POjthC24whN12nXefmMxBt+0Jo7aOoup6du1w5ijLSMz8qbBKVcPkUYp
 vyFdtxhtbFDcLTthxUSxWrvyODIgOafs7U3j9wrSFS2Mdvzl/dKdkL+b6S5r9yx7HdX06Z3U9pR
 ouSTb74iZBm5xczQh+AM9pvGtjvisxi86eMz9LzaA6RQxtskR+IHm026oZbyN5zSrWFzP4w0eO2
 Rd5AldwzXk/9DRGa3hTiXGBK2aTtljNi2YjgFOc5SwR3c/aQOEgGY1dGDcqKwF/mhk3xgppAI1h
 tX+TcxZXYGtiTucPk3L+JpnYjuYkAiQilQRoq3E/0ZWuCJl7hoOsJgsYKKiVIRWdmTlJyDCuCEa
 9zsAXl0A6wTEx0NXANg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060099



Am 06.07.26 um 12:01 schrieb Christian Borntraeger:
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
> Calculates the input size as sizeof(in) + mtt_array_size to match the
> pointer and allocation size.
> 
> Fixes: 0071b138d44a ("vdpa/mlx5: Create direct MKEYs in parallel")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>   drivers/vdpa/mlx5/core/mr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 6d02ccf9eb91..03fe7f5ca412 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -233,7 +233,7 @@ static int create_direct_keys(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *
>   		cmds[i].out = cmd_mem->out;
>   		cmds[i].outlen = sizeof(cmd_mem->out);
>   		cmds[i].in = cmd_mem->in;
> -		cmds[i].inlen = struct_size(cmd_mem, mtt, mttcount);
> +		cmds[i].inlen = sizeof(cmd_mem->in) + (mttcount * sizeof(cmd_mem->mtt[0]));

Assuming the fix is the correct fix, question is, if I should use the offset of in instead, e.g.

		cmds[i].inlen = struct_size(cmd_mem, mtt, mttcount) - offsetof(cmd_mem, in);

to handle potential alignment and padding aspects.

