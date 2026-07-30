Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB183434E5C
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418017; cv=none; b=YETTQBNa83CzHOKziwDPPq2im9VV0UU07VN6OuwxPDUQcHQSzUUoMhspkAMCrznpNhDnGhuLZZwCnNeUZ2HmhOEYuXiKb7aWKEpj1lsuB8tqpV2Wg1XX4UNqbIZMG/XnOqzxXg/16LxlB8wqm4L12Q5fhWQ+h3Y4xDngLrAgApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418017; c=relaxed/simple;
	bh=MkgJagk0lqG9pqhxwgsWwBst8qzg0Js0R4D0qSlPnCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5fnqa8OniR923Umfbtev7DL0GfMFJr2eq2ffiXQoQ8EIPl328A4M53VFgBjEEJkhOiKSEhf6zySwyCo2arc/+egWNF6v+o3FnGI+xr0kGK5+jncMXvGZatJiwFk8z00cdC7pKXkolxuX0TLH9/34pgxpYJTmsM3VNqA5f5IRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IofsaFeb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IofsaFeb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDIbBd3023316;
	Thu, 30 Jul 2026 13:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jurk0j
	HsrA9x6gbe0RHvpqQrLRF5ebl/9BCJOBQFfIQ=; b=IofsaFebqPv2X73mpZuMUA
	wC6a/hTdsYVw+E0WOMXvKwHVMbP9MBKMHDaGaRYbxfU/SMXiV1J3cCDfDV0CHBOl
	VBf+hNxiLT2tuZU3XiwE57v1hGfpofKklCic35+uuiXnvC0SqZ1k/A947udp+kfK
	8VQzXAsOACQ87tgfv4QI2Zuo/6xcB2QwsGVIs9Lc+tFk+qXokt8SaVeFdeNyIQNm
	Y5pNCBE+4oYYsvR/B02OuwAEPE0sNO1ZRoi8cqhO/qHmamjJTzs+M2+Y7BHLf/oa
	cFC+W574OQUqZACqKlER5VT7Nj7dFg1Cd3s84/lufIDuY7x+AAVvDLlLOZn+WBpA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ny16b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:26:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UDQFYZ022852;
	Thu, 30 Jul 2026 13:26:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwbmay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:26:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UDQpPd32702932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 13:26:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 706AC20043;
	Thu, 30 Jul 2026 13:26:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4774220040;
	Thu, 30 Jul 2026 13:26:51 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 13:26:51 +0000 (GMT)
Message-ID: <de0fcb62-f049-4c0d-a686-e0501c07cf09@linux.ibm.com>
Date: Thu, 30 Jul 2026 15:26:51 +0200
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
 <3508dbb8-d110-42dc-aa25-4b3e73057422@linux.ibm.com>
 <9f799ce2-f84c-4224-b91d-464dc767eb00@linux.ibm.com>
 <21e944c6-2039-4e34-a2f9-711ea4769294@nvidia.com>
 <be143bcb-8d26-4576-a5b4-278a2905e6d7@nvidia.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <be143bcb-8d26-4576-a5b4-278a2905e6d7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMSBTYWx0ZWRfX1+KngBAK+4j9
 kmQ8wKu1NpKPPx/x9j8MTO9mB0rFauZLYMSYoek4njdTuKgazG49AGue8o2AotZAe2mKKlZhQkI
 aeTElhA/Gvoei5HtCijRD5uFe5ZgRFc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMSBTYWx0ZWRfXxFKrDsKRaM35
 3W7JNn9cltWfptUPywtCJAUwqYyoEiowVp+J0CQeaayAV5KV2TRA689EjTF+jVw986FwR934kHO
 ejVcgVKDG6ORfaUGVVfkhQOniTDY0tUYz1D1o7lUIzBm896rVRy+9cqPpP6TG/bb5zAKOaDNzwn
 oVlzKLQrAzoS4qKWzEMtpwOC3NcNT/nCElV+je6qVepmgdHC3NqMHn7uaWGsROwfeFXzZYwkmtT
 GQRrVlqV5QThCDzP/mMtAWZ8ohwlnuq3inmG2ND/gnK2dnsvoGPvtmwAViZMONiz3Of4+IVmr0p
 IgZx8zOPdHgkYdCYmrh5OArzqQLTEdh3fABgOFq0aJc64RVNlepETsY5+TTjS5Evsizl+oK34qD
 6YS6xQlXrXbNTFkAF7ixD8RmL9bsbC2p4LwMSeAOVXT8QVHfQG9TXhHb1IiG8QgibCg5ZjOd+ZE
 jdcEihxP+CV+3qSR+kQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6b511e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Ikd4Dj_1AAAA:8 a=A0XsCsmqdwQqc1docJ8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gWpMJwxF0Mft-80OZ0V9rdontgPCn25I
X-Proofpoint-ORIG-GUID: gWpMJwxF0Mft-80OZ0V9rdontgPCn25I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300101

Am 10.07.26 um 13:37 schrieb Dragos Tatulea:
> 
> 
> On 10.07.26 10:23, Dragos Tatulea wrote:
>>
>>
>> On 10.07.26 09:18, Christian Borntraeger wrote:
>>> Am 07.07.26 um 09:17 schrieb Christian Borntraeger:
>>>> Am 06.07.26 um 16:15 schrieb Christian Borntraeger:
>>>>> We have seen in our CI the following KASAN message:
>>>>> BUG: KASAN: slab-out-of-bounds in cmd_exec+0x550/0xca0 [mlx5_core]
>>>>> Read of size 272 at addr 0000000176795020 by task qemu-system-s39/82764
>>>>> [...]
>>>>> [<000011388ab3a7a0>] cmd_exec+0x550/0xca0 [mlx5_core]
>>>>> [<000011388ab3b61c>] mlx5_cmd_exec_cb+0x25c/0x4f0 [mlx5_core]
>>>>> [<000011388b21e82e>] mlx5_vdpa_exec_async_cmds+0x22e/0x5e0 [mlx5_vdpa]
>>>>> [<000011388b21fd44>] create_direct_keys+0x954/0xef0 [mlx5_vdpa]
>>>>> [...]
>>>>> The buggy address is located 4128 bytes inside of
>>>>> allocated 4384-byte region [0000000176794000, 0000000176795120)
>>>>>
>>>>> So in essence we read 16 bytes beyond 4384-byte allocation.
>>>>> create_direct_keys calculates the pointer and length for in and out
>>>>> buffers.
>>>>> The size calculation for in includes the entire structure
>>>>> size (out + in + mtt[]) but the pointer passed to cmd_exec points only
>>>>> to the 'in' field, skipping the 'out' field.
>>>>>
>>>>> This causes mlx5_copy_to_msg() to read beyond the allocated buffer
>>>>> by sizeof(out) bytes when copying command data.
>>>>>
>>>>> Properly calculate the input size to match the pointer and allocation size.
>>>>>
>>>>> Fixes: 0071b138d44a ("vdpa/mlx5: Create direct MKEYs in parallel")
>>>>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>>>
>>>>
>>>> Dragos,
>>>>
>>>> With this fix our nighly CI did not result in a kasan message. As I only have
>>>> limited test coverage a full regression on your side might still be the right
>>>> thing to do.
>>>
>>> Any feedback?
>>>
>> Sorry, got carried away with other stuff. Yes, I will check it on our side.
>>
>> Until then:
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>>
> I was able to reproduce the issue with KASAN during our live migration tests.
> With this patch the issue is gone. Thanks for the fix!
> Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
Ping. I cannot find this in next.
