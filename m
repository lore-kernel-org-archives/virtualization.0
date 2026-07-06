Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1B3DDAE5
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342772; cv=none; b=sh8h07r0AkYo6Gw555ZfDbxh60gNNdhAv8HuAzBDaRWHY2VzYrAM3cYfs3PzeY2R4+xllsOYKmEG6DleQRyhbUFUbJdboNOK+fOmtTdCBuNHW1dB8j4sa+RgniYleyaF4rrizk8NTj7NYzvZW151xIzgzMasmFDI4dX+g3HdYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342772; c=relaxed/simple;
	bh=FifK7jN6Cu1Qxry7NO3XnKyC8D9yPjG9kd22WOrNNnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JACrq8HNJ0lNTaJYLU2rKYX0sTfAhNXaScOwKmx76iWgPzrUIHl+IKbZ6g0qWz8JeLMteqzLT7f0BgaAnwIDJUZVJkUNVT+Vm/1Jr/AqWAs82tyRvfhlmwzAsnAeOqhElMO1QDFtRMvjjfxl8M4pFtIbv5MkWxuHKdBF/f7nUcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uoy/vRCL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uoy/vRCL"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BISxk3447713;
	Mon, 6 Jul 2026 12:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zudwVz
	ZVIiUvZFfeArOUlYRwLpKRLTCHHcE0xj02bGc=; b=Uoy/vRCLTQLP2KxoawocqQ
	5EnXflvgvq9dRBKvEqZZketRwbgfCyV25NYIMd/eOTo4+I7V7BUs+HL1PpPHKWHN
	XzNL6JlTC+dnkFaZ5/OZSLF6VKeOD8XWNTPuWvn6wE4XLT1RVnytqhXBhFoW1Cqj
	r+NFtQI2pGN+VI30rwAOPMWDF0kL/o/5L3wo61hHSAZnYyoSLMtB00kl7puu+vtv
	Td52GUdxjEqBdKUies8fmwoF3OkHn7DAF2uI/jlmpIsZlJo5sR4plJPpOxyY1axo
	xhLEks6FMVAn0CUXrDsNlSk6DS54LCN8BfvUI7zDUYppvQgdcMA+MiuZFMWYLVLw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsj001-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 12:59:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666Cnleg015849;
	Mon, 6 Jul 2026 12:59:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvwsca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 12:59:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666CxQ7454723002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 12:59:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9035120043;
	Mon,  6 Jul 2026 12:59:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4070920040;
	Mon,  6 Jul 2026 12:59:26 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 12:59:26 +0000 (GMT)
Message-ID: <530d7a50-3bd0-496a-bf41-3b99c8fbbad4@linux.ibm.com>
Date: Mon, 6 Jul 2026 14:59:26 +0200
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
 <06b371e3-418c-41d8-8c06-1971cc24d8d4@linux.ibm.com>
 <d7272d8d-8146-4ed0-90d6-2a27eae5ab6e@nvidia.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <d7272d8d-8146-4ed0-90d6-2a27eae5ab6e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RUhYWlvgKVn7U6yaKQ6zY9FvGUE8Kxch
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzMCBTYWx0ZWRfXzxjgkGK3kCvi
 PP0dse4sboJB5qRItODe0Uomk5YWrbj7nP55Payfdfxp/jdaX8Fy8Lb63fEdwWu7+ZdUx0BvOUf
 5GUjw9QdjDoQn3fI60ujfMGkQS99q1U=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4ba6b1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=5a6MezmEKx9941N3190A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RUhYWlvgKVn7U6yaKQ6zY9FvGUE8Kxch
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzMCBTYWx0ZWRfX6XPo9yPbwRPQ
 to/f9UElnmc1ToQYhts7Tq7bcVJCr716Gg/jAG2ixmvfGfCvcbhOJvX3bngT4HfEAetR+CpGCJt
 sftqxySO0fOgDKPvkgkHLvHNpscPvQFzr/z1k9KG8nO0dNGdJUQ7UzR6wwY9g3G4RjiqHKnm5Io
 90YHoOcq+OYfqUjXhVO6ZX9WQ7E3JzTwTPXJDwJzdfu9lUcudQ5Kori4er3672bFyJY88y8aYoO
 DnuGm+rFkYUS/PpPy/QOjtCAvtCy8UDT7XW6MlKA5bb/Klx8j66po5ibhlaT9IqlvduXxLtOG7e
 zynD/vYrEcP33o5WEga/nFpyCFRGituFweBNRhH26aZSQBljA5x3u2zXJ+/EbigrgbGzoh4SK+V
 fDKutl+xlDbNEqsYs/qO+pEoSVyMLcDANkmXY+BfYdhk58Q1dFU3vgxq8VWaaBjO2bqkmRjAvRi
 7XMbrcK61Sjt1QvRvYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060130



Am 06.07.26 um 14:24 schrieb Dragos Tatulea:
> 
> 
> On 06.07.26 12:13, Christian Borntraeger wrote:
>>
>>
>> Am 06.07.26 um 12:01 schrieb Christian Borntraeger:
>>> We have seen in our CI the following KASAN message:
>>> BUG: KASAN: slab-out-of-bounds in cmd_exec+0x550/0xca0 [mlx5_core]
>>> Read of size 272 at addr 0000000176795020 by task qemu-system-s39/82764
>>> [...]
>>> [<000011388ab3a7a0>] cmd_exec+0x550/0xca0 [mlx5_core]
>>> [<000011388ab3b61c>] mlx5_cmd_exec_cb+0x25c/0x4f0 [mlx5_core]
>>> [<000011388b21e82e>] mlx5_vdpa_exec_async_cmds+0x22e/0x5e0 [mlx5_vdpa]
>>> [<000011388b21fd44>] create_direct_keys+0x954/0xef0 [mlx5_vdpa]
>>> [...]
>>> The buggy address is located 4128 bytes inside of
>>> allocated 4384-byte region [0000000176794000, 0000000176795120)
>>>
>>> So in essence we read 16 bytes beyond 4384-byte allocation.
>>> create_direct_keys calculates the pointer and length for in and out
>>> buffers.
>>> The size calculation for in includes the entire structure
>>> size (out + in + mtt[]) but the pointer passed to cmd_exec points only
>>> to the 'in' field, skipping the 'out' field.
>>>
>>> This causes mlx5_copy_to_msg() to read beyond the allocated buffer
>>> by sizeof(out) bytes when copying command data.
>>>
>>> Calculates the input size as sizeof(in) + mtt_array_size to match the
>>> pointer and allocation size.
>>>
>>> Fixes: 0071b138d44a ("vdpa/mlx5: Create direct MKEYs in parallel")
>>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>> ---
>>>    drivers/vdpa/mlx5/core/mr.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
>>> index 6d02ccf9eb91..03fe7f5ca412 100644
>>> --- a/drivers/vdpa/mlx5/core/mr.c
>>> +++ b/drivers/vdpa/mlx5/core/mr.c
>>> @@ -233,7 +233,7 @@ static int create_direct_keys(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *
>>>    		cmds[i].out = cmd_mem->out;
>>>    		cmds[i].outlen = sizeof(cmd_mem->out);
>>>    		cmds[i].in = cmd_mem->in;
>>> -		cmds[i].inlen = struct_size(cmd_mem, mtt, mttcount);
>>> +		cmds[i].inlen = sizeof(cmd_mem->in) + (mttcount * sizeof(cmd_mem->mtt[0]));
> Woops... Thanks for the catch. The fix is good.
> 
>>
>> Assuming the fix is the correct fix, question is, if I should use the offset of in instead, e.g.
>>
>> 		cmds[i].inlen = struct_size(cmd_mem, mtt, mttcount) - offsetof(cmd_mem, in);
>>
>> to handle potential alignment and padding aspects.
>>
> Seems harder to read. Why not:
> sizeof(cmd_mem->in) + flex_array_size(cmd_mem, mtts, mttcount) ?

Can do that. I assume we do not have any implicit holes in the structure due to alignment? In
other words, sizeof(cmd_mem->in) can never be something like 20 (and then the flex array would
start at 24 to align 8 byte elements). If thats the case I will respin with your proposal.
