Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83DC15F316
	for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391399; cv=none; b=J9qdEcrmrJ8cc9SVN0GPmX/Pb8jfW1WS//R33K5pzbbUpjNalhzT9z3JipoF7a3+pX5iJjQ2ooa3EQOJKUjtCX5AIjGsg3E7xUEWREvl52g85kbH9YoywQ5ASURZlbD1B7+9H2AFlwTAJtSXRVlTEBddRAw+ZlyrGWr9qD6vFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391399; c=relaxed/simple;
	bh=C2ox0KqbefqgIcR1h5oqnPkIXq4UGVS9kbaYWQ6dfb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRUybNAXwW1+Fv0aVr6o+bsqKjKRGniIE8CG6Qqj4F/366Z/JwjUOly13MwRPLeI4n/E2KHIiKppzTEpFRKiAVxg1MCA9rKolVKWSMbIKu7gNmKAu7RMHYQikS+8YbqLy4XzTxcRXNk71G8YQkZ1sxgAoT+KhyLH41Inqa3NPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZxCDMVvj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZxCDMVvj"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4247f36f689so44695155e9.1
        for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719391395; x=1719996195; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+vu6CAngNKGlbKo6gG6ckEU4iEDVbJhe6KmDGwESUxA=;
        b=ZxCDMVvjuaaorG/lz1uoY/9NYkAkamYnnn0BGITklP87cTI8Q//X6fSHxZrI+xp0Xr
         bPPVTEdrAK/IW6O319NPWnH/oooOUc8E+5DC5MeKf1NhNgiZRc75mWLGhBtWTFL40FaU
         YjKoxvrpRUQ5cb4OWY+MfzCr6J/Q/7mjyILLafrbTrhz94JjQlnrpudhj46nYg6uEU3Q
         wuAJU4YR3w7QsFpnBs/m5kITiC1fQ2PX9yr46yUvq/hx+35E3o0lTkE11VvNpBA24ixp
         ibbxz1uTLcYJoLLZHilKYC1F4BTVhHRYMQALlaOuNUdVr6uZBHe0Qftr1jqqZtN0mMwo
         aQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391395; x=1719996195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vu6CAngNKGlbKo6gG6ckEU4iEDVbJhe6KmDGwESUxA=;
        b=IQpQy9uw5QUlzeFS/5q0+CkuFPyannss/5O0Ub+nPUvYYmMJzZMLxPzfLF5+dSh+dP
         1rVgK+OGKGgrCZFPJogr4rd6eTZgvzl21vQWIeF4l6/lNxPis4L4kwWPJs/dSt+Gc9Tr
         9EmszRBsr3hJpsskaF5aZyDB6xaxaB9gwlZTXfI5YjDxacodeEq14qY1j2INg/6mRZpn
         08jy0pqwyC0fMqGgHsdmso8uixp8dF33YIabQZShzXJ0KqmdL2Y52cnOL+UXakbKis9N
         D54L8Di02xGC66c+BTrFogyuYD1aXbJg89CX+u5wWpu1IDPKeoU0pFQXPAyIwi/6Qswb
         Xtqw==
X-Forwarded-Encrypted: i=1; AJvYcCXm5EuhP4jnwED078iszvMBlVCj3r5EdmbN8Gal7nobI4KCM2d1k+7rCXU5GweqQIOyz0mDe8vIqRoQYWrPjsWV5X6Hezpx1SlKnykq/8U=
X-Gm-Message-State: AOJu0YwjIGSpejUXdex4Ul361IbIUckYZNshdt/KouEzpYYaG2Uy4WA4
	8ZCyrh4k0whPtrVehC9WoKw0XR13FGDAtPSXOm/IQIEwQk3E/q1zgQQJ6dc1/Ck=
X-Google-Smtp-Source: AGHT+IEkBVGWG6r8INvHXHS1OoC6a2g8D6yuEsFL7uFC/fiKvKH09PT6Z5FhZ0ah6BTan5HW5rn3eA==
X-Received: by 2002:a5d:526d:0:b0:35e:4f42:6016 with SMTP id ffacd0b85a97d-366e7a35de0mr7166540f8f.30.1719391395042;
        Wed, 26 Jun 2024 01:43:15 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366f973b7e5sm6345965f8f.14.2024.06.26.01.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:43:14 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:43:11 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <ZnvUn-Kq4Al0nMQZ@nanopsycho.orion>
References: <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
 <1718879494.952194-11-hengqi@linux.alibaba.com>
 <ZnvI2hJXPJZyveAv@nanopsycho.orion>
 <20240626040730-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240626040730-mutt-send-email-mst@kernel.org>

Wed, Jun 26, 2024 at 10:08:14AM CEST, mst@redhat.com wrote:
>On Wed, Jun 26, 2024 at 09:52:58AM +0200, Jiri Pirko wrote:
>> Thu, Jun 20, 2024 at 12:31:34PM CEST, hengqi@linux.alibaba.com wrote:
>> >On Thu, 20 Jun 2024 06:11:40 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
>> >> > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
>> >> > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
>> >> > > > On Thu, Jun 20, 2024 at 4:21 PM Jason Wang <jasowang@redhat.com> wrote:
>> >> > > > >
>> >> > > > > On Thu, Jun 20, 2024 at 3:35 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> >> > > > > >
>> >> > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
>> >> > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>> >> > > > > > > >
>> >> > > > > > > >     /* Parameters for control virtqueue, if any */
>> >> > > > > > > >     if (vi->has_cvq) {
>> >> > > > > > > > -           callbacks[total_vqs - 1] = NULL;
>> >> > > > > > > > +           callbacks[total_vqs - 1] = virtnet_cvq_done;
>> >> > > > > > > >             names[total_vqs - 1] = "control";
>> >> > > > > > > >     }
>> >> > > > > > > >
>> >> > > > > > >
>> >> > > > > > > If the # of MSIX vectors is exactly for data path VQs,
>> >> > > > > > > this will cause irq sharing between VQs which will degrade
>> >> > > > > > > performance significantly.
>> >> > > > > > >
>> >> > > > >
>> >> > > > > Why do we need to care about buggy management? I think libvirt has
>> >> > > > > been teached to use 2N+2 since the introduction of the multiqueue[1].
>> >> > > > 
>> >> > > > And Qemu can calculate it correctly automatically since:
>> >> > > > 
>> >> > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
>> >> > > > Author: Jason Wang <jasowang@redhat.com>
>> >> > > > Date:   Mon Mar 8 12:49:19 2021 +0800
>> >> > > > 
>> >> > > >     virtio-net: calculating proper msix vectors on init
>> >> > > > 
>> >> > > >     Currently, the default msix vectors for virtio-net-pci is 3 which is
>> >> > > >     obvious not suitable for multiqueue guest, so we depends on the user
>> >> > > >     or management tools to pass a correct vectors parameter. In fact, we
>> >> > > >     can simplifying this by calculating the number of vectors on realize.
>> >> > > > 
>> >> > > >     Consider we have N queues, the number of vectors needed is 2*N + 2
>> >> > > >     (#queue pairs + plus one config interrupt and control vq). We didn't
>> >> > > >     check whether or not host support control vq because it was added
>> >> > > >     unconditionally by qemu to avoid breaking legacy guests such as Minix.
>> >> > > > 
>> >> > > >     Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
>> >> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> >> > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
>> >> > > 
>> >> > > Yes, devices designed according to the spec need to reserve an interrupt
>> >> > > vector for ctrlq. So, Michael, do we want to be compatible with buggy devices?
>> >> > > 
>> >> > > Thanks.
>> >> > 
>> >> > These aren't buggy, the spec allows this. So don't fail, but
>> >> > I'm fine with using polling if not enough vectors.
>> >> 
>> >> sharing with config interrupt is easier code-wise though, FWIW -
>> >> we don't need to maintain two code-paths.
>> >
>> >Yes, it works well - config change irq is used less before - and will not fail.
>> 
>> Please note I'm working on such fallback for admin queue. I would Like
>> to send the patchset by the end of this week. You can then use it easily
>> for cvq.
>> 
>> Something like:
>> /* the config->find_vqs() implementation */
>> int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>>                 struct virtqueue *vqs[], vq_callback_t *callbacks[],
>>                 const char * const names[], const bool *ctx,
>>                 struct irq_affinity *desc)
>> {
>>         int err;
>> 
>>         /* Try MSI-X with one vector per queue. */
>>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>>                                VP_VQ_VECTOR_POLICY_EACH, ctx, desc);
>>         if (!err)
>>                 return 0;
>>         /* Fallback: MSI-X with one shared vector for config and
>>          * slow path queues, one vector per queue for the rest. */
>>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>>                                VP_VQ_VECTOR_POLICY_SHARED_SLOW, ctx, desc);
>>         if (!err)
>>                 return 0;
>>         /* Fallback: MSI-X with one vector for config, one shared for queues. */
>>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>>                                VP_VQ_VECTOR_POLICY_SHARED, ctx, desc);
>>         if (!err)
>>                 return 0;
>>         /* Is there an interrupt? If not give up. */
>>         if (!(to_vp_device(vdev)->pci_dev->irq))
>>                 return err;
>>         /* Finally fall back to regular interrupts. */
>>         return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
>> }
>> 
>> 
>
>
>Well for cvq, we'll need to adjust the API so core
>knows cvq interrupts are be shared with config not
>datapath.

Agreed. I was thinking about introducing some info struct and pass array
of it instead of callbacks[] and names[]. Then the struct can contain
flag indication. Something like:

struct vq_info {
	vq_callback_t *callback;
	const char *name;
	bool slow_path;
};


>
>
>
>> 
>> >
>> >Thanks.
>> >
>> >> 
>> >> > > > 
>> >> > > > Thanks
>> >> > > > 
>> >> > > > >
>> >> > > > > > > So no, you can not just do it unconditionally.
>> >> > > > > > >
>> >> > > > > > > The correct fix probably requires virtio core/API extensions.
>> >> > > > > >
>> >> > > > > > If the introduction of cvq irq causes interrupts to become shared, then
>> >> > > > > > ctrlq need to fall back to polling mode and keep the status quo.
>> >> > > > >
>> >> > > > > Having to path sounds a burden.
>> >> > > > >
>> >> > > > > >
>> >> > > > > > Thanks.
>> >> > > > > >
>> >> > > > >
>> >> > > > >
>> >> > > > > Thanks
>> >> > > > >
>> >> > > > > [1] https://www.linux-kvm.org/page/Multiqueue
>> >> > > > >
>> >> > > > > > >
>> >> > > > > > > --
>> >> > > > > > > MST
>> >> > > > > > >
>> >> > > > > >
>> >> > > > 
>> >> 
>> >
>
