Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A29823DD
	for <virtualization@lists.linux.dev>; Fri, 10 Jul 2026 00:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783644346; cv=pass; b=ubD/CJMNih7y2kmK/nHQg+43V0P8A5orbQsTtPBa5rJ6VXa1yFwf3dEIP3/fIulTEtYrImCNC4agt/ncga4nMrd1CFjR21EaqbyAi5VbIbDmS6tRWdQFTnhq0/2reRG2eiB8M5cVmP1/kHgFgf7Q8cH4yfkYVUMOrVAqxWXdSQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783644346; c=relaxed/simple;
	bh=cEFXJr+q+9MWtcGTtdT+TqhJ4Ycq1/vL6B3e3GzFB1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4AOHSDy2oXCykfZ6mrDL4hKcgIqhqOHmQfo7P7GJ8GsSq0fMkJguMMtD1Tyidf+kM63j6EBWn51k/Zf9RUbdA2/0FUupNDdcUkuF3Ywgc0MgtuOcW53vaagH2Vxb/9Sx4T3XHve4DeMUfj8tWfklIdv62Mwp9EObqt3JCpHBh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7yarNzo; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7yarNzo"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c10e86e52so81041cf.1
        for <virtualization@lists.linux.dev>; Thu, 09 Jul 2026 17:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783644344; cv=none;
        d=google.com; s=arc-20260327;
        b=b/0OB2Iwjz2nXpxjaV0qE1m//quZP/7u6MXD6Vib0vt1NwRhtQzlovECdKLIfXjlmz
         1s4jwD4WQHIzpQ4ifsJ63HFLz4AYb2F6EwYbNypt4fAzbM70ijlDJ4h6eJ9al/MuOA8H
         kRbbcPe/60yqkdG/8qtYCYeONBKfWUsR7DAw9ocqVmQsMaoWwXOBQvIZ8IGHC/mmJpji
         0Ap0eBcGlZNpIw0BFEgt6KkkvxyTTEiGzNAgU9bkCs5G795UzElt5y0zoPlPyX1cb0oC
         l7myuvsdxl+Ws8xuI0ANXBRm6Vqw/Q8qBmH50k2z6puNWk4ROxE8N5OHw+K4BC4o1bBE
         6W0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4NDxZOCfeqZWYG26A8bUT8OjQGBJjjUiBg2MLvfAqRA=;
        fh=HAeWL6cQX/8z+a6sSZNas5ybRUhoTm0iLcl0AHRE9P8=;
        b=mvfzmkAwI5YwrrNT0hcmbym51q2CNfkqxTOk/gljUuACJdDZwoO65cVoN8QUBTGH8x
         kTqBTuOHupaC3mCsuRjrFZSRXxBweXjbh2l/pbrJS9Kso0a6BcmjWEHgcb3r/FTYxWQe
         NTjEi0NPQ+g/1rklItBGCKNzkc30nfrOAN8YALsV18tlFIpl/0ydjm6GWsdPYmtFytJ8
         TcYU3hKVRfTORigNN7OBTM4SVJYgH88ddJyZkEC2L4quqHQAS0SY689ueLSZr3oXjjIO
         v7meVjiBMuLgoZTzJGE2tJYtCTINqzd+mf+9PskByKr5c+VmWB2dRxqzxqYIKAkmbW22
         2BAw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783644344; x=1784249144; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4NDxZOCfeqZWYG26A8bUT8OjQGBJjjUiBg2MLvfAqRA=;
        b=q7yarNzoCnpxgyQcntSKzzYn8Uvpd/7AWCT4TJDSVqLRw0NXBWVwpGytyn7IGRW3Wr
         hftxVzIcDsD5TFnd8xqWoZ4w1gnuGHrQfXIU3jPEtE+piWXLASVbrQkr0BEbIs1TA3Ov
         Vu1mLAYBb90tozSvhMS28xG8gXqDpFUdZsPyz26nkMHXxN3Sp91pXL9WBKQOJ2pFOmcm
         DN9C8XCKtr+RbHvl2BA0R7h8A/D+DIXgmyLfDEs86COZLIFqvChDZBoNZGmjjWGm+OrE
         7Jk+mni6XPEgnaEMUkfdhTbn6FY6GhNCsETjwbBGNvtl+wn00YTyy29q6fiqbsnz/p3L
         +zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783644344; x=1784249144;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4NDxZOCfeqZWYG26A8bUT8OjQGBJjjUiBg2MLvfAqRA=;
        b=XrGQFQvun1PNjumZi3Tp9/n+bf2zwrHlkDRPvlJCbiRnGtu/xA34S5LmH5BaDGIQGA
         1pUkGUUUtOdAztSXjQz4lYHXh9ZFvtPuOi8t/EKe7zrYlLMMZiH04/sTzgpvY7muMvRb
         xekHskAMt9XfxTQPSJsNo5v1VxO4kj4lxy0zmYRwY9o2BbYYQSWmIbYn9dY+lPv/Nn4g
         N6iHtP0mUk2fvcFUBBajB2UXpg+uD+JAwS88XMOLkXmZBQnaM5mMdeMEbLYM6rARLBo6
         +oat00MDKThVC9tmbVRgRmqrbDZ/y2l7npMCD6mMjA0hPcRmLOrdygfKN2P9+MQUgbYO
         ugCw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0LyrSbzkzFCq7u2w3ztYqNLYoEZNuHL2/ERSPrVr/0bP5s3EK3ywq/HDAky4DZg5nz4ExjpbNBbzkMVxvSA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3rIMRIvaJ3+mV8FRgHlm55k1lH/8hIsexYNap6Oz26KkI2tjJ
	+swEY/U4iP4miPUbFl03QKqjpFsfeEhmuPxhwG7IvEuibAT/S4O3U0LrZQgMSSBcjbQFpcuxBr4
	MmWU4jbjghqlSVvGPscAjM32D2A/61dH0ASHSJqy5
X-Gm-Gg: AfdE7cluMvlmPP7qBbA58zdu5izCQ7xiAN9lKqWVVNXLMqhoGn29Pj9fP8O8RhQAG4y
	ezGHGgoAyoEQUvn0y2i3aWmqmSJblj8CuIoO/S2a+5DKiBjCEbOzFVpLiLWro20n6ydRMVMFt1K
	hthK7TvUHDtB5DH2i6CyA0BnzhC6ihb8mZ5bBPh0Axbc6ioge5PegoYTnNGNhjaqFIWM4SKMtRW
	oJzpc8iY2ZgMjtKHo1JVrXWyryHnRUoIhZCEBYnu8RbkSxGv9ZNRSkXt14fFwWBypJYatMxn1Oj
	+d5/K67odno1bi9c72stemWq7Q==
X-Received: by 2002:a05:622a:1f09:b0:516:d570:82c0 with SMTP id
 d75a77b69052e-51cac54df32mr2758731cf.15.1783644343839; Thu, 09 Jul 2026
 17:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260709224330.946683-1-linkl@google.com> <20260709161253.6b5e9ba349f70a3ebfb8180f@linux-foundation.org>
In-Reply-To: <20260709161253.6b5e9ba349f70a3ebfb8180f@linux-foundation.org>
From: Link Lin <linkl@google.com>
Date: Thu, 9 Jul 2026 17:45:32 -0700
X-Gm-Features: AUfX_mzRlthWGS4tvguyuxlqGde2yyyYF501igG6ylQK6FfQ-MElEO9rT5w6uEI
Message-ID: <CALUx4KQ=bYTpDoDAZ+iVb7Ehaa0LmyPDsEWk3xFFmTVYKrpAUA@mail.gmail.com>
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting during
 PM freeze
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jul 2026 at 16:12, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu,  9 Jul 2026 22:43:30 +0000 Link Lin <linkl@google.com> wrote:
>
> > Fix this by:
> > 1. Unregistering page reporting in virtballoon_freeze() prior to calling
> >    remove_common(). This clears the RCU pr_dev_info pointer and flushes/
> >    cancels prdev->work on system_wq via cancel_delayed_work_sync().
> > 2. Re-registering page reporting in virtballoon_restore() after the
> >    virtqueues are re-initialized and virtio_device_ready() has been called.
> > 3. Unwinding virtqueue initialization via remove_common() in
> >    virtballoon_restore() if page_reporting_register() fails.
>
> AI review thinks the patch didn't do the above:
>         https://sashiko.dev/#/patchset/20260709224330.946683-1-linkl@google.com

The AI reviewer might not have parsed the entirety of the fix I proposed.
The patch submitted definitely includes the changes to virtballoon_restore()
for steps 2 and 3 (re-registering page reporting and unwinding init_vqs
on failure). It seems the AI failed to parse the diff correctly. See:

+       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
+               ret = page_reporting_register(&vb->pr_dev_info);
+               if (ret)
+                       goto out_remove_vqs;
+       }
+
        if (towards_target(vb))
                virtballoon_changed(vdev);
        update_balloon_size(vb);
        return 0;
+
+out_remove_vqs:
+       remove_common(vb);
+       return ret;
 }

> It also might have found a couple of pre-existing bugs in there.

Indeed. Regarding the first pre-existing bug found by the AI (leaving the
OOM notifier registered during suspend, leading to a UAF if memory pressure
spikes during S4 hibernation):

I actually addressed this in the commit message:

  "(Note: The OOM Notifier and Shrinker/Free Page Hinting features suffer
  from an identical lifecycle flaw and are also vulnerable to UAFs during
  S4 hibernation when memory pressure spikes. This patch focuses on Free
  Page Reporting, which runs periodically, to ensure clean backports to
  stable kernels)."

Regarding the second pre-existing bug the AI flagged (leaving uncancelled
works on system_freezable_wq if virtballoon_restore fails on the cold path):
the AI is correct that this asynchronous work cancellation failure exists.

Since these are separate, pre-existing lifecycle bugs, would you prefer I
roll fixes for the OOM notifier, shrinker/free page hinting, and work
cancellations into a v2 of this patch, or submit them as a separate patch
series to keep the stable backports clean?

Thanks,
Link
