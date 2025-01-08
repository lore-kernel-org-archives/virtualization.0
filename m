Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A21F8906
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338811; cv=none; b=QDEACrBO8dT19DA7DNQrbOGMnm1tZyCVlyxGVv/llsdIBH3Q6MCEQ7hVS6gx0nSdkpjbNNv0JN5LeWmGda+RV4Sz9P9QF6g+BKwGNgOqCb9lAq+Vg5stD3ojQOqU1MH+dQCIn/Ml5/ppKPEByYukj/GvQgURK2n+QnDV9ID16YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338811; c=relaxed/simple;
	bh=HAHSQYiW7j7jDWWaKzSiXVvSlJqTsmQpmrOEno+dRl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XZPxKwkrmMR6/JZf22vXd76PVcRkX65rzcJqDztipH9ULPdUFI4ilSlmBdhSYa6cUgeu2DBWuboel6kFuBIQtZq135WUUP/bqKmFS5wBTxSwflvD6xA0p0EIKaopcZ6Jg5sEiwJQbd9WhrxvFK4jEFIp8KPaEBv77ktnIUZ/WgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RuTG5apf; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuTG5apf"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EE97607A8
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 12:20:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DRCkYGkju9EU for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jan 2025 12:20:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3D2556066D
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D2556066D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RuTG5apf
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3D2556066D
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736338807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvkScmKSiojMKy4UOE2DrwK0+YmOWXUTXTU3FB5pL+0=;
	b=RuTG5apfYKVsNIDPj7GFNdk1Ig9tNIPnEv9Xng/lJ47l4iXsKTzPrPagF55RYIQ8Q7CvK7
	51VRNcasXHNgA3M/HE8wsiBh7lkj0PXFSoYn+E4tZtcnSqHoNc9buD4TKMrSVnUdoFIioZ
	kRjwTGQeCoxY82HGlZnCOaVIo0+gz6Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428--EScCPnVNBeZWvB_vpPuNQ-1; Wed, 08 Jan 2025 07:20:06 -0500
X-MC-Unique: -EScCPnVNBeZWvB_vpPuNQ-1
X-Mimecast-MFC-AGG-ID: -EScCPnVNBeZWvB_vpPuNQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aaf901a0ef9so510921866b.0
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 04:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736338805; x=1736943605;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvkScmKSiojMKy4UOE2DrwK0+YmOWXUTXTU3FB5pL+0=;
        b=lMR4yIyqn2Vlf5/d3CLds7GblETADoISDtSvI0n1yAHN8xTpyvQSRfkmQvtwbeUssi
         OxRX7MEQ8OBcDTzdbI+LJJEx9/cGf2PPuWxBLZHaX6eN6gY1R7yy59zTyjb7AhKVRzs3
         ov2/xf7Xo0j/hniKixQzC9J3jT3aGL/PSkxT7+cNFFbNt1o/4tWN2xUzsUTbM1X+tYef
         n1dvF0Gf1WgIEFWyHFpBlDAeHX2FS2xAJ7IHEl8A6K++1ZTcT9u2T5UhkapU9FPoKNtz
         H0jT+6emUosEGSAHvUX2VjZE7Ibbw91PU/Xe5m5VUOHh+k1ivZm7215ZlIwJrZoFFtHe
         55ow==
X-Forwarded-Encrypted: i=1; AJvYcCUi3z8kZbhMkLEWdD+e0aV0S0cESq4DZGHsA1KWRCzy4FnZfZbxveWtbnMYkpGlSUV2+JNJSYmxoDg0hwBgYg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx0BG0BbicxFcbYv/YvHky/TZoIrWhgWPThpFlqLksM8gO6cw4+
	tx4kNglSSmbQRcZ6fm3FHLHZJqy6ANADARgtnpKi0U4QEuMKxDxWEZXG4829Y41L8NqziQibP0N
	k9OMSs18FNt0Kq71evtsJQUxfsk63xOw+RlYXUV/uWW8RupemS2cskJCOSJmtRJ6Rn6zItaaVhT
	fyU5Y=
X-Gm-Gg: ASbGncvt0Bp/YsjUTAPO9ij36lhzbLof+pUr2OQOPsglKHsKSobitc5KddHhdYJVDR/
	6wll24hube9i4bwmnZGZj28X1ZMBjO1qJ4QRdJg0MucEvGjprgmNQJ5bbbkIBemTJCfK56oIy1l
	aNzeF7cQdBFw6ysFWzAPhq/8zghrdFaYGvb3iv3gomxmDbUQiN6XT74I4CJIwnsk0bJac9nyBhc
	gBKaaGG9zX4AWSdiBFXUIPs0wkBbNWHKOW/tgcBAsLZfA66Dos=
X-Received: by 2002:a17:906:6a1e:b0:aae:bac6:6659 with SMTP id a640c23a62f3a-ab2ab675c7bmr195885666b.7.1736338805307;
        Wed, 08 Jan 2025 04:20:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJnfpyyzkpOex2toXbOpvS659Qc95KZbvn2dCmymN19iFdvMLZcxesMMp7PrcMbRk8ElqcfQ==
X-Received: by 2002:a17:906:6a1e:b0:aae:bac6:6659 with SMTP id a640c23a62f3a-ab2ab675c7bmr195881866b.7.1736338804843;
        Wed, 08 Jan 2025 04:20:04 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f31bsm2471713066b.1.2025.01.08.04.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:20:04 -0800 (PST)
Date: Wed, 8 Jan 2025 07:20:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <20250108071933-mutt-send-email-mst@kernel.org>
References: <20241230124445.1850997-1-lulu@redhat.com>
 <20241230124445.1850997-6-lulu@redhat.com>
 <CACGkMEvPbe3wvC0UvAu-vgGYu1xMWRzCt0qwUofcHJThRdFxiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvPbe3wvC0UvAu-vgGYu1xMWRzCt0qwUofcHJThRdFxiQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YJueKKMbiq2lCl4YVmJ2cJkMhJcR4EmrzwvhDgGyVEQ_1736338805
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 02, 2025 at 11:36:58AM +0800, Jason Wang wrote:
> On Mon, Dec 30, 2024 at 8:45 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add a new UAPI to enable setting the vhost device to task mode.
> > The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> > to configure the mode if necessary.
> > This setting must be applied before VHOST_SET_OWNER, as the worker
> > will be created in the VHOST_SET_OWNER function
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
> >  include/uapi/linux/vhost.h | 19 +++++++++++++++++++
> >  2 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index ff17c42e2d1a..47c1329360ac 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2250,15 +2250,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >  {
> >         struct eventfd_ctx *ctx;
> >         u64 p;
> > -       long r;
> > +       long r = 0;
> >         int i, fd;
> > +       u8 inherit_owner;
> >
> >         /* If you are not the owner, you can become one */
> >         if (ioctl == VHOST_SET_OWNER) {
> >                 r = vhost_dev_set_owner(d);
> >                 goto done;
> >         }
> > +       if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {
> > +               /*inherit_owner can only be modified before owner is set*/
> > +               if (vhost_dev_has_owner(d)) {
> > +                       r = -EBUSY;
> > +                       goto done;
> > +               }
> > +               if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> > +                       r = -EFAULT;
> > +                       goto done;
> > +               }
> 
> Not a native speaker but I wonder if "VHOST_FORK_FROM_OWNER" is better or not.
> 
> > +               /* Validate the inherit_owner value, ensuring it is either 0 or 1 */
> > +               if (inherit_owner > 1) {
> > +                       r = -EINVAL;
> > +                       goto done;
> > +               }
> > +
> > +               d->inherit_owner = (bool)inherit_owner;
> 
> So this allows userspace to reset the owner and toggle the value. This
> seems to be fine, but I wonder if we need to some cleanup in
> vhost_dev_reset_owner() or not. Let's explain this somewhere (probably
> in the commit log).
> 
> >
> > +               goto done;
> > +       }
> >         /* You must be the owner to do anything else */
> >         r = vhost_dev_check_owner(d);
> >         if (r)
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index b95dd84eef2d..f5fcf0b25736 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -235,4 +235,23 @@
> >   */
> >  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                               struct vhost_vring_state)
> > +
> > +/**
> > + * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the vhost device
> > + *
> > + * @param inherit_owner: An 8-bit value that determines the vhost thread mode
> > + *
> > + * When inherit_owner is set to 1 (default behavior):
> > + *   - The VHOST worker threads inherit their values/checks from
> > + *     the thread that owns the VHOST device. The vhost threads will
> > + *     be counted in the nproc rlimits.
> > + *
> > + * When inherit_owner is set to 0:
> > + *   - The VHOST worker threads will use the traditional kernel thread (kthread)
> > + *     implementation, which may be preferred by older userspace applications that
> > + *     do not utilize the newer vhost_task concept.
> > + */
> > +
> > +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > +
> >  #endif
> > --
> > 2.45.0
> 
> Thanks


At this point, make these changes with patches on top pls.

