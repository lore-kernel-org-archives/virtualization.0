Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8352AC433DF
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 14:19:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9055623121
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 14:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XxI//zNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9055623121
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 419B686E90;
	Thu,  6 Aug 2020 14:19:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CnKwDDvH6jFW; Thu,  6 Aug 2020 14:19:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C9C9186CE5;
	Thu,  6 Aug 2020 14:19:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B27CCC0051;
	Thu,  6 Aug 2020 14:19:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6192C004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 14:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D465486E7A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 14:19:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CslcW2hPE2t5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 14:19:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2E72186CE5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 14:19:39 +0000 (UTC)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 076E1ehi162143; Thu, 6 Aug 2020 10:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cSxQ8SGvCMLjMUkDt4NrKElp1fxGGbRAH4O/nOssxSI=;
 b=XxI//zNfUBcX3pIEyKFwC1wjdJ+TNO5rWewCpPu9PTOS9Dk/nwZNVdQuELBNYByMbDz7
 7MYvQ6WvVu0mQFyqfrC++jh3oS6HymKaz7pDFWfX3VdJj4fz3VlGX52WLEmVSeCiPeGr
 1HZiO6IVbDQ/St5UjGNmYvlHFSYVWucn91vZjzYadephhmTeGI3pc7MtYy+B/rttCgqN
 Rmy2d8PhgbVNUrGmwc3Gd1FHp0pcuWdL+YhltgrYarbG5EXgo3f6C8QKCs+W/wMEQzQQ
 NTyUfAOAcRntfkweiDmJrn4iV0GmVmgGISq+gBHvCY+O8RWloIYoXdhrH2wPV6zpDXV0 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32rg3ndurt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2020 10:19:31 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 076E1c3m162114;
 Thu, 6 Aug 2020 10:19:30 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32rg3nduqn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2020 10:19:30 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 076EH99O001140;
 Thu, 6 Aug 2020 14:19:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma06ams.nl.ibm.com with ESMTP id 32mynh5j4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2020 14:19:28 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 076EJPfV26607874
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Aug 2020 14:19:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5660A4053;
 Thu,  6 Aug 2020 14:19:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FE89A4051;
 Thu,  6 Aug 2020 14:19:24 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.149.70])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  6 Aug 2020 14:19:24 +0000 (GMT)
Subject: Re: [PATCH v7 2/2] s390: virtio: PV needs VIRTIO I/O device protection
From: Pierre Morel <pmorel@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <1594801869-13365-1-git-send-email-pmorel@linux.ibm.com>
 <1594801869-13365-3-git-send-email-pmorel@linux.ibm.com>
 <20200715054807-mutt-send-email-mst@kernel.org>
 <bc5e09ad-faaf-8b38-83e0-5f4a4b1daeb0@redhat.com>
 <20200715074917-mutt-send-email-mst@kernel.org>
 <e41d039c-5fe2-b9db-093b-c0dddcc2ad4f@linux.ibm.com>
Message-ID: <ef819e0e-85c3-0b14-4f8e-0d2a6c452355@linux.ibm.com>
Date: Thu, 6 Aug 2020 16:19:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e41d039c-5fe2-b9db-093b-c0dddcc2ad4f@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-06_09:2020-08-06,
 2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060096
Cc: gor@linux.ibm.com, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
 kvm@vger.kernel.org, thomas.lendacky@amd.com, hca@linux.ibm.com,
 cohuck@redhat.com, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, david@gibson.dropbear.id.au
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



On 2020-07-30 13:31, Pierre Morel wrote:
...snip...
>>>> What bothers me here is that arch code depends on virtio now.
>>>> It works even with a modular virtio when functions are inline,
>>>> but it seems fragile: e.g. it breaks virtio as an out of tree module,
>>>> since layout of struct virtio_device can change.
>>>
>>>
>>> The code was only called from virtio.c so it should be fine.
>>>
>>> And my understanding is that we don't need to care about the kABI issue
>>> during upstream development?
>>>
>>> Thanks
>>
>> No, but so far it has been convenient at least for me, for development,
>> to just be able to unload all of virtio and load a different version.
>>
>>
>>>
>>>>
>>>> I'm not sure what to do with this yet, will try to think about it
>>>> over the weekend. Thanks!

After reflection, I am not sure that this problem must be treated on the 
architecture level or inside the VIRTIO transport.
Consequently, I will propose another patch series based on CCW transport.
This also should be more convenient for core development.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
