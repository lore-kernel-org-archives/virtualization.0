Return-Path: <SRS0=sYkO=OK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C859C433EF
	for <virtualization@archiver.kernel.org>; Mon, 20 Sep 2021 13:28:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0EFB60F23
	for <virtualization@archiver.kernel.org>; Mon, 20 Sep 2021 13:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0EFB60F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C72840408;
	Mon, 20 Sep 2021 13:27:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FC2J31GrYEDg; Mon, 20 Sep 2021 13:27:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2203A403F7;
	Mon, 20 Sep 2021 13:27:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E73A3C001C;
	Mon, 20 Sep 2021 13:27:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BF0AC000F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 13:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DDB240408
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 13:27:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mx4cqn52AGyU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 13:27:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A0A18403F7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 13:27:55 +0000 (UTC)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KDD7wN024097; 
 Mon, 20 Sep 2021 09:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=U7cmcijDA1vNzgXHEI3npVm3DS1EdsroG6ZTmXPrYJY=;
 b=RJ6jIXbk/+7kl5zb/i4F2MDCokka5vKNUjVo6y42PcZYg+5YVtBzr6eOwpzGk0yui8Bu
 H6ELeQfQGXzsY1D75vELW8ufqhfBHpUfs2KXY3jIhrQYCLXeBbfHXHkN3gGrukwskch6
 StDpJko7PCLVlS6sTQdb9iIkGXOLeK+P8vfFnOq2jQFQe+Jz7BHHQRjtfOd5y3bQMiUo
 IAKX0KcwHfxmytkQVvQqIiXaxbzl521gk+CLAnpXg6xHYe3ivN3SZtg53Dwvnu8WqHVe
 h5Roun6Kcvdypyj54bKqN2oiGTaf/vemDjQR3bzFpltL1/Ep2HtKzsiYtaAMEz+y0sDr Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3b5w69a0a5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Sep 2021 09:27:54 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18KDDKRj027950;
 Mon, 20 Sep 2021 09:27:54 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3b5w69a09a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Sep 2021 09:27:54 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18KDD6nJ031008;
 Mon, 20 Sep 2021 13:27:51 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06fra.de.ibm.com with ESMTP id 3b57cj87jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Sep 2021 13:27:51 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 18KDN5d561866464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Sep 2021 13:23:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CB7342041;
 Mon, 20 Sep 2021 13:27:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E3C24204D;
 Mon, 20 Sep 2021 13:27:47 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.4.199])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Mon, 20 Sep 2021 13:27:47 +0000 (GMT)
Date: Mon, 20 Sep 2021 15:27:44 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] virtio/s390: fix vritio-ccw device teardown
Message-ID: <20210920152744.55af1201.pasic@linux.ibm.com>
In-Reply-To: <875yuvh73k.fsf@redhat.com>
References: <20210915215742.1793314-1-pasic@linux.ibm.com>
 <87pmt8hp5o.fsf@redhat.com>
 <20210916151835.4ab512b2.pasic@linux.ibm.com>
 <87mtobh9xn.fsf@redhat.com>
 <20210920003935.1369f9fe.pasic@linux.ibm.com>
 <875yuvh73k.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4eHUpD-siLTy7unl_x02mAm-wE0tsff9
X-Proofpoint-ORIG-GUID: FPpECGWfhLUor-LoVx62bmLIqey1yVpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109200084
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 bfu@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>, kvm@vger.kernel.org,
 Michael Mueller <mimu@linux.ibm.com>
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

On Mon, 20 Sep 2021 12:30:39 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, Sep 20 2021, Halil Pasic <pasic@linux.ibm.com> wrote:
[..]
> 
> Basically, the vcdev is supposed to be around while the ccw device is
> online (with a tail end until references have been given up, of course.)
> It embeds a virtio device that has the ccw device as a parent, which
> will give us a reference on the ccw device as long as the virtio device
> is alive. Any interactions with the ccw device (except freeing the dma
> buffer) are limited to the time where we still have a reference to it
> via the virtio device.
>

I didn't remember that device_add() takes a reference to the parent, and
that device_del() before device_put(dev) and remove callback.


> >  
> >>   
> >> > So my intuition tells me that
> >> > drivers should manage explicitly. Yes virtio_ccw happens to have dma
> >> > memory whose lifetime is more or less the lifetime of struct virtio_ccw,
> >> > but that may not be always the case.    
> >> 
> >> I'm not sure what you're getting at here. Regardless of the lifetime of
> >> the dma memory, it depends on the presence of the ccw device to which it
> >> is tied. This means that the ccw device must not be released while the
> >> dma memory is alive. We can use the approach in your patch here due to
> >> the lifetime of the dma memory that virtio-ccw allocates when we start
> >> using the device and frees when we stop using the device, or we can use
> >> get/put with every allocate/release dma memory pair, which should be
> >> safe for everyone?
> >>   
> >
> > What I mean is that ccw_device_dma_[zalloc,free]() take a pointer to the
> > ccw_device. If we get/put in those we can ensure that, provided the
> > alloc and the free calls are properly paired, the device will be still
> > alive (and the pointer valid) for the free, if it was valid for the
> > alloc. But it does not ensure that each and every call to alloc is with
> > a valid pointer, or that other uses of the pointer are OK. So I don't
> > think it is completely safe for everyone, because we could try to use
> > a pointer to a ccw device when not having any dma memory allocated from
> > its pool.  
> 
> But the problem is the dma memory, right? Also, it is the same issue for
> any potential caller of the ccw_device_dma_* interfaces.

I tend to agree, my argument was based on the assumption that we did not
use to take a reference to the ccw device in virtio_ccw_online(), but we
do via register_virtio_device(). This reference however gets dropped
right before virtio_ccw_release_dev() is called.
> 
> >
> > This patch takes reference to cdev before the pointer is published via
> > vcdev->cdev and drops the reference after *vcdev is freed. The idea is
> > that the pointee basically outlives the pointer. (Without having a full
> > understanding of how things are synchronized).  
> 
> I don't think we have to care about accessing ->cdev (see above.) Plus,
> as we give up the dma memory at the very last point, we would also give
> up the reference via that memory at the very last point, so I'm not sure
> what additional problems could come up.

I understand now. Let me think about it some more. I'm wonderning about
leafs. Will come back at you shortly.

Regards,
Halil
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
