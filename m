Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA53C433EF
	for <virtualization@archiver.kernel.org>; Thu,  6 Jan 2022 13:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9C1E6FBEA;
	Thu,  6 Jan 2022 13:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h84Lwwmpq8FD; Thu,  6 Jan 2022 13:05:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6BF366FB91;
	Thu,  6 Jan 2022 13:05:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4139CC0030;
	Thu,  6 Jan 2022 13:05:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10459C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 13:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E01F440A1E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 13:05:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NrhbzC3hJtSK
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 13:05:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4455140A1C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 13:05:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R751e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V16OQba_1641474307; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V16OQba_1641474307) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 06 Jan 2022 21:05:07 +0800
MIME-Version: 1.0
message-id: <1641474294.475928-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH] virtio_ring: mark ring unused on error
date: Thu, 06 Jan 2022 21:04:54 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Michael S. Tsirkin <mst@redhat.com>
in-reply-to: <20220106130046.422417-1-mst@redhat.com>
Cc: Jiasheng Jiang <jiasheng@iscas.ac.cn>, linux-kernel@vger.kernel.org,
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

On Thu, 6 Jan 2022 08:00:48 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> A recently added error path does not mark ring unused when exiting on
> OOM, which will lead to BUG on the next entry in debug builds.
>
> TODO: refactor code so we have START_USE and END_USE in the same function.
>
> Fixes: fc6d70f40b3d ("virtio_ring: check desc == NULL when using indirect with packed")
> Cc: "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>
> Cc: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


LGTM

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio_ring.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 028b05d44546..962f1477b1fa 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1197,8 +1197,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	if (virtqueue_use_indirect(_vq, total_sg)) {
>  		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
>  						    in_sgs, data, gfp);
> -		if (err != -ENOMEM)
> +		if (err != -ENOMEM) {
> +			END_USE(vq);
>  			return err;
> +		}
>
>  		/* fall back on direct */
>  	}
> --
> MST
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
