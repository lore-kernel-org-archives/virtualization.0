Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F762C433EF
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 13:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9CD360640;
	Mon, 22 Nov 2021 13:50:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HnToZxwm7n6p; Mon, 22 Nov 2021 13:50:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6B5DA60654;
	Mon, 22 Nov 2021 13:50:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4508CC001E;
	Mon, 22 Nov 2021 13:50:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E64ECC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 13:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7F964030D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 13:50:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id INHiYnBuLlKX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 13:50:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E685740292
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 13:50:15 +0000 (UTC)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMCVOU6026884; 
 Mon, 22 Nov 2021 13:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=aHA4C480Nz6E5NCmgObls4kSHKluFhtPQOoxtzr4X+s=;
 b=m9vNL65RVP9mn5VPMktT8iNgRmNE65dAFixuxKksb1EpVB/hMfjHdAefnWVZqVlWZCLi
 Xm+lOrL5IaPONBFMJHyeGFfssm3g+X/72sae2cpeD2cteLwQmj8ickIEZwadvoU9COmQ
 JKuu2OHluGawijEKcALHy6OLj7PvfGkU8ndj3cVnJaDHg/8lo4j97zZzBzwB3LP2yYLv
 ldvIhJMEhHUtutdXV/Mb33TWW5wFT7s7vu7b7JZVQTGkqnfaClzMe7tO70iDN9+54zXP
 oTWVXX0G5vifvmdNlYllUrWk7LWmS4kzz7nS/YP8YsJ4u5m49MMyHoUWoO4ivV7Ko2P7 cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cgb3qt23p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Nov 2021 13:50:12 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AMCVX8o028200;
 Mon, 22 Nov 2021 13:50:12 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cgb3qt22g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Nov 2021 13:50:12 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AMDmrFc010044;
 Mon, 22 Nov 2021 13:50:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06fra.de.ibm.com with ESMTP id 3cer9je9ef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Nov 2021 13:50:09 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 1AMDgw4P64618962
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Nov 2021 13:42:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63CF44C086;
 Mon, 22 Nov 2021 13:50:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D758D4C072;
 Mon, 22 Nov 2021 13:50:06 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.37.164])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Mon, 22 Nov 2021 13:50:06 +0000 (GMT)
Date: Mon, 22 Nov 2021 14:50:03 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211122145003.3e127a03.pasic@linux.ibm.com>
In-Reply-To: <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bivJ9jbi1sDW8XxX0FXZYrfoA8zF0D4o
X-Proofpoint-ORIG-GUID: V3BmkPAMFxZjyy_N1jwN4amxaZqnNUJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_07,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220071
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

On Mon, 22 Nov 2021 14:25:26 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On Mon, Nov 22, 2021 at 1:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:
> >
> > On Mon, 22 Nov 2021 06:35:18 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >  
> > > > I think it should be a common issue, looking at
> > > > vhost_vsock_handle_tx_kick(), it did:
> > > >
> > > > len += sizeof(pkt->hdr);
> > > > vhost_add_used(vq, head, len);
> > > >
> > > > which looks like a violation of the spec since it's TX.  
> > >
> > > I'm not sure the lines above look like a violation of the spec. If you
> > > examine vhost_vsock_alloc_pkt() I believe that you will agree that:
> > > len == pkt->len == pkt->hdr.len
> > > which makes sense since according to the spec both tx and rx messages
> > > are hdr+payload. And I believe hdr.len is the size of the payload,
> > > although that does not seem to be properly documented by the spec.  
> 
> Sorry for being unclear, what I meant is that we probably should use
> zero here. TX doesn't use in buffer actually.
> 
> According to the spec, 0 should be the used length:
> 
> "and len the total of bytes written into the buffer."

Right, I was wrong. I somehow assumed this is the total length and not
just the number of bytes written.

> 
> > >
> > > On the other hand tx messages are stated to be device read-only (in the
> > > spec) so if the device writes stuff, that is certainly wrong.
> > >  
> 
> Yes.
> 
> > > If that is what happens.
> > >
> > > Looking at virtqueue_get_buf_ctx_split() I'm not sure that is what
> > > happens. My hypothesis is that we just a last descriptor is an 'in'
> > > type descriptor (i.e. a device writable one). For tx that assumption
> > > would be wrong.
> > >
> > > I will have another look at this today and send a fix patch if my
> > > suspicion is confirmed.

Yeah, I didn't remember the semantic of
vq->split.vring.used->ring[last_used].len
correctly, and in fact also how exactly the rings work. So your objection
is correct. 

Maybe updating some stuff would make it easier to not make this mistake.

For example the spec and also the linux header says:

/* le32 is used here for ids for padding reasons. */ 
struct virtq_used_elem { 
        /* Index of start of used descriptor chain. */ 
        le32 id; 
        /* Total length of the descriptor chain which was used (written to) */ 
        le32 len; 
};

I think that comment isn't as clear as it could be. I would prefer:
/* The number of bytes written into the device writable portion of the
buffer described by the descriptor chain. */

I believe "the descriptor chain which was used" includes both the
descriptors that map the device read only and the device write
only portions of the buffer described by the descriptor chain. And the
total length of that descriptor chain may be defined either as a number
of the descriptors that form the chain, or the length of the buffer.

One has to use the descriptor chain even if the whole buffer is device
read only. So "used" == "written to" does not make any sense to me.

Also something like
int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int bytes_written)
instead of
int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int len)
would make it easier to read the code correctly.

> >
> > If my suspicion is right something like:
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 00f64f2f8b72..efb57898920b 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -764,6 +764,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >         struct vring_virtqueue *vq = to_vvq(_vq);
> >         void *ret;
> >         unsigned int i;
> > +       bool has_in;
> >         u16 last_used;
> >
> >         START_USE(vq);
> > @@ -787,6 +788,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >                         vq->split.vring.used->ring[last_used].id);
> >         *len = virtio32_to_cpu(_vq->vdev,
> >                         vq->split.vring.used->ring[last_used].len);
> > +       has_in = virtio16_to_cpu(_vq->vdev,
> > +                       vq->split.vring.used->ring[last_used].flags)
> > +                               & VRING_DESC_F_WRITE;  
> 
> Did you mean vring.desc actually? If yes, it's better not depend on
> the descriptor ring which can be modified by the device. We've stored
> the flags in desc_extra[].
> 
> >
> >         if (unlikely(i >= vq->split.vring.num)) {
> >                 BAD_RING(vq, "id %u out of range\n", i);
> > @@ -796,7 +800,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >                 BAD_RING(vq, "id %u is not a head!\n", i);
> >                 return NULL;
> >         }
> > -       if (vq->buflen && unlikely(*len > vq->buflen[i])) {
> > +       if (has_in && q->buflen && unlikely(*len > vq->buflen[i])) {
> >                 BAD_RING(vq, "used len %d is larger than in buflen %u\n",
> >                         *len, vq->buflen[i]);
> >                 return NULL;
> >
> > would fix the problem for split. I will try that out and let you know
> > later.  
> 
> I'm not sure I get this, in virtqueue_add_split, the buflen[i] only
> contains the in buffer length.

Sorry my diff is indeed silly.

> 
> I think the fixes are:
> 
> 1) fixing the vhost vsock
> 2) use suppress_used_validation=true to let vsock driver to validate
> the in buffer length
> 3) probably a new feature so the driver can only enable the validation
> when the feature is enabled.
> 

Makes sense!

Regards,
Halil

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
