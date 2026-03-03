Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F830C63B
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772523236; cv=none; b=f0saJGvx0dqnfR5OdA6RdQbkAHLqEo2NVLSe28/Uadm86oaykmwUeTnO/BgymvfIXwyCInTsh9KJJcKa389PTv44+wRiRmUdcqvm44WIxalCrlIfWzeeool+Ky4ndNveVSH6YO+AtFIaMN4ipJf+Q4U2LnEJcEO5yi9h8rRDP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772523236; c=relaxed/simple;
	bh=59qHQ7DnDrxED0p5GkQ9k+GnHJ0hTz0cSxZxj2NdNqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=o9ovy2RJWihb9iZJ+xs0AfKeJe020vG9O52NejFF40OZXGt3P4hd1ZYf59T6GGnJgBhPH/egxSeaYegNfmcbXXvhYsTCkmbgsbj1TcfmgL34wVgqcv6KCIR8KHAdOhMVE1yT0wRQIMzTUkZUepHYZxC0l4YU9/CEYnGhjoBkpFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGSkmVSg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGSkmVSg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772523232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlXojMn4d5weZIUKImq/I3PU8ARhz8g49XhRbNnib+o=;
	b=ZGSkmVSgRjxw73y1Lxp6hIRsRadFpDSMvA5BTVJ+1JPiugx8xXAEdm5P52FXrMzuxLzZsW
	IjqzC0LxZiR/fveichildBOu8GCT3IYfhRccuxRPl/A38COQM7TC0Sy28/N3qVTXf4XhqT
	R2sy7OsBjkeFzUVpxTzMydMf15vOzs4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-gTf_v76qMNKAkyBqhDVs0g-1; Tue, 03 Mar 2026 02:33:51 -0500
X-MC-Unique: gTf_v76qMNKAkyBqhDVs0g-1
X-Mimecast-MFC-AGG-ID: gTf_v76qMNKAkyBqhDVs0g_1772523230
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439af7ba802so2097447f8f.2
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 23:33:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772523230; x=1773128030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlXojMn4d5weZIUKImq/I3PU8ARhz8g49XhRbNnib+o=;
        b=kaQC9t4MuqfWf4ZY0wP9B1xRPEPoqxpPDbxGLvDGLF4OMFQ538SGsJbgD+9zWQOdCm
         ufzXt1KToOB13FvDDbcyRyWluNsWnd+TN1nVv3Hs271TnipBHfiEWmR6rmw8c9mDX558
         bKm4u0aHIw0LO9NRs2Oxk5CtV14mmWjigyWAA9M/0rIoj0/+76elPjsMuWQxaoNtndOA
         PhueXh+I4hGjHtk05NNAjXzXxDgCGWfXoqWXb1dIcqspdFmjfNX46e3AbWEDxnETAHqF
         Mxs5JTsPQsM0WjEhN8C+b1cPF/mgkn+yv/p4irIXSOh0hI4be0snjinE737uM/t0fwf2
         C6uw==
X-Forwarded-Encrypted: i=1; AJvYcCUCoKdPKKy6q8/aiztUL/6IRxsMiHXrXSv8NQAixjFfsjJbsKNwxlG7IldGEVEbNT5/yj93MduPqKSWJg3fDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YypnUGzxftprnpzIIJL6d78nP2hWSzLCZCcSqd8g4jgmaavW3KF
	xQUjCcVSxNVGvdhmuSaLyv1aSMZGo1DfqbxuGr1jui/FmQaB9MWCW+c8k9rAA61g9fd0izZM5j/
	OgjXxMU+AYGhx18yg7g7Y256E8RpXiwQIOg4i/GlRAcNUhett3iowG1L9OMK4iHIr1BLJ
X-Gm-Gg: ATEYQzxrTNtpdkXlcPyKKzJsBGVFiGBEVcAG9QXF2/d2UCCbx5n2L/3Fz2fg5tNrNeL
	1q4oPMiaGHK7phTgsGQLrfLgwQ5cdDEADBBGrOR4ifVKRtkx4Eh6VPxSklFcP8llAtEH6IvTLw2
	7DA2agvBdHJFF0PfgdA5ub/97VrT6gOVr8HyQ3XdOjlVo9FJJ6DFMSymRAmn1z+TIgcaD72ASRY
	Vuin3csNloM0peAW84fGjg1AhYUea53p7RwhKlsEz7gUgzZmjwa/SeB4TC89Aj1iPfzlLoSgIy4
	/9xkHLSzKhlook9mbn5sm+lDSSmRSa/0IoNnus2eIt1E+l5br50OJOZ9LXBKZu4+y3jP6e5k+v/
	PuIXu0KvIoZMO7OVmsyEQjDnqovpL2vqfGqL02ToRSXf9rw==
X-Received: by 2002:a05:6000:4387:b0:439:c279:32e9 with SMTP id ffacd0b85a97d-439c2793574mr874600f8f.39.1772523229751;
        Mon, 02 Mar 2026 23:33:49 -0800 (PST)
X-Received: by 2002:a05:6000:4387:b0:439:c279:32e9 with SMTP id ffacd0b85a97d-439c2793574mr874537f8f.39.1772523229106;
        Mon, 02 Mar 2026 23:33:49 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b485a0b6sm17215211f8f.39.2026.03.02.23.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 23:33:48 -0800 (PST)
Date: Tue, 3 Mar 2026 02:33:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Maxime Coquelin <mcoqueli@redhat.com>, linux-kernel@vger.kernel.org,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2 3/5] vduse: add VDUSE_GET_FEATURES ioctl
Message-ID: <20260303022922-mutt-send-email-mst@kernel.org>
References: <20260210082554.1582553-1-eperezma@redhat.com>
 <20260210082554.1582553-4-eperezma@redhat.com>
 <CACGkMEtmnV5xJ6crnfTr5Nk8tZe437OgqB22yTOJ+nnrb0LcPg@mail.gmail.com>
 <CAJaqyWdN7xdu_=mUzE3GGBtTeW5g6O0YwWnV_UmX+g2+FNDkZA@mail.gmail.com>
 <CACGkMEuY0f1xjxc4n6QzKfUa-LFrM-X_xtOpTwm5SWjfVvikHA@mail.gmail.com>
 <CAJaqyWe4V77K7R+d_HvSR_2j+sXqemr+zcLUOf7BPu1hT1-ztA@mail.gmail.com>
 <CACGkMEuADgAONQ6-RF6N9HWouTaVDztUVCW2q-KdLNwDEWfuKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuADgAONQ6-RF6N9HWouTaVDztUVCW2q-KdLNwDEWfuKg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: llGThsLTdB7at1ILHwCNrMlw58FS561Nn9fT5pPBaoU_1772523230
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Mar 03, 2026 at 03:20:22PM +0800, Jason Wang wrote:
> On Fri, Feb 13, 2026 at 3:39 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Fri, Feb 13, 2026 at 2:25 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Thu, Feb 12, 2026 at 4:23 PM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Thu, Feb 12, 2026 at 9:07 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > >
> > > > > On Tue, Feb 10, 2026 at 4:26 PM Eugenio Pérez <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > Add an ioctl to allow VDUSE instances to query the available features
> > > > > > supported by the kernel module.
> > > > > >
> > > > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > > ---
> > > > > > A simple u64 bitmap is used for feature flags. While a flexible array
> > > > > > could support indefinite expansion, 64 bits is sufficient for the
> > > > > > foreseeable future and simplifies the implementation.
> > > > > >
> > > > > > Also, dev_dbg is used for logging rather than dev_err as these can be
> > > > > > triggered from userspace.
> > > > > > ---
> > > > > > v2:
> > > > > > * return -EINVAL if ioctl called with version < 2, so userland visible
> > > > > >   reply is kept (Jason).
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++++++++
> > > > > >  include/uapi/linux/vduse.h         |  7 ++++++-
> > > > > >  2 files changed, 34 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > index d1da7c15d98b..7458cbaed4c7 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > @@ -52,6 +52,9 @@
> > > > > >
> > > > > >  #define IRQ_UNBOUND -1
> > > > > >
> > > > > > +/* Supported VDUSE features */
> > > > > > +static const uint64_t vduse_features;
> > > > > > +
> > > > > >  /*
> > > > > >   * VDUSE instance have not asked the vduse API version, so assume 0.
> > > > > >   *
> > > > > > @@ -1947,6 +1950,19 @@ static bool vduse_validate_config(struct vduse_dev_config *config,
> > > > > >                          sizeof(config->reserved)))
> > > > > >                 return false;
> > > > > >
> > > > > > +       if (api_version < VDUSE_API_VERSION_2) {
> > > > > > +               if (config->vduse_features) {
> > > > > > +                       dev_dbg(vduse_ctrl_dev,
> > > > > > +                               "config->vduse_features with version %llu",
> > > > > > +                               api_version);
> > > > > > +                       return false;
> > > > > > +               }
> > > > > > +       } else {
> > > > > > +               if (config->vduse_features & ~vduse_features)
> > > > > > +                       return false;
> > > > > > +       }
> > > > > > +
> > > > > > +
> > > > > >         if (api_version < VDUSE_API_VERSION_1 &&
> > > > > >             (config->ngroups || config->nas))
> > > > > >                 return false;
> > > > > > @@ -2207,6 +2223,18 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
> > > > > >                 ret = vduse_destroy_dev(name);
> > > > > >                 break;
> > > > > >         }
> > > > > > +       case VDUSE_GET_FEATURES:
> > > > > > +               if (control->api_version < VDUSE_API_VERSION_2) {
> > > > > > +                       dev_dbg(vduse_ctrl_dev,
> > > > > > +                               "VDUSE_GET_FEATURES ioctl with version %llu",
> > > > > > +                               control->api_version);
> > > > > > +                       ret = -EINVAL;
> > > > > > +                       break;
> > > > > > +               }
> > > > > > +
> > > > > > +               ret = put_user(vduse_features, (u64 __user *)argp);
> > > > > > +               break;
> > > > > > +
> > > > > >         default:
> > > > > >                 ret = -EINVAL;
> > > > > >                 break;
> > > > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > > > > index 27832d46084c..8898d9daa777 100644
> > > > > > --- a/include/uapi/linux/vduse.h
> > > > > > +++ b/include/uapi/linux/vduse.h
> > > > > > @@ -37,6 +37,7 @@
> > > > > >   * @vq_align: the allocation alignment of virtqueue's metadata
> > > > > >   * @ngroups: number of vq groups that VDUSE device declares
> > > > > >   * @nas: number of address spaces that VDUSE device declares
> > > > > > + * @vduse_features: VDUSE features
> > > > > >   * @reserved: for future use, needs to be initialized to zero
> > > > > >   * @config_size: the size of the configuration space
> > > > > >   * @config: the buffer of the configuration space
> > > > > > @@ -53,7 +54,8 @@ struct vduse_dev_config {
> > > > > >         __u32 vq_align;
> > > > > >         __u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
> > > > > >         __u32 nas; /* if VDUSE_API_VERSION >= 1 */
> > > > > > -       __u32 reserved[11];
> > > > > > +       __u64 vduse_features;
> > > > >
> > > > > Nit: Should we document " /* if VDUSE_API_VERSION >= 2 */
> > > > >
> > > > > But I have an open question, is this better to just introduce a
> > > > > VDUSE_SET_FEATURES then we can do negotiation to avoid bumping API
> > > > > versions?
> > > > >
> > > >
> > > > How do you know if you can call VDUSE_GET_FEATURES and
> > > > VDUSE_SET_FEATURES then? vduse_ioctl does not even return -ENOIOCMD
> > > > but -EINVAL if you call the equivalent of VDUSE_GET_FEATURES on
> > > > current Linux master. Or should the VDUSE instance assume that if the
> > > > ioctl returns -EINVAL the kernel does not support them?
> > >
> > > If we go that way, yes.
> > >
> >
> > I'm ok with doing the change. Kind of, I still think that increasing
> > the API version is way cleaner, so no ioctl returns any error in
> > regular initialization. But python's style "ask forgiveness not
> > permission" is also ok for me.
> >
> > But I'm really missing the motivation of it. What's the problem with
> > the increase of the version that you are trying to solve here?
> 
> For example, if a feature is simply added via a new ioctl. I think we
> don't need to bump the version. An example is the umem reg/dereg.
> VDUSE starts from this choice so I think we should stick to that.
> 
> I think a better time to bump the version are
> 
> 1) an ioctl is expected to behave differently
> 2) new ioctls are mutually exclusive with one(s) of the existing ioctls
> 3) new initialization protocol
> 
> etc.
> 
> >
> > Can we make a rule to know when to increase the version, and when it
> > is not needed and it is ok for ioctls to just return -EINVAL or
> > -ENOIOCTLCMD, so future series can hit the right behavior from earlier
> > versions?
> 
> See above.
> 
> >
> > From your comment I extract that we don't need to increase the API
> > version number if we just add ioctls commands to the device, like
> > probing if an ioctl exists. Also, we don't need to increase the
> > version if we can tell if a member in vduse_dev_config is known to
> > exist because a previous ioctl (or feature flag) succeeded.
> >
> > Am I missing something?
> 
> I might be wrong, just some thoughts. Please correct me if I was wrong.
> 
> Thanks
> 
> >


Not bumping version is nice as people can cherry pick features.

OTOH if people are cherry picking features then userspace has
to support all kind of combinations of features.


So I think there can not be a simple rule, it boils down to this:
if userspace can handle all failures easily - just add an ioctl.

If userspace can not and would merely assert on success -
update the version.


-- 
MST

