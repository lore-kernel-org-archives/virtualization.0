Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A78AC433DF
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 13:08:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374FE207DA
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 13:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EMRP2UcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374FE207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0EC9886250;
	Fri, 21 Aug 2020 13:08:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id syS9dIrw5WiX; Fri, 21 Aug 2020 13:08:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2B29285F5A;
	Fri, 21 Aug 2020 13:08:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21215C07FF;
	Fri, 21 Aug 2020 13:08:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 174F4C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 064FA88605
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:08:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aAOH-aXyNy59
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:08:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DF31A885E4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:08:48 +0000 (UTC)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07LD3lYP105348; Fri, 21 Aug 2020 09:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XHpFRlBvLhzPbNUy/WcR7Iba8tVUXqJsA+kYx9ImcwQ=;
 b=EMRP2UcRsr3sZwUzXHOWWexcYGjU2w0YVHsaQkP68KAgzlTSDrRFQB5khT8JiiaQIrAS
 pEQwHETzP1EQvf2nmoNReYSShT4NJEjjD00afwBF7hv9e9SQ+NFxBT50uH0NZUnfD6E6
 5N0m8RJGkhESMM5KwK0nMsJlLJk8lSWCNC6/GhhCShzJlWIu4R8FdjIeHAYYSGx/GXRs
 KICBhHfeSx6Z1CklvxIMMbpCNo/yPbQD7yz6bGrWv8IWFPaV3xXYNGQYqQu64rlIbW4j
 EHMJqEL5sD3gC5RpSjTjpAt9BAQ3XJi95JcG5TToHEiyEbNwMbMGdb+IqKfOMtbBenZB sg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3328e9ay0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2020 09:08:44 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07LD40OG106366;
 Fri, 21 Aug 2020 09:08:43 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3328e9axxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2020 09:08:43 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07LD4U0d020685;
 Fri, 21 Aug 2020 13:08:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma03fra.de.ibm.com with ESMTP id 3304c92pmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2020 13:08:40 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 07LD8bGS61604294
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Aug 2020 13:08:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7057A405D;
 Fri, 21 Aug 2020 13:08:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BFC6A4055;
 Fri, 21 Aug 2020 13:08:37 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.168.20])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 21 Aug 2020 13:08:36 +0000 (GMT)
Subject: Re: [PATCH v9 1/2] virtio: let arch advertise guest's memory access
 restrictions
To: Cornelia Huck <cohuck@redhat.com>
References: <1597854198-2871-1-git-send-email-pmorel@linux.ibm.com>
 <1597854198-2871-2-git-send-email-pmorel@linux.ibm.com>
 <20200821135906.1c6bede3.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <91c83bba-9a75-4ed4-b682-fcdce26edd54@linux.ibm.com>
Date: Fri, 21 Aug 2020 15:08:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821135906.1c6bede3.cohuck@redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-21_08:2020-08-21,
 2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210120
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



On 2020-08-21 13:59, Cornelia Huck wrote:
> On Wed, 19 Aug 2020 18:23:17 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> An architecture may restrict host access to guest memory.
> 
> "e.g. IBM s390 Secure Execution or AMD SEV"
> 
> Just to make clearer what you are referring to?

yes, thanks

> 
>>
>> Provide a new Kconfig entry the architecture can select,
>> CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, when it provides
>> the arch_has_restricted_virtio_memory_access callback to advertise
> 
> s/advertise/advertise to/

OK

> 
>> VIRTIO common code when the architecture restricts memory access
>> from the host.
> 
> "The common code can then fail the probe for any device where
> VIRTIO_F_IOMMU_PLATFORM is required, but not set."
> 
> ?

Yes, better thanks

> 
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/virtio/Kconfig        |  6 ++++++
>>   drivers/virtio/virtio.c       | 15 +++++++++++++++
>>   include/linux/virtio_config.h |  9 +++++++++
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> index 5809e5f5b157..509f3b4d8ba1 100644
>> --- a/drivers/virtio/Kconfig
>> +++ b/drivers/virtio/Kconfig
>> @@ -6,6 +6,12 @@ config VIRTIO
>>   	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
>>   	  or CONFIG_S390_GUEST.
>>   
>> +config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>> +	bool
>> +	help
>> +	  This option is selected by any architecture enforcing
>> +	  VIRTIO_F_IOMMU_PLATFORM
> 
> "This option is selected if the architecture may need to enforce
> VIRTIO_F_IOMMU_PLATFORM."
> 
> ?

yes, better thanks

> 
>> +
>>   menuconfig VIRTIO_MENU
>>   	bool "Virtio drivers"
>>   	default y
> 
> (...)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

I will make the rewordings.

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
