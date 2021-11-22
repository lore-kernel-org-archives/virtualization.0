Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF4EC433FE
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 11:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 42DDC400F3;
	Mon, 22 Nov 2021 11:08:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UUuNluNRCw3s; Mon, 22 Nov 2021 11:08:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 504F140010;
	Mon, 22 Nov 2021 11:08:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 227DEC001E;
	Mon, 22 Nov 2021 11:08:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 126C0C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 11:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7C1360663
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 11:08:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KU0YndkdVBwU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 11:08:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5B786065D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 11:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637579307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwJpINfDmr6hb4fHSaMa0diME90ILD5FuLJ1mMrsekU=;
 b=So0f+Tocu1wEdpWGcE+oGz9TjrkgdUuQImZTm9rOe4V1WK6PuhY3Z2BhCuc3wtvFG4jv0P
 kR1qGI4otnIUbtV+EnhBtLzO8gVviAbaEvcgz1Pi5SEayGCut/0xEauP02BQ/o04CEUqXi
 i6i5+nwHQEgTOgbf4vNLq7DUg8Avxy0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-mw0zu-wtO9qLDAovsXdz_w-1; Mon, 22 Nov 2021 06:08:26 -0500
X-MC-Unique: mw0zu-wtO9qLDAovsXdz_w-1
Received: by mail-ed1-f69.google.com with SMTP id
 t9-20020aa7d709000000b003e83403a5cbso12563637edq.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 03:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BwJpINfDmr6hb4fHSaMa0diME90ILD5FuLJ1mMrsekU=;
 b=BzjYw6aRw9pwcwfsBmoKRtnoPlEd9sR9MUIh4W2A+RmL6awjOE/ugq4sbJ3oLqJ8mB
 IKjKoUjfXOyUCTdG1DzTCdu+rd0SsFfZ7/ZPyOt7ghkAhOqCcUY3iqPajOtY1ncc0WhY
 f650nqZH+L+mtgtxfWmqO3X6QQCUdcEotNE2HJW8otp0GoMxMxyu2FVcb8dtq/pCz9g5
 88X6JjOUYPfEZ7/COJWGVp3aL+q/vlCCdDY002IPVL/3AcDjAOTm0X4+4JOHNdVgsl0q
 Dcs5fomhzDhNJnRW1jcInwoRt0R0L29cT2A67oBqVMCXGh719FwWWlp3oMQjVSJS6QWf
 BoLw==
X-Gm-Message-State: AOAM533GcCpSnL/cNzYwDefdOxY5agVSvyPeeKgof6Bhc3gI8JN7g2pk
 Pihb2uWFTauhfauZtyN2eNn/bzivLqPO6bCYqRSHNHuB5MNcGT/okZICcSRbYxi7dnn5nOy+bXA
 s1erqrsp8bvxv2CH3/dy7ar9JpZ0/AyHK5a5G+DzR7Q==
X-Received: by 2002:a05:6402:1450:: with SMTP id
 d16mr64822317edx.144.1637579304968; 
 Mon, 22 Nov 2021 03:08:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysfwr7XNBaTmEKGm5Bk/WKD+VkoiIivrsilYo8AQiUBXDw+nsBrImmuAY2gVX68Djdg/vK5g==
X-Received: by 2002:a05:6402:1450:: with SMTP id
 d16mr64822285edx.144.1637579304795; 
 Mon, 22 Nov 2021 03:08:24 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id qb21sm3564077ejc.78.2021.11.22.03.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Nov 2021 03:08:24 -0800 (PST)
Date: Mon, 22 Nov 2021 12:08:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211122110822.3xqcdluezrcapkyp@steredhat>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122075524.lzojug4hspzglzhl@steredhat>
MIME-Version: 1.0
In-Reply-To: <20211122075524.lzojug4hspzglzhl@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kaplan, david" <david.kaplan@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

On Mon, Nov 22, 2021 at 08:55:24AM +0100, Stefano Garzarella wrote:
>On Mon, Nov 22, 2021 at 02:25:26PM +0800, Jason Wang wrote:
>>On Mon, Nov 22, 2021 at 1:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>>>
>>>On Mon, 22 Nov 2021 06:35:18 +0100
>>>Halil Pasic <pasic@linux.ibm.com> wrote:
>>>
>>>> > I think it should be a common issue, looking at
>>>> > vhost_vsock_handle_tx_kick(), it did:
>>>> >
>>>> > len += sizeof(pkt->hdr);
>>>> > vhost_add_used(vq, head, len);
>>>> >
>>>> > which looks like a violation of the spec since it's TX.
>>>>
>>>> I'm not sure the lines above look like a violation of the spec. If you
>>>> examine vhost_vsock_alloc_pkt() I believe that you will agree that:
>>>> len == pkt->len == pkt->hdr.len
>>>> which makes sense since according to the spec both tx and rx messages
>>>> are hdr+payload. And I believe hdr.len is the size of the payload,
>>>> although that does not seem to be properly documented by the spec.
>>
>>Sorry for being unclear, what I meant is that we probably should use
>>zero here. TX doesn't use in buffer actually.
>>
>>According to the spec, 0 should be the used length:
>>
>>"and len the total of bytes written into the buffer."
>>
>>>>
>>>> On the other hand tx messages are stated to be device read-only (in the
>>>> spec) so if the device writes stuff, that is certainly wrong.
>>>>
>>
>>Yes.
>>
>>>> If that is what happens.
>>>>
>>>> Looking at virtqueue_get_buf_ctx_split() I'm not sure that is what
>>>> happens. My hypothesis is that we just a last descriptor is an 'in'
>>>> type descriptor (i.e. a device writable one). For tx that assumption
>>>> would be wrong.
>>>>
>>>> I will have another look at this today and send a fix patch if my
>>>> suspicion is confirmed.
>>>
>>>If my suspicion is right something like:
>>>
>>>diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>index 00f64f2f8b72..efb57898920b 100644
>>>--- a/drivers/virtio/virtio_ring.c
>>>+++ b/drivers/virtio/virtio_ring.c
>>>@@ -764,6 +764,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>>>        struct vring_virtqueue *vq = to_vvq(_vq);
>>>        void *ret;
>>>        unsigned int i;
>>>+       bool has_in;
>>>        u16 last_used;
>>>
>>>        START_USE(vq);
>>>@@ -787,6 +788,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>>>                        vq->split.vring.used->ring[last_used].id);
>>>        *len = virtio32_to_cpu(_vq->vdev,
>>>                        vq->split.vring.used->ring[last_used].len);
>>>+       has_in = virtio16_to_cpu(_vq->vdev,
>>>+                       vq->split.vring.used->ring[last_used].flags)
>>>+                               & VRING_DESC_F_WRITE;
>>
>>Did you mean vring.desc actually? If yes, it's better not depend on
>>the descriptor ring which can be modified by the device. We've stored
>>the flags in desc_extra[].
>>
>>>
>>>        if (unlikely(i >= vq->split.vring.num)) {
>>>                BAD_RING(vq, "id %u out of range\n", i);
>>>@@ -796,7 +800,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>>>                BAD_RING(vq, "id %u is not a head!\n", i);
>>>                return NULL;
>>>        }
>>>-       if (vq->buflen && unlikely(*len > vq->buflen[i])) {
>>>+       if (has_in && q->buflen && unlikely(*len > vq->buflen[i])) {
>>>                BAD_RING(vq, "used len %d is larger than in buflen %u\n",
>>>                        *len, vq->buflen[i]);
>>>                return NULL;
>>>
>>>would fix the problem for split. I will try that out and let you know
>>>later.
>>
>>I'm not sure I get this, in virtqueue_add_split, the buflen[i] only
>>contains the in buffer length.
>>
>>I think the fixes are:
>>
>>1) fixing the vhost vsock
>
>Yep, in vhost_vsock_handle_tx_kick() we should have vhost_add_used(vq, 
>head, 0) since the device doesn't write anything.
>
>>2) use suppress_used_validation=true to let vsock driver to validate
>>the in buffer length
>>3) probably a new feature so the driver can only enable the validation
>>when the feature is enabled.
>
>I fully agree with these steps.

Michael sent a patch to suppress the validation, so I think we should 
just fix vhost-vsock. I mean something like this:

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 938aefbc75ec..4e3b95af7ee4 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -554,7 +554,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
                         virtio_transport_free_pkt(pkt);

                 len += sizeof(pkt->hdr);
-               vhost_add_used(vq, head, len);
+               vhost_add_used(vq, head, 0);
                 total_len += len;
                 added = true;
         } while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));

I checked and the problem is there from the first commit, so we should 
add:

Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")

I tested this patch and it works even without suppressing validation in 
the virtio core.  But for backwards compatibility we have to suppress it 
for sure as Michael did.

Maybe we can have a patch just with this change to backport it easily 
and one after to clean up a bit the code that was added after (len, 
total_len).

@Halil Let me know if you want to do it, otherwise I can do it.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
