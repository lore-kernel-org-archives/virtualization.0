Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7650E95A86
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 02:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 328EA402F2;
	Sun,  8 Oct 2023 02:20:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 328EA402F2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E4B1y5rdU8rE; Sun,  8 Oct 2023 02:20:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3DE5440158;
	Sun,  8 Oct 2023 02:20:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DE5440158
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C999C0071;
	Sun,  8 Oct 2023 02:20:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D906CC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 02:19:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A164B60E78
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 02:19:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A164B60E78
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tmIuhk51keiW
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 02:19:56 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4A3360E32
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 02:19:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4A3360E32
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R551e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0VtcTNin_1696731589; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VtcTNin_1696731589) by smtp.aliyun-inc.com;
 Sun, 08 Oct 2023 10:19:50 +0800
Message-ID: <1696731557.4612653-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] tools/virtio: Add dma sync api for virtio test
Date: Sun, 8 Oct 2023 10:19:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: liming.wu@jaguarmicro.com
References: <20230926050021.717-1-liming.wu@jaguarmicro.com>
 <20230926050021.717-2-liming.wu@jaguarmicro.com>
 <20230927111904-mutt-send-email-mst@kernel.org>
 <20231007065547.1028-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20231007065547.1028-1-liming.wu@jaguarmicro.com>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Liming Wu <liming.wu@jaguarmicro.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat,  7 Oct 2023 14:55:46 +0800, liming.wu@jaguarmicro.com wrote:
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> Fixes: 8bd2f71054bd ("virtio_ring: introduce dma sync api for virtqueue")
> also add dma sync api for virtio test.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>

You should post a new thread.

Thanks.


> ---
>  tools/virtio/linux/dma-mapping.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-mapping.h
> index 834a90bd3270..822ecaa8e4df 100644
> --- a/tools/virtio/linux/dma-mapping.h
> +++ b/tools/virtio/linux/dma-mapping.h
> @@ -24,11 +24,23 @@ enum dma_data_direction {
>  #define dma_map_page(d, p, o, s, dir) (page_to_phys(p) + (o))
>
>  #define dma_map_single(d, p, s, dir) (virt_to_phys(p))
> +#define dma_map_single_attrs(d, p, s, dir, a) (virt_to_phys(p))
>  #define dma_mapping_error(...) (0)
>
>  #define dma_unmap_single(d, a, s, r) do { (void)(d); (void)(a); (void)(s); (void)(r); } while (0)
>  #define dma_unmap_page(d, a, s, r) do { (void)(d); (void)(a); (void)(s); (void)(r); } while (0)
>
> +#define sg_dma_address(sg) (0)
> +#define dma_need_sync(v, a) (0)
> +#define dma_unmap_single_attrs(d, a, s, r, t) do { \
> +	(void)(d); (void)(a); (void)(s); (void)(r); (void)(t); \
> +} while (0)
> +#define dma_sync_single_range_for_cpu(d, a, o, s, r) do { \
> +	(void)(d); (void)(a); (void)(o); (void)(s); (void)(r); \
> +} while (0)
> +#define dma_sync_single_range_for_device(d, a, o, s, r) do { \
> +	(void)(d); (void)(a); (void)(o); (void)(s); (void)(r); \
> +} while (0)
>  #define dma_max_mapping_size(...) SIZE_MAX
>
>  #endif
> --
> 2.34.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
