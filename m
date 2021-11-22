Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A62C433EF
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 16:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 509B4605B2;
	Mon, 22 Nov 2021 16:23:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jUY064dRIH4M; Mon, 22 Nov 2021 16:23:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CE7B760626;
	Mon, 22 Nov 2021 16:23:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DC9CC002E;
	Mon, 22 Nov 2021 16:23:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07FC5C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 16:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D67E960626
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 16:23:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kgj0hl7oELCX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 16:23:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07AE0605B2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637598211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=efSmwxiUUtJf26Hl785CQMfaXFiaJqB6njx3g5TY46w=;
 b=C0dtn/9e974IkjAJ7RPqU2nlBv5H+4Nieg6D1Jj1nWtOS0x/WeAXUT/lMTSEjfOm7HJwKI
 PtxkCsyTLOt2mDQwmWnihpS1TNSThrHaqY6GByqVRT+0pop95U2Quls8F0VnzrMdTgG+zt
 6sWSia2NK2EYjfy3jC3qRNbG4j4Wqp8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-87-gZL5weG3O8qlev2pibgUNA-1; Mon, 22 Nov 2021 11:23:30 -0500
X-MC-Unique: gZL5weG3O8qlev2pibgUNA-1
Received: by mail-ed1-f71.google.com with SMTP id
 d13-20020a056402516d00b003e7e67a8f93so15332526ede.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 08:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=efSmwxiUUtJf26Hl785CQMfaXFiaJqB6njx3g5TY46w=;
 b=7DNrghA98/vmQmPZ5Hs18Gj83pM6aOfv0nE/QrrENoOl6id0MzTWGRbw8zHSXLzqDX
 wO98zYwA/zcP1q1BjVecQ1jxu5hTy5Wd6P2dVIAi77gD1DaK916oqxCOMuOMQdFnCKs7
 C5BGwezLYaPmVSI/EFI55iHfFWBNZaPjuzn2+yVAQADRAsZl5m88QxblotUQc5zy8/0W
 eX9pUVudJYwbsXeUG7z0wyj/Z0pvOPMhIn3XIYP+bv+sYIcUvSs27sNQys1H6Xbtiuen
 20PzDBabAJJv6tCjEoJCGVqs41JCEXJKTNu4TtUlsWcwxAgeHlV12CaIL6A5YNI8X0XC
 lMnQ==
X-Gm-Message-State: AOAM533oXNag1RfeW+QOcmNCQchnbDfx3hKuc4eyLneeOkWh0MADsCC0
 iSo2KA3iC+4OUT9dh6Vs/p0Da34cZ+wnFxjSculXW+7tqpwWBDIvXTqqCaaJIAi9GCB8vMJ3mnA
 0UvksGsE+a2tx0WMhNAfNJQs+h1N5KS4Yo/Ulz2QD2A==
X-Received: by 2002:aa7:df9a:: with SMTP id b26mr66258647edy.107.1637598209590; 
 Mon, 22 Nov 2021 08:23:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypOCvvJc4Uunk8NDr5uqUQL2+zRETKUnZEB8ll4wnoYCNHncNxVvfAIWCG/0rhW4OJYhc7qg==
X-Received: by 2002:aa7:df9a:: with SMTP id b26mr66258601edy.107.1637598209339; 
 Mon, 22 Nov 2021 08:23:29 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id j4sm4285620edk.64.2021.11.22.08.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Nov 2021 08:23:29 -0800 (PST)
Date: Mon, 22 Nov 2021 17:23:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211122162326.f22bpzse74skqjex@steredhat>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122075524.lzojug4hspzglzhl@steredhat>
 <20211122110822.3xqcdluezrcapkyp@steredhat>
 <20211122152432.23a70a12.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20211122152432.23a70a12.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kaplan, david" <david.kaplan@amd.com>, mst <mst@redhat.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Nov 22, 2021 at 03:24:32PM +0100, Halil Pasic wrote:
>On Mon, 22 Nov 2021 12:08:22 +0100
>Stefano Garzarella <sgarzare@redhat.com> wrote:
>
>> On Mon, Nov 22, 2021 at 08:55:24AM +0100, Stefano Garzarella wrote:
>> >On Mon, Nov 22, 2021 at 02:25:26PM +0800, Jason Wang wrote:
>> >>On Mon, Nov 22, 2021 at 1:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>> >>>
>> >>>On Mon, 22 Nov 2021 06:35:18 +0100
>> >>>Halil Pasic <pasic@linux.ibm.com> wrote:
>> >>>
>> >>>> > I think it should be a common issue, looking at
>> >>>> > vhost_vsock_handle_tx_kick(), it did:
>> >>>> >
>> >>>> > len += sizeof(pkt->hdr);
>> >>>> > vhost_add_used(vq, head, len);
>> >>>> >
>> >>>> > which looks like a violation of the spec since it's TX.
>> >>>>
>> >>>> I'm not sure the lines above look like a violation of the spec. If you
>> >>>> examine vhost_vsock_alloc_pkt() I believe that you will agree that:
>> >>>> len == pkt->len == pkt->hdr.len
>> >>>> which makes sense since according to the spec both tx and rx messages
>> >>>> are hdr+payload. And I believe hdr.len is the size of the payload,
>> >>>> although that does not seem to be properly documented by the spec.
>> >>
>> >>Sorry for being unclear, what I meant is that we probably should use
>> >>zero here. TX doesn't use in buffer actually.
>> >>
>> >>According to the spec, 0 should be the used length:
>> >>
>> >>"and len the total of bytes written into the buffer."
>> >>
>> >>>>
>> >>>> On the other hand tx messages are stated to be device read-only (in the
>> >>>> spec) so if the device writes stuff, that is certainly wrong.
>> >>>>
>> >>
>> >>Yes.
>> >>
>> >>>> If that is what happens.
>> >>>>
>> >>>> Looking at virtqueue_get_buf_ctx_split() I'm not sure that is what
>> >>>> happens. My hypothesis is that we just a last descriptor is an 'in'
>> >>>> type descriptor (i.e. a device writable one). For tx that assumption
>> >>>> would be wrong.
>> >>>>
>> >>>> I will have another look at this today and send a fix patch if my
>> >>>> suspicion is confirmed.
>> >>>
>> >>>If my suspicion is right something like:
>> >>>
>> >>>diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> >>>index 00f64f2f8b72..efb57898920b 100644
>> >>>--- a/drivers/virtio/virtio_ring.c
>> >>>+++ b/drivers/virtio/virtio_ring.c
>> >>>@@ -764,6 +764,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>> >>>        struct vring_virtqueue *vq = to_vvq(_vq);
>> >>>        void *ret;
>> >>>        unsigned int i;
>> >>>+       bool has_in;
>> >>>        u16 last_used;
>> >>>
>> >>>        START_USE(vq);
>> >>>@@ -787,6 +788,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>> >>>                        vq->split.vring.used->ring[last_used].id);
>> >>>        *len = virtio32_to_cpu(_vq->vdev,
>> >>>                        vq->split.vring.used->ring[last_used].len);
>> >>>+       has_in = virtio16_to_cpu(_vq->vdev,
>> >>>+                       vq->split.vring.used->ring[last_used].flags)
>> >>>+                               & VRING_DESC_F_WRITE;
>> >>
>> >>Did you mean vring.desc actually? If yes, it's better not depend on
>> >>the descriptor ring which can be modified by the device. We've stored
>> >>the flags in desc_extra[].
>> >>
>> >>>
>> >>>        if (unlikely(i >= vq->split.vring.num)) {
>> >>>                BAD_RING(vq, "id %u out of range\n", i);
>> >>>@@ -796,7 +800,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>> >>>                BAD_RING(vq, "id %u is not a head!\n", i);
>> >>>                return NULL;
>> >>>        }
>> >>>-       if (vq->buflen && unlikely(*len > vq->buflen[i])) {
>> >>>+       if (has_in && q->buflen && unlikely(*len > vq->buflen[i])) {
>> >>>                BAD_RING(vq, "used len %d is larger than in buflen %u\n",
>> >>>                        *len, vq->buflen[i]);
>> >>>                return NULL;
>> >>>
>> >>>would fix the problem for split. I will try that out and let you know
>> >>>later.
>> >>
>> >>I'm not sure I get this, in virtqueue_add_split, the buflen[i] only
>> >>contains the in buffer length.
>> >>
>> >>I think the fixes are:
>> >>
>> >>1) fixing the vhost vsock
>> >
>> >Yep, in vhost_vsock_handle_tx_kick() we should have vhost_add_used(vq,
>> >head, 0) since the device doesn't write anything.
>> >
>> >>2) use suppress_used_validation=true to let vsock driver to validate
>> >>the in buffer length
>> >>3) probably a new feature so the driver can only enable the validation
>> >>when the feature is enabled.
>> >
>> >I fully agree with these steps.
>>
>> Michael sent a patch to suppress the validation, so I think we should
>> just fix vhost-vsock. I mean something like this:
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index 938aefbc75ec..4e3b95af7ee4 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -554,7 +554,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>>                          virtio_transport_free_pkt(pkt);
>>
>>                  len += sizeof(pkt->hdr);
>> -               vhost_add_used(vq, head, len);
>> +               vhost_add_used(vq, head, 0);
>>                  total_len += len;
>>                  added = true;
>>          } while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
>>
>> I checked and the problem is there from the first commit, so we should
>> add:
>>
>> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
>>
>> I tested this patch and it works even without suppressing validation in
>> the virtio core.  But for backwards compatibility we have to suppress it
>> for sure as Michael did.
>>
>> Maybe we can have a patch just with this change to backport it easily
>> and one after to clean up a bit the code that was added after (len,
>> total_len).
>>
>> @Halil Let me know if you want to do it, otherwise I can do it.
>>
>
>It is fine, it was you guys who figured out the solution so I think
>it should either be Jason or you who take credit for the patch.

Okay, I'm finishing the tests and sending the patch.

>Thanks for addressing the issue this quickly!

Thanks for reporting!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
