Return-Path: <SRS0=Ra46=BR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CEBC433E1
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 14:26:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C05B20866
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 14:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gr1HUEKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C05B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2A5B824BDF;
	Fri,  7 Aug 2020 14:26:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K5gc2gnA6bTB; Fri,  7 Aug 2020 14:26:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AF68D203A2;
	Fri,  7 Aug 2020 14:26:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 812C4C0050;
	Fri,  7 Aug 2020 14:26:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3C5CC004C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 14:26:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DB52A8737B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 14:26:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1m2Ba92B8NXk
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 14:26:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4D66B8729E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 14:26:07 +0000 (UTC)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 077E2T5P039928; Fri, 7 Aug 2020 10:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=12G63m6nNUgCxJtOgPkzXIunifSEIVC0Gdm1Kr5ju1s=;
 b=gr1HUEKms1mv9AqL8ggWBTQ58s6WG7idRLg+G/5EbIth69Vzb1RwDBvx7GuBVAvIAc2e
 jyrbQs+u23QTMTB+B9TmkEB82i89neQl2WmuvneCBAM0oj3S2bVoj7Js4P4HevHYaEzG
 /2/k6PU1irClBB47uqMWftd5uG63SjV4BGaunLzN9U6YvY1PcZ56UeMzlWXneEqLk9FP
 NlbovIg0e/R1hSDtymap1SjMxOWMzlq9TXpaQ38yOELsJPbj2xD1Wo/yQe+2O7bm3iua
 9zPo2X2wBvNs8qvF74Hl1WF26G21yLm4qDFAmrU6eXnTGmWY1XYi8cCNyOwoQJ3+0PSr BA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32rjd9xnkx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2020 10:26:06 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 077E2iMk041530;
 Fri, 7 Aug 2020 10:26:05 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32rjd9xnjv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2020 10:26:05 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 077EPlOT020463;
 Fri, 7 Aug 2020 14:26:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma02fra.de.ibm.com with ESMTP id 32n018c4tg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2020 14:26:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 077EPxl326214762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Aug 2020 14:26:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD1AE42042;
 Fri,  7 Aug 2020 14:25:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51C974203F;
 Fri,  7 Aug 2020 14:25:59 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.47.252])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  7 Aug 2020 14:25:59 +0000 (GMT)
Subject: Re: [PATCH v1 0/1] s390: virtio-ccw: PV needs VIRTIO I/O device
 protection
To: Cornelia Huck <cohuck@redhat.com>
References: <1596723782-12798-1-git-send-email-pmorel@linux.ibm.com>
 <20200806174744.595b9c8c.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <7a79725f-14d9-5b1a-f0e0-77c3ce596420@linux.ibm.com>
Date: Fri, 7 Aug 2020 16:25:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806174744.595b9c8c.cohuck@redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-07_09:2020-08-06,
 2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070097
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, kvm@vger.kernel.org,
 mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com
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



On 2020-08-06 17:47, Cornelia Huck wrote:
> On Thu,  6 Aug 2020 16:23:01 +0200
...
> This does work, and I'm tempted to queue this patch, but I'm wondering
> whether we need to give up on a cross-architecture solution already
> (especially keeping in mind that ccw is the only transport that is
> really architecture-specific).
> 
> I know that we've gone through a few rounds already, and I'm not sure
> whether we've been there already, but:
> 
> Could virtio_finalize_features() call an optional
> arch_has_restricted_memory_access() function and do the enforcing of
> IOMMU_PLATFORM? That would catch all transports, and things should work
> once an architecture opts in. That direction also shouldn't be a
> problem if virtio is a module.

Yes thanks, I rework it in this direction.


-- 
Pierre Morel
IBM Lab Boeblingen
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
