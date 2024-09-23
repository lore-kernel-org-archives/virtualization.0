Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB4198830
	for <virtualization@lists.linux.dev>; Mon, 23 Sep 2024 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110081; cv=none; b=JCwJ1kXB4mD5YfRcFnly7EJt8JgC4Rd3TqQWXhBCpupkkrqL7rh7/dqDMO7cP29svgY7y9zKnRp8LTBYEnKVS/f04YRpV5UnIRbDRN7tNZThHXRxUsg/Taq7AvLMyYUkkTVBufLiw8AN608aEGkwUg70CznytF01HbY55539cKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110081; c=relaxed/simple;
	bh=/p30FrVYVuYfEnt6kv72Q1UcFg9YJf1SQEiA395yPXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBHn7dscPtfsgD0e6SZH3Qu44VEVSMnUWOZUtnPJLvDUUxcb3wps6umHk4Qg8waVcDD278W0CupFCII1r51khj6XsZ24pdZ+NQ7WRqDGOfVblHjolx1l4q2FxI7LPDwXSJYI08UNDYSVjTRDD8rugFGc05wFD7kxskxlW5HGg4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=To7o0Qwl; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="To7o0Qwl"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c358b72615so40395896d6.0
        for <virtualization@lists.linux.dev>; Mon, 23 Sep 2024 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727110079; x=1727714879; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jkCqUIg3Xe8RRG1JyAgfDxC/SwDY13wlpSpEmGTb8k=;
        b=To7o0QwlUI2D6bUAhvPYVyMV1LxsC6Pn5GnK3HUa9Mf0sDWrCjy9GgNGsjMnbdQu+t
         e5vsElHGq7om6dxV4rtFeOrNwXkqktGpk9I76CWQ33pLT1tGkzKGxKMRtcb0l/pqyL9g
         PgHx3vO+zi9IbFOkDZHD758Hv/2za5+ZgsGbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727110079; x=1727714879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jkCqUIg3Xe8RRG1JyAgfDxC/SwDY13wlpSpEmGTb8k=;
        b=idFIN49LQcpJ+N/csuSnUg3KaDhWlvm5czt/wJATl5xFBPf13j5VpLYuo60L7BjCh3
         aUkpVLU8PUz6ZX331IdfO0ypRoH1JnKk+vrjIEVpB+UzRm5833Jo0E11JB1w46HFd82Z
         cGDNZK2Oc3ahUWWTco5UANP1y0wFVNH8zUqmZH/sOwJcgBMbaPS0sVz8N8W6R/I/m5bU
         G1I6SKG+Ver2tC0MGKfmC0dtCGae3hsQOJ1Ow6xsLiLpoixteb+nhyfMsyyc7PMHX6SS
         dBcJ7xfiNNpA/hIsPy6Wo9V2BykPZQg1MOyt94cRwIXwMc8WJxT0ecp7ANq8rm/T/3nj
         5qGw==
X-Forwarded-Encrypted: i=1; AJvYcCUiUZ2PA6tp6TLr8Lxu/toZaGIJgiJFJ1tBgwPNkrddGvWR4V6nURzK7jEWb0XLDETKy8agpYP0aTUefDYAwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHGgePcKOI3Fyw7Txugm1E3KaBK0P5fwdorVavUkZs99ZKWmZh
	J8AqLiW2vdXnFimUWAMFuydEnqaPzKgPU6NPmKIkcXQT8sw0OARyriobnC/nyNKoqSIrVMzg6cc
	NP1eZf2ds4I7zSb9jkzWCuxlzEqGvkrjeEG/C
X-Google-Smtp-Source: AGHT+IG2yd0efpRRzhPAk2QTdSce9Tjc0IthclvMuhkAgRnoOsrG4G3REAz+LXZA408Gybkvd7KwLETYZ59qfR+vU8Q=
X-Received: by 2002:a05:6214:469b:b0:6c3:6a68:499f with SMTP id
 6a1803df08f44-6c7bc73066bmr168626116d6.19.1727110078647; Mon, 23 Sep 2024
 09:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240815004617.2325269-1-philipchen@chromium.org>
 <CA+cxXhneUKWr+VGOjmOtWERA53WGcubjWBuFbVBBuJhNhSoBcQ@mail.gmail.com>
 <66d89eaeb0a4b_1e9158294e1@iweiny-mobl.notmuch> <CA+cxXhmexXuXJg2qgbDJO7MXqpJzuDH1_Hru=7Ei9jus=FGwew@mail.gmail.com>
In-Reply-To: <CA+cxXhmexXuXJg2qgbDJO7MXqpJzuDH1_Hru=7Ei9jus=FGwew@mail.gmail.com>
From: Philip Chen <philipchen@chromium.org>
Date: Mon, 23 Sep 2024 09:47:46 -0700
Message-ID: <CA+cxXhmnsysKE-pTCkx38U5r+ofM6_2nFS5R1_rW3p3FbmiSLw@mail.gmail.com>
Subject: Re: [PATCH] virtio_pmem: Add freeze/restore callbacks
To: Ira Weiny <ira.weiny@intel.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi maintainers,

Are there any other concerns I should address for this patch?

On Mon, Sep 9, 2024 at 4:52=E2=80=AFPM Philip Chen <philipchen@chromium.org=
> wrote:
>
> Hi
>
> On Wed, Sep 4, 2024 at 10:54=E2=80=AFAM Ira Weiny <ira.weiny@intel.com> w=
rote:
> >
> > Philip Chen wrote:
> > > Hi maintainers,
> > >
> > > Can anyone let me know if this patch makes sense?
> > > Any comment/feedback is appreciated.
> > > Thanks in advance!
> >
> > I'm not an expert on virtio but the code looks ok on the surface.  I've
> > discussed this with Dan a bit and virtio-pmem is not heavily tested.
>
> Thanks for your comments.
> I think this specific patch is not heavily involved with virtio spec deta=
ils.
> This patch simply provides the basic freeze/restore PM callbacks for
> virtio_pmem, like people already did for the other virtio drivers.
>
> >
> > Based on our discussion [1] I wonder if there is a way we can recreate =
this
> > with QEMU to incorporate into our testing?
>
> Yes, these are how I test on crosvm, but I believe the same steps can
> be applied to QEMU:
> (1) Set pm_test_level to TEST_PLATFORM (build time change)
> (2) Write something to pmem
> (3) Make the device go through a freeze/restore cycle by writing
> `disk` to `/sys/power/state`
> (4) Validate the data written to pmem in (2) is still preserved
>
> Note:
> (a) The freeze/restore PM routines are sometimes called as the backup
> for suspend/resume PM routines in a suspend/resume cycle.
> In this case, we can also test freeze/restore PM routines with
> suspend/resume: i.e. skip (1) and write `mem` to `sys/power/state` in
> (3).
> (b) I also tried to set up QEMU for testing. But QEMU crashes when I
> try to freeze the device even without applying this patch.
> Since the issue seems to be irrelevant to pmem and most likely a QEMU
> setup problem on my end, I didn't spend more time enabling QEMU.
>
>
>
> >
> > Ira
> >
> > [1] https://lore.kernel.org/lkml/CA+cxXhnb2i5O7_BiOfKLth5Zwp5T62d6F6c39=
vnuT53cUkU_uw@mail.gmail.com/
> >
> > >
> > > On Wed, Aug 14, 2024 at 5:46=E2=80=AFPM Philip Chen <philipchen@chrom=
ium.org> wrote:
> > > >
> > > > Add basic freeze/restore PM callbacks to support hibernation (S4):
> > > > - On freeze, delete vq and quiesce the device to prepare for
> > > >   snapshotting.
> > > > - On restore, re-init vq and mark DRIVER_OK.
> > > >
> > > > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > > > ---
> > > >  drivers/nvdimm/virtio_pmem.c | 24 ++++++++++++++++++++++++
> > > >  1 file changed, 24 insertions(+)
> > > >
> > > > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_p=
mem.c
> > > > index c9b97aeabf85..2396d19ce549 100644
> > > > --- a/drivers/nvdimm/virtio_pmem.c
> > > > +++ b/drivers/nvdimm/virtio_pmem.c
> > > > @@ -143,6 +143,28 @@ static void virtio_pmem_remove(struct virtio_d=
evice *vdev)
> > > >         virtio_reset_device(vdev);
> > > >  }
> > > >
> > > > +static int virtio_pmem_freeze(struct virtio_device *vdev)
> > > > +{
> > > > +       vdev->config->del_vqs(vdev);
> > > > +       virtio_reset_device(vdev);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int virtio_pmem_restore(struct virtio_device *vdev)
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       ret =3D init_vq(vdev->priv);
> > > > +       if (ret) {
> > > > +               dev_err(&vdev->dev, "failed to initialize virtio pm=
em's vq\n");
> > > > +               return ret;
> > > > +       }
> > > > +       virtio_device_ready(vdev);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static unsigned int features[] =3D {
> > > >         VIRTIO_PMEM_F_SHMEM_REGION,
> > > >  };
> > > > @@ -155,6 +177,8 @@ static struct virtio_driver virtio_pmem_driver =
=3D {
> > > >         .validate               =3D virtio_pmem_validate,
> > > >         .probe                  =3D virtio_pmem_probe,
> > > >         .remove                 =3D virtio_pmem_remove,
> > > > +       .freeze                 =3D virtio_pmem_freeze,
> > > > +       .restore                =3D virtio_pmem_restore,
> > > >  };
> > > >
> > > >  module_virtio_driver(virtio_pmem_driver);
> > > > --
> > > > 2.46.0.76.ge559c4bf1a-goog
> > > >
> >
> >
