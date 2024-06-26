Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A313D2A4
	for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389309; cv=none; b=mR6sgDV8TQaKYCF/7s9lDZuRCX5m+ZYNELojAHcMPbUfPAlON92Z8rGnY+uis+c1vCjgQpCCPFIGx46kUSc+ABEzL6oFJl56/QAh3wEUbF8YHi5PVpjZ1aRV1GReaK+C6lVGqA8VJ0h5u079u0h+F30cPtWR7VWgMd8bIjO+xqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389309; c=relaxed/simple;
	bh=aB1+MldYvxbQUyxEJjAT0rA/UCaRqalple5w1m/mT74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=il0Cfn9VFTQhMrSsVUY/9bxW+TbLKVyWl/YqQT0LcNNWzWd2A6d1tRnhCuBi40QKO02BoVUUG2AZtfFaDI0IAU0bbwQyC8evWZazpcVbwLlxl+P1PPxY7ZVhjsl/Oe54QSG4KtFgSDoh/2qxw9A7JSONE2uhbJYXQRiodPKCWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IyQwwcQa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyQwwcQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719389305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PW53FOYz+yPifWkSV3hyL5CpnaqaEZC+cPJs4PgCMlI=;
	b=IyQwwcQamz9w1E21Q6fsjv0oMuDD20nJZvAs6yr2/sNIf69B2NH4j4ksIC9GnkO8hwQKvQ
	2I8JW+Ga8+xrf0v6P2BkWbLYegYDli4vasS9huwPgKr8andY6dwd6q6S7rE5w6m3TcHzVW
	nGfmBCIX2Swk2e2qKIZpwcvG4blgijQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-_LeDK9WiMgWIxm6_F4tdqw-1; Wed, 26 Jun 2024 04:08:24 -0400
X-MC-Unique: _LeDK9WiMgWIxm6_F4tdqw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a725eed1cfeso157824966b.3
        for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 01:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719389303; x=1719994103;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PW53FOYz+yPifWkSV3hyL5CpnaqaEZC+cPJs4PgCMlI=;
        b=hXdTUzEffuptDYXKmS92yP2m1XMqAx6KFBomFXCWzGyxfZYg1nHsG3VoWwXV6iVY/c
         km0fVym+8KdE7QWhRhWq+e+H2DqG8FAGCkhpD0s/7tsVp6IuuS3C34UolaTy8yo0w8gk
         eaSs6XQLosNsEiLnIkkbZtX8whdZbOVcUsMCz6RYFB1cCmcJeri4fdFa+MTjaxrv1119
         ee/dqmq/jysUzmWyMpOs09T/yUbiT4CkUGomuTEWZ8oLjFTNjyTBegUs8dK3rhS7tZZL
         GozM/4yVTsnocrrN49owDycuYFBiVgv0QcZ66foU1jgKfN5J3O6Y0Lby0VznR7pCJmRk
         w6Tg==
X-Forwarded-Encrypted: i=1; AJvYcCU1LGzakc7OE0rEWxnEz5rBujdZYk2F7KOLyfpQbe605CC4WO12StIHL+5YIjL6vaTsxi4ChLka9k5ZHDjnomxKoLcp9NdJAEw7Y/Wwzic=
X-Gm-Message-State: AOJu0YxxH168/aGb+etHqPplzi07304q+vSf/6JEHEDx16RJAdqSf5l1
	iPsIj54bIFpmXo2UiLMxMmS58WzxPCmTN1hPEvHZa74iAPu+R0f4MnjbbqxU5rPsjacOi0gz7ml
	SMdh+9dUmz6C8XwFaNfX8DHxREsGn57CL74VchaazNtPr96PUe36b9r0w7PwzXMRK
X-Received: by 2002:a17:907:c086:b0:a72:7a8c:9885 with SMTP id a640c23a62f3a-a727a8c99e1mr289698066b.63.1719389303022;
        Wed, 26 Jun 2024 01:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkDiUAEeUIIWI4V/2yk1zloNYX8tLrrYKgefPnKiD32Vjr1nbW5zF+5Dx25++4nwNrTrXRvA==
X-Received: by 2002:a17:907:c086:b0:a72:7a8c:9885 with SMTP id a640c23a62f3a-a727a8c99e1mr289686266b.63.1719389301203;
        Wed, 26 Jun 2024 01:08:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a70b248e582sm448516966b.59.2024.06.26.01.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:08:20 -0700 (PDT)
Date: Wed, 26 Jun 2024 04:08:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <20240626040730-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
 <1718879494.952194-11-hengqi@linux.alibaba.com>
 <ZnvI2hJXPJZyveAv@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZnvI2hJXPJZyveAv@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jun 26, 2024 at 09:52:58AM +0200, Jiri Pirko wrote:
> Thu, Jun 20, 2024 at 12:31:34PM CEST, hengqi@linux.alibaba.com wrote:
> >On Thu, 20 Jun 2024 06:11:40 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
> >> > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
> >> > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
> >> > > > On Thu, Jun 20, 2024 at 4:21 PM Jason Wang <jasowang@redhat.com> wrote:
> >> > > > >
> >> > > > > On Thu, Jun 20, 2024 at 3:35 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> >> > > > > >
> >> > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> >> > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> >> > > > > > > >
> >> > > > > > > >     /* Parameters for control virtqueue, if any */
> >> > > > > > > >     if (vi->has_cvq) {
> >> > > > > > > > -           callbacks[total_vqs - 1] = NULL;
> >> > > > > > > > +           callbacks[total_vqs - 1] = virtnet_cvq_done;
> >> > > > > > > >             names[total_vqs - 1] = "control";
> >> > > > > > > >     }
> >> > > > > > > >
> >> > > > > > >
> >> > > > > > > If the # of MSIX vectors is exactly for data path VQs,
> >> > > > > > > this will cause irq sharing between VQs which will degrade
> >> > > > > > > performance significantly.
> >> > > > > > >
> >> > > > >
> >> > > > > Why do we need to care about buggy management? I think libvirt has
> >> > > > > been teached to use 2N+2 since the introduction of the multiqueue[1].
> >> > > > 
> >> > > > And Qemu can calculate it correctly automatically since:
> >> > > > 
> >> > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
> >> > > > Author: Jason Wang <jasowang@redhat.com>
> >> > > > Date:   Mon Mar 8 12:49:19 2021 +0800
> >> > > > 
> >> > > >     virtio-net: calculating proper msix vectors on init
> >> > > > 
> >> > > >     Currently, the default msix vectors for virtio-net-pci is 3 which is
> >> > > >     obvious not suitable for multiqueue guest, so we depends on the user
> >> > > >     or management tools to pass a correct vectors parameter. In fact, we
> >> > > >     can simplifying this by calculating the number of vectors on realize.
> >> > > > 
> >> > > >     Consider we have N queues, the number of vectors needed is 2*N + 2
> >> > > >     (#queue pairs + plus one config interrupt and control vq). We didn't
> >> > > >     check whether or not host support control vq because it was added
> >> > > >     unconditionally by qemu to avoid breaking legacy guests such as Minix.
> >> > > > 
> >> > > >     Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
> >> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
> >> > > 
> >> > > Yes, devices designed according to the spec need to reserve an interrupt
> >> > > vector for ctrlq. So, Michael, do we want to be compatible with buggy devices?
> >> > > 
> >> > > Thanks.
> >> > 
> >> > These aren't buggy, the spec allows this. So don't fail, but
> >> > I'm fine with using polling if not enough vectors.
> >> 
> >> sharing with config interrupt is easier code-wise though, FWIW -
> >> we don't need to maintain two code-paths.
> >
> >Yes, it works well - config change irq is used less before - and will not fail.
> 
> Please note I'm working on such fallback for admin queue. I would Like
> to send the patchset by the end of this week. You can then use it easily
> for cvq.
> 
> Something like:
> /* the config->find_vqs() implementation */
> int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>                 struct virtqueue *vqs[], vq_callback_t *callbacks[],
>                 const char * const names[], const bool *ctx,
>                 struct irq_affinity *desc)
> {
>         int err;
> 
>         /* Try MSI-X with one vector per queue. */
>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>                                VP_VQ_VECTOR_POLICY_EACH, ctx, desc);
>         if (!err)
>                 return 0;
>         /* Fallback: MSI-X with one shared vector for config and
>          * slow path queues, one vector per queue for the rest. */
>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>                                VP_VQ_VECTOR_POLICY_SHARED_SLOW, ctx, desc);
>         if (!err)
>                 return 0;
>         /* Fallback: MSI-X with one vector for config, one shared for queues. */
>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>                                VP_VQ_VECTOR_POLICY_SHARED, ctx, desc);
>         if (!err)
>                 return 0;
>         /* Is there an interrupt? If not give up. */
>         if (!(to_vp_device(vdev)->pci_dev->irq))
>                 return err;
>         /* Finally fall back to regular interrupts. */
>         return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
> }
> 
> 


Well for cvq, we'll need to adjust the API so core
knows cvq interrupts are be shared with config not
datapath.



> 
> >
> >Thanks.
> >
> >> 
> >> > > > 
> >> > > > Thanks
> >> > > > 
> >> > > > >
> >> > > > > > > So no, you can not just do it unconditionally.
> >> > > > > > >
> >> > > > > > > The correct fix probably requires virtio core/API extensions.
> >> > > > > >
> >> > > > > > If the introduction of cvq irq causes interrupts to become shared, then
> >> > > > > > ctrlq need to fall back to polling mode and keep the status quo.
> >> > > > >
> >> > > > > Having to path sounds a burden.
> >> > > > >
> >> > > > > >
> >> > > > > > Thanks.
> >> > > > > >
> >> > > > >
> >> > > > >
> >> > > > > Thanks
> >> > > > >
> >> > > > > [1] https://www.linux-kvm.org/page/Multiqueue
> >> > > > >
> >> > > > > > >
> >> > > > > > > --
> >> > > > > > > MST
> >> > > > > > >
> >> > > > > >
> >> > > > 
> >> 
> >

