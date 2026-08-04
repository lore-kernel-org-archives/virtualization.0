Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34053859DF
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856994; cv=none; b=DaZHHIx6Uuc/dUhEFm9i6u4WBxfpf1xJ/P0d2XNzanx50ELC3PScAAkvTbYUmaVYZV3xBh8IUn3ZA6spl2SFMJb7MeZCYELFFQb/suXcZetB24kVa+PPBxoUmS8RJ4wNYn1qVhbrHBqooZ8Xnuhq3ePKW8kfjyQcGYenpicpzF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856994; c=relaxed/simple;
	bh=L8H4U84pYooHtui+eEbaWcXPEFOW63dD+WAE3edmCHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHNfkKAkT012I+CBkMNQteFWg1Pm9EtPBuSp8BlVk/W/vfvhSQ1rODkRo5tFviFbpxBRy+TNSCQSjjjFTqy6GlRaNwhCZSr2DfYTDnaCUK9JELIiI6TwGp923knCIjCzabY0dei2bvTPCJ7R4aCF8URjogR0CydMZhDQ3SwCmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JSfeY9yx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JSfeY9yx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Cphr3808854;
	Tue, 4 Aug 2026 15:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ih6EP7
	FYRj1PZW39WtunmPeNKTVTdI4VAofblg0Uh8A=; b=JSfeY9yxpHF8jeX5h+qVKg
	qnO+pOpph3cjmWU46pE/CpfqpuAY8yiiHaa00eOUaxP/CuXixfZDPPGns0nrTG8n
	7QFrDnJE8QBUqY/HbLWjrE6OM71AiWi0PjoPpWFntj5ncLx2X3TxSN4IQ7MjEhVV
	atc9s8zyjGdXhkl8qQnGyW0MIvVuKJhWMCm5Ab0cJTa2DFQth2JrP5k9GKIV3+KQ
	6dNlu5FBHOsYQyQbrmp7sDO0eI8R3Yfdfpo02BgzDbDHPCJkRWbjDZ/J9Dyb42m+
	IfiAd7PtlIovIWqR1LwgmRnCKoxxJK7ptZKlZ+5UI4gxUphw9GMMjrn+aztzldAg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hpcmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 15:22:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674FBMF8000918;
	Tue, 4 Aug 2026 15:22:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qjn9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 15:22:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674FMpPR52363744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 15:22:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C902E2004B;
	Tue,  4 Aug 2026 15:22:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B69C20043;
	Tue,  4 Aug 2026 15:22:41 +0000 (GMT)
Received: from [9.39.27.209] (unknown [9.39.27.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 15:22:41 +0000 (GMT)
Message-ID: <0609e5d5-1772-4a44-8cac-eef768e7eba2@linux.ibm.com>
Date: Tue, 4 Aug 2026 20:52:40 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/11] sched/docs: Document cpu_preferred_mask and
 Preferred CPU concept
To: Yury Norov <ynorov@nvidia.com>, linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, yury.norov@gmail.com,
        kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
        tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
        seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, maddy@linux.ibm.com,
        srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
        vineeth@bitbyteword.org, frederic@kernel.org, arighi@nvidia.com,
        pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org,
        tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
        rdunlap@infradead.org, kernellwp@gmail.com, linux-doc@vger.kernel.org,
        jgross@suse.com, virtualization@lists.linux.dev,
        kernel test robot <lkp@intel.com>
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
 <20260724140732.2683314-2-sshegde@linux.ibm.com> <amPc_DXDkeVawXS7@yury>
 <54af8965-f0bf-4424-8b41-609c914bafad@linux.ibm.com> <amrbXSiJOBbGojhK@yury>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <amrbXSiJOBbGojhK@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEyMyBTYWx0ZWRfX/S0gjORK2dio
 8Uo03AXbSImI1UbZxgpBEgu7PtE6zjpWygQN00WFDLJiUW0gw3SUqsNCW8vqBuo4V/uGb7uvrsJ
 bDQp05vZRIgDSMZNh24Kj9gBnxcVivY=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a7203d1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=Oz8tNqjb8Ns73ZrLlg8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEyMyBTYWx0ZWRfX30FAOpFGRimA
 6WnVNbzYsXXCzlhXb6Bzs5ZHxeNZ1eefkijwYYqa3tyfx3fGNZ2CXfKIYMrgRNFKvezKxBjIdnp
 SI/xrtOKAETGWXzF5h1FPvTddZuQnJHUCvdteGcdLTKHLmcQTGT5z4v+c06H+xMihkBZTL9ncEI
 uW+hvDpAPrPNwVBABQlwru6aa9kaxJDvtdiqbHrLQMoOws6a6lPN2cEEtKfaFhNKltsyLANajtG
 qDlBHAQ7DEgVDBKDrUOXfH/tyFatB0tgNKyxp2DsQtV1gRt5WZExjnI1GtKMbIMSdcoVhHqCsGm
 nO/WKWelS03szCXy9eOWw6rzftpGv5T2+oHzpbI1+HpXl49CxZ0hNopzDuqyDu2KlXp3bmcnhwN
 Zh12Ub4wKzX7cbKV9BPpLG+1hei/T6afD8WA8S4QpaxzktnJaj8BHHzmfklsBeS3Bu5+Ngzk5yZ
 Of8ivII/gSpQwg6aeFQ==
X-Proofpoint-ORIG-GUID: Y6cfh8hpweMfRvEXnIxmJkrXjlF8rm0L
X-Proofpoint-GUID: IhpjpYwj-p43ol6AAliDjKy1jL_PEAu4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040123

Hi Yury,

On 7/30/26 10:34 AM, Yury Norov wrote:
> On Sat, Jul 25, 2026 at 07:52:24AM +0530, Shrikanth Hegde wrote:

>> I don't think any other file in there are a choice.
>> So, I guess I need to add a new one named sched-preferred-cpu.rst
> 
> Maybe sched-paravirt.rst?

Ok. Will add a new one.


======================================================
To Everyone,

I am still waiting for the system to run numbers on next version that i have.
Performance is expected to be same as v9 apart from system to system variations,
but i still want to run it once before sending it.

Changes prepared as of now for next version. If there are any other review comments
meanwhile, please let me know.

PATCH 1:
   - Move the documentation bits into Documentation/scheduler/sched-paravirt.rst
   (New file instead of adding to sched-arch.rst)

PATCH 5:
   - Remove cpu_preferred check in _nohz_idle_balance
   This would naturally allow nohz.next_balance to happen
   as should_we_balance fails and load balance bails out
   on non-preferred CPUs and time gets updated.
            
PATCH 5:
   - Add cpu_preferred check in find_new_ilb to select an preferred
   idle CPU for idle load balancing.
   This may need to be rebased if andrea's patch lands upstream
   before my next version.
   https://lore.kernel.org/all/20260731191957.3199642-1-arighi@nvidia.com/

PATCH 8:
   - Add details about thresholds limitations.
   - Minor documentation nits.

NEW PREP PATCH:
   - Introduce kcpustat_field_total to sum up kcpustat for specified type over
   set of cpus. That will likely becomes first patch in next version.
   https://lore.kernel.org/all/d3533cdb-d32a-4d75-84d5-a2908ecc7bfa@linux.ibm.com/

PATCH 10:
   - Rename compute_preferred_cpus_work to steal_governor_loop
   - Mention in the changelog and documentation that default thresholds it won't work in
     all cases and user might have to change them based on the system under test.
   - Always do the design checks. That will avoid any driver related design
     checks into core code. All the core code needs to take care is w.r.t to hotplug
     that preferred is set after active and reset before active. Add this specific case
     details in changelog why design checks are done always.
   - Add changelog/doc on how the it safely handles half-offlined core.

Assumed as concluded and not changing for next version:
- returning void in sched_non_preferred_cpu_push_stop is out of the scope of this series.
- Using possible CPUs for computing steal ratio.
- fs/proc/stat.c and drivers/leds/trigger/ledtrig-activity.c etc not using kcpustat_field_total.

