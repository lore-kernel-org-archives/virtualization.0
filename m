Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C00EC433EF
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 11:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC2A360AB7;
	Mon, 16 May 2022 11:20:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2CR4kj9j0tmo; Mon, 16 May 2022 11:20:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 687EF61048;
	Mon, 16 May 2022 11:20:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B2ECC0039;
	Mon, 16 May 2022 11:20:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 174E5C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 11:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA733417E2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 11:20:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nOWERt8DF6a8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 11:20:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0510D417D4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 11:20:33 +0000 (UTC)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GA1tEZ027622;
 Mon, 16 May 2022 11:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=0sDcy/5NqNqinaz/rCWyl/8Vhyljw4xe8o9woHQh1Ig=;
 b=ArzzKyxtAykXd5sFX4sdhGF6C/zs8q0X/Cl8227uTjnwWdlwNr/dAXL4svcEWt9feTy0
 bJaqfG50A3ro/a6kiFO97HsPrb+0fqaIpU6dH+4/z3ulhEVnmEwdUDkw7KG+XGJi/Imp
 bLiBmT32ErkeRCNgi/U2jTaribwq3eEaFKUqBZBu8xOnyRSHNOzJa9CpJ3XtVAhvBLiY
 DPRzBKm+oudkf0y/4UjbLqoU71zeZf4Gd5ibYisl39MNfCaoY1WYLD66my3JnjUwxeBX
 dsV70Ik9DPUy7bcDUEGoBLYVupZjqynYI0GonTO0o3qvCOjLM8Qx4ZhgBRKmskiz/P4l ng== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3mgm9dej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 May 2022 11:20:13 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24GAmWxa011771;
 Mon, 16 May 2022 11:20:13 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3mgm9ddu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 May 2022 11:20:13 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24GBF3KD032765;
 Mon, 16 May 2022 11:20:11 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma05fra.de.ibm.com with ESMTP id 3g24291ye4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 May 2022 11:20:11 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 24GBK8m341288040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 May 2022 11:20:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7E24A405F;
 Mon, 16 May 2022 11:20:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CA2AA405B;
 Mon, 16 May 2022 11:20:08 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown
 [9.152.224.205])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 16 May 2022 11:20:08 +0000 (GMT)
Date: Mon, 16 May 2022 13:20:06 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 0/9] rework on the IRQ hardening of virtio
Message-ID: <20220516132006.29d28fbe.pasic@linux.ibm.com>
In-Reply-To: <CACGkMEtaN6tZrwp3rsxu4Hn1Rev2P06X3BaR4X1cqDxnRdPCKg@mail.gmail.com>
References: <20220507071954.14455-1-jasowang@redhat.com>
 <875ymd3fd1.fsf@redhat.com>
 <CACGkMEvfkUpsY4LRTuH7w18DZdq+w3=Ef6b-0sG0XvzVUVKdzg@mail.gmail.com>
 <20220511160147.46cbf2fb.pasic@linux.ibm.com>
 <CACGkMEtaN6tZrwp3rsxu4Hn1Rev2P06X3BaR4X1cqDxnRdPCKg@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NypXikSCMvLQ1iQroLyffUfvmf3iPEFe
X-Proofpoint-GUID: mWAhWuEU_dMPLR8NB5vNWHv6vAcsNqNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_06,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 adultscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=761 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160065
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

On Thu, 12 May 2022 11:31:08 +0800
Jason Wang <jasowang@redhat.com> wrote:

> > > It looks to me we need to use write_lock_irq()/write_unlock_irq() to
> > > do the synchronization.
> > >
> > > And we probably need to keep the
> > > read_lock_irqsave()/read_lock_irqrestore() logic since I can see the
> > > virtio_ccw_int_handler() to be called from process context (e.g from
> > > the io_subchannel_quiesce()).
> > >  
> >
> > Sounds correct.  
> 
> As Cornelia and Vineeth pointed out, all the paths the vring_interrupt
> is called with irq disabled.
> 
> So I will use spin_lock()/spin_unlock() in the next version.

Can we do some sort of an assertion that if the kernel is built with
the corresponding debug features will make sure this assumption holds
(and warn if it does not)? That assertion would also document the fact.

If an assertion is not possible, I think we should at least place a
strategic comment that documents our assumption.

Regards,
Halil

> 
> Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
