Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07483112C1
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035479; cv=none; b=tG+AYd2wpc8bMjuIUOo8b+q+YKn0AbUUBkPKLkZYlQ7S8vx8GDNmVSRswdAvu+A4tB2eAIxqgZWXR/U4WV1A55VpKNhzwv1CU91nthqft+nhutbQmLP9IWYsK1n46z2PT7C8N5yGRK7eEM8dXIALhRSeZOODNhxD2TL1huev1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035479; c=relaxed/simple;
	bh=9l3q0B/E0FjBFxb2LJmMKlw9pl5hcTfSNOB811iBgVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SQAZ0Cw/YQX73ZmCxHaLh9nvmPipGnVLyz2MO4UHNoeHB4Bm7QOcFIng3XAWFydqrTc3R/bxklPDaloGqiiSLMzdPh5IMIDAWnd+OUPExAh7fJTSunmUmVsBHzrzMyWhCbDvkKgkp1XFArsarOGAmGEixOSdQ2fnbTQas3ubdHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCY38rmv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCY38rmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784035475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CpLHRy6/20YstfcDyrkyOratDSzuro/7QBC+7w5m58=;
	b=WCY38rmviGa2bbBEX5YlQWLXF2Fl9FLA5/DapYBxPGvwKdGg6UJaY7lfns7Acj1/icljnU
	7o3Tk1hesyal+0FnKZ6N/zMec4BiTXuRS2HGf5Xx2jcPxNnSXCfY25dFo0zg6PKvyRVzIt
	zUk0A8+320F31s2maTr95haWDsVexpQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-mFhfmAPPPWuP45-BfDD-2A-1; Tue, 14 Jul 2026 09:24:34 -0400
X-MC-Unique: mFhfmAPPPWuP45-BfDD-2A-1
X-Mimecast-MFC-AGG-ID: mFhfmAPPPWuP45-BfDD-2A_1784035473
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49244130073so45155215e9.1
        for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 06:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035473; x=1784640273;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8CpLHRy6/20YstfcDyrkyOratDSzuro/7QBC+7w5m58=;
        b=CiZFRol1G0P0y4pQQPX665/b/nudms+gc9xcfeF6NrdNdpbneELcmk9ddJSQbRdFmr
         PHOrf0KfspH5VUNqtyurXzGVvO8Z0VPz/iEiTh7cetEljrymIsLZrJC8xQXwGrjJtal1
         JS1aws4ShO+X3w70k/siFC5UXpDb/8ZiZ4lKVLQV62sun6FSv97q/JBM9aXNeaz1Bl9Q
         yaNAXcI9Mt80TWyExRNl+9FwzGjqnd7MqRlkBeEIaAqEhlSNFW+ugsTBQnrCjetzSUAR
         28N8eQq0iwqnhwtAEX2mgOCvyZgqQq5lp/RAFtysj7OEXCEbXY29X0yd++FIW9/skyKN
         mCJg==
X-Forwarded-Encrypted: i=1; AHgh+RqiFbFIqxLj+xEmCofkun8ewHnbpxzAALbNym5WeOf3XC95+55NvYTHbKyTosr23/LoG6Zl8JTbHR9nLzGUjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAi5o5a91aO0tN2+un/DhXSBBvVZIudij1FSWibyLUOi8KCSwU
	AnzHpGurMAVRzBvdWWDTogWzbPmsCa96yuL+M9/O9oiZOsD1+cjS7k2qXJiJYCw+Kuea4WP+O4Y
	dA+g4ZjnGgIuhtCESpZqm9foBKlSJFaUXGbsOjJ+cYvSVdqy44bIkRSB6btZC50dKQjkt
X-Gm-Gg: AfdE7cnRXhmWjshDFJvVpF9YuTq4rKQEYWtMGhpNbZLBq6bki39EX1ojyG9OU4JPfaG
	AaD5Zypg5MUl4kV1hYHqssujaIvJGwxXUhIRmIVpydmWPG/TnNzQL4g0AROiSQ8aNydd5ktOGfL
	oVdBdIO+QT0bh/ty1z0DRUHy9POE0kcPy7v6b+aPE60CM4RPrQ2oEFOqE4fhCJeuvwEpsCv72fX
	CZbfbrBwxRn4+fToYMtFNeQFph48m1rxbrmCHmKVVJRBcJpcFDbxXhnSxMz7jpFliWWsOAXjksD
	WDWSrRD9AJ7eUFCFH3wneM+H21ejPANaEQR7Y2pj5XUgxfDCpno7TJX8PT79+p25mrTeGWgnBcv
	hJSMznYu5UpuABMXfD5gIVriSm52ePKUe4mg=
X-Received: by 2002:a05:600c:699a:b0:493:bcba:46a4 with SMTP id 5b1f17b1804b1-495389bcc5bmr25895005e9.20.1784035472835;
        Tue, 14 Jul 2026 06:24:32 -0700 (PDT)
X-Received: by 2002:a05:600c:699a:b0:493:bcba:46a4 with SMTP id 5b1f17b1804b1-495389bcc5bmr25894565e9.20.1784035472269;
        Tue, 14 Jul 2026 06:24:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32b9f3sm86514755e9.13.2026.07.14.06.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:24:31 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:24:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Link Lin <linkl@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, prasin@google.com,
	rientjes@google.com, duenwen@google.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, Ammar Faizi <ammarfaizi2@openresty.com>,
	jiaqiyan@google.com, ahwilkins@google.com,
	Greg Thelen <gthelen@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting
 during PM freeze
Message-ID: <20260714092146-mutt-send-email-mst@kernel.org>
References: <20260709224330.946683-1-linkl@google.com>
 <8d316b6c-41fb-4ae3-8923-3b649b92b33d@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8d316b6c-41fb-4ae3-8923-3b649b92b33d@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D9Mu9WnhzY5sLVYUMCipLW_9hT_MVSZZ8kakJTmPlBw_1784035473
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2026 at 03:17:42PM +0200, David Hildenbrand (Arm) wrote:
> On 7/10/26 00:43, Link Lin wrote:
> > During system power management freeze (e.g. ACPI S3 suspend or S4
> > hibernation), virtballoon_freeze() calls remove_common() to reset the
> > virtio device and delete all virtqueues via vdev->config->del_vqs().
> > However, unlike virtballoon_remove(), virtballoon_freeze() fails to call
> > page_reporting_unregister(&vb->pr_dev_info).
> > 
> > The comment in virtballoon_freeze() states:
> >     /*
> >      * The workqueue is already frozen by the PM core before this
> >      * function is called.
> >      */
> > 
> > While this comment was accurate in 2011 for balloon-internal workqueues
> > (such as balloon_wq, which was created with WQ_FREEZABLE and is paused
> > by the PM freezer), it is invalid for Free Page Reporting.
> > 
> > Free Page Reporting (mm/page_reporting.c) schedules its delayed work
> > (prdev->work) on the global system_wq. Because system_wq lacks the
> > WQ_FREEZABLE flag, the PM freezer (freeze_workqueues_busy()) explicitly
> > skips it. Consequently, page_reporting_process() on system_wq remains
> > active and unfrozen throughout device suspend.
> > 
> > If memory is freed into the buddy allocator or a delayed work timer
> > expires while the device is being frozen, page_reporting_process() fires
> > on system_wq and calls virtballoon_free_page_report(). This function
> > passes vb->reporting_vq into virtqueue_add_inbuf() / virtqueue_add_split().
> > Because the virtqueues were already destroyed by del_vqs(), this results
> > in a Use-After-Free / General Protection Fault:
> > 
> >     [  250.709271] general protection fault, probably for non-canonical address 0x7f728084daf08d5e: 0000 [#1] SMP PTI
> >     [  250.732967] CPU: 2 PID: 38 Comm: kworker/2:1 Not tainted 5.10.0-44-cloud-amd64 #1 Debian 5.10.257-1
> >     [  250.751575] Workqueue: events page_reporting_process
> >     [  250.756665] RIP: 0010:virtqueue_add_split+0x233/0x4c0 [virtio_ring]
> >     ...
> >     [  250.867678] virtballoon_free_page_report+0x3a/0xe0 [virtio_balloon]
> >     [  250.883446] page_reporting_process+0x225/0x4f0
> > 
> > (Note: The OOM Notifier and Shrinker/Free Page Hinting features suffer
> > from an identical lifecycle flaw and are also vulnerable to UAFs during
> > S4 hibernation when memory pressure spikes. This patch focuses on Free
> > Page Reporting, which runs periodically, to ensure clean backports to
> > stable kernels).
> > 
> > Fix this by:
> > 1. Unregistering page reporting in virtballoon_freeze() prior to calling
> >    remove_common(). This clears the RCU pr_dev_info pointer and flushes/
> >    cancels prdev->work on system_wq via cancel_delayed_work_sync().
> > 2. Re-registering page reporting in virtballoon_restore() after the
> >    virtqueues are re-initialized and virtio_device_ready() has been called.
> > 3. Unwinding virtqueue initialization via remove_common() in 
> >    virtballoon_restore() if page_reporting_register() fails.
> > 
> > Fixes: 924a663f75e2 ("virtio-balloon: Reporting free page reservations")
> > Cc: stable@vger.kernel.org
> > Cc: jasowang@redhat.com
> > Cc: xuanzhuo@linux.alibaba.com
> > Cc: Ammar Faizi <ammarfaizi2@openresty.com>
> > Cc: jiaqiyan@google.com
> > Cc: ahwilkins@google.com
> > Cc: Greg Thelen <gthelen@google.com>
> > Cc: Alexander Duyck <alexander.duyck@gmail.com>
> > Signed-off-by: Link Lin <linkl@google.com>
> > ---
> >  drivers/virtio/virtio_balloon.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index a1b2c3d4e5f6..45a90fb3abf8 100640
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -1055,6 +1055,9 @@ static int virtballoon_freeze(struct virtio_device *vdev)
> >  	 * The workqueue is already frozen by the PM core before this
> >  	 * function is called.
> >  	 */
> > +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> > +		page_reporting_unregister(&vb->pr_dev_info);
> > +
> >  	remove_common(vb);
> >  	return 0;
> >  }
> >  
> >  static int virtballoon_restore(struct virtio_device *vdev)
> >  {
> >  	struct virtio_balloon *vb = vdev->priv;
> >  	int ret;
> >  
> >  	ret = init_vqs(vdev->priv);
> >  	if (ret)
> >  		return ret;
> >  
> >  	virtio_device_ready(vdev);
> >  
> > +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> > +		ret = page_reporting_register(&vb->pr_dev_info);
> > +		if (ret)
> > +			goto out_remove_vqs;
> > +	}
> 
> Hm, that failure handling is rather nasty.
> 
> 
> In virtballoon_freeze() we document:
> 
> "The workqueue is already frozen by the PM core before this function is called"
> 
> Your report states:
> 
> "Workqueue: events page_reporting_process"
> 
> 
> I assume that workqueue is not frozen yet because ... it's not freezable :)
> 
> So could we queue to system_freezable_wq instead, or define our own freezable
> workqueue there? Then a driver doesn't have to worry about that.
> 
> -- 
> Cheers,
> 
> David

+1.  Just system_freezable_wq will do the trick.

-- 
MST

