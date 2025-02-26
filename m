Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0656210F49
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560595; cv=none; b=eqBj5h6/rEHxWAvFv3lFw2qiahkaHNoHqwV7VH2U7ZOTS+0laK23c2GojBN+No8mpYM/d/AlGJlW1XJFsxVaU1PXaLTZUOAPlEJ+6CFbpOArvW6n2ACXGjmxJWpnwyu5Zv0vcA/c/kt+p2bHhWOyIL9lVWXhvIAPDYYrtrHlv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560595; c=relaxed/simple;
	bh=g6gLBFXvpEOgGJDjblXWCArBBdvpGNVPxWYKgaS04As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bvB2jL3smJrlKqh0DH5nl/A29bkWGWgN27gUi+6sEs0bnpR5Wz2hKCn7Y9DONiYBqynPwrhH/iir5CSqhJ4bKgxc4PxPszxxeaIHSvGjwBn48OHc9akLrbESWbVaz4rYgyjJO82FbT4FdXcoZC3g0BvyfVdLju2iv63yCNyiXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGO8E+Ft; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGO8E+Ft"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D1BD81DFD
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 09:03:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eij5E3F9SZ3w for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Feb 2025 09:03:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3315181F02
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3315181F02
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TGO8E+Ft
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3315181F02
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 09:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740560590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qi5HciIV3JUutET+RsOw0o6fA6bk9IwEPBCuSO3/i6w=;
	b=TGO8E+FttRmyZ8hKx2rW0/5TCdJoKxBhvtq5kTD/g66RWKcu6Z5zXVTbUIX13vCCkkEKKz
	7W43Ji45+e+27kpy7njeRiCOSQHtYfm2umLLJq05YId+LLE0wUuGvujHQ72M1PAfZPR+QA
	JpTnUKZ+5k9zW9rU60X3aRPJj+uxpiE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-28MFjWrtOEWYzqsr7MJUaA-1; Wed, 26 Feb 2025 04:03:08 -0500
X-MC-Unique: 28MFjWrtOEWYzqsr7MJUaA-1
X-Mimecast-MFC-AGG-ID: 28MFjWrtOEWYzqsr7MJUaA_1740560588
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abbc0572fc9so665183266b.0
        for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 01:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740560587; x=1741165387;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi5HciIV3JUutET+RsOw0o6fA6bk9IwEPBCuSO3/i6w=;
        b=M2+hrMNS5c0UQ2Wur3LpLLoceHwJmacrbcd/JZjy9lTgs0VkUrRiHHt3iad/Sl9zhl
         PaIF6Zrx14pQJ2hTfK8cDq/T82blCWYckcmK/cnekTRnSMQn8ul641PGxSlUdoaHqSlZ
         WVE0r71ZQ3gkHimLvaDUDDfPDG8PzdFbLxPfMabwE8tZJrWtJ1UHfJ9dC8EyMtXU99lY
         xQLJpc4FJJEG2Gzzz65zHQqgP5EEHB4Z6/5ug25W5DycGJZYYsFZVSCt8fCazu3+Z9Bj
         mDK9pDoUHuAOGUS3ZZ0OTKPzm0SGnmcnjxGoUnWQoeeNy9ITR/fSoF3KEMl1MHdHASHo
         YgtA==
X-Forwarded-Encrypted: i=1; AJvYcCUDqWDIvhE8mTNZy/D4OuV23nGlodIXRfQ/njYWkACgrWYEM4eCCjIv39xZY5/Rraxo0XyT11NvVDogngLzeg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwQv9QF8LouuqDU2cZfpUOHtdoaFKVgfA28fiW8ap7OFPpWUIA7
	/RwbvAlYhERbnENE4X+N9wXCBQa6uinmfTui79pY5De2UkK6GNzS8UNRTc6CP80DVzdPL7sHrgl
	0Zg2CIgnLVEJVM45DBF3WAlKIt6ZLTc6duHhGSP+a5eVQ8nLSGnzrXZahQ6C/lPTuPzvfJYRThO
	0R9Bsh0KEa/KM=
X-Gm-Gg: ASbGncuCSUrYu4GOkWm8iJhXFWnLiI4mRrtjV8UVGy4OpCDA1No1PMBwa2BDCAd6Ild
	DGlYA94HafK6mA60bbZlEoNGGstSuBmBYerrPIYMSUNUEvXwOrhkRIAchTz6AOphUghN7mnkhJv
	IxmhQVL4m8xL2hqvhF12KXQt1CJsOcXV0IB9J3Gkdb1dD+OIwcb+e6kzSb6dDI51y+QKKHQs1qy
	DletaTmpK8NZqePsLk7ZKHMAdFeHNAkycGQXmhrzi+dBr/3/QncDznf/aH51hLbZoRgLG/oOUUM
	6lx5F3ZaH/opoCGlU+s=
X-Received: by 2002:a17:906:31c4:b0:aa6:6885:e2fa with SMTP id a640c23a62f3a-abc09a0772bmr1929047966b.14.1740560587260;
        Wed, 26 Feb 2025 01:03:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHINfbQ4wBoMreLCkELfzuU4I4j2q+Sul+AT/r/Jhkj+j3SVH2xhet7ld3h5p6Rb1LvmOnUiA==
X-Received: by 2002:a17:906:31c4:b0:aa6:6885:e2fa with SMTP id a640c23a62f3a-abc09a0772bmr1929039966b.14.1740560586548;
        Wed, 26 Feb 2025 01:03:06 -0800 (PST)
Received: from sgarzare-redhat ([5.179.186.222])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed201330csm287247066b.87.2025.02.26.01.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 01:03:05 -0800 (PST)
Date: Wed, 26 Feb 2025 10:02:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, 
	michael.christie@oracle.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <CAGxU2F4b+P4ur16t_qDp-jdf5EJkbtraNFoO4XM3HP1RuOQxzg@mail.gmail.com>
References: <20250223154042.556001-1-lulu@redhat.com>
 <20250223154042.556001-6-lulu@redhat.com>
 <6vadeadshznfijaugusnwqprssqirxjtbtpprvokdk6yvvo6br@5ngvuz7peqoz>
 <CACLfguU8-F=i3N6cyouBxwneM1Fr0oNs9ac3+c5xoHr_zcZW6A@mail.gmail.com>
 <CAGxU2F7-UB+Jh41HkHKOqM+KNqSi2chEzVnFe9XAFmNun=0CTA@mail.gmail.com>
 <20250226035030-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250226035030-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rmNdhqKq0yanfXe8hMKDXAMmbJtzk8qKzgdPfeZWOa8_1740560588
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, 26 Feb 2025 at 09:50, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Feb 26, 2025 at 09:46:06AM +0100, Stefano Garzarella wrote:
> > Hi Cindy,
> >
> > On Wed, 26 Feb 2025 at 07:14, Cindy Lu <lulu@redhat.com> wrote:
> > >
> > > On Tue, Feb 25, 2025 at 7:31 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > >
> > > > On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
> > > > >Add a new UAPI to enable setting the vhost device to task mode.
> > > > >The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> > > > >to configure the mode if necessary.
> > > > >This setting must be applied before VHOST_SET_OWNER, as the worker
> > > > >will be created in the VHOST_SET_OWNER function
> > > > >
> > > > >Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > >---
> > > > > drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
> > > > > include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> > > > > 2 files changed, 40 insertions(+), 2 deletions(-)
> > > > >
> > > > >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > >index d8c0ea118bb1..45d8f5c5bca9 100644
> > > > >--- a/drivers/vhost/vhost.c
> > > > >+++ b/drivers/vhost/vhost.c
> > > > >@@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
> > > > >       int i;
> > > > >
> > > > >       vhost_dev_cleanup(dev);
> > > > >-
> > > > >+      dev->inherit_owner = true;
> > > > >       dev->umem = umem;
> > > > >       /* We don't need VQ locks below since vhost_dev_cleanup makes sure
> > > > >        * VQs aren't running.
> > > > >@@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> > > > > {
> > > > >       struct eventfd_ctx *ctx;
> > > > >       u64 p;
> > > > >-      long r;
> > > > >+      long r = 0;
> > > > >       int i, fd;
> > > > >+      u8 inherit_owner;
> > > > >
> > > > >       /* If you are not the owner, you can become one */
> > > > >       if (ioctl == VHOST_SET_OWNER) {
> > > > >               r = vhost_dev_set_owner(d);
> > > > >               goto done;
> > > > >       }
> > > > >+      if (ioctl == VHOST_FORK_FROM_OWNER) {
> > > > >+              /*inherit_owner can only be modified before owner is set*/
> > > > >+              if (vhost_dev_has_owner(d)) {
> > > > >+                      r = -EBUSY;
> > > > >+                      goto done;
> > > > >+              }
> > > > >+              if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> > > > >+                      r = -EFAULT;
> > > > >+                      goto done;
> > > > >+              }
> > > > >+              /* Validate the inherit_owner value, ensuring it is either 0 or 1 */
> > > > >+              if (inherit_owner > 1) {
> > > > >+                      r = -EINVAL;
> > > > >+                      goto done;
> > > > >+              }
> > > > >+
> > > > >+              d->inherit_owner = (bool)inherit_owner;
> > > > >
> > > > >+              goto done;
> > > > >+      }
> > > > >       /* You must be the owner to do anything else */
> > > > >       r = vhost_dev_check_owner(d);
> > > > >       if (r)
> > > > >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > > >index b95dd84eef2d..8f558b433536 100644
> > > > >--- a/include/uapi/linux/vhost.h
> > > > >+++ b/include/uapi/linux/vhost.h
> > > > >@@ -235,4 +235,22 @@
> > > > >  */
> > > > > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,       \
> > > > >                                             struct vhost_vring_state)
> > > > >+
> > > > >+/**
> > > > >+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device
> > > > >+ *
> > > > >+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
> > > > >+ *
> > > > >+ * When inherit_owner is set to 1:
> > > > >+ *   - The VHOST worker threads inherit its values/checks from
> > > > >+ *     the thread that owns the VHOST device, The vhost threads will
> > > > >+ *     be counted in the nproc rlimits.
> > > > >+ *
> > > > >+ * When inherit_owner is set to 0:
> > > > >+ *   - The VHOST worker threads will use the traditional kernel thread (kthread)
> > > > >+ *     implementation, which may be preferred by older userspace applications that
> > > > >+ *     do not utilize the newer vhost_task concept.
> > > > >+ */
> > > > >+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > > >
> > > > I don't think we really care of the size of the parameter, so can we
> > > > just use `bool` or `unsigned int` or `int` for this IOCTL?
> > > >
> > > > As we did for other IOCTLs where we had to enable/disable something (e.g
> > > > VHOST_VSOCK_SET_RUNNING, VHOST_VDPA_SET_VRING_ENABLE).
> > > >
> > > hi Stefano
> > > I initially used it as a boolean, but during the code review, the
> > > maintainers considered it was unsuitable for the bool use as the
> >
> > I see, indeed I found only 1 case of bool:
> >
> > include/uapi/misc/xilinx_sdfec.h:#define XSDFEC_SET_BYPASS
> > _IOW(XSDFEC_MAGIC, 9, bool)
> >
> > > interface in ioctl (I think in version 3 ?). So I changed it to u8,
> > > then will check if this is 1/0 in ioctl and the u8 should be
> > > sufficient for us to use
> >
> > Okay, if Michael and Jason are happy with it, it's fine.
> > It just seemed strange to me that for other IOCTLs we use int or
> > unsigned int when we need a boolean instead of a sized type.
>
> I only found VHOST_VSOCK_SET_RUNNING. which other ioctls?

VHOST_VDPA_SET_VRING_ENABLE use the `struct vhost_vring_state` where we 
use the `unsigned int num` field as boolean, but I see that this is a 
special case where we re-use the same struct for multiple ioctls.

Thanks,
Stefano

