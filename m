Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632D835AC3C
	for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971807; cv=none; b=qFBdC8lw3VmCv/OU2uais/8y7cs9XyGfzBpnA22ZG3bKM3qJyjh2x8PEkqAwLGcTIJxbQLhi1dlW69to2fgP7+vqR6Jf1p8aJNAaP46bniTuxkXJv5olNrDY252dstHz0S4AUMOeGIgCMNtc57j5SnkY45hYG9hO1Uc8Yt5c9fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971807; c=relaxed/simple;
	bh=+D5yjWN6rVMXpGyTufspKcyF6W9cMssILiwjIivzAPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uXoOQcuqa/76TN3ZnAC+/WhppygBz59ubN7z9ZfjQWmuE/htHwpUaRT/UnrTtYqlIBCcWVS8RQY8C+wRA3jbjjtRIZBRf9CQClG7j8VXny90Uze3dIBZhibB7z5IjUVZ4chaI5G0DnyOwRv5b+QLad2p4wziMiWKasnc5zoFTeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBDIKZHa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBDIKZHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783971804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oh/99NzF4tGS13cUL+eRJ8P8DrHZhD3bwsodlnkuIoc=;
	b=aBDIKZHalXNWNIhdnnQfIgIyO1jRKG8xv+eESO+WctxpnLo8Hydv0enVwOmE3BsJ2OJoIo
	WF+PxwTHzEvuk611pV7FY+T42LibMzt+1s8lsz2lBHilpOjOGOxA/L0rwzDNHuBO+FdN3L
	VKw9nzmVChNNvNLKTdQBUbwUP2On9XU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-qt2Wa12aNn-x4XQRQW-SvA-1; Mon, 13 Jul 2026 15:43:23 -0400
X-MC-Unique: qt2Wa12aNn-x4XQRQW-SvA-1
X-Mimecast-MFC-AGG-ID: qt2Wa12aNn-x4XQRQW-SvA_1783971802
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-472a798fc7cso116295f8f.1
        for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 12:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971802; x=1784576602;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oh/99NzF4tGS13cUL+eRJ8P8DrHZhD3bwsodlnkuIoc=;
        b=h1/RyGCw4UOdbKn2ADF32f2HPrhXK/s9lq5yz0yhu6EVLpwpjSF64VNoVm07nC/XA9
         Znz1bPpsmonZZeS/FqMCtSR34iC4sE35HdRvd6IyWDZEdCsde4jsLbx0e1hwL/UVEnih
         bmTM0YjhjQJFIhrrzkI12QEEyTrmWEfyHDoSvY4xr1BEaTbC0RtloD31YK7hL2SxttAP
         Vo7oSgIN8Ej4krGM0A6w98SAhkI4ETFOJSA07tFwQYkx1cfjJoCp0HHpoE2ZF8FsM11b
         ahUdyal2oHwWysJJmJa2OBZUGmDMS1Ia9BPx5hy+CaYELeXQQUbE2IzRS1X7kPAYJG/b
         5hPQ==
X-Forwarded-Encrypted: i=1; AHgh+RodJKF3pmYwFLdFRymYKUW7PXahqbMfPYu4BYDDwjha6NWustwUuxPc0+3Jlj4UA7OvLulTWbnNdRmzPeZOQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIsZlIXaENuLAnjMtmtUevGKHRdqdf5QvijUOdDLRJMp+bdHPb
	xxtlhsOPw7pIpxKbzNTo5bUIB/1KAfQNOLJoiN5cvtXZ5i25djL37p+8t/yaFzi7F1AAqYjKNmH
	VCqKPyGnekm0r0K0kQnG+gUVWx5xsqfTfzsO/hcjPdew7c/qerHlEpX6sIOC6x6F4Hj3V
X-Gm-Gg: AfdE7cmMNp5pMwOi+l1JPcSBYZVQGnlTXZs9dimAhFC+bvIbMYU0BWGx+T/MMMJdau0
	e1aB9/T9btqbXuvBho9uYyzS0xfrSI0Nsi+vBFr1JBI3VxKjQ9OdV6z6Wv+Rp1ukz5pLsEQKt2+
	s2UWKagxo2xvJCOgbTE3iVO7ozlF149yCMk9dCiwej/K6QK4zwdpcLYZbjIqi0Uk3w25I0XQaQ3
	03eggoQo00hD/oktlNG4YE/eydAeuByAiAuhUNFAJRRh9NgGUHAD1GpvgCzZQejLBidOwkxoctN
	A9PekryYnQXLm4vZr46+V8wpjBxmO+erK6R3b/WAg54GXuXHFvHIO+6K5vF+uPT1YX4/8hMc4YX
	v08+GNIh9dTLWIQdwl4RBdgqxKuG3O3CwjIQ=
X-Received: by 2002:a05:6000:1841:b0:473:823:1924 with SMTP id ffacd0b85a97d-47f2dcd7860mr13165056f8f.39.1783971801737;
        Mon, 13 Jul 2026 12:43:21 -0700 (PDT)
X-Received: by 2002:a05:6000:1841:b0:473:823:1924 with SMTP id ffacd0b85a97d-47f2dcd7860mr13165028f8f.39.1783971801248;
        Mon, 13 Jul 2026 12:43:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e0e4sm1936476f8f.4.2026.07.13.12.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:43:20 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:43:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Rientjes <rientjes@google.com>
Cc: Link Lin <linkl@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, prasin@google.com, duenwen@google.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com,
	ahwilkins@google.com, Greg Thelen <gthelen@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting
 during PM freeze
Message-ID: <20260713154243-mutt-send-email-mst@kernel.org>
References: <20260709224330.946683-1-linkl@google.com>
 <20260709161253.6b5e9ba349f70a3ebfb8180f@linux-foundation.org>
 <CALUx4KQ=bYTpDoDAZ+iVb7Ehaa0LmyPDsEWk3xFFmTVYKrpAUA@mail.gmail.com>
 <59e3dae7-a203-2e1d-3b65-875b7e0e122b@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <59e3dae7-a203-2e1d-3b65-875b7e0e122b@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2Hq0KuMTm7XzAFuG8chDx5jTpACJ4h5Zb9DFGsrlRUk_1783971802
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 13, 2026 at 12:41:07PM -0700, David Rientjes wrote:
> On Thu, 9 Jul 2026, Link Lin wrote:
> 
> > > > Fix this by:
> > > > 1. Unregistering page reporting in virtballoon_freeze() prior to calling
> > > >    remove_common(). This clears the RCU pr_dev_info pointer and flushes/
> > > >    cancels prdev->work on system_wq via cancel_delayed_work_sync().
> > > > 2. Re-registering page reporting in virtballoon_restore() after the
> > > >    virtqueues are re-initialized and virtio_device_ready() has been called.
> > > > 3. Unwinding virtqueue initialization via remove_common() in
> > > >    virtballoon_restore() if page_reporting_register() fails.
> > >
> > > AI review thinks the patch didn't do the above:
> > >         https://sashiko.dev/#/patchset/20260709224330.946683-1-linkl@google.com
> > 
> > The AI reviewer might not have parsed the entirety of the fix I proposed.
> > The patch submitted definitely includes the changes to virtballoon_restore()
> > for steps 2 and 3 (re-registering page reporting and unwinding init_vqs
> > on failure). It seems the AI failed to parse the diff correctly. See:
> > 
> > +       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> > +               ret = page_reporting_register(&vb->pr_dev_info);
> > +               if (ret)
> > +                       goto out_remove_vqs;
> > +       }
> > +
> >         if (towards_target(vb))
> >                 virtballoon_changed(vdev);
> >         update_balloon_size(vb);
> >         return 0;
> > +
> > +out_remove_vqs:
> > +       remove_common(vb);
> > +       return ret;
> >  }
> > 
> > > It also might have found a couple of pre-existing bugs in there.
> > 
> > Indeed. Regarding the first pre-existing bug found by the AI (leaving the
> > OOM notifier registered during suspend, leading to a UAF if memory pressure
> > spikes during S4 hibernation):
> > 
> > I actually addressed this in the commit message:
> > 
> >   "(Note: The OOM Notifier and Shrinker/Free Page Hinting features suffer
> >   from an identical lifecycle flaw and are also vulnerable to UAFs during
> >   S4 hibernation when memory pressure spikes. This patch focuses on Free
> >   Page Reporting, which runs periodically, to ensure clean backports to
> >   stable kernels)."
> > 
> > Regarding the second pre-existing bug the AI flagged (leaving uncancelled
> > works on system_freezable_wq if virtballoon_restore fails on the cold path):
> > the AI is correct that this asynchronous work cancellation failure exists.
> > 
> > Since these are separate, pre-existing lifecycle bugs, would you prefer I
> > roll fixes for the OOM notifier, shrinker/free page hinting, and work
> > cancellations into a v2 of this patch, or submit them as a separate patch
> > series to keep the stable backports clean?
> > 
> 
> I think it would be best to have separate patches for each fix; Andrew, 
> please correct me if you'd prefer one patch to address everything.

It does not matter much but yes separate ones are a bit better if
each can be applied independently.

