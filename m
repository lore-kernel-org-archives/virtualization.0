Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79240245E
	for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365882; cv=none; b=Ac9ykihDQ5aawJf71L+RYZGHTGV3h4TVoRpWf40dFUxNcRVql3Z7cUz04O9IBhPxRjcfJnWdpCWS+q8gVrh94V6iBwechTjBHpotC3ovqfpVzKDcTwgvf4N/d4poB5gsPFZgGpDFVUyUdbRTKz8JEsN9Wy9NCAy7nQz5AYRIOHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365882; c=relaxed/simple;
	bh=Lcf72Rzm78gc5DlMU+0uRPGYeGfW3qCW7AY97IDSli8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Xdd/SRXYc+nW7oscZqW3Zv6Xo6EKIoljlhOJMOSzETPxyWoSiDvnRGKpdsV379dolmQZ5CIIcbF8nVWClXjsu7WicsrybSVIMQbQKp5fKGDyFunwJiLdvkuTq6643N3S9uMEFeTRPPduMtR4TbduKSAkUh0z5Rn1kDGMBnHD350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKe39VbI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKe39VbI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774365880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4v4xqTqHjMjWJnkL34okqRK9gfII8qgKulp2fDfnMdA=;
	b=KKe39VbI55HDXy1IDEtNGcA+J9hB37yzeK01GZnakQ+UZr4ZFsF4P0bDlncAYZbm+bgVkK
	Bx63M7Q4W1ahQG4GF6u2tmQPyShrffHLIp+tI1huL8woHT0X/1j0XM6JLR5CUckwYFebIZ
	/dm3dfE0Ah25x1k6R+yxZHy7YBK1nII=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-rLFIso6RNSyUpUY_FJgRhg-1; Tue, 24 Mar 2026 11:24:38 -0400
X-MC-Unique: rLFIso6RNSyUpUY_FJgRhg-1
X-Mimecast-MFC-AGG-ID: rLFIso6RNSyUpUY_FJgRhg_1774365877
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48544725bdeso55849215e9.2
        for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 08:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774365877; x=1774970677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4v4xqTqHjMjWJnkL34okqRK9gfII8qgKulp2fDfnMdA=;
        b=RWpJXaQTclOCq8CNXR2fbgDODjl2K/GUIIgv+Me9hQ/a4RGzC8RUeHUShmTn89Be3B
         rL5dGZ32vKfD0SuH10FOK1m3SS67py7lsXEKmOKa32EhgcL1O+FioPZC7MyJwgwRaNdp
         eLImODTvShrtZPBkFNabjP79dLxpGsmGqkNTFDa6kSdGX9HATUsTmHarqDX3RmgRC5zo
         xkXVKvWAqLmgfFwNW8tbI7IgQj/JmVmUtlaL9hefOKDy9+ryLXlnm7ZupbhLIZdN9fM1
         LQQFNYxeSrIM8ypUIFfIyJluoNMivvjfHaVJhOcqKJdKUrqv397xJf29Trb5+2NwYGRL
         hL3w==
X-Forwarded-Encrypted: i=1; AJvYcCV4kjyDk/c6DXd25AMfGNKqXaAugIUDcvt5gu0axCslvewjuCZFPOhM7ntguTqLMkynH3V79hYtfNzYhJWPWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGlIr8dfCxFDic7ypcEF7z6whSJLoPshR5xz+NvYZj+QK6vKwB
	KR1hyWdK78ayxHK7LE0tXrNVFsJ1IFKw+2AxGXcPfoCvScFIUGuQ8H0PTkZnGaantw6KDClEffb
	zT6UuhGSdK6WA2LkK/ATXtakBte3aqNW4YZ12Xq0MIpQRC5BI5Ddj9FnOE2+hEf8KOPu2
X-Gm-Gg: ATEYQzxBQgQDOD35H9ja+ww26OPGyv0e1SaIdsOvvA7Hy7jyWu+qlnD/i5Fx0mt9uAf
	6rv3SB2/z5PxgTbp43XJvQqqTEPrBuHh9llG8Wb1J+mFB8xEEC0+I0ag3h/i8mUXBiFmI6x64NY
	Wz0ZQ1aNjoStC/H5qPGZrlYq3NT2mmcocYX0kS7bbQXGc5Yts7JD6pnEAj+xv9etHpLPBj4Stpg
	cP2pXfNT1hnko1lWbWMKAZ/IptULfKMxaA7cG9k2u+T0s1y/+/fGT+sBVPdrvxDROBAbanWFkl0
	e5G3IB3YItD8oElg21+GZasCfVBboq6sPW3eu79RcAzS2vgb7XQCL9SlHjNAD2l7gp2PXs8BrxZ
	pCzzgCLEsT/OS4D/0
X-Received: by 2002:a05:600c:8b2a:b0:486:ff92:63e5 with SMTP id 5b1f17b1804b1-48715fc32admr2453185e9.6.1774365877010;
        Tue, 24 Mar 2026 08:24:37 -0700 (PDT)
X-Received: by 2002:a05:600c:8b2a:b0:486:ff92:63e5 with SMTP id 5b1f17b1804b1-48715fc32admr2452355e9.6.1774365876419;
        Tue, 24 Mar 2026 08:24:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116abe8esm60822765e9.4.2026.03.24.08.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:24:35 -0700 (PDT)
Date: Tue, 24 Mar 2026 11:24:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v3 3/3] vduse: add F_QUEUE_READY feature
Message-ID: <20260324112340-mutt-send-email-mst@kernel.org>
References: <20260310190759.1097506-1-eperezma@redhat.com>
 <20260310190759.1097506-4-eperezma@redhat.com>
 <CACGkMEvwmC4qiYgZAkrHEC3r3q7FyMiqpg5=2oNMPGm0q=PLBA@mail.gmail.com>
 <CAJaqyWe+x9okNwPD5n6M+PeLt0cQY-_fBWOD9uXSa1nKHqRaFw@mail.gmail.com>
 <CACGkMEuKTezQQXJ0XEKWEoRaeo-ORcE07+xgSoJ_7UwpPdonWA@mail.gmail.com>
 <CAJaqyWf5mnARrEXssKQ2CQB0rZ+KVi_kW1xyOc_Dx1ELAs4LHA@mail.gmail.com>
 <CAJaqyWd40=bxMOwTR4wyHtPS_-Txn2WbwSj9rZEXoY-4DxQgpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWd40=bxMOwTR4wyHtPS_-Txn2WbwSj9rZEXoY-4DxQgpw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RBv4N5ceF4_5XP-BTSYl9oSRhMmNRUq5GVUNK4rvxGM_1774365877
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Mar 24, 2026 at 03:01:47PM +0100, Eugenio Perez Martin wrote:
> On Fri, Mar 13, 2026 at 8:08 AM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Fri, Mar 13, 2026 at 7:05 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Thu, Mar 12, 2026 at 2:24 PM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Thu, Mar 12, 2026 at 4:58 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > >
> > > > > On Wed, Mar 11, 2026 at 3:08 AM Eugenio Pérez <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > Add the VDUSE_F_QUEUE_READY feature flag. This allows the kernel module
> > > > > > to explicitly signal userspace when a specific virtqueue has been
> > > > > > enabled.
> > > > > >
> > > > > > In scenarios like Live Migration of VirtIO net devices, the dataplane
> > > > > > starts after the control virtqueue allowing QEMU to apply configuration
> > > > > > in the destination device.
> > > > > >
> > > > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > > ---
> > > > > > v2:
> > > > > > * Fix comment of vduse_dev_request.vq_ready
> > > > > > * Set vq_ready before sending the message to the VDUSE userland
> > > > > >   instance, avoiding the need for SMP sync after receiving the message.
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 +++++++++++++++++++++++++++-
> > > > > >  include/uapi/linux/vduse.h         | 18 ++++++++++++++++++
> > > > > >  2 files changed, 45 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > index 17e0358d3a68..4f642b95a7cb 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > @@ -9,6 +9,7 @@
> > > > > >   */
> > > > > >
> > > > > >  #include "linux/virtio_net.h"
> > > > > > +#include <linux/bits.h>
> > > > > >  #include <linux/cleanup.h>
> > > > > >  #include <linux/init.h>
> > > > > >  #include <linux/module.h>
> > > > > > @@ -53,7 +54,7 @@
> > > > > >  #define IRQ_UNBOUND -1
> > > > > >
> > > > > >  /* Supported VDUSE features */
> > > > > > -static const uint64_t vduse_features;
> > > > > > +static const uint64_t vduse_features = BIT_U64(VDUSE_F_QUEUE_READY);
> > > > > >
> > > > > >  /*
> > > > > >   * VDUSE instance have not asked the vduse API version, so assume 0.
> > > > > > @@ -120,6 +121,7 @@ struct vduse_dev {
> > > > > >         char *name;
> > > > > >         struct mutex lock;
> > > > > >         spinlock_t msg_lock;
> > > > > > +       u64 vduse_features;
> > > > > >         u64 msg_unique;
> > > > > >         u32 msg_timeout;
> > > > > >         wait_queue_head_t waitq;
> > > > > > @@ -601,8 +603,29 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_device *vdpa,
> > > > > >  {
> > > > > >         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> > > > > >         struct vduse_virtqueue *vq = dev->vqs[idx];
> > > > > > +       struct vduse_dev_msg msg = { 0 };
> > > > > > +       int r;
> > > > > >
> > > > > >         vq->ready = ready;
> > > > > > +
> > > > > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY)))
> > > > > > +               return;
> > > > > > +
> > > > > > +       msg.req.type = VDUSE_SET_VQ_READY;
> > > > > > +       msg.req.vq_ready.num = idx;
> > > > > > +       msg.req.vq_ready.ready = !!ready;
> > > > > > +
> > > > > > +       r = vduse_dev_msg_sync(dev, &msg);
> > > > > > +
> > > > > > +       if (r < 0) {
> > > > > > +               dev_dbg(&vdpa->dev, "device refuses to set vq %u ready %u",
> > > > > > +                       idx, ready);
> > > > > > +
> > > > > > +               /* We can't do better than break the device in this case */
> > > > >
> > > > > It's better to explain why we can't depend on vduse_dev_msg_sync() here.
> > > > >
> > > > > For example it did:
> > > > >
> > > > >         if (unlikely(dev->broken))
> > > > >                 return -EIO;
> > > > >
> > > > >         init_waitqueue_head(&msg->waitq);
> > > > >         spin_lock(&dev->msg_lock);
> > > > >         if (unlikely(dev->broken)) {
> > > > >                 spin_unlock(&dev->msg_lock);
> > > > >                 return -EIO;
> > > > >         }
> > > > >
> > > > > and
> > > > >
> > > > >         if (!msg->completed) {
> > > > >                 list_del(&msg->list);
> > > > >                 msg->resp.result = VDUSE_REQ_RESULT_FAILED;
> > > > >                 /* Mark the device as malfunction when there is a timeout */
> > > > >                 if (!ret)
> > > > >                         vduse_dev_broken(dev);
> > > > >         }
> > > > >
> > > >
> > > > I'm not sure I follow you here.
> > > >
> > > > We can't do better than breaking the device because the function
> > > > returns no error state, and the caller does not expect an error code.
> > > > Do you mean we can't depend on vduse_dev_msg_sync to call
> > > > vduse_dev_broken(dev) by itself?
> > >
> > > I think I meant, reset seems to be more heavyweight than suspend.
> > >
> > > So if reset can fail, I don't see reason ot break device only for
> > > suspend failure.
> > >
> >
> > Sorry I still don't get you.
> >
> > This series does not implement suspend at all. It doesn't modify the
> > VDUSE device reset or the virtio reset behavior. It only implements
> > the vq ready message for the device. If the device returns an error
> > from that operation, what is your proposal for when the driver sends
> > new messages like resume?
> >
> 
> Friendly ping.

Jason, more comments? If this is to go in it has to go into linux next.

-- 
MST

