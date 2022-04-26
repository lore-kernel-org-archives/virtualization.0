Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96078C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 02:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2398941484;
	Tue, 26 Apr 2022 02:51:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BANu9FCoyzYD; Tue, 26 Apr 2022 02:51:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3AD22409BA;
	Tue, 26 Apr 2022 02:51:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09F94C0039;
	Tue, 26 Apr 2022 02:51:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DF80C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 02:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 10232410D8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 02:51:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9hjGUQQJ-T3v
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 02:51:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7448409BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 02:51:07 +0000 (UTC)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PMf9fn002943;
 Tue, 26 Apr 2022 02:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=0HFp/dtYsRDF0xV3AMzOvMfLQW7g/p1IqBhfJ8n6Mt4=;
 b=KrXPuOFxMb/MWPAUkUSgFdtuiFp1yY8Vwxb6fJPkeT7GBzNmtgzrV01DoJxTGvvC+3TK
 yF0bcC3IbyrSDuDks5E/UWBAIO1k+03Na9gkZdA/8DjMiADCR60r9U+ONL+PDlFYnhwV
 jO22p2MnyGPBCCDdvMVPWf7hDMZYfOV75dT4vBbwbOZNGe2KZPmFZEf96m3twbeivtNh
 hQCWOpQReNs5ObaUdcGIKDgAZsxoXFqCtd1FZiPNjb4/naNUayPbF/orA1U5EjurdYRw
 35LuHO52/Vi5RWul/arLxIC89MXytc8WDgp4/xC346SX1z060fb7I+dbRVBgn61p4kmn Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fp15807m6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Apr 2022 02:51:00 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23Q2oxYT000336;
 Tue, 26 Apr 2022 02:51:00 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fp15807kj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Apr 2022 02:50:59 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q2ncRM002627;
 Tue, 26 Apr 2022 02:50:55 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma05fra.de.ibm.com with ESMTP id 3fm938tm5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Apr 2022 02:50:55 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 23Q2or9c49414654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Apr 2022 02:50:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D8C3A404D;
 Tue, 26 Apr 2022 02:50:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73FDCA4040;
 Tue, 26 Apr 2022 02:50:52 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.52.32])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Tue, 26 Apr 2022 02:50:52 +0000 (GMT)
Date: Tue, 26 Apr 2022 04:50:50 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220426045050.4697c833.pasic@linux.ibm.com>
In-Reply-To: <87a6c98rwf.fsf@redhat.com>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cd7m943RPs77y-Ogdgm4XIbN1hGBzUCL
X-Proofpoint-ORIG-GUID: PPYjYjkc_YhP6CDObAT2cw3Fa3ebaMDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260014
Cc: paulmck@kernel.org, lulu@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 peterz@infradead.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 eperezma@redhat.com, tglx@linutronix.de
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

On Mon, 25 Apr 2022 10:54:24 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:  
> >> This patch tries to implement the synchronize_cbs() for ccw. For the
> >> vring_interrupt() that is called via virtio_airq_handler(), the
> >> synchronization is simply done via the airq_info's lock. For the
> >> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> >> device spinlock for irq is introduced ans used in the synchronization
> >> method.
> >> 
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Cc: Halil Pasic <pasic@linux.ibm.com>
> >> Cc: Cornelia Huck <cohuck@redhat.com>
> >> Signed-off-by: Jason Wang <jasowang@redhat.com>  
> >
> >
> > This is the only one that is giving me pause. Halil, Cornelia,
> > should we be concerned about the performance impact here?
> > Any chance it can be tested?  
> 
> We can have a bunch of devices using the same airq structure, and the
> sync cb creates a choke point, same as registering/unregistering. If
> invoking the sync cb is a rare operation (same as (un)registering), it
> should not affect interrupt processing for other devices too much, but
> it really should be rare.

With the notable difference that the critical section in sync_cb is
basically empty, so it should be less intrusive that register/unregister.

I would also argue, that since after the reset we (re-)discover our
virtqueues and (re-)register adapter interrupts, and thus before or as a
part of the reset we probably do an unregister to clean up the adapter
interrupts and de-allocate the bits in the info, this should not incur
any mayor overhead for the airq case, which is the preferred one.

Or am I missing something?

> 
> For testing, you would probably want to use a setup with many devices
> that share the same airq area (you can fit a lot of devices if they have
> few queues), generate traffic on the queues, and then do something that
> triggers the callback (adding/removing a new device in a loop?)
> 
> I currently don't have such a setup handy; Halil, would you be able to
> test that?

Neither do I. I would also have to start from scratch. I guess it would
be also sufficient to do a setup with two devices: a nic with many busy
queues, and another device that is responsible for generating the resets.

Regards,
Halil
> 
> >  
> >> ---
> >>  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
> >>  1 file changed, 27 insertions(+)
> >> 
> >> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> >> index d35e7a3f7067..c19f07a82d62 100644
> >> --- a/drivers/s390/virtio/virtio_ccw.c
> >> +++ b/drivers/s390/virtio/virtio_ccw.c
> >> @@ -62,6 +62,7 @@ struct virtio_ccw_device {
> >>  	unsigned int revision; /* Transport revision */
> >>  	wait_queue_head_t wait_q;
> >>  	spinlock_t lock;
> >> +	spinlock_t irq_lock;
> >>  	struct mutex io_lock; /* Serializes I/O requests */
> >>  	struct list_head virtqueues;
> >>  	bool is_thinint;
> >> @@ -984,6 +985,27 @@ static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
> >>  	return dev_name(&vcdev->cdev->dev);
> >>  }
> >>  
> >> +static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
> >> +{
> >> +	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> >> +	struct airq_info *info = vcdev->airq_info;
> >> +
> >> +	/*
> >> +	 * Synchronize with the vring_interrupt() called by
> >> +	 * virtio_ccw_int_handler().
> >> +	 */
> >> +	spin_lock(&vcdev->irq_lock);
> >> +	spin_unlock(&vcdev->irq_lock);
> >> +
> >> +	if (info) {
> >> +		/*
> >> +		 * Synchronize with the vring_interrupt() with airq indicator
> >> +		 */
> >> +		write_lock(&info->lock);
> >> +		write_unlock(&info->lock);
> >> +	}  
> 
> I think we can make this an either/or operation (devices will either use
> classic interrupts or adapter interrupts)?

Right, for virtqueue notifications. I second Connie's motion!

> 
> >> +}
> >> +
> >>  static const struct virtio_config_ops virtio_ccw_config_ops = {
> >>  	.get_features = virtio_ccw_get_features,
> >>  	.finalize_features = virtio_ccw_finalize_features,  
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
