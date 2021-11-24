Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF262C433EF
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 11:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62B0E4025F;
	Wed, 24 Nov 2021 11:33:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ySOfreum95L3; Wed, 24 Nov 2021 11:33:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EEEA040263;
	Wed, 24 Nov 2021 11:33:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C730DC001E;
	Wed, 24 Nov 2021 11:33:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F3E4C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 11:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FE4160BAA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 11:33:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FytHFWVWArQv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 11:33:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BDF496060F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 11:33:44 +0000 (UTC)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOBNajM011993; 
 Wed, 24 Nov 2021 11:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=hozd2+Y1/Qiu6cp8IXq+P0ny6UFDTejcFpVK1Wpw5dk=;
 b=pKFiBHwkOwVtlejxxVIMlEU/k9hSxsvQ0n2o35ER64Z+1AuZMlJICE/CFgTPMHvqX29X
 FzKRL+AN8HZhjXh6UzkzHZiN5+1O2ZPi7V+GhQlqFr+3V25VpSWQj3IfUP4P1yNrxtlA
 w5BNxmesmJGc9dK/LDdrBDnoorjpvMYysyRao5+M5IHEXhe4sZ8BA/b98KoXz5Gaw5S0
 zXUAqLRfRSYZw3/DAAvA59VYGhtzxwtAVvkWB5Ysn/O9NLZWnLkUFGpPXHR0TQlJKEPH
 SiaZ2HU09wbAM+CV4mgCCUpc2z5mNVkJss6F99DEPe7+oUx9HX7p43vtndEjawks2w5U Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3chmfm84n0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Nov 2021 11:33:37 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AOBOOi1013597;
 Wed, 24 Nov 2021 11:33:37 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3chmfm84ma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Nov 2021 11:33:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AOBXDFJ026434;
 Wed, 24 Nov 2021 11:33:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04ams.nl.ibm.com with ESMTP id 3cernb0y08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Nov 2021 11:33:34 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 1AOBQLFp59965840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Nov 2021 11:26:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECE1211C04A;
 Wed, 24 Nov 2021 11:33:31 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 491F611C050;
 Wed, 24 Nov 2021 11:33:31 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.0.71])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Wed, 24 Nov 2021 11:33:31 +0000 (GMT)
Date: Wed, 24 Nov 2021 12:33:28 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211124123328.5ed9ce78.pasic@linux.ibm.com>
In-Reply-To: <CACGkMEs086P=qfMieMQ3wPhcarsdO++iRTwVHtN-4cgKLm8opA@mail.gmail.com>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122212352.4a76232d.pasic@linux.ibm.com>
 <CACGkMEtmhwDEAvMuMhQEUB-b+=n713pVvjyct8QAqMUk1H-A-g@mail.gmail.com>
 <20211123055906-mutt-send-email-mst@kernel.org>
 <87zgpupcga.fsf@mpe.ellerman.id.au>
 <CACGkMEteDZJVM8j5pir7_Hcn6Oq=tKbcg4DUiEQBGm5Kg9w30w@mail.gmail.com>
 <CACGkMEs086P=qfMieMQ3wPhcarsdO++iRTwVHtN-4cgKLm8opA@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MUU4xCk-3zlIDCRZ7bqj6Jr0_gzgxZCw
X-Proofpoint-GUID: P0_RJzMk6N0w4Cq4UY1RowTVe8yceCdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_04,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=999
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240065
Cc: "kaplan, david" <david.kaplan@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, mcgrof@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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

On Wed, 24 Nov 2021 10:33:28 +0800
Jason Wang <jasowang@redhat.com> wrote:

> > > > Let's see how far we can get. But yes, maybe we were too aggressive in
> > > > breaking things by default, a warning might be a better choice for a
> > > > couple of cycles.  
> >
> > Ok, considering we saw the issues with balloons I think I can post a
> > patch to use warn instead. I wonder if we need to taint the kernel in
> > this case.  
> 
> Rethink this, consider we still have some time, I tend to convert the
> drivers to validate the length by themselves. Does this make sense?

I do find value in doing the validation in a single place for every
driver. This is really a common concern. But I think, not breaking
what used to work before is a good idea. So I would opt for producing
a warning, but otherwise preserving old behavior unless there is an
explicit opt-in for something more strict.

BTW AFAIU if we detect a problem here, there are basically two
cases:
(1) Either the device is over-reporting what it has written, or
(2) we have a memory corruption in the guest because the device has
written beyond the end of the provided buffer. This can be because
  (2.1) the driver provided a smaller buffer than mandated by the spec,
  or
  (2.2) the device is broken.

Case (1) is relatively harmless, and I believe a warning for it is more
than appropriate. Whoever sees the warning should push for a fixed device
if possible.

Case (2) is nasty. What would be the sanest course of action if we were
reasonably sure we have have case (2.2)?

Maybe we can detect case (2) with a canary. I.e. artificially extend 
the buffer with an extra descriptor that has a poisoned buffer, and
check if the value of that poisoned buffer is different than poison. I'm
not sure it is worth the effort though in production.

Regards,
Halil
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
