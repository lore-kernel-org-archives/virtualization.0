Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A221DFEA
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242216; cv=none; b=L5WYghTRswEmI32Zmw1xPQgi94hJtnZhGnNfawevjX9/SP4e1ftB6tlCh5ECp1SUt46a95gAozvq7bcMMhTJITG4+vUPVWL8ZSte9d0qv6aG4WSGRNxXT4YZ9tWeTK0uTkxAYd1LNNmKMjQalYyXXKWYG6G21qGDuhnjubxu5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242216; c=relaxed/simple;
	bh=O6AbQQv08XL0kbixOp2Se7XkHGGcK6vtjiCmpZgsXDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LegLQDCVsAVIeFIW/efoQhKEO9H0RlpZLQbiy+puna/F/Sh5DXNhMEJyB9gO/0xovXPYA1jg+pgI4mjrOdP9xJuL4rk08rO3Z6g9KX2OOySKZNtNKs1sXBN6al1DNgcx6IS+oUsEVZees2m9I9gMKNt9lA2eNwPmg5/1gR9Paa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOTo6jCR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOTo6jCR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719242214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCX+lNdypWk49oW7uwNBqMndVES4ETrYwY6bHgoSOJA=;
	b=fOTo6jCREvQv5XqznDi46SyNjFHEcZBYdnn0h+blDYdlBi4WDygk8NaKoUgwaW4BGhgQ7I
	Dzwqgv4QkbJTcN9Vm1Td3Mo9ejVZV+5IydcQG6QHdXXNxgEJ/kOcr5U60qRmHrOOLDo4IS
	/tKtJnyOu+Jo0y4K4HI4dJfwTRL57HM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-tOZGTUKhOzOaQFKRli4dow-1; Mon, 24 Jun 2024 11:16:52 -0400
X-MC-Unique: tOZGTUKhOzOaQFKRli4dow-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7955f8b4bcfso925420285a.3
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 08:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719242211; x=1719847011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCX+lNdypWk49oW7uwNBqMndVES4ETrYwY6bHgoSOJA=;
        b=k00MdT3D8sV+pbXDuisemQ08dPWWJ+UMgPKzWOZnhZgo6++f2xgiFaVnobYAMSWTRi
         bTk1cKX227uyvmweQCN8IoNilZUdIv3lYqJDR6lWaa129H5QmlQnOp0uPbMn4efHrM+S
         CrsSze4LW56dnjixOeZSOJi2QakTDBytTkKaQdNapylUdhwd+4W05m6/wywykoBAFvCF
         9/hwJv+EGDkkQxNJeNt0/fc1IfOp7krK0oRMGXvpVAe5aHyun3wiFk/914Nr5R5b6qaf
         9JxpVDtrKyT7GbwCAwpQkiMYh23nsUCqRrfJn5VjTOJB9JqBCm+o3orbhteDfzr7lltp
         DYQw==
X-Forwarded-Encrypted: i=1; AJvYcCVKGO0Jw6DczQE9yi1RV0KxpXoLQNXAcASf3+668Z9CWPIfkR6RXqXB5zoqNC8qTQjf+Vi5ePnvRusoTHq7lGR53n7rQ2AXq3pyZLRd/Kg=
X-Gm-Message-State: AOJu0YynxUjxEsNjxl+OSj9C/UXN27rDLD/MxGaGlIcstIZbuDdLEP4V
	lPE4BoVT9c03IYoZvWGEk886fJNnJ8OiMNly1YPSfqvNeMbWzq5AAGm7YHVb7KJDXBQe48cRWNS
	i7TI7TIexE5saDvwU6cl5f0vFPLtKZFjvCNDROffbe+3A7d4rrTSCg0w5urNPDXrp
X-Received: by 2002:a05:620a:24c9:b0:797:b67e:e84f with SMTP id af79cd13be357-79be6efb7e7mr529342785a.37.1719242211392;
        Mon, 24 Jun 2024 08:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+bfWGhfh9PyATb+JsN2W0DiUmvzBDzfi4oW0R7hayj+0yAiQAnjC73YiyLd+upcaaryR43A==
X-Received: by 2002:a05:620a:24c9:b0:797:b67e:e84f with SMTP id af79cd13be357-79be6efb7e7mr529338385a.37.1719242210705;
        Mon, 24 Jun 2024 08:16:50 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:f72:b8c7:9fc2:4c8b:feb3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce91f8f7sm321994885a.97.2024.06.24.08.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:16:50 -0700 (PDT)
Date: Mon, 24 Jun 2024 11:16:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Heng Qi <hengqi@linux.alibaba.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, virtualization@lists.linux.dev
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <20240624111347-mutt-send-email-mst@kernel.org>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <1719222832.5704103-18-hengqi@linux.alibaba.com>
 <20240624070832-mutt-send-email-mst@kernel.org>
 <Znl4q_ArglG1aqPv@nanopsycho.orion>
 <20240624095239-mutt-send-email-mst@kernel.org>
 <ZnmH-eMBfsPkDpkd@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZnmH-eMBfsPkDpkd@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 04:51:37PM +0200, Jiri Pirko wrote:
> Mon, Jun 24, 2024 at 03:55:53PM CEST, mst@redhat.com wrote:
> >On Mon, Jun 24, 2024 at 03:46:19PM +0200, Jiri Pirko wrote:
> >> Mon, Jun 24, 2024 at 01:23:01PM CEST, mst@redhat.com wrote:
> >> >On Mon, Jun 24, 2024 at 05:53:52PM +0800, Heng Qi wrote:
> >> >> On Mon, 24 Jun 2024 11:04:43 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> >> >> > From: Jiri Pirko <jiri@nvidia.com>
> >> >> > 
> >> >> > Currently the admin queue command execution is serialized by a lock.
> >> >> > This patchsets lifts this limitation allowing to execute admin queue
> >> >> > commands in parallel. To do that, admin queue processing needs to be
> >> >> > converted from polling to interrupt based completion.
> >> >> > 
> >> >> > Patches #1-#6 are preparations, making things a bit smoother as well.
> >> >> > Patch #7 implements interrupt based completion for admin queue.
> >> >> 
> >> >> Hi, Jiri
> >> >> 
> >> >> Before this set, I pushed the cvq irq set [1], and the discussion focused on the
> >> >> fact that the newly added irq vector may cause the IO queue to fall back to
> >> >> shared interrupt mode.
> >> >> But it is true that devices implemented according to the specification should
> >> >> not encounter this problem. So what do you think?
> >> 
> >> Wait. Please note that admin queue is only created and used by PF virtio
> >> device. And most probably, this is on hypervisor managing the VFs that
> >> are passed to guest VMs. These VFs does not have admin queue.
> >> 
> >> Therefore, this is hardly comparable to control vq.
> >
> >
> >Well Parav recently posted patches adding admin queue
> >to VFs, with new "self" group type.
> 
> Right, but even so, when device implementation decides to implement and
> enable admin queue, it should also make sure to provide correct amount
> of vectors. My point is, there should not be any breakage in user
> expectation, or am I missing something?


Hmm, I think you are right that cvq is an existing capability
and adminq is newer.

Gimme a couple of days to think all this over, hopefully we'll also see
a new version of the cvq patch, making it easier to see whether they
interact and if so, how.



> 
> >
> >
> >> 
> >> >> 
> >> >> [1] https://lore.kernel.org/all/20240619171708-mutt-send-email-mst@kernel.org/
> >> >
> >> >It's true - this can cause guest to run out of vectors for a variety of
> >> >reasons.
> >> >
> >> >First we have guest irqs - I am guessing avq could use IRQF_SHARED ?
> >> 
> >> There is no avq in quest, under normal circumstances. Unless for some
> >> reason somebody passes trough virtio PF into guest.
> >
> >
> >At the moment, but this will change soon.
> >
> >
> >> 
> >> >I am not sure why we don't allow IRQF_SHARED for the config
> >> >interrupt though. So I think addressing this part can be deferred.
> >> >
> >> >Second, we might not have enough msix vectors on the device. Here sharing
> >> >with e.g. cvq and further with config interrupt would make sense.
> >> 
> >> For cvq irq vector, I believe that sharing with config irq makes sense.
> >> Even for admin queue maybe. But again, admin queue is on PF. I don't
> >> think this is a real concern.
> >> 
> >> 
> >> >
> >> >Jiri do you think you can help Heng Qi hammer out a solution for cvq?
> >> >I feel this will work will then benefit in a similar way,
> >> >and having us poll aggressively for cvq but not admin commands
> >> >does not make much sense, right?
> >> >
> >> >> > Patch #8 finally removes the admin queue serialization lock.
> >> >> > 
> >> >> > Jiri Pirko (8):
> >> >> >   virtio_pci: push out single vq find code to vp_find_one_vq_msix()
> >> >> >   virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
> >> >> >   virtio: push out code to vp_avq_index()
> >> >> >   virtio: create admin queues alongside other virtqueues
> >> >> >   virtio_pci_modern: create admin queue of queried size
> >> >> >   virtio_pci_modern: pass cmd as an identification token
> >> >> >   virtio_pci_modern: use completion instead of busy loop to wait on
> >> >> >     admin cmd result
> >> >> >   virtio_pci_modern: remove admin queue serialization lock
> >> >> > 
> >> >> >  drivers/virtio/virtio.c            |  28 +----
> >> >> >  drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
> >> >> >  drivers/virtio/virtio_pci_common.h |   9 +-
> >> >> >  drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
> >> >> >  include/linux/virtio.h             |   2 +
> >> >> >  include/linux/virtio_config.h      |   2 -
> >> >> >  6 files changed, 150 insertions(+), 160 deletions(-)
> >> >> > 
> >> >> > -- 
> >> >> > 2.45.1
> >> >> > 
> >> >> > 
> >> >
> >

