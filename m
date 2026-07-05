Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D97318146
	for <virtualization@lists.linux.dev>; Sun,  5 Jul 2026 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783240489; cv=none; b=Er2Tow/OYCUWELFBfxtQ6BSeSjWTDj0JUWnyvbl/aq71n3gNtGIVrOqk2AfCHJWek6vPsl7LqOmfFnKwMmdOkyXTqeqZZdhzFcaA4Tcbitqq75QyqtMQUwZ58hVx6Cu7yv5adNlZyqgKoA0XUglr6fBJKymmnO1EQp3YC4uuhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783240489; c=relaxed/simple;
	bh=aGklt9XfhyATNt2V3YXMXkU651KsIQi+Pol1FGyc7ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Q/DbMH35dWazVkLAxW4E7kLMYHjiwqA3/UKHNB6bCZqpBEExWePxd8560PYCoYxlF68T51QNYDB1m7vW85MXzNJB3r5388Tr3gpt0gYJlNZQC/Gsf5YiLjH60jmkrg4uYgk0t1kBkwQGOsVNyJ18ElSMW29oW4HG9K/JifjA7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UM9x/Rw1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UM9x/Rw1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783240486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hpyyGnCmoaU77sn+Ro68vpJQoBqTCnGGK+pBiKnHXwc=;
	b=UM9x/Rw1EsHhyasN/XqBqCW85BrjqV6ewTXJCgG1UHHhyAUGPmjiPJt2CpNsKmimOHM8jp
	5u6qdMlf9dxRzzPFh1qWGl/SaTDSQJjyoroCHgIraL7g/ADhA+JRK5TP2gibdis/dIfCrS
	dNKKDigkoOctOQDyHc1c8wrwc4nA+VY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-AynoCubzOtCzw3KOezUlBw-1; Sun, 05 Jul 2026 04:34:45 -0400
X-MC-Unique: AynoCubzOtCzw3KOezUlBw-1
X-Mimecast-MFC-AGG-ID: AynoCubzOtCzw3KOezUlBw_1783240484
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493bb6a4336so16591335e9.3
        for <virtualization@lists.linux.dev>; Sun, 05 Jul 2026 01:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783240484; x=1783845284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpyyGnCmoaU77sn+Ro68vpJQoBqTCnGGK+pBiKnHXwc=;
        b=c/+fNvzg+zX2oyfesCOtLQ2k9weaKceI/aPlu85yoNeibMwAg9avJ2O+nFvJ055CRn
         MXOFcmEZSYF/2cxyPwrwf5i887i9/qCXda528shtd4rR9NcqmTaAxPHQcQ2/1R54T7qz
         n3mjxUEeHcVFGfOHNeDkeh2FbuAeJFMownGSCwHZeM7CXW9LHdDdRMGuOhxLnBli7U9B
         IVHBlmHxAtcFd+mETC1KYk/70JY41c7zEWlHxcLQBQlxlvHkxCzjFzY11rdIE9B+uwEq
         u2Dz7s3Ghnw/SOyOTjgryNbRqrv5PWZRyMHtk8HxHUt/cW9kEzc2YdaX5ylOst7h8xFX
         yyJw==
X-Forwarded-Encrypted: i=1; AFNElJ/x5q8iT1PHljAWKHhcyClIq157ZXOi2zmtwX5gC2+IkldRx/x7tqJcJnuwPrAQdyZqv7EukoLDL8vFznvcDw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4jsj9j6U/WeQL78kvwDJBKoGl3Qf04/auhyrChYAFXO9sYr/i
	opQt2geaE8fmrbgQWSIUgmANDKoj/05ULpwjX4w+UfkUXPunYsuznIY1IoOZ4sqPRj4dUbFwX2l
	DnSrM3BX3mkmTrti1wuQxJ5F2M7ij5oudUUzip27bczI6HkRoThQbUM2IuuI2sbQ9WdEM
X-Gm-Gg: AfdE7cnAQyz248BuiWWAEXhjgJ6QGAeaw7sEAOwqjOua5e57gnxcdvD31m2zyxmj0KS
	52gprayrmTt8oug7jPzx+V9L62vNt4eWbifG8UY1wNl3xpeScx4In2HO37zU7vTDdnJBx+5nhvE
	TP9je+xp91dkWr3wPLp9lzp++0dqrDvfmWVz+R5xGcIP/Vq4OhJRHrGlLlHNdfDevToBOdwMyzh
	bDmwZv3CbHU1pkhiXAcm4dKVPmB3ud5JMhoI7Rg3zhs2vQVbLtfXhioWtaHlOBeafm8A4HP6lJA
	4qcKb0cCJ2n+y+moqTdqMreYbaxgSPsiunnuebTRiL2VuGxggcBMz6cJu0JKWn4ZdbjiyvDbOIZ
	uuYJxUAganpkyt9B0cWn0NswD8jlExDPB
X-Received: by 2002:a05:600c:1988:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-493d11f8067mr71136125e9.27.1783240483668;
        Sun, 05 Jul 2026 01:34:43 -0700 (PDT)
X-Received: by 2002:a05:600c:1988:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-493d11f8067mr71135645e9.27.1783240483110;
        Sun, 05 Jul 2026 01:34:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce1a844sm177749835e9.15.2026.07.05.01.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:34:42 -0700 (PDT)
Date: Sun, 5 Jul 2026 04:34:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: page_reporting: allow driver to set batch capacity
Message-ID: <20260705042708-mutt-send-email-mst@kernel.org>
References: <444c24cf39f3f3620fc90ef4695bd6b0979f4c4b.1783232420.git.mst@redhat.com>
 <20260705011635.9974cac7f0defec9961e85c4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260705011635.9974cac7f0defec9961e85c4@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JywPoUuwaai2KEQklRXghBZu4VyKgl86pgZEUgtaIts_1783240484
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 05, 2026 at 01:16:35AM -0700, Andrew Morton wrote:
> On Sun, 5 Jul 2026 02:25:13 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > At the moment, if a virtio balloon device has a page reporting vq but
> > its size is < PAGE_REPORTING_CAPACITY (32), the balloon driver fails
> > probe.
> > 
> > But, there's no way for host to know this value, so it can easily
> > create a smaller vq and suddenly adding the reporting capability
> > to the device makes all of the driver fail. Not pretty.
> > 
> > Add a capacity field to page_reporting_dev_info so drivers can
> > control the maximum number of pages per report batch.
> > 
> > In virtio-balloon, set the capacity to the reporting virtqueue size,
> > letting page_reporting adapt to whatever the device provides.
> > 
> > Capacity need not be a power of two.  Code previously called out
> > division by PAGE_REPORTING_CAPACITY as cheap since it was a power
> > of 2, but no performance difference was observed with non-power-of-2
> > values.
> > 
> > If capacity is 0 or exceeds PAGE_REPORTING_CAPACITY, it defaults
> > to PAGE_REPORTING_CAPACITY.  The 0 check and the clamping is done in
> > page_reporting_register(), before the reporting work is scheduled,
> > so we never get division by 0.
> 
> Thanks.  What's the priority here?  Should we fix 7.2?  Earlier?
> 
> It seems that Sashiko has found a pre-existing issue, a hard-to-hit
> error path thing:
> 
> 	https://sashiko.dev/#/patchset/444c24cf39f3f3620fc90ef4695bd6b0979f4c4b.1783232420.git.mst@redhat.com
> 

Ugh. Yes but it is a minor symptom actually(

This is the root cause:

        virtio_device_ready(vdev);

        if (towards_target(vb))
                virtballoon_changed(vdev);
        return 0;

DRIVER_OK set almost the last thing. But, e.g.:



        if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
                struct scatterlist sg;
                unsigned int num_stats;
                vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];

                /*
                 * Prime this virtqueue with one buffer so the hypervisor can
                 * use it to signal us later (it can't be broken yet!).
                 */
                num_stats = update_balloon_stats(vb);

                sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
                err = virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb,
                                           GFP_KERNEL);
                if (err) {
                        dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
                                 __func__);
                        return err;
                }
                virtqueue_kick(vb->stats_vq);
        }

this happens before DRIVER_OK and it's quite out of spec.

All of balloon initialization needs to be rethought and fixed.
Maybe.
After coffee.



-- 
MST

