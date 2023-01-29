Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CDDC05027
	for <virtualization@archiver.kernel.org>; Sun, 29 Jan 2023 06:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C7DFB40129;
	Sun, 29 Jan 2023 06:03:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7DFB40129
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Eyj9EzP7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qQF2qDz-R3y0; Sun, 29 Jan 2023 06:03:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 39BFE400F6;
	Sun, 29 Jan 2023 06:03:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 39BFE400F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B035C0033;
	Sun, 29 Jan 2023 06:03:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BFC1C002B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 06:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5398940129
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 06:03:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5398940129
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cuVAzcaZcyRd
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 06:03:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19815400F6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19815400F6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 06:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674972205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=45bUkiep54tmBTJEkS/MNpluSkiEVK+TLNueCz5nf8c=;
 b=Eyj9EzP7WkcTYLrbykQQmPyRwwTcLqpNZzJdS1FdxoBrpjQBjWRxYl9LzvFJbM7+HJSEWX
 uBoxGDuyy2GzxrayVwV2O13RMmdDFCJcss1aHfAjU/gEeH68Z96s2yg5DMfhdwzA9MfEmH
 LYc/k9vW10EOHH7BciHYOTo8wF2aAXw=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-74-LujvKGH-Mwy_CREdXhTcow-1; Sun, 29 Jan 2023 01:03:23 -0500
X-MC-Unique: LujvKGH-Mwy_CREdXhTcow-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1634c8f8b54so3032186fac.14
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Jan 2023 22:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=45bUkiep54tmBTJEkS/MNpluSkiEVK+TLNueCz5nf8c=;
 b=hLMmmtw3R0YBmlKzXDH62iwWGFCpvIiQ1n09K4zd3yCGu7jkFbhK0AaU9TVnC64nxN
 L8nfqcep0rhO2sNcTxzU/yCZfzNWRkkcPKtvgFrbZWgAcx008B2mhpoEiXpB8BH8xGx/
 8YMDAG0HcLysPM9wIA881ykq7Gv2Kz3zxWaapHr54Kr7yZfpeOyofm5gpAMzVsGhOWgW
 wZFQMmJ7NZPzmMj+xqtKPrJkvsYjoXjWgVF0t3ng+vqg0KfLQn8UJ/ivOPV8pFoaRJ9C
 FJQj15UBNEGpIZOH8tF0opjTsi+lZex2cE6n09MvdKWuT8fq+tfkjo8FA9/3OPpPGX1J
 f9eQ==
X-Gm-Message-State: AO0yUKWFKpPd3gxrXVjpnArax0QvYViOIuwZpCZnL+fqi5gAe2Py0Z4M
 sA5HJnS0lRt1CUSeuHgPe/VQTx6OMT3/yXf4BF2q3CPHrEov90AayTvkTkjc0HxC1/6ME5bknTn
 AKOhZ6BW0amnDk7MhAVeBhl9TTilX1LTRxeCR5mgr3COjoWS69du9OLBVnw==
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr116371oao.35.1674972203011; 
 Sat, 28 Jan 2023 22:03:23 -0800 (PST)
X-Google-Smtp-Source: AK7set/OxwOzdOtXUfhziT4PTwF/YD77C6KS9ss0hcg3WVOqPDIPj+fm526ZXLHopV6orFx6BFjwUHOLW0de94q3pvs=
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr116360oao.35.1674972202797; Sat, 28 Jan
 2023 22:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20230129025034.2000-1-longpeng2@huawei.com>
 <20230129025034.2000-2-longpeng2@huawei.com>
In-Reply-To: <20230129025034.2000-2-longpeng2@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 29 Jan 2023 14:03:11 +0800
Message-ID: <CACGkMEuq=17Y6E6uSRdsRG8iuMrU6j9AeVS1s1EhnfHeoB+rkA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vdpa: support specify the pgprot of vq
 notification area
To: "Longpeng(Mike)" <longpeng2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, yechuan@huawei.com,
 eperezma@redhat.com, huangzhichao@huawei.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
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

On Sun, Jan 29, 2023 at 10:51 AM Longpeng(Mike) <longpeng2@huawei.com> wrote:
>
> From: Longpeng <longpeng2@huawei.com>
>
> Adds get_vq_notification_pgprot operation to vdpa_config_ops to support
> specify the pgprot of vq norification area. It's an optional operation,
> the vdpa framework will treat the pgprot of vq notification area as
> noncached as default as usual.

Missing sob.

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vhost/vdpa.c | 4 +++-
>  include/linux/vdpa.h | 9 +++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 166044642fd5..036fe88425c8 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1263,7 +1263,9 @@ static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
>
>         notify = ops->get_vq_notification(vdpa, index);
>
> -       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +       vma->vm_page_prot = ops->get_vq_notification_pgprot ?
> +               ops->get_vq_notification_pgprot(vdpa, index, vma->vm_page_prot) :
> +               pgprot_noncached(vma->vm_page_prot);
>         if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
>                             PFN_DOWN(notify.addr), PAGE_SIZE,
>                             vma->vm_page_prot))
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6d0f5e4e82c2..07fcf5e6abc8 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -169,6 +169,12 @@ struct vdpa_map_file {
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
>   *                             Returns the notifcation area
> + * @get_vq_notification_pgprot:        Get the pgprot of the vq's notification area (optional)
> + *                             @vdev: vdpa device
> + *                             @idx: virtqueue index
> + *                             @prot: original page protection value of the
> + *                                    notification area
> + *                             Returns pgprot_t: the pgprot of the notification area
>   * @get_vq_irq:                        Get the irq number of a virtqueue (optional,
>   *                             but must implemented if require vq irq offloading)
>   *                             @vdev: vdpa device
> @@ -305,6 +311,9 @@ struct vdpa_config_ops {
>                                    struct netlink_ext_ack *extack);
>         struct vdpa_notification_area
>         (*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
> +       pgprot_t (*get_vq_notification_pgprot)(struct vdpa_device *vdev,
> +                                              u16 idx,
> +                                              pgprot_t prot);
>         /* vq irq is not expected to be changed once DRIVER_OK is set */
>         int (*get_vq_irq)(struct vdpa_device *vdev, u16 idx);
>
> --
> 2.23.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
