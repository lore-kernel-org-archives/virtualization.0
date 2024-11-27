Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB0F1494A6
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Nov 2024 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689871; cv=none; b=TKXl0w9shFyAlVdx8Rfl3PnbA9jS2NEiq59SnOOD/IWJ9RNiWfTizLmUfHmc1Wa6wJ+4voBzGGJoDyejRXnrF3y6BqyDde4+X77OFCsuduoCk+Mwr4EjWSGYWpRUM1PoOyNlqRL0hwMeQ1SBt1jtEIb8LC9NIjigwgJxe3xIplU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689871; c=relaxed/simple;
	bh=Adem4fDNDm4uOJzImDUmzo/9GG4HkxizaDKg1FXsy3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWjzK1nJhSANJMwGhNS9ZWycQj184XzaWcVImaNN5CIdn+zfzK1G9oz6I+A8QMC/1uUz0D1WhEiimAYa8xpRawe+CzAD/nPT+99BLZkIZOEP6+njjySVL/ECzcGDmUroXqupC6PvEohUC6XnDhlG8+B/f71YDzyygsYp0uKzXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdQyOWXA; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdQyOWXA"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 334124098C
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Nov 2024 06:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cdPcXlI0cg1T for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Nov 2024 06:44:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2772C40971
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2772C40971
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZdQyOWXA
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2772C40971
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Nov 2024 06:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732689867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdRqBIsob+HSQlVYogv7NSws9OUzt8+ABx+5vycAsxw=;
	b=ZdQyOWXA3ObyHQoYAJGGRcyY67f9ANbpJvir+pLZiJAnpndNPHVLjViWZ3BERCd1Dw/OBt
	dJTYQSp1a2rlJRTelpnj3kruLtj9aO7FVHG7nMZ8FbmORGnsoI4JK+9TSqZUdtVdVerBub
	znfmhy1dxd6vIsNAi+eWPQ+2XlMOidk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-P-mzqUx4NG2WjxBjjuyEVA-1; Wed, 27 Nov 2024 01:44:25 -0500
X-MC-Unique: P-mzqUx4NG2WjxBjjuyEVA-1
X-Mimecast-MFC-AGG-ID: P-mzqUx4NG2WjxBjjuyEVA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa55354400eso48378266b.1
        for <virtualization@lists.linux-foundation.org>; Tue, 26 Nov 2024 22:44:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732689864; x=1733294664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdRqBIsob+HSQlVYogv7NSws9OUzt8+ABx+5vycAsxw=;
        b=feJHWwYQINcrw0blZ4ZuYCyaahWEWp3a/7dIVf/+xL2D7vDgZPxlJ63CkHQVI+Mpjm
         +3Z+nFvBE0lPmax5LLUxrM0jhymyO8fPOJ+HtwFuk8B+TEpsnV9u6WeksftZ7N6K7R1f
         TkH1KxKdntUUmWkKNJnkCxWF8zY2tIA3iE2x4kysYhL0bg+ilXkAydDZnz3hbft1QYOq
         Dhw9tgj/uAgzHHcDb7ZBxQDwBA/6lvRCPTf8IymaLkW47eIdJrNLKhe0URpmUHViHQAE
         jR1e9x9nL0Ah2P/XQu8RWOftuT0jZrGsAdyoLz84orVqchE1QMrZk6hdYptb3Qr0zIPV
         G/LA==
X-Forwarded-Encrypted: i=1; AJvYcCXNbGMQ7mokrEjCMTi96iQ0G0FklJJRZ/YBsw25rZ9ywGR+h820pzKMPf+pvAke6qP0yCUVznqi/K53KcHs8w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywl/FzxEG2lfwSDsOcNu8Ldjwagrzg+NWsoKJqkDiCzARervzlt
	40IqVWjgTVcGGIl0ihgDlzbjxB70Yl5VF3+6Mz1RlpZukUCD8lTHCOvoo8m8i/iymVofqXglB83
	dbr/hlpcVE9MWNr35gHEDHnl6vAEECH060WUdpB4zNd1BZ+NOH7x1kqNF1q4nvqPtIHDtdKs3FE
	09Ly6pASgACz3Gjfy3WmCZHMVXMVIxa4MCci+70YNQfHkGt1okUO0vcA==
X-Gm-Gg: ASbGncu2zImxTcTUSvcrfyq50VfrMf4Hh1x6uuhFHl7EezZJtZC5FBrSYD+y/TRfFuE
	VinT9McCJ3ke1JcujA6HbIZy0bUm6x5Fz
X-Received: by 2002:a17:907:2cc6:b0:a99:3db2:eb00 with SMTP id a640c23a62f3a-aa5649cf412mr648869166b.28.1732689863798;
        Tue, 26 Nov 2024 22:44:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExZ32B7TxPPlBNx/gDPoxy1NSbfDzaO3j+hHsSRz0S0ZDH0lfDAjhj4c4mRiL8YGZcb7T/QzEjIE9kOhP+9jM=
X-Received: by 2002:a17:907:2cc6:b0:a99:3db2:eb00 with SMTP id
 a640c23a62f3a-aa5649cf412mr648867366b.28.1732689863496; Tue, 26 Nov 2024
 22:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-5-lulu@redhat.com>
 <5dcd0aa9-f098-4aac-a053-9693761ff550@oracle.com>
In-Reply-To: <5dcd0aa9-f098-4aac-a053-9693761ff550@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 27 Nov 2024 14:43:44 +0800
Message-ID: <CACLfguU_xqxu5b0D8RoEFAb5Z8Xp4H8v2f5UeLG74kSZcthfOw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] vhost: Add kthread support in function vhost_worker_create
To: michael.christie@oracle.com
Cc: jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ctt3W9f2CcXo5UBqa9_VtqF2pcNm_sEWeNjILsuVLGQ_1732689864
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 5:20=E2=80=AFAM <michael.christie@oracle.com> wrote=
:
>
> On 11/5/24 1:25 AM, Cindy Lu wrote:
> >  static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> >  {
> >       struct vhost_worker *worker;
> > -     struct vhost_task *vtsk;
> > +     struct vhost_task *vtsk =3D NULL;
> > +     struct task_struct *task =3D NULL;
> >       char name[TASK_COMM_LEN];
> >       int ret;
> >       u32 id;
> >
> > +     /* Allocate resources for the worker */
> >       worker =3D kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> >       if (!worker)
> >               return NULL;
> >
> > +     worker->fn =3D kzalloc(sizeof(struct vhost_task_fn), GFP_KERNEL_A=
CCOUNT);
> > +     if (!worker->fn) {
> > +             kfree(worker);
> > +             return NULL;
> > +     }
>
> Why dynamically allocate this?
>
> You could probably even just kill the vhost_task_fn struct since we just
> have to the 2 callouts.

sure, will change this
>
>
> > +
> >       worker->dev =3D dev;
> >       snprintf(name, sizeof(name), "vhost-%d", current->pid);
> >
> > -     vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_kill=
ed,
> > -                              worker, name);
> > -     if (!vtsk)
> > -             goto free_worker;
> > -
> >       mutex_init(&worker->mutex);
> >       init_llist_head(&worker->work_list);
> >       worker->kcov_handle =3D kcov_common_handle();
> > -     worker->vtsk =3D vtsk;
> >
> > -     vhost_task_start(vtsk);
> > +     if (dev->inherit_owner) {
> > +             /* Create and start a vhost task */
>
> Maybe instead of this comment and the one below write something about
> what inherit_owner means. We can see from the code we are creating a
> vhost/kthread, but it's not really obvious why. Something like:
>
> /*
>  * If inherit_owner is true we use vhost_tasks to create
>  * the worker so all settings/limits like cgroups, NPROC,
>  * scheduler, etc are inherited from the owner. If false,
>  * we use kthreads and only attach to the same cgroups
>  * as the owner for compat with older kernels.
>  */
>
Thanks, Mike=EF=BC=8C I will change this

>
>
> > +             vtsk =3D vhost_task_create(vhost_run_work_list,
> > +                                      vhost_worker_killed, worker, nam=
e);
> > +             if (!vtsk)
> > +                     goto free_worker;
> > +
> > +             worker->vtsk =3D vtsk;
> > +             worker->fn->wakeup =3D vhost_task_wakeup_fn;
> > +             worker->fn->stop =3D vhost_task_stop_fn;
> > +
> > +             vhost_task_start(vtsk);
> > +     } else {
> > +             /* Create and start a kernel thread */
> > +             task =3D kthread_create(vhost_run_work_kthread_list, work=
er,
> > +                                   "vhost-%d", current->pid);
> > +             if (IS_ERR(task)) {
> > +                     ret =3D PTR_ERR(task);
> > +                     goto free_worker;
> > +             }
> > +             worker->task =3D task;
> > +             worker->fn->wakeup =3D vhost_kthread_wakeup_fn;
> > +             worker->fn->stop =3D vhost_kthread_stop_fn;
> > +
> > +             wake_up_process(task);
> > +             /* Attach to the vhost cgroup */
>
> You don't need this comment do you? The function name tells us the same
> info.
>
sure, Will remove  this
> > +             ret =3D vhost_attach_cgroups(dev);
>
> I don't think this works. Patch 3/9 did:
>
> +       xa_for_each(&dev->worker_xa, i, worker) {
> +               ret =3D vhost_worker_cgroups_kthread(worker);
>
> but we don't add the worker to the xa until below.
>
> You also want to just call vhost_worker_cgroups_kthread above, because
> you only want to add the one task and not loop over all of them.
>
> I would then also maybe rename vhost_worker_cgroups_kthread to something
> like vhost_attach_task_to_cgroups.
>
>
Will fix this. Thanks
>
> > +             if (ret)
> > +                     goto stop_worker;
> > +     }
> >
> >       ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> >       if (ret < 0)
> >               goto stop_worker;
> >       worker->id =3D id;
> > -
> >       return worker;
> > -
> >  stop_worker:
> > -     vhost_task_stop(vtsk);
> > +     worker->fn->stop(dev->inherit_owner ? (void *)vtsk : (void *)task=
);
>
> I don't think you need to cast since the function takes a void pointer.
> Same comment for the other patches like 6/9 where you are calling the
> callout and casting.
>
Sure, Thanks I will rewrite this part
Thanks
cindy

