Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240312D47E4
	for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374628; cv=none; b=rvvffbIs7XXxrtMjPgRASHuKoT76mGsVTx5TMsOksNsbAfj7oABV93jlEt0nFrWD/dMPJwDKhWI/HfHXIKyMiyY7mWOqvq8oDAO3b+sgkHb8co6ohh9q26/FxFMKDDlJHmwNCkuK89NebCkFP5yeqOLULys1z72yTKTePwedvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374628; c=relaxed/simple;
	bh=o7kXX0RPLQ0nYMfqvkQvBpbLY/zrqTRR2MDUo7xgM/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JsI8A3t4QGbyvcJ0MltXwHQTS++xPTGhYJleGYPQTnhNbl2mo4t1WgNlVT3wnNqmHP3nim0Ngh+iBpYMcuCYhY6cFgspKtviKjFNPJXk3aarsJ9+V++Tqbh0p9gadZ9pDuVzGEhAHG2+BIZYDBR0SAYfxqw69X0NPg7/hZvhhyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IsjRO0Wk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsjRO0Wk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763374625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DKtAV7uj9Q5JrTVGQ18jEKZJYnX6MI+dW/m85jGdlyY=;
	b=IsjRO0Wkd1anYT1c+XeuKRLeMwq8TqvmqNhAMPnxdhs43cYGSusIx21tWNBh4/n+EW5RbF
	QImouT1jKVF7ME0Oqo6nUC63ZBonWRF0493br6SlOLhdzwwKZij/IRw5S9FA7p+YmwKxJ6
	4nyWsAHBoholJp/XWuElw1txctbGIL0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-95L8V7OxPfSUC_XjkOdsVA-1; Mon, 17 Nov 2025 05:17:03 -0500
X-MC-Unique: 95L8V7OxPfSUC_XjkOdsVA-1
X-Mimecast-MFC-AGG-ID: 95L8V7OxPfSUC_XjkOdsVA_1763374623
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b3155274eso1624483f8f.0
        for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 02:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763374622; x=1763979422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKtAV7uj9Q5JrTVGQ18jEKZJYnX6MI+dW/m85jGdlyY=;
        b=CZXEV7xlNpWu01qMt8uX+01pcK7WfGLoCDX+B1TIOhA5GTl5YFFEYyO0O4YmcQuNOO
         oUUcC/b4hcz/kJqJNEWwWSdQm/8ugBZuPn5sB4tPlg4PIadD5gLJdm+PXZpJC5p2cto6
         tH+TG2yQUYJoJ1CjV13RzkZUMis+mSBF+/JjQdUXbZ6+TUBbexCbpF7qArHyS43jnMPm
         q8RDahZZ8sX+BcVBd8FyP3f14LkIymNN9r445vqrbNx/e77UPpYALKG1JMrW6ES6w/Rf
         SnP8aZnF75NhzVbITQLqD4dGlDcF9mtOes44WwpiG9Q4qWqfxEeMtLR7t/NH1Zl4Zkz6
         rthg==
X-Forwarded-Encrypted: i=1; AJvYcCVBMXOiZRDhDJTea6DRYqWivTvhFJzODqeErXr9p1w3GS1qf+wGA4mfT7U1vHaPprTxYzsWlW6vBdFtXHP13Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCnYCq55PsrZMOLuuUD7FCgbka6bvwcajWkPj1RemdF6TbHYvj
	lAD07QpGXgr6M6wIW2oiOZM9nPvsOWDmrn1zn0k2vMBxgHHMZtIxuI485r7cajxcuFfwz3NkYW0
	k+EdnhqWvzzI8f1iO5zP9iWdGdzMJQ2+vaJWFR3PFFlf1WbZ3dHhqUO9VGLi41khBzfWu
X-Gm-Gg: ASbGnctEO0OfizUumvpC6flQaD542SCTrCxaotQSoYcRtso/p23TAK0rUYG5HqGKvgZ
	ATyUHF/5lMEvaycuwZNJC1Hl9AbaYjf6G3g/E05nv8jW8tQCHTq+dSN9t2i3LyvOCCgrXTW9IqB
	X8m+zk1QQOci41Pd6h3aStECMAmxmVFEyXjRpT0ATOiu4ModqwKhdjKRE8xAcH53wO5eY/qTwgP
	1i5wrs38S+aHkZh3rSmEWa1Buj7m0ch1kiEjZWhPTb47IHIRb+zk/tP+voNPjbxJ53T+mnT9ik4
	LpB3mt/l7ytRkHU5IFbvw2tYJnyO1RN+PbG9x6z0TY5aOIXAgwfvUUWQD0g3x6pCodhB+8B8sxJ
	XXAKFghj9takFIq7V6os=
X-Received: by 2002:a05:6000:1449:b0:429:c4bb:fbc4 with SMTP id ffacd0b85a97d-42b59367894mr11563586f8f.25.1763374622459;
        Mon, 17 Nov 2025 02:17:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaib2b+VX5Urwcd5csnh/3M+yBJ32yTSo0v68+WHEdzkMgog6bBuPAjinpdOdZ3rqCx4Nysg==
X-Received: by 2002:a05:6000:1449:b0:429:c4bb:fbc4 with SMTP id ffacd0b85a97d-42b59367894mr11563560f8f.25.1763374621928;
        Mon, 17 Nov 2025 02:17:01 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85627sm26755235f8f.16.2025.11.17.02.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:17:01 -0800 (PST)
Date: Mon, 17 Nov 2025 05:16:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH 0/2] add WQ_PERCPU to alloc_workqueue() in virtio_balloon
 and vduse
Message-ID: <20251117051617-mutt-send-email-mst@kernel.org>
References: <20251107154917.313090-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251107154917.313090-1-marco.crivellari@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bR2qycrF5HBuG7qhzTBGUosh59r3Z8aTlh3MUdQ1B5w_1763374623
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 07, 2025 at 04:49:15PM +0100, Marco Crivellari wrote:
> Hi,
> 
> === Current situation: problems ===
> 
> Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
> set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.
> 
> This leads to different scenarios if a work item is scheduled on an
> isolated CPU where "delay" value is 0 or greater then 0:
>         schedule_delayed_work(, 0);
> 
> This will be handled by __queue_work() that will queue the work item on the
> current local (isolated) CPU, while:
> 
>         schedule_delayed_work(, 1);
> 
> Will move the timer on an housekeeping CPU, and schedule the work there.
> 
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> 
> === Recent changes to the WQ API ===
> 
> The following, address the recent changes in the Workqueue API:
> 
> - commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> - commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The old workqueues will be removed in a future release cycle.
> 
> === Introduced Changes by this series ===
> 
> 1) [P 1-2] WQ_PERCPU added to alloc_workqueue()
> 
>     This adds a new WQ_PERCPU flag to explicitly request alloc_workqueue()
>     to be per-cpu when WQ_UNBOUND has not been specified.
> 
> Thanks!
> 
> Marco Crivellari (2):
>   virtio_balloon: add WQ_PERCPU to alloc_workqueue users
>   vduse: add WQ_PERCPU to alloc_workqueue users

To make sure, this does not seem to introduce any
functional change - you want me to queue this now?


>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>  drivers/virtio/virtio_balloon.c    | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> -- 
> 2.51.1

