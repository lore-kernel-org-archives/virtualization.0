Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3A2C05027
	for <virtualization@archiver.kernel.org>; Fri, 20 Jan 2023 12:54:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D12A641CCE;
	Fri, 20 Jan 2023 12:54:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D12A641CCE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hLJ7ZHjH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ok2EHwCm3-vK; Fri, 20 Jan 2023 12:54:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1C55741A6D;
	Fri, 20 Jan 2023 12:54:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C55741A6D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD1C0C0033;
	Fri, 20 Jan 2023 12:54:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07919C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4B8560EAA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:54:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4B8560EAA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hLJ7ZHjH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fksnajzthh83
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:54:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC86A60D61
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC86A60D61
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674219286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Za8Y4nDbP8CWvHTQOrddwheGGIMRpuQAQh3mIFbUx8U=;
 b=hLJ7ZHjHVCc9qFL6Pg1A4EK9favrqZTpDjhQsKqvv1+YHhAoilkZvdYZgVSG+m/0jTj6jG
 at254zscVaELxGRolOc9brDTVUxLPwnIJ5x3Ts9su1ekc25tsviuyNj4EmhMe8BuFll3N/
 jCdHd05aXNFAuMLisD7agUxPoFcuhjY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-253-3vHTTLPbOUue-Bs-rc7Wuw-1; Fri, 20 Jan 2023 07:54:45 -0500
X-MC-Unique: 3vHTTLPbOUue-Bs-rc7Wuw-1
Received: by mail-wm1-f69.google.com with SMTP id
 l23-20020a7bc457000000b003db0cb8e543so1301424wmi.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 04:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Za8Y4nDbP8CWvHTQOrddwheGGIMRpuQAQh3mIFbUx8U=;
 b=EtoW0+WZvTiENoq/AWY/mQ7ypSTxvvWsRZmGcY/JOrEqyYWzH7Li+fpKo5/8QKwit5
 yVdKu4j/YDrrNDli/e/n9BsEdKW2Bxkdd0wpSFc39c0XL9+ENOc5nwk46hRNx7FAQRqY
 f4hPBrPahRZelTc9GLmsA6ebWPbU9M44pEPahPw/8TDh5QKTqkJK5OlmaWePKjchD7lV
 8opQwol07nKhw/irMzBT+px4vtltjbUTXX2fLYiTGfuSJVOFQNy9jIeyZHSQep1ptqC1
 Lg8Q6Nzk/i+B+GX7pH16mURZj1PprMC6ImT2q0HN0r+GQmHo07/sIAictjANgLAfgUu5
 d/DQ==
X-Gm-Message-State: AFqh2kpYCFk4CUN6lSVOBoWcwofebJ7ZPdMjM+avec6NjajV5Tr9ZfQf
 xRjAF0+tz2KNbObTuvNwtVCV+fDdYbXYqz3XrNo08/pWlWIdtZXxCNnv4z6m+y9TbBi2BE0XJ7v
 zUUH2Qa5JhobVCirSpYHp1rTkOj12A9pHIARnmfCCGw==
X-Received: by 2002:a05:600c:2103:b0:3d3:43ae:4d10 with SMTP id
 u3-20020a05600c210300b003d343ae4d10mr14429479wml.11.1674219284583; 
 Fri, 20 Jan 2023 04:54:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtT9yqfP8Lvim31ZX9JEKbLExcTKqA9SmCXtTx+VQEAGdKIv1O2jbkTfAw7i5Vsh2YUHhYkxQ==
X-Received: by 2002:a05:600c:2103:b0:3d3:43ae:4d10 with SMTP id
 u3-20020a05600c210300b003d343ae4d10mr14429466wml.11.1674219284369; 
 Fri, 20 Jan 2023 04:54:44 -0800 (PST)
Received: from redhat.com ([2.52.19.29]) by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c444700b003db06493ee7sm2206862wmn.47.2023.01.20.04.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jan 2023 04:54:43 -0800 (PST)
Date: Fri, 20 Jan 2023 07:54:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 3/6] virtio 9p: Fix an overflow
Message-ID: <20230120074817-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-4-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20230119135721.83345-4-alexander.shishkin@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andi Kleen <ak@linux.intel.com>, Eric Van Hensbergen <ericvh@gmail.com>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, elena.reshetova@intel.com,
 v9fs-developer@lists.sourceforge.net, kirill.shutemov@linux.intel.com
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

On Thu, Jan 19, 2023 at 03:57:18PM +0200, Alexander Shishkin wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> tag_len is read as a u16 from the untrusted host. It could overflow
> in the memory allocation, which would lead to a too small buffer.
> 
> Some later loops use it when extended to 32bit, so they could overflow
> the too small buffer.
> 
> Make sure to do the arithmetic for the buffer size in 32bit to avoid
> wrapping.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Cc: Eric Van Hensbergen <ericvh@gmail.com>
> Cc: Latchesar Ionkov <lucho@ionkov.net>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: v9fs-developer@lists.sourceforge.net
> ---
>  net/9p/trans_virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 3c27ffb781e3..a78e4d80e5ba 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -629,7 +629,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>  		err = -EINVAL;
>  		goto out_free_vq;
>  	}
> -	tag = kzalloc(tag_len + 1, GFP_KERNEL);
> +	tag = kzalloc((u32)tag_len + 1, GFP_KERNEL);
>  	if (!tag) {
>  		err = -ENOMEM;
>  		goto out_free_vq;

Hmm are you sure there's a difference in behaviour? I thought C will just
extend the integer to int.

> -- 
> 2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
