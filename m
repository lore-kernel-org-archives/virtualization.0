Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8790AE810D2
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 11:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E550860B9C;
	Wed, 27 Sep 2023 11:26:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E550860B9C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Yct5r7gl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YaApiflTixLY; Wed, 27 Sep 2023 11:26:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 33C3A60AFF;
	Wed, 27 Sep 2023 11:26:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33C3A60AFF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 153B9C0071;
	Wed, 27 Sep 2023 11:26:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B93B2C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 11:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D5D24045C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 11:26:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D5D24045C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com
 header.a=rsa-sha256 header.s=pp1 header.b=Yct5r7gl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q3ocrvIzSZoM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 11:26:06 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F9C240179
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 11:26:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F9C240179
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38RBCJXj019581; Wed, 27 Sep 2023 11:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=zaDKg/sOthAqsAeV4KNI4nrJjy4oAfJBx/xwQotlLbM=;
 b=Yct5r7glFMPtIALEPCD0KFgfcmvNIS92ZihPDC1qRBk7r6dht1B2n7CkAuUI3ekZnKIh
 tTChVqM70tPe5rCNi35gVaqlEp4hMNxJv4JeXAB4mU03EJEsczcBjwwgnn1AzMhzVXAr
 bDeNRHSKgUs6fn+ebf5s4HN2SnDzhCJfdYKY/Pi8p2miqF8CAuZ7Tc3XY7Kz9hlIdvOS
 dofxDvqaX9OaTyJS5YbjuSyOWkYE6mbH2xpYdnr98LpEb3PVoeQg4qFE1R9X/ymlmiBS
 0zexhca3cirbSgPDsLqHWm/YvwWUNg5Jf/Smjrvnj/rbbaTSGDqxHQK68X9vdIZ0Uda2 ag== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tckag89rf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 11:25:43 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RBD8Jm022055;
 Wed, 27 Sep 2023 11:25:42 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tckag89r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 11:25:42 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38R9qQ1j030746; Wed, 27 Sep 2023 11:25:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjk2nd6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 11:25:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38RBPcsx22610616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Sep 2023 11:25:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DC1520040;
 Wed, 27 Sep 2023 11:25:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2027920049;
 Wed, 27 Sep 2023 11:25:38 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown
 [9.152.224.212])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 27 Sep 2023 11:25:38 +0000 (GMT)
Date: Wed, 27 Sep 2023 13:25:36 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Message-ID: <20230927132536.4b19ab2f.pasic@linux.ibm.com>
In-Reply-To: <877coc2aj8.fsf@redhat.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
 <877coc2aj8.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p8YYw4faLgXLXLhjv7-7jONu4hPNxosP
X-Proofpoint-GUID: yb10tZ8FN2SVPf-XJEXl-ThNzyYU-cf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_06,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 mlxlogscore=625 clxscore=1015 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270092
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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

On Wed, 27 Sep 2023 12:08:43 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> > On the other hand virtio_airq_handler() calls vring_interrupt() with
> > interrupts enabled. (While vring_interrupt() is called in a (read)
> > critical section in virtio_airq_handler() we use read_lock() and
> > not read_lock_irqsave() to grab the lock. Whether that is correct in
> > it self (i.e. disregarding the crypto problem) or not I'm not sure right
> > now. Will think some more about it tomorrow.) If the way to go forward
> > is disabling interrupts in virtio-ccw before vring_interrupt() is
> > called, I would be glad to spin a patch for that.  
> 
> virtio_airq_handler() is supposed to be an interrupt handler for an
> adapter interrupt -- as such I would expect it to always run with
> interrupts disabled (and I'd expect vring_interrupt() to be called
> with interrupts disabled as well; if that's not the case, I think it
> would need to run asynchronously.) At least that was my understanding at
> the time I wrote the code.

Thanks Connie! I don't quite understand what do you mean by "run with
interrupts disabled" in this context.

Do you mean that if I were to add the following warning:

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index ac67576301bf..2a9c73f5964f 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -211,6 +211,8 @@ static void virtio_airq_handler(struct airq_struct *airq,
        struct airq_info *info = container_of(airq, struct airq_info, airq);
        unsigned long ai;
 
+       WARN_ONCE(in_irq(), "irqs are ought to be disabled but are not\n");
+
        inc_irq_stat(IRQIO_VAI);

it would/should never trigger, or do you mean something different?

If yes, does that mean that you would expect the common airq code (i.e. something
like do_airq_interrupt()) to disable interrupts, or call virtio_airq_handler()?
asynchronously sort of as a bottom half (my understanding of bottom halves is currently
not complete).

If no what do you actually mean?

Regards,
Halil

Regards,
Halil

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
