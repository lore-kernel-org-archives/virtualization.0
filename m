Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A3B2EB0A
	for <virtualization@lists.linux.dev>; Wed, 13 Dec 2023 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMJXr0mx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702479329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIFKxiFZihO9GqXmA3HovwJ/rQqe1hgcv8SZULAHlOU=;
	b=ZMJXr0mxOBRHFf0F0NNc3YH6vkNWgd2VtQtTW/XqAj1Z2ehbepuOLp2jaYsvwlZ0mv7wRH
	I4WZsVhcufGVHpRWUoMmyKstyQDAWe2SvpHJ2T1FLKzJb5/i281CzStzOFKBsopmk5J+Xe
	dHBIAfKlt4FvRhfG4oQh/xfwjh+wmQ4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-qEscf4KwNQWXRTfDPjzeww-1; Wed, 13 Dec 2023 09:55:25 -0500
X-MC-Unique: qEscf4KwNQWXRTfDPjzeww-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ca31b054e4so54313581fa.2
        for <virtualization@lists.linux.dev>; Wed, 13 Dec 2023 06:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479324; x=1703084124;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uIFKxiFZihO9GqXmA3HovwJ/rQqe1hgcv8SZULAHlOU=;
        b=MRfsywK8TAC5TOKgfD969wBcJQkZNTig7kBtLETufD4cqHhTl0QDX+Bi5o3Q4TSPGZ
         WCehXctF8/JUGIIinTiYc+2j/Dh/tJ6LDK9X1oagc6WqYHmBQL1MFaUR3B4+ZpCoSJQO
         3CezV2b/luODRrCvqDBizu7x3KLBi5VMYxzW1/j+AWHNkJuPukWLWtjSR1o4D9k0lUjg
         GE0IKQYPEEV8r67pkpgQ6JhczgQJ/wNtXyTY1IklrqQ37aIFZcO67JaZxl4kcyFP8It8
         FptC4zVuhzEnOJXCprn7ovcbC2hkOdjI69F79tmTF1NJS63lx7AJMypnJTApCXi1yMtb
         qR3A==
X-Gm-Message-State: AOJu0YzScjp2561A+sILwE8Zs6n3s0buD9dT4ZfSsnYKiZeIigpw8LIV
	nZuUWM+mV0qa9rX25HZd3FyOKEz/0drFr79EKPe3dK5Zp+D6iAPObUrPpM5+b/Qkmm9mTJK8PvK
	sSRgQkkQcJSdUYkpeylaO1RY731w=
X-Received: by 2002:a2e:828f:0:b0:2c9:e9eb:8ccb with SMTP id y15-20020a2e828f000000b002c9e9eb8ccbmr3769065ljg.69.1702479324253;
        Wed, 13 Dec 2023 06:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHviyKH7wfcVf+I7xtZv4/UFi1AvA8vImQUb3UJSgTbMIYjDNrX0hdJf2t7gC7r7QeAbgewkg==
X-Received: by 2002:a2e:828f:0:b0:2c9:e9eb:8ccb with SMTP id y15-20020a2e828f000000b002c9e9eb8ccbmr3769060ljg.69.1702479323843;
        Wed, 13 Dec 2023 06:55:23 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
        by smtp.gmail.com with ESMTPSA id ck9-20020a0564021c0900b0054f4097fea2sm5763020edb.0.2023.12.13.06.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:55:23 -0800 (PST)
Date: Wed, 13 Dec 2023 09:55:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231213094854-mutt-send-email-mst@kernel.org>
References: <20231208052150-mutt-send-email-mst@kernel.org>
 <53044.123120806415900549@us-mta-342.us.mimecast.lan>
 <20231209053443-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
 <20231211115329-mutt-send-email-mst@kernel.org>
 <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>
 <20231212111433-mutt-send-email-mst@kernel.org>
 <42870.123121305373200110@us-mta-641.us.mimecast.lan>
 <20231213061719-mutt-send-email-mst@kernel.org>
 <25485.123121307454100283@us-mta-18.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <25485.123121307454100283@us-mta-18.us.mimecast.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Dec 13, 2023 at 01:45:35PM +0100, Tobias Huschle wrote:
> On Wed, Dec 13, 2023 at 07:00:53AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Dec 13, 2023 at 11:37:23AM +0100, Tobias Huschle wrote:
> > > On Tue, Dec 12, 2023 at 11:15:01AM -0500, Michael S. Tsirkin wrote:
> > > > On Tue, Dec 12, 2023 at 11:00:12AM +0800, Jason Wang wrote:
> > > > > On Tue, Dec 12, 2023 at 12:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> [...]
> > 
> > Apparently schedule is already called?
> > 
> 
> What about this: 
> 
> static int vhost_task_fn(void *data)
> {
> 	<...>
> 	did_work = vtsk->fn(vtsk->data);  --> this calls vhost_worker if I'm not mistaken
> 	if (!did_work)
> 		schedule();
> 	<...>
> }
> 
> static bool vhost_worker(void *data)
> {
> 	struct vhost_worker *worker = data;
> 	struct vhost_work *work, *work_next;
> 	struct llist_node *node;
> 
> 	node = llist_del_all(&worker->work_list);
> 	if (node) {
> 		<...>
> 		llist_for_each_entry_safe(work, work_next, node, node) {
> 			<...>
> 		}
> 	}
> 
> 	return !!node;
> }
> 
> The llist_for_each_entry_safe does not actually change the node value, doesn't it?
> 
> If it does not change it, !!node would return 1.
> Thereby skipping the schedule.
> 
> This was changed recently with:
> f9010dbdce91 fork, vhost: Use CLONE_THREAD to fix freezer/ps regression
> 
> It returned a hardcoded 0 before. The commit message explicitly mentions this
> change to make vhost_worker return 1 if it did something.
> 
> Seems indeed like a nasty little side effect caused by EEVDF not scheduling
> the woken up kworker right away.


So we are actually making an effort to be nice.
Documentation/kernel-hacking/hacking.rst says:

If you're doing longer computations: first think userspace. If you
**really** want to do it in kernel you should regularly check if you need
to give up the CPU (remember there is cooperative multitasking per CPU).
Idiom::

    cond_resched(); /* Will sleep */


and this is what vhost.c does.

At this point I'm not sure why it's appropriate to call schedule() as opposed to
cond_resched(). Ideas?


-- 
MST

