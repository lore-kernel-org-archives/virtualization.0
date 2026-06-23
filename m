Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D029D26E
	for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782203654; cv=pass; b=B/lZZe/IT9uxvIK8P0fyTk5oZCAO6KZxHydnPBl/rPvQi7NRwzQP8D+DKJagN8f4i5EzQ5N2e/3UcdJ+V6gODxwTK1RH7CqcuKo7fxK3qjxr3MSuYvbMOXdn/+zaZriQkw0NnEQlc0Ca48INEJ9r9ZkyY8mGP7ZHBKJCyg7McAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782203654; c=relaxed/simple;
	bh=OV2fW3pCtMFTTEV7ESe1I9XaCMwurSyjPz18E6Kt5OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+2cjDV4OOg8se2d/3NZJU0pJoM/ksRmTgRKw2ozPub66On29uflnpcdL68ZZHeLL0w/Mxyt/sCdj/dRiC3Eps+Vp5MKGZ1QpGmagI6Bh9mQ9Bvu5rc+Jxybos3BFnVsA2voWXjjvlIdE0bRa1SiPxHqfosTWjosvBGUW5E/2zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgz/wib2; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgz/wib2"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e94b0aeaa1so1201251a34.0
        for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 01:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782203652; cv=none;
        d=google.com; s=arc-20240605;
        b=VYvNjldr/b8ejkpapcPrLyEPt5hX89Iv0F3DIBPMBWo3hfRBSf8R6v4iKaFyyupOvc
         JywNmPW0dKi6dZibBRIA3EVJQPiYdpe4C7z962GcCz/l6RsUOd96Y0Sb6eGVd/zuEI8M
         Sf4eOja7RKPkSQoZIBMXdhF9Dqq7/zEudoMUxPqzPH1ztx7r6zmgZAdgPuFyHHg9zKyY
         2ntwJgjtaReyX0O+t70qv6S48qRV0HLfTmvQHqNCGWQp3wpAuUk+wU4nADiB4KpNh4bM
         pYuRnlsbfQIj8qdKJ26yMAbJq+jIjr0c+fq/7dA5HCcyMd/u17fu05z4ZTE9KH6s6hed
         3IhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f1l2abI1ryKdUdqmih7/lMXELbJLXJ4khadRoH+x27k=;
        fh=nhG7dC5OMunj9U1UvnL1ybeVjmFo4tyyuPv4ful+kYo=;
        b=b+oPM1jLO8NmDBFgppYYR6rf6A/siucanDDrs77VFF/YXB1KEAYn3oF2AshqMnQ4Bo
         LKrMByYnGVR06JArxEF+CzZihn6LgSEN7y9NVldocMp6wH7FYaqwnzifx09wSeu6hbKT
         PwsKrod7FxLteU9XjLtuS+p71+wQL9Lg8PLl5Ka7C2MD6+48YnRm/BV5MvI3xv9Fn0Be
         OceDItKzjAIiQ0lbwkMsmqtU8POpoT6xqz0xjRdaKuuF6VGd9s7Jok4gf5quKoIOqImu
         mljlzKnoz5qrXAXgB9gghgPNZRwgAU7iy0LcZIsPN1UTWj3GeG9f7UMsxzQJWmyvP19O
         c8OQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782203652; x=1782808452; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1l2abI1ryKdUdqmih7/lMXELbJLXJ4khadRoH+x27k=;
        b=lgz/wib2gHELaRSYlDuJ04Dj3bfNQo3zp3u8WJ0CHywE75BscydVPsgos39XPYb0VZ
         9+BYDzaa8ZTYgGY0QN5ZB4dSBO4FC7/hKBIXUMsSE55ryoWMq/WDqxPMEu6/fa5rTcQC
         9BzN0mO4NbTNiZ7VqetlOayPi5Oq8fBoR30mcLHNuiYY3UmcpOf1Rli/EgOoMa/KRhFC
         HbyLyUKEOyTfiWd5A9AActjGDG9eXg8NGEPuX5o0E1oVhzNwWsOQgFWRDj6AgoxOJZEQ
         5F5npOVT1mXxdLIhY9KiiFNK5Y6gxIQPOly78mRnvfCT5jo5wcSqPvp3cDnBZK+qf7Vt
         rP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782203652; x=1782808452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1l2abI1ryKdUdqmih7/lMXELbJLXJ4khadRoH+x27k=;
        b=pvWVVv/ELwxffNIaC0pL2KrgGag1Cf3eLJdvUlkocHdEioSfzN3ZoRx6A/nperGE1Q
         Pmn3zG2atEQGkAXx85UayId/G746lATI4LjWBFMOFAb23H/mbnr2p3if/sDSqKHpEk5v
         pFlm9Q3gXGdwf/vZyI3HeMPOlx9KmR53b71ba1f/8I1Y54z2zQuqv+xW4OcJ8dhzaezN
         0rkpaKfYdAQk+6i7a7p9wEyAiI6VrO4A787XXJdl7K5Z3EvPG+QC/a3WgdNoWtH1asE+
         yw0Khh8a8FdKavBds810K14kCiqi6V4aQ9XvnbzVEGmcC577xAyes/13UnkLGx4vy5iK
         nymg==
X-Forwarded-Encrypted: i=1; AFNElJ9EG1rx5e1K5zAqw99jg/k2M3vbF8VzxS9blg+X714pfYcOni7OocE0oRuTXpOlX0+NpHhIUmNBLOJX2I3i2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlTjhV7m+aqbG/tpfv5a4MahAmx4MABhwcbHlqeOSxaHp/kbzp
	meuTFbKDiQbWrNEfvebZPhgZKT+VmSVa8dAOtwuo6N/fxQKkQ06OdoqBS3rFQdJmmbZuB4BuEw4
	dL4z6lJrJYdWxnUxHLuGn9nqenuFNfv8=
X-Gm-Gg: AfdE7ckov37PpT5kYKJ2OmLpNgJ8Q7e9lLLeF6VFucoJhLhzsWltj5M487bcYAgPKTO
	IhY9WrvP+hURscZ87aXwxpyEPFlVmNIN9e729G0Nh8uAWEZ6tVqUhohyQoclfGOMNAMZPXfdWe8
	6pk9WOZuIt2aD8h4obwCHq0w1Mt0sNoY0rj/Lvn4gt4kdU919fAypWyCaptWA3wx6/k5LDdvcj7
	9FxbMo86DOGvkh2Pf7XLw5P0SC9IakR1vpDodtH93hno156UoOzKK0MxayMmEb/Putu3tFAOYw=
X-Received: by 2002:a05:6830:4489:b0:7e6:ff83:4b36 with SMTP id
 46e09a7af769-7e979744c03mr1083770a34.8.1782203652447; Tue, 23 Jun 2026
 01:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260621130246.2973254-1-me@linux.beauty> <20260621130246.2973254-8-me@linux.beauty>
In-Reply-To: <20260621130246.2973254-8-me@linux.beauty>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 23 Jun 2026 10:34:01 +0200
X-Gm-Features: AVVi8CfWC-Vqu4iDrDySDkpltMedRJpJ6Gq-lDYV2aqtP04PGGTk3D_rgV39oMw
Message-ID: <CAM9Jb+jeNUjOawATgq7+cU8KVq3ujxNaXF9y5bnta6jJ3_T+-w@mail.gmail.com>
Subject: Re: [PATCH v6 07/12] nvdimm: virtio_pmem: use READ_ONCE()/WRITE_ONCE()
 for wait flags
To: Li Chen <me@linux.beauty>
Cc: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, virtualization@lists.linux.dev, 
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Use READ_ONCE()/WRITE_ONCE() for the wait_event() flags (done and
> wq_buf_avail). They are observed by waiters without pmem_lock, so make
> the accesses explicit single loads/stores and avoid compiler
> reordering/caching across the wait/wake paths.
>
> Signed-off-by: Li Chen <me@linux.beauty>

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com

> ---
> v2->v3:
> - Split out READ_ONCE()/WRITE_ONCE() updates from patch 3/7 (no functional
>   change intended).
> v3->v4:
> - Rebased onto v7.1-rc7 and renumbered after the flush error patches.
>
>  drivers/nvdimm/nd_virtio.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index 8ed4d6b3a9284..da829e9f4bdff 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -18,9 +18,9 @@ static void virtio_pmem_wake_one_waiter(struct virtio_pmem *vpmem)
>
>         req_buf = list_first_entry(&vpmem->req_list,
>                                    struct virtio_pmem_request, list);
> -       req_buf->wq_buf_avail = true;
> +       list_del_init(&req_buf->list);
> +       WRITE_ONCE(req_buf->wq_buf_avail, true);
>         wake_up(&req_buf->wq_buf);
> -       list_del(&req_buf->list);
>  }
>
>   /* The interrupt handler */
> @@ -34,7 +34,7 @@ void virtio_pmem_host_ack(struct virtqueue *vq)
>         spin_lock_irqsave(&vpmem->pmem_lock, flags);
>         while ((req_data = virtqueue_get_buf(vq, &len)) != NULL) {
>                 virtio_pmem_wake_one_waiter(vpmem);
> -               req_data->done = true;
> +               WRITE_ONCE(req_data->done, true);
>                 wake_up(&req_data->host_acked);
>         }
>         spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> @@ -66,7 +66,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>         if (!req_data)
>                 return -ENOMEM;
>
> -       req_data->done = false;
> +       WRITE_ONCE(req_data->done, false);
>         init_waitqueue_head(&req_data->host_acked);
>         init_waitqueue_head(&req_data->wq_buf);
>         INIT_LIST_HEAD(&req_data->list);
> @@ -87,12 +87,12 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>                                         GFP_ATOMIC)) == -ENOSPC) {
>
>                 dev_info(&vdev->dev, "failed to send command to virtio pmem device, no free slots in the virtqueue\n");
> -               req_data->wq_buf_avail = false;
> +               WRITE_ONCE(req_data->wq_buf_avail, false);
>                 list_add_tail(&req_data->list, &vpmem->req_list);
>                 spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
>
>                 /* A host response results in "host_ack" getting called */
> -               wait_event(req_data->wq_buf, req_data->wq_buf_avail);
> +               wait_event(req_data->wq_buf, READ_ONCE(req_data->wq_buf_avail));
>                 spin_lock_irqsave(&vpmem->pmem_lock, flags);
>         }
>         err1 = virtqueue_kick(vpmem->req_vq);
> @@ -106,7 +106,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>                 err = -EIO;
>         } else {
>                 /* A host response results in "host_ack" getting called */
> -               wait_event(req_data->host_acked, req_data->done);
> +               wait_event(req_data->host_acked, READ_ONCE(req_data->done));
>                 err = le32_to_cpu(req_data->resp.ret);
>         }
>
> --
> 2.52.0
