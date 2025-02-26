Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A620CCF1
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559858; cv=none; b=Hjpfi+83HvyOpM/l4fDayCNXU4JncBcCOaiJ192XuiQXWi1gS2eyGnElfcKJezvClEpZXeUAyGmkkKpktIHqX/rfR8vnf3kBBMHVbVLY0FDNi/2eshbJWlPoCvB00wcIXxqpiovGb0eM4PuNBkLhVUPzDRleqkz/1c/LoV9Ck9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559858; c=relaxed/simple;
	bh=TlqIDV8RqYlxPo/b6yGAe9zWBggL5/w9qEsziGhHGZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nYMfhVizV6aAydAFZXPH2+8MFVMp5Vbe8UCCjEpLfdeKR6xqylkupxpymOP0T4N6QeqqzWkbFvN7gpXkkgJRJlEHxSE4SEfNG8xuuZSOTbrV3Ukl3ZO5SvCyOM3823p8wEwV+ThSU8SP36ZA5dtwUBySyuITJaCLKqe0SKWNn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HokOamIB; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HokOamIB"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2E4440DB3
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 08:50:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YHkHiSM8HKfX for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Feb 2025 08:50:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3B76A40DB2
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B76A40DB2
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HokOamIB
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B76A40DB2
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740559854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W569uJXR/VXEzmXeXl4vPfAutQmoCsakKrgYooeW6j8=;
	b=HokOamIBFe+uhHfbWn3FkllGny4MLuydbW78+hzfy+Z1hjqUzTyh3XIIDqOC4MQsnkGhcu
	9JghfqUMKP8Lspb8AuvFwCblDqu/WyJMHYDT6wBXZQPuoH43lLqpOtdxNOLpymNyLJIIjU
	vwh/soP+dz6UBn/3rq5thwxP657SlvM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-AcBgBNO2Ox60KbsT5x0CkQ-1; Wed, 26 Feb 2025 03:50:52 -0500
X-MC-Unique: AcBgBNO2Ox60KbsT5x0CkQ-1
X-Mimecast-MFC-AGG-ID: AcBgBNO2Ox60KbsT5x0CkQ_1740559851
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399a5afc95so27701985e9.3
        for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 00:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740559851; x=1741164651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W569uJXR/VXEzmXeXl4vPfAutQmoCsakKrgYooeW6j8=;
        b=J9YkHsgqB57tyrVlWA4Wif1XnV2x4yxOLx9r0wt8mRU/cmCqbh13XXtgRDIxkuxFcT
         mY0LJ643a5dXDE+wyN/BxuBb0MJ2LdsEYnPs3av23qFKl5zxFliPsJcUheuRYXv3SH53
         6KA/V0+R2BUetlXJ/WbjUbM6B+BnZ5vR1wsMwgrVR7P1GcwuZvfNka/3WFFeylz9ojyN
         p4oc0jMjyp2ZKMpGel4sO1eMccXqS3cWT/60nu6jcc4Xg98SVmKZZi6cVHiT2ZMpdBRL
         pDKSXv7x1NYhuwOjfAt1VQHxUGfDjr94VpjK1L1OUpDYPvZL9o/BddH4+jc446xPmn+l
         wKUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9yDSIKuDB706wFll9lyoB7t+4/iWdwYswW2LoPGBMDxdxTASkTZMRt223yCYz7IOyk/JLGQrlgvwf0TqteA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzy40Ci9CB6zjNcJ5alD4swGLwI0raXPQmwYWRvtLsdGutc7cBC
	ELdcWJ7W8EmevCH5ebAvNTP9ntc6GP66wlzYf9RdBMFsxsAtTwh70jvbRlO94dXMN3aQj/o8Cym
	imLGbVFZwo6DvxHD04d+71etiC1m8TH8uyk4Pxmbp9QwXhVl9/thtTwddKtAUhAOQyYOTulc1gW
	muKgA=
X-Gm-Gg: ASbGncun1o7zUHxFZZus8pjZQeEZXAyEtxGtaYcdnETWsZCmZ5j3XV8N0yx5nEozebd
	/Oz7ww2hcTnInjArkz7931bJRG+oiAj0LoAJh+35kbTBMB8pO7p+rANb8+vxHzlAvdrqEIiGs9k
	6qgrtiZIehhf5eR/qzpVWApNpmKEbOJU26TOGUxtoWHj4huGDt3gW92Pib8Oh4KPc+8574+HpXp
	GMftaPpOCc2gU8i9Ph6uxrwKJ4XBTf4xqPx5bFQwnMC/6wDzffF/Wq7UUp5gDEid6GI41RAfeBT
	Zog4o3FaPg==
X-Received: by 2002:a05:600c:4f93:b0:439:9c0e:3692 with SMTP id 5b1f17b1804b1-439b75b6417mr141340455e9.28.1740559851171;
        Wed, 26 Feb 2025 00:50:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbMJ5mkQfjiSQborGir/O3+YljBsy/esutoUmpA27ZFyuTcn1+Xvu16xwWUH6sOldzPwK0qQ==
X-Received: by 2002:a05:600c:4f93:b0:439:9c0e:3692 with SMTP id 5b1f17b1804b1-439b75b6417mr141340255e9.28.1740559850795;
        Wed, 26 Feb 2025 00:50:50 -0800 (PST)
Received: from redhat.com ([2a02:14f:1eb:e270:8595:184c:7546:3597])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba4c437asm14054485e9.0.2025.02.26.00.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 00:50:50 -0800 (PST)
Date: Wed, 26 Feb 2025 03:50:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
	michael.christie@oracle.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <20250226035030-mutt-send-email-mst@kernel.org>
References: <20250223154042.556001-1-lulu@redhat.com>
 <20250223154042.556001-6-lulu@redhat.com>
 <6vadeadshznfijaugusnwqprssqirxjtbtpprvokdk6yvvo6br@5ngvuz7peqoz>
 <CACLfguU8-F=i3N6cyouBxwneM1Fr0oNs9ac3+c5xoHr_zcZW6A@mail.gmail.com>
 <CAGxU2F7-UB+Jh41HkHKOqM+KNqSi2chEzVnFe9XAFmNun=0CTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAGxU2F7-UB+Jh41HkHKOqM+KNqSi2chEzVnFe9XAFmNun=0CTA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M6ufeWdvbsXivkINHr8CrJOF9V-O-lud2kL_SAELt6M_1740559851
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 26, 2025 at 09:46:06AM +0100, Stefano Garzarella wrote:
> Hi Cindy,
> 
> On Wed, 26 Feb 2025 at 07:14, Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Tue, Feb 25, 2025 at 7:31 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > >
> > > On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
> > > >Add a new UAPI to enable setting the vhost device to task mode.
> > > >The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> > > >to configure the mode if necessary.
> > > >This setting must be applied before VHOST_SET_OWNER, as the worker
> > > >will be created in the VHOST_SET_OWNER function
> > > >
> > > >Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > >---
> > > > drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
> > > > include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> > > > 2 files changed, 40 insertions(+), 2 deletions(-)
> > > >
> > > >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > >index d8c0ea118bb1..45d8f5c5bca9 100644
> > > >--- a/drivers/vhost/vhost.c
> > > >+++ b/drivers/vhost/vhost.c
> > > >@@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
> > > >       int i;
> > > >
> > > >       vhost_dev_cleanup(dev);
> > > >-
> > > >+      dev->inherit_owner = true;
> > > >       dev->umem = umem;
> > > >       /* We don't need VQ locks below since vhost_dev_cleanup makes sure
> > > >        * VQs aren't running.
> > > >@@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> > > > {
> > > >       struct eventfd_ctx *ctx;
> > > >       u64 p;
> > > >-      long r;
> > > >+      long r = 0;
> > > >       int i, fd;
> > > >+      u8 inherit_owner;
> > > >
> > > >       /* If you are not the owner, you can become one */
> > > >       if (ioctl == VHOST_SET_OWNER) {
> > > >               r = vhost_dev_set_owner(d);
> > > >               goto done;
> > > >       }
> > > >+      if (ioctl == VHOST_FORK_FROM_OWNER) {
> > > >+              /*inherit_owner can only be modified before owner is set*/
> > > >+              if (vhost_dev_has_owner(d)) {
> > > >+                      r = -EBUSY;
> > > >+                      goto done;
> > > >+              }
> > > >+              if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> > > >+                      r = -EFAULT;
> > > >+                      goto done;
> > > >+              }
> > > >+              /* Validate the inherit_owner value, ensuring it is either 0 or 1 */
> > > >+              if (inherit_owner > 1) {
> > > >+                      r = -EINVAL;
> > > >+                      goto done;
> > > >+              }
> > > >+
> > > >+              d->inherit_owner = (bool)inherit_owner;
> > > >
> > > >+              goto done;
> > > >+      }
> > > >       /* You must be the owner to do anything else */
> > > >       r = vhost_dev_check_owner(d);
> > > >       if (r)
> > > >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > >index b95dd84eef2d..8f558b433536 100644
> > > >--- a/include/uapi/linux/vhost.h
> > > >+++ b/include/uapi/linux/vhost.h
> > > >@@ -235,4 +235,22 @@
> > > >  */
> > > > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,       \
> > > >                                             struct vhost_vring_state)
> > > >+
> > > >+/**
> > > >+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device
> > > >+ *
> > > >+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
> > > >+ *
> > > >+ * When inherit_owner is set to 1:
> > > >+ *   - The VHOST worker threads inherit its values/checks from
> > > >+ *     the thread that owns the VHOST device, The vhost threads will
> > > >+ *     be counted in the nproc rlimits.
> > > >+ *
> > > >+ * When inherit_owner is set to 0:
> > > >+ *   - The VHOST worker threads will use the traditional kernel thread (kthread)
> > > >+ *     implementation, which may be preferred by older userspace applications that
> > > >+ *     do not utilize the newer vhost_task concept.
> > > >+ */
> > > >+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > >
> > > I don't think we really care of the size of the parameter, so can we
> > > just use `bool` or `unsigned int` or `int` for this IOCTL?
> > >
> > > As we did for other IOCTLs where we had to enable/disable something (e.g
> > > VHOST_VSOCK_SET_RUNNING, VHOST_VDPA_SET_VRING_ENABLE).
> > >
> > hi Stefano
> > I initially used it as a boolean, but during the code review, the
> > maintainers considered it was unsuitable for the bool use as the
> 
> I see, indeed I found only 1 case of bool:
> 
> include/uapi/misc/xilinx_sdfec.h:#define XSDFEC_SET_BYPASS
> _IOW(XSDFEC_MAGIC, 9, bool)
> 
> > interface in ioctl (I think in version 3 ?). So I changed it to u8,
> > then will check if this is 1/0 in ioctl and the u8 should be
> > sufficient for us to use
> 
> Okay, if Michael and Jason are happy with it, it's fine.
> It just seemed strange to me that for other IOCTLs we use int or
> unsigned int when we need a boolean instead of a sized type.

I only found VHOST_VSOCK_SET_RUNNING. which other ioctls?

> Thanks for looking at it,
> Stefano

