Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6A1C54EBD
	for <virtualization@archiver.kernel.org>; Thu, 12 Jan 2023 04:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79BB9607AA;
	Thu, 12 Jan 2023 04:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 79BB9607AA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SM57v6Fy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ppglkgj2twtN; Thu, 12 Jan 2023 04:02:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ACF68607C9;
	Thu, 12 Jan 2023 04:02:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ACF68607C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77C2FC0032;
	Thu, 12 Jan 2023 04:02:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07DD7C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 04:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAAA7417C5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 04:02:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAAA7417C5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SM57v6Fy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vLCv65vm8R-4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 04:02:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D355417C3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D355417C3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 04:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673496168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Ead6NbYjGEcOLExh9Mv61ETFXQQrhvNXO4fmiWeGhg=;
 b=SM57v6Fy6RLpJYzThdkqInXSkLBBZW4mqglQjKbgRg8lRHP2nOKjDKobdoAL+qEyxdQEKj
 rgwwJmratw+yX0SKKQh+BoWm55ntWgMhSgece0A7xjRynSOOgiYizZsQ7aZdCcNL+tgGYx
 6fFVelosa+DV1XUFguqGhCWIAyXhl1k=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-83-vlFgPOawNIqpwQCFQiB3kA-1; Wed, 11 Jan 2023 23:02:47 -0500
X-MC-Unique: vlFgPOawNIqpwQCFQiB3kA-1
Received: by mail-oo1-f72.google.com with SMTP id
 j14-20020a4a750e000000b004e0f07d00ccso6254335ooc.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 20:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Ead6NbYjGEcOLExh9Mv61ETFXQQrhvNXO4fmiWeGhg=;
 b=RTbbcfambfTWNw0XcykQQuFW2sxMeh5t9NwBRSYu3I+k/XKCUFnWxt66HN4OBL2v+l
 iCBpNLIuiKCsHe8RBRtYXsIQu1DVtVnkVxpvQcSKTrF+zxGd6lwDqYVW5gBzUKB/r1jy
 nLYYddoEGkeu5HtgfJiYkho2HaPAI4rWkzrxWLrxVffSkPPSYow1V4ZV8ahuwTNTVr/d
 gfqoVhmYl33TDbcJPUr8o43HNDL9E9RrrhaQcycE7xw/TyD9jDJRabM8F/ZYQNWxU+U7
 7W7IoLef/if6q773yrc6KN/vHEJOOXJGWhSQL8/fAYNXoMrYwkKPa5RxHOe9LjWlQ06Z
 h0OQ==
X-Gm-Message-State: AFqh2koXoSGSAOkhdDeNaybMtyYa2eGTeKDH+oNwb8FR+fRCWnK+Zv3K
 KulJ1KOS36Xwzk/FPky+/dwySRKLI1NGmXSxKcyFeRqa22Ga9X4je9Ob+DHQeg4vgucg0NPVxn7
 NCRybjiG0pAUvcDqvqOPl34vV3zJIb+v8QDi3/3eGR64NYWOtwFNkYfsZOg==
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr4131311oah.35.1673496166833; 
 Wed, 11 Jan 2023 20:02:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs23GgCUjE+n1ZMX3l44UXf7JP96onjuoMkRSJyeIQHYTd/0zJHvVdCU1raqdOjILjzA9GfGaIqELD3q2P6bPU=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr4131300oah.35.1673496166467; Wed, 11
 Jan 2023 20:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20230111060730.24779-1-jasowang@redhat.com>
 <Y78Lfmzr6s1BU3ri@fedora>
In-Reply-To: <Y78Lfmzr6s1BU3ri@fedora>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jan 2023 12:02:35 +0800
Message-ID: <CACGkMEukZ42N4ZNbGvn6gr3C74aAbFpot-4Zeyp0GL7LmS9tRw@mail.gmail.com>
Subject: Re: [PATCH] vhost-scsi: unbreak any layout for response
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bcodding@redhat.com, Al Viro <viro@zeniv.linux.org.uk>, pbonzini@redhat.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jan 12, 2023 at 3:18 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Wed, Jan 11, 2023 at 02:07:30PM +0800, Jason Wang wrote:
> > Al Viro said:
> >
> > """
> > Since "vhost/scsi: fix reuse of &vq->iov[out] in response"
> > we have this:
> >                 cmd->tvc_resp_iov = vq->iov[vc.out];
> >                 cmd->tvc_in_iovs = vc.in;
> > combined with
> >                 iov_iter_init(&iov_iter, ITER_DEST, &cmd->tvc_resp_iov,
> >                               cmd->tvc_in_iovs, sizeof(v_rsp));
> > in vhost_scsi_complete_cmd_work().  We used to have ->tvc_resp_iov
> > _pointing_ to vq->iov[vc.out]; back then iov_iter_init() asked to
> > set an iovec-backed iov_iter over the tail of vq->iov[], with
> > length being the amount of iovecs in the tail.
> >
> > Now we have a copy of one element of that array.  Fortunately, the members
> > following it in the containing structure are two non-NULL kernel pointers,
> > so copy_to_iter() will not copy anything beyond the first iovec - kernel
> > pointer is not (on the majority of architectures) going to be accepted by
> > access_ok() in copyout() and it won't be skipped since the "length" (in
> > reality - another non-NULL kernel pointer) won't be zero.
> >
> > So it's not going to give a guest-to-qemu escalation, but it's definitely
> > a bug.  Frankly, my preference would be to verify that the very first iovec
> > is long enough to hold rsp_size.  Due to the above, any users that try to
> > give us vq->iov[vc.out].iov_len < sizeof(struct virtio_scsi_cmd_resp)
> > would currently get a failure in vhost_scsi_complete_cmd_work()
> > anyway.
> > """
> >
> > However, the spec doesn't say anything about the legacy descriptor
> > layout for the respone. So this patch tries to not assume the response
> > to reside in a single separate descriptor which is what commit
> > 79c14141a487 ("vhost/scsi: Convert completion path to use") tries to
> > achieve towards to ANY_LAYOUT.
> >
> > This is done by allocating and using dedicate resp iov in the
> > command. To be safety, start with UIO_MAXIOV to be consistent with the
> > vhost core.
> >
> > Testing with the hacked virtio-scsi driver that use 1 descriptor for 1
> > byte in the response.
> >
> > Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Benjamin Coddington <bcodding@redhat.com>
> > Cc: Nicholas Bellinger <nab@linux-iscsi.org>
> > Fixes: a77ec83a5789 ("vhost/scsi: fix reuse of &vq->iov[out] in response")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vhost/scsi.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index dca6346d75b3..7d6d70072603 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -80,7 +80,7 @@ struct vhost_scsi_cmd {
> >       struct scatterlist *tvc_prot_sgl;
> >       struct page **tvc_upages;
> >       /* Pointer to response header iovec */
> > -     struct iovec tvc_resp_iov;
> > +     struct iovec *tvc_resp_iov;
> >       /* Pointer to vhost_scsi for our device */
> >       struct vhost_scsi *tvc_vhost;
> >       /* Pointer to vhost_virtqueue for the cmd */
> > @@ -563,7 +563,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
> >               memcpy(v_rsp.sense, cmd->tvc_sense_buf,
> >                      se_cmd->scsi_sense_length);
> >
> > -             iov_iter_init(&iov_iter, ITER_DEST, &cmd->tvc_resp_iov,
> > +             iov_iter_init(&iov_iter, ITER_DEST, cmd->tvc_resp_iov,
> >                             cmd->tvc_in_iovs, sizeof(v_rsp));
> >               ret = copy_to_iter(&v_rsp, sizeof(v_rsp), &iov_iter);
> >               if (likely(ret == sizeof(v_rsp))) {
> > @@ -594,6 +594,7 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, struct vhost_scsi_tpg *tpg,
> >       struct vhost_scsi_cmd *cmd;
> >       struct vhost_scsi_nexus *tv_nexus;
> >       struct scatterlist *sg, *prot_sg;
> > +     struct iovec *tvc_resp_iov;
> >       struct page **pages;
> >       int tag;
> >
> > @@ -613,6 +614,7 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, struct vhost_scsi_tpg *tpg,
> >       sg = cmd->tvc_sgl;
> >       prot_sg = cmd->tvc_prot_sgl;
> >       pages = cmd->tvc_upages;
> > +     tvc_resp_iov = cmd->tvc_resp_iov;
> >       memset(cmd, 0, sizeof(*cmd));
> >       cmd->tvc_sgl = sg;
> >       cmd->tvc_prot_sgl = prot_sg;
> > @@ -625,6 +627,7 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, struct vhost_scsi_tpg *tpg,
> >       cmd->tvc_data_direction = data_direction;
> >       cmd->tvc_nexus = tv_nexus;
> >       cmd->inflight = vhost_scsi_get_inflight(vq);
> > +     cmd->tvc_resp_iov = tvc_resp_iov;
> >
> >       memcpy(cmd->tvc_cdb, cdb, VHOST_SCSI_MAX_CDB_SIZE);
> >
> > @@ -935,7 +938,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
> >       struct iov_iter in_iter, prot_iter, data_iter;
> >       u64 tag;
> >       u32 exp_data_len, data_direction;
> > -     int ret, prot_bytes, c = 0;
> > +     int ret, prot_bytes, i, c = 0;
> >       u16 lun;
> >       u8 task_attr;
> >       bool t10_pi = vhost_has_feature(vq, VIRTIO_SCSI_F_T10_PI);
> > @@ -1092,7 +1095,8 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
> >               }
> >               cmd->tvc_vhost = vs;
> >               cmd->tvc_vq = vq;
> > -             cmd->tvc_resp_iov = vq->iov[vc.out];
> > +             for (i = 0; i < vc.in ; i++)
> > +                     cmd->tvc_resp_iov[i] = vq->iov[vc.out + i];
>
> Where is the guarantee that vc.in < UIO_MAXIOV?
>

We limit it here in the vhost_virtqueue structure:

        struct iovec iov[UIO_MAXIOV];

And we pass sizeof(vq->iov) to vhost_get_vq_desc():

        vc->head = vhost_get_vq_desc(vq, vq->iov,
                                     ARRAY_SIZE(vq->iov), &vc->out, &vc->in,
                                     NULL, NULL);

> >               cmd->tvc_in_iovs = vc.in;
> >
> >               pr_debug("vhost_scsi got command opcode: %#02x, lun: %d\n",
> > @@ -1461,6 +1465,7 @@ static void vhost_scsi_destroy_vq_cmds(struct vhost_virtqueue *vq)
> >               kfree(tv_cmd->tvc_sgl);
> >               kfree(tv_cmd->tvc_prot_sgl);
> >               kfree(tv_cmd->tvc_upages);
> > +             kfree(tv_cmd->tvc_resp_iov);
> >       }
> >
> >       sbitmap_free(&svq->scsi_tags);
> > @@ -1508,6 +1513,14 @@ static int vhost_scsi_setup_vq_cmds(struct vhost_virtqueue *vq, int max_cmds)
> >                       goto out;
> >               }
> >
> > +             tv_cmd->tvc_resp_iov = kcalloc(UIO_MAXIOV,
> > +                                            sizeof(struct page *),
> > +                                            GFP_KERNEL);
>
> Should sizeof(struct page *) be sizeof(struct iovec)?

Yes, I will fix it.

Thanks

>
> > +             if (!tv_cmd->tvc_resp_iov) {
> > +                     pr_err("Unable to allocate tv_cmd->tvc_resp_iov\n");
> > +                     goto out;
> > +             }
> > +
> >               tv_cmd->tvc_prot_sgl = kcalloc(VHOST_SCSI_PREALLOC_PROT_SGLS,
> >                                              sizeof(struct scatterlist),
> >                                              GFP_KERNEL);
> > --
> > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
