Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD4146D71
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299687; cv=none; b=jaH8VuUQjhPYjEGew0wZQO555Km6iynnwhSqJromgyNooq2+8atK0G43DdDX8qoCnacsXKMcgBbfq1Dn/trfqxPCvzR/b7iOrHwEFe9N1TbYkwW7GK5ViGsYRrpgZX4gcI3MLstohCj39GFFFXjAFNjVuXm3JcvoGkqrJNK+1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299687; c=relaxed/simple;
	bh=MWlI6gqiKW7AFxrW0jW8foQWqr6Sk9txhhHrr4oyi4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fYlqV3XSt4qBaRWR4zlJjrCaogPVC9x6ivxWGxsF7yD/iU6LaJi1rpnXYUv2S0tvod7xczYVoHA/8J1kLazTuNwkXVTq69MdhryVNJCBfRqAIn9oh38X+RNYwc6lu0ZCq0M12EgbWnfXNHahBKEWlFLu7mEa8ClT0tAAGKfojkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fk/JV14k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fk/JV14k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719299685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LebRXIKKc2SwfP9sV4lCluk07RoQVB0AjJsteCADcZk=;
	b=Fk/JV14kReAaZOGRmOrvxMdyssbm7FLISruB0P6va5/NCz8moClJJYsQO2jEUq0F8vJn4m
	j/+cJLD/0Zq6J66JwnvUlM31mUbO+7YObCmTbKM+3WM14bl3DVNOq+Xq/Q1EDvHL8V5lIY
	MHrvkO/95D6cCdDtI7Blf42KiDpOIEw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-V_HlZ7VgNHa7bs8fGMmOiA-1; Tue, 25 Jun 2024 03:14:40 -0400
X-MC-Unique: V_HlZ7VgNHa7bs8fGMmOiA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-365dca90118so1967921f8f.0
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 00:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299679; x=1719904479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LebRXIKKc2SwfP9sV4lCluk07RoQVB0AjJsteCADcZk=;
        b=Wu6q1Ds87GqdDhVnJ12v4TfyqTWMJEVlY3xwuEbbZ2CeQ2mMfLEe8TXfzx2jvztwqN
         4tcuD5zOa+3NgYkYLEtkanokhCbdnhRHtTQl0K8w7oFBkAut0oTDmrl8SEBfbJ5rKxZR
         x9z0cJEIGv8OoAgt9l7b///9p6E81emv/jKJKy8USA95kHbPU8i513e78QV9VQZcKzVW
         aAKp9g24y2aw542algeDGLk0psk0qn050NTFhB98V12DqlPF1+PaeVkDE5iUwh6RqFNg
         Eh0hcfpNYp/1sYC7xhJsph942D5iNhcmnIk7QmHGIrbt9HJlIV5sg/DPP6k/RhbFaaKd
         Y7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXffHVQgU2P+bhsOud9QqyBdA2M1rIbkjRAGjO0clvMFx/zG6YyMKi94jn8Oxek7pEy/U4xAGAA/JJgTmYm/V+8UYJ4z5QR2QJysI6rJNM=
X-Gm-Message-State: AOJu0YwILLehdWJnxJ3pawc59MwhI9myGuELhVqw9YMobBXOQ/717xsx
	TZcqZ24RLfPflZvdlIV4S+GeiUGFxliHuTSOI1L+n+aUF3yBSx0lJN1R2Tp3fAK1xWVzQv4t3QS
	EX5p277+CDp0qoK/FT9CRTuqHyHLmqXQclIIaEoHukl2DADeBLsVTNaUJRmbMNWrr
X-Received: by 2002:adf:fa8e:0:b0:362:8749:9639 with SMTP id ffacd0b85a97d-366e7a373f4mr4713215f8f.35.1719299679069;
        Tue, 25 Jun 2024 00:14:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+RQabaVT0BHWxAQBLc5MihkozylBrOdUtM3UiHMV0ATZoGWoxlVaHU25AglTEOaxNsvlKQw==
X-Received: by 2002:adf:fa8e:0:b0:362:8749:9639 with SMTP id ffacd0b85a97d-366e7a373f4mr4713186f8f.35.1719299678279;
        Tue, 25 Jun 2024 00:14:38 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:f72:b8c7:9fc2:4c8b:feb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b861bsm11976184f8f.29.2024.06.25.00.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:14:37 -0700 (PDT)
Date: Tue, 25 Jun 2024 03:14:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <20240625031153-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
 <CACGkMEtacpgHvD7GLysXWm7_CybhgyJYx=AMAX+jk6+G4wqW8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtacpgHvD7GLysXWm7_CybhgyJYx=AMAX+jk6+G4wqW8Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 25, 2024 at 09:27:24AM +0800, Jason Wang wrote:
> On Thu, Jun 20, 2024 at 6:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
> > > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > On Thu, Jun 20, 2024 at 4:21 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 20, 2024 at 3:35 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > > > > > >
> > > > > > > > >     /* Parameters for control virtqueue, if any */
> > > > > > > > >     if (vi->has_cvq) {
> > > > > > > > > -           callbacks[total_vqs - 1] = NULL;
> > > > > > > > > +           callbacks[total_vqs - 1] = virtnet_cvq_done;
> > > > > > > > >             names[total_vqs - 1] = "control";
> > > > > > > > >     }
> > > > > > > > >
> > > > > > > >
> > > > > > > > If the # of MSIX vectors is exactly for data path VQs,
> > > > > > > > this will cause irq sharing between VQs which will degrade
> > > > > > > > performance significantly.
> > > > > > > >
> > > > > >
> > > > > > Why do we need to care about buggy management? I think libvirt has
> > > > > > been teached to use 2N+2 since the introduction of the multiqueue[1].
> > > > >
> > > > > And Qemu can calculate it correctly automatically since:
> > > > >
> > > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
> > > > > Author: Jason Wang <jasowang@redhat.com>
> > > > > Date:   Mon Mar 8 12:49:19 2021 +0800
> > > > >
> > > > >     virtio-net: calculating proper msix vectors on init
> > > > >
> > > > >     Currently, the default msix vectors for virtio-net-pci is 3 which is
> > > > >     obvious not suitable for multiqueue guest, so we depends on the user
> > > > >     or management tools to pass a correct vectors parameter. In fact, we
> > > > >     can simplifying this by calculating the number of vectors on realize.
> > > > >
> > > > >     Consider we have N queues, the number of vectors needed is 2*N + 2
> > > > >     (#queue pairs + plus one config interrupt and control vq). We didn't
> > > > >     check whether or not host support control vq because it was added
> > > > >     unconditionally by qemu to avoid breaking legacy guests such as Minix.
> > > > >
> > > > >     Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
> > > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > >
> > > > Yes, devices designed according to the spec need to reserve an interrupt
> > > > vector for ctrlq. So, Michael, do we want to be compatible with buggy devices?
> > > >
> > > > Thanks.
> > >
> > > These aren't buggy, the spec allows this.
> 
> So it doesn't differ from the case when we are lacking sufficient msix
> vectors in the case of multiqueue. In that case we just fallback to
> share one msix for all queues and another for config and we don't
> bother at that time.

sharing queues is exactly "bothering".

> Any reason to bother now?
> 
> Thanks

This patch can make datapath slower for such configs by switching to
sharing msix for a control path benefit. Not a tradeoff many users want
to make.


> > >  So don't fail, but
> > > I'm fine with using polling if not enough vectors.
> >
> > sharing with config interrupt is easier code-wise though, FWIW -
> > we don't need to maintain two code-paths.
> >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > > > So no, you can not just do it unconditionally.
> > > > > > > >
> > > > > > > > The correct fix probably requires virtio core/API extensions.
> > > > > > >
> > > > > > > If the introduction of cvq irq causes interrupts to become shared, then
> > > > > > > ctrlq need to fall back to polling mode and keep the status quo.
> > > > > >
> > > > > > Having to path sounds a burden.
> > > > > >
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > [1] https://www.linux-kvm.org/page/Multiqueue
> > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > MST
> > > > > > > >
> > > > > > >
> > > > >
> >

