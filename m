Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531A36894B
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787106158; cv=pass; b=QGGM5IuqbQXH8vfn/KnHOg87az3mSrVEf4CU5uO8eMKKKCgyjoSrnJao6qf1Skvjsx9Y26afuhmZ1LmtOJTOQuyoP7Ib8Kd+WlKePg1yzD47TTprMuDzWzsRpVGhydz5K3JtjE26QJzCLvzXzICaoqZFGcIAlgynQEHuLzmevZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787106158; c=relaxed/simple;
	bh=5GYdROF3y/KvoZOEokyr7HJNK+G6/Ew2bTh6+vySWoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gb7Mov9vokO2T7eO+TArmWnTckrhRlH/o4ceo2d9uNEN6tjG9n86uM0Pdq2+kuMM90LijNCKRxByxzH0Y2/o9+eCDha1+ZmANTqckYJKZ7sLYEnoui+SGjk7p+uxzBgIC7O0AQMzih6o0C7oC5saqb6XcPDg4m0NirR2FgyD6Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqYxY94D; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqYxY94D"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e99ef0902so32839485a.2
        for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 19:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787106155; cv=none;
        d=google.com; s=arc-20260327;
        b=A/87hdNkjJU6qEnMZSxr569H4L3jcn09SGrkCa+cZaWlo2eesNT3d/22wwtHLujnwd
         Z+/B/ZxfswZdxZBtinsAp4C7M41xEZ6sA1ICp0uejF8c6T41pMgGoH9YzR5e4D8yZEpz
         fy/hngO9UN3PtiGjDTAiFWmQveq+RV+PGz0HAPanzp2vK7Fx99RLVxSTNFCJI9eQm8ge
         AQoFyIt8Q0SzuCV0cqPb0QoTxXMnE1X3qQASV4iYFwWUHqSMKtwlziIvgFIFvDmEW9fv
         91Ro/P5aW33c2atUxHYk8rCcS/Tw66TfALzDv1ATbjbI1dAnrL7vfjZJJw9HRJMxGDhd
         9k9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gpRJv4Mp23YkEXUctQWMGQFThMmtk/9orPPH7o5EEeo=;
        fh=4p1p/JuabEQA23v5GmtCCVbFGPo4zZEoFBbIOEaDi5c=;
        b=VwI6KV+LAxCbsNKgJKUQMvCdknHJ+hLT+JHhwVSOOHQcDR1umwqOh8JhLdvuhYCpmQ
         oUdKyBU2b1LFTASu93pMn8SpDqJ1E6LnlTs/yFUi7PW/6ya48/vkAyOxq1kXpLhBY2FD
         VioZWMqbsTASu+uBakq9H5YW4ZbtUPwSVx7sraAGKSnuhXidAsxO1YVOkiifl6sc7sTC
         q5q+vjAkuyW/8vawmUQnPM8HWdYoU9qZ1Pu2PdgU0ov6moobo8Cv2P3nR0hEJRqEBZhT
         ATR+XZPBZexNwWV1movEWFMmqVIrxaU5szEEF95xf6rIYEVa2Y2mnLEG0EOCdLucxsWj
         t6XQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787106155; x=1787710955; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gpRJv4Mp23YkEXUctQWMGQFThMmtk/9orPPH7o5EEeo=;
        b=OqYxY94DiPle3odXFvffmRjAA4Vtji3kJbOFfNjVcq7IQEFCWXGHRXuhcMcOCoaEi3
         ksDhrpjcmS5vDkitiOnmQdIZNNz4eYEE38lxnLX/YX8ikROvuEATwOVWKzTQEF30vtrO
         Gg36bJFMl5vdcon4y6QrfU+p9ZuRkowCo4yJ9pdR/0XZq+iNG2s/G/0RP9MfXO5kHGnm
         FoiEKCczZ+Ec0yUojPZU0uiYANKMYk2WpyQ881N+rYV8WCL0tK9Py2rff2Tj9A1IXWC3
         Jm2rG0jwlDV2kcOOpDahk3AIE23mfzLv3hNzWSxnixUmUaIQoooswAEekx07TedmOSyV
         4ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787106155; x=1787710955;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gpRJv4Mp23YkEXUctQWMGQFThMmtk/9orPPH7o5EEeo=;
        b=BDESuZZz9fbxmiPDzbTI+Ll/GxLi9mfgpwIBKfM5hnl1Pv+uJ1GhRVuSPu2EubmEXs
         Bhet38E/zgN3AoZPrI4r6ednD7MMT2EEvDsdBrsIjpNoUlcfr8kp0pmz59to/SiZMQt9
         zv2rdRqa+mLc6LbuuNsyjMeVoaf7G3PLm/3/bvDUnXas5PNgsc+qJfHGRArAqsW9Blbh
         z0x7BsbmKUzSi1LQg9VF/vao+o/+QROTqk0n9Zhb21m1mRm+F1A8Hvy4pXEm1p6dSwIR
         HaEK8rAU5u3NMLaBBQYLQ8SyyoLv9VDbRMMCH/WPVYOtVq8RByjhioiiuTBQxRbKb4Yr
         HsUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbVwt+xIT4a5z/LpGBO5MhjHAss7699xxsi2gXjiCCAgjPyy3dx+Ao7WDMbZqlh7YdBqB8Da9c3KTSy+B86Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDvTyLDApmb1URlw4B2TnUyXkuny14SfywnxRxsvLfnlEAUGoX
	eYb1oCzy9cLpb5fZfdukOlZSxkzNYOKLdg+BYYswKJlyCoE+8TxtGJfbI4OFXotgomzcPF5oOC/
	kdIKl87i4ja1DCSRXm0uHOxZThbObNEY=
X-Gm-Gg: AR+sD13uVkDEt6UfZbfcub52uEQmF2Udzw7fpXxR+Wtn9xcE8qaYygfvD1qdvKWbVBN
	V3pU47EC/QNRGXHDA4tBMGp8kyLz2e5IeQnYMOv1/pZGG/Uha4Z71ibcDJ9Gvf4cqMfo3oq9dlf
	XHpwlDW+gxTkfOHnm3MSKqpL/hdvexYJHfgkwlWKWnnXuKtSVfCF8YR+UQNZI9JKB6FJXQz1D2T
	DxrAOzH8TNHxAzbMLjN8mmHGfxr5Vze2dsGbVnb0gRQfbpuOPSVKoBlbxUoWgnPzzBHvHgipIa7
	1k9os+VHusrs1zIxPat/3KDswcDNkuUTvcQkO6mGIJNgOFWZXbuSP9Uy
X-Received: by 2002:a05:620a:1b86:b0:931:3ff3:30b1 with SMTP id
 af79cd13be357-9371e2036dfmr190855685a.4.1787106154920; Tue, 18 Aug 2026
 19:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260818054709.282196-1-physicalmtea@gmail.com>
In-Reply-To: <20260818054709.282196-1-physicalmtea@gmail.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Wed, 19 Aug 2026 10:21:57 +0800
X-Gm-Features: AcwNN1WMlM3A0kVn0JUwWoFXgehU9bp1VN0RuZWr2DIeBqxYb0PcrHL0eS72BEQ
Message-ID: <CAJwVaM+D_yyU5E7w415HVwG_eMTrv3V6HiXa6Jc3wboWZJxs-w@mail.gmail.com>
Subject: Re: [PATCH] virtio_console: do not free control-out buffers on remove
To: amit@kernel.org, mst@redhat.com, jasowangio@gmail.com
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, arnd@arndb.de, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> __send_control_msg() publishes &portdev->cpkt as the control-out
> virtqueue cookie. remove_vqs() walks every virtqueue and passes leftover
> cookies to free_buf(), which treats them as struct port_buffer and
> reads sgpages.
>
> If a control message is still on c_ovq when the device is unbound,
> free_buf() reads past the ports_device object.
>
> KASAN reported the use through:
>
>         free_buf
>         remove_vqs
>         virtcons_remove
>         unbind_store
>
> Drain c_ovq without freeing. The packet lives in portdev and is released
> with it.
>
> Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  drivers/char/virtio_console.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 9a33217c68d9..6e9bf064826e 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1886,10 +1886,24 @@ static void remove_vqs(struct ports_device *portdev)
>
>         virtio_device_for_each_vq(portdev->vdev, vq) {
>                 struct port_buffer *buf;
> +               unsigned int len;
>
> -               flush_bufs(vq, true);
> -               while ((buf = virtqueue_detach_unused_buf(vq)))
> -                       free_buf(buf, true);
> +               /*
> +                * c_ovq cookies are &portdev->cpkt, not port_buffer.
> +                * Detach them but do not free_buf().
> +                */
> +               if (vq == portdev->c_ovq) {

The non-multiport case was not considered here; fixed in PATCH v2.

> +                       spin_lock(&portdev->c_ovq_lock);
> +                       while (virtqueue_get_buf(vq, &len))
> +                               ;
> +                       while (virtqueue_detach_unused_buf(vq))
> +                               ;
> +                       spin_unlock(&portdev->c_ovq_lock);
> +               } else {
> +                       flush_bufs(vq, true);
> +                       while ((buf = virtqueue_detach_unused_buf(vq)))
> +                               free_buf(buf, true);
> +               }
>                 cond_resched();
>         }
>         portdev->vdev->config->del_vqs(portdev->vdev);
> --
> 2.34.1
