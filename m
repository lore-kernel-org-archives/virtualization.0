Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419B63115
	for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100077; cv=none; b=YNNvaJlCTSkMfJLTxErCL7j6eRQ+bih6MX6gSSyqQUQ/577YaLMAckeg3h6Hcoq9xH4zR/zgVHYacFHepfRiQsrGO+6v+Tb8HH4LOKG+Id9YgUkiKTX840gkuJ48K4cwujGqO8JEauMnF/0p2C071p+pkIMxCs2pxsz+Lx8Cfn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100077; c=relaxed/simple;
	bh=PVbbIatoT6RIiV5abSmqSSxIjHXSV6lYXkgNUI5+2gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHRj+9AmtGQtiFCZAWzDUedRhvdusTxvxNQZnk1GkbwdBSj71ebvifdQosl/grphmFtOAtYiVPwNSZMrIf0sSnkO90k4vdpU42fw5FKQfXEzKGjMn5KJw0YA3gcozrahUC2QjIVt4PTjquJfFmXru4kdfYtcMFHzCMROrpeodTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amZSLJQn; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amZSLJQn"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5986cb7bb61so3013598eaf.2
        for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 04:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706100075; x=1706704875; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AnkwrxW5Z4yXDJPF85seO+gGhJZrClAeKefqDE27GA8=;
        b=amZSLJQn5HkRNEA3ULzAZUFBfd/VxubaM1V//So6XiT9FLd8gIOmjy1vMivP8+4e/h
         f7ld2WvVXtgoZjlGJ+80Gh2gmRW8var/dn5Ry/LyAx7dq+mvWn/v0MLVAK3n1Y5yQ7Cq
         ggKlfTQ1B1a+Gq3UlXHY6qgq6I31s+LmcZ4a0kBSEwQbcapjfm4v+oEGq0iWxTaeSJ9+
         6nv+jKoNZzIF44CaiJPyBcqo4JOCM7gS1GLnnfBuwIlJIbkMsbo4YirtV9JVckKQ4jfn
         zy3PcCJKYHFsLOOPUIpnbk2PexVa1If9RkSun853knTvdD29/X86vWhKs2SNRd+6MMC4
         5Sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706100075; x=1706704875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnkwrxW5Z4yXDJPF85seO+gGhJZrClAeKefqDE27GA8=;
        b=o5FTuWH8RjQ/w24lRZDWUET2LAB9enq2nTRH1j0IZolvsx5GxVrYX8sWqir26hpRR0
         79dV2xBpRoQV+2aCg/mZP1aIEbHW7bt9xu76IpBO5e5hXIMC4yef6FEqu049YZmKgbIR
         A9A5mBExsWxejXDVSqECwpIhspCt2gyd6YS2F6+Zv2Dus0B8nnms4vQ8Sa5kJIxnKtjr
         DU8SL4vnTmdZcIh5W459VgneP+rVsypAFrh5kqqLv1zo8IZ2NQFd+AOkhBzTHZAhUQ78
         8VaGE8+ixJG+ZgDZkQ37rYYHKG764e9g8mLYpcf7mwNe7jPiU54Ijbtp+DmQY17SW5OD
         1w8w==
X-Gm-Message-State: AOJu0YxG2mVYeXcWKR9PqEP82+AkthAFoil7cSFIuYbr6X6OdSdNe6rM
	/q/VoVFCjotH74U5HUQCUFN12dSPxfETSB0H5JAcdOuvJ1QrYThJnD+6q0bTdKKXsG/hOb8Hw1p
	P+KNJo869vinKoVPG14q7Nx38qJaETRdM7ns=
X-Google-Smtp-Source: AGHT+IHg4IGpUO6XoQDqlpM5XvVGIhVLxKeS7j4I6xrHPwtKeYUfNZTpDUhUN4q+4sQkN5vU9g1YLKhr9sun9zL/el0=
X-Received: by 2002:a4a:bd09:0:b0:591:acf8:d08f with SMTP id
 n9-20020a4abd09000000b00591acf8d08fmr1244525oop.11.1706100075456; Wed, 24 Jan
 2024 04:41:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240124121032.8172-1-lirongqing@baidu.com>
In-Reply-To: <20240124121032.8172-1-lirongqing@baidu.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 24 Jan 2024 07:41:03 -0500
Message-ID: <CAJSP0QUEwd+VbYzwkmo0hZc6FPxv-3MTz0n6t6PCKo3Q-C3_8g@mail.gmail.com>
Subject: Re: [PATCH] virtio_crypto: remove duplicate check if queue is broken
To: Li RongQing <lirongqing@baidu.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	arei.gonglei@huawei.com, herbert@gondor.apana.org.au, davem@davemloft.net, 
	virtualization@lists.linux.dev, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 07:27, Li RongQing <lirongqing@baidu.com> wrote:
>
> virtqueue_enable_cb() will call virtqueue_poll() which will check if
> queue is broken at beginning, so remove the virtqueue_is_broken() call
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_core.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> index 43a0838..3607b6f 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -42,8 +42,6 @@ static void virtcrypto_ctrlq_callback(struct virtqueue *vq)
>                         virtio_crypto_ctrlq_callback(vc_ctrl_req);
>                         spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
>                 }
> -               if (unlikely(virtqueue_is_broken(vq)))
> -                       break;
>         } while (!virtqueue_enable_cb(vq));
>         spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
>  }
> --
> 2.9.4
>
>
