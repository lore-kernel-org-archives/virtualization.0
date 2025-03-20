Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65717991
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435461; cv=none; b=rWmYQtemigjyjqxqgRa/DMQGy2xYZagSU52G5ra5Jb8CMOZSifD71HzbDWAY1uKgeKUFaZebKmK2aklClffeNMHA+7XHTBQrRu3aqgHIkdhoh1azFrc5z6OLnYQaoquuv+6Ki9NSMXVdNGBjtrDusc0UE+9zuhXQDueNc7VvFf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435461; c=relaxed/simple;
	bh=Wl6WYrAucD7W3yWclox3lkCN4CXnwwOMoZMBTjORzQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7pn6In55OSg/brEH9Z279FKEF0pP7+Sg3kAdmlfRcwY7bMdbA5EzPAMJDFKR8rZsqa/iOvJCBMXe8n0oYqhSnfsusqPNA7nDLFcmOu/7vF3qDd0b0jyotHY3/K8yBVOtROuk6CJ2XrCjKwt3qo9csmZzjrqE9mFDpJYlWEViSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TaJKF5tg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TaJKF5tg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742435458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIVnYU3ZVuH1OuWSd8k2TRkobMDqbNTuCddNx2dlzbo=;
	b=TaJKF5tgU7NWRTGbtA1kgwGRkfHd5yCFXWXAoEQA47ODDy3Fm2QaklXP6KKDIVUZpw4Qeo
	UMoWV774SyhNvfGjcJfgcwwSOklyhtzRLUC77mZOC3GayrQRJVaO490tHS0amFS1RxskFh
	IzeCUzc0khwpwNNlEODpNNpYPjve07w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-o15yoWRePay0AciKV-GPJw-1; Wed, 19 Mar 2025 21:50:57 -0400
X-MC-Unique: o15yoWRePay0AciKV-GPJw-1
X-Mimecast-MFC-AGG-ID: o15yoWRePay0AciKV-GPJw_1742435456
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so431823a91.0
        for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 18:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435456; x=1743040256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIVnYU3ZVuH1OuWSd8k2TRkobMDqbNTuCddNx2dlzbo=;
        b=K3pp4S3G0oiR8I0YAZz/cf8FEPqGl+9j14MqgvNQpAMsS83IZMyX0sx5ZEvR+rsBAv
         2PAujmT0hg0A7MSZr8+sPmk2+Z28P5HndTBy8IJBISFwUKMTQGpiO6QCkHASpJpd0Gr2
         +whqQxm6K5fIu88/0VXRwGhjvKQMgWnNXGhR0uVsNN21pe+3Ew2x6RWEsiZNDjPgVEBL
         FjD49svXahOCW2CaI9fFO3zIdEvPsYngKCgJKELGkCMGM2DvQpU/cHtzUaErwUiKiDZU
         7q6osoIPsSDlt9jFfl/vChIckiRptXt+KHRz5CVWGi6dXQ755819iIPOn0sqHD5Mb8PC
         h57A==
X-Forwarded-Encrypted: i=1; AJvYcCUn6iYCDYWDGit42iSjZaLd1ZXxSQqijF7ehliemu8I4QufKDsR/jCZc9ZzUOimY4c6H4bwnXdWjvMhPYwZ4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeVACSHxvMtG9KFI5nPbhiQa6fxfd9Tqj3gB2HGVhhXIUpRXUQ
	ZiEMpbT3AzI8eV3NivusLtDAaFNwj4j2YmByFR1jK9GPWoZvQI5/VDSwtuUv9TUdEktPpT+XuOq
	iSGUqqteM1zxK+9eMbEtzRiUqZ89Q4E+vtBNR+PkqlFaDCT3d+IxBkImaunG+37kIQHo2LAeOq6
	uJiGdWKiJRAVydBbmI2iJc8wJ5rJWxul/yauVU2kQ=
X-Gm-Gg: ASbGncvEfGCHpPopCwGcsovLFTirp3iP6gNh0sZlISP2KZfQXWE5zUp7iX1sYoMhrjf
	16ZAMDjJjE+Acqy18tNYeljpNGHQRiBR3kQ454ZSgXlqzHQYr00Y1jCNAYFJn87o1l2ZTeK7l/Q
	==
X-Received: by 2002:a17:90b:4c89:b0:2fc:ec7c:d371 with SMTP id 98e67ed59e1d1-301d507faacmr1855199a91.3.1742435456140;
        Wed, 19 Mar 2025 18:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeMawCeyRWO9aE478Dl2xOAMybWcnnwqOWuqUyYDaUX4HK6mIJKwahNmjZp3Myy0p+ZYF1QHaFTeMTmkg2jwY=
X-Received: by 2002:a17:90b:4c89:b0:2fc:ec7c:d371 with SMTP id
 98e67ed59e1d1-301d507faacmr1855173a91.3.1742435455741; Wed, 19 Mar 2025
 18:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com> <20250318-virtio-v1-3-344caf336ddd@daynix.com>
 <CACGkMEv1TTXHd_JGb_vyN8pfTAMLbsTE6oU9_phrdpaZBrE97Q@mail.gmail.com> <b6eec81d-618f-4a59-8680-8e22f1a798bf@daynix.com>
In-Reply-To: <b6eec81d-618f-4a59-8680-8e22f1a798bf@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Mar 2025 09:50:43 +0800
X-Gm-Features: AQ5f1JomCMJvdUcszXcgY4iLGGC6Jyj4ZoBaN-XVk0bTIneaqZ04DVXXMxPvRmg
Message-ID: <CACGkMEsEaUzAeEaBzX6zQC-gVMjS_0tSegBKUrhX4R6c3MW2hQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] virtio_net: Use new RSS config structs
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: srpv7YXXSaGlHqjk7uT9rAEHpfCYhg0sVQy8h_b2nx8_1742435456
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 12:48=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2025/03/19 10:43, Jason Wang wrote:
> > On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> The new RSS configuration structures allow easily constructing data fo=
r
> >> VIRTIO_NET_CTRL_MQ_RSS_CONFIG as they strictly follow the order of dat=
a
> >> for the command.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   drivers/net/virtio_net.c | 117 +++++++++++++++++--------------------=
----------
> >>   1 file changed, 43 insertions(+), 74 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index d1ed544ba03a..4153a0a5f278 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -360,24 +360,7 @@ struct receive_queue {
> >>          struct xdp_buff **xsk_buffs;
> >>   };
> >>
> >> -/* This structure can contain rss message with maximum settings for i=
ndirection table and keysize
> >> - * Note, that default structure that describes RSS configuration virt=
io_net_rss_config
> >> - * contains same info but can't handle table values.
> >> - * In any case, structure would be passed to virtio hw through sg_buf=
 split by parts
> >> - * because table sizes may be differ according to the device configur=
ation.
> >> - */
> >>   #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> >> -struct virtio_net_ctrl_rss {
> >> -       __le32 hash_types;
> >> -       __le16 indirection_table_mask;
> >> -       __le16 unclassified_queue;
> >> -       __le16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_h=
ash_config for details) */
> >> -       __le16 max_tx_vq;
> >> -       u8 hash_key_length;
> >> -       u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >> -
> >> -       __le16 *indirection_table;
> >> -};
> >>
> >>   /* Control VQ buffers: protected by the rtnl lock */
> >>   struct control_buf {
> >> @@ -421,7 +404,9 @@ struct virtnet_info {
> >>          u16 rss_indir_table_size;
> >>          u32 rss_hash_types_supported;
> >>          u32 rss_hash_types_saved;
> >> -       struct virtio_net_ctrl_rss rss;
> >> +       struct virtio_net_rss_config_hdr *rss_hdr;
> >> +       struct virtio_net_rss_config_trailer rss_trailer;
> >> +       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >>
> >>          /* Has control virtqueue */
> >>          bool has_cvq;
> >> @@ -523,23 +508,16 @@ enum virtnet_xmit_type {
> >>          VIRTNET_XMIT_TYPE_XSK,
> >>   };
> >>
> >> -static int rss_indirection_table_alloc(struct virtio_net_ctrl_rss *rs=
s, u16 indir_table_size)
> >> +static size_t virtnet_rss_hdr_size(const struct virtnet_info *vi)
> >>   {
> >> -       if (!indir_table_size) {
> >> -               rss->indirection_table =3D NULL;
> >> -               return 0;
> >> -       }
> >> +       u16 indir_table_size =3D vi->has_rss ? vi->rss_indir_table_siz=
e : 1;
> >>
> >> -       rss->indirection_table =3D kmalloc_array(indir_table_size, siz=
eof(u16), GFP_KERNEL);
> >> -       if (!rss->indirection_table)
> >> -               return -ENOMEM;
> >> -
> >> -       return 0;
> >> +       return struct_size(vi->rss_hdr, indirection_table, indir_table=
_size);
> >>   }
> >>
> >> -static void rss_indirection_table_free(struct virtio_net_ctrl_rss *rs=
s)
> >> +static size_t virtnet_rss_trailer_size(const struct virtnet_info *vi)
> >>   {
> >> -       kfree(rss->indirection_table);
> >> +       return struct_size(&vi->rss_trailer, hash_key_data, vi->rss_ke=
y_size);
> >>   }
> >>
> >>   /* We use the last two bits of the pointer to distinguish the xmit t=
ype. */
> >> @@ -3576,15 +3554,16 @@ static void virtnet_rss_update_by_qpairs(struc=
t virtnet_info *vi, u16 queue_pair
> >>
> >>          for (; i < vi->rss_indir_table_size; ++i) {
> >>                  indir_val =3D ethtool_rxfh_indir_default(i, queue_pai=
rs);
> >> -               vi->rss.indirection_table[i] =3D cpu_to_le16(indir_val=
);
> >> +               vi->rss_hdr->indirection_table[i] =3D cpu_to_le16(indi=
r_val);
> >>          }
> >> -       vi->rss.max_tx_vq =3D cpu_to_le16(queue_pairs);
> >> +       vi->rss_trailer.max_tx_vq =3D cpu_to_le16(queue_pairs);
> >>   }
> >>
> >>   static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pai=
rs)
> >>   {
> >>          struct virtio_net_ctrl_mq *mq __free(kfree) =3D NULL;
> >> -       struct virtio_net_ctrl_rss old_rss;
> >> +       struct virtio_net_rss_config_hdr *old_rss_hdr;
> >> +       struct virtio_net_rss_config_trailer old_rss_trailer;
> >>          struct net_device *dev =3D vi->dev;
> >>          struct scatterlist sg;
> >>
> >> @@ -3599,24 +3578,28 @@ static int virtnet_set_queues(struct virtnet_i=
nfo *vi, u16 queue_pairs)
> >>           * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return =
directly.
> >>           */
> >>          if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
> >> -               memcpy(&old_rss, &vi->rss, sizeof(old_rss));
> >> -               if (rss_indirection_table_alloc(&vi->rss, vi->rss_indi=
r_table_size)) {
> >> -                       vi->rss.indirection_table =3D old_rss.indirect=
ion_table;
> >> +               old_rss_hdr =3D vi->rss_hdr;
> >> +               old_rss_trailer =3D vi->rss_trailer;
> >> +               vi->rss_hdr =3D kmalloc(virtnet_rss_hdr_size(vi), GFP_=
KERNEL);
> >> +               if (!vi->rss_hdr) {
> >> +                       vi->rss_hdr =3D old_rss_hdr;
> >>                          return -ENOMEM;
> >>                  }
> >>
> >> +               *vi->rss_hdr =3D *old_rss_hdr;
> >>                  virtnet_rss_update_by_qpairs(vi, queue_pairs);
> >>
> >>                  if (!virtnet_commit_rss_command(vi)) {
> >>                          /* restore ctrl_rss if commit_rss_command fai=
led */
> >> -                       rss_indirection_table_free(&vi->rss);
> >> -                       memcpy(&vi->rss, &old_rss, sizeof(old_rss));
> >> +                       kfree(vi->rss_hdr);
> >> +                       vi->rss_hdr =3D old_rss_hdr;
> >> +                       vi->rss_trailer =3D old_rss_trailer;
> >>
> >>                          dev_warn(&dev->dev, "Fail to set num of queue=
 pairs to %d, because committing RSS failed\n",
> >>                                   queue_pairs);
> >>                          return -EINVAL;
> >>                  }
> >> -               rss_indirection_table_free(&old_rss);
> >> +               kfree(old_rss_hdr);
> >>                  goto succ;
> >>          }
> >>
> >> @@ -4059,28 +4042,12 @@ static int virtnet_set_ringparam(struct net_de=
vice *dev,
> >>   static bool virtnet_commit_rss_command(struct virtnet_info *vi)
> >>   {
> >>          struct net_device *dev =3D vi->dev;
> >> -       struct scatterlist sgs[4];
> >> -       unsigned int sg_buf_size;
> >> +       struct scatterlist sgs[2];
> >>
> >>          /* prepare sgs */
> >> -       sg_init_table(sgs, 4);
> >> -
> >> -       sg_buf_size =3D offsetof(struct virtio_net_ctrl_rss, hash_cfg_=
reserved);
> >> -       sg_set_buf(&sgs[0], &vi->rss, sg_buf_size);
> >> -
> >> -       if (vi->has_rss) {
> >> -               sg_buf_size =3D sizeof(uint16_t) * vi->rss_indir_table=
_size;
> >> -               sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_buf_=
size);
> >> -       } else {
> >> -               sg_set_buf(&sgs[1], &vi->rss.hash_cfg_reserved, sizeof=
(uint16_t));
> >> -       }
> >> -
> >> -       sg_buf_size =3D offsetof(struct virtio_net_ctrl_rss, key)
> >> -                       - offsetof(struct virtio_net_ctrl_rss, max_tx_=
vq);
> >> -       sg_set_buf(&sgs[2], &vi->rss.max_tx_vq, sg_buf_size);
> >> -
> >> -       sg_buf_size =3D vi->rss_key_size;
> >> -       sg_set_buf(&sgs[3], vi->rss.key, sg_buf_size);
> >> +       sg_init_table(sgs, 2);
> >> +       sg_set_buf(&sgs[0], vi->rss_hdr, virtnet_rss_hdr_size(vi));
> >> +       sg_set_buf(&sgs[1], &vi->rss_trailer, virtnet_rss_trailer_size=
(vi));
> >
> > So I still see this:
> >
> >          if (vi->has_rss || vi->has_rss_hash_report) {
> >                  if (!virtnet_commit_rss_command(vi)) {
> >
> > Should we introduce a hash config helper instead?
>
> I think it's fine to use virtnet_commit_rss_command() for hash
> reporting. struct virtio_net_hash_config and struct
> virtio_net_rss_config are defined to have a common layout to allow
> sharing this kind of logic.

Well, this trick won't work if the reserved field in hash_config is
used in the future.

Thanks

>
> Regards,
> Akihiko Odaki
>
> >
> > Thanks
> >
>

