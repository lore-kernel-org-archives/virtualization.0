Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B1371738
	for <virtualization@lists.linux.dev>; Tue,  7 May 2024 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063076; cv=none; b=CAc15V+ssbFhaYhACiUiNu/C6uOYJxI3Klv0TQWJk5Lr/NIvE0ZgsL2S7sfDjpQ+dzp/aexR+P+pF9VD0by5HcV0KF97t1rfQiXB9IX0qCYvTejRnjNBMwyoDsTqru61qXkGYNW+RmmMq2FohAb+/gA1/YMNDmdP/p5cqVCBrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063076; c=relaxed/simple;
	bh=iRNDmwTixgFgL5VoQXJOy3arsMf7U1r+eJl2pM3HO9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KELKpGXaapDtC5RXJhSCbp+/SiuM7xl5ceIA/1cCEAvs4O6cifd671kbyVlBTjFqwRShitdbptxuy31+zWOEbvhlYhwB2U86GUVkq35PsUKUOF1gLze3momB+NgKQcoMQ0lYnsWAtOXE4nu256llDPgSdXHvI2KQg+rxCngiGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzIeojV2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzIeojV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715063074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ub/tWSU8Fj/o8FTj2YWFwqsvPPAps9DOp+ciPg98a0=;
	b=HzIeojV2WUcOSUuApnNPfsz+JcFyMwqHO85AOQpX4veKI26cEyypt7mtlGkbQmfJ0voTcn
	E1X8er16sS9mo1u9lPeKzwtcVSqzOduamitxGXdy58XNCOBcbqRnSExYAzSdbyE4U7FZWo
	2q+zeplY0dEgJlI7eHCZy3xRMV7ZinQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-VCLtvqf0OCCm3iCXLZ_nPw-1; Tue, 07 May 2024 02:24:32 -0400
X-MC-Unique: VCLtvqf0OCCm3iCXLZ_nPw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2b364c4c4b0so3248111a91.1
        for <virtualization@lists.linux.dev>; Mon, 06 May 2024 23:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715063071; x=1715667871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ub/tWSU8Fj/o8FTj2YWFwqsvPPAps9DOp+ciPg98a0=;
        b=Iwt59tz+YY/Rt1k3tG5IhbyLo3Ie2EANIv7wYeax+TuHE6tcSL8jp/g6QJv7UlhZrS
         p7ya59gfitE1mv2xvbaSK8pi1eot5cetLRHZK5FjUKUtRJhCc3j55bDUzDGRusSxCrod
         /CFJUyzxkZ24qm+CvFg3Sw0/lxOH7ILAOJd2M6g0A4VQHDXzTWqm3NCnOBPrL+J5CDsk
         dRrna+loSme8RQU9GjOadnIuc1qx+k0UeWiHQk676TUzmb9dsKY6e0iPOYkUWymeiO+Z
         KEMjgJrWre0EX2k+sBzYuvsH9iIMmSWexD17/LBMHAq/iM8h6JFsmt9tqqPE0A6oBe/X
         Ipvg==
X-Forwarded-Encrypted: i=1; AJvYcCWKquuT8O/G8Fir1i/cZjfFnvL+NHrbTuxrg22B5pNxDJzIqo+WKvISlMVd0mdE8VBUeBLnsDOtk4EXza1MqeVJNZ9tmOIcvzxq3c+yo98=
X-Gm-Message-State: AOJu0YxEJYoJUU2m/SXqd+pWrqZOLwT01xML4jAXSdgZ1ingEDaoE2zO
	w0pMr1oNlc04RQEWlTOyqOI2cAfsSSRg/JhcuzGCDgE+uxdFONmGEUQLgCTFhtBTIHPSTRaJmNw
	DSx2++pWyJScWmW6z8ePEZu3lcKhrEKMErnIB3+88vsoS2I2gfdCpeejIptaiZw8RCbUtgjxx+D
	rI49nT+XNYvRpuRQ6Sattc+IQ8txNwX3OHw67G2wk=
X-Received: by 2002:a17:90b:3146:b0:2ad:fed5:e639 with SMTP id ip6-20020a17090b314600b002adfed5e639mr11902818pjb.9.1715063071581;
        Mon, 06 May 2024 23:24:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcbd70ocCfKWmS+I8L3u4xWmqH+OVg8WgwTwISIvTFxgLD0Q0VQJrBzid2QIXEXsjYtVCdMbLJb/Ii/2LgCcw=
X-Received: by 2002:a17:90b:3146:b0:2ad:fed5:e639 with SMTP id
 ip6-20020a17090b314600b002adfed5e639mr11902804pjb.9.1715063071242; Mon, 06
 May 2024 23:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240426065441.120710-1-hengqi@linux.alibaba.com> <20240426065441.120710-2-hengqi@linux.alibaba.com>
In-Reply-To: <20240426065441.120710-2-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 May 2024 14:24:19 +0800
Message-ID: <CACGkMEvUT_uyLaqi533BUOqCYW1dYZTqdW_CC3-LgQXhhdJYFw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] virtio_net: introduce ability to get
 reply info from device
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:54=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f3899898230=
39724f95bbbd243291ab0064f82
>
> Based on the description provided in the above specification, we have
> enabled the virtio-net driver to support acquiring some response
> information from the device via the CVQ (Control Virtqueue).
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

I wonder if we need to tweak the spec as it has:

"""
Upon disabling and re-enabling a transmit virtqueue, the device MUST
set the coalescing parameters of the virtqueue
to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
command, or, if the driver did not set any TX coalescing parameters,
to 0.
"""

So for reset, this patch tells us the device would have a non-zero
default value.

But spec tolds us after vq reset, it has a zero default value ...

Thanks


> ---
>  drivers/net/virtio_net.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7176b956460b..3bc9b1e621db 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2527,11 +2527,12 @@ static int virtnet_tx_resize(struct virtnet_info =
*vi,
>   * supported by the hypervisor, as indicated by feature bits, should
>   * never fail unless improperly formatted.
>   */
> -static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 c=
md,
> -                                struct scatterlist *out)
> +static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class=
, u8 cmd,
> +                                      struct scatterlist *out,
> +                                      struct scatterlist *in)
>  {
> -       struct scatterlist *sgs[4], hdr, stat;
> -       unsigned out_num =3D 0, tmp;
> +       struct scatterlist *sgs[5], hdr, stat;
> +       u32 out_num =3D 0, tmp, in_num =3D 0;
>         int ret;
>
>         /* Caller should know better */
> @@ -2549,10 +2550,13 @@ static bool virtnet_send_command(struct virtnet_i=
nfo *vi, u8 class, u8 cmd,
>
>         /* Add return status. */
>         sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status));
> -       sgs[out_num] =3D &stat;
> +       sgs[out_num + in_num++] =3D &stat;
>
> -       BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
> -       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMI=
C);
> +       if (in)
> +               sgs[out_num + in_num++] =3D in;
> +
> +       BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
> +       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_=
ATOMIC);
>         if (ret < 0) {
>                 dev_warn(&vi->vdev->dev,
>                          "Failed to add sgs for command vq: %d\n.", ret);
> @@ -2574,6 +2578,12 @@ static bool virtnet_send_command(struct virtnet_in=
fo *vi, u8 class, u8 cmd,
>         return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
>  }
>
> +static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 c=
md,
> +                                struct scatterlist *out)
> +{
> +       return virtnet_send_command_reply(vi, class, cmd, out, NULL);
> +}
> +
>  static int virtnet_set_mac_address(struct net_device *dev, void *p)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
> --
> 2.32.0.3.g01195cf9f
>

