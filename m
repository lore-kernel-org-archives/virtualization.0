Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE31414DF6
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470082; cv=none; b=blJdWvYIXuoLWn/VS7N4lntjccVz7audGhUYHonMVLdg13rAnyG4klErfFA9LWFEjxlFOHAiwz+S8t4hjhQ0VQGjX202SSuwkm+ef6IjRpwlBpstO5xc7BgY/hE6ZNMz5A01XC2h5taN1aoqdd+g9TRZRMQFpGxJK4uAV2zQIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470082; c=relaxed/simple;
	bh=Ftj8CTSLWRYL9OXXbJVKKqgqSrz2XFdu+rwr3vUie6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ni6y70ChV2d8pbC0B8Yop46tlcXmN9bjil/ohuNOZmxXGhOnv6DtpnwsRe/4WvN18XInyDxYXfvTqOL4nFq/3NwWJtsBVsygl6CkEzCaTptQ3UreeqHCr2lWemuO+No3GPDwJVhwb7MWSX9HBpFQYWqKPzM08MSLnfc7BomXvxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjVm9FPw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjVm9FPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789470079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txtxD4oHFA2YkyGlKVoJ0Hr6NZh2d56sqLMTfZsoi3c=;
	b=PjVm9FPwm12JdG7x40yA61AmRsChFDdfTSBsEmKKIE1tV8sUp/Un3+UX4sG9j1UmHf5YVz
	Ty1DpyHCH63nyidbm6ijktYrsktw6WWAhIexc54U9pw3SVlyHQGwZcq+YqqVFQOyH6Tk/o
	+AohKADvgGKgR9caFU66ovfEI1MorrQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-MW_nCHS8NX-Dg8hym5EuAw-1; Tue, 15 Sep 2026 07:01:15 -0400
X-MC-Unique: MW_nCHS8NX-Dg8hym5EuAw-1
X-Mimecast-MFC-AGG-ID: MW_nCHS8NX-Dg8hym5EuAw_1789470075
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c293bac1764so239596966b.0
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 04:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789470074; x=1790074874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=txtxD4oHFA2YkyGlKVoJ0Hr6NZh2d56sqLMTfZsoi3c=;
        b=n7kwqmFUm09aN02oLsaSmTYbR3skRHiWk031tv07gL0186wNXeJgsvx9phcyPOHfc9
         eYmDEXCFxPt4yXmpghHbZvq6pA0LtlxqtG3d0lgY8Yxu7uqJ9Y53XYXraf8dqKMhhx4l
         e8eSsHA0V+95ThGTlcIWMXQS44UU6hh0XaiCB9JxMZ1nEBlaQxSmRkB35gCG28y7Xxqt
         uz9Tdu2RMNYA3Ks85bOGDYzj7AtCG9MsQfYHLvtnk57UJovBMY7tTP6IU92xumtfS/6K
         ch4npFu227orS/A2RGsP3hJc3xutMeP1UAf3vO8K2TCWK7ronlFCa1UVUNqTH5WAcMk8
         dSKw==
X-Forwarded-Encrypted: i=1; AKwUvBzSkinMM+lKxegMPbqUJb2O41r2Iwdd7NHYyrQdZM5XXVClEULeEiT/WRwDeMZ0LszSkpvZcOyGuFRzY6o/eQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lG4o8FwdGoNPvV+4FQWOvwybM15MIkrP4wxtR4YnmTTtzlVYY7
	mT0h4/O2KzJ+EfEacE4z3A0srqX7jODr5LPFiu0BSUbvF8wcwtZUZs8ga6XCyj4O/3dBqfiV4Ew
	vXcjo7FQ4AQxilqRRixLAeNq04BF6JxvKuLOV8DjNjAW5zH52qh7C/G4NTog38ODhXNiJ
X-Gm-Gg: AYBFou3cADn9sLSfuTEqNxzbHKdW3iuHNysVxgpvGTAtvlygmFd8s+/WE2CIgycjKE7
	/e2WPKFY9a3t7r0EJbY4JPk3UODScD7nJ57Rbt73q06H0N2ygp5I+S7rip60Ij94EaLd8iSk+PI
	5uQ2Xu2pTaDWrHz4mZpOgUWDZIHnVgd1PXUI4urY5Ipq+8Ncd/zDTEuA7ayI30+PmZh3+35X0ec
	F/gRhOJMgNCoufZX/V5LrtG9UKIExL/u1FwgL2Wpwb2zi12ZgM5uLogjGEm396Bg9cgjae8pfK/
	N9TI2KAXpHtRkwLrWhTiPX/AK98wWI2qMG5u2N9pug2Yzfa11nuDT6c+8J4UbI8vxOxCgE2lGft
	92a4eZG6SyKlO5hv4q4hoMAQ=
X-Received: by 2002:a17:907:c18:b0:c25:8e53:45ca with SMTP id a640c23a62f3a-c29b87655b6mr752689766b.21.1789470073862;
        Tue, 15 Sep 2026 04:01:13 -0700 (PDT)
X-Received: by 2002:a17:907:c18:b0:c25:8e53:45ca with SMTP id a640c23a62f3a-c29b87655b6mr752683866b.21.1789470073233;
        Tue, 15 Sep 2026 04:01:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966021ae8sm558697666b.22.2026.09.15.04.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:01:12 -0700 (PDT)
Date: Tue, 15 Sep 2026 07:01:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, virtualization@lists.linux.dev,
	Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH] vhost-scsi: do not relock event vq mutex on send_evt
 fallback
Message-ID: <20260915070050-mutt-send-email-mst@kernel.org>
References: <20260912090420.47439-1-physicalmtea@gmail.com>
 <20260913090452.2B8221F00893@smtp.kernel.org>
 <CAJwVaMKtk=PxFq330K8NBLRF7FzgcSu32vt1irLEJ7dSRQ5A_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJwVaMKtk=PxFq330K8NBLRF7FzgcSu32vt1irLEJ7dSRQ5A_w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fxhVa3R0n0XHS495IkA7Q0Adh9a2To-tT5eZUGHobq0_1789470075
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Sep 14, 2026 at 04:38:57PM +0800, Jia Jia wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> >
> > Pre-existing issues:
> > - [Critical] vhost_scsi_do_evt_work() accesses vq->iov[out] without verifying that the guest actually provided an input buffer, leading to arbitrary user-space memory corruption.
> > - [High] Events are processed in LIFO order instead of FIFO, which can cause state corruption for hotplug/hotunplug sequences.
> > --
> >
> > commit 05830c30fc2e4dc682c270a9b487ae5abb66218b
> > Author: Jia Jia <physicalmtea@gmail.com>
> >
> > vhost-scsi: do not relock event vq mutex on send_evt fallback
> >
> > This commit resolves a deadlock during fallback event handling when the vhost
> > worker has disconnected. It splits event completion into an internal unlocked
> > helper and a locked wrapper to safely reuse the completion path.
> >
> > Link: https://lore.kernel.org/all/20260905005352.1E5B01F00A3D@smtp.kernel.org/
> >
> > > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > > index 4f8c0260bc9e7..42abf18291b75 100644
> > > --- a/drivers/vhost/scsi.c
> > > +++ b/drivers/vhost/scsi.c
> > > @@ -660,19 +660,26 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, struct vhost_scsi_evt *evt)
> > >       vhost_scsi_log_write(vq, vq_log, log_num);
> > >  }
> > >
> > > -static void vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
> > > +/* Caller must hold the event virtqueue mutex. */
> > > +static void __vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
> > >  {
> > > -     struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
> > >       struct vhost_scsi_evt *evt, *t;
> > >       struct llist_node *llnode;
> > >
> > > -     mutex_lock(&vq->mutex);
> > >       llnode = llist_del_all(&vs->vs_event_list);
> > >       llist_for_each_entry_safe(evt, t, llnode, list) {
> >
> > [Severity: High]
> > This is a pre-existing issue, but does this loop deliver events to the guest
> > in reverse order?
> >
> > The events are added to vs_event_list using llist_add(), which constructs a
> > last-in, first-out list. Because lnode is retrieved locklessly with
> > llist_del_all(), and the iteration happens without first calling
> > llist_reverse_order(), the events appear to be processed from newest to
> > oldest.
> >
> > Could this cause state corruption for hotplug and hotunplug sequences? For
> > example, if a device is plugged and then rapidly unplugged, the guest might
> > receive the unplug event first and the plug event second, leaving it
> > erroneously believing the device is still present.
> >
> 
> Looks like this could get the acquire order wrong? Need to verify.


didn't look into this yet - did u reach any conclusion?

> > >               if (!drop)
> > >                       vhost_scsi_do_evt_work(vs, evt);
> >
> > [Severity: Critical]
> > This is a pre-existing issue, but can this function access out-of-bounds or
> > stale memory if the guest provides an empty input buffer?
> >
> > Looking at vhost_scsi_do_evt_work() in drivers/vhost/scsi.c, the code uses
> > vhost_get_vq_desc() which populates vq->iov:
> >
> >     head = vhost_get_vq_desc(vq, vq->iov,
> >             ARRAY_SIZE(vq->iov), &out, &in,
> >             vq_log, &log_num);
> >     ...
> >     if ((vq->iov[out].iov_len != sizeof(struct virtio_scsi_event))) {
> >         vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n",
> >                 vq->iov[out].iov_len);
> >
> > If a guest submits a descriptor chain with only read-only descriptors,
> > vhost_get_vq_desc() sets in = 0. The out variable holds the count of
> > read-only descriptors, meaning the first writable descriptor expected by the
> > host would be at index out.
> >
> 
> This is a dup -- an earlier patch already fixed it:
> https://lore.kernel.org/all/20260904005240.502787-1-physicalmtea@gmail.com/
> It was while fixing that earlier issue that Sashiko spotted this
> adjacent problem.
> 
> > Does the length check above access vq->iov[out].iov_len without verifying
> > that in > 0?
> >
> > If in is 0, vq->iov[out] was not populated by vhost_get_vq_desc() and
> > contains stale data from a previous request. Could a malicious guest use
> > this to force the kernel to write the event structure to a previously
> > legitimate but now hot-unplugged host virtual address via the
> > __copy_to_user() call later in the function?
> >
> > >               vhost_scsi_free_evt(vs, evt);
> > >       }
> > > +}
> >
> > [ ... ]
> >
> > --
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260912090420.47439-1-physicalmtea@gmail.com?part=1

