Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F18C32771
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 15:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E95982A72;
	Mon, 26 Sep 2022 15:49:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E95982A72
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k/yBCckO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P5tTGswQwCsR; Mon, 26 Sep 2022 15:49:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 84A3982CB7;
	Mon, 26 Sep 2022 15:49:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84A3982CB7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57464C0033;
	Mon, 26 Sep 2022 15:49:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C616C0033
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 15:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7297B41710
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 15:49:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7297B41710
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com
 header.a=rsa-sha256 header.s=pp1 header.b=k/yBCckO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8RO2b-oh9KCZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 15:49:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F1E841797
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F1E841797
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 15:49:40 +0000 (UTC)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QEU2s4004827;
 Mon, 26 Sep 2022 15:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BAAkQPJUniW6I4A73h7YeiR4tAVwoqmwhjv/IGoOmHI=;
 b=k/yBCckOBvx1iMXNsL71sJv9WNl9LC1BBxlU9w0v8VL+WVh68sPA+UkcDTGRhJP1srry
 3jNDpHNsYYjJbqZObEkfusJ8DY/evuTplAEpO2SIVeHfE4YMVAHb68Fj8Tw7Qgz1geos
 XJcycuKWhhWmJga2Himc6/5vyjBp4oUlBxCQa1hADDHEaBRco7ScIPCBP5PlDqRzRSyu
 HiwRgQ5EOsEcA8/TQqNKQVL/s3UgOvpw2JRYq6a9uZR+k2skQDxYwmFFQorDbhDn0luR
 pT1x388j725TtHpnAR/r4u4y06ck1pvawMlBdayNgDJfz88okpAMpWMWd6PjqMyfCXRE Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jucjrdr4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Sep 2022 15:49:23 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28QDKJQY013322;
 Mon, 26 Sep 2022 15:49:22 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jucjrdr45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Sep 2022 15:49:22 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28QFbYVA032301;
 Mon, 26 Sep 2022 15:49:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03fra.de.ibm.com with ESMTP id 3jssh91y62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Sep 2022 15:49:20 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 28QFnHNA3998348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Sep 2022 15:49:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBC51A405B;
 Mon, 26 Sep 2022 15:49:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E9E7A4054;
 Mon, 26 Sep 2022 15:49:17 +0000 (GMT)
Received: from [9.171.20.172] (unknown [9.171.20.172])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 26 Sep 2022 15:49:17 +0000 (GMT)
Message-ID: <9ec643f3-b935-0119-d8bc-1fbe46c36356@linux.ibm.com>
Date: Mon, 26 Sep 2022 17:49:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
References: <20220822114649.055452969@infradead.org>
 <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
 <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
 <YzGhUZJKV3pKJL3Z@hirez.programming.kicks-ass.net>
 <66463973-923f-624d-3041-72ce76147b3e@linux.ibm.com>
 <YzGrJSLXpocpGIha@hirez.programming.kicks-ass.net>
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <YzGrJSLXpocpGIha@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5DtpxKxPO8IHNBcG607UyFF58T5jGATs
X-Proofpoint-ORIG-GUID: Jvxbn7w7La4_KTQpSuYLex2PibWJ-dfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260098
Cc: vincent.guittot@linaro.org, linux-pm@vger.kernel.org, bigeasy@linutronix.de,
 Amit Shah <amit@kernel.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mingo@kernel.org, Marc Hartmayer <mhartmay@linux.ibm.com>,
 mgorman@suse.de, oleg@redhat.com, tj@kernel.org,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, will@kernel.org,
 dietmar.eggemann@arm.com, ebiederm@xmission.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



Am 26.09.22 um 15:37 schrieb Peter Zijlstra:
> On Mon, Sep 26, 2022 at 03:23:10PM +0200, Christian Borntraeger wrote:
>> Am 26.09.22 um 14:55 schrieb Peter Zijlstra:
>>
>>> Could you please test with something like the below on? I can boot that
>>> with KVM, but obviously I didn't suffer any weirdness to begin with :/
>>>
>>> ---
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 4e6a6417211f..ef9ccfc3a8c0 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -4051,6 +4051,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>>>    	unsigned long flags;
>>>    	int cpu, success = 0;
>>> +	WARN_ON_ONCE(state & TASK_FREEZABLE);
>>> +
>>>    	preempt_disable();
>>>    	if (p == current) {
>>>    		/*
>>
>> Does not seem to trigger.
> 
> Moo -- quite the puzzle this :/ I'll go stare at it more then.

Hmm,

#define ___wait_is_interruptible(state)                                         \
         (!__builtin_constant_p(state) ||                                        \
                 state == TASK_INTERRUPTIBLE || state == TASK_KILLABLE)          \

That would not trigger when state is also TASK_FREEZABLE, no?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
