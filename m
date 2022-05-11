Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A26C433EF
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 14:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A86DA82F8B;
	Wed, 11 May 2022 14:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bw1VSOXsOvqB; Wed, 11 May 2022 14:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 55DE6828AA;
	Wed, 11 May 2022 14:02:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F961C0032;
	Wed, 11 May 2022 14:02:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48F0CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 14:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4591E82C7C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 14:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a_Cgizdd-cWF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 14:02:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96A5583224
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 14:02:10 +0000 (UTC)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BDKVnd029848;
 Wed, 11 May 2022 14:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=qsQ5SKdZ0ioW8fqIOFzLQJ9VmnLyw+WheucOVyOqJyg=;
 b=k4Rx4Nf8+Bx/Ryz55H7dbjXRRxBo1ea4Oy+RBhUJOBmxr+uRIels04vcd5/UKx2vUmzg
 lWw27swv7KYIMoypYXbP1VVWDVwafJeVToYGHy5ZIIcz8wv8rnjMPurpIAQsDSkIgS71
 8DPKmjlZCh8MZcj3wBpUmaLpofdoOIW40lj4DArBvIZUZFOijQKDlpoAOV0PNZa+SuWI
 Ni/NXHJi7vWDtdhONEEUJ9FmZB+xhl4kQAY6iAjl67lq97vfLWC8uYat/w3RBwOQgscb
 7kJEokRQVoWWox8teCjVLXl9rQ3LpVqlRqEbN9SM7GdLH2TgwLTg5NH7fiNLhGyy8Avs 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0dxq8t7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 May 2022 14:01:55 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BDjBOt035787;
 Wed, 11 May 2022 14:01:54 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0dxq8t6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 May 2022 14:01:54 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BDvLUM009481;
 Wed, 11 May 2022 14:01:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma06fra.de.ibm.com with ESMTP id 3fwg1hvb3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 May 2022 14:01:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 24BE1nhq57868570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 May 2022 14:01:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0E115204F;
 Wed, 11 May 2022 14:01:49 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown
 [9.152.224.205])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 37EDD5204E;
 Wed, 11 May 2022 14:01:49 +0000 (GMT)
Date: Wed, 11 May 2022 16:01:47 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 0/9] rework on the IRQ hardening of virtio
Message-ID: <20220511160147.46cbf2fb.pasic@linux.ibm.com>
In-Reply-To: <CACGkMEvfkUpsY4LRTuH7w18DZdq+w3=Ef6b-0sG0XvzVUVKdzg@mail.gmail.com>
References: <20220507071954.14455-1-jasowang@redhat.com>
 <875ymd3fd1.fsf@redhat.com>
 <CACGkMEvfkUpsY4LRTuH7w18DZdq+w3=Ef6b-0sG0XvzVUVKdzg@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YwY84jtz4mZc8wDYsffoaslHaMgif1_C
X-Proofpoint-ORIG-GUID: HB8f3CTnTA7Z_CM9GzFj0wrmdbOigrtX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_05,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=917 clxscore=1015 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110063
Cc: Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 mst <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Wed, 11 May 2022 10:22:59 +0800
Jason Wang <jasowang@redhat.com> wrote:

> >        CPU0
> >        ----
> >   lock(&vcdev->irq_lock);
> >   <Interrupt>
> >     lock(&vcdev->irq_lock);
> >
> >  *** DEADLOCK ***  
> 
> It looks to me we need to use write_lock_irq()/write_unlock_irq() to
> do the synchronization.
> 
> And we probably need to keep the
> read_lock_irqsave()/read_lock_irqrestore() logic since I can see the
> virtio_ccw_int_handler() to be called from process context (e.g from
> the io_subchannel_quiesce()).
> 

Sounds correct.

Regards,
Halil
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
