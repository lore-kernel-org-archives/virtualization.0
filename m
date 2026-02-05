Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F4A355033
	for <virtualization@lists.linux.dev>; Thu,  5 Feb 2026 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273522; cv=none; b=g9b0YvN2CjRR431x2EoP7pRY87Ow20BeBiy55zgkxVL2PJyNiKQIAUKOsqRCvSiugXQZhvnUWwh4GNaJXhogidrQ+xEZUfP5s2KtdEleBQy1aVCuD08ZoJ/vHTFd8C58dN6A4rMUW7BwxpusPpS86r82+myP1+RDd6xJfyccrec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273522; c=relaxed/simple;
	bh=/rtGSzTLCizkTqAM1hY0p3Qt+byzVY1Q0ym8+ppwn1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPCfMXbSJ3q0oZV2LnvO8h5S1o5KCjdyklDMEPhahGtULqpHujdEDuNgq9Cy76cDKPZR6sbFQKrT+yMD6FO3+uyz2kTq7Doi50DfUbi5C0JjzYQWnywB9D6zCKz03o0y09BpIU8j48jDsR7wCPAeNWpn7BWLbyVsanDSDwGNEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MksIMp1i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MksIMp1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770273521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IaAEgv1LaxsoPCYS0MlhpQupUE5GCUJXaW9nz/E7/qc=;
	b=MksIMp1ircq+Pvg/MPk+ff5c2JpfjHQM7neT2ZHZKBk5CrP7UB4uizILcAuFSZ2o11X5l+
	06fwCOsgybbNHnD/L16PCuduS4JlsUY3mhqIBWctROeh8iLx2P7nkU4/h0OofQsKls43SK
	IBz2Ho8tPkErF/dhjQ1Tn0G91oIwLE4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-1SHLKusHMs6G9_-vqmaxLA-1; Thu, 05 Feb 2026 01:38:38 -0500
X-MC-Unique: 1SHLKusHMs6G9_-vqmaxLA-1
X-Mimecast-MFC-AGG-ID: 1SHLKusHMs6G9_-vqmaxLA_1770273517
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-794b74a8b2bso8294647b3.3
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 22:38:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770273517; x=1770878317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IaAEgv1LaxsoPCYS0MlhpQupUE5GCUJXaW9nz/E7/qc=;
        b=HssYN2o75025QctMK3Fs4G6BZAfa47OcTuMawFjmcCzPDbTJ5ZhEAopMAGAuKi8LUX
         ghBOcsgNfcwj3O7aqSX0OHCvAJGTX51a1Y6MdnLllFbtwOy1d1FVpe4ikwMH45sz7ZWG
         bFwZ97QpdBU/GGSehPlOHxvlP/eOI23159YTSf8oyqaRivuxzB2T6kTaudc8njMcbNPA
         zo8Ri7UkE1+twfaWBf+ukyLRHKpj/WvW7pm2sk7cQc92vo78cin+nzFPQfDU9jtxNSzB
         JHIRcBfQx0C5bHRECsMhXMwD1zhtzsSPG6cVD97rJo0oVAOsPcTdTpDV5fr6x5WBXOGq
         clmA==
X-Forwarded-Encrypted: i=1; AJvYcCVhMCjgQp9FEcyUyHOjsygOkcmoUa2iZRR/vJWZvCp8aQJ0UES8RZbQ/KpbC4gY0pPUjGUpSN1rZVWc4uIdfA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5PTxndmiDyn6M7dSkhUDDH0qk2o4keabQZATeXSq6W9unfZZk
	CH4XAIGQzLCxWYA3SAcGkz3P2T/TMoL0LsDES7pHXscAfqf6vX2iP5Uuop/YU6zCOqjQes5uPEz
	w0wwm2D+I74u5VdrC4mQnbRbncqa0kMiwDu4Whe/NORatb2WFjBSZdS9FhpVQsmfw6TLJU2GQOW
	Er0HtjsYmoC7aDkABxjo4UkKWeGEBgYrrBjr53ITOSB7E=
X-Gm-Gg: AZuq6aKBVBOjcqVRfCDhqup365n6KjPwmnCK1Ycpm1BfJfnFMgSFgR+ZU9uVzgI3VS5
	oDCt2pct/t+YpeV9tR4+caMe4ImhCfbNjMepgnsJzGyFPV5K/lm/GzZPgmCwsTNoY3E9QvtGPZt
	IzwG/y0bckXTbZq3F0xBVn7ofFbPFBXj6Jz5qZL15x3NkZl+zbKjbSlCEqo8G0Rp/npQ==
X-Received: by 2002:a05:690c:48c1:b0:78f:9801:7606 with SMTP id 00721157ae682-794fe73737dmr43439237b3.34.1770273517287;
        Wed, 04 Feb 2026 22:38:37 -0800 (PST)
X-Received: by 2002:a05:690c:48c1:b0:78f:9801:7606 with SMTP id
 00721157ae682-794fe73737dmr43439147b3.34.1770273516953; Wed, 04 Feb 2026
 22:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-6-eperezma@redhat.com>
 <CACGkMEtuAG-uZYJWZcsT1A0+QBCTOnkr7m0dt8MdbTwd5UNyNw@mail.gmail.com>
 <CAJaqyWc8_B82n1a3JaBKKvhkWN=Rs93=kcfCU6e9RfzsPXdF5g@mail.gmail.com>
 <CACGkMEuqbEGXE-6xe_kkPMT_JicieQ=HjNKx9j_o3XG9TCuAKg@mail.gmail.com>
 <CAJaqyWe_CLL4D-8WcTJm==AK=d0DrjSrco+ctaQjSobo5ZPHkg@mail.gmail.com>
 <CACGkMEtXh1xBDemkCCUw_Sow9-1pBU_bo1sN0SUmTQF0XCvvHA@mail.gmail.com>
 <CAJaqyWcJjtiw2VLzybuUAFs3Q4ugvhEPFeDtxN31vjzdvKS8RA@mail.gmail.com>
 <CACGkMEt1XiKEqqYAs5QhLJnUwAE+SU4GzgAe9f34ohmAw8nzLg@mail.gmail.com>
 <CAJaqyWcuwsnKj6wb1Vc2bXORyTeQhsn7ZLdsbEiU-C8QKKuFYQ@mail.gmail.com> <CACGkMEvgQsPUv_zK7=1bpLPhvem_HuS8MRb5uUB0VcB5vBQN4Q@mail.gmail.com>
In-Reply-To: <CACGkMEvgQsPUv_zK7=1bpLPhvem_HuS8MRb5uUB0VcB5vBQN4Q@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 5 Feb 2026 07:38:00 +0100
X-Gm-Features: AZwV_QiLpsLRsLePvmtLQ-6ZZJrGwGhc86QPm_ccU4mbqc5Gfvc81OEZbi9BjzM
Message-ID: <CAJaqyWcrDS6+wjMuqX+dgTF58jisC+1gZoNoeH_q6EtCziMizg@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: add F_QUEUE_READY feature
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rmmRP0Im-EzzRmNOHe1WdgUzU_UV1XQu7wqqjD_kNaE_1770273517
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 5:09=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Feb 4, 2026 at 3:35=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Wed, Feb 4, 2026 at 3:44=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Tue, Feb 3, 2026 at 3:28=E2=80=AFPM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
> > > >
> > > > On Tue, Feb 3, 2026 at 5:00=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Fri, Jan 30, 2026 at 4:15=E2=80=AFPM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Jan 30, 2026 at 3:17=E2=80=AFAM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 29, 2026 at 2:26=E2=80=AFPM Eugenio Perez Martin
> > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jan 29, 2026 at 3:12=E2=80=AFAM Jason Wang <jasowan=
g@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9re=
z <eperezma@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Add the VDUSE_F_QUEUE_READY feature flag. This allows t=
he kernel module
> > > > > > > > > > to explicitly signal userspace when a specific virtqueu=
e has been
> > > > > > > > > > enabled.
> > > > > > > > > >
> > > > > > > > > > In scenarios like Live Migration of VirtIO net devices,=
 the dataplane
> > > > > > > > > > starts after the control virtqueue allowing QEMU to app=
ly configuration
> > > > > > > > > > in the destination device.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++=
+++++++++++++-
> > > > > > > > > >  include/uapi/linux/vduse.h         | 19 ++++++++++++++=
+++++
> > > > > > > > > >  2 files changed, 46 insertions(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drive=
rs/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > index e7da69c2ad71..1d93b540db4d 100644
> > > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > @@ -9,6 +9,7 @@
> > > > > > > > > >   */
> > > > > > > > > >
> > > > > > > > > >  #include "linux/virtio_net.h"
> > > > > > > > > > +#include <linux/bits.h>
> > > > > > > > > >  #include <linux/cleanup.h>
> > > > > > > > > >  #include <linux/init.h>
> > > > > > > > > >  #include <linux/module.h>
> > > > > > > > > > @@ -53,7 +54,7 @@
> > > > > > > > > >  #define IRQ_UNBOUND -1
> > > > > > > > > >
> > > > > > > > > >  /* Supported VDUSE features */
> > > > > > > > > > -static const uint64_t vduse_features;
> > > > > > > > > > +static const uint64_t vduse_features =3D BIT_U64(VDUSE=
_F_QUEUE_READY);
> > > > > > > > > >
> > > > > > > > > >  /*
> > > > > > > > > >   * VDUSE instance have not asked the vduse API version=
, so assume 0.
> > > > > > > > > > @@ -120,6 +121,7 @@ struct vduse_dev {
> > > > > > > > > >         char *name;
> > > > > > > > > >         struct mutex lock;
> > > > > > > > > >         spinlock_t msg_lock;
> > > > > > > > > > +       u64 vduse_features;
> > > > > > > > > >         u64 msg_unique;
> > > > > > > > > >         u32 msg_timeout;
> > > > > > > > > >         wait_queue_head_t waitq;
> > > > > > > > > > @@ -619,7 +621,30 @@ static void vduse_vdpa_set_vq_read=
y(struct vdpa_device *vdpa,
> > > > > > > > > >  {
> > > > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > > +       int r;
> > > > > > > > > > +
> > > > > > > > > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUE=
UE_READY)))
> > > > > > > > > > +               goto out;
> > > > > > > > > > +
> > > > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > > > > > > > > +       msg.req.vq_ready.num =3D idx;
> > > > > > > > > > +       msg.req.vq_ready.ready =3D !!ready;
> > > > > > > > > > +
> > > > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > >
> > > > > > > > > > +       if (r < 0) {
> > > > > > > > > > +               dev_dbg(&vdpa->dev, "device refuses to =
set vq %u ready %u",
> > > > > > > > > > +                       idx, ready);
> > > > > > > > > > +
> > > > > > > > > > +               /* We can't do better than break the de=
vice in this case */
> > > > > > > > > > +               spin_lock(&dev->msg_lock);
> > > > > > > > > > +               vduse_dev_broken(dev);
> > > > > > > > >
> > > > > > > > > This has been done by vduse_dev_msg_sync().
> > > > > > > > >
> > > > > > > >
> > > > > > > > This is done by msg_sync() when userland does not reply in =
a
> > > > > > > > timeframe, but not when userland replies with VDUSE_REQ_RES=
ULT_FAILED.
> > > > > > > > Should I add a comment?
> > > > > > >
> > > > > > > If this is not specific to Q_READY, I think we need to move i=
t to
> > > > > > > msg_sync() as well.
> > > > > > >
> > > > > >
> > > > > > It's specific to Q_READY for me, as it's the request that retur=
ns void
> > > > > > and has no possibility to inform of an error.
> > > > >
> > > > > I may miss something, I mean why consider the failure of Q_READY =
to be
> > > > > more serious than the failure of other commands (e.g set_status()=
).
> > > > >
> > > >
> > > > I'm not considering the failure of Q_READY more serious than any ot=
her
> > > > failure. I'm breaking the device here as I cannot return the error =
to
> > > > the vDPA driver: This function returns void.
> > >
> > > Yes, and set_status() return void as well.
> > >
> > > void virtio_add_status(struct virtio_device *dev, unsigned int status=
)
> > > {
> > >         might_sleep();
> > > =3D>      dev->config->set_status(dev, dev->config->get_status(dev) |=
 status);
> > > }
> > >
> >
> > Yes, I'm not saying all of the other users of vduse_dev_msg_sync don't
> > ignore the return code of the userland VDUSE instance. I'm saying that
> > we have cases where it is not ignored and the driver can react from
> > the error. After a fast look for them:
> >
> > 1) Case vhost_vdpa -> VHOST_GET_VRING_BASE -> ops->get_vq_state.
> > 2) Case vhost_vdpa -> ops->vduse_vdpa_set_map -> vduse_dev_update_iotlb
> >
> > If the userland VDUSE instance returns an error, -EIO is propagated to
> > vhost_vdpa user, and both can react and continue operating normally.
> > If we break the device, the same two userlands apps see a totally
> > different behavior: The device is totally unusable from that moment.
> >
> > Do we really want to break the device from the moment that VDUSE
> > instance returns an error in these conditions, and do it in an user
> > visible change?
>
> Ok, I think you worries about that if we do it for set_status() it
> might break userspace. That makes sense.
>
> >
> > > >
> > > > We can make the function return a bool or int, and then make
> > > > vhost_vdpa and virtio_vdpa react to that error.  QEMU is already
> > > > prepared for VHOST_VDPA_SET_VRING_ENABLE to return an error, as it =
is
> > > > an ioctl,
> > >
> > > But we did:
> > >
> > >         case VHOST_VDPA_SET_VRING_ENABLE:
> > >                 if (copy_from_user(&s, argp, sizeof(s)))
> > >                         return -EFAULT;
> > >                 ops->set_vq_ready(vdpa, idx, s.num);
> > >                 return 0;
> > >
> > > So the failure come from copy_from_user()
> > >
> >
> > Yes. Let me rewrite it as:
> >
> > We can make ops->set_vq_ready return a bool or int, and then make
> > vhost_vdpa react to that error. The driver virtio_vdpa already checks
> > the same by calling get_vq_ready, but there is no equivalent in
> > vhost_vdpa. I can set a comment explaining the two methods for
> > checking the error of the call. QEMU is already prepared for handling
> > the return of an error from VHOST_VDPA_SET_VRING_ENABLE, as the ioctl
> > already returns errors like -EFAULT, and hopefully the rest of the
> > users of VHOST_VDPA_SET_VRING_ENABLE are also prepared.
> >
> > > >
> > > > Should I change vdpa_config_ops->set_vq_ready so it can return an
> > > > error, as a prerequisite of this series?
> > >
> > > Or it would be better to leave the breaking of device on
> > > REQ_RESULT_FAILED for future investigation (not blocking this series)=
.
> > >
> >
> > I'd say it's the best option, yes. But my vote is to make
> > VHOST_VDPA_SET_VRING_ENABLE more robust actually :).
>
> Ok, I think then it would be better to use a separate patch in this serie=
s?
>

Yes, I'm ok with leaving this as a change for future series.

Thanks!

