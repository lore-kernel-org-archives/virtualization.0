Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22CF145A09
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300046; cv=none; b=Q2BYrGZXUpChERlx9UFR9+KwhMqPOjkVhbmV8lpnaRXgdcCvOyvoNHX44zeyPuR4dW8tQlFGN+yb5jzvHgNNgb5HK1d1eBrps0rt+Vq4nFZGBFaKSu6IFthVbYeGBCBYK33MA3UGz6dhn23/dc6cnuWchayz7t1nZyET2LBC5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300046; c=relaxed/simple;
	bh=onlqNPxAqQdL2fRmNYgprHSolUQwvhhv07ezoV8ZRMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YkIsdVgLaXM9U4zIjI7Ed2jB3rdBPx7cm0tPndVts+Bu+HIqHiehhczWuWVAvGBBy3nl96gl/raSfGiHLjADQGAsGwpVPBxtLQmywfq50OsKCDC5J9rHBTP4dKfJFJ9Kk8RAuuIYjIzG4TxT5zIkYl5Dqru+f8Jmsu5DX1xz1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ABikWXbA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABikWXbA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719300043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r7mzdlx4RxVx8F/7j/U5y5iEyY68U4MQ5cbXLJ4cpcs=;
	b=ABikWXbAD4yZ3kRcamBxqhie1X/6NF4VjculbM6HiGSq95U4SyOovB97jVEPtPr8IxPFHg
	LY4K3L74uWFkKZtg4EM09mqysRKbbC45VSX4FAEwNvdZlPxulGUPoln3kISTSiI0wBEkxb
	DHeqwOVFiegMMJnZOPbDwCBFHjSAPR0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-KlGleuzqOjmkJZbY2PGxmQ-1; Tue, 25 Jun 2024 03:20:42 -0400
X-MC-Unique: KlGleuzqOjmkJZbY2PGxmQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ec67dfa052so5297051fa.3
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 00:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719300040; x=1719904840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7mzdlx4RxVx8F/7j/U5y5iEyY68U4MQ5cbXLJ4cpcs=;
        b=Wfi8wY8IZCrDC3q4TFp95g1XzYr+Udxg6mamP9JrUKZcSqKkAhNrBaoeX12jciNpAM
         20207d1VhHglLEWyORJsP7rkzY05UeeR4pVMwDF+1QbdXokeGN7q3WrkM8pXXOHd8osA
         H/SvFWPw+B6ZYV9Y6UJSDeGdPvmob00zk+eVN26jvqd4w3UQaZyD6SgurRScaxcREMzk
         DLPwbxTOj+nnSflN8tvDplhGXwJ2NkxlU1PsZO6mOONEzP1FuabTH5DBsuR/mbmwZSWT
         tV478PWEaJAEjOASXfdqUeLeNH6tNvIaLWOmcEPBX91pOLHQUpwYHTqQziXAQ8KCcrm4
         GeuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBQEGElmZYUrS9+VJq3wq0XwnFRtA9se1uYSOTZpTxDSK8ihsg4LR8dbV3XjrGvUgqP/FVHz3QSqLp0h8gcjnxRF9ReYS08wFMexk/pJk=
X-Gm-Message-State: AOJu0YzE7uIFUwwAYB9FGG36sYa+PDWqHfemKbSvUSDjsgrM0zXfsYQz
	d7bqU7PSyRLJNpK88zslmBuoX1XyQP7k8BQieF0uvdYNe4bPmsi7omuCSfMrrvLHsZ1dhcLzggl
	keeQ4eGWWurQDKdpE0iR/33uB6aU7mpRMpxpMD8w472rRa+2HDcF6niyygcQ8w29YON+mb6wX
X-Received: by 2002:a05:6512:3e1c:b0:52b:c0cd:7312 with SMTP id 2adb3069b0e04-52ce185dbb4mr4963095e87.49.1719300040441;
        Tue, 25 Jun 2024 00:20:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9wovnwelCOuEYhsDJnjoW5XA/GKmCHrecdLODoh/KhXpCGzAl/amJtBYt1CBXDjYb3NrPHA==
X-Received: by 2002:a05:6512:3e1c:b0:52b:c0cd:7312 with SMTP id 2adb3069b0e04-52ce185dbb4mr4963063e87.49.1719300039612;
        Tue, 25 Jun 2024 00:20:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:f72:b8c7:9fc2:4c8b:feb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b60sm201907195e9.37.2024.06.25.00.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:20:39 -0700 (PDT)
Date: Tue, 25 Jun 2024 03:20:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	parav@nvidia.com, feliu@nvidia.com, virtualization@lists.linux.dev,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <20240625031633-mutt-send-email-mst@kernel.org>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <1719222832.5704103-18-hengqi@linux.alibaba.com>
 <20240624070832-mutt-send-email-mst@kernel.org>
 <Znl4q_ArglG1aqPv@nanopsycho.orion>
 <20240624095239-mutt-send-email-mst@kernel.org>
 <ZnmH-eMBfsPkDpkd@nanopsycho.orion>
 <20240624111347-mutt-send-email-mst@kernel.org>
 <1719281486.8829272-20-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1719281486.8829272-20-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 25, 2024 at 10:11:26AM +0800, Heng Qi wrote:
> On Mon, 24 Jun 2024 11:16:45 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Jun 24, 2024 at 04:51:37PM +0200, Jiri Pirko wrote:
> > > Mon, Jun 24, 2024 at 03:55:53PM CEST, mst@redhat.com wrote:
> > > >On Mon, Jun 24, 2024 at 03:46:19PM +0200, Jiri Pirko wrote:
> > > >> Mon, Jun 24, 2024 at 01:23:01PM CEST, mst@redhat.com wrote:
> > > >> >On Mon, Jun 24, 2024 at 05:53:52PM +0800, Heng Qi wrote:
> > > >> >> On Mon, 24 Jun 2024 11:04:43 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> > > >> >> > From: Jiri Pirko <jiri@nvidia.com>
> > > >> >> > 
> > > >> >> > Currently the admin queue command execution is serialized by a lock.
> > > >> >> > This patchsets lifts this limitation allowing to execute admin queue
> > > >> >> > commands in parallel. To do that, admin queue processing needs to be
> > > >> >> > converted from polling to interrupt based completion.
> > > >> >> > 
> > > >> >> > Patches #1-#6 are preparations, making things a bit smoother as well.
> > > >> >> > Patch #7 implements interrupt based completion for admin queue.
> > > >> >> 
> > > >> >> Hi, Jiri
> > > >> >> 
> > > >> >> Before this set, I pushed the cvq irq set [1], and the discussion focused on the
> > > >> >> fact that the newly added irq vector may cause the IO queue to fall back to
> > > >> >> shared interrupt mode.
> > > >> >> But it is true that devices implemented according to the specification should
> > > >> >> not encounter this problem. So what do you think?
> > > >> 
> > > >> Wait. Please note that admin queue is only created and used by PF virtio
> > > >> device. And most probably, this is on hypervisor managing the VFs that
> > > >> are passed to guest VMs. These VFs does not have admin queue.
> > > >> 
> > > >> Therefore, this is hardly comparable to control vq.
> > > >
> > > >
> > > >Well Parav recently posted patches adding admin queue
> > > >to VFs, with new "self" group type.
> > > 
> > > Right, but even so, when device implementation decides to implement and
> > > enable admin queue, it should also make sure to provide correct amount
> > > of vectors. My point is, there should not be any breakage in user
> > > expectation, or am I missing something?
> > 
> > 
> > Hmm, I think you are right that cvq is an existing capability
> > and adminq is newer.
> 
> admin vq has been supported in the kernel for more than half a year, and if at
> this point you think that the device must provide interrupt vectors for it, then
> I think this is also true for cvq.

There's a big difference between 15 years and half a year.  I don't
think any hardware devices have been released with the capability just
yet, and yes allocating a vector for each queue is a good idea for
hardware devices.


> > 
> > Gimme a couple of days to think all this over, hopefully we'll also see
> > a new version of the cvq patch, making it easier to see whether they
> > interact and if so, how.
> > 
> > 
> > 
> > > 
> > > >
> > > >
> > > >> 
> > > >> >> 
> > > >> >> [1] https://lore.kernel.org/all/20240619171708-mutt-send-email-mst@kernel.org/
> > > >> >
> > > >> >It's true - this can cause guest to run out of vectors for a variety of
> > > >> >reasons.
> > > >> >
> > > >> >First we have guest irqs - I am guessing avq could use IRQF_SHARED ?
> > > >> 
> > > >> There is no avq in quest, under normal circumstances. Unless for some
> > > >> reason somebody passes trough virtio PF into guest.
> > > >
> > > >
> > > >At the moment, but this will change soon.
> > > >
> > > >
> > > >> 
> > > >> >I am not sure why we don't allow IRQF_SHARED for the config
> > > >> >interrupt though. So I think addressing this part can be deferred.
> > > >> >
> > > >> >Second, we might not have enough msix vectors on the device. Here sharing
> > > >> >with e.g. cvq and further with config interrupt would make sense.
> > > >> 
> > > >> For cvq irq vector, I believe that sharing with config irq makes sense.
> > > >> Even for admin queue maybe. But again, admin queue is on PF. I don't
> > > >> think this is a real concern.
> > > >> 
> > > >> 
> > > >> >
> > > >> >Jiri do you think you can help Heng Qi hammer out a solution for cvq?
> > > >> >I feel this will work will then benefit in a similar way,
> > > >> >and having us poll aggressively for cvq but not admin commands
> > > >> >does not make much sense, right?
> > > >> >
> > > >> >> > Patch #8 finally removes the admin queue serialization lock.
> > > >> >> > 
> > > >> >> > Jiri Pirko (8):
> > > >> >> >   virtio_pci: push out single vq find code to vp_find_one_vq_msix()
> > > >> >> >   virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
> > > >> >> >   virtio: push out code to vp_avq_index()
> > > >> >> >   virtio: create admin queues alongside other virtqueues
> > > >> >> >   virtio_pci_modern: create admin queue of queried size
> > > >> >> >   virtio_pci_modern: pass cmd as an identification token
> > > >> >> >   virtio_pci_modern: use completion instead of busy loop to wait on
> > > >> >> >     admin cmd result
> > > >> >> >   virtio_pci_modern: remove admin queue serialization lock
> > > >> >> > 
> > > >> >> >  drivers/virtio/virtio.c            |  28 +----
> > > >> >> >  drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
> > > >> >> >  drivers/virtio/virtio_pci_common.h |   9 +-
> > > >> >> >  drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
> > > >> >> >  include/linux/virtio.h             |   2 +
> > > >> >> >  include/linux/virtio_config.h      |   2 -
> > > >> >> >  6 files changed, 150 insertions(+), 160 deletions(-)
> > > >> >> > 
> > > >> >> > -- 
> > > >> >> > 2.45.1
> > > >> >> > 
> > > >> >> > 
> > > >> >
> > > >
> > 

