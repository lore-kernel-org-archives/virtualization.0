Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CD34398EB
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698318; cv=none; b=e5G8UO7Y/fuC5Pm1uMABXGSzACvI4Ngl78LhJHbJVELHwUTayN2zyrkx0r4r4+Gmg0WHT/9WlnkCfGTTk+/CpLUGvQw6tXDtb1fBfUDgmAYs5VNox1EvjUE+JpCk4CqgNUZNX/a2mtgImxFpjn144n7lR3TGFA9EdQ2rZnqdiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698318; c=relaxed/simple;
	bh=E1Jda6QArnMGVqe7oW6Jmzt5H//hkddoKiSnnfahG7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJHSegQdJjgqKAVK+hnbeWL480/untfWuPdsbQgb2qfWvAYin/w3FdcfE0294nDb7sN2kmd2tCmaanrpcDO8dYn1VFce1a6+5SJbV0DnJB9rGqvKBWj5c7Ka5daV2+zeFPOtMJ7iEnoHMqrFFqkZ+eZHE+NmiFE3KW4kAgNl5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YHMRO0aw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YHMRO0aw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E81mM2586069;
	Fri, 14 Aug 2026 09:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1tJUmB
	We+QQscODT5sj/PcFcn6Qk1DIiutdRPcpig7o=; b=YHMRO0aweQk6aWcTgofQln
	yn8GCYd0fh9RMLIJ+5Ha15JpL52Z0gdqft1TQ9TU0d18egDRd4nCha2ZIXDxHgCj
	7k3jms3KwLzDeqXhicW9mScenOtgtWqRB8T2SdV3pFSnepWJW/3aa9Up+vCdMdBw
	xyl1GquFMP8gZEfHLgNiWDDTZBZOBpvS+WtnE/+2o8goBFEy5wyHfxTvGg69xlkF
	3mdC+0tcQeoNHcwWypcC01mpDVGK4HvjKnpIsZWDnNcxiGBLhdJak1DKOREpBajM
	pH+kTxWoDkM4WRHyCudiZ0tn4QDU6U47dEsXQ7gT/ugTuQumsgvlhKWX5y6D03aA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma43yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 09:04:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E8uJY9025822;
	Fri, 14 Aug 2026 09:04:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5werua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 09:04:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E94oVa50725180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 09:04:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E45CA2004B;
	Fri, 14 Aug 2026 09:04:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D420820040;
	Fri, 14 Aug 2026 09:04:48 +0000 (GMT)
Received: from [9.87.144.6] (unknown [9.87.144.6])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 09:04:48 +0000 (GMT)
Message-ID: <eab0e469-eccd-4664-9e7b-d3029ffee9c0@linux.ibm.com>
Date: Fri, 14 Aug 2026 11:04:48 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/12] sched/cputime: Add kcpustat_field_total helper
To: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, yury.norov@gmail.com,
        kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
        ynorov@nvidia.com
Cc: tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
        seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, maddy@linux.ibm.com,
        srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
        vineeth@bitbyteword.org, frederic@kernel.org, arighi@nvidia.com,
        pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org,
        tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
        rdunlap@infradead.org, kernellwp@gmail.com, linux-doc@vger.kernel.org,
        jgross@suse.com, virtualization@lists.linux.dev
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
 <20260812054033.95658-2-sshegde@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20260812054033.95658-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2OCBTYWx0ZWRfXwG6vZ+qadrz0
 2bcpGOLQPEESVGTagCfeqDrtQvS2hMrJwyzziIjGoQBC1nVJDA+Z4rDUyd8lk5YTKN0xL/Er1S/
 EH+QHz48xY4ejgM0Bg4gDKZxecgol5T2WX2EMIn4E2hk6Skc+CceSjLkTeQonOW+ZmUu8XroxlQ
 cv1q15vT/a+tQNbVJub7SeUSccvWX7iETsg2S11woBBZFaEXqww06N04eIitNRsCW6nckybeK7H
 2FUpM3mZtRmzHk/wqH0vtflXL6L2/tZ/AZZXtBlJDK6q8tvTdSrYkhKaqN0Jwr7BuvXMspM3DUF
 IiOVkX0R3vBR0arRnc69UYH+PU9uKKED9GdwEfhHKGham3wEaD9LYoz5GsLde/BEjyN3EdPIPgk
 ohXTiNtcvjXUO1aN7E/8C+tVjLBH5gmrIf/rJvScDDGn6OWh252FkQpSOMOqtRZfog4hWFZCUEj
 J+FSbQ8mN3Dun4FIJ4A==
X-Proofpoint-ORIG-GUID: YqgIVM1gHAo9m5HamkwJ_a0fut1hjExs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2OCBTYWx0ZWRfX9a8v8sLDhTy3
 8oL7Ldh7UA78/nQerBhaUetNqXOYGlYAaRFOv/RrZETvjI0MaSaXdB+lgvBUT9O/r/JBG4Y2rAK
 P3tSzfbCwww4CFfCXip1J5fKR/F53WA=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7eda37 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=hJ4HDH4UpsQMbZvwes0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6kOLak7p4B7TzFrmKbxWa8CTMxui5l3y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140068

On 12/08/2026 07:40, Shrikanth Hegde wrote:
> Provide a new helper function which sums up a given type of cpustat
> over a specified cpumask.
> 
> This allows the caller's code to be simpler and avoids duplication.
> For example, subsequent patch in the steal governor use this exact
> same pattern when calculating steal time.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
FWIW, feel free to add my r-b to this patch

Reviewed-by: Mete Durlu <meted@linux.ibm.com>
