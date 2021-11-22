Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CE0C433F5
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 05:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32F11607DF;
	Mon, 22 Nov 2021 05:35:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mz5_nMa8-7dx; Mon, 22 Nov 2021 05:35:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 97780605FD;
	Mon, 22 Nov 2021 05:35:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6389DC002E;
	Mon, 22 Nov 2021 05:35:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76A23C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 05:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65B0280F69
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 05:35:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RN4G1izrHBIf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 05:35:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D43680DEF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 05:35:32 +0000 (UTC)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AM5M8hQ040045; 
 Mon, 22 Nov 2021 05:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=CA6Crhw+Oip7jycciQON200J8boSzFiIqMvQJcBLKHg=;
 b=dZjAv2kFlagRMr5jxjJ7UkJ5x8mL1Pb5KzbtL8aWURqPiyc0x4Y7c7/MPYI56dMp6cMs
 HiCaAoov2M0lV3jvFm18b+OdSQXRmYYD9RPSv6Y0/EIgd/RGKmwt2c+m5LwlcqzjGJWG
 3SYtheUVFjhB5N1YyNUrjhHP+o4qSP66pVqVOWEjMFcub0nU7Z8KWY7eujOGzwN+JBIz
 /+E/vVVQ3xfaV0UBKYVljHaocgXFG4F2zMI5hJn3Q9tNZURepoXzBn2wJp/fHKxG+RXq
 9gaU6rzGaBJj+CUFdUOGTEq2h//zmQja9QAeZHUWEipcEK6uq3yKSK/tIuy2Vnri68ow jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cg50e870r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Nov 2021 05:35:28 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AM5MImP000359;
 Mon, 22 Nov 2021 05:35:27 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cg50e86yk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Nov 2021 05:35:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AM5SxdM005367;
 Mon, 22 Nov 2021 05:35:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04ams.nl.ibm.com with ESMTP id 3cerna9nu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Nov 2021 05:35:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 1AM5SEAG57803162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Nov 2021 05:28:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94FB911C050;
 Mon, 22 Nov 2021 05:35:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 174CD11C05B;
 Mon, 22 Nov 2021 05:35:22 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.46.196])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Mon, 22 Nov 2021 05:35:22 +0000 (GMT)
Date: Mon, 22 Nov 2021 06:35:18 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211122063518.37929c01.pasic@linux.ibm.com>
In-Reply-To: <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V4C_OskBSbepen78rjZZGECX7_Yw4rxj
X-Proofpoint-GUID: Jnkjo_3UdBCABnrwb6QknnBSd76yB_ST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_01,2021-11-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220028
Cc: "kaplan, david" <david.kaplan@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, mst <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Mon, 22 Nov 2021 11:51:09 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On Fri, Nov 19, 2021 at 11:10 PM Halil Pasic <pasic@linux.ibm.com> wrote:
> >
> > On Wed, 27 Oct 2021 10:21:04 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >  
> > > This patch validate the used buffer length provided by the device
> > > before trying to use it. This is done by record the in buffer length
> > > in a new field in desc_state structure during virtqueue_add(), then we
> > > can fail the virtqueue_get_buf() when we find the device is trying to
> > > give us a used buffer length which is greater than the in buffer
> > > length.
> > >
> > > Since some drivers have already done the validation by themselves,
> > > this patch tries to makes the core validation optional. For the driver
> > > that doesn't want the validation, it can set the
> > > suppress_used_validation to be true (which could be overridden by
> > > force_used_validation module parameter). To be more efficient, a
> > > dedicate array is used for storing the validate used length, this
> > > helps to eliminate the cache stress if validation is done by the
> > > driver.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>  
> >
> > Hi Jason!
> >
> > Our CI has detected, that virtio-vsock became unusable with this
> > patch on s390x. I didn't test on x86 yet. The guest kernel says
> > something like:
> > vmw_vsock_virtio_transport virtio1: tx: used len 44 is larger than in buflen 0
> >
> > Did you, or anybody else, see something like this on platforms other that
> > s390x?  
> 
> Adding Stefan and Stefano.
> 
> I think it should be a common issue, looking at
> vhost_vsock_handle_tx_kick(), it did:
> 
> len += sizeof(pkt->hdr);
> vhost_add_used(vq, head, len);
> 
> which looks like a violation of the spec since it's TX.

I'm not sure the lines above look like a violation of the spec. If you
examine vhost_vsock_alloc_pkt() I believe that you will agree that:
len == pkt->len == pkt->hdr.len
which makes sense since according to the spec both tx and rx messages
are hdr+payload. And I believe hdr.len is the size of the payload,
although that does not seem to be properly documented by the spec.

On the other hand tx messages are stated to be device read-only (in the
spec) so if the device writes stuff, that is certainly wrong.

If that is what happens. 

Looking at virtqueue_get_buf_ctx_split() I'm not sure that is what
happens. My hypothesis is that we just a last descriptor is an 'in'
type descriptor (i.e. a device writable one). For tx that assumption
would be wrong.

I will have another look at this today and send a fix patch if my
suspicion is confirmed.


> 
> >
> > I had a quick look at this code, and I speculate that it probably
> > uncovers a pre-existig bug, rather than introducing a new one.  
> 
> I agree.
> 

:) I'm not so sure any more myself.

> >
> > If somebody is already working on this please reach out to me.  
> 
> AFAIK, no. 

Thanks for the info! Then I will dig a little deeper. I asked in order
to avoid doing the debugging and fixing just to see that somebody was
faster :D

> I think the plan is to fix both the device and drive side
> (but I'm not sure we need a new feature for this if we stick to the
> validation).
> 
> Thanks
> 

Thank you!

Regards,
Halil
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
