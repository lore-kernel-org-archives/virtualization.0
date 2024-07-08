Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED36511CA1
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438849; cv=none; b=oLe9vktSfjyjMF/KXuAXMR+l+BBFRl4UCQthqSJXBH2fNj18TzTcIMRSfs6aM+DhVV4uaihTYYgqcWjy17X0DHnmcyx3PtLQDeNkJQytiJTdQJbexR8Is3TebwsQDmdjPkOzNsE2CdtzTsT13d5v25GHLje4JlvndbmueOZzo6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438849; c=relaxed/simple;
	bh=4DQccTifEBBNX8gHmRvfdps4Uo3dR3DK7HsIbN7lBJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCvsqoEcR9qsZgDRcVungjRH39KYFXgOnol79R0wHee6TxVMC0uPNmfkZaFwCDWdYW5O/G6nJKEDl6itDOyiOUlwRgl2TWxi0AkHcBd5vFiEP4HGo03wBsuUZX2vfgKgrEH95ZBjx8a8KDqxOVZ8vZL/EBTJh/dfkXoeNkmMFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=M/tub1gZ; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="M/tub1gZ"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-58f9874aeb4so3728266a12.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 04:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720438845; x=1721043645; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Oj9hVhewV9lGX86mRsVY7ZBdhsddt781yMM5sK/aJ0=;
        b=M/tub1gZPp9fvRzIwq045gVWQETTmYeWNGhAFmzaJE/xz0T23PAsG0UwQ6qdZYoKN8
         a7TFOj0r7tXWsYor+81U9rnubrls6siYsbl9M31kvHNEKbIkwNWUc+tgWhWaojykaDm8
         u0eUPX6Ax6QIYcSf3iXpwVY6vEqTQbSpf/bsq/AYTCIyjxgWtTE+8SHVGPv5I2ZXBkvk
         UIKoKcUckO2/yriFKC2nD1paJdQEwDuT+iFHZaRQHtlCCyPWmIzIFu0OIbsKG8uG+9al
         pRAJ2fYLw14p0HKZd7ipeHKwMW2MEoQRJRFj6XgRCpI7skmtRHte07otCeSvLz/O8A4Q
         e3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720438845; x=1721043645;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Oj9hVhewV9lGX86mRsVY7ZBdhsddt781yMM5sK/aJ0=;
        b=SimhrcnEryA9W5xSPerFyknb+jIi6DVqC9oV6xT9hC06RNemHKUNnSX6kpQ9TfuHYJ
         ENbQ3nTNl1SkdShXMcALLKpSaSM/OynYfkNYyrVCoD6tPccusSa2WtflNDLPzpYeZssq
         iFHVYkavBC69iBZYvaswgD/FsKVizDgPf3y3+pGGXlTDZUL0Dvf1V3aS4cWGo+UhFAgD
         0Y+V4GyNoqAEVigBIienJHQ28znXN/x0V7/W+nUsrIP/p+yEvofSMWBnbEA+DusmCOmV
         84FhcDD08r3L47TB0gle0NLK8pbXxOu5+kCQ31MCrigA6D3nnTlsyEEZ3hKx4wABNgeK
         3SWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDcCL8sOMqvcLX+oZp923vvjIDoSx4DXpcrOBkcnnuyPd3GO1XG91eaeOse7qtGJc8MvAKJuzXj8U5CK3ZccSmPfK30LrR+U6Bwan6fik=
X-Gm-Message-State: AOJu0Yw0lZKmHZa/bE1y8u4FAPUDCHCwAS/XZnYKBC1zJ6z+YE47W4TS
	DImNUx8wVP4rdI3cfPVSX20UoDXBAnJHa8Y5u77onWGnBbcfp3c23HYQPcsfBiw=
X-Google-Smtp-Source: AGHT+IGByAobiVYXxBMrpQrkE5cUurgwnnCaXBM6PFdoW6K3shR38ZsJV83iB0L93Z7GXll4KYSabA==
X-Received: by 2002:a17:906:897:b0:a77:eb34:3b50 with SMTP id a640c23a62f3a-a77eb343cb9mr341666566b.20.1720438844745;
        Mon, 08 Jul 2024 04:40:44 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77ec25ec18sm164889866b.39.2024.07.08.04.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 04:40:44 -0700 (PDT)
Date: Mon, 8 Jul 2024 13:40:42 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <ZovQOpmfOMs77lJ2@nanopsycho.orion>
References: <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
 <1718879494.952194-11-hengqi@linux.alibaba.com>
 <ZnvI2hJXPJZyveAv@nanopsycho.orion>
 <20240626040730-mutt-send-email-mst@kernel.org>
 <ZnvUn-Kq4Al0nMQZ@nanopsycho.orion>
 <20240626045313-mutt-send-email-mst@kernel.org>
 <ZnwApCUjIijZ7o0b@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnwApCUjIijZ7o0b@nanopsycho.orion>

Wed, Jun 26, 2024 at 01:51:00PM CEST, jiri@resnulli.us wrote:
>Wed, Jun 26, 2024 at 11:58:08AM CEST, mst@redhat.com wrote:
>>On Wed, Jun 26, 2024 at 10:43:11AM +0200, Jiri Pirko wrote:
>>> Wed, Jun 26, 2024 at 10:08:14AM CEST, mst@redhat.com wrote:
>>> >On Wed, Jun 26, 2024 at 09:52:58AM +0200, Jiri Pirko wrote:
>>> >> Thu, Jun 20, 2024 at 12:31:34PM CEST, hengqi@linux.alibaba.com wrote:
>>> >> >On Thu, 20 Jun 2024 06:11:40 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>> >> >> On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
>>> >> >> > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
>>> >> >> > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
>>> >> >> > > > On Thu, Jun 20, 2024 at 4:21 PM Jason Wang <jasowang@redhat.com> wrote:
>>> >> >> > > > >
>>> >> >> > > > > On Thu, Jun 20, 2024 at 3:35 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>> >> >> > > > > >
>>> >> >> > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>> >> >> > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
>>> >> >> > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>>> >> >> > > > > > > >
>>> >> >> > > > > > > >     /* Parameters for control virtqueue, if any */
>>> >> >> > > > > > > >     if (vi->has_cvq) {
>>> >> >> > > > > > > > -           callbacks[total_vqs - 1] = NULL;
>>> >> >> > > > > > > > +           callbacks[total_vqs - 1] = virtnet_cvq_done;
>>> >> >> > > > > > > >             names[total_vqs - 1] = "control";
>>> >> >> > > > > > > >     }
>>> >> >> > > > > > > >
>>> >> >> > > > > > >
>>> >> >> > > > > > > If the # of MSIX vectors is exactly for data path VQs,
>>> >> >> > > > > > > this will cause irq sharing between VQs which will degrade
>>> >> >> > > > > > > performance significantly.
>>> >> >> > > > > > >
>>> >> >> > > > >
>>> >> >> > > > > Why do we need to care about buggy management? I think libvirt has
>>> >> >> > > > > been teached to use 2N+2 since the introduction of the multiqueue[1].
>>> >> >> > > > 
>>> >> >> > > > And Qemu can calculate it correctly automatically since:
>>> >> >> > > > 
>>> >> >> > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
>>> >> >> > > > Author: Jason Wang <jasowang@redhat.com>
>>> >> >> > > > Date:   Mon Mar 8 12:49:19 2021 +0800
>>> >> >> > > > 
>>> >> >> > > >     virtio-net: calculating proper msix vectors on init
>>> >> >> > > > 
>>> >> >> > > >     Currently, the default msix vectors for virtio-net-pci is 3 which is
>>> >> >> > > >     obvious not suitable for multiqueue guest, so we depends on the user
>>> >> >> > > >     or management tools to pass a correct vectors parameter. In fact, we
>>> >> >> > > >     can simplifying this by calculating the number of vectors on realize.
>>> >> >> > > > 
>>> >> >> > > >     Consider we have N queues, the number of vectors needed is 2*N + 2
>>> >> >> > > >     (#queue pairs + plus one config interrupt and control vq). We didn't
>>> >> >> > > >     check whether or not host support control vq because it was added
>>> >> >> > > >     unconditionally by qemu to avoid breaking legacy guests such as Minix.
>>> >> >> > > > 
>>> >> >> > > >     Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
>>> >> >> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>> >> >> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> >> >> > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> >> >> > > 
>>> >> >> > > Yes, devices designed according to the spec need to reserve an interrupt
>>> >> >> > > vector for ctrlq. So, Michael, do we want to be compatible with buggy devices?
>>> >> >> > > 
>>> >> >> > > Thanks.
>>> >> >> > 
>>> >> >> > These aren't buggy, the spec allows this. So don't fail, but
>>> >> >> > I'm fine with using polling if not enough vectors.
>>> >> >> 
>>> >> >> sharing with config interrupt is easier code-wise though, FWIW -
>>> >> >> we don't need to maintain two code-paths.
>>> >> >
>>> >> >Yes, it works well - config change irq is used less before - and will not fail.
>>> >> 
>>> >> Please note I'm working on such fallback for admin queue. I would Like
>>> >> to send the patchset by the end of this week. You can then use it easily
>>> >> for cvq.
>>> >> 
>>> >> Something like:
>>> >> /* the config->find_vqs() implementation */
>>> >> int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>>> >>                 struct virtqueue *vqs[], vq_callback_t *callbacks[],
>>> >>                 const char * const names[], const bool *ctx,
>>> >>                 struct irq_affinity *desc)
>>> >> {
>>> >>         int err;
>>> >> 
>>> >>         /* Try MSI-X with one vector per queue. */
>>> >>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>>> >>                                VP_VQ_VECTOR_POLICY_EACH, ctx, desc);
>>> >>         if (!err)
>>> >>                 return 0;
>>> >>         /* Fallback: MSI-X with one shared vector for config and
>>> >>          * slow path queues, one vector per queue for the rest. */
>>> >>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>>> >>                                VP_VQ_VECTOR_POLICY_SHARED_SLOW, ctx, desc);
>>> >>         if (!err)
>>> >>                 return 0;
>>> >>         /* Fallback: MSI-X with one vector for config, one shared for queues. */
>>> >>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
>>> >>                                VP_VQ_VECTOR_POLICY_SHARED, ctx, desc);
>>> >>         if (!err)
>>> >>                 return 0;
>>> >>         /* Is there an interrupt? If not give up. */
>>> >>         if (!(to_vp_device(vdev)->pci_dev->irq))
>>> >>                 return err;
>>> >>         /* Finally fall back to regular interrupts. */
>>> >>         return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
>>> >> }
>>> >> 
>>> >> 
>>> >
>>> >
>>> >Well for cvq, we'll need to adjust the API so core
>>> >knows cvq interrupts are be shared with config not
>>> >datapath.
>>> 
>>> Agreed. I was thinking about introducing some info struct and pass array
>>> of it instead of callbacks[] and names[]. Then the struct can contain
>>> flag indication. Something like:
>>> 
>>> struct vq_info {
>>> 	vq_callback_t *callback;
>>> 	const char *name;
>>> 	bool slow_path;
>>> };
>>> 
>>
>>Yes. Add ctx too? There were attempts at it already btw.
>
>Yep, ctx too. I can take a stab at it if noone else is interested.

Since this work is in v4, and I hope it will get merged soon, I plan to
send v2 of admin queue parallelization patchset after that. Here it is:
https://github.com/jpirko/linux_mlxsw/tree/wip_virtio_parallel_aq2

Heng, note the last patch:
virtio_pci: allow to indicate virtqueue being slow path

That is not part of my set, it is ment to be merged in your control
queue patchset. Then you can just indicate cvq to be slow like this:

        /* Parameters for control virtqueue, if any */
        if (vi->has_cvq) {
                vqs_info[total_vqs - 1].callback = virtnet_cvq_done;
                vqs_info[total_vqs - 1].name = "control";
                vqs_info[total_vqs - 1].slow_path = true;
        }

I just wanted to let you know this is in process so you may prepare.
Will keep you informed.

Thanks.
