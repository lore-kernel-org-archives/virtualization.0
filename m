Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212FBC129
	for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729369; cv=none; b=OdVyRx4/snOuZLpQf64FbmTR0czIC07UqLpoxrkVNyGsRwFrrMz7KQzA1QKZoWCjvPSiEWiTjqlhTSW6vhLwSLM9kwyZ2lgqlYi2sGPGEITi9ODmh97P2Ed+zFsddcffA4Q6azuQ9ShyN9r8pxMa8BblMQeRgk5NOpEnYhm97KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729369; c=relaxed/simple;
	bh=dIQqCW4vXQ8LoM7WsnlboTXmHceZ6q4uVBsb5+MjBeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnF42wdw5BPnx4bQ+xke6PciCL1Lw1eiQel/3X9gnjaYAB20hC07+SgKgtcg9zPIxeh0S8noEMUEt4F68RxjXAHEtZJt6MUViFMmstK5tvrdqcn+jSzM4jIdxVzwMV4CYlLilia2yWu6giXEGPkrHMJNLg8QoN6JTiqwqFOT+9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRPwZ/tT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRPwZ/tT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712729367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpUDa2UySzZ6xNtAKKwlmJjaVp8SzowsTqBfpIs3GWw=;
	b=ZRPwZ/tTxdt9xDZ70lFRFsckrCGvknIYouCv4nqaOFbYWq3pOMI84mvR7+BVEpS5kWIXxI
	eJnrNRRG7A1nALbr+s1goZFw97q4PEs6JAbvhiySVurTujqAP4vzLSBBrr5nx4ICG2J5ks
	RD4aOQv2FzCtJZofK65yy50AbMTgp8I=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-TXp3UqesPjO0FgLyYqImqQ-1; Wed, 10 Apr 2024 02:09:25 -0400
X-MC-Unique: TXp3UqesPjO0FgLyYqImqQ-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5aa33fd1935so4099074eaf.2
        for <virtualization@lists.linux.dev>; Tue, 09 Apr 2024 23:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712729365; x=1713334165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpUDa2UySzZ6xNtAKKwlmJjaVp8SzowsTqBfpIs3GWw=;
        b=a6F2gAWy/10lR3qZg49PAexVEtVVBxpFztiWr38t4fWbVo2234GKQ954albAvkgGQV
         4sPkw4jPkVgMQG5njPV5QGLKK8V9AZMtgAPhJMpslwZNY6g1K3AeO3X7whVMeqo3P7Qq
         BWa3AtrufwgMYNbnuIvBE/WDyqQ9RHmcA5dLstBbjgrLnvkErXVpOiMtnPKeTS4FnCVO
         MGrywLmxCoxZCgHjmy/f6MfSIljizBKUgNp1OnDOnRAEMThh2BpBMzmP+V14WUp4horg
         3fuqliXOcwUa8Ye2uIlgmBZS6H54mPA/ueueazfgLNazFDSZUIVd77QoCbmYouhJxkRK
         IJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCWKICSKV8h3Hn7NS+w65l0iPAuix8yhafgvVvWZBNkG+4GFXnP5fgrlGxqc/vF7dd7BjigqlBOrtopzlAV54rodK4Mjm0E2Nk/jLbl0Hes=
X-Gm-Message-State: AOJu0YycUaNC5+wVA6VBHmv/t8VWX/dJ2lmQncluspcsvO8CWIL0J7LJ
	Qqsrhs0e8M85NQHs9lfCneW/5e3ZSHDmzVPlBaUBxAmXfinOWgYCLXXUM9+lSvYfa902TCse4Gj
	g2eo9NzE4O3yaRocTrGh6blMRy5bg2ROGE5J3MLkbjcZuOxlrPsvUK8E8S1li2FMqCNU7srP9RM
	PjhCrRhOF593K+9MuC/nJjUSWwpNWSLwG2inqa0YA=
X-Received: by 2002:a05:6358:4b45:b0:183:9ea4:74ab with SMTP id ks5-20020a0563584b4500b001839ea474abmr2134339rwc.31.1712729365209;
        Tue, 09 Apr 2024 23:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd6cDUF6ppyja4kOtkluO3wddXwNXimvcjissix6p7JvRj9JHcaaOGJT1Jjj9iErmie7vMc+YqpALeBXrbmY0=
X-Received: by 2002:a05:6358:4b45:b0:183:9ea4:74ab with SMTP id
 ks5-20020a0563584b4500b001839ea474abmr2134319rwc.31.1712729364897; Tue, 09
 Apr 2024 23:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com> <20240318110602.37166-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240318110602.37166-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Apr 2024 14:09:11 +0800
Message-ID: <CACGkMEt_RYQMLpZOYe6MhhxeH8xpzKUJE-UCthBCr+7JgD6V1g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/9] virtio_net: virtnet_send_command supports command-specific-result
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f3899898230=
39724f95bbbd243291ab0064f82
>
> The virtnet cvq supports to get result from the device.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 47 +++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..af512d85cd5b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2512,10 +2512,11 @@ static int virtnet_tx_resize(struct virtnet_info =
*vi,
>   * never fail unless improperly formatted.
>   */
>  static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 c=
md,
> -                                struct scatterlist *out)
> +                                struct scatterlist *out,
> +                                struct scatterlist *in)
>  {
> -       struct scatterlist *sgs[4], hdr, stat;
> -       unsigned out_num =3D 0, tmp;
> +       struct scatterlist *sgs[5], hdr, stat;
> +       u32 out_num =3D 0, tmp, in_num =3D 0;
>         int ret;
>
>         /* Caller should know better */
> @@ -2533,10 +2534,13 @@ static bool virtnet_send_command(struct virtnet_i=
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
> @@ -2578,7 +2582,8 @@ static int virtnet_set_mac_address(struct net_devic=
e *dev, void *p)
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
>                 sg_init_one(&sg, addr->sa_data, dev->addr_len);
>                 if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
> -                                         VIRTIO_NET_CTRL_MAC_ADDR_SET, &=
sg)) {
> +                                         VIRTIO_NET_CTRL_MAC_ADDR_SET,
> +                                         &sg, NULL)) {
>                         dev_warn(&vdev->dev,
>                                  "Failed to set mac address by vq command=
.\n");
>                         ret =3D -EINVAL;
> @@ -2647,7 +2652,7 @@ static void virtnet_ack_link_announce(struct virtne=
t_info *vi)
>  {
>         rtnl_lock();
>         if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_ANNOUNCE,
> -                                 VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL))
> +                                 VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL, NUL=
L))

Nit: It might be better to introduce a virtnet_send_command_reply()
and let virtnet_send_command() call it as in=3DNULL to simplify the
changes.

Others look good.

Thanks

