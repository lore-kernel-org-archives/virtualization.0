Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935EC15F308
	for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395899; cv=none; b=FbDZ72+FEUjbBqpWOa23J2Bu2w38wlY8mAbHmwPSaOgjGTWCmkMVeOdk70pGSgXNEED9hEwOCmT9UVkIE7+p0eOBW3LCYKv4Rw1WWb2cSEooBSujKMTg1OXY0ulhg3QxgqHSWN7In8Q9MB6DB78PQudnFQLXmeUGyPrOHW8O8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395899; c=relaxed/simple;
	bh=x16jpfiapiMAOFClAby3zt13IuO15RnTDjRTyItCQcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=A/22qVynqD/yiBFGiddqdMAE4Z+JN0vyqc2GMIbNUejgeDCDiGibWeHDejnis8It8bCDOOQ9eQJ+Y2bhvLZcVQQRy0jxdH3nILJQ6AH5Tt5eQh576anjMhNcIZX0ylrTzhizLK2010Ik8dRTpZ5Pw8bvjnyLi3x0543/1pNzfyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPJk8Pqu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPJk8Pqu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719395896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoXQutb3rkAKNU8JON+XNG0X1+QCCt1nv365VnOUFAw=;
	b=CPJk8PquMC28BZ0Cc6+FHH5c1K4ek+GZn8OS7kNQd3k4e2TSpFR6UeI+oxwK8+okrbooOZ
	xBqJSQtzdH+rXiRp8d5eqmWNGQUfDuJtFLRUbUKMHjBK/tb6pUykozrMnG/1KA5gV8VUim
	kD3ecjycgcrK5vI8jq3h+klrVUxbeYw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-l6J4OgbhMrKonjjcZ6gZEA-1; Wed, 26 Jun 2024 05:58:14 -0400
X-MC-Unique: l6J4OgbhMrKonjjcZ6gZEA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a728beeb805so40357366b.0
        for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 02:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395894; x=1720000694;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoXQutb3rkAKNU8JON+XNG0X1+QCCt1nv365VnOUFAw=;
        b=JkidMzfF8Xyb/5aj4/zPWhtW1vntkC3B12DvqME5SbGBjINsOQbQE/BHCDOwLkAsmW
         CBqI8potm4ayaEb0QscYGFFGg4qLfhISr54KQgr6QDkPICjeM5Fw6qEUxjsNzhuBb/sn
         XJ5kBrEhmfchWjO/9iGVTQefasDMI6kXyyyyiAoBXpW4t0WFzkvvvzMgagQ5f6lVVhUM
         MgQcg7Z5JrgM5gpuEIHZ3IyOVgpIjnakRxwqUbcmBWJuSSAVMUKNRU2338o73rMBLlHA
         Z5N3BL/wY3SkDX9tZXasRqbHc8eOdy5plTJep8l+4JLe2MQLbRNWENnRO2OI00l5grB+
         OuhA==
X-Forwarded-Encrypted: i=1; AJvYcCXc43w1ZAfPMnSEUZNSSSypdTj1oyxSIYsrf4k/4Cfa5hHJayl/B+whGBBn5MU48WAqMmhamxpm0PzGxPk1TShm/L09OsoU3iTkeu3aEGQ=
X-Gm-Message-State: AOJu0Yz1h0lC0nSyJ0Tkw9ZZ6354NBzQiAL4uR07BjqMxq/GeW7gyef+
	ENXfDxhiN0qV2ehFpbl+yZTqHlfUfTo6mnIbotMjbVNGXb9DmX92fT8m44K7R0Ax99MkgaFRFF3
	rdWNJnijqBInYrwFwyGDdnpBvDE6MSDtpPcejstEd/Sl3GbSoFcHO834pnQ7OZwDx
X-Received: by 2002:a17:907:a602:b0:a72:84c9:cedc with SMTP id a640c23a62f3a-a7284c9d5a3mr166020766b.8.1719395893554;
        Wed, 26 Jun 2024 02:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9h0Wqhv5wIiLtdVLt5PHEEm3ReeN8olewjUx+l/KHU8JGw2sxnSWEzV2m/Mu/ti31gj/ISw==
X-Received: by 2002:a17:907:a602:b0:a72:84c9:cedc with SMTP id a640c23a62f3a-a7284c9d5a3mr166017866b.8.1719395892700;
        Wed, 26 Jun 2024 02:58:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a726627e0dcsm187428066b.62.2024.06.26.02.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:58:12 -0700 (PDT)
Date: Wed, 26 Jun 2024 05:58:08 -0400
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
Message-ID: <20240626045313-mutt-send-email-mst@kernel.org>
References: <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
 <1718879494.952194-11-hengqi@linux.alibaba.com>
 <ZnvI2hJXPJZyveAv@nanopsycho.orion>
 <20240626040730-mutt-send-email-mst@kernel.org>
 <ZnvUn-Kq4Al0nMQZ@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZnvUn-Kq4Al0nMQZ@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jun 26, 2024 at 10:43:11AM +0200, Jiri Pirko wrote:
> Wed, Jun 26, 2024 at 10:08:14AM CEST, mst@redhat.com wrote:
> >On Wed, Jun 26, 2024 at 09:52:58AM +0200, Jiri Pirko wrote:
> >> Thu, Jun 20, 2024 at 12:31:34PM CEST, hengqi@linux.alibaba.com wrote:
> >> >On Thu, 20 Jun 2024 06:11:40 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
> >> >> > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
> >> >> > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
> >> >> > > > On Thu, Jun 20, 2024 at 4:21 PM Jason Wang <jasowang@redhat.com> wrote:
> >> >> > > > >
> >> >> > > > > On Thu, Jun 20, 2024 at 3:35 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> >> >> > > > > >
> >> >> > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> >> >> > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> >> >> > > > > > > >
> >> >> > > > > > > >     /* Parameters for control virtqueue, if any */
> >> >> > > > > > > >     if (vi->has_cvq) {
> >> >> > > > > > > > -           callbacks[total_vqs - 1] = NULL;
> >> >> > > > > > > > +           callbacks[total_vqs - 1] = virtnet_cvq_done;
> >> >> > > > > > > >             names[total_vqs - 1] = "control";
> >> >> > > > > > > >     }
> >> >> > > > > > > >
> >> >> > > > > > >
> >> >> > > > > > > If the # of MSIX vectors is exactly for data path VQs,
> >> >> > > > > > > this will cause irq sharing between VQs which will degrade
> >> >> > > > > > > performance significantly.
> >> >> > > > > > >
> >> >> > > > >
> >> >> > > > > Why do we need to care about buggy management? I think libvirt has
> >> >> > > > > been teached to use 2N+2 since the introduction of the multiqueue[1].
> >> >> > > > 
> >> >> > > > And Qemu can calculate it correctly automatically since:
> >> >> > > > 
> >> >> > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
> >> >> > > > Author: Jason Wang <jasowang@redhat.com>
> >> >> > > > Date:   Mon Mar 8 12:49:19 2021 +0800
> >> >> > > > 
> >> >> > > >     virtio-net: calculating proper msix vectors on init
> >> >> > > > 
> >> >> > > >     Currently, the default msix vectors for virtio-net-pci is 3 which is
> >> >> > > >     obvious not suitable for multiqueue guest, so we depends on the user
> >> >> > > >     or management tools to pass a correct vectors parameter. In fact, we
> >> >> > > >     can simplifying this by calculating the number of vectors on realize.
> >> >> > > > 
> >> >> > > >     Consider we have N queues, the number of vectors needed is 2*N + 2
> >> >> > > >     (#queue pairs + plus one config interrupt and control vq). We didn't
> >> >> > > >     check whether or not host support control vq because it was added
> >> >> > > >     unconditionally by qemu to avoid breaking legacy guests such as Minix.
> >> >> > > > 
> >> >> > > >     Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
> >> >> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >> >> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> >> > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
> >> >> > > 
> >> >> > > Yes, devices designed according to the spec need to reserve an interrupt
> >> >> > > vector for ctrlq. So, Michael, do we want to be compatible with buggy devices?
> >> >> > > 
> >> >> > > Thanks.
> >> >> > 
> >> >> > These aren't buggy, the spec allows this. So don't fail, but
> >> >> > I'm fine with using polling if not enough vectors.
> >> >> 
> >> >> sharing with config interrupt is easier code-wise though, FWIW -
> >> >> we don't need to maintain two code-paths.
> >> >
> >> >Yes, it works well - config change irq is used less before - and will not fail.
> >> 
> >> Please note I'm working on such fallback for admin queue. I would Like
> >> to send the patchset by the end of this week. You can then use it easily
> >> for cvq.
> >> 
> >> Something like:
> >> /* the config->find_vqs() implementation */
> >> int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> >>                 struct virtqueue *vqs[], vq_callback_t *callbacks[],
> >>                 const char * const names[], const bool *ctx,
> >>                 struct irq_affinity *desc)
> >> {
> >>         int err;
> >> 
> >>         /* Try MSI-X with one vector per queue. */
> >>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
> >>                                VP_VQ_VECTOR_POLICY_EACH, ctx, desc);
> >>         if (!err)
> >>                 return 0;
> >>         /* Fallback: MSI-X with one shared vector for config and
> >>          * slow path queues, one vector per queue for the rest. */
> >>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
> >>                                VP_VQ_VECTOR_POLICY_SHARED_SLOW, ctx, desc);
> >>         if (!err)
> >>                 return 0;
> >>         /* Fallback: MSI-X with one vector for config, one shared for queues. */
> >>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
> >>                                VP_VQ_VECTOR_POLICY_SHARED, ctx, desc);
> >>         if (!err)
> >>                 return 0;
> >>         /* Is there an interrupt? If not give up. */
> >>         if (!(to_vp_device(vdev)->pci_dev->irq))
> >>                 return err;
> >>         /* Finally fall back to regular interrupts. */
> >>         return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
> >> }
> >> 
> >> 
> >
> >
> >Well for cvq, we'll need to adjust the API so core
> >knows cvq interrupts are be shared with config not
> >datapath.
> 
> Agreed. I was thinking about introducing some info struct and pass array
> of it instead of callbacks[] and names[]. Then the struct can contain
> flag indication. Something like:
> 
> struct vq_info {
> 	vq_callback_t *callback;
> 	const char *name;
> 	bool slow_path;
> };
> 

Yes. Add ctx too? There were attempts at it already btw.


> >
> >
> >
> >> 
> >> >
> >> >Thanks.
> >> >
> >> >> 
> >> >> > > > 
> >> >> > > > Thanks
> >> >> > > > 
> >> >> > > > >
> >> >> > > > > > > So no, you can not just do it unconditionally.
> >> >> > > > > > >
> >> >> > > > > > > The correct fix probably requires virtio core/API extensions.
> >> >> > > > > >
> >> >> > > > > > If the introduction of cvq irq causes interrupts to become shared, then
> >> >> > > > > > ctrlq need to fall back to polling mode and keep the status quo.
> >> >> > > > >
> >> >> > > > > Having to path sounds a burden.
> >> >> > > > >
> >> >> > > > > >
> >> >> > > > > > Thanks.
> >> >> > > > > >
> >> >> > > > >
> >> >> > > > >
> >> >> > > > > Thanks
> >> >> > > > >
> >> >> > > > > [1] https://www.linux-kvm.org/page/Multiqueue
> >> >> > > > >
> >> >> > > > > > >
> >> >> > > > > > > --
> >> >> > > > > > > MST
> >> >> > > > > > >
> >> >> > > > > >
> >> >> > > > 
> >> >> 
> >> >
> >

