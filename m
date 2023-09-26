Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E25E7E653
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 16:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 841FB8249E;
	Tue, 26 Sep 2023 16:42:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 841FB8249E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GDx9YKE6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Znth54d2Xa-i; Tue, 26 Sep 2023 16:42:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0CC2882470;
	Tue, 26 Sep 2023 16:42:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CC2882470
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB5D1C0039;
	Tue, 26 Sep 2023 16:42:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6CA7C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 16:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A7D240487
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 16:42:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A7D240487
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com
 header.a=rsa-sha256 header.s=pp1 header.b=GDx9YKE6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yrZIINfX3BzI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 16:42:29 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30DAA40383
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 16:42:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30DAA40383
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QGfhLV026269; Tue, 26 Sep 2023 16:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ltcBCLRpeo5Qm/iG36QikwBKiii+yn5bF1s2VHUvFMM=;
 b=GDx9YKE6/y0+joAQJGAFIuBqJbDBj5rFj6MOsuvtHbVrRlSs+NffCJxdYtEgKs5urx/W
 uCnjLcSWXhPNEYGRS8YymcaggsDs0wU3g5TX60JqCN61aOhg5CdcCz1MzEq96eEkFkdw
 s1LdI5pt/ybe/Tw9Sva6dCJ2gzbuWTl+MfYopvgPGwthaaHOg9C+eyCVYtilQVBaS64s
 CBDtTl0CQx4M/lUei68uxtTKzBWTNlwbZVNyxdjjvGQFIcpJp5tTteBdZvr4dgisBfVT
 4LPumhFr6aXsJ73qF8P+xvyh3feTKYbn/qphQmcriqkjhP0E7FebbRFZjRgomE1ZMPJk Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tc31y00c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 16:42:06 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QGfjFZ026375;
 Tue, 26 Sep 2023 16:42:05 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tc31y00bg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 16:42:05 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QFVYV8008456; Tue, 26 Sep 2023 16:42:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabsn85h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 16:42:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38QGg1kE15270400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 16:42:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A1EB20043;
 Tue, 26 Sep 2023 16:42:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B52220040;
 Tue, 26 Sep 2023 16:42:01 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown
 [9.152.224.212])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Sep 2023 16:42:00 +0000 (GMT)
Date: Tue, 26 Sep 2023 18:41:58 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Message-ID: <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
In-Reply-To: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o5Qnfs9z3yvYmj8Y5r21YF414SvYoNHs
X-Proofpoint-GUID: SE2bF5nwtmg_Bi5BJcw-sW5SVI_T11kO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 mlxlogscore=233
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260145
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

[..]
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -61,8 +61,9 @@ static void virtio_crypto_akcipher_finalize_req(
>  	vc_akcipher_req->src_buf = NULL;
>  	vc_akcipher_req->dst_buf = NULL;
>  	virtcrypto_clear_request(&vc_akcipher_req->base);
> -
> +	local_bh_disable();
>  	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
> +	local_bh_enable();

Thanks Gonglei!

I did this a quick spin, and it does not seem to be sufficient on s390x.
Which does not come as a surprise to me, because 

#define lockdep_assert_in_softirq()                                     \
do {                                                                    \
        WARN_ON_ONCE(__lockdep_enabled                  &&              \
                     (!in_softirq() || in_irq() || in_nmi()));          \
} while (0)

will still warn because  in_irq() still evaluates to true (your patch
addresses the !in_softirq() part).

I don't have any results on x86 yet. My current understanding is that the
virtio-pci transport code disables interrupts locally somewhere in the
call chain (actually in vp_vring_interrupt() via spin_lock_irqsave())
and then x86 would be fine. But I will get that verified.

On the other hand virtio_airq_handler() calls vring_interrupt() with
interrupts enabled. (While vring_interrupt() is called in a (read)
critical section in virtio_airq_handler() we use read_lock() and
not read_lock_irqsave() to grab the lock. Whether that is correct in
it self (i.e. disregarding the crypto problem) or not I'm not sure right
now. Will think some more about it tomorrow.) If the way to go forward
is disabling interrupts in virtio-ccw before vring_interrupt() is
called, I would be glad to spin a patch for that.

Copying Conny, as she may have an opinion on this (if I'm not wrong she
authored that code).

Regards,
Halil
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
