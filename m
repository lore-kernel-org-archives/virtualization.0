Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3EA86264
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Apr 2024 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040825; cv=none; b=ThybeGhpYoCeD+35rbq2iJmT1p5qLGtisfN+CYo9R2eKnK4s7xf8dAwxfwwAMdc9oqEyNRgSqPQJ97xp1ecAkC7v5tzkbi2UabOehQcBiv2tt/94KiU34MWxBvkoHGvfjTZMoHCxYzvbjb/IdmAdHxY8CKjqUIlFwOrlKqGFDms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040825; c=relaxed/simple;
	bh=uixl8nuzsyXFYXWzPKcewT6UnoNYs6qqp8WThBIlYYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T8oe+bOaexaANGq1+fCwVWxZ6f2B3MKVhevVIs1YhhCu2LDDs3x3qFqKsbOUw6VMXbnvzreL8+QZBByeoQ/PpSb8PI5xwMPUKg1lec4LE0yUS25BOqzWA/L6l3aNf/udmtY7FFj0Xz1GBXW0714e2ewDNc4CmiWR+qhCfUVdRS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4lcYsJc; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4lcYsJc"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37E7B606A6
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Apr 2024 10:27:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zGwQRjNmCZIJ for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Apr 2024 10:27:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 43A98606A3
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43A98606A3
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C4lcYsJc
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 43A98606A3
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Apr 2024 10:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714040822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StDpHEj4qxN3O4ePPPw+2ExFWloqHkamN4QGQkrDpNQ=;
	b=C4lcYsJcL0januS1XvvYaY+YqiPHdE1KgX2Xy8PgFLfS2gJUWP/0YmaqjiPcu0Dk/BUboj
	K5sKdPXnX0Gcl7LMtEp4Gm/Gz0u/37CfrbGiyamga9JP1KchepNFeTGxbiGJkWOGvE953s
	rSrlaPjI4pFl9mGLRLhACI4vP+/hfV4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665--PpHfDXNMpSu7S9VuXU75w-1; Thu, 25 Apr 2024 06:27:00 -0400
X-MC-Unique: -PpHfDXNMpSu7S9VuXU75w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-418f5e7b9b2so3962115e9.3
        for <virtualization@lists.linux-foundation.org>; Thu, 25 Apr 2024 03:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714040819; x=1714645619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StDpHEj4qxN3O4ePPPw+2ExFWloqHkamN4QGQkrDpNQ=;
        b=iOqwJnRdNXTl3Z6TQ/MEDIrxoWh0EAVHVxpY5c9mpQrf8pbtGt2b0WZGk0h5zSWAMg
         cS58siKZIURyzVJrjm/K2hvBOF2f9GT5bH/XCqt1wlwaxioMNt58Ah+sq6wLVvBxI5L+
         y6A2tR0dQcLY7k87VFvRAMatmOc1vHURMZWYsga9Ygno8lSnXreCzXmxV0vPeq+qGqeu
         ASDIfuj5eCNZdAufdmShu6jtpEe2DZtI2vywBEhe97DacJcpICSvu2yk6FAf8KNwsaCS
         V2K01AnGkoru+Qh51diQZeuzLK1Ydcw8BoOq8npRC5OLEK0OSkJ3vpDx8r3gY0VeVqae
         MGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeo20cOwnv4OqI4rDCRIe7yTUXIc62JSKSEHUvYQVwWRNV2c288e4EbzFwouHr5sCGf531ZV67RmYrd9Cg7iaZ5AhsIRc1DAI6h8+WcbRZgwtWX4ZfjvLs9g==
X-Gm-Message-State: AOJu0YylrEhx9rNTMBeaxxCx3FL5ooPahirsaVRHHhBsQpqIPzpEW08u
	Zaec+EzOCLelAhfK+X4oiS6d2Ukhc9ZwAyrAKBMI9JxijU/VOiBGku+snvxzV6RhCo+kRBLWbgE
	HuQVBdKV6rInF2chgtK/1bMgXMUGlxFuvK4CYWuxY3rVNIlmZN5tlf6xkUSx4ea2Jn76flrnvOe
	aW06E=
X-Received: by 2002:a05:600c:45cd:b0:41a:a4d1:a896 with SMTP id s13-20020a05600c45cd00b0041aa4d1a896mr3784204wmo.16.1714040819397;
        Thu, 25 Apr 2024 03:26:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJY9XrsRahoUquS47308gYuYDwb7vPf7/AD+bocV5qjiT1KaTqb1OttUK1khms9pm9okb6pg==
X-Received: by 2002:a05:600c:45cd:b0:41a:a4d1:a896 with SMTP id s13-20020a05600c45cd00b0041aa4d1a896mr3784184wmo.16.1714040818916;
        Thu, 25 Apr 2024 03:26:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:9e35:9594:88eb:df3e:840e])
        by smtp.gmail.com with ESMTPSA id j2-20020a05600c1c0200b0041ac3e13f1esm8619446wms.37.2024.04.25.03.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:26:58 -0700 (PDT)
Date: Thu, 25 Apr 2024 06:26:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for
 reconnection
Message-ID: <20240425062507-mutt-send-email-mst@kernel.org>
References: <20240412133017.483407-1-lulu@redhat.com>
 <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org>
 <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org>
 <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
 <20240423043538-mutt-send-email-mst@kernel.org>
 <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>
 <20240424055108-mutt-send-email-mst@kernel.org>
 <CACGkMEtosWhV-eJbPetgPtp-Thg31CLUBGaENbQRknYtzEV3bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtosWhV-eJbPetgPtp-Thg31CLUBGaENbQRknYtzEV3bQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Apr 25, 2024 at 09:35:58AM +0800, Jason Wang wrote:
> On Wed, Apr 24, 2024 at 5:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Apr 24, 2024 at 08:44:10AM +0800, Jason Wang wrote:
> > > On Tue, Apr 23, 2024 at 4:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Apr 23, 2024 at 11:09:59AM +0800, Jason Wang wrote:
> > > > > On Tue, Apr 23, 2024 at 4:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > > > > > > On Wed, Apr 17, 2024 at 5:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > > > > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > > > > > > and vduse_alloc_reconnnect_info_mem
> > > > > > > > > These functions allow vduse to allocate and free memory for reconnection
> > > > > > > > > information. The amount of memory allocated is vq_num pages.
> > > > > > > > > Each VQS will map its own page where the reconnection information will be saved
> > > > > > > > >
> > > > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++++++
> > > > > > > > >  1 file changed, 40 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > > > > > > >       int irq_effective_cpu;
> > > > > > > > >       struct cpumask irq_affinity;
> > > > > > > > >       struct kobject kobj;
> > > > > > > > > +     unsigned long vdpa_reconnect_vaddr;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > >  struct vduse_dev;
> > > > > > > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
> > > > > > > > >
> > > > > > > > >       vq->irq_effective_cpu = curr_cpu;
> > > > > > > > >  }
> > > > > > > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > > > > > > > > +{
> > > > > > > > > +     unsigned long vaddr = 0;
> > > > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > > > +
> > > > > > > > > +     for (int i = 0; i < dev->vq_num; i++) {
> > > > > > > > > +             /*page 0~ vq_num save the reconnect info for vq*/
> > > > > > > > > +             vq = dev->vqs[i];
> > > > > > > > > +             vaddr = get_zeroed_page(GFP_KERNEL);
> > > > > > > >
> > > > > > > >
> > > > > > > > I don't get why you insist on stealing kernel memory for something
> > > > > > > > that is just used by userspace to store data for its own use.
> > > > > > > > Userspace does not lack ways to persist data, for example,
> > > > > > > > create a regular file anywhere in the filesystem.
> > > > > > >
> > > > > > > Good point. So the motivation here is to:
> > > > > > >
> > > > > > > 1) be self contained, no dependency for high speed persist data
> > > > > > > storage like tmpfs
> > > > > >
> > > > > > No idea what this means.
> > > > >
> > > > > I mean a regular file may slow down the datapath performance, so
> > > > > usually the application will try to use tmpfs and other which is a
> > > > > dependency for implementing the reconnection.
> > > >
> > > > Are we worried about systems without tmpfs now?
> > >
> > > Yes.
> >
> > Why? Who ships these?
> 
> Not sure, but it could be disabled or unmounted. I'm not sure make
> VDUSE depends on TMPFS is a good idea.
> 
> Thanks

Don't disable or unmount it then?
The use-case needs to be much clearer if we are adding a way for
userspace to pin kernel memory for unlimited time.

-- 
MST

