Return-Path: <SRS0=Tn2H=KJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C9DC43461
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 11:36:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB75861404
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 11:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB75861404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3E088444E;
	Fri, 14 May 2021 11:36:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R9UuwGLBGipq; Fri, 14 May 2021 11:36:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F8E7842BE;
	Fri, 14 May 2021 11:36:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEC7DC000D;
	Fri, 14 May 2021 11:36:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E98EC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 11:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76F3A40162
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 11:36:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XyaKd2Hi6gri
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 11:36:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C74E4011D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 11:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620992179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mIcQUlsHB9GjnPE2QvhbTigpY+9TcUPrmrRb1c8BGPY=;
 b=BhKsNEpaDK/ku6xyrloGUDQklDGReeydD0UKcJ23Sh+TpfpyKGA/4GGrXwHS7Jv8oaCE3U
 f5Yev2vA2oW+wu0cXtQUBHXv4Lty7XUwhZWJnPxiX1OlAYMkL6gMQtRd5Ex/lLIjn0dwZV
 ReXMEC9lwUPe4jiVuR9znD3gizPIsaA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-5FqpViFPMCKjiLOZmninRw-1; Fri, 14 May 2021 07:36:17 -0400
X-MC-Unique: 5FqpViFPMCKjiLOZmninRw-1
Received: by mail-wr1-f70.google.com with SMTP id
 i102-20020adf90ef0000b029010dfcfc46c0so12649976wri.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 04:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mIcQUlsHB9GjnPE2QvhbTigpY+9TcUPrmrRb1c8BGPY=;
 b=iw6NSRA3FSpcD6Shb8mqjsn+WV8nNM55GrY2kQ+5ZrEzYl0jDmrrYfl51ws+bxN15h
 Nz+CjokE5kBNxHgjFHoXQ0qO9f1zY15v3Sgyx8RBAZNGz+6dxMwvvz+OJy9yj3cimeJP
 399GNgDnUZGePPb3PHDpEpYgMKokS305uFPZd6MDYR7uLqV8G282zHiomP1yAlEqa2ri
 kQyOjlhechHnITghRcZcMZP6wSZ6z0/YZsGxd94/jyHMIyUEQsW+3js0bkmN60q9RCyr
 9hhtWlIIikWBmO51UDARZJhBRe9OA2eevRvfx1KdrsIS10F+W9rfP3DgAoAwU1UNXe8Q
 xMRg==
X-Gm-Message-State: AOAM53219AmVi3Y+OxVqg1xOlbZvI/RHl+UovUKaeM4O7dNo4tzHv6dM
 qarTw34UDlDmEgWRS9RYKvIGy1BiYvjKgphB6cw4A9U1lkCnVx2gU8APHIK1FOlIoA+h4CkEkTN
 ddwp80fwpd/mfxcca52Gi/rJzXsjsM7QjTJfbCk6Ixw==
X-Received: by 2002:adf:e991:: with SMTP id h17mr13348560wrm.265.1620992176519; 
 Fri, 14 May 2021 04:36:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkheG6+9wAfmTav7j8nkCGClt/d84UwVpHJTyKDfom/4CboPHupI3U474RxUhnHPIO1Tj/hw==
X-Received: by 2002:adf:e991:: with SMTP id h17mr13348540wrm.265.1620992176305; 
 Fri, 14 May 2021 04:36:16 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
 by smtp.gmail.com with ESMTPSA id t7sm4707wrs.87.2021.05.14.04.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 May 2021 04:36:15 -0700 (PDT)
Date: Fri, 14 May 2021 07:36:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
Message-ID: <20210514073452-mutt-send-email-mst@kernel.org>
References: <20210423080942.2997-1-jasowang@redhat.com>
 <YJ1TgoFSwOkQrC+1@stefanha-x1.localdomain>
 <CACGkMEv0uWd+X87cYoG-GGjTXBvRztp2CY3RKyq9jFbSYK1n0Q@mail.gmail.com>
 <YJ5cKe0egklXDpng@stefanha-x1.localdomain>
 <CACycT3u+hQbDJtf5gxS1NVVpiTffMz1skuhTExy5d_oRjYKoxg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3u+hQbDJtf5gxS1NVVpiTffMz1skuhTExy5d_oRjYKoxg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de, kvm <kvm@vger.kernel.org>,
 konrad.wilk@oracle.com, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Stefan Hajnoczi <stefanha@redhat.com>
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

On Fri, May 14, 2021 at 07:27:22PM +0800, Yongji Xie wrote:
> On Fri, May 14, 2021 at 7:17 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > On Fri, May 14, 2021 at 03:29:20PM +0800, Jason Wang wrote:
> > > On Fri, May 14, 2021 at 12:27 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > >
> > > > On Fri, Apr 23, 2021 at 04:09:35PM +0800, Jason Wang wrote:
> > > > > Sometimes, the driver doesn't trust the device. This is usually
> > > > > happens for the encrtpyed VM or VDUSE[1].
> > > >
> > > > Thanks for doing this.
> > > >
> > > > Can you describe the overall memory safety model that virtio drivers
> > > > must follow?
> > >
> > > My understanding is that, basically the driver should not trust the
> > > device (since the driver doesn't know what kind of device that it
> > > tries to drive)
> > >
> > > 1) For any read only metadata (required at the spec level) which is
> > > mapped as coherent, driver should not depend on the metadata that is
> > > stored in a place that could be wrote by the device. This is what this
> > > series tries to achieve.
> > > 2) For other metadata that is produced by the device, need to make
> > > sure there's no malicious device triggered behavior, this is somehow
> > > similar to what vhost did. No DOS, loop, kernel bug and other stuffs.
> > > 3) swiotb is a must to enforce memory access isolation. (VDUSE or encrypted VM)
> > >
> > > > For example:
> > > >
> > > > - Driver-to-device buffers must be on dedicated pages to avoid
> > > >   information leaks.
> > >
> > > It looks to me if swiotlb is used, we don't need this since the
> > > bouncing is not done at byte not page.
> > >
> > > But if swiotlb is not used, we need to enforce this.
> > >
> > > >
> > > > - Driver-to-device buffers must be on dedicated pages to avoid memory
> > > >   corruption.
> > >
> > > Similar to the above.
> > >
> > > >
> > > > When I say "pages" I guess it's the IOMMU page size that matters?
> > > >
> > >
> > > And the IOTLB page size.
> > >
> > > > What is the memory access granularity of VDUSE?
> > >
> > > It has an swiotlb, but the access and bouncing is done per byte.
> > >
> > > >
> > > > I'm asking these questions because there is driver code that exposes
> > > > kernel memory to the device and I'm not sure it's safe. For example:
> > > >
> > > >   static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
> > > >                   struct scatterlist *data_sg, bool have_data)
> > > >   {
> > > >           struct scatterlist hdr, status, *sgs[3];
> > > >           unsigned int num_out = 0, num_in = 0;
> > > >
> > > >           sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
> > > >                             ^^^^^^^^^^^^^
> > > >           sgs[num_out++] = &hdr;
> > > >
> > > >           if (have_data) {
> > > >                   if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
> > > >                           sgs[num_out++] = data_sg;
> > > >                   else
> > > >                           sgs[num_out + num_in++] = data_sg;
> > > >           }
> > > >
> > > >           sg_init_one(&status, &vbr->status, sizeof(vbr->status));
> > > >                                ^^^^^^^^^^^^
> > > >           sgs[num_out + num_in++] = &status;
> > > >
> > > >           return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
> > > >   }
> > > >
> > > > I guess the drivers don't need to be modified as long as swiotlb is used
> > > > to bounce the buffers through "insecure" memory so that the memory
> > > > surrounding the buffers is not exposed?
> > >
> > > Yes, swiotlb won't bounce the whole page. So I think it's safe.
> >
> > Thanks Jason and Yongji Xie for clarifying. Seems like swiotlb or a
> > similar mechanism can handle byte-granularity isolation so the drivers
> > not need to worry about information leaks or memory corruption outside
> > the mapped byte range.
> >
> > We still need to audit virtio guest drivers to ensure they don't trust
> > data that can be modified by the device. I will look at virtio-blk and
> > virtio-fs next week.
> >
> 
> Oh, that's great. Thank you!
> 
> I also did some audit work these days and will send a new version for
> reviewing next Monday.
> 
> Thanks,
> Yongji

Doing it in a way that won't hurt performance for simple
configs that trust the device is a challenge though.
Pls take a look at the discussion with Christoph for some ideas
on how to do this.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
