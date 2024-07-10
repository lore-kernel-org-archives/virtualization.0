Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC03A1B86EC
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720596529; cv=none; b=pyiZPH8pY+cL28Djeh5AoAG60iDjNV3gSJ8kvJTJIl8lNyFPLnwncQ0o1oWKKuiLLRCY/s8il7t9blXO7+s+jpWQWSyUdxnanz8wgLGYEV+ySHrn/s+NvZudxyxvxovsBfYD0fM53gse0SN8hnGF7N/5k1nOocwohdlfM7I1JR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720596529; c=relaxed/simple;
	bh=xQh5HU5tluzMTaHOeOkGuFGYbA1Vq50E5qJn6PoW5Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCqV5tfLKo27fqVYNWlr0q9M6QTzoV1Teo+s3VZC426KSh4zggSbJ49Q+IokGMx8zLH9GhcQsB3EPEJxIfL9I3Fi5oFf0iTYDK5SYQOi/EbvDsUkSP3fzuClPxWaKkdLWSGgadEuvE3VzeYjtbN5egm8kDytU6E51cMqCGypwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ECa4fzQV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECa4fzQV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720596526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxCFFb+O+FYVotTIPR8WWbYkloVGsx7sbWOFar1qXXo=;
	b=ECa4fzQV7GbOGINJ2gVAxJGosPS9hVBA+AeAZzNQ6jWY3K2fHYU0XVLMbYio6SVEXd/1SP
	5eZM/ilEkKnMInegCyzLx3wWX7xcsuJkCuMuDsemCY04iBdRlaFuHvmSYiDmKz6NhR/PEc
	mrh3Ga7NDJrQBuKg0pq5aU4weiMdsZQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-GvoLw9a-Oiu77DmwCLAOYw-1; Wed, 10 Jul 2024 03:28:44 -0400
X-MC-Unique: GvoLw9a-Oiu77DmwCLAOYw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-25e08ee43f6so4208200fac.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 00:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720596524; x=1721201324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxCFFb+O+FYVotTIPR8WWbYkloVGsx7sbWOFar1qXXo=;
        b=oz23HFeP2mzjCnsdHJeJQ5UE0IjwxZDes3kMsXXUwe4mcmmFiMuyIZK/Vn83lvGhdN
         yVUVuSAz4invia8nndJ6+zQQps/OHHl1qEOBKA2htF5E6ixuxW+EES3xKMtR6/2N6SvC
         woNBbHEhsbzLqulk+My5cN070AmBm2nT2LJVUBbrPYnJOoo41ldZ2tBK/CGjzbuxnrsK
         PXjMl3pyo9Bdb+/dHKxXu1KpbhfxKmn0Rf3jaJgEFsO3tyvPWoRqfXTBUBpykEL/oI2O
         cuTT3Tdd+b6J5PXZjR77I/+LnWnflLKgQWQNytVl6bOBmmhI5ZgbHwVUjx15X8mDLJks
         0omA==
X-Forwarded-Encrypted: i=1; AJvYcCVZhU22H4O3ha5UxmQ9LzcuN9LXwV48KFY8VdN16xFsqyp4vYQ41vuJHN1YPQD1x/68XyY5q0DYywjWqGRmrchW9ujFxPZGTAES+LSxVys=
X-Gm-Message-State: AOJu0YyZSLWir1g+0MpdBoZw1T2lDj9etYMw1ukalCarQ6+xlT77iZTD
	UQb/d2JSRtR6+AJgxyTG601+cnxECNRBqMWIzmhWov3h+C8VKY9GIK2Vu0ptwzrz9T4ybevSnPR
	qpEQ+03bkuqSwjEbNsdCQkDgOQinskh9HVjNpO50mdHwM6cAbsce7v7ZjOjCuEFzntV5/1FGbZv
	gTj9WgTQJNs79hiFfDSYcWHyZRa8r8L2pPWN9KVjo=
X-Received: by 2002:a05:6870:71c9:b0:25e:ebb:b4f4 with SMTP id 586e51a60fabf-25eae75fa03mr3659221fac.2.1720596524025;
        Wed, 10 Jul 2024 00:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOTIeMcESujn8AqeMOf7hlU3PPNIoV11WktqFb+Dz6M9e/IfuDLcZm0kQUi5duDpXKsbY8UOxkXk1JPmgkqvQ=
X-Received: by 2002:a05:6870:71c9:b0:25e:ebb:b4f4 with SMTP id
 586e51a60fabf-25eae75fa03mr3659213fac.2.1720596523579; Wed, 10 Jul 2024
 00:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240705112821.144819-1-sgarzare@redhat.com> <20240705073017-mutt-send-email-mst@kernel.org>
 <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
 <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
 <CACGkMEurseUpMKaiLpJEkcT9U_tmqm4yqp3OgR--6XnAY=C9WQ@mail.gmail.com>
 <3f5d33l4c73nudppajvhnjhpdpvft5yolm7vdraikany2tfdjz@i62d45j4ucs5>
 <CACGkMEuqiAx-a0sPJf0Xpvmr=5wbzbuOr0-w+9ZcwQMTWFU1rw@mail.gmail.com>
 <xuruyrbkago7w7tjbvqmfvjoqy665srurqozbenfayagfxl72y@wqy56jenfo2u>
 <CACGkMEtB1maGywWRPNHgVGJog+rbowXvKG0nEDXPn_9-VB0Azw@mail.gmail.com> <emhlvvttkq5yqcbphdkyrcmcxpyk22uxe2eiohmrapmjrv4vsz@zbiixmblizcj>
In-Reply-To: <emhlvvttkq5yqcbphdkyrcmcxpyk22uxe2eiohmrapmjrv4vsz@zbiixmblizcj>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 15:28:31 +0800
Message-ID: <CACGkMEtT-UeLk6Hv1AFXk_yhiVxx-5tWknqs=OYg8+cAGDmd9w@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 3:19=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Jul 10, 2024 at 11:08:48AM GMT, Jason Wang wrote:
> >On Tue, Jul 9, 2024 at 8:41=E2=80=AFPM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >>
> >> On Tue, Jul 09, 2024 at 10:56:16AM GMT, Jason Wang wrote:
> >> >On Mon, Jul 8, 2024 at 4:15=E2=80=AFPM Stefano Garzarella <sgarzare@r=
edhat.com> wrote:
> >> >>
> >> >> Hi Cindy, Jason,
> >> >>
> >> >> On Mon, Jul 08, 2024 at 03:59:34PM GMT, Jason Wang wrote:
> >> >> >On Mon, Jul 8, 2024 at 3:06=E2=80=AFPM Cindy Lu <lulu@redhat.com> =
wrote:
> >> >> >>
> >> >> >> On Fri, 5 Jul 2024 at 20:42, Stefano Garzarella <sgarzare@redhat=
.com> wrote:
> >> >> >> >
> >> >> >> > On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wro=
te:
> >> >> >> > >On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella =
wrote:
> >> >> >> > >> The vDPA block simulator always allocated a 128 MiB ram-dis=
k, but some
> >> >> >> > >> filesystems (e.g. XFS) may require larger minimum sizes (se=
e
> >> >> >> > >> https://issues.redhat.com/browse/RHEL-45951).
> >> >> >> > >>
> >> >> >> > >> So to allow us to test these filesystems, let's add a modul=
e parameter
> >> >> >> > >> to control the size of the simulated virtio-blk devices.
> >> >> >> > >> The value is mapped directly to the `capacity` field of the=
 virtio-blk
> >> >> >> > >> configuration space, so it must be expressed in sector numb=
ers of 512
> >> >> >> > >> bytes.
> >> >> >> > >>
> >> >> >> > >> The default value (0x40000) is the same as the previous val=
ue, so the
> >> >> >> > >> behavior without setting `capacity` remains unchanged.
> >> >> >> > >>
> >> >> >> > >> Before this patch or with this patch without setting `capac=
ity`:
> >> >> >> > >>   $ modprobe vdpa-sim-blk
> >> >> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> >> >> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> >> >> >> > >>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks =
(134 MB/128 MiB)
> >> >> >> > >>
> >> >> >> > >> After this patch:
> >> >> >> > >>   $ modprobe vdpa-sim-blk capacity=3D614400
> >> >> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> >> >> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> >> >> >> > >>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks =
(315 MB/300 MiB)
> >> >> >> > >>
> >> >> >> > >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> >> >> > >
> >> >> >> > >What a hack. Cindy was working on adding control over config
> >> >> >> > >space, why can't that be used?
> >> >> >> >
> >> >> >> > If it can be used easily with virtio-blk device too, it will b=
e great.
> >> >> >> > @Cindy do you plan to support that changes for a virtio-blk de=
vice too?
> >> >> >> >
> >> >> >> Hi Stefano
> >> >> >> I plan to add support to change the vdpa device's configuration =
after
> >> >> >> it is created.
> >> >> >
> >> >> >I think for Stefano's case, we can just implement it via provision=
ing
> >> >> >parameters?
> >> >>
> >> >> Yep, I think we don't need to change it after creation, but specify=
ing
> >> >> while creating should be enough.
> >> >>
> >> >> So, IIUC we can already do it, implementing something similar to
> >> >> vdpasim_net_setup_config() to call during vdpasim_blk_dev_add(), ri=
ght?
> >> >
> >> >Right.
> >> >
> >> >>
> >> >> What about when we have `shared_backend` set to true for the
> >> >> vdpa_sim_blk.ko? In this case the backend is supposed to be shared
> >> >> between all the devices to test live migration.
> >> >
> >> >This seems to be another topic.
> >>
> >> Yep, but really related. I think we need to handle that case when
> >> supporting the `capacity` setting.
> >
> >Ok, so if I was not wrong, the goal is to test migration.
>
> Sorry, I was not clear, I try to rephrase:
> vdpa_sim_blk already supports a module parameter called `shared_backend`
> introduced mainly to test live migration on the same host. When that
> parameter is on, all the created devices share the same backend and so
> we can easily do migration from one to another.
>
> With that parameter on or off, the device is always 128 MB, but now
> that's a problem for testing, because it looks like XFS requires at
> least 300 MB: https://issues.redhat.com/browse/RHEL-45951
>
> That's why I sent this patch.
>
> When `shared_backend` is off (default), using the provisioning
> parameters seems feasible to me, but when it's on, how do I deal with
> it?
>
> Being a simulator, we can maybe make it so that only the first device
> can change the size for example, or that all devices control the size,
> but then we would have to handle the size change at runtime, which I
> think is feasible, but it requires some work to send a notification of
> configuration change, etc.

Can we mandate the size parameter to be exactly the same as the first
vDPA block simulator?

>
> >
> >>
> >> >
> >> >>
> >> >> Maybe we can just change the size of the shared ramdisk to be refle=
cted
> >> >> to all devices.
> >> >>
> >> >> Suggestions?
> >> >
> >> >Could we specify the path to tmpfs or others during provisioning
> >> >instead?  It seems more general (but more work).
> >>
> >> Then it would almost become a real device, no longer just a simulator.
> >> It's enough work, though, as you said, but at that point we'd just hav=
e
> >> to specify the backend file to use for the device.
> >>
> >> In that case what API would we need to use to allow the user to set th=
e
> >> backend file?
> >
> >Yes, I think we can allow some vendor specific provisioning parameters.
> >
> >But not sure it's an overkill for the use case here. If others are
> >happy with the shared_backed. I'm fine.
>
> Yeah, maybe it's overkill and I don't have much time these days :-(
>
> I think the easiest way is to merge this patch, but I understand that a
> module parameter is not very beautiful
>
> I'll try to see if I can implement provisioning parameters for
> vdpa_sim_blk. Allowing capacity to be set only to the first device if
> `shared_backend` is on.
>
> WDYT?

Something like this.

When there's no block simulator, allow an arbitrary capacity. When
there is one, fail the creation when the capacity doesn't match. (when
'shared_backend' is on).

Thanks

>
> Thanks,
> Stefano
>

