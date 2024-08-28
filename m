Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB257E574
	for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861112; cv=none; b=MbK6kshYSFksU2QvFFOwfLEAOJv8uroJBaCO/BccZJXiw7z2akbmF2g/TbvFPvpReJC+OYY7uCzU5QH4lI7n5eQlb4B1hVIuhE5U9QyWGnd+b8zYwdlHGQllBMgJAIy2PYq94KJ3qOQ3f7sHrpLPdodr0yEixFdHc54+R1ENCBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861112; c=relaxed/simple;
	bh=kIvr0x/nLPwcvuNSrLnV/abx0d5b4l7BDKhzSArNKc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTwBMPmrCitYO5J1/kZYiCUU+DMAt+tw+UDo0vW8IfDNq55qz5UI6+udeAi2tf8Zn+W2tYxdA4yWA9b0HeHJpUxEDqVRPzAV1qrpdE8U+wgWQlHp/Yh8v0TTHZXxnBoXd0nB3KEZlwUzrrW0ePTo4hR4OwWyeR7yix736HI6QCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=E7b1wN7I; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="E7b1wN7I"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bf0261f162so8156294a12.0
        for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724861105; x=1725465905; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oWkcdaOAAFvORBpXPTZdmIkf436AaVmj4duMnhZD0fE=;
        b=E7b1wN7IJ/NBFJdXTyYB0lJ7YUvHDYWmewMKfmkBJfs02xjzWbEdx+DTkR3PWKGUcl
         PDFuoXbvTg+DC9zZNqXlQeK5R4APU3DHzBROFMomCw3xP5SRaNAhSY8b0Np+IU/TQY3s
         SWeu5In2YTCqAkzVvVYhsanL66lATjX77spko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724861105; x=1725465905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWkcdaOAAFvORBpXPTZdmIkf436AaVmj4duMnhZD0fE=;
        b=IM4mk3lFXahVKcWOfHzBcELRHxaTBfNBnkswvnQP0sxs0szp8dGIA5vgsybO/7wDHD
         zkkLMEOLIFc/CPUF+8u72RJVuhJmhPQM9DwEPpqAovU1tKd8olCSLJ0bLgy58Nc/2LSV
         +k0+qwJOCVvr6ITY1kwZkNHSmG7MnUQTv4FxIPy4oyABbeVCl2OlUOzEbOokiMES4/Ga
         sI9S9Bfhfo/zUcV68v2HX5/cLxcJyT+Da7Ioeqrue5WlqV7aGTp3Hr/F9E73/yV3WbqM
         hOZzEJX9T2P3qj7cI5srxVEgj45a/BIHcd5pYsHWKoaj3F8FeSkLoBCwlCjQyrFXvvy5
         HSBA==
X-Gm-Message-State: AOJu0YwEUhxNWcPEuv8zIXHEv7rGh/GEO/yxpuhXv7rEL9vOe8lYdXSw
	M+xWmmjOaXsEyBuCo+WY5vQv8D2LbsTqk2LtTE2CIf1RnDxb4Q3O8vFVXHnNm6ce5w17DGuzAP/
	Xl9IztGYT0AJzYRjlNPDtzBgQSwD20YTntuBs0A==
X-Google-Smtp-Source: AGHT+IEd/j5L+4NMEp8J6xc7168AIhIlNU3X4m8er/5Tes73NiKJtkogh9BrRV6y9JwR/TOVA2CoOFxCnpSddq7kcAA=
X-Received: by 2002:a17:907:d3cd:b0:a86:8a89:3d7e with SMTP id
 a640c23a62f3a-a86a52cced3mr1304461466b.41.1724861104742; Wed, 28 Aug 2024
 09:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240517190435.152096-1-pgootzen@nvidia.com> <20240517190435.152096-2-pgootzen@nvidia.com>
In-Reply-To: <20240517190435.152096-2-pgootzen@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Aug 2024 18:04:53 +0200
Message-ID: <CAJfpegtbdLeKSWXRtqqS__jbMiUwBGzvv-tu4=RAOZWBdzA3fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-fs: let -ENOMEM bubble up or burst gently
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: virtualization@lists.linux.dev, vgoyal@redhat.com, stefanha@redhat.com, 
	mst@redhat.com, dgilbert@redhat.com, yorayz@nvidia.com, mgurtovoy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 May 2024 at 21:05, Peter-Jan Gootzen <pgootzen@nvidia.com> wrote:
>
> Currently, when the enqueueing of a request or forget operation fails
> with -ENOMEM, the enqueueing is retried after a timeout. This patch
> removes this behavior and treats -ENOMEM in these scenarios like any
> other error. By bubbling up the error to user space in the case of a
> request, and by dropping the operation in case of a forget. This
> behavior matches that of the FUSE layer above, and also simplifies the
> error handling. The latter will come in handy for upcoming patches that
> optimize the retrying of operations in case of -ENOSPC.
>
> Signed-off-by: Peter-Jan Gootzen <pgootzen@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Yoray Zack <yorayz@nvidia.com>
> ---
>  fs/fuse/virtio_fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8ffa4f063a37..55126df202d6 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -447,7 +447,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>
>                 ret = virtio_fs_enqueue_req(fsvq, req, true);
>                 if (ret < 0) {
> -                       if (ret == -ENOMEM || ret == -ENOSPC) {
> +                       if (ret == -ENOSPC) {
>                                 spin_lock(&fsvq->lock);
>                                 list_add_tail(&req->list, &fsvq->queued_reqs);
>                                 schedule_delayed_work(&fsvq->dispatch_work,
> @@ -494,7 +494,7 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
>
>         ret = virtqueue_add_outbuf(vq, &sg, 1, forget, GFP_ATOMIC);
>         if (ret < 0) {
> -               if (ret == -ENOMEM || ret == -ENOSPC) {
> +               if (ret == -ENOSPC) {

Wasn't retrying on ENOMEM added because GFP_ATOMIC can fail with a
significantly larger probability?

Thanks,
Miklos
