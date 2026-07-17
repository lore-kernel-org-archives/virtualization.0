Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB5533AD88
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784321939; cv=pass; b=lYl2DB8cJMUnb5QUDwTppyj8YTZSKe2G/xkaRqJYq8VD6NBgYsb8f8FoiY8PZny3ouwnJhheW5dmVC382TmMzG57Z5hLCd9AdLUfcTsYYxXqmWLphWtJhPz11E4yOyYTO0STv326xg4a3/EfJx2SMHlyT0GkK7GQGK/P4OKeuCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784321939; c=relaxed/simple;
	bh=Oxp3VE6W5OESCDk/lq8ld8+/tNlpFRwfjSzVyS347CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fu6vjF6Pm8hyBzEVr0pOztAklLkc18ZQ9pvwx7eSBkgGMlEEDPuz6PTpgqwrc5Dhyujh4VI7oo4TR02b1Cs5jtGMDVKxNZ9a9rIZ+ZLRHFcDgBf7eMYrULE/vBaZrAwJy0q6Lphl7KHbUW5cnCW3ZP6a+olElNVJQk/i7UZ3pBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pXUwNEnt; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pXUwNEnt"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cab97c86bdso230335ad.1
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 13:58:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784321936; cv=none;
        d=google.com; s=arc-20260327;
        b=sckJA0xvEGoYJ2FrRbKrrEg5+aKGsrTBRJmkq2jgBeXEAM5uGnzHVU+ials2541dFL
         QkquleyRv0763rSO2URsRe7w2v6LzHpeYlXGg7qmdFeyaCmpWhM20G2PSInYjCZPPAO4
         kDDyNEbhQbwRT8S9ujBuTUb2J4hDHnfR7EP24jXMZpurD6VsyhNA2Bz03/oRG7F6zzAN
         tFq8VCBTKZsmr81bTEbvGJ3b9S3FnET15lrMAQ0AsacV/cH5df/941rWix3Meb9LAIZb
         +z8vX/EKcBGQ3m8OTHMyvWh/MDo38dz8ArFlhr+14wbGJaWergVROg/3XlGzRh/hu6ET
         j06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WnfgE1H7K7/mC+v3TIpWo3qvxDALdn1GWtbi9ajFYHA=;
        fh=nYNCgSLyEm/tHjdC0fN9OQHpAo429uhkje6wyIk8A28=;
        b=SpurkoNRxC84LKABHcNbfGqFOa3Fv6Y1pdzLDzwGbRtX8CWB35PR17l/m4WYxFvFYO
         AJfPhjSVqLjpCg3/3Xn5JG1Wifgq2HBEGim3wdezbjM+mZ3nmEqz4zJoFAvRp59jlDKw
         kvQWa1d24qsqnAMNukEiWFNFgbpYKE/UoNIsQan16kY0hb6AUEUNfufnqVqmSX2aj3le
         DdnErnf1AEO73qEaYX3KpLRq79XoejoK8P2knzpfo+kszV4C3stGwHaKdl9mADiU/lcn
         vW14+/6i7O+r6aeb8x24r1K5rsrxTt9arUYr642zNIHdr1NV+oAK3Ve4gih2QYUY65G5
         Y0pg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784321936; x=1784926736; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WnfgE1H7K7/mC+v3TIpWo3qvxDALdn1GWtbi9ajFYHA=;
        b=pXUwNEntdXE7HtVM60TGB4mimvR7Cnwo+Z7iUe/N+yOoHs4s3DH9/ncoZImKNhAl1P
         4/UNIJl3jt3W6ozQZPC9nbbQE9Rw9ltFxsJiPd8cB9Ivcw/59lERV3BhoTcvGiCqRuKZ
         V4rtHmf2PDBGokU6+c2QeCWoskAI4YdeV5yHb2wNaVH+F/waMSpp4o4BE89LLd19dE9S
         yVeQAyyxxpKB8OlKVqf6KD6XspbfN41M5eaZ4LbPWcNDyjbzUkxEgi7Kot+o05ejzafx
         wRPJMOYA1VXKSm0d7Vz31dkhssNqi6l7noyxE+SsvsQZLmL+q/vL2K5mA0G7234djaU9
         9Wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784321936; x=1784926736;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WnfgE1H7K7/mC+v3TIpWo3qvxDALdn1GWtbi9ajFYHA=;
        b=ce6r9GbtUlP04+wzOFP6u4JHS0kFwiXgx9uVOtDCt4ltGRB05uHqNhNbvA+W5oR1oP
         BwgX6Cej5cFif+pLocl2xn+GlrT0ji0tC2fgA6Al5gzew8k7W744OpVgPE3G59kq2RwZ
         vm77HVS3OOn2nUOTRtXwEz+yfuxhND5LZ9qGJ7SeZnisfJJ6fP3fVugrb9D/IQp+AkbC
         ooGlPi83BX+oJdp5ZigXYfT4L8bWQhpUufFCN8Qd98XGs3WsQ+WWZw5oqXiXYaxdczTI
         mQnT2UChjeDxBUrpSzhqLVpzx24J3XuribrqMHzds5Wr9wFwdDDTPIBzFALhZXHpEMuT
         zylA==
X-Forwarded-Encrypted: i=1; AHgh+RpsXalZ8WlA14gKtIcabndGzInXW2zEY+3NyOoyXYpFI+IP0XazoJec9FwK2mDU734UlCIIqR2zWNsZHEHK2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyH8w8XciFXmdLng6Yf2LJJ1h+gzklYq/KX9Skia2qYmEtRig9U
	6/+BKP272AbkadDRf7XvE1lBk0bJf8wL7nmlnKqqV+BTaDGIrqwShOIzGwihDz0LNrfguQRoaFt
	TWUtpZGGm1YE5ul5fils+qyyYqs01nShbOyOMJQ0=
X-Gm-Gg: AfdE7clXbP4O76qTNE9hFbpqm3z8e1wR/WhjZQiiRxFyd+GgXSUIeRf20suy9L/pIVj
	k6y78xNlqvtYCW/n2PxT8AUBTzUp8XFpd3yARXA2rqR3YbAmpVhONl1ZwT9YD8bZ14NE4jsqqNH
	twjzZQKC/YFA9jkEeg3S4x5Ngj5PZv8NeXPqIXnMqk7jSRmgYtM+adZSe6fO8JRbou0sb2wvOyV
	t+07uff4b8ynzQAyo0Tun/J/mUMMwtUt3ulz+FZk+wXZ9gD+z5p5hDeBTDQ
X-Received: by 2002:a17:902:da85:b0:2c7:a13a:7fe6 with SMTP id
 d9443c01a7336-2cf452fd4b0mr887925ad.10.1784321934805; Fri, 17 Jul 2026
 13:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622171017-mutt-send-email-mst@kernel.org> <20260625201850.2981130-1-briandaniels@google.com>
In-Reply-To: <20260625201850.2981130-1-briandaniels@google.com>
From: Brian Daniels <briandaniels@google.com>
Date: Fri, 17 Jul 2026 16:58:43 -0400
X-Gm-Features: AUfX_mzGhAxsevNNCzHuFAL-9v5fyH_AQB2nko-N5dkEfL6WfkLDjnUAfCiRGoQ
Message-ID: <CAD4i_GSrW+8Ho0GOAQwbP_MV-idTuHcU4K7x_4gasCrxvoQgNw@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] media: virtio: Add virtio_media_driver
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com, adelva@google.com, 
	aesteve@redhat.com, changyeon@google.com, daniel.almeida@collabora.com, 
	eperezma@redhat.com, gnurou@gmail.com, gurchetansingh@google.com, 
	hverkuil@xs4all.nl, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 4:18=E2=80=AFPM Brian Daniels <briandaniels@google.=
com> wrote:
>
> > > From: Alexandre Courbot <gnurou@gmail.com>
> > >
> > > virtio_media_driver.c provides the expected driver hooks, and support
> > > for mmapping and polling.
> > >
> > > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > > Signed-off-by: Brian Daniels <briandaniels@google.com>
> > > ---
> > >  drivers/media/virtio/virtio_media_driver.c | 959 +++++++++++++++++++=
++
> > >  1 file changed, 959 insertions(+)
> > >  create mode 100644 drivers/media/virtio/virtio_media_driver.c
> > >
> > > diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/med=
ia/virtio/virtio_media_driver.c
> > > new file mode 100644
> > > index 000000000..d6363c673
> > > --- /dev/null
> > > +++ b/drivers/media/virtio/virtio_media_driver.c
> > > @@ -0,0 +1,959 @@
> > > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+
> > > +
> > > +/*
> > > + * Virtio-media driver.
> > > + *
> > > + * Copyright (c) 2024-2025 Google LLC.
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> > > +#include <linux/dev_printk.h>
> > > +#include <linux/mm.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/scatterlist.h>
> > > +#include <linux/types.h>
> > > +#include <linux/videodev2.h>
> > > +#include <linux/vmalloc.h>
> > > +#include <linux/wait.h>
> > > +#include <linux/workqueue.h>
> > > +#include <linux/module.h>
> > > +#include <linux/moduleparam.h>
> > > +#include <linux/virtio.h>
> > > +#include <linux/virtio_config.h>
> > > +#include <linux/virtio_ids.h>
> > > +
> > > +#include <media/frame_vector.h>
> > > +#include <media/v4l2-dev.h>
> > > +#include <media/v4l2-event.h>
> > > +#include <media/videobuf2-memops.h>
> > > +#include <media/v4l2-device.h>
> > > +#include <media/v4l2-ioctl.h>
> > > +
> > > +#include "protocol.h"
> > > +#include "session.h"
> > > +#include "virtio_media.h"
> > > +
> > > +#define VIRTIO_MEDIA_NUM_EVENT_BUFS 16
> > > +
> > > +/* ID of the SHM region into which MMAP buffer will be mapped. */
> > > +#define VIRTIO_MEDIA_SHM_MMAP 0
> > > +
> > > +/*
> > > + * Name of the driver to expose to user-space.
> > > + *
> > > + * This is configurable because v4l2-compliance has workarounds spec=
ific to
> > > + * some drivers. When proxying these directly from the host, this al=
lows it to
> > > + * apply them as needed.
> > > + */
> > > +char *virtio_media_driver_name;
> > > +module_param_named(driver_name, virtio_media_driver_name, charp, 066=
0);
> >
> >
> > Um. What? Not how it should be handled.
>
> I can remove this module param. I didn't end up using this when complianc=
e testing.
> Instead, I patched v4l-utils:
> https://lore.kernel.org/all/20260528163448.4031965-1-briandaniels@google.=
com/
>
> Let me know if you think the v4l-utils patch is a good approach, otherwis=
e let
> me know how you'd prefer to address the v4l2-compliance driver-specific w=
orkounds
> when they're being proxied with virtio-media.
>
> > > +
> > > +/*
> > > + * Whether USERPTR buffers are allowed.
> > > + *
> > > + * This is disabled by default as USERPTR buffers are dangerous, but=
 the option
> > > + * is left to enable them if desired.
> > > + */
> > > +bool virtio_media_allow_userptr;
> > > +module_param_named(allow_userptr, virtio_media_allow_userptr, bool, =
0660);
> >
> >
> > is this kind of thing common?
>
> To be honest, I don't really know. I'm also not that familiar with the US=
ERPTR
> issues. I see a few references online about their use being discouraged d=
ue to
> possible race conditions, perhaps that was the original motivation for th=
is
> parameter (I'm not the original author of this driver).
>
> I'm open to alternatives, feel free to let me know if you have a preferen=
ce.
>
> > > +
> > > +/**
> > > + * virtio_media_session_alloc - Allocate a new session.
> > > + * @vv: virtio-media device the session belongs to.
> > > + * @id: ID of the session.
> > > + * @nonblocking_dequeue: whether dequeuing of buffers should be bloc=
king or
> > > + * not.
> > > + *
> > > + * The ``id`` and ``list`` fields must still be set by the caller.
> >
> > still in what sense?
>
> Based on the code below, I'm not so sure that the caller is responsible f=
or
> setting these values. They seem to be initialized in the function.
>
> Perhaps Alexandre Courbot (the original author) would know more. Unless h=
e
> says otherwise though I'm inclined to remove this comment.
>
> > > + */
> > > +static struct virtio_media_session *
> > > +virtio_media_session_alloc(struct virtio_media *vv, u32 id,
> > > +                      struct file *file)
> > > +{
> > > +   struct virtio_media_session *session;
> > > +   int i;
> > > +   int ret;
> > > +
> > > +   session =3D kzalloc_obj(*session, GFP_KERNEL);
> > > +   if (!session)
> > > +           goto err_session;
> > > +
> > > +   session->shadow_buf =3D kzalloc(VIRTIO_SHADOW_BUF_SIZE, GFP_KERNE=
L);
> > > +   if (!session->shadow_buf)
> > > +           goto err_shadow_buf;
> > > +
> > > +   ret =3D sg_alloc_table(&session->command_sgs, DESC_CHAIN_MAX_LEN,
> > > +                        GFP_KERNEL);
> > > +   if (ret)
> > > +           goto err_payload_sgs;
> > > +
> > > +   session->id =3D id;
> > > +   session->nonblocking_dequeue =3D file->f_flags & O_NONBLOCK;
> > > +
> > > +   INIT_LIST_HEAD(&session->list);
> > > +   v4l2_fh_init(&session->fh, &vv->video_dev);
> > > +   virtio_media_session_fh_add(session, file);
> > > +
> > > +   for (i =3D 0; i <=3D VIRTIO_MEDIA_LAST_QUEUE; i++)
> > > +           INIT_LIST_HEAD(&session->queues[i].pending_dqbufs);
> > > +   mutex_init(&session->queues_lock);
> > > +
> > > +   init_waitqueue_head(&session->dqbuf_wait);
> > > +
> > > +   mutex_lock(&vv->sessions_lock);
> > > +   list_add_tail(&session->list, &vv->sessions);
> > > +   mutex_unlock(&vv->sessions_lock);
> > > +
> > > +   return session;
> > > +
> > > +err_payload_sgs:
> > > +   kfree(session->shadow_buf);
> > > +err_shadow_buf:
> > > +   kfree(session);
> > > +err_session:
> > > +   return ERR_PTR(-ENOMEM);
> > > +}
> > > +
> > > +/**
> > > + * virtio_media_session_free - Free all resources of a session.
> > > + * @vv: virtio-media device the session belongs to.
> > > + * @session: session to destroy.
> > > + *
> > > + * All the resources of @sesssion, as well as the backing memory of =
@session
> > > + * itself, are freed.
> >
> > why @ here and `` above? And typo in the name.
>
> The `@` here was an attempt to follow the guide here for referencing func=
tion
> parameters:
> https://docs.kernel.org/doc-guide/kernel-doc.html#highlights-and-cross-re=
ferences
>
> That being said, I don't believe this file is 100% consistent with that. =
I will
> spend some time cleaning up the comments throughout this patch set to get=
 them
> consistent for v5. Thanks!
>
> > > + */
> > > +static void virtio_media_session_free(struct virtio_media *vv,
> > > +                                 struct virtio_media_session *sessio=
n)
> > > +{
> > > +   int i;
> > > +
> > > +   mutex_lock(&vv->sessions_lock);
> > > +   list_del(&session->list);
> > > +   mutex_unlock(&vv->sessions_lock);
> > > +
> > > +   virtio_media_session_fh_del(session);
> > > +   v4l2_fh_exit(&session->fh);
> > > +
> > > +   sg_free_table(&session->command_sgs);
> > > +
> > > +   for (i =3D 0; i <=3D VIRTIO_MEDIA_LAST_QUEUE; i++)
> > > +           vfree(session->queues[i].buffers);
> > > +
> > > +   kfree(session->shadow_buf);
> > > +   kfree(session);
> > > +}
> > > +
> > > +/**
> > > + * virtio_media_session_close - Close and free a session.
> > > + * @vv: virtio-media device the session belongs to.
> > > + * @session: session to close and destroy.
> > > + *
> > > + * This send the ``VIRTIO_MEDIA_CMD_CLOSE`` command to the device, a=
nd frees
> >
> > sends
>
> Fix staged in v5
>
> > > + * all resources used by @session.
> > > + */
> > > +static int virtio_media_session_close(struct virtio_media *vv,
> > > +                                 struct virtio_media_session *sessio=
n)
> > > +{
> > > +   struct virtio_media_cmd_close *cmd_close =3D &session->cmd.close;
> > > +   struct scatterlist cmd_sg =3D {};
> > > +   struct scatterlist *sgs[1] =3D { &cmd_sg };
> > > +   int ret;
> > > +
> > > +   mutex_lock(&vv->vlock);
> > > +
> > > +   cmd_close->hdr.cmd =3D VIRTIO_MEDIA_CMD_CLOSE;
> > > +   cmd_close->session_id =3D session->id;
> > > +
> > > +   sg_set_buf(&cmd_sg, cmd_close, sizeof(*cmd_close));
> > > +   sg_mark_end(&cmd_sg);
> > > +
> > > +   ret =3D virtio_media_send_command(vv, sgs, 1, 0, 0, NULL);
> > > +   mutex_unlock(&vv->vlock);
> > > +   if (ret < 0)
> > > +           return ret;
> > > +
> > > +   virtio_media_session_free(vv, session);
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +/**
> > > + * virtio_media_find_session - Lookup for the session with a given I=
D.
> >
> > a session
>
> Fix staged in v5
>
> > > + * @vv: virtio-media device to lookup the session from.
> > > + * @id: ID of the session to lookup.
> > > + */
> > > +static struct virtio_media_session *
> > > +virtio_media_find_session(struct virtio_media *vv, u32 id)
> > > +{
> > > +   struct list_head *p;
> > > +   struct virtio_media_session *session =3D NULL;
> > > +
> > > +   mutex_lock(&vv->sessions_lock);
> > > +   list_for_each(p, &vv->sessions) {
> > > +           struct virtio_media_session *s =3D
> > > +                   list_entry(p, struct virtio_media_session, list);
> > > +           if (s->id =3D=3D id) {
> > > +                   session =3D s;
> > > +                   break;
> > > +           }
> > > +   }
> > > +   mutex_unlock(&vv->sessions_lock);
> > > +
> > > +   return session;
> > > +}
> > > +
> > > +/**
> > > + * struct virtio_media_cmd_callback_param - Callback parameters to t=
he virtio
> > > + *                                          command queue.
> > > + * @vv: virtio-media device in use.
> > > + * @done: flag to be switched once the command is completed.
> > > + * @resp_len: length of the received response from the command. Only=
 valid
> > > + * after @done_flag has switched to ``true``.
> >
> > confusing indent
>
> Fix staged in v5
>
> > > + */
> > > +struct virtio_media_cmd_callback_param {
> > > +   struct virtio_media *vv;
> > > +   bool done;
> > > +   size_t resp_len;
> > > +};
> > > +
> > > +/**
> > > + * commandq_callback: Callback for the command queue.
> > > + * @queue: command virtqueue.
> > > + *
> > > + * This just wakes up the thread that was waiting on the command to =
complete.
> > > + */
> > > +static void commandq_callback(struct virtqueue *queue)
> > > +{
> > > +   unsigned int len;
> > > +   struct virtio_media_cmd_callback_param *param;
> > > +
> > > +process_bufs:
> > > +   while ((param =3D virtqueue_get_buf(queue, &len))) {
> > > +           param->done =3D true;
> > > +           param->resp_len =3D len;
> > > +           wake_up(&param->vv->wq);
> > > +   }
> > > +
> > > +   if (!virtqueue_enable_cb(queue)) {
> > > +           virtqueue_disable_cb(queue);
> > > +           goto process_bufs;
> > > +   }
> > > +}
> > > +
> > > +/**
> > > + * virtio_media_kick_command - send a command to the commandq.
> > > + * @vv: virtio-media device in use.
> > > + * @sgs: descriptor chain to send.
> > > + * @out_sgs: number of device-readable descriptors in @sgs.
> > > + * @in_sgs: number of device-writable descriptors in @sgs.
> > > + * @resp_len: output parameter. Upon success, contains the size of t=
he response
> > > + * in bytes.
> >
> > confusing indent
> >
> > > + *
> >
> > why an empty line?
>
> Indent fixed and empty line removed in v5
>
> > > + */
> > > +static int virtio_media_kick_command(struct virtio_media *vv,
> > > +                                struct scatterlist **sgs,
> > > +                                const size_t out_sgs, const size_t i=
n_sgs,
> > > +                                size_t *resp_len)
> > > +{
> > > +   struct virtio_media_cmd_callback_param cb_param =3D {
> > > +           .vv =3D vv,
> > > +           .done =3D false,
> > > +           .resp_len =3D 0,
> > > +   };
> > > +   struct virtio_media_resp_header *resp_header;
> > > +   int ret;
> > > +
> > > +   ret =3D virtqueue_add_sgs(vv->commandq, sgs, out_sgs, in_sgs, &cb=
_param,
> > > +                           GFP_ATOMIC);
> >
> >
> > can init with declaration.
>
> Thanks, added to v5
>
> > > +   if (ret) {
> > > +           v4l2_err(&vv->v4l2_dev,
> > > +                    "failed to add sgs to command virtqueue\n");
> > > +           return ret;
> > > +   }
> > > +
> > > +   if (!virtqueue_kick(vv->commandq)) {
> > > +           v4l2_err(&vv->v4l2_dev, "failed to kick command virtqueue=
\n");
> > > +           return -EINVAL;
> > > +   }
> > > +
> > > +   /* Wait for the response. */
> > > +   ret =3D wait_event_timeout(vv->wq, cb_param.done, 5 * HZ);
> > > +   if (ret =3D=3D 0) {
> > > +           v4l2_err(&vv->v4l2_dev,
> > > +                    "timed out waiting for response to command\n");
> > > +           return -ETIMEDOUT;
> > > +   }
> > > +
> > > +   if (resp_len)
> > > +           *resp_len =3D cb_param.resp_len;
> > > +
> > > +   if (in_sgs > 0) {
> > > +           /*
> > > +            * If we expect a response, make sure we have at least a
> > > +            * response header - anything shorter is invalid.
> > > +            */
> > > +           if (cb_param.resp_len < sizeof(*resp_header)) {
> > > +                   v4l2_err(&vv->v4l2_dev,
> > > +                            "received response header is too short\n=
");
> > > +                   return -EINVAL;
> > > +           }
> > > +
> > > +           resp_header =3D sg_virt(sgs[out_sgs]);
> > > +           if (resp_header->status)
> > > +                   /* Host returns a positive error code. */
> > > +                   return -resp_header->status;
> > > +   }
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +/**
> > > + * virtio_media_send_command - Send a command to the device and wait=
 for its
> > > + * response.
> > > + * @vv: virtio-media device in use.
> > > + * @sgs: descriptor chain to send.
> > > + * @out_sgs: number of device-readable descriptors in @sgs.
> > > + * @in_sgs: number of device-writable descriptors in @sgs.
> > > + * @minimum_resp_len: minimum length of the response expected by the=
 caller
> > > + * when the command is successful. Anything shorter than that will r=
esult in
> > > + * ``-EINVAL`` being returned.
> > > + * @resp_len: output parameter. Upon success, contains the size of t=
he response
> > > + * in bytes.
> > > + */
> > > +int virtio_media_send_command(struct virtio_media *vv, struct scatte=
rlist **sgs,
> > > +                         const size_t out_sgs, const size_t in_sgs,
> > > +                         size_t minimum_resp_len, size_t *resp_len)
> > > +{
> > > +   size_t local_resp_len =3D resp_len ? *resp_len : 0;
> > > +   int ret =3D virtio_media_kick_command(vv, sgs, out_sgs, in_sgs,
> > > +                                       &local_resp_len);
> > > +   if (resp_len)
> > > +           *resp_len =3D local_resp_len;
> > > +
> > > +   /*
> > > +    * If the host could not process the command, there is no valid
> > > +    * response.
> > > +    */
> > > +   if (ret < 0)
> > > +           return ret;
> > > +
> > > +   /* Make sure the host wrote a complete reply. */
> > > +   if (local_resp_len < minimum_resp_len) {
> > > +           v4l2_err(&vv->v4l2_dev,
> > > +                    "received response is too short: received %zu, e=
xpected at least %zu\n",
> > > +                    local_resp_len, minimum_resp_len);
> > > +           return -EINVAL;
> > > +   }
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +/**
> > > + * virtio_media_send_event_buffer() - Sends an event buffer to the h=
ost so it
> > > + * can return it with an event.
> > > + * @vv: virtio-media device in use.
> > > + * @event_buffer: pointer to the event buffer to send to the device.
> > > + */
> > > +static int virtio_media_send_event_buffer(struct virtio_media *vv,
> > > +                                     void *event_buffer)
> > > +{
> > > +   struct scatterlist *sgs[1], vresp;
> > > +   int ret;
> > > +
> > > +   sg_init_one(&vresp, event_buffer, VIRTIO_MEDIA_EVENT_MAX_SIZE);
> > > +   sgs[0] =3D &vresp;
> >
> > what is this convoluted thing? why not pass &vresp directly?
>
> `virtqueue_add_sgs` expects a `struct scatterlist **`. Passing `&vresp` i=
s
> only a single pointer and it needs a double pointer.
>
> It could be written as:
>
>   struct scatterlist *sgs, vresp;
>
>   sg_init_one(&vresp, event_buffer, VIRTIO_MEDIA_EVENT_MAX_SIZE);
>   sgs =3D &vresp;
>   ret =3D virtqueue_add_sgs(vv->eventq, &sgs, 0, 1, event_buffer,
>
> But I suspect it's written as is to match `virtqueue_add_sgs`'s function
> declaration:
>
>   int virtqueue_add_sgs(struct virtqueue *vq,
>                         struct scatterlist *sgs[],
>                         unsigned int out_sgs,
>                         unsigned int in_sgs,
>                         void *data,
>                         gfp_t gfp);
>
> > > +
> > > +   ret =3D virtqueue_add_sgs(vv->eventq, sgs, 0, 1, event_buffer,
> > > +                           GFP_ATOMIC);
> >
> >
> > This does not work uness event_buffer is aligned for dma.
> > But it does not seem to be:
> >
> >      for (i =3D 0; i < VIRTIO_MEDIA_NUM_EVENT_BUFS; i++) {
> >             void *ebuf =3D vv->event_buffer + VIRTIO_MEDIA_EVENT_MAX_SI=
ZE * i;
> >
> >              ret =3D virtio_media_send_event_buffer(vv, ebuf);
> >              if (ret)
> >                      goto err_send_event_buffer;
>
> Apologies if the following questions are bit basic, I'm  still pretty new=
 to
> this.
>
> Is the dma alignment requirement a general requirement for calling the
> `virtqueue_add_sgs` function? Or is the dma alignment requirement to allo=
w the
> driver to support DMABUF transfers? If its the later, I should note this =
driver
> does not support DMABUF transfers yet when streaming frames.
>
> If it's the former, then how would I go about ensuring its dma aligned?
>
> From the code block you quoted above, `vv->event_buffer` is allocated lik=
e so:
>
>   vv->event_buffer =3D devm_kzalloc(dev,
>           VIRTIO_MEDIA_EVENT_MAX_SIZE *
>           VIRTIO_MEDIA_NUM_EVENT_BUFS,
>           GFP_KERNEL);
>   if (!vv->event_buffer)
>     return -ENOMEM;
>
> Do I need to call something else besides `devm_kzalloc()` to ensure every
> element within the vv->event_buffer array is dma aligned?

Before I send out v5, would you mind addressing this question? I
didn't want it getting lost in all of the threads. Thanks!

> >
> >
> > > +   if (ret) {
> > > +           v4l2_err(&vv->v4l2_dev,
> > > +                    "failed to add sgs to event virtqueue\n");
> > > +           return ret;
> > > +   }
> > > +
> > > +   if (!virtqueue_kick(vv->eventq)) {
> > > +           v4l2_err(&vv->v4l2_dev, "failed to kick event virtqueue\n=
");
> > > +           return -EINVAL;
> > > +   }
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +/**
> > > + * eventq_callback() - Callback for the event queue.
> > > + * @queue: event virtqueue.
> > > + *
> > > + * This just schedules for event work to be run.
> > > + */
> > > +static void eventq_callback(struct virtqueue *queue)
> > > +{
> > > +   struct virtio_media *vv =3D queue->vdev->priv;
> > > +
> > > +   schedule_work(&vv->eventq_work);
> > > +}
> > > +
> > > +/**
> > > + * virtio_media_process_dqbuf_event() - Process a dequeued event for=
 a session.
> > > + * @vv: virtio-media device in use.
> > > + * @session: session the event is addressed to.
> > > + * @dqbuf_evt: the dequeued event to process.
> > > + *
> > > + * Invalid events are ignored with an error log.
> > > + */
> > > +static void
> > > +virtio_media_process_dqbuf_event(struct virtio_media *vv,
> > > +                            struct virtio_media_session *session,
> > > +                            struct virtio_media_event_dqbuf *dqbuf_e=
vt)
> > > +{
> > > +   struct virtio_media_buffer *dqbuf;
> > > +   const enum v4l2_buf_type queue_type =3D dqbuf_evt->buffer.type;
> > > +   struct virtio_media_queue_state *queue;
> > > +   typeof(dqbuf->buffer.m) buffer_m;
> > > +   typeof(dqbuf->buffer.m.planes[0].m) plane_m;
> > > +   int i;
> > > +
> > > +   if (queue_type >=3D ARRAY_SIZE(session->queues)) {
> > > +           v4l2_err(&vv->v4l2_dev,
> > > +                    "unmanaged queue %d passed to dqbuf event",
> > > +                    dqbuf_evt->buffer.type);
> > > +           return;
> > > +   }
> > > +   queue =3D &session->queues[queue_type];
> > > +
> > > +   if (dqbuf_evt->buffer.index >=3D queue->allocated_bufs) {
> > > +           v4l2_err(&vv->v4l2_dev,
> > > +                    "invalid buffer ID %d for queue %d in dqbuf even=
t",
> > > +                    dqbuf_evt->buffer.index, dqbuf_evt->buffer.type)=
;
> > > +           return;
> > > +   }
> > > +
> > > +   dqbuf =3D &queue->buffers[dqbuf_evt->buffer.index];
> > > +
> > > +   /*
> > > +    * Preserve the 'm' union that was passed to us during QBUF so us=
erspace
> > > +    * gets back the information it submitted.
> > > +    */
> > > +   buffer_m =3D dqbuf->buffer.m;
> > > +   memcpy(&dqbuf->buffer, &dqbuf_evt->buffer, sizeof(dqbuf->buffer))=
;
> > > +   dqbuf->buffer.m =3D buffer_m;
> > > +   if (V4L2_TYPE_IS_MULTIPLANAR(dqbuf->buffer.type)) {
> > > +           if (dqbuf->buffer.length > VIDEO_MAX_PLANES) {
> > > +                   v4l2_err(&vv->v4l2_dev,
> > > +                            "invalid number of planes received from =
host for a multiplanar buffer\n");
> > > +                   return;
> > > +           }
> > > +           for (i =3D 0; i < dqbuf->buffer.length; i++) {
> > > +                   plane_m =3D dqbuf->planes[i].m;
> > > +                   memcpy(&dqbuf->planes[i], &dqbuf_evt->planes[i],
> > > +                          sizeof(struct v4l2_plane));
> > > +                   dqbuf->planes[i].m =3D plane_m;
> > > +           }
> > > +   }
> > > +
> > > +   /* Set the DONE flag as the buffer is waiting for being dequeued.=
 */
> > > +   dqbuf->buffer.flags |=3D V4L2_BUF_FLAG_DONE;
> > > +
> > > +   mutex_lock(&session->queues_lock);
> > > +   list_add_tail(&dqbuf->list, &queue->pending_dqbufs);
> > > +   queue->queued_bufs -=3D 1;
> > > +   mutex_unlock(&session->queues_lock);
> > > +
> > > +   wake_up(&session->dqbuf_wait);
> > > +}
> > > +
> > > +/**
> > > + * virtio_media_process_events() - Process all pending events on a d=
evice.
> > > + * @vv: device which pending events we want to process.
> > > + *
> > > + * Retrieves all pending events on @vv's event queue and dispatch th=
em to their
> > > + * corresponding session.
> > > + *
> > > + * Invalid events are ignored with an error log.
> > > + */
> > > +void virtio_media_process_events(struct virtio_media *vv)
> > > +{
> > > +   struct virtio_media_event_error *error_evt;
> > > +   struct virtio_media_event_dqbuf *dqbuf_evt;
> > > +   struct virtio_media_event_event *event_evt;
> > > +   struct virtio_media_session *session;
> > > +   struct virtio_media_event_header *evt;
> > > +   unsigned int len;
> > > +
> > > +   mutex_lock(&vv->events_lock);
> > > +
> > > +process_bufs:
> > > +   while ((evt =3D virtqueue_get_buf(vv->eventq, &len))) {
> > > +           /* Make sure we received enough data */
> > > +           if (len < sizeof(*evt)) {
> > > +                   v4l2_err(&vv->v4l2_dev,
> > > +                            "event is too short: got %u, expected at=
 least %zu\n",
> > > +                            len, sizeof(*evt));
> > > +                   goto end_of_event;
> > > +           }
> > > +
> > > +           session =3D virtio_media_find_session(vv, evt->session_id=
);
> > > +           if (!session) {
> > > +                   v4l2_err(&vv->v4l2_dev, "cannot find session %d\n=
",
> > > +                            evt->session_id);
> > > +                   goto end_of_event;
> > > +           }
> > > +
> > > +           switch (evt->event) {
> > > +           case VIRTIO_MEDIA_EVT_ERROR:
> > > +                   if (len < sizeof(*error_evt)) {
> > > +                           v4l2_err(&vv->v4l2_dev,
> > > +                                    "error event is too short: got %=
u, expected %zu\n",
> > > +                                    len, sizeof(*error_evt));
> > > +                           break;
> > > +                   }
> > > +                   error_evt =3D (struct virtio_media_event_error *)=
evt;
> > > +                   v4l2_err(&vv->v4l2_dev,
> > > +                            "received error %d for session %d",
> > > +                            error_evt->errno, error_evt->hdr.session=
_id);
> > > +                   virtio_media_session_close(vv, session);
> > > +                   break;
> > > +
> > > +           /*
> > > +            * Dequeued buffer: put it into the right queue so user-s=
pace
> > > +            * can dequeue it.
> > > +            */
> > > +           case VIRTIO_MEDIA_EVT_DQBUF:
> > > +                   if (len < sizeof(*dqbuf_evt)) {
> > > +                           v4l2_err(&vv->v4l2_dev,
> > > +                                    "dqbuf event is too short: got %=
u, expected %zu\n",
> > > +                                    len, sizeof(*dqbuf_evt));
> > > +                           break;
> > > +                   }
> > > +                   dqbuf_evt =3D (struct virtio_media_event_dqbuf *)=
evt;
> > > +                   virtio_media_process_dqbuf_event(vv, session,
> > > +                                                    dqbuf_evt);
> > > +                   break;
> > > +
> > > +           case VIRTIO_MEDIA_EVT_EVENT:
> > > +                   if (len < sizeof(*event_evt)) {
> > > +                           v4l2_err(&vv->v4l2_dev,
> > > +                                    "session event is too short: got=
 %u expected %zu\n",
> > > +                                    len, sizeof(*event_evt));
> > > +                           break;
> > > +                   }
> > > +
> > > +                   event_evt =3D (struct virtio_media_event_event *)=
evt;
> > > +                   v4l2_event_queue_fh(&session->fh, &event_evt->eve=
nt);
> > > +                   break;
> > > +
> > > +           default:
> > > +                   v4l2_err(&vv->v4l2_dev, "unknown event type %d\n"=
,
> > > +                            evt->event);
> > > +                   break;
> > > +           }
> > > +
> > > +end_of_event:
> > > +           virtio_media_send_event_buffer(vv, evt);
> > > +   }
> > > +
> > > +   if (!virtqueue_enable_cb(vv->eventq)) {
> > > +           virtqueue_disable_cb(vv->eventq);
> > > +           goto process_bufs;
> > > +   }
> > > +
> > > +   mutex_unlock(&vv->events_lock);
> > > +}
> > > +
> > > +static void virtio_media_event_work(struct work_struct *work)
> > > +{
> > > +   struct virtio_media *vv =3D
> > > +           container_of(work, struct virtio_media, eventq_work);
> > > +
> > > +   virtio_media_process_events(vv);
> > > +}
> > > +
> > > +/**
> > > + * virtio_media_device_open() - Create a new session from an opened =
file.
> > > + * @file: opened file for the session.
> > > + */
> > > +static int virtio_media_device_open(struct file *file)
> > > +{
> > > +   struct video_device *video_dev =3D video_devdata(file);
> > > +   struct virtio_media *vv =3D to_virtio_media(video_dev);
> > > +   struct virtio_media_cmd_open *cmd_open =3D &vv->cmd.open;
> > > +   struct virtio_media_resp_open *resp_open =3D &vv->resp.open;
> > > +   struct scatterlist cmd_sg =3D {}, resp_sg =3D {};
> > > +   struct scatterlist *sgs[2] =3D { &cmd_sg, &resp_sg };
> > > +   struct virtio_media_session *session;
> > > +   u32 session_id;
> > > +   int ret;
> > > +
> > > +   mutex_lock(&vv->vlock);
> > > +
> > > +   sg_set_buf(&cmd_sg, cmd_open, sizeof(*cmd_open));
> > > +   sg_mark_end(&cmd_sg);
> > > +
> > > +   sg_set_buf(&resp_sg, resp_open, sizeof(*resp_open));
> > > +   sg_mark_end(&resp_sg);
> > > +
> > > +   cmd_open->hdr.cmd =3D VIRTIO_MEDIA_CMD_OPEN;
> > > +   ret =3D virtio_media_send_command(vv, sgs, 1, 1, sizeof(*resp_ope=
n),
> > > +                                   NULL);
> > > +   session_id =3D resp_open->session_id;
> > > +   mutex_unlock(&vv->vlock);
> > > +   if (ret < 0)
> > > +           return ret;
> > > +
> > > +   session =3D virtio_media_session_alloc(vv, session_id, file);
> > > +   if (IS_ERR(session))
> > > +           return PTR_ERR(session);
> > > +
> > > +   file->private_data =3D &session->fh;
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +/**
> > > + * virtio_media_device_close() - Close a previously opened session.
> > > + * @file: file of the session to close.
> > > + *
> > > + * This sends to ``VIRTIO_MEDIA_CMD_CLOSE`` command to the device, a=
nd close
> > > + * the session on the driver side.
> > > + */
> > > +static int virtio_media_device_close(struct file *file)
> > > +{
> > > +   struct video_device *video_dev =3D video_devdata(file);
> > > +   struct virtio_media *vv =3D to_virtio_media(video_dev);
> > > +   struct virtio_media_session *session =3D
> > > +           fh_to_session(file->private_data);
> > > +
> > > +   return virtio_media_session_close(vv, session);
> > > +}
> > > +
> > > +/**
> > > + * virtio_media_device_poll() - Poll logic for a virtio-media device=
.
> > > + * @file: file of the session to poll.
> > > + * @wait: poll table to wait on.
> > > + */
> > > +static __poll_t virtio_media_device_poll(struct file *file, poll_tab=
le *wait)
> > > +{
> > > +   struct virtio_media_session *session =3D
> > > +           fh_to_session(file->private_data);
> > > +   enum v4l2_buf_type capture_type =3D
> > > +           session->uses_mplane ? V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE=
 :
> > > +                                  V4L2_BUF_TYPE_VIDEO_CAPTURE;
> > > +   enum v4l2_buf_type output_type =3D
> > > +           session->uses_mplane ? V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE =
:
> > > +                                  V4L2_BUF_TYPE_VIDEO_OUTPUT;
> > > +   struct virtio_media_queue_state *capture_queue =3D
> > > +           &session->queues[capture_type];
> > > +   struct virtio_media_queue_state *output_queue =3D
> > > +           &session->queues[output_type];
> > > +   __poll_t req_events =3D poll_requested_events(wait);
> > > +   __poll_t rc =3D 0;
> > > +
> > > +   poll_wait(file, &session->dqbuf_wait, wait);
> > > +   poll_wait(file, &session->fh.wait, wait);
> > > +
> > > +   mutex_lock(&session->queues_lock);
> > > +   if (req_events & (EPOLLIN | EPOLLRDNORM)) {
> > > +           if (!capture_queue->streaming ||
> > > +               (capture_queue->queued_bufs =3D=3D 0 &&
> > > +                list_empty(&capture_queue->pending_dqbufs)))
> > > +                   rc |=3D EPOLLERR;
> > > +           else if (!list_empty(&capture_queue->pending_dqbufs))
> > > +                   rc |=3D EPOLLIN | EPOLLRDNORM;
> > > +   }
> > > +   if (req_events & (EPOLLOUT | EPOLLWRNORM)) {
> > > +           if (!output_queue->streaming)
> > > +                   rc |=3D EPOLLERR;
> > > +           else if (output_queue->queued_bufs <
> > > +                    output_queue->allocated_bufs)
> > > +                   rc |=3D EPOLLOUT | EPOLLWRNORM;
> > > +   }
> > > +   mutex_unlock(&session->queues_lock);
> > > +
> > > +   if (v4l2_event_pending(&session->fh))
> > > +           rc |=3D EPOLLPRI;
> > > +
> > > +   return rc;
> > > +}
> > > +
> > > +static void virtio_media_vma_close_locked(struct vm_area_struct *vma=
)
> > > +{
> > > +   struct virtio_media *vv =3D vma->vm_private_data;
> > > +   struct virtio_media_cmd_munmap *cmd_munmap =3D &vv->cmd.munmap;
> > > +   struct virtio_media_resp_munmap *resp_munmap =3D &vv->resp.munmap=
;
> > > +   struct scatterlist cmd_sg =3D {}, resp_sg =3D {};
> > > +   struct scatterlist *sgs[2] =3D { &cmd_sg, &resp_sg };
> > > +   int ret;
> > > +
> > > +   sg_set_buf(&cmd_sg, cmd_munmap, sizeof(*cmd_munmap));
> > > +   sg_mark_end(&cmd_sg);
> > > +
> > > +   sg_set_buf(&resp_sg, resp_munmap, sizeof(*resp_munmap));
> > > +   sg_mark_end(&resp_sg);
> > > +
> > > +   cmd_munmap->hdr.cmd =3D VIRTIO_MEDIA_CMD_MUNMAP;
> > > +   cmd_munmap->driver_addr =3D
> > > +           (vma->vm_pgoff << PAGE_SHIFT) - vv->mmap_region.addr;
> > > +   ret =3D virtio_media_send_command(vv, sgs, 1, 1, sizeof(*resp_mun=
map),
> > > +                                   NULL);
> > > +   if (ret < 0) {
> > > +           v4l2_err(&vv->v4l2_dev, "host failed to unmap buffer: %d\=
n",
> > > +                    ret);
> > > +   }
> > > +}
> > > +
> > > +/**
> > > + * virtio_media_vma_close() - Close a MMAP buffer mapping.
> > > + * @vma: VMA of the mapping to close.
> > > + *
> > > + * Inform the host that a previously created MMAP mapping is no long=
er needed
> > > + * and can be removed.
> > > + */
> > > +static void virtio_media_vma_close(struct vm_area_struct *vma)
> > > +{
> > > +   struct virtio_media *vv =3D vma->vm_private_data;
> > > +
> > > +   mutex_lock(&vv->vlock);
> > > +   virtio_media_vma_close_locked(vma);
> > > +   mutex_unlock(&vv->vlock);
> > > +}
> > > +
> > > +static const struct vm_operations_struct virtio_media_vm_ops =3D {
> > > +   .close =3D virtio_media_vma_close,
> > > +};
> > > +
> > > +/**
> > > + * virtio_media_device_mmap - Perform a mmap request from userspace.
> > > + * @file: opened file of the session to map for.
> > > + * @vma: VM area struct describing the desired mapping.
> > > + *
> > > + * This requests the host to map a MMAP buffer for us, so we can the=
n make that
> > > + * mapping visible into user-space address space.
> > > + */
> > > +static int virtio_media_device_mmap(struct file *file,
> > > +                               struct vm_area_struct *vma)
> > > +{
> > > +   struct video_device *video_dev =3D video_devdata(file);
> > > +   struct virtio_media *vv =3D to_virtio_media(video_dev);
> > > +   struct virtio_media_session *session =3D
> > > +           fh_to_session(file->private_data);
> > > +   struct virtio_media_cmd_mmap *cmd_mmap =3D &session->cmd.mmap;
> > > +   struct virtio_media_resp_mmap *resp_mmap =3D &session->resp.mmap;
> > > +   struct scatterlist cmd_sg =3D {}, resp_sg =3D {};
> > > +   struct scatterlist *sgs[2] =3D { &cmd_sg, &resp_sg };
> > > +   int ret;
> > > +
> > > +   if (!(vma->vm_flags & VM_SHARED))
> > > +           return -EINVAL;
> > > +   if (!(vma->vm_flags & (VM_READ | VM_WRITE)))
> > > +           return -EINVAL;
> > > +
> > > +   mutex_lock(&vv->vlock);
> > > +
> > > +   cmd_mmap->hdr.cmd =3D VIRTIO_MEDIA_CMD_MMAP;
> > > +   cmd_mmap->session_id =3D session->id;
> > > +   cmd_mmap->flags =3D
> > > +           (vma->vm_flags & VM_WRITE) ? VIRTIO_MEDIA_MMAP_FLAG_RW : =
0;
> > > +   cmd_mmap->offset =3D vma->vm_pgoff << PAGE_SHIFT;
> > > +
> > > +   sg_set_buf(&cmd_sg, cmd_mmap, sizeof(*cmd_mmap));
> > > +   sg_mark_end(&cmd_sg);
> > > +
> > > +   sg_set_buf(&resp_sg, resp_mmap, sizeof(*resp_mmap));
> > > +   sg_mark_end(&resp_sg);
> > > +
> > > +   /*
> > > +    * The host performs reference counting and is smart enough to re=
turn
> > > +    * the same guest physical address if this is called several time=
s on
> > > +    * the same
> > > +    * buffer.
> > > +    */
> > > +   ret =3D virtio_media_send_command(vv, sgs, 1, 1, sizeof(*resp_mma=
p),
> > > +                                   NULL);
> > > +   if (ret < 0)
> > > +           goto end;
> > > +
> > > +   vma->vm_private_data =3D vv;
> > > +   /*
> > > +    * Keep the guest address at which the buffer is mapped since we =
will
> > > +    * use that to unmap.
> > > +    */
> > > +   vma->vm_pgoff =3D (resp_mmap->driver_addr + vv->mmap_region.addr)=
 >>
> > > +                   PAGE_SHIFT;
> > > +
> > > +   /*
> > > +    * We cannot let the mapping be larger than the buffer.
> > > +    */
> > > +   if (vma->vm_end - vma->vm_start > PAGE_ALIGN(resp_mmap->len)) {
> > > +           dev_dbg(&video_dev->dev,
> > > +                   "invalid MMAP, as it would overflow buffer length=
\n");
> > > +           virtio_media_vma_close_locked(vma);
> > > +           ret =3D -EINVAL;
> > > +           goto end;
> > > +   }
> > > +
> > > +   ret =3D io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> > > +                            vma->vm_end - vma->vm_start,
> > > +                            vma->vm_page_prot);
> > > +   if (ret)
> > > +           goto end;
> > > +
> > > +   vma->vm_ops =3D &virtio_media_vm_ops;
> > > +
> > > +end:
> > > +   mutex_unlock(&vv->vlock);
> > > +   return ret;
> > > +}
> > > +
> > > +static const struct v4l2_file_operations virtio_media_fops =3D {
> > > +   .owner =3D THIS_MODULE,
> > > +   .open =3D virtio_media_device_open,
> > > +   .release =3D virtio_media_device_close,
> > > +   .poll =3D virtio_media_device_poll,
> > > +   .unlocked_ioctl =3D virtio_media_device_ioctl,
> > > +   .mmap =3D virtio_media_device_mmap,
> > > +};
> > > +
> > > +static int virtio_media_probe(struct virtio_device *virtio_dev)
> > > +{
> > > +   struct device *dev =3D &virtio_dev->dev;
> > > +   struct virtqueue *vqs[2];
> > > +   static struct virtqueue_info vq_info[2] =3D {
> > > +           {
> > > +                   .name =3D "command",
> > > +                   .callback =3D commandq_callback,
> > > +           },
> > > +           {
> > > +                   .name =3D "event",
> > > +                   .callback =3D eventq_callback,
> > > +           },
> > > +   };
> > > +   struct virtio_media *vv;
> > > +   struct video_device *vd;
> > > +   int i;
> > > +   int ret;
> > > +
> > > +   vv =3D devm_kzalloc(dev, sizeof(*vv), GFP_KERNEL);
> > > +   if (!vv)
> > > +           return -ENOMEM;
> > > +
> > > +   vv->event_buffer =3D devm_kzalloc(dev,
> > > +                                   VIRTIO_MEDIA_EVENT_MAX_SIZE *
> > > +                                   VIRTIO_MEDIA_NUM_EVENT_BUFS,
> > > +                                   GFP_KERNEL);
> > > +   if (!vv->event_buffer)
> > > +           return -ENOMEM;
> > > +
> > > +   INIT_LIST_HEAD(&vv->sessions);
> > > +   mutex_init(&vv->sessions_lock);
> > > +   mutex_init(&vv->events_lock);
> > > +   mutex_init(&vv->vlock);
> > > +
> > > +   vv->virtio_dev =3D virtio_dev;
> > > +   virtio_dev->priv =3D vv;
> > > +
> > > +   init_waitqueue_head(&vv->wq);
> > > +
> > > +   ret =3D v4l2_device_register(dev, &vv->v4l2_dev);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   ret =3D virtio_find_vqs(virtio_dev, 2, vqs, vq_info, NULL);
> > > +   if (ret)
> > > +           goto err_find_vqs;
> > > +
> > > +   vv->commandq =3D vqs[0];
> > > +   vv->eventq =3D vqs[1];
> > > +   INIT_WORK(&vv->eventq_work, virtio_media_event_work);
> > > +
> > > +   /* Get MMAP buffer mapping SHM region */
> > > +   virtio_get_shm_region(virtio_dev, &vv->mmap_region,
> > > +                         VIRTIO_MEDIA_SHM_MMAP);
> > > +
> > > +   vd =3D &vv->video_dev;
> > > +
> > > +   vd->v4l2_dev =3D &vv->v4l2_dev;
> > > +   vd->vfl_type =3D VFL_TYPE_VIDEO;
> > > +   vd->ioctl_ops =3D &virtio_media_ioctl_ops;
> > > +   vd->fops =3D &virtio_media_fops;
> > > +   vd->device_caps =3D virtio_cread32(virtio_dev, 0);
> > > +   if (vd->device_caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MP=
LANE))
> > > +           vd->vfl_dir =3D VFL_DIR_M2M;
> > > +   else if (vd->device_caps &
> > > +            (V4L2_CAP_VIDEO_OUTPUT | V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLA=
NE))
> > > +           vd->vfl_dir =3D VFL_DIR_TX;
> > > +   else
> > > +           vd->vfl_dir =3D VFL_DIR_RX;
> > > +   vd->release =3D video_device_release_empty;
> > > +   strscpy(vd->name, "virtio-media", sizeof(vd->name));
> > > +
> > > +   video_set_drvdata(vd, vv);
> > > +
> > > +   ret =3D video_register_device(vd, virtio_cread32(virtio_dev, 4), =
0);
> > > +   if (ret)
> > > +           goto err_register_device;
> > > +
> > > +   for (i =3D 0; i < VIRTIO_MEDIA_NUM_EVENT_BUFS; i++) {
> > > +           void *ebuf =3D vv->event_buffer + VIRTIO_MEDIA_EVENT_MAX_=
SIZE * i;
> > > +
> > > +           ret =3D virtio_media_send_event_buffer(vv, ebuf);
> > > +           if (ret)
> > > +                   goto err_send_event_buffer;
> > > +   }
> > > +
> > > +   virtio_device_ready(virtio_dev);
> > > +
> > > +   return 0;
> > > +
> > > +err_send_event_buffer:
> > > +   video_unregister_device(&vv->video_dev);
> > > +err_register_device:
> > > +   virtio_dev->config->del_vqs(virtio_dev);
> > > +err_find_vqs:
> > > +   v4l2_device_unregister(&vv->v4l2_dev);
> > > +
> > > +   return ret;
> > > +}
> > > +
> > > +static void virtio_media_remove(struct virtio_device *virtio_dev)
> > > +{
> > > +   struct virtio_media *vv =3D virtio_dev->priv;
> > > +   struct list_head *p, *n;
> > > +
> > > +   cancel_work_sync(&vv->eventq_work);
> > > +   virtio_reset_device(virtio_dev);
> > > +
> > > +   v4l2_device_unregister(&vv->v4l2_dev);
> > > +   virtio_dev->config->del_vqs(virtio_dev);
> > > +   video_unregister_device(&vv->video_dev);
> > > +
> > > +   list_for_each_safe(p, n, &vv->sessions) {
> > > +           struct virtio_media_session *s =3D
> > > +                   list_entry(p, struct virtio_media_session, list);
> > > +
> > > +           virtio_media_session_free(vv, s);
> > > +   }
> > > +}
> > > +
> > > +static struct virtio_device_id id_table[] =3D {
> > > +   { VIRTIO_ID_MEDIA, VIRTIO_DEV_ANY_ID },
> > > +   { 0 },
> > > +};
> > > +
> > > +static unsigned int features[] =3D {};
> > > +
> > > +static struct virtio_driver virtio_media_driver =3D {
> > > +   .feature_table =3D features,
> > > +   .feature_table_size =3D ARRAY_SIZE(features),
> > > +   .driver.name =3D VIRTIO_MEDIA_DEFAULT_DRIVER_NAME,
> > > +   .driver.owner =3D THIS_MODULE,
> > > +   .id_table =3D id_table,
> > > +   .probe =3D virtio_media_probe,
> > > +   .remove =3D virtio_media_remove,
> > > +};
> > > +
> > > +module_virtio_driver(virtio_media_driver);
> > > +
> > > +MODULE_DEVICE_TABLE(virtio, id_table);
> > > +MODULE_DESCRIPTION("virtio media driver");
> > > +MODULE_AUTHOR("Alexandre Courbot <gnurou@gmail.com>");
> > > +MODULE_LICENSE("Dual BSD/GPL");
