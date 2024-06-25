Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0481CA87
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719281506; cv=none; b=QJEy/jMC3oN34Kkh+I2JCwnCeP/YkbbQxPV2v8sFnRgBl3HVVU48zqZ7PXau8xOQ3WSekU+LLcEMbjTbLaSfwBMtEiYkQGKJN+9tWrfPGudCIqRMT5n2uj+CxI8Q6/6b6dlZ3DtKsYSjvK/HpYTb4hcmHpfnkaqlm5QfZRJplWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719281506; c=relaxed/simple;
	bh=AdKoMK5EpTduYeM66UoUj2BMPOrcCsYupeqYb/H/qOk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=EQCZUJxEDn2IEvu+EruPbYXGs1dvh6+V7kNltMHm/aI++BIiUv+2kC1nlXVxjASICKoG0kTfgDDBUY9cJLLs/ggeoW/ciGa3KHiardsd2EvfqGTwGRt2CLia67hHc933bcEymBDxOi/9QGeHBRVYukFhUENCe5w4/K25YZe9CKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yFs7qka6; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yFs7qka6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719281500; h=Message-ID:Subject:Date:From:To;
	bh=WXA32tsIMZqvbGx5Q+/pZspIKoB8/Xap8m8mmepx66U=;
	b=yFs7qka6zL6B/svpTv+O+XSile6JVdz9SWnAg+FBnF9ZzbJox3VzmFn9QbexZO8I0ci3qcr3pkoURR3M8bokhArfs/b6NJs9RSwnPhpHQ0170B0dfGkXqSjESfN7d4Z+Po4wcMns+2MaSQaa3OFndwnkPpYTCI8glfYXFKPXFfU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W9Dhw3-_1719281499;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W9Dhw3-_1719281499)
          by smtp.aliyun-inc.com;
          Tue, 25 Jun 2024 10:11:39 +0800
Message-ID: <1719281486.8829272-20-hengqi@linux.alibaba.com>
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue commands execution
Date: Tue, 25 Jun 2024 10:11:26 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com,
 parav@nvidia.com,
 feliu@nvidia.com,
 virtualization@lists.linux.dev,
 Jiri Pirko <jiri@resnulli.us>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <1719222832.5704103-18-hengqi@linux.alibaba.com>
 <20240624070832-mutt-send-email-mst@kernel.org>
 <Znl4q_ArglG1aqPv@nanopsycho.orion>
 <20240624095239-mutt-send-email-mst@kernel.org>
 <ZnmH-eMBfsPkDpkd@nanopsycho.orion>
 <20240624111347-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240624111347-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 24 Jun 2024 11:16:45 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Jun 24, 2024 at 04:51:37PM +0200, Jiri Pirko wrote:
> > Mon, Jun 24, 2024 at 03:55:53PM CEST, mst@redhat.com wrote:
> > >On Mon, Jun 24, 2024 at 03:46:19PM +0200, Jiri Pirko wrote:
> > >> Mon, Jun 24, 2024 at 01:23:01PM CEST, mst@redhat.com wrote:
> > >> >On Mon, Jun 24, 2024 at 05:53:52PM +0800, Heng Qi wrote:
> > >> >> On Mon, 24 Jun 2024 11:04:43 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> > >> >> > From: Jiri Pirko <jiri@nvidia.com>
> > >> >> > 
> > >> >> > Currently the admin queue command execution is serialized by a lock.
> > >> >> > This patchsets lifts this limitation allowing to execute admin queue
> > >> >> > commands in parallel. To do that, admin queue processing needs to be
> > >> >> > converted from polling to interrupt based completion.
> > >> >> > 
> > >> >> > Patches #1-#6 are preparations, making things a bit smoother as well.
> > >> >> > Patch #7 implements interrupt based completion for admin queue.
> > >> >> 
> > >> >> Hi, Jiri
> > >> >> 
> > >> >> Before this set, I pushed the cvq irq set [1], and the discussion focused on the
> > >> >> fact that the newly added irq vector may cause the IO queue to fall back to
> > >> >> shared interrupt mode.
> > >> >> But it is true that devices implemented according to the specification should
> > >> >> not encounter this problem. So what do you think?
> > >> 
> > >> Wait. Please note that admin queue is only created and used by PF virtio
> > >> device. And most probably, this is on hypervisor managing the VFs that
> > >> are passed to guest VMs. These VFs does not have admin queue.
> > >> 
> > >> Therefore, this is hardly comparable to control vq.
> > >
> > >
> > >Well Parav recently posted patches adding admin queue
> > >to VFs, with new "self" group type.
> > 
> > Right, but even so, when device implementation decides to implement and
> > enable admin queue, it should also make sure to provide correct amount
> > of vectors. My point is, there should not be any breakage in user
> > expectation, or am I missing something?
> 
> 
> Hmm, I think you are right that cvq is an existing capability
> and adminq is newer.

admin vq has been supported in the kernel for more than half a year, and if at
this point you think that the device must provide interrupt vectors for it, then
I think this is also true for cvq.

> 
> Gimme a couple of days to think all this over, hopefully we'll also see
> a new version of the cvq patch, making it easier to see whether they
> interact and if so, how.
> 
> 
> 
> > 
> > >
> > >
> > >> 
> > >> >> 
> > >> >> [1] https://lore.kernel.org/all/20240619171708-mutt-send-email-mst@kernel.org/
> > >> >
> > >> >It's true - this can cause guest to run out of vectors for a variety of
> > >> >reasons.
> > >> >
> > >> >First we have guest irqs - I am guessing avq could use IRQF_SHARED ?
> > >> 
> > >> There is no avq in quest, under normal circumstances. Unless for some
> > >> reason somebody passes trough virtio PF into guest.
> > >
> > >
> > >At the moment, but this will change soon.
> > >
> > >
> > >> 
> > >> >I am not sure why we don't allow IRQF_SHARED for the config
> > >> >interrupt though. So I think addressing this part can be deferred.
> > >> >
> > >> >Second, we might not have enough msix vectors on the device. Here sharing
> > >> >with e.g. cvq and further with config interrupt would make sense.
> > >> 
> > >> For cvq irq vector, I believe that sharing with config irq makes sense.
> > >> Even for admin queue maybe. But again, admin queue is on PF. I don't
> > >> think this is a real concern.
> > >> 
> > >> 
> > >> >
> > >> >Jiri do you think you can help Heng Qi hammer out a solution for cvq?
> > >> >I feel this will work will then benefit in a similar way,
> > >> >and having us poll aggressively for cvq but not admin commands
> > >> >does not make much sense, right?
> > >> >
> > >> >> > Patch #8 finally removes the admin queue serialization lock.
> > >> >> > 
> > >> >> > Jiri Pirko (8):
> > >> >> >   virtio_pci: push out single vq find code to vp_find_one_vq_msix()
> > >> >> >   virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
> > >> >> >   virtio: push out code to vp_avq_index()
> > >> >> >   virtio: create admin queues alongside other virtqueues
> > >> >> >   virtio_pci_modern: create admin queue of queried size
> > >> >> >   virtio_pci_modern: pass cmd as an identification token
> > >> >> >   virtio_pci_modern: use completion instead of busy loop to wait on
> > >> >> >     admin cmd result
> > >> >> >   virtio_pci_modern: remove admin queue serialization lock
> > >> >> > 
> > >> >> >  drivers/virtio/virtio.c            |  28 +----
> > >> >> >  drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
> > >> >> >  drivers/virtio/virtio_pci_common.h |   9 +-
> > >> >> >  drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
> > >> >> >  include/linux/virtio.h             |   2 +
> > >> >> >  include/linux/virtio_config.h      |   2 -
> > >> >> >  6 files changed, 150 insertions(+), 160 deletions(-)
> > >> >> > 
> > >> >> > -- 
> > >> >> > 2.45.1
> > >> >> > 
> > >> >> > 
> > >> >
> > >
> 
