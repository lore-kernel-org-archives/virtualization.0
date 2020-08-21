Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D1BC433DF
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 13:07:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2236207BB
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 13:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rEWUNxN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2236207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7BBFC885F6;
	Fri, 21 Aug 2020 13:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HOSjw2AWgsk1; Fri, 21 Aug 2020 13:07:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CE44F885A3;
	Fri, 21 Aug 2020 13:07:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADA32C07FF;
	Fri, 21 Aug 2020 13:07:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98A8AC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8795D88605
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:07:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mL+9e+Pxe-Ii
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:07:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D9F75885E4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:07:15 +0000 (UTC)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07LD3cod085946; Fri, 21 Aug 2020 09:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rCX53BW9XWck10T5IMGv9OVxfYJ84h/kfh43uFw0aFQ=;
 b=rEWUNxN4NrA6aHediaUELPUNMJvgvQiDvTC6KTeQIJxnuOb6Va8ZFE0kC9/mhfm+KO1i
 nyNI81g3sdX2xXyVa9iBJG1dRGClBHzr3pGsKl5E57DRFGQWIVZJTsQjuK7CSsRlGuot
 NXh6VJJCbKVkmBpkx6TVffhpNBZ9r0Qp86f6mqW6wR893ZYxi9yfZzMD2L5zpSIsylxW
 GFDDdEwJw1HG7Zp3JB1+UnXdrhcB1vfX5mBseE0cGjctQaTXdQK2jiBKJNz99vPG6xRj
 Z3e0V6BPM6NMJML3mjFrC9i8VbEimpkRlpkUHtrnMOJkGUiKg9PtfJbYkJ4I8wP4iVoM RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 331yc8qbt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2020 09:07:07 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07LD4TUx089473;
 Fri, 21 Aug 2020 09:07:07 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 331yc8qbrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2020 09:07:07 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07LD59oq008635;
 Fri, 21 Aug 2020 13:07:04 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma05fra.de.ibm.com with ESMTP id 3304bujpcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2020 13:07:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 07LD5VHw459264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Aug 2020 13:05:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 845A9A404D;
 Fri, 21 Aug 2020 13:07:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAC77A4051;
 Fri, 21 Aug 2020 13:06:59 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.168.20])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 21 Aug 2020 13:06:59 +0000 (GMT)
Subject: Re: [PATCH v9 2/2] s390: virtio: PV needs VIRTIO I/O device protection
To: Cornelia Huck <cohuck@redhat.com>
References: <1597854198-2871-1-git-send-email-pmorel@linux.ibm.com>
 <1597854198-2871-3-git-send-email-pmorel@linux.ibm.com>
 <20200821140510.3849410c.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <19f742f8-8cc2-8f5a-90b0-c33e7b6a45b9@linux.ibm.com>
Date: Fri, 21 Aug 2020 15:06:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821140510.3849410c.cohuck@redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-21_06:2020-08-21,
 2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210115
Cc: gor@linux.ibm.com, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
 kvm@vger.kernel.org, mst@redhat.com, linuxram@us.ibm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, thomas.lendacky@amd.com,
 hca@linux.ibm.com, david@gibson.dropbear.id.au
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



On 2020-08-21 14:05, Cornelia Huck wrote:
> On Wed, 19 Aug 2020 18:23:18 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> If protected virtualization is active on s390, VIRTIO has retricted
> 
> s/retricted/only restricted/
> 
>> access to the guest memory.
>> Define CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS and export
>> arch_has_restricted_virtio_memory_access to advertize VIRTIO if that's
>> the case, preventing a host error on access attempt.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/Kconfig   |  1 +
>>   arch/s390/mm/init.c | 11 +++++++++++
>>   2 files changed, 12 insertions(+)
> 
> (...)
> 
>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>> index 6dc7c3b60ef6..8febd73ed6ca 100644
>> --- a/arch/s390/mm/init.c
>> +++ b/arch/s390/mm/init.c
>> @@ -45,6 +45,7 @@
>>   #include <asm/kasan.h>
>>   #include <asm/dma-mapping.h>
>>   #include <asm/uv.h>
>> +#include <linux/virtio_config.h>
> 
> I don't think you need this include anymore.

right,
> 
>>   
>>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>>   
> 
> (...)
> 
> With the nit fixed,
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks,

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
