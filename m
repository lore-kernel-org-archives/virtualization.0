Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0A2F83A1
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769414651; cv=none; b=ur7jinLG6GvzEsaRUqgNycya4C1L9eaKoJW08+qV0HfZgYRqVhQTKi3qOaYzqNLIk4ccoNOrFag0UD3L8tCkOwkx9cXvdCX8Q82KFZ1pwX6WZhw5Dqw8OT8cB/nGXlyGUel448RsUrBw2c3uDdKBzaRcOfcUQuGh8ZS2XKjlEJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769414651; c=relaxed/simple;
	bh=CWGx5SwOqaT/YlaB3Ps9+tQ+33m439GlJ4rNP6yIH50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xon2SElcpnYbFGaIZrHrdzwC6JMpWswgcenUeiP+ji9Li7W8grBqHppEt+hgvA1R1r1WdmuuIrwnq54JcLHgN1hmpcjwG8/0ZYzhb8X83N1TAkXI+2vK6RDHe1kRfXFHloPBJj42alfRCEOfzCKkCOcy033ZHSRajrzD8C+lHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYR+TB61; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYR+TB61"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 855A2818E6
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 08:04:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c20eq4LATX5V for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jan 2026 08:04:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 92EAC81331
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92EAC81331
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cYR+TB61
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 92EAC81331
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 08:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769414646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZQZQO2mxRCQriV7DA3Ln3qIIcNBZotCw5GdvUiDLcg=;
	b=cYR+TB61whsrhpPlhsZdy82K6780alQ8kRZ1tPoHvFhbuq+Tw4qSDlumGeP+K0VVrXGOdf
	ZJoY2B/UDatUdcamIr0MokrBQAwT14egFZQ8W/DQ9zteblys+vAxbBcriEbmzeYsRLLO8I
	7NlRCT2iZZvhV7LT6zw6/nFFUASc6qk=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-SzGC_TpSN8O2lQAyfZ6DGA-1; Mon, 26 Jan 2026 03:04:04 -0500
X-MC-Unique: SzGC_TpSN8O2lQAyfZ6DGA-1
X-Mimecast-MFC-AGG-ID: SzGC_TpSN8O2lQAyfZ6DGA_1769414644
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9412512e9abso19590044241.3
        for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 00:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769414644; x=1770019444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sZQZQO2mxRCQriV7DA3Ln3qIIcNBZotCw5GdvUiDLcg=;
        b=wcxKNC0VpWsxqkJNHU/2GI/ZFRFA09KBSQmG4xit9v/AKyvE/inmYFhYaHpHKrKWtK
         QDswFlmMxSCjNbyAV/QIvyXYNRNEyUU4zxFjCnIvet+yCxPK2DNG+SgtI0A6ggWpB6c5
         mNqEmxXKn/LmDRqeP4L+fIxdcf2dExU1OiMaigbNk3hA3XpZf0BUxJ7D1QFMuXiDWlXK
         OyaDYCZhPUk2SFsrXbhTSPSuVMzlO/14EQUvwtCv2rpdVil27iZ37nuYWilXGCwMHAzX
         WxdKfZqCUoNPDPgOkDMTN9I8l6pKWLAV7W/LYcVw25/Zzlk1nZTTRvnrBvqNJZAYk07h
         nVOw==
X-Forwarded-Encrypted: i=1; AJvYcCVkjgUTKHYA3U9Pc+OIwtluRA0/BJnUFwa0T36N9nGlfo2aY+D8TKeP7Ozu5JiTdTcV1J0nTHt3RCp8ZYcPjw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwQNs/1PaUXTrNNAu5TRn3e3HXzp9fD59c4nppOHgI2YWhdWdkH
	vLpmU+ER8tm8wOad4MDKjsZ/8puNOVH8Hcx4OF8UxdYcNCUehR7xErWS9kzyfVbmL8vbvlTJvU2
	IxDeLmsmdb18MMWCa55Z2Owz2G6BPGjKwDkPh/d80QBM1E9wf5/F9EdLordULGIe3VB5Ia+0ZNe
	5U/N3OMXdPBM1fp3RrvINPszY2x5pev8DIuczQRlcHPx/CxiZM/GI7snpPQQ==
X-Gm-Gg: AZuq6aL4rCYkRAayDfIUlWzTfjrx6vtBeaBnu+e+Bj/21IR4U2cHByf+eGo0TSy+Hdw
	X/hty3orwWF7/hJdjhEjdVlbDsWYmOFak7k+dJ50PxrBTnCXLHqns8FjIjbTyW2Hm8bO2IjA8XQ
	pt6DE1qG6zM4CwYUq4dkelqQ2OV6zrdYjjfibo+r3AWeWbwGYEpqiS+qE6JX9x5ZWCufY=
X-Received: by 2002:a05:6102:32d1:b0:5f5:48df:b869 with SMTP id ada2fe7eead31-5f57651cce8mr1098105137.44.1769414643902;
        Mon, 26 Jan 2026 00:04:03 -0800 (PST)
X-Received: by 2002:a05:6102:32d1:b0:5f5:48df:b869 with SMTP id
 ada2fe7eead31-5f57651cce8mr1098098137.44.1769414643588; Mon, 26 Jan 2026
 00:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260119055447.229772-1-lulu@redhat.com> <20260119055447.229772-3-lulu@redhat.com>
 <aW3JstEHDXjj80OL@test-OptiPlex-Tower-Plus-7010>
In-Reply-To: <aW3JstEHDXjj80OL@test-OptiPlex-Tower-Plus-7010>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 26 Jan 2026 16:03:24 +0800
X-Gm-Features: AZwV_Qixdd4SbLBwLRkXMVFpsz1u-BKiGH2rTPLdxtlyFEEtvuaiAvDni2PEalU
Message-ID: <CACLfguVXA6mpx6FUS-gwuXs0treNn_-D_-cxxAnwUD=mmztccw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] vdpa/mlx5: reuse common function for MAC address updates
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l6QXY8mEtF88sGDkQOXtIi7iJtICD-8U82cNm77YyZA_1769414644
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 2:05=E2=80=AFPM Hariprasad Kelam <hkelam@marvell.co=
m> wrote:
>
> On 2026-01-19 at 11:23:52, Cindy Lu (lulu@redhat.com) wrote:
> > Factor out MAC address update logic and reuse it from handle_ctrl_mac()=
.
> >
> > This ensures that old MAC entries are removed from the MPFS table
> > before adding a new one and that the forwarding rules are updated
> > accordingly. If updating the flow table fails, the original MAC and
> > rules are restored as much as possible to keep the software and
> > hardware state consistent.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> >
> > Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 131 ++++++++++++++++--------------
> >  1 file changed, 71 insertions(+), 60 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 6e42bae7c9a1..7a39843de243 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -2125,86 +2125,97 @@ static void teardown_steering(struct mlx5_vdpa_=
net *ndev)
> >       mlx5_destroy_flow_table(ndev->rxft);
> >  }
> >
> > -static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev=
, u8 cmd)
> > +static int mlx5_vdpa_change_mac(struct mlx5_vdpa_net *ndev,
> > +                             struct mlx5_core_dev *pfmdev,
> > +                             const u8 *new_mac)
> >  {
> > -     struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > -     struct mlx5_control_vq *cvq =3D &mvdev->cvq;
> > -     virtio_net_ctrl_ack status =3D VIRTIO_NET_ERR;
> > -     struct mlx5_core_dev *pfmdev;
> > -     size_t read;
> > -     u8 mac[ETH_ALEN], mac_back[ETH_ALEN];
> > +     struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
> > +     u8 old_mac[ETH_ALEN];
> >
> > -     pfmdev =3D pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
> > -     switch (cmd) {
> > -     case VIRTIO_NET_CTRL_MAC_ADDR_SET:
> > -             read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, (=
void *)mac, ETH_ALEN);
> > -             if (read !=3D ETH_ALEN)
> > -                     break;
> > +     if (is_zero_ether_addr(new_mac))
> > +             return -EINVAL;
> >
> > -             if (!memcmp(ndev->config.mac, mac, 6)) {
> > -                     status =3D VIRTIO_NET_OK;
> > -                     break;
> > +     if (!is_zero_ether_addr(ndev->config.mac)) {
> > +             if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
> > +                     mlx5_vdpa_warn(mvdev, "failed to delete old MAC %=
pM from MPFS table\n",
> > +                                    ndev->config.mac);
> > +                     return -EIO;
> >               }
> > +     }
> >
> > -             if (is_zero_ether_addr(mac))
> > -                     break;
> > +     if (mlx5_mpfs_add_mac(pfmdev, (u8 *)new_mac)) {
> > +             mlx5_vdpa_warn(mvdev, "failed to insert new MAC %pM into =
MPFS table\n",
> > +                            new_mac);
> > +             return -EIO;
> > +     }
> >
> > -             if (!is_zero_ether_addr(ndev->config.mac)) {
> > -                     if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) =
{
> > -                             mlx5_vdpa_warn(mvdev, "failed to delete o=
ld MAC %pM from MPFS table\n",
> > -                                            ndev->config.mac);
> > -                             break;
> > -                     }
> > -             }
> > +     /* backup the original mac address so that if failed to add the f=
orward rules
> > +      * we could restore it
> > +      */
> > +     memcpy(old_mac, ndev->config.mac, ETH_ALEN);
>         can we use "ether_addr_copy" instead of memcpy?
> Thanks,
> Hariprasad k
>
Thanks  Hariprasad, will change this
Thanks
cindy

