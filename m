Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7691357CF9
	for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971671; cv=none; b=JgywRPjckHO3fuNHNWcGjd3HibzgggZxCtkg/EF6NNcLHALUN4YKYaxfe0p3qkbnB70Mn5netYG6dKzXLEyc+3qhh/J6ZRVkq6XaV/vjiZCddXFKGjqodBaMbX+V5pBZ9SKMp/obR7WJpK9+VVCBo6adra0AFMYZ2ikBEqIXxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971671; c=relaxed/simple;
	bh=Z380FDqsxBLRnjMA6hntXYmI+33qpOSqSr+3iFUF4c4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bkl6gpKPBu95Xdm3FLT4CVV/5QtRhCmZ7/nWFlHN3iy6VbRt5+u+IzRaCyg2edqaU0ID9HfVE/3Hf1tdOen0q5F0C58h9ScGXEmyT2fUMmT3b1uoXKc/AuavNcZTgoWXJiNZOD7iMgX4bsyQRqkgO6ZXKAO7rm0PBdJyMjwf6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOyPYWwY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOyPYWwY"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cab97c86bdso27795ad.1
        for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783971669; x=1784576469; darn=lists.linux.dev;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WLh7SflYriIICq2322YWz4Oz4v42mpNRc7r49x5w7jo=;
        b=sOyPYWwYcJ1kx0WSCvn2l3wy7g2UhERGvkpSAPccyHIMkZ7/wKRrqYIshkpMcwDZeb
         sgazBuB5RXSCX0QmWAT/mZTJbBOllezcOCVvBpoTYkXpW+EgPxLfoC/lwMs1HajT/wkK
         uTyqiVI4iuE16A8d26dSEQkXjh8+hVkcO/stL5vCPtBu4Wdcix3EE0R+jiyvbMTP/cGN
         Yu+Zd7QyACHGG21Zvo0XnwVfsnCjc060ZgG897HCJZpyWsXpWb4OlO07JgYQg4RGHICF
         XMAJ76W8f/q4LDJ2k7TjQIJbskxBee8UZkjT8ytefycvKa8RHFo1yw7cr1x2w1NfuDr1
         dWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971669; x=1784576469;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLh7SflYriIICq2322YWz4Oz4v42mpNRc7r49x5w7jo=;
        b=sYnVTRNVG1mDQD4ufyoybN3+AuUyRyyKtdk2TO5A3Q3c0aZaGFC9tvTn1cdI6Mal8v
         v9M1c0QDbmZTEm+a1LGB2lBCrMgwBvUsCBCb52BYXqyYcJJ8sNztx8vcXCCliUUyajUV
         q0mVO6AKkxo0qv8mDlgWnmFGSjBwMincSlGACvlVv5EZVOzV0UQ9MfS9bwaPOYzElBPT
         dB7JDLHIgv5L8HCKfYx6su7YJVGdKnb+NlyDB0oQuZDLugD2vdFZL32aeqidfC6fpdI8
         mHm0HUlg6Ac/L9LVjk8+ZjL4WJvWkfkBhsJpTsLSC5sTnW03IZPOvPVMZ8lSf/sDAvxS
         embQ==
X-Forwarded-Encrypted: i=1; AHgh+RqfNOS5oJaGgZRv3lPZ7KPasMcUVVZEBqi1UuwAFEWVnII0l1VD73G4daumpFYDYrtXeAhtYFjraQ23bQRVnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywo7FCCkqW6vfBntULvtcu8Q6rrPGHdW6xt1XiaMW+XKKXNoCxp
	kRbPTjDZVDcs17wCJ98UV6c5LxnvYMsTgTNpO83qWCyHd9G3TLaD1dFJl7y6Wp6WfQ==
X-Gm-Gg: AfdE7cnBMkj+SfXE3NShpfF+R1Snv/y2vh5lCiogAMGo2a13GzzboxBAmbFyVnctVpq
	UyN9+WgFsKd3ucGhWLmalnNsR/TLDzTXjLEj1+heKGJaaHYyp1IMU1rhlGmy8k/tWpysdD0dVhZ
	qjIlP1rTsxOAp+yM9uoJWcvNhZZbNxpGYjlrmVn/RTKfaAm1lrWkD8sMLGLFRrBBP4gFYTokHCR
	9NSZpydaXNGsMN1STc0GjnkH/U7vCwOF4U3jzf8uqtmARQ6GvfRMn7FYYA57E5If6JdHN60qvMK
	IUzgbvuf2yFpR/cLCphQ8gI1790NkPy0IpFiwzSkTp8UhmXBfqRBHUcijSagEitIq7EYxCpxJFT
	mmCUGzOia+9Nb3JEBr8lvfcPsP0+O4iD5onUls/ZyY4OzGwrDpiGKLb2+8YDPqTQjpA4empDy+I
	PoCsAgita6ispOGOZd4GwLOncNf+mN9yUwuoZKqDXxyZYrbPRqlnKWxUiBIHa0AMXm+h7guk8AF
	NHfa0tmKfRYZyXvtF8/LlW+36o6FGznO8V8bQfF5lEZoNIx7E8aIg==
X-Received: by 2002:a17:902:fd83:b0:2bd:6dad:3dfa with SMTP id d9443c01a7336-2cee1ccc432mr2429565ad.24.1783971668691;
        Mon, 13 Jul 2026 12:41:08 -0700 (PDT)
Received: from [2a00:79e0:2eb4:9:4c33:68fb:770e:3e89] ([2a00:79e0:2eb4:9:4c33:68fb:770e:3e89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6c158bsm272977b3a.38.2026.07.13.12.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:41:07 -0700 (PDT)
Date: Mon, 13 Jul 2026 12:41:07 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Link Lin <linkl@google.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    "Michael S . Tsirkin" <mst@redhat.com>, 
    David Hildenbrand <david@kernel.org>, virtualization@lists.linux.dev, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, prasin@google.com, 
    duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
    Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, 
    ahwilkins@google.com, Greg Thelen <gthelen@google.com>, 
    Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting during
 PM freeze
In-Reply-To: <CALUx4KQ=bYTpDoDAZ+iVb7Ehaa0LmyPDsEWk3xFFmTVYKrpAUA@mail.gmail.com>
Message-ID: <59e3dae7-a203-2e1d-3b65-875b7e0e122b@google.com>
References: <20260709224330.946683-1-linkl@google.com> <20260709161253.6b5e9ba349f70a3ebfb8180f@linux-foundation.org> <CALUx4KQ=bYTpDoDAZ+iVb7Ehaa0LmyPDsEWk3xFFmTVYKrpAUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 Jul 2026, Link Lin wrote:

> > > Fix this by:
> > > 1. Unregistering page reporting in virtballoon_freeze() prior to calling
> > >    remove_common(). This clears the RCU pr_dev_info pointer and flushes/
> > >    cancels prdev->work on system_wq via cancel_delayed_work_sync().
> > > 2. Re-registering page reporting in virtballoon_restore() after the
> > >    virtqueues are re-initialized and virtio_device_ready() has been called.
> > > 3. Unwinding virtqueue initialization via remove_common() in
> > >    virtballoon_restore() if page_reporting_register() fails.
> >
> > AI review thinks the patch didn't do the above:
> >         https://sashiko.dev/#/patchset/20260709224330.946683-1-linkl@google.com
> 
> The AI reviewer might not have parsed the entirety of the fix I proposed.
> The patch submitted definitely includes the changes to virtballoon_restore()
> for steps 2 and 3 (re-registering page reporting and unwinding init_vqs
> on failure). It seems the AI failed to parse the diff correctly. See:
> 
> +       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> +               ret = page_reporting_register(&vb->pr_dev_info);
> +               if (ret)
> +                       goto out_remove_vqs;
> +       }
> +
>         if (towards_target(vb))
>                 virtballoon_changed(vdev);
>         update_balloon_size(vb);
>         return 0;
> +
> +out_remove_vqs:
> +       remove_common(vb);
> +       return ret;
>  }
> 
> > It also might have found a couple of pre-existing bugs in there.
> 
> Indeed. Regarding the first pre-existing bug found by the AI (leaving the
> OOM notifier registered during suspend, leading to a UAF if memory pressure
> spikes during S4 hibernation):
> 
> I actually addressed this in the commit message:
> 
>   "(Note: The OOM Notifier and Shrinker/Free Page Hinting features suffer
>   from an identical lifecycle flaw and are also vulnerable to UAFs during
>   S4 hibernation when memory pressure spikes. This patch focuses on Free
>   Page Reporting, which runs periodically, to ensure clean backports to
>   stable kernels)."
> 
> Regarding the second pre-existing bug the AI flagged (leaving uncancelled
> works on system_freezable_wq if virtballoon_restore fails on the cold path):
> the AI is correct that this asynchronous work cancellation failure exists.
> 
> Since these are separate, pre-existing lifecycle bugs, would you prefer I
> roll fixes for the OOM notifier, shrinker/free page hinting, and work
> cancellations into a v2 of this patch, or submit them as a separate patch
> series to keep the stable backports clean?
> 

I think it would be best to have separate patches for each fix; Andrew, 
please correct me if you'd prefer one patch to address everything.
