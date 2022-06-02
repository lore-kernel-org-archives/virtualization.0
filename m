Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641A7C433EF
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 07:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E216D415D5;
	Thu,  2 Jun 2022 07:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s9EindZqjO9f; Thu,  2 Jun 2022 07:22:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 35281415A8;
	Thu,  2 Jun 2022 07:22:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 118DAC0039;
	Thu,  2 Jun 2022 07:22:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9512CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7279960BE1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jxeDqAeqtagc
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:22:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A15AE60B9F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654154524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PdmeV4XXkwsKK34sBvBhUPHAPFbEQyKtEpFLQkhAZRk=;
 b=Jwvlv9LJEIX+9zXuEjrVJZo0rxS/wfCXUDuNoKKfDYUvGcL6btGYGdee+A68UHCSHc8Dr5
 6Ig+3xNZvnIWaYPkMB6QvJ84qCLwOfIhwUMXqy6m4Xf7BcR4XxwUzkpU44MeMCt4/2NWUr
 s+Qip98XRedeM6PLDgiQInU+TAxffB8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-TxaJAx5jPUGyKkkmrXiRPQ-1; Thu, 02 Jun 2022 03:22:03 -0400
X-MC-Unique: TxaJAx5jPUGyKkkmrXiRPQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-30c14765d55so36070947b3.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Jun 2022 00:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PdmeV4XXkwsKK34sBvBhUPHAPFbEQyKtEpFLQkhAZRk=;
 b=73BoNw406gYd62xazJ8RJkMGCbmhhcTUv32SYyixuAGFQB6OwAlVez1DVy3GdBzgoo
 DT0YDlGwNhOXu6vUctlnVOwyzZVwTwWJV9WX04w0yK5Aa9ftA3zOQCBUB+lTH6xIxzdu
 btHHZHqNgMlmrQXx6wXCiKC9EauMSeOVXEr4EM+n/7wroz2KFQTHYO5D27Of5vr+yiWd
 QWoTAAZ/5Ckbqgb3nVLRTTGLl7XNr3HbNiZp6QdHEW/cjsfH04bGJuUnobTWXwQ4iTSF
 FtQAFq6SHMv1CeAbD+3T5Z4IM9OzRbLNo38y89vtumF/HU3dIr5V3moD0YeKqgefVKQo
 bBLg==
X-Gm-Message-State: AOAM530QLZ7Pf3o49n1o7sXXq6bZqXs6XSN9K/7uyY1AiiP7hILmBUxN
 h8R5joH8kexd8GaAljtdHQdk3I7WTyRAke1+09X2JPMhDEQlYV6sx9XqDHgM1FZPWd4nsXFxkP7
 THCdDBURIs1j2EnkJDLHFJ98KvS19qt8Z0lKhnpdpQfQ6WJTWFS72RgtKMw==
X-Received: by 2002:a25:d98b:0:b0:65c:9dc9:7a8f with SMTP id
 q133-20020a25d98b000000b0065c9dc97a8fmr3682963ybg.622.1654154523045; 
 Thu, 02 Jun 2022 00:22:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuB1e5WkQ7CJfmXyUcXu9v1a07sh/Q63u1Zs089N3+o1m61VRasufyxqas0IxOqRZFSLxoDqQFKlYmmFh6paM=
X-Received: by 2002:a25:d98b:0:b0:65c:9dc9:7a8f with SMTP id
 q133-20020a25d98b000000b0065c9dc97a8fmr3682951ybg.622.1654154522824; Thu, 02
 Jun 2022 00:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220602023845.2596397-1-lingshan.zhu@intel.com>
 <20220602023845.2596397-3-lingshan.zhu@intel.com>
In-Reply-To: <20220602023845.2596397-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jun 2022 15:21:51 +0800
Message-ID: <CACGkMEt4u2R9y8f3S0rAhrEmOi-N=1NCfLxLTR+U6ddcu9iYWg@mail.gmail.com>
Subject: Re: [PATCH 2/6] vDPA/ifcvf: support userspace to query features and
 MQ of a management device
To: Zhu Lingshan <lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jun 2, 2022 at 10:48 AM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> Adapting to current netlink interfaces, this commit allows userspace
> to query feature bits and MQ capability of a management device.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_base.c | 12 ++++++++++++
>  drivers/vdpa/ifcvf/ifcvf_base.h |  1 +
>  drivers/vdpa/ifcvf/ifcvf_main.c |  3 +++
>  3 files changed, 16 insertions(+)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> index 6bccc8291c26..7be703b5d1f4 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> @@ -341,6 +341,18 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
>         return 0;
>  }
>
> +u16 ifcvf_get_max_vq_pairs(struct ifcvf_hw *hw)
> +{
> +       struct virtio_net_config __iomem *config;
> +       u16 val, mq;
> +
> +       config  = (struct virtio_net_config __iomem *)hw->dev_cfg;

Any reason we need the cast here? (cast from void * seems not necessary).

> +       val = vp_ioread16((__le16 __iomem *)&config->max_virtqueue_pairs);

I don't see any __le16 cast for the callers of vp_ioread16, anything
make max_virtqueue_pairs different here?

Thanks

> +       mq = le16_to_cpu((__force __le16)val);
> +
> +       return mq;
> +}
> +
>  static int ifcvf_hw_enable(struct ifcvf_hw *hw)
>  {
>         struct virtio_pci_common_cfg __iomem *cfg;
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
> index f5563f665cc6..d54a1bed212e 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.h
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
> @@ -130,6 +130,7 @@ u64 ifcvf_get_hw_features(struct ifcvf_hw *hw);
>  int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features);
>  u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid);
>  int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num);
> +u16 ifcvf_get_max_vq_pairs(struct ifcvf_hw *hw);
>  struct ifcvf_adapter *vf_to_adapter(struct ifcvf_hw *hw);
>  int ifcvf_probed_virtio_net(struct ifcvf_hw *hw);
>  u32 ifcvf_get_config_size(struct ifcvf_hw *hw);
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 4366320fb68d..0c3af30b297e 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -786,6 +786,9 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>         vf->hw_features = ifcvf_get_hw_features(vf);
>         vf->config_size = ifcvf_get_config_size(vf);
>
> +       ifcvf_mgmt_dev->mdev.max_supported_vqs = ifcvf_get_max_vq_pairs(vf);

Btw, I think current IFCVF doesn't support the provisioning of a
$max_qps that is smaller than what hardware did.

Then I wonder if we need a min_supported_vqs attribute or doing
mediation in the ifcvf parent.

Thanks

> +       ifcvf_mgmt_dev->mdev.supported_features = vf->hw_features;
> +
>         adapter->vdpa.mdev = &ifcvf_mgmt_dev->mdev;
>         ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring);
>         if (ret) {
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
