Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16EE32D7FA
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809819; cv=none; b=AFjh7aCW+05hdqwFuuNl36hUipqqjr7h1XaJsctSWcBTeuyYfVYdyj+PpVFWoHPz834JYs4RWW8PnGmpW0zf/LcGwF/E6kZRGSNR7jPG1/u1gEyuLuH5mDAdTT59rhxEcK9PElZoKFZADmRYkgnTdSbnVKgyXfNB5XawbnABmFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809819; c=relaxed/simple;
	bh=PM5LtfPDQIV5du64Y5KIEDXtLlDm2w5SXqmeT7El7/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rYX5zlUtN8PDr680RxuRV/HUu0HnxEVei2dR7oZ6XONIelJmzaeXYyWj2yf/ZnjO+5igRrlMPaaYkMvg8GvrquJ1BlDIU1tvnzVwPlVumD5fd49CcnKOhQ8rTDh8tHXTNZELegOhZODHuxUZqMkMkKOc4KVzFlq9rym/tUn/jUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ex1vqClb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ex1vqClb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776809815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yz5OSV1oyDXAa95VEwciW/htVdkVZSZuJpRkIi1eALw=;
	b=ex1vqClb9eZxRjpvQzR8fneZd+Wq62nqoqLmGgTqeki+pmGEu7Q/x33HPlhpnftPQIdXLz
	jFvFclXNFlkU3nDAwI2FM2TQYnD/obcMqG4YliDpo7kqDEABDcwLL+4fkhbnybTey7qpBK
	A6tQrxhW1B3ihsYB8fZOqkrBjWdoyb8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-gljyjrbyMC2U4rZtvR6pYQ-1; Tue, 21 Apr 2026 18:16:54 -0400
X-MC-Unique: gljyjrbyMC2U4rZtvR6pYQ-1
X-Mimecast-MFC-AGG-ID: gljyjrbyMC2U4rZtvR6pYQ_1776809813
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a55d82e0eso7886575e9.1
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809813; x=1777414613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yz5OSV1oyDXAa95VEwciW/htVdkVZSZuJpRkIi1eALw=;
        b=Zr2fo38rzAd/8OScVUQj6Bip0jC00/jq5u/hnbk7yUwHlklN4UeXPwVLWNZgY8DNp8
         LLbciI7tsgc9qmIvSXKCmYHjBo7GghnJlQXln9Mc4m1eJWDWyE2mGwxC/J4ANyAWzpSQ
         Rhati4hWBgJ9Sf1nf9M95Ons1nX5YcJP0PjkFccx0S0+Kt6l8vs8R4W8lnKTMyrXgEBj
         gnFWdY1VPswWuQjiQ/EgpCfwvfaCqIlRJ8+lVYkTIII96QoZyX4gYud8IQu26eB2rmu+
         X+YVOhUqEvRW+qQYRIVpuRTC7Bgx4gRf/LvxMPYVhCiaBiZ0sB5MbohhzH9FsUHdXhoq
         1muw==
X-Forwarded-Encrypted: i=1; AFNElJ8PbqBtrTITpSUyxFTto+o6G/dR65AztuHR30PhE8KprH5XGVpwuZN84bHVDOgSH3Ouipnh8lxbR8SYlIorgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzL3KGPJ0INsFYFNmnVfDS+yT3mdmT0QHyDDNclekHX+BI8svWT
	8NPJvZv+xrg7sZYyHL14hT6TJZ+urBDw+q2bXy7qjW9HhX67awjDkG0zQ9eu1O7enSqQwvBoaOr
	ybRxojr3vlgqlBtXJCbciZM9zfB54ihFZDm9j9BWpmEW7zxtDGMAwzLXTVTYzbqwacJjB
X-Gm-Gg: AeBDiesuTFC+7cGlv6AxBGvEDa6QzAaMic9yDbpUNLEmsOloZvw/qhGU5NzCE6eVCW0
	m2+ykW9qs3enaD9Q/n7ZhFmWsLHNUwrZoTZhpmUk2Em4Y/V4tU+Jh/q2i3OxeijOPDBr5RiDbzW
	0UOdgB2HgVQf4GCr8rhwlQEFQu8oS6TIjDf7ZvtXfZvFnUvVCWFWc2NaycHrMPe3G0vn4t5ALfm
	fm5kJLc/yHU+IJTEQjDIKLVakPRz8xlY6PGJqKhykqnI8gAHejFv1DSnM7xoSXYrbjFHlfZ2Pk+
	dmfCW28S1GgVFuQJuHy3o1cDlGWAfXZPWJ1GdVbkLKhNh7iHb2JpvFtRz3gaGleQGtveajhB/fd
	OlaSB40sSAr0dEdNQbpvFiLB7W1iKrPe18cpbjHueq5olasM+g/hY9w==
X-Received: by 2002:a05:600c:8586:b0:489:e49:f766 with SMTP id 5b1f17b1804b1-4890e49f7d8mr120973865e9.17.1776809812995;
        Tue, 21 Apr 2026 15:16:52 -0700 (PDT)
X-Received: by 2002:a05:600c:8586:b0:489:e49:f766 with SMTP id 5b1f17b1804b1-4890e49f7d8mr120973715e9.17.1776809812521;
        Tue, 21 Apr 2026 15:16:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb755938sm167530455e9.3.2026.04.21.15.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:16:51 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:16:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Link Lin <linkl@google.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	jiaqiyan@google.com, rientjes@google.com, weixugc@google.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	ammarfaizi2@openresty.com
Subject: Re: [RFC PATCH v1] virtio_pci: only store successfully populated
 virtio_pci_vq_info
Message-ID: <20260421181640-mutt-send-email-mst@kernel.org>
References: <20260407212521.934620-1-linkl@google.com>
 <CALUx4KQKNYZm5AZzQXNqLRdGAT0nQOpmn_Lz6WHie73w1d9JQA@mail.gmail.com>
 <CALUx4KTPcRCGvyvJfHSU_t61UJOuTBaAGxJ6nhUuaghE0_ZfUg@mail.gmail.com>
 <20260421175107-mutt-send-email-mst@kernel.org>
 <CALUx4KRuJcW+ea7wrupQAd_cFJvzRxcrYq93DTYMDyB2vkf96Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CALUx4KRuJcW+ea7wrupQAd_cFJvzRxcrYq93DTYMDyB2vkf96Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Lny6ZtskZ_eudnjNQlSZbwt5Mxu5U_iZmsLSvmCRrI_1776809813
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 21, 2026 at 03:15:55PM -0700, Link Lin wrote:
> Hi Michael,
> 
> That's essentially the same fix as ours but one month earlier. That's
> great news!
> 
> Quick follow-up question: Do you know if this will make it into v7.1?


I'll try.

> I also noticed the patch has the "Cc: stable@vger.kernel.org # v6.11+"
> tag, which is perfect since we actually hit this bug in v6.12.
> 
> I wasn't aware of Ammar's patch as I wasn't subscribed to the mailing
> list. Looks like we tried to reinvent the wheel ^_^;
> 
> Sincerely,
> Link
> 
> 
> On Tue, Apr 21, 2026 at 2:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 21, 2026 at 02:47:32PM -0700, Link Lin wrote:
> > > Hi everyone,
> > >
> > > Friendly ping. Apologies if you are getting this the second time - my
> > > last ping wasn't in plain text mode and got rejected by some mailing
> > > lists.
> > >
> > > Please let me know if anyone has had a chance to look at this RFC
> > > patch, or if any changes are needed.
> > >
> > > Thanks,
> > > Link
> > >
> > > On Tue, Apr 21, 2026 at 2:24 PM Link Lin <linkl@google.com> wrote:
> > > >
> > > > Hi everyone,
> > > >
> > > > Friendly ping on this RFC patch. Please let me know if anyone has had a chance to look at this, or if any changes are needed.
> > > >
> > > > Thanks,
> > > > Link
> > > >
> > > > On Tue, Apr 7, 2026 at 2:25 PM Link Lin <linkl@google.com> wrote:
> > > >>
> > > >> In environments where free page reporting is disabled, a kernel
> > > >> panic is triggered when tearing down the virtio_balloon module:
> > > >>
> > > >>   [12261.808190] Call trace:
> > > >>   [12261.808471]  __list_del_entry_valid_or_report+0x18/0xe0
> > > >>   [12261.809064]  vp_del_vqs+0x12c/0x270
> > > >>   [12261.809462]  remove_common+0x80/0x98 [virtio_balloon]
> > > >>   [12261.810034]  virtballoon_remove+0xfc/0x158 [virtio_balloon]
> > > >>   [12261.810663]  virtio_dev_remove+0x68/0xf8
> > > >>   [12261.811108]  device_release_driver_internal+0x17c/0x278
> > > >>   [12261.811701]  driver_detach+0xd4/0x138
> > > >>   [12261.812117]  bus_remove_driver+0x90/0xd0
> > > >>   [12261.812562]  driver_unregister+0x40/0x70
> > > >>   [12261.813006]  unregister_virtio_driver+0x20/0x38
> > > >>   [12261.813518]  cleanup_module+0x20/0x7a8 [virtio_balloon]
> > > >>   [12261.814109]  __arm64_sys_delete_module+0x278/0x3d0
> > > >>   [12261.814654]  invoke_syscall+0x5c/0x120
> > > >>   [12261.815086]  el0_svc_common+0x90/0xf8
> > > >>   [12261.815506]  do_el0_svc+0x2c/0x48
> > > >>   [12261.815883]  el0_svc+0x3c/0xa8
> > > >>   [12261.816235]  el0t_64_sync_handler+0x8c/0x108
> > > >>   [12261.816724]  el0t_64_sync+0x198/0x1a0
> > > >>
> > > >> The issue originates in vp_find_vqs_intx(). It kzalloc_objs() based
> > > >> on the nvqs count provided by the caller, virtio_balloon::init_vqs().
> > > >> However, it is not always the case that all nvqs number of
> > > >> virtio_pci_vq_info objects will be properly populated.
> > > >>
> > > >> For example, when VIRTIO_BALLOON_F_FREE_PAGE_HINT is absent, the
> > > >> VIRTIO_BALLOON_VQ_FREE_PAGE-th item in the vp_dev->vqs array is
> > > >> actually never populated, and is still a zeroe-initialized
> > > >> virtio_pci_vq_info object, which is eventually going to trigger
> > > >> a __list_del_entry_valid_or_report() crash.
> > > >>
> > > >> Tested by applying this patch to a guest VM kernel with the
> > > >> VIRTIO_BALLOON_F_REPORTING feature enabled and the
> > > >> VIRTIO_BALLOON_F_FREE_PAGE_HINT feature disabled.
> > > >> Without this patch, unloading the virtio_balloon module triggers a panic.
> > > >> With this patch, no panic is observed.
> > > >>
> > > >> The fix is to use queue_idx to handle the case that vp_find_vqs_intx()
> > > >> skips vp_setup_vq() when caller provided null vqs_info[i].name, when
> > > >> the caller doesn't populate all nvqs number of virtqueue_info objects.
> > > >> Invariantly queue_idx is the correct index to store a successfully
> > > >> created and populated virtio_pci_vq_info object. As a result, now
> > > >> a virtio_pci_device object only stores queue_idx number of valid
> > > >> virtio_pci_vq_info objects in its vqs array when the for-loop over
> > > >> nvqs finishes (of course, without goto out_del_vqs).
> > > >>
> > > >> vp_find_vqs_msix() has similar issue, so fix it in the same way.
> > > >>
> > > >> This patch is marked as RFC because we are uncertain if any virtio-pci
> > > >> code implicitly requires virtio_pci_device's vqs array to always
> > > >> contain nvqs number of virtio_pci_vq_info objects, and to store
> > > >> zero-initialized virtio_pci_vq_info objects. We have not observed
> > > >> any issues in our testing, but insights or alternatives are welcome!
> > > >>
> > > >> Signed-off-by: Link Lin <linkl@google.com>
> > > >> Co-developed-by: Jiaqi Yan <jiaqiyan@google.com>
> > > >> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > > >> ---
> > > >>  drivers/virtio/virtio_pci_common.c | 10 ++++++----
> > > >>  1 file changed, 6 insertions(+), 4 deletions(-)
> > > >>
> > > >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > >> index da97b6a988de..9b32301529e5 100644
> > > >> --- a/drivers/virtio/virtio_pci_common.c
> > > >> +++ b/drivers/virtio/virtio_pci_common.c
> > > >> @@ -423,14 +423,15 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> > > >>                         vqs[i] = NULL;
> > > >>                         continue;
> > > >>                 }
> > > >> -               vqs[i] = vp_find_one_vq_msix(vdev, queue_idx++, vqi->callback,
> > > >> +               vqs[i] = vp_find_one_vq_msix(vdev, queue_idx, vqi->callback,
> > > >>                                              vqi->name, vqi->ctx, false,
> > > >>                                              &allocated_vectors, vector_policy,
> > > >> -                                            &vp_dev->vqs[i]);
> > > >> +                                            &vp_dev->vqs[queue_idx]);
> > > >>                 if (IS_ERR(vqs[i])) {
> > > >>                         err = PTR_ERR(vqs[i]);
> > > >>                         goto error_find;
> > > >>                 }
> > > >> +               ++queue_idx;
> > > >>         }
> > > >>
> > > >>         if (!avq_num)
> > > >> @@ -485,13 +486,14 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
> > > >>                         vqs[i] = NULL;
> > > >>                         continue;
> > > >>                 }
> > > >> -               vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
> > > >> +               vqs[i] = vp_setup_vq(vdev, queue_idx, vqi->callback,
> > > >>                                      vqi->name, vqi->ctx,
> > > >> -                                    VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[i]);
> > > >> +                                    VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[queue_idx]);
> > > >>                 if (IS_ERR(vqs[i])) {
> > > >>                         err = PTR_ERR(vqs[i]);
> > > >>                         goto out_del_vqs;
> > > >>                 }
> > > >> +               ++queue_idx;
> > > >>         }
> > > >>
> > > >>         if (!avq_num)
> > > >> --
> > > >> 2.53.0.1213.gd9a14994de-goog
> >
> >
> > I have this in my tree:
> >
> > https://lore.kernel.org/all/20260315141808.547081-1-ammarfaizi2@openresty.com/
> >
> >
> > same?
> >
> >

