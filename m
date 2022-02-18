Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6112BC433FE
	for <virtualization@archiver.kernel.org>; Fri, 18 Feb 2022 09:25:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E815D83F26;
	Fri, 18 Feb 2022 09:25:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Di4PwpD6DegK; Fri, 18 Feb 2022 09:25:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6412083EA1;
	Fri, 18 Feb 2022 09:25:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3238BC0011;
	Fri, 18 Feb 2022 09:25:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00F5EC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 09:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4A0140184
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 09:25:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RliH_xIW6S2c
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 09:25:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3729440147
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645176306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vd+QhoWwJYG1HL/F/mwaSFG+AvH7Lx3prSPJQjg2n70=;
 b=PDVQbWTvEaGyV4uSXw2Rn1/FBwfVxU7iz/+v2hPsALbH/NUv1hfvQ+7SdIfIpe8M2Pvh3O
 gV9ggnkX+LCJMx2sHKAq0BENuBEwdHZcx9q3RPg7K3bJa8GZn+2mOtIQzSPYvtJTFcMVKp
 PyPYvC5h4UZil4Yu0uRsn5YE5i856+M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-P4t3itUoO8eXCjAQ1KOYZA-1; Fri, 18 Feb 2022 04:25:05 -0500
X-MC-Unique: P4t3itUoO8eXCjAQ1KOYZA-1
Received: by mail-wm1-f71.google.com with SMTP id
 ay41-20020a05600c1e2900b0037c5168b3c4so5660234wmb.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 01:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Vd+QhoWwJYG1HL/F/mwaSFG+AvH7Lx3prSPJQjg2n70=;
 b=GaJQQ/vDUr7xGoMggHClRJLA47OEjBXd/2jB3HZOWUKtvS+YTcErWHoZ9aa/nP/fSn
 DSr9OX3lzB8XAhn0jDerGey8YKjbPtQRR4cVsI1Mo3LfQZAGRYXPmT6jwN0jeiqbtpRT
 IziHZMg9yUnYandLnGQAvqtjBiRBYMMCo5isDlYV/FBJ8d/HtGwtm7ymvJbjjJlM0ZCy
 Ar+VFSr+Z6yHTOBDFeDKmafGQR2FNuoxmOc0AXH0vpRqYMwYqgcGrPKzpAr4AZtdzi+c
 6QDTVIQh2kvq7pwSkVLstajBdPgNIU1Dc9oQoYp9vALswHhOuwQ/01J+KnSPKxulVZMY
 dZQQ==
X-Gm-Message-State: AOAM530Z4YyZgc+Td9wZSHKOF0wfdJgJDx/zohHKrkvylp9MmfIjO55O
 GqTe3gywH0pV78gI2v/5dg9rx4/9F/qWM4S0OEm/pe0axped1ehIlVw4x4Su9Ic5b7guEqpHVBa
 Ut/Vrdc5boLz8DmTGbeYMenLDOx5WXHqdavY83qTs9g==
X-Received: by 2002:a05:6000:18aa:b0:1e8:5dda:c340 with SMTP id
 b10-20020a05600018aa00b001e85ddac340mr5141631wri.677.1645176304251; 
 Fri, 18 Feb 2022 01:25:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQ0U/Gu007TAIgzQ2TC/XBKA9PFdYgU/5XpmCVEv8o3L0Hu0A8zZpOZTZLdaXTL2ej5hVbSA==
X-Received: by 2002:a05:6000:18aa:b0:1e8:5dda:c340 with SMTP id
 b10-20020a05600018aa00b001e85ddac340mr5141618wri.677.1645176304017; 
 Fri, 18 Feb 2022 01:25:04 -0800 (PST)
Received: from redhat.com ([2.55.156.211])
 by smtp.gmail.com with ESMTPSA id e4sm20827564wrp.25.2022.02.18.01.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Feb 2022 01:25:03 -0800 (PST)
Date: Fri, 18 Feb 2022 04:24:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1 0/6] virtio: support advance DMA
Message-ID: <20220218041948-mutt-send-email-mst@kernel.org>
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtE+Bcdru43F5dOkMO1kDhUe19gKwaN4FqkztTCRXSjmw@mail.gmail.com>
 <1645174523.8877885-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1645174523.8877885-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

On Fri, Feb 18, 2022 at 04:55:23PM +0800, Xuan Zhuo wrote:
> On Thu, 17 Feb 2022 15:19:44 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Thu, Feb 10, 2022 at 4:51 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > virtqueue_add() only supports virtual addresses, dma is completed in
> > > virtqueue_add().
> > >
> > > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > > it is necessary for us to support passing the DMA address to virtqueue_add().
> >
> > I'd suggest rename this feature as "unmanaged DMA".
> 
> OK

IIUC when you say "dma is completed" you really mean "memory is mapped
for dma". What is special is that virtio suddenly gets s/g that is
already mapped for DMA, not in the way DMA (direct memory access) itself
happens. right? Pls document as such.
And this is why I'd call this flag "mapped" or "premapped", not
"predma". "unmanaged" is also ok, though it's a bit vague wrt what
exactly is managed.
I'll defer to Jason on this.  Jason what do you prefer?

> >
> > >
> > > Record this predma information in extra->flags, which can be skipped when
> > > executing dma unmap.
> >
> > Question still, can we use per-virtqueue flag instead of per
> > descriptor flag? If my memory is correct, the answer is yes in the
> > discussion for the previous version.
> >
> 
> Yes.
> 
> per-virtqueue? I guess it should be per-submit.
> 
> This patch set only adds a flag to desc_extra[head].flags, so that we can know
> if we need to unmap dma when we detach.
> 
> Thanks.
> 
> > Thanks
> >
> > >
> > > v1:
> > >    1. All sgs requested at one time are required to be unified PREDMA, and several
> > >       of them are not supported to be PREDMA
> > >    2. virtio_dma_map() is removed from this patch set and will be submitted
> > >       together with the next time AF_XDP supports virtio dma
> > >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> > >       indirect desc
> > >
> > > Xuan Zhuo (6):
> > >   virtio: rename vring_unmap_state_packed() to
> > >     vring_unmap_extra_packed()
> > >   virtio: remove flags check for unmap split indirect desc
> > >   virtio: remove flags check for unmap packed indirect desc
> > >   virtio: virtqueue_add() support predma
> > >   virtio: split: virtqueue_add_split() support dma address
> > >   virtio: packed: virtqueue_add_packed() support dma address
> > >
> > >  drivers/virtio/virtio_ring.c | 199 ++++++++++++++++++++++-------------
> > >  1 file changed, 126 insertions(+), 73 deletions(-)
> > >
> > > --
> > > 2.31.0
> > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
