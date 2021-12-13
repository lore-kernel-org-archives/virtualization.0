Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD51C4332F
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 06:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E67CC85A0D;
	Mon, 13 Dec 2021 06:25:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hFChUgUeEnWB; Mon, 13 Dec 2021 06:25:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7F8EA85A06;
	Mon, 13 Dec 2021 06:25:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54160C002F;
	Mon, 13 Dec 2021 06:25:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 953D9C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 06:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82D6F85A0D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 06:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KDeW_h0l2OXr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 06:25:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B1EEB85A06
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 06:25:39 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R781e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=15; SR=0; TI=SMTPD_---0V-NwA56_1639376733; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V-NwA56_1639376733) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 13 Dec 2021 14:25:34 +0800
MIME-Version: 1.0
message-id: <1639376723.603977-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH] virtio-net: make copy len check in xdp_linearize_page
date: Mon, 13 Dec 2021 14:25:23 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: mengensun8801@gmail.com
in-reply-to: <20211213045012.12757-1-mengensun@tencent.com>
x-mailing-list: bpf@vger.kernel.org
Cc: MengLong Dong <imagedong@tencent.com>, hawk@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org,
 mengensun <mengensun@tencent.com>, john.fastabend@gmail.com, ast@kernel.org,
 ZhengXiong Jiang <mungerjiang@tencent.com>,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
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

On Mon, 13 Dec 2021 12:50:12 +0800, mengensun8801@gmail.com wrote:
> From: mengensun <mengensun@tencent.com>
>
> xdp_linearize_page asume ring elem size is smaller then page size
> when copy the first ring elem, but, there may be a elem size bigger
> then page size.
>
> add_recvbuf_mergeable may add a hole to ring elem, the hole size is
> not sure, according EWMA.
>
> so, fix it by check copy len,if checked failed, just dropped the
> whole frame, not make the memory dirty after the page.
>
> Signed-off-by: mengensun <mengensun@tencent.com>
> Reviewed-by: MengLong Dong <imagedong@tencent.com>
> Reviewed-by: ZhengXiong Jiang <mungerjiang@tencent.com>

LGTM

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/net/virtio_net.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 36a4b7c195d5..844bdbd67ff7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -662,8 +662,12 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  				       int page_off,
>  				       unsigned int *len)
>  {
> -	struct page *page = alloc_page(GFP_ATOMIC);
> +	struct page *page;
>
> +	if (*len > PAGE_SIZE - page_off)
> +		return NULL;
> +
> +	page = alloc_page(GFP_ATOMIC);
>  	if (!page)
>  		return NULL;
>
> --
> 2.27.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
