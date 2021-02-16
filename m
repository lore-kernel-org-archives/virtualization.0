Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D1EC433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 10:42:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA5E64DFF
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 10:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA5E64DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19AB76F585
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 10:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W5GCE2t2Z73O for <virtualization@archiver.kernel.org>;
	Tue, 16 Feb 2021 10:42:24 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 4579F6F56C; Tue, 16 Feb 2021 10:42:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59BAA6F4F7;
	Tue, 16 Feb 2021 10:42:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 315E0C0174;
	Tue, 16 Feb 2021 10:42:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 835FFC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 10:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76CF66F4F7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 10:42:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I_fA_xksKhy6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 10:42:18 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id B921C6F51C; Tue, 16 Feb 2021 10:42:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF2346F4F7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 10:42:17 +0000 (UTC)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 11GAX3NP124533; Tue, 16 Feb 2021 05:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=gGpHKUVut1e5h+GesFZOQHKFq6ZkLXyolgzAx+o8uKw=;
 b=oWGDgDFpUUVBuB7c/uk44R+A2xih6221uOtOZbG5/4M4j/gn29Gjh5AzzIbEA33x6TH0
 eyBG1xIkvyvdHS3kBUvhS2u66L78Q6LhycTe8UDVhzWfN0HAbTqVK6rm1sLA6YQsq4nU
 /nROWaXSoVHpm/CiizZl560lFrxQNT/9V0RnU5basjoxlit7Mg6rkW/YZMI/jjZoHXwn
 4rPbyjhW+E8yGiRg576hg7j5XtgKFQrjtmw7Y660jh8sMmpnr0CRApP/xQNyCuxWOCVe
 zRud9+vUNo/mCiHdjr0gcY9xzNNwGzzy6aN6ZvVVvctIqwav4g2sjLTCsJbPOixtrJh+ 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 36rc7j0qwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Feb 2021 05:42:16 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11GAXCBp125506;
 Tue, 16 Feb 2021 05:42:16 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 36rc7j0qw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Feb 2021 05:42:16 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11GAfOOg002699;
 Tue, 16 Feb 2021 10:42:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04ams.nl.ibm.com with ESMTP id 36p6d8ap3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Feb 2021 10:42:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 11GAgCa032113004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Feb 2021 10:42:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B73442047;
 Tue, 16 Feb 2021 10:42:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC63842041;
 Tue, 16 Feb 2021 10:42:11 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.71.158])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Tue, 16 Feb 2021 10:42:11 +0000 (GMT)
Date: Tue, 16 Feb 2021 11:42:09 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio/s390: implement virtio-ccw revision 2 correctly
Message-ID: <20210216114209.08fab659.pasic@linux.ibm.com>
In-Reply-To: <20210216113907.4e6943a9.cohuck@redhat.com>
References: <20210212170411.992217-1-cohuck@redhat.com>
 <20210215124702.23a093b8.cohuck@redhat.com>
 <20210215195144.7b96b41f.pasic@linux.ibm.com>
 <20210216113907.4e6943a9.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-02-15_16:2021-02-12,
 2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160092
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 Pierre Morel <pmorel@linux.ibm.com>, virtualization@lists.linux-foundation.org
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

On Tue, 16 Feb 2021 11:39:07 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> > 
> > Reviewed-by: Halil Pasic <pasic@linux.ibm.com>  
> 
> Thanks!
> 
> I'll do a v2 with a tweaked commit message and cc:stable.

Sounds good!

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
