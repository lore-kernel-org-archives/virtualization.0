Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D7BC77B7A
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 10:09:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E24F54036F;
	Thu, 18 May 2023 10:09:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E24F54036F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HmCS/VzU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 71zFPlkqV3Z0; Thu, 18 May 2023 10:09:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 72255400FE;
	Thu, 18 May 2023 10:09:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72255400FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37382C0036;
	Thu, 18 May 2023 10:09:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D6EBC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 10:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2051042813
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 10:09:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2051042813
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HmCS/VzU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ahONh7b6rB0w
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 10:09:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 45EDA4280C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45EDA4280C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 10:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684404563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jCIbZz6ZgescTd68JNRiPQpaemH52EcT/phWnnmN7dc=;
 b=HmCS/VzUlDtG2GTDFb7bjxu374pBpsIh+t2qEVWvLZNlpEtgO7jDipC6961jpGgSKDiarz
 0epyp0NSaU+vpYgCOOswnt+w2QI1G/f197xHhOGefYVBFvwu7LQQW+vAoomfgdoiK/aPHK
 DsnzBgP/E36QcwI2E2x/USdWYOfcZ8Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-XdY6peZBP8GgKn8c0GzByg-1; Thu, 18 May 2023 06:09:19 -0400
X-MC-Unique: XdY6peZBP8GgKn8c0GzByg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f42ceb4a4fso6952035e9.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 03:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684404558; x=1686996558;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCIbZz6ZgescTd68JNRiPQpaemH52EcT/phWnnmN7dc=;
 b=hnvz8iETI+39wU/IOJNq0RLKYuRZRYF6qkE0zkAk1/jOF27WnaDGACxocfBuaDu89r
 qnWWly29l0qLk2H6vofTrLNxpUhykj40d3SVlGjTNKlBl3+q6gtQRP54wk+fHGPDpiyL
 mukAZxWF4yUVxU2fKGyRnQcde3UXPrUoXhuSqGk4kqjIEI74C+5uxOV3EzUxC7vUDuF3
 QzH7C31FwWn8X6a8DhrRT5wlj8O3Xcbvl1YJ9OE9aRLany1vGCf8+ldflouyhS43LsBj
 m5g8eAYHYjv2f7eVzBrbAybeSgTK6VdZ5Iru4UeZmMb15F4Ab1letxi92wNtwwvSd/dq
 q5Tg==
X-Gm-Message-State: AC+VfDxvTNQW18iNLvEK6iyjTB6YT+4m34YDzOAMUBOdXzWTXppWgmlH
 jtq7ardvHPPCCjmfclgyRu+fvLCZRMatzAiNy8jifvpUF3cZdcCJm6O5D57icg2tTy6/P6/GOCD
 HAmZ1gil0Yja9qMDEUQ5LN/BYKs1i/42WF3nib91Ydw==
X-Received: by 2002:a1c:6a17:0:b0:3f4:f855:706b with SMTP id
 f23-20020a1c6a17000000b003f4f855706bmr968940wmc.27.1684404558524; 
 Thu, 18 May 2023 03:09:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oIgFtBVIy9bdA6+5Ow17knV96BGAtGJXZzadD+PYeaIhzN8pn6HZW19bRMu1KU+Q951kbgg==
X-Received: by 2002:a1c:6a17:0:b0:3f4:f855:706b with SMTP id
 f23-20020a1c6a17000000b003f4f855706bmr968925wmc.27.1684404558195; 
 Thu, 18 May 2023 03:09:18 -0700 (PDT)
Received: from redhat.com ([2.52.6.43]) by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b0030631a599a0sm1646018wrw.24.2023.05.18.03.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 03:09:17 -0700 (PDT)
Date: Thu, 18 May 2023 06:09:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: Re: Re: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Message-ID: <20230518060656-mutt-send-email-mst@kernel.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
 <ZGSEq197W8VvOWCc@infradead.org>
 <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
 <ZGSGQWqbtdwGXurf@infradead.org>
 <cc9f3aea-b8bc-f312-41bb-3fd68083aa99@bytedance.com>
 <20230517062401-mutt-send-email-mst@kernel.org>
 <ee2a975f-0aa6-a46a-e9d2-7f82e313347f@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <ee2a975f-0aa6-a46a-e9d2-7f82e313347f@bytedance.com>
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

On Thu, May 18, 2023 at 08:47:22AM +0800, zhenwei pi wrote:
> On 5/17/23 18:39, Michael S. Tsirkin wrote:
> > On Wed, May 17, 2023 at 04:35:55PM +0800, zhenwei pi wrote:
> > > 
> > > 
> > > On 5/17/23 15:46, Christoph Hellwig wrote:
> > > > On Wed, May 17, 2023 at 03:43:03PM +0800, zhenwei pi wrote:
> > > > > I have a plan to introduce 'Virtio Over Fabrics'(TCP&RDMA) as Virtio
> > > > > transport, as mentioned in cover letter of this series:
> > > > > 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
> > > > > https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
> > > > 
> > > > Just don't do it.  Please define your own protocols over RDMA or TCP
> > > > for exactly the operations you need (for many they will already exist)
> > > > instead of piggyg backing on virtio and making everyone else pay the
> > > > price.
> > > > 
> > > 
> > > Hi
> > > 
> > > 1, `virtqueue_add_inbuf` in current version:
> > > static inline int virtqueue_add_inbuf(struct virtqueue *vq,
> > >                                        struct scatterlist *sg,
> > >                                        unsigned int num,
> > >                                        void *data,
> > >                                        gfp_t gfp)
> > > {
> > >          if (likely(!vq->abstract))
> > >                  return vring_virtqueue_add_sgs(vq, &sg, num, 0, 1, data,
> > > NULL, gfp);
> > > 
> > >          return vq->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
> > > }
> > > 
> > > And disassemble 'virtinput_queue_evtbuf':
> > > static void virtinput_queue_evtbuf(struct virtio_input *vi,
> > >                                     struct virtio_input_event *evtbuf)
> > > {
> > >          struct scatterlist sg[1];
> > > 
> > >          sg_init_one(sg, evtbuf, sizeof(*evtbuf));
> > >          virtqueue_add_inbuf(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
> > > }
> > > 
> > > I notice that two instructions are newly added for vring like:
> > >   24d:   80 78 35 00             cmpb   $0x0,0x35(%rax)
> > >   251:   75 3f                   jne    292
> > > 
> > > Is it an expensive price...
> > 
> > Can we somehow only override the kick method?
> > Then take the ring and send it over ...
> > 
> 
> Could you please take a look at this code?
> https://github.com/pizhenwei/linux/blob/virtio-of-github/drivers/virtio/virtio_fabrics.c#LL861C13-L861C23

what am I looking at here?

Looks like at least vof_handle_vq duplicates some code from vringh.
But besides that yes, that's the idea.


> > 
> > > 2, Storage/FS specific remote protocol is quite popular, otherwise I'm not
> > > familiar with other device protocols. For example, I need a remote crypto
> > > device to accelerate HTTPS ... With Virtio Over Fabrics, I have a chance to
> > > attach a virtio-crypto device to do this work.
> > > 
> > > -- 
> > > zhenwei pi
> > 
> 
> -- 
> zhenwei pi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
