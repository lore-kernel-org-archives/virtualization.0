Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5672D23B9
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808281; cv=none; b=OyT+idukGHdOnb4thw1MGjfhjPQg1GzT93jdc71DeY/D4nAcTzy3NvFKaE2L15g45dNl9ktw5agr0dLd7/moGrSdK7rCJgeSWeEfNhnEsRlyIOwXwiGmerO0COIikt6H4S8xEPyA3l8Cd/lAKE2uj6Lc+KDcbKa1SOVSCWTaDyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808281; c=relaxed/simple;
	bh=1MIPip+yQMdd9dzHaWdM/5MQk5tbrZlixR0nsnbZHMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iO8c+U0AuCY93w72Yuo53bSOkGNIdVIj4czu1J2aUibzRweO/xm68rvWzSHMxPSJMRJKXgE489CDDqoxB+k6G/ND3VI15QvtfXIuICseDftsXrloIgXb8TLLJtyxtTgMOGS8v0ziNbWHmKYBloTq3RvqaYpGm6gjTP29zl1RluM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WA4G4skY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WA4G4skY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/gUxpnKz7TzQvpX+9xGm5OwVsh44kQ/7AgwlJT0pOA=;
	b=WA4G4skYjwZyyqXw4C3+spsNbX2JaDjCfz6jJ1SG57mJovLJB+/tUXVwXjvSJUdRnlBG42
	0lPqwb7iPqX9ZOHLcrexXrs7Sq7Mj4IuWcu7y4q2eEwQtJ6T3AFSDsSGbsVPLryKMeDJN1
	yOLFl+ChABHTF0gG7CQgVkF0kHBVBQI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-jDWkesmsMHGSwBb6w8sTtw-1; Tue, 21 Apr 2026 17:51:17 -0400
X-MC-Unique: jDWkesmsMHGSwBb6w8sTtw-1
X-Mimecast-MFC-AGG-ID: jDWkesmsMHGSwBb6w8sTtw_1776808276
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso22830575e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 14:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808276; x=1777413076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/gUxpnKz7TzQvpX+9xGm5OwVsh44kQ/7AgwlJT0pOA=;
        b=XjZaEAFXp8/y4UPqCe8vgSF0oRcBhOuS4dq/bb6kYU6F6TfbbVttskalwI5nfHn7iq
         htNyACRNUQN9IkbOO8lz5Uzn0fueLgmIDxXp2tDfkVN9gWJxfQbtqJ/RUyO0GtjMypn+
         uc7n+5L31uTdWB+WdxB7dLmUzEUY9AFLS4/22DUgXFES5r7WayRYXt95R2vUjMcUGI6E
         7mDD0eYSsU7PDa42Ylx4jxYiGPfnpzNr2U9mm7DknCzuypgeinXHjUT/Yl0W/2Hg5pYD
         QYuS6uwG9muWf6fxMcxXgs9rLoUtvTi0VXe+sTo+Z4qpCxMxJFaoxc2LbHIafGELbXid
         ZdPA==
X-Forwarded-Encrypted: i=1; AFNElJ/VqBKEygMMAmsGBnAuaNwtRUKOq0Be2L1jC4553YTtnDhDWdjYW5C1y2kmQBlykYGBV46TWoUHnDNt+Jj2KQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgPHpyfywOKkIzEKKynBSjw/dE61HQRd2yZzCrEE1VGhWBw9MV
	K2H5O9i3Mv0Te5pwbpS7NNTZ3VKD7J2rDD+XMJxCn4pfgHmVjwVpD9B637MgBr1frKeDMNpOhAR
	biAfDosk1Z+n5MmzdJgF0ssFWQUtZ8oOyS8B1Si4B9LRBGWgg5GvWBtulqWypz301888g
X-Gm-Gg: AeBDietVqEYNbukdt9fRqS/i6//xPf7xPQgdoQcoWAltD8VbHZWSMCZBxha9dMEbpXv
	3G+99IaTTS82LQjD6y1hOPG7KrDoMqHBH7D2ukgnS4tnb1ila5u8/lopDRLxtHlURKqgjWeqJjS
	LhQAY4btw1HjGdqYqwfeYyOX0xOgX+iNnzQkH1mU26ja4p/lDBipYiUrNDyhWnjR3iMAFztegJW
	C8LVmFEzZbV1S8iGY8UQor12DwId9ebDBENVVWScHrSKx5yhheppvRJrtdSusdzM4fZV7udRnYc
	RN5MWe3Ti+llTiWbRJlqKVTvGjUqwL7UANxb2Nw+NC8NMNhfO8f/hqb4dZypovadBWcfg+DpcNL
	J5hd15y3dCpRmd4+HWWcfELn3H7FoanFmdwvlITY2HNeJI3GnWXfT+w==
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-488fb8859ddmr264457495e9.2.1776808276346;
        Tue, 21 Apr 2026 14:51:16 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-488fb8859ddmr264457135e9.2.1776808275838;
        Tue, 21 Apr 2026 14:51:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a525a0b1asm63989145e9.2.2026.04.21.14.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 14:51:15 -0700 (PDT)
Date: Tue, 21 Apr 2026 17:51:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Link Lin <linkl@google.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	jiaqiyan@google.com, rientjes@google.com, weixugc@google.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] virtio_pci: only store successfully populated
 virtio_pci_vq_info
Message-ID: <20260421175107-mutt-send-email-mst@kernel.org>
References: <20260407212521.934620-1-linkl@google.com>
 <CALUx4KQKNYZm5AZzQXNqLRdGAT0nQOpmn_Lz6WHie73w1d9JQA@mail.gmail.com>
 <CALUx4KTPcRCGvyvJfHSU_t61UJOuTBaAGxJ6nhUuaghE0_ZfUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CALUx4KTPcRCGvyvJfHSU_t61UJOuTBaAGxJ6nhUuaghE0_ZfUg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cRpB5uSci2cNvyLK-kQRZYuP_G4Y4sAZiTHZ6z_-CeQ_1776808276
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 21, 2026 at 02:47:32PM -0700, Link Lin wrote:
> Hi everyone,
> 
> Friendly ping. Apologies if you are getting this the second time - my
> last ping wasn't in plain text mode and got rejected by some mailing
> lists.
> 
> Please let me know if anyone has had a chance to look at this RFC
> patch, or if any changes are needed.
> 
> Thanks,
> Link
> 
> On Tue, Apr 21, 2026 at 2:24 PM Link Lin <linkl@google.com> wrote:
> >
> > Hi everyone,
> >
> > Friendly ping on this RFC patch. Please let me know if anyone has had a chance to look at this, or if any changes are needed.
> >
> > Thanks,
> > Link
> >
> > On Tue, Apr 7, 2026 at 2:25 PM Link Lin <linkl@google.com> wrote:
> >>
> >> In environments where free page reporting is disabled, a kernel
> >> panic is triggered when tearing down the virtio_balloon module:
> >>
> >>   [12261.808190] Call trace:
> >>   [12261.808471]  __list_del_entry_valid_or_report+0x18/0xe0
> >>   [12261.809064]  vp_del_vqs+0x12c/0x270
> >>   [12261.809462]  remove_common+0x80/0x98 [virtio_balloon]
> >>   [12261.810034]  virtballoon_remove+0xfc/0x158 [virtio_balloon]
> >>   [12261.810663]  virtio_dev_remove+0x68/0xf8
> >>   [12261.811108]  device_release_driver_internal+0x17c/0x278
> >>   [12261.811701]  driver_detach+0xd4/0x138
> >>   [12261.812117]  bus_remove_driver+0x90/0xd0
> >>   [12261.812562]  driver_unregister+0x40/0x70
> >>   [12261.813006]  unregister_virtio_driver+0x20/0x38
> >>   [12261.813518]  cleanup_module+0x20/0x7a8 [virtio_balloon]
> >>   [12261.814109]  __arm64_sys_delete_module+0x278/0x3d0
> >>   [12261.814654]  invoke_syscall+0x5c/0x120
> >>   [12261.815086]  el0_svc_common+0x90/0xf8
> >>   [12261.815506]  do_el0_svc+0x2c/0x48
> >>   [12261.815883]  el0_svc+0x3c/0xa8
> >>   [12261.816235]  el0t_64_sync_handler+0x8c/0x108
> >>   [12261.816724]  el0t_64_sync+0x198/0x1a0
> >>
> >> The issue originates in vp_find_vqs_intx(). It kzalloc_objs() based
> >> on the nvqs count provided by the caller, virtio_balloon::init_vqs().
> >> However, it is not always the case that all nvqs number of
> >> virtio_pci_vq_info objects will be properly populated.
> >>
> >> For example, when VIRTIO_BALLOON_F_FREE_PAGE_HINT is absent, the
> >> VIRTIO_BALLOON_VQ_FREE_PAGE-th item in the vp_dev->vqs array is
> >> actually never populated, and is still a zeroe-initialized
> >> virtio_pci_vq_info object, which is eventually going to trigger
> >> a __list_del_entry_valid_or_report() crash.
> >>
> >> Tested by applying this patch to a guest VM kernel with the
> >> VIRTIO_BALLOON_F_REPORTING feature enabled and the
> >> VIRTIO_BALLOON_F_FREE_PAGE_HINT feature disabled.
> >> Without this patch, unloading the virtio_balloon module triggers a panic.
> >> With this patch, no panic is observed.
> >>
> >> The fix is to use queue_idx to handle the case that vp_find_vqs_intx()
> >> skips vp_setup_vq() when caller provided null vqs_info[i].name, when
> >> the caller doesn't populate all nvqs number of virtqueue_info objects.
> >> Invariantly queue_idx is the correct index to store a successfully
> >> created and populated virtio_pci_vq_info object. As a result, now
> >> a virtio_pci_device object only stores queue_idx number of valid
> >> virtio_pci_vq_info objects in its vqs array when the for-loop over
> >> nvqs finishes (of course, without goto out_del_vqs).
> >>
> >> vp_find_vqs_msix() has similar issue, so fix it in the same way.
> >>
> >> This patch is marked as RFC because we are uncertain if any virtio-pci
> >> code implicitly requires virtio_pci_device's vqs array to always
> >> contain nvqs number of virtio_pci_vq_info objects, and to store
> >> zero-initialized virtio_pci_vq_info objects. We have not observed
> >> any issues in our testing, but insights or alternatives are welcome!
> >>
> >> Signed-off-by: Link Lin <linkl@google.com>
> >> Co-developed-by: Jiaqi Yan <jiaqiyan@google.com>
> >> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> >> ---
> >>  drivers/virtio/virtio_pci_common.c | 10 ++++++----
> >>  1 file changed, 6 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> >> index da97b6a988de..9b32301529e5 100644
> >> --- a/drivers/virtio/virtio_pci_common.c
> >> +++ b/drivers/virtio/virtio_pci_common.c
> >> @@ -423,14 +423,15 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> >>                         vqs[i] = NULL;
> >>                         continue;
> >>                 }
> >> -               vqs[i] = vp_find_one_vq_msix(vdev, queue_idx++, vqi->callback,
> >> +               vqs[i] = vp_find_one_vq_msix(vdev, queue_idx, vqi->callback,
> >>                                              vqi->name, vqi->ctx, false,
> >>                                              &allocated_vectors, vector_policy,
> >> -                                            &vp_dev->vqs[i]);
> >> +                                            &vp_dev->vqs[queue_idx]);
> >>                 if (IS_ERR(vqs[i])) {
> >>                         err = PTR_ERR(vqs[i]);
> >>                         goto error_find;
> >>                 }
> >> +               ++queue_idx;
> >>         }
> >>
> >>         if (!avq_num)
> >> @@ -485,13 +486,14 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
> >>                         vqs[i] = NULL;
> >>                         continue;
> >>                 }
> >> -               vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
> >> +               vqs[i] = vp_setup_vq(vdev, queue_idx, vqi->callback,
> >>                                      vqi->name, vqi->ctx,
> >> -                                    VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[i]);
> >> +                                    VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[queue_idx]);
> >>                 if (IS_ERR(vqs[i])) {
> >>                         err = PTR_ERR(vqs[i]);
> >>                         goto out_del_vqs;
> >>                 }
> >> +               ++queue_idx;
> >>         }
> >>
> >>         if (!avq_num)
> >> --
> >> 2.53.0.1213.gd9a14994de-goog


I have this in my tree:

https://lore.kernel.org/all/20260315141808.547081-1-ammarfaizi2@openresty.com/


same?


