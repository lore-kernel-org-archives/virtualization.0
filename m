Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BB4C433F5
	for <virtualization@archiver.kernel.org>; Thu,  6 Jan 2022 12:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E115440A2A;
	Thu,  6 Jan 2022 12:59:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4TfUWWKzma16; Thu,  6 Jan 2022 12:59:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 59D234012F;
	Thu,  6 Jan 2022 12:59:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23A4FC0030;
	Thu,  6 Jan 2022 12:59:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3C3FC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D317E82D17
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:59:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L_G882Z2Q0RD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:59:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0461582D14
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641473971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5WAXUnIE5VkO2N/WW0e+ntcocAshJvWgVTBusRNRoBM=;
 b=Z07kWzKqvVWOFLqA/fDNW7zz+X+r68ILcJvw4w69ZmYTo9Ur2VG/SYmtyIoc+9gSJlcsYw
 8um3vgLqGeUv2JC9zg1IIq9gaAY4ktPRtliEJPSkOqwjKhyTquEnMcVjgyjnfOfi/tHuhh
 accsAnI6Rtj+Fq7mJ1+m/yKDdb+vFmI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-4ffjZStiNC-cTq-BlI8uQg-1; Thu, 06 Jan 2022 07:59:31 -0500
X-MC-Unique: 4ffjZStiNC-cTq-BlI8uQg-1
Received: by mail-wm1-f69.google.com with SMTP id
 b20-20020a05600c4e1400b003457da1c91eso184601wmq.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 04:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5WAXUnIE5VkO2N/WW0e+ntcocAshJvWgVTBusRNRoBM=;
 b=ykkl3mXCWkro1/PzhAeHix8l0f0RKJcKRbZDXvQSf5CiAcH+VxXwipbVlXCTvf8TZh
 VxRkfEfr8CW0RecwtJ7kJzpNxDOMcqnrXPdYyIcNCV3kmcBNrxPE8XCgTQVzQDfIubE0
 4/rVuFROs4x7RHDC8mojpvZBBJbAnNJztYUp0hZXUhB0hgtVtIBbFa1cgitaZX39irQ6
 YfsfPK8LVrX5CuIUdKnqfQjgOgLbgUU/l05UEXeYi5xcFqLlq2Zlb6Q5A7c6KphYnDzH
 /Ai37EdAvPuzGAE+aUG3wyrXX/qq+Tr9gMKRkRwBMaj895lLFvjSi+wVN2KhfpnASrSS
 kimg==
X-Gm-Message-State: AOAM532Mo30mGj2sNR9QtAOM4PEIYkLS3ImDuLRemcC3bz89XwNWsMs0
 N0+nGpGYvCefs/efRmi551ee05cxi6eeC+oKmklXwKwtxaj1dNp73bOvHUzUAyNfgIFRmOBBiSY
 C6MpF0OP0qto+8fik35eMB/a/0w5cSLPGZ/krroVM8g==
X-Received: by 2002:a5d:47cd:: with SMTP id o13mr50910676wrc.669.1641473968662; 
 Thu, 06 Jan 2022 04:59:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzk/EB7gBSw+8TNfGdRn9vLKyEkOGA9jgxYXDa9oIkZ9y8w7ZQqRax7nQjOp89r1Ux1UWKooQ==
X-Received: by 2002:a5d:47cd:: with SMTP id o13mr50910672wrc.669.1641473968510; 
 Thu, 06 Jan 2022 04:59:28 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:991b:6857:5652:b903:a63b])
 by smtp.gmail.com with ESMTPSA id l2sm2111421wrs.43.2022.01.06.04.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jan 2022 04:59:27 -0800 (PST)
Date: Thu, 6 Jan 2022 07:59:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH v2] virtio_ring: Check null pointer
Message-ID: <20220106075459-mutt-send-email-mst@kernel.org>
References: <20220104151251.1988036-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
In-Reply-To: <20220104151251.1988036-1-jiasheng@iscas.ac.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Jan 04, 2022 at 11:12:51PM +0800, Jiasheng Jiang wrote:
> As the alloc_indirect_packed() returns kmalloc_array() that could
> allocation fail and return null pointer, it should be check in order to
> prevent the dereference of null pointer.
> 
> Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>


Well upstream has:

    virtio_ring: check desc == NULL when using indirect with packed

so this no longer applies.
I think we do need to fix it: the END_USE is missing there.
Sending a patch.


> ---
> v2: Remove the redundant empty line.
> ---
>  drivers/virtio/virtio_ring.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 71e16b53e9c1..2923d8a68dc3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -992,6 +992,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  
>  	head = vq->packed.next_avail_idx;
>  	desc = alloc_indirect_packed(total_sg, gfp);
> +	if (!desc) {
> +		END_USE(vq);
> +		return -ENOMEM;
> +	}
>  
>  	if (unlikely(vq->vq.num_free < 1)) {
>  		pr_debug("Can't add buf len 1 - avail = 0\n");
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
