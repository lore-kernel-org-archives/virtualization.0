Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08314C433F5
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 14:24:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67D4780DF0;
	Mon, 22 Nov 2021 14:24:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bmj9e30ht09E; Mon, 22 Nov 2021 14:24:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D924180DE1;
	Mon, 22 Nov 2021 14:24:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A9C0C002E;
	Mon, 22 Nov 2021 14:24:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3CEEC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 14:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E238580DE3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 14:24:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mhV9APHtvtOD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 14:24:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02D2980DE1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 14:24:42 +0000 (UTC)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMDqOQJ030848; 
 Mon, 22 Nov 2021 14:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=kiHfvmznB+MewPOaXImBWXvixAZkbmkFRSdb7g/Ixzk=;
 b=ayAL8zUuHmybP318bj5CUQ/R/x4Rrb1ANgo5eFQRW+3eKH6cJh5rAB4a24Lf1j4iP+BA
 dVDkqclSHk8Nyq7PC/ph811jSWDR9h8xKmaxEsazrGCzf2Hl3OldK1S6HQeZ/yYkTiNq
 ShTaeB4k15hrwEO2BeEg70wO441CwS7DLw+eDKAQzVv1m4zW3SfyJKtq9f1o5mwpvlbg
 Idps+BJqwkrSY9wOkP/9uylz0opSw04UBlEJqu5nLFRx/lYrdqV/1RB86P8ZFjBxQb1i
 I8B63J+0aMsCr4hV0q1BbPewmt4rQ2twNtruVOG6ah3hpOTRffekPNsMfWCU94bWUxV3 Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3cgcfngpfa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Nov 2021 14:24:39 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AMEIYuV018430;
 Mon, 22 Nov 2021 14:24:39 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3cgcfngpex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Nov 2021 14:24:39 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AMEErG0015551;
 Mon, 22 Nov 2021 14:24:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma03ams.nl.ibm.com with ESMTP id 3cern9q8pf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Nov 2021 14:24:37 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AMEOZAT63504860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Nov 2021 14:24:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D1D75208E;
 Mon, 22 Nov 2021 14:24:35 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.37.164])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id E0E895208A;
 Mon, 22 Nov 2021 14:24:34 +0000 (GMT)
Date: Mon, 22 Nov 2021 15:24:32 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211122152432.23a70a12.pasic@linux.ibm.com>
In-Reply-To: <20211122110822.3xqcdluezrcapkyp@steredhat>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122075524.lzojug4hspzglzhl@steredhat>
 <20211122110822.3xqcdluezrcapkyp@steredhat>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xkVgc1HaxBlsn9QQlswKhDBbxeKwhMNb
X-Proofpoint-ORIG-GUID: MK1Sk8W_6val3gSS3__ai93gjTpVd4uc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_07,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220075
Cc: "kaplan, david" <david.kaplan@amd.com>, mst <mst@redhat.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
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

On Mon, 22 Nov 2021 12:08:22 +0100
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Mon, Nov 22, 2021 at 08:55:24AM +0100, Stefano Garzarella wrote:
> >On Mon, Nov 22, 2021 at 02:25:26PM +0800, Jason Wang wrote:  
> >>On Mon, Nov 22, 2021 at 1:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:  
> >>>
> >>>On Mon, 22 Nov 2021 06:35:18 +0100
> >>>Halil Pasic <pasic@linux.ibm.com> wrote:
> >>>  
> >>>> > I think it should be a common issue, looking at
> >>>> > vhost_vsock_handle_tx_kick(), it did:
> >>>> >
> >>>> > len += sizeof(pkt->hdr);
> >>>> > vhost_add_used(vq, head, len);
> >>>> >
> >>>> > which looks like a violation of the spec since it's TX.  
> >>>>
> >>>> I'm not sure the lines above look like a violation of the spec. If you
> >>>> examine vhost_vsock_alloc_pkt() I believe that you will agree that:
> >>>> len == pkt->len == pkt->hdr.len
> >>>> which makes sense since according to the spec both tx and rx messages
> >>>> are hdr+payload. And I believe hdr.len is the size of the payload,
> >>>> although that does not seem to be properly documented by the spec.  
> >>
> >>Sorry for being unclear, what I meant is that we probably should use
> >>zero here. TX doesn't use in buffer actually.
> >>
> >>According to the spec, 0 should be the used length:
> >>
> >>"and len the total of bytes written into the buffer."
> >>  
> >>>>
> >>>> On the other hand tx messages are stated to be device read-only (in the
> >>>> spec) so if the device writes stuff, that is certainly wrong.
> >>>>  
> >>
> >>Yes.
> >>  
> >>>> If that is what happens.
> >>>>
> >>>> Looking at virtqueue_get_buf_ctx_split() I'm not sure that is what
> >>>> happens. My hypothesis is that we just a last descriptor is an 'in'
> >>>> type descriptor (i.e. a device writable one). For tx that assumption
> >>>> would be wrong.
> >>>>
> >>>> I will have another look at this today and send a fix patch if my
> >>>> suspicion is confirmed.  
> >>>
> >>>If my suspicion is right something like:
> >>>
> >>>diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> >>>index 00f64f2f8b72..efb57898920b 100644
> >>>--- a/drivers/virtio/virtio_ring.c
> >>>+++ b/drivers/virtio/virtio_ring.c
> >>>@@ -764,6 +764,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >>>        struct vring_virtqueue *vq = to_vvq(_vq);
> >>>        void *ret;
> >>>        unsigned int i;
> >>>+       bool has_in;
> >>>        u16 last_used;
> >>>
> >>>        START_USE(vq);
> >>>@@ -787,6 +788,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >>>                        vq->split.vring.used->ring[last_used].id);
> >>>        *len = virtio32_to_cpu(_vq->vdev,
> >>>                        vq->split.vring.used->ring[last_used].len);
> >>>+       has_in = virtio16_to_cpu(_vq->vdev,
> >>>+                       vq->split.vring.used->ring[last_used].flags)
> >>>+                               & VRING_DESC_F_WRITE;  
> >>
> >>Did you mean vring.desc actually? If yes, it's better not depend on
> >>the descriptor ring which can be modified by the device. We've stored
> >>the flags in desc_extra[].
> >>  
> >>>
> >>>        if (unlikely(i >= vq->split.vring.num)) {
> >>>                BAD_RING(vq, "id %u out of range\n", i);
> >>>@@ -796,7 +800,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >>>                BAD_RING(vq, "id %u is not a head!\n", i);
> >>>                return NULL;
> >>>        }
> >>>-       if (vq->buflen && unlikely(*len > vq->buflen[i])) {
> >>>+       if (has_in && q->buflen && unlikely(*len > vq->buflen[i])) {
> >>>                BAD_RING(vq, "used len %d is larger than in buflen %u\n",
> >>>                        *len, vq->buflen[i]);
> >>>                return NULL;
> >>>
> >>>would fix the problem for split. I will try that out and let you know
> >>>later.  
> >>
> >>I'm not sure I get this, in virtqueue_add_split, the buflen[i] only
> >>contains the in buffer length.
> >>
> >>I think the fixes are:
> >>
> >>1) fixing the vhost vsock  
> >
> >Yep, in vhost_vsock_handle_tx_kick() we should have vhost_add_used(vq, 
> >head, 0) since the device doesn't write anything.
> >  
> >>2) use suppress_used_validation=true to let vsock driver to validate
> >>the in buffer length
> >>3) probably a new feature so the driver can only enable the validation
> >>when the feature is enabled.  
> >
> >I fully agree with these steps.  
> 
> Michael sent a patch to suppress the validation, so I think we should 
> just fix vhost-vsock. I mean something like this:
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 938aefbc75ec..4e3b95af7ee4 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -554,7 +554,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>                          virtio_transport_free_pkt(pkt);
> 
>                  len += sizeof(pkt->hdr);
> -               vhost_add_used(vq, head, len);
> +               vhost_add_used(vq, head, 0);
>                  total_len += len;
>                  added = true;
>          } while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
> 
> I checked and the problem is there from the first commit, so we should 
> add:
> 
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> 
> I tested this patch and it works even without suppressing validation in 
> the virtio core.  But for backwards compatibility we have to suppress it 
> for sure as Michael did.
> 
> Maybe we can have a patch just with this change to backport it easily 
> and one after to clean up a bit the code that was added after (len, 
> total_len).
> 
> @Halil Let me know if you want to do it, otherwise I can do it.
> 

It is fine, it was you guys who figured out the solution so I think
it should either be Jason or you who take credit for the patch. Thanks
for addressing the issue this quickly!

Regards,
Halil
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
