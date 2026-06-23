Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2826436604C
	for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207995; cv=pass; b=I+Hs4E/zUsLGuQPRFpnKbFEEuG648nQ/PmjvLOyTXA+6sOogb5Oca4joM+04xSjJtv01GMHz//obC5mknG/GF+FkEZd+JyQmwwSUmACRlEppIX6BKQ8FE2Sz/E2p1JILpNrhKw95rFzJrrTTKzCfCbS2IhcxwLKZ2kQNX3ApB+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207995; c=relaxed/simple;
	bh=37450W6FYAtNA5BvRLzKphD5NkEmloE/RbhaJCvRqSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ln8l/YyJGH9Obc4XywiliVo22I9m0gDRqo+aYiyHsfoxh2lPzVkkeM/3qFfi6aP7/vcyxupDKXi5dJc4YHfcH962kEJ0xL5dE4sfVNzBVaJVzbueulcTNSDMBfRlJT6F30L3bjYoFPYSKzpHP0U+hhjxIjPS8TjhgtHJtBcl16Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReVcyhpQ; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReVcyhpQ"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-48650c78e09so1898137b6e.2
        for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 02:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782207993; cv=none;
        d=google.com; s=arc-20240605;
        b=Oks7dzL9uzLWAoaEo1O4oE2l4Ni9yI6O+E3yGXlwClpbSjjcDh7pMHvSXZaFRRd9OX
         o3ylkosd6C11Pz0kgKYaMDVhkhXxZG4OS2mBa4urnxXuxggCH85hKMUvs2WUdyJ10Q6V
         98pc8Ns0L09UsCdIzZdNKUsAgRUDyuF2YArqR4s+/G4ymmlpcoSnbxUkEe7cyOTtYdJ8
         RbX7S8lRghucJZdhRTQcUCM24s6rQy9bhE4Aaw190LZXMbV4MvvB6BDdGTD5TUFx+X7u
         nTKLrvA2vHfZlHYM9BmZYNMG+C5qjkz8637D2MRPpjl8yMzqILGY98xckQ/HwsUn+FoW
         lpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yv0BeALdClipLyUvwU4pgEmX5q0tg0SvoPTdnQsLUIM=;
        fh=+TkQ2ObGm+oqoW0BmjylRnCH/6N8WTmPT8+U4qvF/xA=;
        b=KNAyq1TE4gAsGMZSEudQ0hJl37FhXEILWMoHtyDLnhcZ+SfRPGJsUQtnIX2XfahVRJ
         i9wlSi5at7QFx/Qeig76JU5UFDuOHYjmBt/YzYEZpJUqtEtxcC+sp/RJ2M6sCIL+Ehc9
         UCGRvdeeuOaN95Tt65S9xezTNW7LPD5FolYV9ffmfvcWKEIt3czrFa3r3GQoSk3AIc2v
         8MccGX5BMUyq+9pP7z/LWf/HHw807VCUXyfX0GzosdqyZVxlXvM0xxs2RkQoIfNP6MXx
         jECSD2YPMW+whpq73/q4FAT0DZ3gTkz986q/qtSZ8OvNsXeVJX4M4uJ28uaEUjWARbPs
         WLbA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782207993; x=1782812793; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yv0BeALdClipLyUvwU4pgEmX5q0tg0SvoPTdnQsLUIM=;
        b=ReVcyhpQr+DYqbssGJfJOAXc/ZWk09NXllSVR/o6FHa4/NK+gRTaFzj/XVikYJM9tB
         vGIDxLT6OnZgYFgrEwUzpCps74qwlcIh3iraSu/KdLx4oSBRznh4S3kkqIyZ58xGhqsM
         f8hr9c1dVumnB7nxvnjluEVvbihnmGAGRMqQP4Grjq+LPiifNOE22Q3lNq6lrfbaEMbf
         300hNyi+1c4eaHrKK9i8InP4FUW4Uc23NWz31KECqRkAf/gCwNw+siLxuO6sHMIZCg2Z
         Bb2EVcvg5Z4RWZdqXpwqJhY9hWdfsH4H5ZMnUntUSlpRwGMibVCagdsm+s3QHr6Fdbwv
         Rnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782207993; x=1782812793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yv0BeALdClipLyUvwU4pgEmX5q0tg0SvoPTdnQsLUIM=;
        b=j9/muzGzDLjzH4JR5be78TRlvmAL7+/Hb13j40noVn629BdbKjLsECamccFdqX1YJJ
         WYLbGhTJ8Sh7RhhI84h8Zop1Q/EddOJwMhtmNscpfEvu0TWVio8bvHGh7Z0UjR8nw/27
         4bIGwrJoRsPrEFm+1ip4ZqCMivmfSmWzlEjkXSww3upX7tbnL/FK5KvK9jsrcdjTF1jI
         Nx2higqKngw4d1HKpOYsrqibQYlD6JTfxI+iRrX8k4EvfZNFEsY1ZYqXKyUgxQTAN+CQ
         LIAhLkGz9/t6cZS/mpfIHdnqypcG2n1BYXVhtGZriNg2XxNX8eV4eNC1BrOSK8ov7CQz
         BasQ==
X-Forwarded-Encrypted: i=1; AFNElJ/uEMKUKCl75aU4UFr+XGFmmgB53hHMFQY6cMIaH0LSemSEEdJckfJoEfwo/w/2Xmmd3sBW/sPieL8rTSN6Eg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwrWdiapndI26Ry6Rr6lX8Q5I12wkgcViSq8tmyVWNUbpM3aML
	XjumQo4K0meXulHmauvLTzJC/g5WX/KdVNE8OzKHOs4guWq85zl/g6TvtendK/Qsti2tMaK1710
	U/fGDgq0u1ipdwkfWymigB67Inv45kek=
X-Gm-Gg: AfdE7clCWzmwjWt5OhixOyiZY2dtSiNP0spsheWjBjGwBIrPBLJnZ1apwxXFaaxdDov
	GsGyF2D9GPAymMU/5aqdUFvYfG5EfHpCewK1txlqTcNhvbxAijBr+6jZw/2emW5SeZ5uKumsaJw
	iddiQU+blTUrdA/SWl5ay1HQD+fpGk9KMUDWOlWdD+6HvPEuVfqxZQJpqGCUoEq74tcSmuTrMYC
	1vzidB34vVu2o2/OUEXWnfwO+pbI6iuwH+Tn7ZnYsDgSR5tC2o+j0Batz2n4DjasQUb8Dyi1Y4=
X-Received: by 2002:a05:6808:11c9:b0:48b:9987:ba17 with SMTP id
 5614622812f47-48f62c24e11mr798270b6e.35.1782207993042; Tue, 23 Jun 2026
 02:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260621130246.2973254-1-me@linux.beauty> <20260621130246.2973254-2-me@linux.beauty>
In-Reply-To: <20260621130246.2973254-2-me@linux.beauty>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 23 Jun 2026 11:46:20 +0200
X-Gm-Features: AVVi8CdODMw4si1bRIcvd7rg71p9Rlcb8aYNMExjt_doJRdh8NW0AmYupBG3yIE
Message-ID: <CAM9Jb+hf6KEWRKtWr6PQByRQ869jL6Ws7J_ShFjKY_YicTbS_g@mail.gmail.com>
Subject: Re: [PATCH v6 01/12] nvdimm: preserve flush callback errors
To: Li Chen <me@linux.beauty>
Cc: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, virtualization@lists.linux.dev, 
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> nvdimm_flush() currently converts any non-zero provider flush error to
> -EIO. That loses useful errno values from provider callbacks.
>
> A local virtio-pmem mkfs sanity test showed the masking clearly:
>
>   wipefs: /dev/pmem0: cannot flush modified buffers: Input/output error
>   mkfs.ext4: Input/output error while writing out and closing file system
>   nd_region region0: dbg: nvdimm_flush rc=-5
>
> The virtio-pmem callback can return -ENOMEM when async_pmem_flush() fails
> to allocate a child flush bio, but nvdimm_flush() hides that as -EIO before
> pmem_submit_bio() converts it to a block status.
>
> Return the provider callback error directly. The generic flush path still
> returns 0, and pmem_submit_bio() already handles errno-to-blk_status
> conversion for bio completion.
>
> Signed-off-by: Li Chen <me@linux.beauty>
> ---
> v3->v4:
> - New patch.
>
>  drivers/nvdimm/region_devs.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index e35c2e18518f0..0cd96503c0596 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1114,10 +1114,8 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
>
>         if (!nd_region->flush)
>                 rc = generic_nvdimm_flush(nd_region);
> -       else {
> -               if (nd_region->flush(nd_region, bio))
> -                       rc = -EIO;
> -       }
> +       else
> +               rc = nd_region->flush(nd_region, bio);

IIRC this was introduced as a generic populate error type since a
failed flush can also propagate host-side errors, which may not be
relevant to the guest.
That said, we could still consider handling specific cases like
-ENOMEM, unless there is a better approach to address this.

Thanks,
Pankaj
>
>         return rc;
>  }
> --
> 2.52.0
