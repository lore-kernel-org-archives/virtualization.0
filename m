Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A367C433EF
	for <virtualization@archiver.kernel.org>; Fri,  8 Apr 2022 13:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2181E60AD5;
	Fri,  8 Apr 2022 13:05:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QjV3ePAj604e; Fri,  8 Apr 2022 13:05:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AE05960B56;
	Fri,  8 Apr 2022 13:05:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8135FC0088;
	Fri,  8 Apr 2022 13:05:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EE9FC002C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 13:05:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 370238138A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 13:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OXr4JRshMCDY
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 13:03:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 870C3813AA
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 13:03:39 +0000 (UTC)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238D1J9s032334; 
 Fri, 8 Apr 2022 13:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=/Bzxxg1QWV2zTZLJYuemtOnOWtUYLKKRvdzaHjiJa80=;
 b=oadugTP17bUKmETwp80eex9cNWjnQWZU6tDx4Wg73gfSSKwUoP4kP2/idl4NScdwR7JJ
 7EVriThCP7fAY9wGP9YvSwjB2aFCwwV/pqeTSlx7CIiYkOojnMp199mh3tVZDNL0HxR0
 gwmcJ7WO6f6A3HonLmfNHfSseQ4jMqXzyHTOO7nDsWU9nyEjwGFrnLxmHdefhiKJPb7T
 obxOf5cbYd0cbc/xaKdsTfkdFTs0t13aM+6RZzSC0rT8zel2kA5EqEXva1S1yLmkeqYE
 toGRZlQEIbebUUdWw6uI9kVu4WG8JAr7i5UwIQJCsdZMq2HdJXD/vB2QoTvcxHu3K7Os Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3fabc4kmhw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Apr 2022 13:03:15 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 238CnRwC009831;
 Fri, 8 Apr 2022 13:03:14 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3fabc4kmh4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Apr 2022 13:03:14 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 238CvERB031199;
 Fri, 8 Apr 2022 13:03:12 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06ams.nl.ibm.com with ESMTP id 3f6drhusun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Apr 2022 13:03:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 238ConXP28705158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Apr 2022 12:50:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB68A42049;
 Fri,  8 Apr 2022 13:03:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3615A4203F;
 Fri,  8 Apr 2022 13:03:09 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.91.78])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Fri,  8 Apr 2022 13:03:09 +0000 (GMT)
Date: Fri, 8 Apr 2022 15:03:07 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Message-ID: <20220408150307.24b6b99f.pasic@linux.ibm.com>
In-Reply-To: <87wng2e527.fsf@redhat.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pea_3SdETi5KqpcWHIwOkTb7dRCt-z75
X-Proofpoint-ORIG-GUID: Lk-kM33MKokmvJMY6cCIhgQ_k2uPcOqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_04,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011
 mlxscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080067
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, peterz@infradead.org, maz@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>, tglx@linutronix.de
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

On Wed, 06 Apr 2022 15:04:32 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:  
> >> This patch implements PCI version of synchronize_vqs().
> >> 
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Signed-off-by: Jason Wang <jasowang@redhat.com>  
> >
> > Please add implementations at least for ccw and mmio.  
> 
> I'm not sure what (if anything) can/should be done for ccw...

If nothing needs to be done I would like to have at least a comment in
the code that explains why. So that somebody who reads the code
doesn't wonder: why is virtio-ccw not implementing that callback.

> 
> >  
> >> ---
> >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> >>  drivers/virtio/virtio_pci_common.h |  2 ++
> >>  drivers/virtio/virtio_pci_legacy.c |  1 +
> >>  drivers/virtio/virtio_pci_modern.c |  2 ++
> >>  4 files changed, 19 insertions(+)
> >> 
> >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> >> index d724f676608b..b78c8bc93a97 100644
> >> --- a/drivers/virtio/virtio_pci_common.c
> >> +++ b/drivers/virtio/virtio_pci_common.c
> >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> >>  		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >>  }
> >>  
> >> +void vp_synchronize_vqs(struct virtio_device *vdev)
> >> +{
> >> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >> +	int i;
> >> +
> >> +	if (vp_dev->intx_enabled) {
> >> +		synchronize_irq(vp_dev->pci_dev->irq);
> >> +		return;
> >> +	}
> >> +
> >> +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> >> +		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >> +}
> >> +  
> 
> ...given that this seems to synchronize threaded interrupt handlers?
> Halil, do you think ccw needs to do anything? (AFAICS, we only have one
> 'irq' for channel devices anyway, and the handler just calls the
> relevant callbacks directly.)

Sorry I don't understand enough yet. A more verbose documentation on
"virtio_synchronize_vqs - synchronize with virtqueue callbacks" would
surely benefit me. It may be more than enough for a back-belt but it
ain't enough for me to tell what is the callback supposed to accomplish.

I will have to study this discussion and the code more thoroughly.
Tentatively I side with Jason and Michael in a sense, that I don't
believe virtio-ccw is safe against rough interrupts.

Sorry for the late response. I intend to revisit this on Monday. If
I don't please feel encouraged to ping.

Regards,
Halil

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
