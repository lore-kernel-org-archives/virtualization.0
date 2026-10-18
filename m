Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9E43F106D
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342822; cv=pass; b=nBryDYCpeycyqeAZ3ElxtO17hG1XLs9WxeSZ/uJq8VhM+AMFlkb4swkXkcuKuMxgTT/00Z49F5KHoPmfwlamGaMLWbVlxFcsK1rz5amjpRjOS2ddTOoSY/q15ceIic6ePpvQAZMBxlLFHBx9HGst5bXTVv4ZAzIcrc4Dpenu4WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342822; c=relaxed/simple;
	bh=g/JGIrVbzY2CScB/KpNY8unmxw00ClvPmppC33lSWpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivzLy/llhxl3NDP34NmJdV+swd7fwn2pU8eEx9otsS3DxUMoFW1w/uAfYZdvsuH84Aoe9oFkEAc5FyqFyjCtjdbkBFJhV58qoQpsYZs+O6ZjgmfxJNqnGeZFFTywrHCXB0YX3/DSkSI8lFIf6WrWq8sAeXnNEvdkL6Y0UoES1nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXhe3vwj; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXhe3vwj"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c40f29667e6so34830266b.0
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 10:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792342819; cv=none;
        d=google.com; s=arc-20260327;
        b=nSxulYpwifR/xc4AsNTzOaGpcAbHH44RzsLu0a2TeOQN5sQpX7NbZKnUU5M3z+p6XA
         Ju4JWuCwOcRVnKOEo7JaB34NbN91GkQiTByVLIV1I50QZS3bAnw5trP6rNpmu3Ub5807
         Di1Y4AM5G48kkp2c+6J8SMzuTVfqS28U1clXPOYaGAMrHo/FIJppN/LozYdbYWosaVyU
         nT9l/Oe0OC6qlSJJl+fnCR5Lja+Vvg8IOAAOHj3XaJbdOdc54sLn7CAQh5heatFReDO2
         0MxZrYJvq+daeTrVaz7yzSZ1H9rcsdcz3yQiT0QCM5SkpEGzPrQT1HnJ6mtkw6bq8h9g
         2WHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2/1Y5ghSBlEp/00kqDwKjo69e3DTVuqhYG4tCNcmd4Y=;
        fh=9sSJx5eGKOc9DGsT52egNF+Sg3FzJcPq5+sxbZSRMVM=;
        b=RRkKm7nyFX50MHA456Wkg2nptOGGcBw0CfQgF0doAFSv7ePZAXUTZ+zxhqyzI9LDVe
         i9GNmzfXIDEozbCQiW8TLxq+wUiXGjWfpEMsU95HZY3aA7QJia4zIcNyN6HZ23qB4A8h
         POARYfvWacoc57Sm57XakCM/DJeUIOOIh6nggFxI31ze46Kgx9lHg3wVuILFpjf8py20
         /AJEJZTrelxj+y3lGuizciJRLKeDYphmIUoquCUk+K1+6m5tuN6YehirG8Fytb6s9kTt
         N4iBu4QWulRCCkDTSrmBRtBaGA9xsqD7op2JQdcvN8QQkVjpLdI/bM3/qiSDhxSnSQ6F
         2kwQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792342819; x=1792947619; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2/1Y5ghSBlEp/00kqDwKjo69e3DTVuqhYG4tCNcmd4Y=;
        b=fXhe3vwjm8Wav1qBK+qyxgA+JeulNxJczfmV0pnqcUGyIt1ofIPH+ROJOdRfl9eiYS
         C6FXOXoG7fFBYjuYEivPAJMpie3tH3DtYYU8wxPU2cFZdDInCsoE0KMIiNDfnNY713nF
         yrcbmyU3OTRFLWIlPyr/9vnMNARYg3UY6TSvMF6v5s3xjqbxuo/dtb46k/sBwLxlKfTy
         1iRO/lU5J1rnJSTA2ototSrvZHM+sHUFIn4NCu9tAN5R1Z/dlXbUkYgT9KTdTMPUYNzB
         /MbLtnP/OILMUGfSq6iSLwX8wPPCUK4pIFHlwt+4Gmg3cxseYLyY0rO484PbT73NDbzq
         MWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792342819; x=1792947619;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2/1Y5ghSBlEp/00kqDwKjo69e3DTVuqhYG4tCNcmd4Y=;
        b=bP0v+PKWSK5vXfgq7XFSGf4rq44lL2gk9rgxeeQubWhWCRPGcyBcPdj5hc61vlIRil
         aSgcIgf3h3UAQllgitlYz+mpTJmBv0JNo+QnF7ApxJDvZHr1WI0qk/F50qzhWysZ2tLY
         l0cD8w0bf+7uQ85x+cOjwwB+N3JjVgmMsE4K+ybtQPm3d6n4Y4ouChWg+vlCaZw0bTOZ
         bXIrC1qLxnCgokciUz/QP2MHI0g8YWPefn8MYNJneyPDxEh+/eWOgbqudKqCVyALTGja
         Q21bps8dZ7h3USX5rbKrCbW+4cN6HYp8oLoHJraP8KyLTNxY1O1W85GweCAForknvCN6
         UrYQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0RndSFFOU9QGdrsgxRhMwycFMO+/e6dnaUpbzc2pS9Hqbkrm5Q0hZfpFmT4wneNUzDsU27qE8emGrh0AUvw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJGYTLicyxKc3gaKmIBcSVnc7cyFIayvUBqsupqdLmqoBILEaGf
	mOtn5EvfPNfe9XelQMlVEGKbpNqPgAexIyD1ldNYKLAtQfIxKwErX20fpR36DPER9Yze1p/aQ3r
	sWEqg0O5IcsRAunP3PsSykVrv/TN6zKM=
X-Gm-Gg: AYBFou1rYjy336rGYZLgPz7WmhCGaL19NToIL5JJAMEUDuLQv5eBjqvEIMTsBMiTC8b
	t2HT57tgAzVPabfwebCN1bMGg2hwfN/HKzhGEuZ4q95QktDTk5oXovbftR/YkiUzp3NSB1m1UzT
	t5FniheyKAjOa52J/CW59NjnH8wPRHjjNG2J8m9Mj/u6oMocrHs32ioROuHM4uZxZJYzBR5mXl6
	gRudwQ5NHEr2lL3AcylTXAMEZijzJBbrOfea0SxZbo1UtTpfOMITPQaHh22mK1876b9Y4BAwmLL
	48FYFSpZTK5qpcT1KQgTdYu5XZOdNI8LAQQjHDlXJQ4PG5vQE8ZWIjC+rnGNa45HKqGJUggqyG1
	MzdftT5TCqTReLqVKsCDA5SXHrUzWPFdRiA==
X-Received: by 2002:a17:906:f597:b0:c41:55b4:d88b with SMTP id
 a640c23a62f3a-c41a00f1a94mr354678866b.43.1792342818130; Sun, 18 Oct 2026
 10:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261016103640.4989-2-blum@kernel.org>
In-Reply-To: <20261016103640.4989-2-blum@kernel.org>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Sun, 18 Oct 2026 22:30:08 +0530
X-Gm-Features: AclHuK-nQ7ZtqX-oks4iRGuLf-PLYl2NcnCVNUFe0eh8h6uUfoXPMhFqyj8drsU
Message-ID: <CANc+2y7ruqmfO+D_nfdc9rnBE0uSSnZR9UJY2Dvc5Nez9U-61Q@mail.gmail.com>
Subject: Re: [PATCH] hwrng: virtio - prevent use-after-free after a failed restore
To: Thorsten Blum <blum@kernel.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Rusty Russell <rusty@rustcorp.com.au>, 
	Amos Kong <akong@redhat.com>, virtualization@lists.linux.dev, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thorsten,

On Fri, 16 Oct 2026 at 16:16, Thorsten Blum <blum@kernel.org> wrote:
>
> remove_common() frees the driver data during freeze, but does not clear
> vdev->priv, which points to freed memory. If probe_common() then fails
> during restore, a later remove or freeze can dereference the dangling
> pointer.
>
> Clear vdev->priv on the probe_common() error cleanup path and before
> freeing the driver data in remove_common(). Also reset the device and
> return early from remove_common() if vdev->priv is already NULL for a
> safe teardown after a failed restore.
>
> Fixes: 08e53fbdb85c ("virtio-rng: support multiple virtio-rng devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  drivers/char/hw_random/virtio-rng.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index 5e83ffa105e4..a9ff520975a7 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -190,6 +190,7 @@ static int probe_common(struct virtio_device *vdev)
>  err_find:
>         ida_free(&rng_index_ida, index);
>  err_ida:
> +       vdev->priv = NULL;
>         kfree(vi);
>         return err;
>  }
> @@ -198,6 +199,11 @@ static void remove_common(struct virtio_device *vdev)
>  {
>         struct virtrng_info *vi = vdev->priv;
>
> +       if (!vi) {
> +               virtio_reset_device(vdev);
> +               return;
> +       }
> +

The virtio_reset_device() is always called before setting vdev->priv
to NULL. So the virtio device is already quiesced, no need to do early
return. Isn't it?

>         vi->hwrng_removed = true;
>         vi->data_avail = 0;
>         vi->data_idx = 0;
> @@ -207,6 +213,7 @@ static void remove_common(struct virtio_device *vdev)
>         virtio_reset_device(vdev);
>         vdev->config->del_vqs(vdev);
>         ida_free(&rng_index_ida, vi->index);
> +       vdev->priv = NULL;
>         kfree(vi);
>  }
>
>

The rest of the hunks are fine.

Thanks,
PrasannaKumar
