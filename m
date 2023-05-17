Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD83C77B7F
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 10:39:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AC1160F1D;
	Wed, 17 May 2023 10:39:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AC1160F1D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BrQeW7HT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HIxiPd0fxUZf; Wed, 17 May 2023 10:39:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9540560A6D;
	Wed, 17 May 2023 10:39:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9540560A6D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 685B2C0037;
	Wed, 17 May 2023 10:39:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2423FC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 10:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F36A481EF6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 10:39:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F36A481EF6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BrQeW7HT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PYcn2mXRkPtL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 10:39:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A4EA80E92
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A4EA80E92
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684319989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K9RFNHgsvYsYoyjUlDzPxezQioa4wPBhCeawLWQ4WWw=;
 b=BrQeW7HTtyCDmK41lyBVtQlX+zFuN0Eg7FKggNVqbqSUgGzUyUUrCPqOqvWjAKo8ruuM7x
 FUis8xpFcKc+qIrIdXE69Z6BHKkfohKhl/w479TE0+73wbHuz6LtHZxXUiHz8xeMAjGdNE
 A+papPoMlDJ93BQiwWIwUR/EDzusYpk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-Tp8p02AlOhunHgCy0dofsQ-1; Wed, 17 May 2023 06:39:48 -0400
X-MC-Unique: Tp8p02AlOhunHgCy0dofsQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-307bac4c949so398046f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 03:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684319987; x=1686911987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9RFNHgsvYsYoyjUlDzPxezQioa4wPBhCeawLWQ4WWw=;
 b=CVrSAhxQ/BtzgogDODsZmpO6MacP+oLaADek+qP85IpBCt2OdLVV+f+JnBkFB26ily
 FQebKEp8HrCH685pOwjGzFMgItFT8b1QEF624YDq+BJKV0O6fAh2XZR+o+79zaFrTTQX
 mfXaAizW3Z/KPeipSMJe6v+DOXW+vod+/p6kdno6kMQShiwNB8rbrpkP/mYwMFNEVN/u
 XZ74syKttMHbfzXrlKHGeRwI9wpOY7zSTxbHocV+tLQtASWG3APsx4CjfZlrnqNFX6qK
 g3gs5ZqV4bsvYgkbxEVtVl5u76Ix+OcUhytHfXf3j3FOe1a9nd7/3pcs1QAvH1Ot0tNd
 fSaw==
X-Gm-Message-State: AC+VfDyyGXP5OvO5ndNTF7lwkwnMPTWZM2U9X6Eo1ybaMR1/a7HDj44O
 XllAPo7nnOXiXiUUBZRqkGZye7ebIrLbGcXzjh4suvrYkAG+s4R7rjYXmoMZ9AKkmnfLWoaBr3s
 vhz4olE4nMrvYLEBuTVD4dRJTRym213BQIvbiPzFlZg==
X-Received: by 2002:a5d:54ca:0:b0:2ef:b4a9:202f with SMTP id
 x10-20020a5d54ca000000b002efb4a9202fmr236454wrv.69.1684319987571; 
 Wed, 17 May 2023 03:39:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48S7q5cMVKOoBFLgTSo73ggc+dQUqjnyJuJwbUxLKbFp3Thr5m3KCEyEM6J2lKwxaUDPhdCA==
X-Received: by 2002:a5d:54ca:0:b0:2ef:b4a9:202f with SMTP id
 x10-20020a5d54ca000000b002efb4a9202fmr236437wrv.69.1684319987266; 
 Wed, 17 May 2023 03:39:47 -0700 (PDT)
Received: from redhat.com ([2.52.6.43]) by smtp.gmail.com with ESMTPSA id
 f12-20020adff8cc000000b002fe13ec49fasm2269476wrq.98.2023.05.17.03.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 03:39:46 -0700 (PDT)
Date: Wed, 17 May 2023 06:39:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: Re: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Message-ID: <20230517062401-mutt-send-email-mst@kernel.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
 <ZGSEq197W8VvOWCc@infradead.org>
 <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
 <ZGSGQWqbtdwGXurf@infradead.org>
 <cc9f3aea-b8bc-f312-41bb-3fd68083aa99@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <cc9f3aea-b8bc-f312-41bb-3fd68083aa99@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, stefanha@redhat.com
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

On Wed, May 17, 2023 at 04:35:55PM +0800, zhenwei pi wrote:
> 
> 
> On 5/17/23 15:46, Christoph Hellwig wrote:
> > On Wed, May 17, 2023 at 03:43:03PM +0800, zhenwei pi wrote:
> > > I have a plan to introduce 'Virtio Over Fabrics'(TCP&RDMA) as Virtio
> > > transport, as mentioned in cover letter of this series:
> > > 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
> > > https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
> > 
> > Just don't do it.  Please define your own protocols over RDMA or TCP
> > for exactly the operations you need (for many they will already exist)
> > instead of piggyg backing on virtio and making everyone else pay the
> > price.
> > 
> 
> Hi
> 
> 1, `virtqueue_add_inbuf` in current version:
> static inline int virtqueue_add_inbuf(struct virtqueue *vq,
>                                       struct scatterlist *sg,
>                                       unsigned int num,
>                                       void *data,
>                                       gfp_t gfp)
> {
>         if (likely(!vq->abstract))
>                 return vring_virtqueue_add_sgs(vq, &sg, num, 0, 1, data,
> NULL, gfp);
> 
>         return vq->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
> }
> 
> And disassemble 'virtinput_queue_evtbuf':
> static void virtinput_queue_evtbuf(struct virtio_input *vi,
>                                    struct virtio_input_event *evtbuf)
> {
>         struct scatterlist sg[1];
> 
>         sg_init_one(sg, evtbuf, sizeof(*evtbuf));
>         virtqueue_add_inbuf(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
> }
> 
> I notice that two instructions are newly added for vring like:
>  24d:   80 78 35 00             cmpb   $0x0,0x35(%rax)
>  251:   75 3f                   jne    292
> 
> Is it an expensive price...

Can we somehow only override the kick method?
Then take the ring and send it over ...


> 2, Storage/FS specific remote protocol is quite popular, otherwise I'm not
> familiar with other device protocols. For example, I need a remote crypto
> device to accelerate HTTPS ... With Virtio Over Fabrics, I have a chance to
> attach a virtio-crypto device to do this work.
> 
> -- 
> zhenwei pi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
