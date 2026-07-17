Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE33331A48
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300628; cv=pass; b=cRte7ZYMgEtU0l+mhUsnAn9Dx0uJyJ/i6JJ/miMZB7+uCr27odPSZ8kPmjoBA2ld/fVnYDOc73P1oOxcIoNdR8f16IueiGM0GsjjaeUIpgKDZZqU24F7yJIBqedV2AaPFsWszh/lJ+29Wo9F0TCghsVOYmMhxIaRWdWNFcBFYBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300628; c=relaxed/simple;
	bh=4I5hTuD/iFXPg+NyVOkcJtrnXIHDXNgE/JDWa9xvQe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJmqpgWN70IRbDMjuMpwOPiaMV29z+kanPl88dLTz1ZxhZy8tW+sthh2Y3skrCRLK0gRHlWQe57pFKos3xboS5BQF7f5U4mtHnLm9qAVO9qbW1ryWdWQk+plTCcOlsbwd2B5HOpEGjLiGl6pC8Cf53WO8tQHDst5bxsgfR9C2jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUsg/fXB; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUsg/fXB"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-448b89f700fso4865266fac.2
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 08:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784300625; cv=none;
        d=google.com; s=arc-20260327;
        b=elY64UgL0ArnXQn2UAhkrTdw22xT3WFTdYlWgLg26fwG8nwO6zIVKorSILGTyvW8YP
         K5709JTjslH8CnDTQ8w5YLX+3pDFoY8gHyMtSkFeuUMQrFFPYwAX5Gi1FNiXSAY7AdqK
         Nx1C4FMGiux44S3yG6lXV1raMLntb1au3pfl16OlO9/z8afg8obCxpBQUh3ZseGrzrBw
         O06hP8spziIxKIvnsligAF0EzeqKHbO66Xqu8oGq4FXz/Vp3/C96PbnSEolgTxaHTTp0
         KolEp5WKrsL0eMkMshPMKkLn6odOUP89A0JwDbhpTSygI0VqTFFERDfDzKWkrPG+XeMf
         FXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=poYdYrQ7d60yOY7c10x2Y/P8RkUQTllTFQeSEPM/KwY=;
        fh=U+DQ1N1Gc9n6AMjs2B6WZDC/AMAylW4nj+h9rzEQaGs=;
        b=dFVtwiUolgBMSfpatTa8lNXAvb13K4bHNGBZVI26pP0PSn2nhnDTTRSjJvQm0mstjr
         gyd4uFDIg1FbHoHHcJBPIdveEMs5N/d1+g+N23IE9u+olTIvfQUB8ReHlL1tneOEh0i7
         3l0pQwR78B3aDasmheVKVT97dWpg9SiMCNxzb/gnAnZaKjhVK9YFS3tXAT/+SfEKjYF3
         EZz7tz90JgsWE11Y9Y7F777AF60GZNDz++vQBQgipg+QWcQ1cP/Ef0JmsgM2Ytt8Tx+e
         3zuCCSbNPMZlWRgHZ2H0C4H4+wNy/FDwYj9ySvV4RLxfhM+hWYoZazG1+43tT3QGLYZp
         O90w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300625; x=1784905425; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=poYdYrQ7d60yOY7c10x2Y/P8RkUQTllTFQeSEPM/KwY=;
        b=VUsg/fXBULfRlTNfi0TT8EbWYiaDR6/Rf42J+0qkLYJfQLaLc8a0GDdPjVVc0v62yV
         jfH2c/6YP46gQMD0hjXNdi23+32PgTKTBxMeyVG4j//8p503pBCGC2u00AaSIvebSE3X
         209B0JIK8XWGgROfTVosv7KHdmZbqha+gY6SKRETzTRsjQpA2sZKajRENs3ILvTNBvwg
         2jSXPydiaEuIE9kkrkEkZLRvPXUkS9vAtiCIlk30nRZnlWQk0KV3lUcw4QE40AtjiarG
         4x6UaiMG+H+K1o88G65Q9Mx5zdXwG0/pZJt1OVJ1PDn+9uh4bWzKtMKRUYJTqHaZu+Q/
         s28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300625; x=1784905425;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=poYdYrQ7d60yOY7c10x2Y/P8RkUQTllTFQeSEPM/KwY=;
        b=HhRw/TU1pv7C5HWpWmoU2f73tgYBgAAFhtMdMC+3/O61ZugCpoWn388ZvQlE1CBRDl
         HSffli7h3gH5ycUQLz/uHjvB7CCiZ+SkV2IKtgrt4eGBujTX26jNiGfTN7R/A8nzWsPE
         bukceRDCgqAN1W1mCbp2rrHGD6QWskocM7HT5xYHdHX6G0aQf8nDBDD1KWSaUDxPApnc
         pCrclRUe8cgKVqIVHJNEqYUkAWNG0khoIW1OY/0x7r+lc/4xeHS4eA0GO5HQYDwp5U8C
         7ArJg65iRvBn7ahphTirlmeFq6hPiiq4TF6eKOPvfcRMcLGVL1QV1IRnpbMBtT3LTG+O
         AsmA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5y61cq/kl16SHGCy6ECM7Ss2FssFi7lVQApYGqa3gF3bYYKdAbYK1npS5P08GvAvs8TVuD2fhTJpmqzj2Vw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkMPdVPjTe5h2Eh2qkEhoBOmH+R30oPJUdXDEe0yBdMAKCSoUT
	H47TAMwrFIKE1Y81aDiHINfQfdaRFTP75EZC8//xccHgXCmZSt060Z3cIexPuznhk2OTRZSZDy/
	sDkE9rQfg348aiclshe5kdq3hJyK+dyQ=
X-Gm-Gg: AfdE7cnP208CPAItVHuNPVxL1rFzNbllh5TrBazpkAtuALL19l1356b0gULL2cJTPCN
	rdWHpfP3NgBEjzLzbpvTF9sVEsIx8+m4Uy6HpDlzMTCoLXdSvHn+F9FwZAMBnkXVdVMYSy4uMe2
	DMyQ3+2IeCZxUXVa1/eBWxBn4hlaiEXFZgRq8L9079ND/EhJ5zCvVXr51YyVFDyYQ/iv+0gH9p1
	9sHqzbvVFK7/9cildrKGw9pjsvbWbzJIvdwcRWeQFdiRBnfAWCmQzDXyQ1vBu/MOGH533IAzXw=
X-Received: by 2002:a05:6870:c695:b0:456:65b1:a226 with SMTP id
 586e51a60fabf-456905a565emr1171540fac.41.1784300625241; Fri, 17 Jul 2026
 08:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260709124455.1547912-1-joseph.qi@linux.alibaba.com>
In-Reply-To: <20260709124455.1547912-1-joseph.qi@linux.alibaba.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Fri, 17 Jul 2026 17:03:33 +0200
X-Gm-Features: AUfX_myPnm6hoDB2wsVDiOjsIb4vMF9folxx9WjFpkN0El1BM_Z84gVyqPqpkL4
Message-ID: <CAM9Jb+jXPPe2X98ADMHMzFFGgJKzM27+45Bnn8iRj1+KqJWjiQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-pmem: allocate flush bio from a driver-private bio_set
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Baokun Li <libaokun@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Dan Williams <djbw@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Alison Schofield <alison.schofield@intel.com>, Linux NVDIMM <nvdimm@lists.linux.dev>, 
	Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"

+CC more folks

> async_pmem_flush() allocates a child bio for the flush with GFP_ATOMIC.
> This runs from pmem_submit_bio(), a ->submit_bio callback that executes
> in a sleepable context, so there is no atomicity requirement here.
>
> bio_alloc() only guarantees success when __GFP_DIRECT_RECLAIM is set,
> because that is what lets it fall back to the mempool reserve. With
> GFP_ATOMIC the reclaim bit is absent, so the allocation can fail and
> return -ENOMEM whenever the fast paths (percpu cache and slab) are
> exhausted, which is common right after boot. A flush is issued from
> filesystem writeback and must not fail on a transient allocation
> shortage, otherwise the device can appear unmountable:
>
>   Buffer I/O error on dev pmem0, logical block 0, lost sync page write
>
> Switch to GFP_NOIO so __GFP_DIRECT_RECLAIM is set and the allocation can
> make forward progress. However, bio_alloc() draws from the shared
> fs_bio_set, and the incoming bio being flushed may itself have come from
> fs_bio_set; allocating a second bio from the same set while submitting
> underneath ->submit_bio can deadlock the mempool. Add a driver-private
> bio_set for the flush and allocate from it via bio_alloc_bioset(), so
> the flush bio has an independent reserve.
>
> With a dedicated mempool-backed bio_set and GFP_NOIO the allocation
> cannot fail, so drop the now-redundant NULL check.
>
> Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  drivers/nvdimm/nd_virtio.c   | 11 ++++++-----
>  drivers/nvdimm/virtio_pmem.c | 11 ++++++++++-
>  drivers/nvdimm/virtio_pmem.h |  4 ++++
>  3 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index 4176046627beb..b4bd21edf5c1c 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -110,17 +110,18 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>  /* The asynchronous flush callback function */
>  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>  {
> +       struct virtio_device *vdev = nd_region->provider_data;
> +       struct virtio_pmem *vpmem = vdev->priv;
> +
>         /*
>          * Create child bio for asynchronous flush and chain with
>          * parent bio. Otherwise directly call nd_region flush.
>          */
>         if (bio && bio->bi_iter.bi_sector != -1) {
> -               struct bio *child = bio_alloc(bio->bi_bdev, 0,
> -                                             REQ_OP_WRITE | REQ_PREFLUSH,
> -                                             GFP_ATOMIC);
> +               struct bio *child = bio_alloc_bioset(bio->bi_bdev, 0,
> +                                       REQ_OP_WRITE | REQ_PREFLUSH, GFP_NOIO,
> +                                       &vpmem->flush_bio_set);
>
> -               if (!child)
> -                       return -ENOMEM;
>                 bio_clone_blkg_association(child, bio);
>                 child->bi_iter.bi_sector = -1;
>                 bio_chain(child, bio);
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 77b1966619059..136179506b478 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -65,12 +65,17 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>         }
>
>         mutex_init(&vpmem->flush_lock);
> +       err = bioset_init(&vpmem->flush_bio_set, BIO_POOL_SIZE, 0, 0);
> +       if (err) {
> +               dev_err(&vdev->dev, "failed to initialize flush bio_set\n");
> +               goto out_err;
> +       }
>         vpmem->vdev = vdev;
>         vdev->priv = vpmem;
>         err = init_vq(vpmem);
>         if (err) {
>                 dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
> -               goto out_err;
> +               goto out_bioset;
>         }
>
>         if (virtio_has_feature(vdev, VIRTIO_PMEM_F_SHMEM_REGION)) {
> @@ -131,6 +136,8 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>         nvdimm_bus_unregister(vpmem->nvdimm_bus);
>  out_vq:
>         vdev->config->del_vqs(vdev);
> +out_bioset:
> +       bioset_exit(&vpmem->flush_bio_set);
>  out_err:
>         return err;
>  }
> @@ -138,10 +145,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>  static void virtio_pmem_remove(struct virtio_device *vdev)
>  {
>         struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
> +       struct virtio_pmem *vpmem = vdev->priv;
>
>         nvdimm_bus_unregister(nvdimm_bus);
>         vdev->config->del_vqs(vdev);
>         virtio_reset_device(vdev);
> +       bioset_exit(&vpmem->flush_bio_set);
>  }
>
>  static int virtio_pmem_freeze(struct virtio_device *vdev)
> diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
> index f72cf17f9518f..4ff2076f75047 100644
> --- a/drivers/nvdimm/virtio_pmem.h
> +++ b/drivers/nvdimm/virtio_pmem.h
> @@ -15,6 +15,7 @@
>  #include <linux/libnvdimm.h>
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
> +#include <linux/bio.h>
>
>  struct virtio_pmem_request {
>         struct virtio_pmem_req req;
> @@ -39,6 +40,9 @@ struct virtio_pmem {
>         /* Serialize flush requests to the device. */
>         struct mutex flush_lock;
>
> +       /* bio_set for allocating flush child bios */
> +       struct bio_set flush_bio_set;
> +
>         /* nvdimm bus registers virtio pmem device */
>         struct nvdimm_bus *nvdimm_bus;
>         struct nvdimm_bus_descriptor nd_desc;
> --
> 2.39.3
>
