Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3922339
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742789155; cv=none; b=p6O88IUBorTjQeLx0cvc3CorEZd4xQrWdLbAzPElqKjz6DJdtoQTnfloKiG7dWOApke1qumrlH6S/Z+/3VOPbvqhTfm9QdoiojJ2Dsqs5iyBvF4xBMtb34UPLpf25amtKDxEvs9CnHVAI+rtBEgCopPoP3AhmE6lkTHKmX3ET6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742789155; c=relaxed/simple;
	bh=aet9vxFSnxe8aFM1s9AV67Zwavy2t3D9TNLmRVq8SJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AatjO54P7IDXXHBiTz+whX5haTorzNOZ7M4QNo3sv6fzs3+tQgJzuuuId8Cx6t0E3/xLZm43iFbDWswq0maQn6OkMFZ96T9dDnO8v2zNQ8j6xczMIOcLz0QNwUqVmQoiixbn7HpiUa1uvJ0FU6rUMJmluZd7MbZUoFh1gfP1gh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbXbpGjt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbXbpGjt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742789151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1x1hY/1rtDy9MjAhzqye2i9aiAJTHF35sT4hEN0FVn8=;
	b=hbXbpGjtRouxThQ+cDP3OVyhWBPQNoQnCSnI0E0kO7S412j539N31O/jBlEvZcFUasFMLH
	GcaMmXiPib/8lholJMztyeB0jRj4Oha0fouc3tn8yM9cDp+p1M7DCmroCu5uleOJAzrq35
	0Ngc4+fJvWQAZ49NBMNXELezQRuNp08=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-ZxrDsO-fMOSFuUAoOndycQ-1; Mon, 24 Mar 2025 00:05:49 -0400
X-MC-Unique: ZxrDsO-fMOSFuUAoOndycQ-1
X-Mimecast-MFC-AGG-ID: ZxrDsO-fMOSFuUAoOndycQ_1742789149
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22651aca434so62580565ad.1
        for <virtualization@lists.linux.dev>; Sun, 23 Mar 2025 21:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742789149; x=1743393949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1x1hY/1rtDy9MjAhzqye2i9aiAJTHF35sT4hEN0FVn8=;
        b=DbYNxr605hFoPfxUh5Ru9acUgHbPR3gxpvB8kU3gNvt8JkfXV59SGqbPwvX9u+sMF2
         uRk/nKHkoyuRa79JF7NoqKxS8iNOQ5j3bXpNZxHgVBxnMPV4Y5+fFrpJ8YlKstO9coJD
         vt8aCq7nkSY/YghZ2I7UBLW8rbTfUrli106lO3LM/+aN3KWgCAGn3+7jADfyB5OVjj1W
         a2y4MyLUip+v7ZejuW3sp6lU6HgNqXJj9WbvXVKyA8SFS1xINGtL8G0SXkJyObZ3nQFN
         4N6rrEQZS4mpjRkdO1Y5XmogN9UQlnxXDTTcl+u5DwK76ged0E0EIbVocXXgZMMSzB1Q
         xY2g==
X-Forwarded-Encrypted: i=1; AJvYcCWu9SB9aDLunZ5AC8IEg1HkE4oG5bdRdMo/Jo+NL2fwGlhJbJDnfs8PUDLBYPvcg+ENKbAVS6Z02xD3ECJq1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1D1xzMbiiX4+nd1Q4DyD5N/fxD4rkwQcDfKyAg9NqMeDJl+s6
	LWmZO47OhsUhMuNw+Yq3XyPuuosW7ZfwDgbm8cjsTB9JpAKux/EKrjL/LadYO3PUGZaCgm+/VTI
	7stRSZURDpnlVDXH1VTlQ/5gsuEcfyb0um1YNSxi44zZdul9aVVDprw5a/bU67xAeYkwGky7YcR
	MPW0Sl+IK5CejoNCswNa9OSnxf8RCwkzquXLtzawo=
X-Gm-Gg: ASbGncuH+2au4z4Om563flneBM7NPHdnEv3U0eAxE1H/08bHwtjb8JqbXevCNz+b01N
	I8WmsYgw2raQtx56CapqrorCxWXJePH5lf22fPvjim7H89gTE+D9eknwHDFbsDkIbzFVerDI=
X-Received: by 2002:a17:902:ce0f:b0:216:2bd7:1c2f with SMTP id d9443c01a7336-22780c7ba39mr141626595ad.18.1742789148404;
        Sun, 23 Mar 2025 21:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzfjhheKeqCofKoGx2ILS7JuiKGk75svOUU8Qjb+DNoGmGIQw0tKFz8tgPNN1o+lc+3igAiVcvV60oJJW/uGA=
X-Received: by 2002:a17:902:ce0f:b0:216:2bd7:1c2f with SMTP id
 d9443c01a7336-22780c7ba39mr141626145ad.18.1742789147809; Sun, 23 Mar 2025
 21:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com> <20250318-virtio-v1-3-344caf336ddd@daynix.com>
 <CACGkMEv1TTXHd_JGb_vyN8pfTAMLbsTE6oU9_phrdpaZBrE97Q@mail.gmail.com>
 <b6eec81d-618f-4a59-8680-8e22f1a798bf@daynix.com> <CACGkMEsEaUzAeEaBzX6zQC-gVMjS_0tSegBKUrhX4R6c3MW2hQ@mail.gmail.com>
 <83a5ab7b-7b29-413e-a854-31c7893f3c4a@daynix.com> <CACGkMEvbs9NnHhjaiiD4hc-bOAm9+-ry3xfdZET3HqJ=_1k6Lg@mail.gmail.com>
 <764ca4a4-3587-4dd4-93a4-23542b32dbf9@daynix.com>
In-Reply-To: <764ca4a4-3587-4dd4-93a4-23542b32dbf9@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Mar 2025 12:05:36 +0800
X-Gm-Features: AQ5f1Jo0oR0RYzJE70FldPxBoE1wqtTxWWGuGc3i0-xP2EFlGv5DKGx9Q1oDxBU
Message-ID: <CACGkMEstpXSyxXNr7CymfK8L3xXX40o+QQf80sPYNjtZjWkR3g@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: 3E7KuSjkyJwyvMU7_-vu2uQ1Hw8POerSsiTbjBzNOt4_1742789149
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 2:35=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/21 9:35, Jason Wang wrote:
> > On Thu, Mar 20, 2025 at 1:36=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/03/20 10:50, Jason Wang wrote:
> >>> On Wed, Mar 19, 2025 at 12:48=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>
> >>>> On 2025/03/19 10:43, Jason Wang wrote:
> >>>>> On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odak=
i@daynix.com> wrote:
> >>>>>>
> >>>>>> The new RSS configuration structures allow easily constructing dat=
a for
> >>>>>> VIRTIO_NET_CTRL_MQ_RSS_CONFIG as they strictly follow the order of=
 data
> >>>>>> for the command.
> >>>>>>
> >>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>> ---
> >>>>>>     drivers/net/virtio_net.c | 117 +++++++++++++++++--------------=
----------------
> >>>>>>     1 file changed, 43 insertions(+), 74 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>>>>> index d1ed544ba03a..4153a0a5f278 100644
> >>>>>> --- a/drivers/net/virtio_net.c
> >>>>>> +++ b/drivers/net/virtio_net.c
> >>>>>> @@ -360,24 +360,7 @@ struct receive_queue {
> >>>>>>            struct xdp_buff **xsk_buffs;
> >>>>>>     };
> >>>>>>
> >>>>>> -/* This structure can contain rss message with maximum settings f=
or indirection table and keysize
> >>>>>> - * Note, that default structure that describes RSS configuration =
virtio_net_rss_config
> >>>>>> - * contains same info but can't handle table values.
> >>>>>> - * In any case, structure would be passed to virtio hw through sg=
_buf split by parts
> >>>>>> - * because table sizes may be differ according to the device conf=
iguration.
> >>>>>> - */
> >>>>>>     #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> >>>>>> -struct virtio_net_ctrl_rss {
> >>>>>> -       __le32 hash_types;
> >>>>>> -       __le16 indirection_table_mask;
> >>>>>> -       __le16 unclassified_queue;
> >>>>>> -       __le16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_n=
et_hash_config for details) */
> >>>>>> -       __le16 max_tx_vq;
> >>>>>> -       u8 hash_key_length;
> >>>>>> -       u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >>>>>> -
> >>>>>> -       __le16 *indirection_table;
> >>>>>> -};
> >>>>>>
> >>>>>>     /* Control VQ buffers: protected by the rtnl lock */
> >>>>>>     struct control_buf {
> >>>>>> @@ -421,7 +404,9 @@ struct virtnet_info {
> >>>>>>            u16 rss_indir_table_size;
> >>>>>>            u32 rss_hash_types_supported;
> >>>>>>            u32 rss_hash_types_saved;
> >>>>>> -       struct virtio_net_ctrl_rss rss;
> >>>>>> +       struct virtio_net_rss_config_hdr *rss_hdr;
> >>>>>> +       struct virtio_net_rss_config_trailer rss_trailer;
> >>>>>> +       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >>>>>>
> >>>>>>            /* Has control virtqueue */
> >>>>>>            bool has_cvq;
> >>>>>> @@ -523,23 +508,16 @@ enum virtnet_xmit_type {
> >>>>>>            VIRTNET_XMIT_TYPE_XSK,
> >>>>>>     };
> >>>>>>
> >>>>>> -static int rss_indirection_table_alloc(struct virtio_net_ctrl_rss=
 *rss, u16 indir_table_size)
> >>>>>> +static size_t virtnet_rss_hdr_size(const struct virtnet_info *vi)
> >>>>>>     {
> >>>>>> -       if (!indir_table_size) {
> >>>>>> -               rss->indirection_table =3D NULL;
> >>>>>> -               return 0;
> >>>>>> -       }
> >>>>>> +       u16 indir_table_size =3D vi->has_rss ? vi->rss_indir_table=
_size : 1;
> >>>>>>
> >>>>>> -       rss->indirection_table =3D kmalloc_array(indir_table_size,=
 sizeof(u16), GFP_KERNEL);
> >>>>>> -       if (!rss->indirection_table)
> >>>>>> -               return -ENOMEM;
> >>>>>> -
> >>>>>> -       return 0;
> >>>>>> +       return struct_size(vi->rss_hdr, indirection_table, indir_t=
able_size);
> >>>>>>     }
> >>>>>>
> >>>>>> -static void rss_indirection_table_free(struct virtio_net_ctrl_rss=
 *rss)
> >>>>>> +static size_t virtnet_rss_trailer_size(const struct virtnet_info =
*vi)
> >>>>>>     {
> >>>>>> -       kfree(rss->indirection_table);
> >>>>>> +       return struct_size(&vi->rss_trailer, hash_key_data, vi->rs=
s_key_size);
> >>>>>>     }
> >>>>>>
> >>>>>>     /* We use the last two bits of the pointer to distinguish the =
xmit type. */
> >>>>>> @@ -3576,15 +3554,16 @@ static void virtnet_rss_update_by_qpairs(s=
truct virtnet_info *vi, u16 queue_pair
> >>>>>>
> >>>>>>            for (; i < vi->rss_indir_table_size; ++i) {
> >>>>>>                    indir_val =3D ethtool_rxfh_indir_default(i, que=
ue_pairs);
> >>>>>> -               vi->rss.indirection_table[i] =3D cpu_to_le16(indir=
_val);
> >>>>>> +               vi->rss_hdr->indirection_table[i] =3D cpu_to_le16(=
indir_val);
> >>>>>>            }
> >>>>>> -       vi->rss.max_tx_vq =3D cpu_to_le16(queue_pairs);
> >>>>>> +       vi->rss_trailer.max_tx_vq =3D cpu_to_le16(queue_pairs);
> >>>>>>     }
> >>>>>>
> >>>>>>     static int virtnet_set_queues(struct virtnet_info *vi, u16 que=
ue_pairs)
> >>>>>>     {
> >>>>>>            struct virtio_net_ctrl_mq *mq __free(kfree) =3D NULL;
> >>>>>> -       struct virtio_net_ctrl_rss old_rss;
> >>>>>> +       struct virtio_net_rss_config_hdr *old_rss_hdr;
> >>>>>> +       struct virtio_net_rss_config_trailer old_rss_trailer;
> >>>>>>            struct net_device *dev =3D vi->dev;
> >>>>>>            struct scatterlist sg;
> >>>>>>
> >>>>>> @@ -3599,24 +3578,28 @@ static int virtnet_set_queues(struct virtn=
et_info *vi, u16 queue_pairs)
> >>>>>>             * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and r=
eturn directly.
> >>>>>>             */
> >>>>>>            if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
> >>>>>> -               memcpy(&old_rss, &vi->rss, sizeof(old_rss));
> >>>>>> -               if (rss_indirection_table_alloc(&vi->rss, vi->rss_=
indir_table_size)) {
> >>>>>> -                       vi->rss.indirection_table =3D old_rss.indi=
rection_table;
> >>>>>> +               old_rss_hdr =3D vi->rss_hdr;
> >>>>>> +               old_rss_trailer =3D vi->rss_trailer;
> >>>>>> +               vi->rss_hdr =3D kmalloc(virtnet_rss_hdr_size(vi), =
GFP_KERNEL);
> >>>>>> +               if (!vi->rss_hdr) {
> >>>>>> +                       vi->rss_hdr =3D old_rss_hdr;
> >>>>>>                            return -ENOMEM;
> >>>>>>                    }
> >>>>>>
> >>>>>> +               *vi->rss_hdr =3D *old_rss_hdr;
> >>>>>>                    virtnet_rss_update_by_qpairs(vi, queue_pairs);
> >>>>>>
> >>>>>>                    if (!virtnet_commit_rss_command(vi)) {
> >>>>>>                            /* restore ctrl_rss if commit_rss_comma=
nd failed */
> >>>>>> -                       rss_indirection_table_free(&vi->rss);
> >>>>>> -                       memcpy(&vi->rss, &old_rss, sizeof(old_rss)=
);
> >>>>>> +                       kfree(vi->rss_hdr);
> >>>>>> +                       vi->rss_hdr =3D old_rss_hdr;
> >>>>>> +                       vi->rss_trailer =3D old_rss_trailer;
> >>>>>>
> >>>>>>                            dev_warn(&dev->dev, "Fail to set num of=
 queue pairs to %d, because committing RSS failed\n",
> >>>>>>                                     queue_pairs);
> >>>>>>                            return -EINVAL;
> >>>>>>                    }
> >>>>>> -               rss_indirection_table_free(&old_rss);
> >>>>>> +               kfree(old_rss_hdr);
> >>>>>>                    goto succ;
> >>>>>>            }
> >>>>>>
> >>>>>> @@ -4059,28 +4042,12 @@ static int virtnet_set_ringparam(struct ne=
t_device *dev,
> >>>>>>     static bool virtnet_commit_rss_command(struct virtnet_info *vi=
)
> >>>>>>     {
> >>>>>>            struct net_device *dev =3D vi->dev;
> >>>>>> -       struct scatterlist sgs[4];
> >>>>>> -       unsigned int sg_buf_size;
> >>>>>> +       struct scatterlist sgs[2];
> >>>>>>
> >>>>>>            /* prepare sgs */
> >>>>>> -       sg_init_table(sgs, 4);
> >>>>>> -
> >>>>>> -       sg_buf_size =3D offsetof(struct virtio_net_ctrl_rss, hash_=
cfg_reserved);
> >>>>>> -       sg_set_buf(&sgs[0], &vi->rss, sg_buf_size);
> >>>>>> -
> >>>>>> -       if (vi->has_rss) {
> >>>>>> -               sg_buf_size =3D sizeof(uint16_t) * vi->rss_indir_t=
able_size;
> >>>>>> -               sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_=
buf_size);
> >>>>>> -       } else {
> >>>>>> -               sg_set_buf(&sgs[1], &vi->rss.hash_cfg_reserved, si=
zeof(uint16_t));
> >>>>>> -       }
> >>>>>> -
> >>>>>> -       sg_buf_size =3D offsetof(struct virtio_net_ctrl_rss, key)
> >>>>>> -                       - offsetof(struct virtio_net_ctrl_rss, max=
_tx_vq);
> >>>>>> -       sg_set_buf(&sgs[2], &vi->rss.max_tx_vq, sg_buf_size);
> >>>>>> -
> >>>>>> -       sg_buf_size =3D vi->rss_key_size;
> >>>>>> -       sg_set_buf(&sgs[3], vi->rss.key, sg_buf_size);
> >>>>>> +       sg_init_table(sgs, 2);
> >>>>>> +       sg_set_buf(&sgs[0], vi->rss_hdr, virtnet_rss_hdr_size(vi))=
;
> >>>>>> +       sg_set_buf(&sgs[1], &vi->rss_trailer, virtnet_rss_trailer_=
size(vi));
> >>>>>
> >>>>> So I still see this:
> >>>>>
> >>>>>            if (vi->has_rss || vi->has_rss_hash_report) {
> >>>>>                    if (!virtnet_commit_rss_command(vi)) {
> >>>>>
> >>>>> Should we introduce a hash config helper instead?
> >>>>
> >>>> I think it's fine to use virtnet_commit_rss_command() for hash
> >>>> reporting. struct virtio_net_hash_config and struct
> >>>> virtio_net_rss_config are defined to have a common layout to allow
> >>>> sharing this kind of logic.
> >>>
> >>> Well, this trick won't work if the reserved field in hash_config is
> >>> used in the future.
> >>
> >> Right, but we can add a hash config helper when that happens. It will
> >> only result in a duplication of logic for now.
> >>
> >> Regards,
> >> Akihiko Odaki
> >
> > That's tricky as the cvq commands were designed to be used separately.
> > Let's use a separate helper and virtio_net_hash_config uAPIs now.
>
> It's not tricky but is explicitly stated in the spec. 5.1.6.5.6.4 "Hash
> calculation" says:
>  > Field reserved MUST contain zeroes. It is defined to make the
>  > structure to match the layout of virtio_net_rss_config structure,
>  > defined in 5.1.6.5.7.

This is kind of not elegant, but it's too late to fix.

Thanks

>
> By the way, I found it says field reserved MUST contain zeros but we do
> nothing to ensure that. I'll write a fix for that.
>
> Regards,
> Akihiko Odaki
>
> >
> > Thanks
> >
> >>
> >>>
> >>> Thanks
> >>>
> >>>>
> >>>> Regards,
> >>>> Akihiko Odaki
> >>>>
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>
> >>>
> >>
> >
>

