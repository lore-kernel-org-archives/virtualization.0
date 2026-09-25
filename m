Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE48C402BA1
	for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329811; cv=none; b=F6Lq1Kb3fbFlGIZ+JNhsdFUnqJYg+uJXC7iSpm3IUJwCAFGk7q/HHAySN51iZWWbr/vXhmWf6pzaF8eYeYkicvcQbTDNlPyqHRhWbUpb1tmY82HkR5pmtkJadTAjxkyGS8XPfnHfSzLzger7a4LzAMVQMCTmVVTZyAhZM85RPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329811; c=relaxed/simple;
	bh=fq792iZnf1EX2HMh49l4ybkVGmrgVT0JRKhhjP1neTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOLNORxYCVL4D+D3pYwgOs9e5oJGT5sS8amFFUjgG2Q8a/HGbm/kSlW2BjAW/NU3uZI8mm0clvALfN3r3o+mrmunb3HSqU9ydF4yVpXtbFkblaxa9zgERpeBshsyyXRmwio92fUa8ZgbSexYQqDuQQdvpsnoDs6bloZTHodDDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M3vt2dXS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M3vt2dXS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4athd3084914;
	Fri, 25 Sep 2026 09:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RFjdSO
	0fRLrDwHiIbpDxY65cWE6AYquTLWo5HDV8bxI=; b=M3vt2dXSt4/eJcodlpeuWK
	YxA5/vvbVGAu89VMVBngNc17JkSzY0ZQg+KEMqN5JL6S3yPj2sF1SiAywPcrMU99
	4m2BvSKDT16jbJb+ZvYaJRsl4T3fkmg1u1bIZA9XK80Bh/tJ93B094hBVUEemCSj
	z/VNjortrFpsVUlfBf0r+8Az7Y0NTx9zf5MeX8usk3TYKDj8smf06d908c8D/LVw
	GNWzXDL+D+25dritaWUJdmBR+kg90gmH3BeMz2Q9bP12CfaETsOLyT/uVyLeTxnc
	94msbSghg5BqSnF8aC00OMIVa20No3IBjliTxbG69h0fv+r3S3FLYPzNL+nBJIWQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqwayb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 09:49:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P9m6aN3248950;
	Fri, 25 Sep 2026 09:49:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt31t97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 09:49:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P9nntA53412332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 09:49:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C5F22004B;
	Fri, 25 Sep 2026 09:49:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C18820040;
	Fri, 25 Sep 2026 09:49:41 +0000 (GMT)
Received: from [9.39.19.124] (unknown [9.39.19.124])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 09:49:40 +0000 (GMT)
Message-ID: <e152585c-aa6c-4e50-b427-7683e28f8584@linux.ibm.com>
Date: Fri, 25 Sep 2026 15:19:40 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/13] sched/debug: Add migration stats due to non
 preferred CPUs
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, yury.norov@gmail.com,
        kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
        meted@linux.ibm.com, ynorov@nvidia.com, tglx@kernel.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com, seanjc@google.com,
        vschneid@redhat.com, huschle@linux.ibm.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, maddy@linux.ibm.com, srikar@linux.ibm.com,
        hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
        frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
        christian.loehle@arm.com, tj@kernel.org, tommaso.cucinotta@gmail.com,
        maz@kernel.org, rafael@kernel.org, rdunlap@infradead.org,
        kernellwp@gmail.com, linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev, sunlightlinux@gmail.com
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-10-sshegde@linux.ibm.com>
 <20260925075134.GH4121339@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260925075134.GH4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab643c2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=SGBh-QMtgtaYjPv-_jIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzOCBTYWx0ZWRfX6WyNKe8/6vBv
 F5CIU4LJdWYyEi+vZNfiq6R19bOL3vfMw02pUJhi6Y1ES78IL3XbduN1So1BJh0CdS0FKRkflhv
 MbVD8d0hV6Pb8IoqP7LMd2QMbRzXS+F0rUdX05z2sKuPL4cZ8YDpBSAS56JzwGJCBdCfcTHeksT
 9MjLnYwjRdeu8b6MRvdjJeVvagyQ6JYA887Mv6JgK+iEkCbU9bj2qpB+KXIqgJnjOKCSnUpf02q
 mjGQkeiFmIq07Qv3qZq78uTOc/n3S7jfnwYKe66f9RjPraWXt+5wR04EvsWU27+YAuVRORO5FHK
 qaUBiz1+ETeEoZlBgLNLUdEKNFYmwGFNep5yhBffn1hQwEewsI7Ys2nwlB7ym88dz5FQ2NIOgtO
 pgVaIY0nXeiuqs9pN+lZ9+cHJTrxPmyuLcGv8T2Q09hWSjUtOfg/nf8QHIskqf7XvWy+QOF6+He
 Hb8Xn7A7LHBRFY1kqiA==
X-Proofpoint-ORIG-GUID: Il0JpxIQlFyfku8N6UHX21EUtSFreeG6
X-Proofpoint-GUID: PBmAX94aFTjtYRSCKyUhQfRtYKIS6xwH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzOCBTYWx0ZWRfX5tvDTXekGsLD
 plFqoIlXRD1p7WeZMj/YqM4h8Szwo9QscqlNC1jWoDDsdswjiI0QgrjD2wmajcDJPGutB7pn7Cg
 z/xbamXj/tvL40M23wTwFvHEOdC7w60=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250038

Hi Peter.

On 9/25/26 1:21 PM, Peter Zijlstra wrote:
> On Wed, Sep 09, 2026 at 07:26:13PM +0530, Shrikanth Hegde wrote:
>> Add a new stat,
>> - nr_migrations_cpu_non_preferred: number of migrations happened since
>>    a CPU was marked as non preferred due to high steal time.
> 
> My reading of the below code ends up with something like:
> 
>   - nr_migrations_cpu_non_preferred: number of push migrations while the
>     CPU is non-preferred.
> 
> Hmm?

Indeed. Will update the changelog.
