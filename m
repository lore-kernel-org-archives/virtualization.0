Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C46390C8D
	for <virtualization@lists.linux.dev>; Fri, 10 Jul 2026 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667938; cv=none; b=ZQdPkBWWTMtYy6EOuyGb4cWki3man3dqP8Q83/ug6au6BfKt91IIbNVYuRS7apVrrIAyUT9Qg2+2XFCf8GZ1piUxzJhKTgOpe4qKlFohMgA0vlqdR29hRqtqbiS2gyma7CCxTshxxRtXIj34H4JUgUAeiWZfrQe5ANFAyzQc2Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667938; c=relaxed/simple;
	bh=YHV3kQEIRdQVDg73FlHy8b2HtJqswaIlAt/D++YdsL0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Tq5dZlP56vE4sTbJuqv3Jwk9omB9irvMwpwTZVgTgSM+SIljIufPYT/GBJ04o6vk5pdf8RIFccxf/npMb3OZz9/ISsZb/Aqk2lUnb77fgfNzVhEYcGF/5zOkqSTZlxO/OhuRq94sKKhyuwEYY9betTNKQ8G4Ie+RoYTWie+oILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OAUR0noA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OAUR0noA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3nC6J3492618;
	Fri, 10 Jul 2026 07:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IL6ENB
	1XIbPK0Qh/1szWlzu4iHQKbWE8pnYWrfPRmA0=; b=OAUR0noArP8HMiLk70z0dt
	4VYHMNU0e9NmXRgk5Fltdh5CyPRTI0dJW3qL1OQrHdmLJccz8VRkmMYKhT2hs/W4
	WqnIyUd3eGO4Fpt2AP1Gssprm7gEGXJ73B0fdcs8c7cyDYJoOz0wTYSZCFFhkwl7
	PAPnM7r4BHeTINTH2cZkPoc+twQCoKu1EuxC2sVIKosK2DP5jp28a6r2qSzJMJwB
	ya5Jdfxegp83zINs7z+4g2ZBYwo7lHLqG5qbTSfjBQNFI+PH88m0rNanS9jHH6vF
	8v7EjTOTpyXl4ZJrFX3I9iZC4DdlvoJYD7dDgXplRY7gfe8Y8wD1T139Ef5R736g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke5rdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 07:18:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A74nix009439;
	Fri, 10 Jul 2026 07:18:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqggp67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 07:18:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A7Iq8H24969542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 07:18:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8A512004D;
	Fri, 10 Jul 2026 07:18:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCAEE20040;
	Fri, 10 Jul 2026 07:18:52 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 07:18:52 +0000 (GMT)
Message-ID: <9f799ce2-f84c-4224-b91d-464dc767eb00@linux.ibm.com>
Date: Fri, 10 Jul 2026 09:18:52 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vdpa/mlx5: Fix buffer length in create_direct_keys()
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260706141537.3510294-1-borntraeger@linux.ibm.com>
 <3508dbb8-d110-42dc-aa25-4b3e73057422@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <3508dbb8-d110-42dc-aa25-4b3e73057422@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a509cdf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=BY-eHWddwsCeY9jSyhgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2OSBTYWx0ZWRfX4yMXQQ74TaTm
 EDJ9SXSaVs2p+cgHmMj7xOlmqHDE/OjPOB1hFsAMOenL1i/WRGwq2LgJk0+SbERUo9W/E+kY4+I
 TDOXddMKCrvsq3JXw6poHxXcnuGPDFFyWn0ZbONOxU4suBz9Of0GXoN6XyFpMuDBqVzBS/f592P
 JH8fWZJycolDchObfIQHqPRGlLkXVLxumU90prTS8wUHn59R118V+bwO46fcbZlHF7j4nXdCOFc
 13Ad+L9M/4RVuATARDLx1Ue1g/1FCH90feq/RYCKidLLnKONGRTjOhEPpOqWSZUBSG2P3qbz1I0
 bXdWdC0kkejCa9Fn48XrBRqpQNyD6cWlrsvH88cq2KF+oc/FK+N0GsdG+OzZKvvmv0rvETIqR4W
 YfSJeoWFpkKry69y5mOwDX20QqKvpY++oVFjadpHBmagCgsZFVYYlKRASGzoBDAvkC4hXyLC1oB
 0zHLGNG4QMtnJ6RaGSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2OSBTYWx0ZWRfX8ulnab4LGyxm
 sLxjAEhKXR3QaAABbwRwR24EsDGSCj2nSeLu6SVP1cfZd8ATVuo65CG4za5T8pBVeZi9DtJI62B
 VEbRNIYa5SMyUK/aCnxjFZDdPTti9Xo=
X-Proofpoint-GUID: MF7s_xrwl8ARvqUo2_GlilKF8LdCEZLv
X-Proofpoint-ORIG-GUID: MF7s_xrwl8ARvqUo2_GlilKF8LdCEZLv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100069

Am 07.07.26 um 09:17 schrieb Christian Borntraeger:
> Am 06.07.26 um 16:15 schrieb Christian Borntraeger:
>> We have seen in our CI the following KASAN message:
>> BUG: KASAN: slab-out-of-bounds in cmd_exec+0x550/0xca0 [mlx5_core]
>> Read of size 272 at addr 0000000176795020 by task qemu-system-s39/82764
>> [...]
>> [<000011388ab3a7a0>] cmd_exec+0x550/0xca0 [mlx5_core]
>> [<000011388ab3b61c>] mlx5_cmd_exec_cb+0x25c/0x4f0 [mlx5_core]
>> [<000011388b21e82e>] mlx5_vdpa_exec_async_cmds+0x22e/0x5e0 [mlx5_vdpa]
>> [<000011388b21fd44>] create_direct_keys+0x954/0xef0 [mlx5_vdpa]
>> [...]
>> The buggy address is located 4128 bytes inside of
>> allocated 4384-byte region [0000000176794000, 0000000176795120)
>>
>> So in essence we read 16 bytes beyond 4384-byte allocation.
>> create_direct_keys calculates the pointer and length for in and out
>> buffers.
>> The size calculation for in includes the entire structure
>> size (out + in + mtt[]) but the pointer passed to cmd_exec points only
>> to the 'in' field, skipping the 'out' field.
>>
>> This causes mlx5_copy_to_msg() to read beyond the allocated buffer
>> by sizeof(out) bytes when copying command data.
>>
>> Properly calculate the input size to match the pointer and allocation size.
>>
>> Fixes: 0071b138d44a ("vdpa/mlx5: Create direct MKEYs in parallel")
>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> 
> Dragos,
> 
> With this fix our nighly CI did not result in a kasan message. As I only have
> limited test coverage a full regression on your side might still be the right
> thing to do.

Any feedback? 

