Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DC2F39B5
	for <virtualization@lists.linux.dev>; Sat, 25 Jul 2026 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784946195; cv=none; b=NpKw3UQHCWQGu8Hog1Sl7ODi5gbT9Xkzn1xv2tijS7qqpPXKN2l2/ePaK+9heINf57Xe5Jy5Sxp2zNV2XTuCJYUfyjRHoDwjvbSL3gmtGNlGOQ59WeT5wXS73yNYsrZ59/GPZA+FZXkwUAdzYOwHahZajzKZ2zg5fdiAjiqHzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784946195; c=relaxed/simple;
	bh=Hw+ehIiuvGAbwAz02qkHgwMU/fI4sN/3iJejeVOYnZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyZvF3v6ha+qBWYGwXE+e6HZuvSUIRP56vH2EhLDLkW13VBy4mw778QpqccWVAeKn5Rw+DBL612JYJlir70Lr+fXf5PkV6IasEARnH+hOKwvvabIa8uZeu9U+jGDi4Ad9vJPL3Zje1uGSnuojfnrZ+uSDFN4hAZV9FpipcHXHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UF+or7Ne; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UF+or7Ne"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P1WYfI3358304;
	Sat, 25 Jul 2026 02:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XjWzYw
	k61j3ckT2KWld+PMdgTbLOTU573GeOdhIgVdk=; b=UF+or7Nek/8cK2al6oZeTN
	D/AaHZgnhVv3JT0njrif3/mEitF4jcPXrqgS/N2ApQ7zCQHWSn+PPsVkhc0X+lBq
	JEGxo6RxnXfITiyuusTdC8q/Pp7UqiTjMQ8PuEbTq7mnV3H+pek5Iu2nGLyhbVdl
	RP0k1ennOL7usZVRQmeImLrDmYW5cwXYqJpRaSVrDPrYv5amh/8LesLFySt5lR1D
	NvF/1h/So3UH8R8CJBKW251/amSY0f8aZn/vzK3eesyy6JMNUDZMSg0AcJPw6Xbs
	Ts7t3w5auNl3psDWuEhlvqctnHK3tvoORUF/8I3wQ12okS573U/fWiUoN+TyBHww
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmkje83ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 02:22:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66P2JsLb026217;
	Sat, 25 Jul 2026 02:22:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyu7tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 02:22:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66P2MhNE51118584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 02:22:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABB3020076;
	Sat, 25 Jul 2026 02:22:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72D7620075;
	Sat, 25 Jul 2026 02:22:25 +0000 (GMT)
Received: from [9.124.223.44] (unknown [9.124.223.44])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 02:22:25 +0000 (GMT)
Message-ID: <54af8965-f0bf-4424-8b41-609c914bafad@linux.ibm.com>
Date: Sat, 25 Jul 2026 07:52:24 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/11] sched/docs: Document cpu_preferred_mask and
 Preferred CPU concept
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
        corbet@lwn.net, tglx@kernel.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com,
        chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org,
        arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com,
        tj@kernel.org, tommaso.cucinotta@gmail.com, maz@kernel.org,
        rafael@kernel.org, rdunlap@infradead.org, kernellwp@gmail.com,
        linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev, kernel test robot <lkp@intel.com>
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
 <20260724140732.2683314-2-sshegde@linux.ibm.com> <amPc_DXDkeVawXS7@yury>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <amPc_DXDkeVawXS7@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YvY/gYYX c=1 sm=1 tr=0 ts=6a641df9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=nBlIldA4zcEpqykLzo8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AIJdXfv_nUVJfOVZ_mfFKd0e1RJzF9y3
X-Proofpoint-ORIG-GUID: 5wsWyJllVuMZ7X6qst_SPabYuM4vzMvh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDAxOCBTYWx0ZWRfX7B0w2t47ML/o
 QYoc1E+z0olsAXyVN0hfwsIYrBz9Mx+1go36Sg++WMbS3QQf052R7Kc/r3rcdse4tNRveevWoe+
 lgBEQES8ih80WoX2eovwkSZYcW4SMx/YdFI6ioiRdUE+ZLcSvj6Nibpi4SLdVQV2dwQnRmuLgjg
 2KqS/Ic2GVSw7IbdEKDfwJMixuUaiiHrNexmvhAvuWH8Wah5Ka/7vuGZDk9lQaNarqlDSnCBuDL
 ZjQpJmw9pyHvboWNu4sqXby0HknOesL4blRlagYRzMTXAbXQDXF8E4e5ZhMjtKA+G8t4odFNh8L
 mmxAmzbS59UPR3oivepX/nPcsF3p3fefcqk2Jp6DoPzB5WbD7VWiXa3SLCdu5RdzguiNDa2wOqp
 4vH66NH0GoYZuosgJpEd552BkG+X4FcUjrWoWrtFLLtUlfNW/3osjuIu5PF+6kn9vWcdpOXV4nA
 DHX171OFWrUaXEZRn+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDAxOCBTYWx0ZWRfX5wsu6PkS9VuL
 P9ss4sswESZlP65/BoOoCM3kBapM6XUMwqsqFOBvSqUKUh+wdh3aCdC6R913pPLwZvWNXVM48pB
 RNszhKz90qvORqsuxiEe1/EGbnX9HdE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250018

Hi Yury,

On 7/25/26 3:15 AM, Yury Norov wrote:
> On Fri, Jul 24, 2026 at 07:37:22PM +0530, Shrikanth Hegde wrote:
>> Add documentation for new cpumask called cpu_preferred_mask. This could
>> help users in understanding what this mask is and the concept behind it.
>>
>> Document how to enable it and implementation aspects of it.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202606180717.yNM0yb41-lkp@intel.com/
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   Documentation/scheduler/sched-arch.rst | 58 ++++++++++++++++++++++++++
> 
> And there's really nothing arch-specific in your series. Can you find
> a better place for the docs?
> 

You are right, it initially started as a arch specific RFC, now it is
completely generic.

completion.rst  sched-bwc.rst       sched-design-CFS.rst  sched-ext.rst          sched-stats.rst
index.rst       sched-capacity.rst  sched-domains.rst     sched-nice-design.rst  sched-util-clamp.rst
membarrier.rst  sched-deadline.rst  sched-eevdf.rst       sched-pelt.c           schedutil.rst
sched-arch.rst  sched-debug.rst     sched-energy.rst      sched-rt-group.rst     text_files.rst

I don't think any other file in there are a choice.
So, I guess I need to add a new one named sched-preferred-cpu.rst
