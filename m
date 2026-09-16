Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB2F3B7749
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541192; cv=pass; b=eP25nRDBNjeVGqJSXyLcRL/xddGMjr4yKQZeTbAFmlHt180RzU01Jbaqwg5/LjySSH0tUQte12PGApmYgWHZ240zROiuLywvrUhBzegCS1EevWwRvOoDRxnP3+4gvZk+8ILhTYV4VHtyluisPh7ILd/b3iltVXGqVlGva1O+xaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541192; c=relaxed/simple;
	bh=XlFiHTz+Dihyzf4MnSf1LVtKdUui8dM4W7PbZ/5Xzys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AY0qp8kXeQmYIdak0lCRadhex/AdQ/XHgw0gz2IUFUR2TC4TTkt7ZGjEe9DYVtuOgTLnKxDCvr6HdXb4EMl/ZaA5iHoSk13pAQD3vknj1NK5nvSaQNL+5S4/gePLfHOqUlUPtsbSysR0QfcaIbjSmZZC4hKjM1gfBvMeyllISv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIyCXKO/; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIyCXKO/"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1651cso536865e87.0
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 23:46:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789541188; cv=none;
        d=google.com; s=arc-20260327;
        b=mWe1XrYvc5mW6w+CIu92a1S9GUsKVDnjPHl+jGqs5zBcljqQuXhRp+S60y/JnLaXkl
         nyxk80EQOPDhzIjhHd92IcBOb4ta9Ef/ckQV0iBZQA9e5n86fXFgRV+bslVK1jcrUdNG
         08FiKxLoWS7vuEQUOWeH9a+c4WwlCYEyMiaq7916UH8ANWX89eR2GOuB9MBUj0SYhhhB
         y+0td/T5lmi22N/+tamMOaW3kVUDOOyzwmS9++KQm4Xs0G4BKj+Y4JsK1jdnfo8U76tQ
         X0nhQcU9MUHsjrDf8jhWVFcBSpfY9IYbcCt6cfWI0k62/kihaWnkrCSdoSbFKDgjTvVH
         WZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=P6xB9GyEAaDD3YuwcLClG2nTPjFhbGFjC7xAq098W0Q=;
        fh=o+TmzkYtn/ul7EHTrKZo6VTLXJxU/iN72PsmdI0CHh4=;
        b=KOOuNVFHDozKeF8p8S/XjZ2/JcHCelTkbuUlRl0o9dAHVBj8i467rGllEfrkY83qiP
         n3utmkIsY12DlzdjO/d7isun+3CHjlkOIgT8Jt42BzDAj92p0dBSfvGuXWSrm3rYwFHM
         Jh3RGIlxYJFxWivqY9BJ5pdo0lReWZecu5h1b9tSmG2EV7lmhNfXvdLKeIyzSLkvEmkA
         g84owCpro6kHrr2KkfqFL4akHMtj4C8DeVQW5rEWjSQmCkHsFD2Aohz+KPtjpejUHrrq
         Q+K8Tl3gfBtf0VjBay21zPctr/RnlmYbNxYNnG4L4yOH/yozKXSdnG7oVb5tukF0GRbX
         WsLw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789541188; x=1790145988; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P6xB9GyEAaDD3YuwcLClG2nTPjFhbGFjC7xAq098W0Q=;
        b=QIyCXKO/CNpPcMKtyNcTSixKuAOHbUg2Z5GPwb6uZs4fB0XNEaN6s7XxM66WwfxE/5
         kLsrpb+XqcktB4S54nwuJIFDzJJxwXuGUL1vyLdfb1pKb1CBWD7xi7wnNDyVvO1NgMIx
         Ud9/be2mswrD3xrHljlPcTSFxNoF7HL8qctZ2wP48X/thzIvXowi/w2xZzo3tZ0gqfWl
         9oQzDaSUcIBaQku6oLEp64qKFT1bZ9xxKgyxcMw+ukQQDaPnkLt9RItp43BaNL/Nk+GJ
         VshhS5Cj81NMZU2USY/y+KYva/nr+rxp4qFRSeuyRI7ccnWNfti6zrxVMqpMOnoB2X4U
         P66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541188; x=1790145988;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P6xB9GyEAaDD3YuwcLClG2nTPjFhbGFjC7xAq098W0Q=;
        b=0Vfwqxv77YpExMEhQDHB18HKhC9TvtkUO9a5GE2Zb6RUSXmY8qhiXYm+XtriaZyolc
         4t/71vMVFR5MR8g6pJPUghjB4In9NWFx78lyipFwGt+ubBz3pFkpn2hxyHWz2WQr/eP8
         VZVBPI9+reBqVa0CFs7diTzwezqdnbcWssFu0YXwctXvaeGX2gLQxUiAm2kZP1K+oWk8
         kiG11aHo51k++ffMyXzcr0zqLnRp9fKXOBBlmDEfcHACMDkUSXSFkushhIc53bJiPzCZ
         qEe827B8czkN3r4JcUy+E/qdFG1pJnoORYy/RdcpqNsv9Pnut4SbHOj+i+kZqQHvp/kr
         rqWw==
X-Forwarded-Encrypted: i=1; AKwUvBwVnPjUjh9haQ0Hg2+HmbDZsVUWmAb68w49jzS8kUn1SIb+J4Gu2t5N3PMg9Bgo18zbYJrvpeTtV0GPkcplPg==@lists.linux.dev
X-Gm-Message-State: AFuF++lMihyNXqBB6C0ntwlZbtv8qr/X88u2Mkk8wiUsT4ddMvmSJn1g
	2Efu5rpyslr3wxB+K3FF86+v+Dh6EAuNxjF7A9J2g74LRA4yZKyVW5jcZFjclbmPVD9lIuM9tZ4
	VAhkBYm5MpGwvtcDV2QgRErA4NDHuhnM=
X-Gm-Gg: AYBFou1FMdslgDmbLQFIohiFTLgITxbfdVDEEhkyfd0O8n8xbO7i1EhSnn22ELBkjdl
	/Rcwj5GplqLd/K+x7Md8LPaM/iPBcI1JxJiI4L0Uf71c3+xirsGSNc7qpxwi4rUUIj//m2PK1y6
	sjT3eDsXuYNpaAmlmhiq7/3eAfyCC3B1Txsy9iMKvOpYAKnYCWpzgTsWG+8ArRToFfB5jv+TIP3
	bmCRLXrnOPXLsI9HT8mvd+f0jXeVMQMAA56RKbuL82UJg4tTeTPrIiGxkMoFKLzWNkYt7tlo4hS
	bv3PP629jyLJRwqw399RyXj2H453E68FN9eSG/QvGZEBuZwe5pjrWxcJ9232qE1vpL0H
X-Received: by 2002:a05:6512:1194:b0:5b6:17b6:f8d3 with SMTP id
 2adb3069b0e04-5b8b661e63amr330005e87.24.1789541187235; Tue, 15 Sep 2026
 23:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260908-fix-warning-in-sbitmap_get-v1-1-767c2c211a2b@gmail.com> <7a2ed1bc-bf7a-4744-84e2-72c79bd36f2a@oracle.com>
In-Reply-To: <7a2ed1bc-bf7a-4744-84e2-72c79bd36f2a@oracle.com>
From: Linfeng Sun <linfeng.sun.dev@gmail.com>
Date: Wed, 16 Sep 2026 14:46:12 +0800
X-Gm-Features: AcwNN1WNBnS3VJCLq8kKpzJnYh_F0LVNR17Lgzi-0b2V4lV0sCpEsqAPTIpRIks
Message-ID: <CA+kkGbsOD15psKucuvm2JEjHhjQdd3p+9439wK77JHkhqAvGYQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-scsi: initialize command pools for late I/O virtqueues
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 15, 2026 at 04:38:38PM -0500, Mike Christie wrote:
> On 9/8/26 9:30 AM, Linfeng Sun wrote:
> > vhost_scsi_set_endpoint() allocates command pools only for I/O virtqueues that
> > are already set up, but publishes the backend for every virtqueue. If userspace
> > finishes configuring a skipped queue later, a kick reaches vhost_scsi_get_cmd() with
> >
> >
> > vhost_scsi_set_endpoint() allocates command pools only for I/O virtqueues
> > that are already set up, but publishes the backend for every virtqueue. If
> > userspace finishes configuring a skipped queue later, a kick reaches
> > vhost_scsi_get_cmd() with scsi_tags uninitialized and triggers the
> > !sb->alloc_hint warning in sbitmap_get().
> >
> > Leave skipped I/O virtqueues inactive at SET_ENDPOINT. When SET_VRING_ADDR
> > later completes their setup, allocate the command pools and activate the
> > queues. Roll back both if access initialization fails.
> >
> > Fixes: 25b98b64e284 ("vhost scsi: alloc cmds per vq instead of session")
> > Signed-off-by: Linfeng Sun <linfeng.sun.dev@gmail.com>
> > ---
> > I checked QEMU and found no evidence it's affected. I haven't checked
> > VirtualBox because I am not familiar with it. However, the virtio spec
> > doesn't require a specific operation order, so a new VMM could still
> > trigger this issue.
> >
> > Crash log:
> > [   34.698961] ------------[ cut here ]------------
> > [   34.699385] WARNING: lib/sbitmap.c:286 at sbitmap_get+0x227/0x270, CPU#0: vhost-82/88
> > [   34.700542] Modules linked in:
> > [   34.701309] CPU: 0 UID: 0 PID: 88 Comm: vhost-82 Not tainted 7.3.0-rc2+ #14 PREEMPT(full)
> > [   34.701958] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [   34.702717] RIP: 0010:sbitmap_get+0x227/0x270
> > [   34.703247] Code: 41 8d 5d 01 89 df 44 89 fe e8 f5 3a 46 ff 31 c0 44 39 fb 0f 43 d8 e8 38 46 46 ff 65 41 89 1c 24 e9 25 ff ff ff e8 29 46 46 ff <0f> 0b eb ba e8 20 46 46 ff 44 89 fe 31 ff 45 31 e4 e8 c3 3b 46 ff
> > [   34.704234] RSP: 0018:ffffc90000ec3bb0 EFLAGS: 00000246
> > [   34.704677] RAX: 0000000000000000 RBX: ffff88800500dee8 RCX: 0000000000000000
> > [   34.705166] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88800500dee8
> > [   34.705584] RBP: ffffc90000ec3be0 R08: 0000000000000000 R09: 0000000000000000
> > [   34.705988] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000006
> > [   34.706477] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880050094d0
> > [   34.706955] FS:  0000000014d05380(0000) GS:ffff888099c36000(0000) knlGS:0000000000000000
> > [   34.707463] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   34.707854] CR2: 00007c0c3c20e000 CR3: 0000000008e47000 CR4: 00000000000006f0
> > [   34.708592] Call Trace:
> > [   34.709259]  <TASK>
> > [   34.709822]  vhost_scsi_handle_vq+0x4a9/0x1b20
> > [   34.710437]  ? update_cfs_rq_load_avg+0x2e/0x230
> > [   34.710874]  vhost_scsi_handle_kick+0x2c/0x40
> > [   34.711292]  vhost_run_work_list+0xa6/0xf0
> > [   34.711673]  vhost_task_fn+0x76/0x1b0
> > [   34.712003]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x30
> > [   34.712506]  ? recalc_sigpending+0xe1/0x130
> > [   34.712890]  ? __pfx_vhost_task_fn+0x10/0x10
> > [   34.713325]  ret_from_fork+0x37a/0x630
> > [   34.713673]  ? __pfx_vhost_task_fn+0x10/0x10
> > [   34.714031]  ret_from_fork_asm+0x1a/0x30
> > [   34.714535] RIP: 0033:0x0
> > [   34.715201] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > [   34.715587] RSP: 002b:0000000000000000 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > [   34.716158] RAX: 0000000000000000 RBX: 000000000048bb20 RCX: 000000000041ca3d
> > [   34.716571] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> > [   34.716957] RBP: 00007ffcac47c4e0 R08: 00000000ffffffff R09: 0000000000000000
> > [   34.717418] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
> > [   34.717826] R13: 00007ffcac47c778 R14: 00000000004af868 R15: 0000000000000001
> > [   34.718363]  </TASK>
> > ---
> >   drivers/vhost/scsi.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 42 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 4f8c0260bc9e..069a6ff4dd40 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -2008,6 +2008,40 @@ static int vhost_scsi_setup_vq_cmds(struct vhost_virtqueue *vq, int max_cmds)
> >     return -ENOMEM;
> >   }
> >
> > +/* Callers must hold dev mutex. */
> > +static int vhost_scsi_activate_vqs(struct vhost_scsi *vs)
> > +{
> > +   struct vhost_virtqueue *vq;
> > +   int i, ret = 0;
> > +
> > +   if (!vs->vs_tpg)
> > +           return 0;
> > +
> > +   for (i = VHOST_SCSI_VQ_IO; i < vs->dev.nvqs; i++) {
> > +           vq = &vs->vqs[i].vq;
> > +           mutex_lock(&vq->mutex);
> > +           if (vhost_vq_get_backend(vq) || !vhost_vq_is_setup(vq))
> > +                   goto unlock;
> > +
> > +           ret = vhost_scsi_setup_vq_cmds(vq, vq->num);
> > +           if (ret)
> > +                   goto unlock;
> > +
> > +           vhost_vq_set_backend(vq, vs->vs_tpg);
> > +           ret = vhost_vq_init_access(vq);
> > +           if (ret) {
> > +                   vhost_vq_set_backend(vq, NULL);
> > +                   vhost_scsi_destroy_vq_cmds(vq);
> > +           }
> > +unlock:
> > +           mutex_unlock(&vq->mutex);
> > +           if (ret)
> > +                   break;
> > +   }
> > +
> > +   return ret;
> > +}
> > +
> >   /*
> >    * Called from vhost_scsi_ioctl() context to walk the list of available
> >    * vhost_scsi_tpg with an active struct vhost_scsi_nexus
> > @@ -2105,6 +2139,9 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
> >
> >             for (i = 0; i < vs->dev.nvqs; i++) {
> >                     vq = &vs->vqs[i].vq;
> > +                   if (i >= VHOST_SCSI_VQ_IO && !vs->vqs[i].scsi_cmds)
> > +                           continue;
> > +
> >                     mutex_lock(&vq->mutex);>                        vhost_vq_set_backend(vq, vs_tpg);
> >                     vhost_vq_init_access(vq);
> > @@ -2466,10 +2503,13 @@ vhost_scsi_ioctl(struct file *f,
> >     default:
> >             mutex_lock(&vs->dev.mutex);
> >             r = vhost_dev_ioctl(&vs->dev, ioctl, argp);
> > -           if (r == -ENOIOCTLCMD)
> > +           if (r == -ENOIOCTLCMD) {
> >                     r = vhost_vring_ioctl(&vs->dev, ioctl, argp);
> > -           else
> > +                   if (!r && ioctl == VHOST_SET_VRING_ADDR)
> > +                           r = vhost_scsi_activate_vqs(vs);
> Is it ok to just not support the delayed setup? So just do the
> fix in vhost_scsi_set_endpoint?
>
A later SET_VRING_ADDR would still succeed while leaving the queue
inactive. If we donot support it, I think it should fail explicitly
instead of causing a silent I/O stall.

> Is this a useful feature?
>
No current VMM appears to rely on it, but the UAPI does not specify this
ordering. A new VMM could reasonably use it.

> I don't think net supports it. When it does the vhost_net_set_backend
> call it does vhost_vq_access_ok. If it's not ready to go then it
> returns failure.
>
Right, net returns an error for that VQ. Simply skipping a scsi VQ would
make the later ioctl succeed without activating it.

> If we supported this, then I think vhost_scsi_activate_vqs should
> active the specific virtqueue that VHOST_SET_VRING_ADDR is called
> for.

Agreed. I will change it to activate only that virtqueue.
