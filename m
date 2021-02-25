Return-Path: <SRS0=rmzs=H3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF28BC433DB
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 17:01:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281DD64F03
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 17:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281DD64F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCEE44EEDD;
	Thu, 25 Feb 2021 17:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H_Jaoj6cAPPO; Thu, 25 Feb 2021 17:01:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3855C4EEDA;
	Thu, 25 Feb 2021 17:01:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A907C000A;
	Thu, 25 Feb 2021 17:01:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABCA5C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 17:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8868B432A3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 17:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VGU_bUG1kDOD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 17:01:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 909C043291
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 17:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614272510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvbKIoohXeRyXpBeKhyai4J6wvMoBTGi1G+ws1L6YJc=;
 b=aPaphRiReDG9ZjDYaMsRJCzuq9XOPY23Sqo+xsUF5gGByOZhzsa/TDt+51GtUJEKjFCCuX
 vK9rWU6gICVPw1If55xmEM1BpyxVndyCWqPoFCFpik0rsuhfciAs19X3Ri5+3O8MJX7OMN
 NF19b7ofb1ML4/0FcvTZOdeL8D6Kedw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-o4W_CKBAML-6ShrSM9NAlQ-1; Thu, 25 Feb 2021 12:01:33 -0500
X-MC-Unique: o4W_CKBAML-6ShrSM9NAlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CE98814303;
 Thu, 25 Feb 2021 17:01:31 +0000 (UTC)
Received: from carbon (unknown [10.36.110.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF3795C266;
 Thu, 25 Feb 2021 17:01:21 +0000 (UTC)
Date: Thu, 25 Feb 2021 18:01:20 +0100
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 net-next] virtio-net: support XDP_TX when not more
 queues
Message-ID: <20210225180120.09e8845a@carbon>
In-Reply-To: <1614241349-77324-1-git-send-email-xuanzhuo@linux.alibaba.com>
References: <1614241349-77324-1-git-send-email-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Marek Majtyka <alardam@gmail.com>, brouer@redhat.com,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Thu, 25 Feb 2021 16:22:29 +0800
Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> The number of queues implemented by many virtio backends is limited,
> especially some machines have a large number of CPUs. In this case, it
> is often impossible to allocate a separate queue for XDP_TX.
> 
> This patch allows XDP_TX to run by reuse the existing SQ with
> __netif_tx_lock() hold when there are not enough queues.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 48 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
[...]
> @@ -2416,12 +2441,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  		xdp_qp = nr_cpu_ids;
>  
>  	/* XDP requires extra queues for XDP_TX */
> -	if (curr_qp + xdp_qp > vi->max_queue_pairs) {
> -		NL_SET_ERR_MSG_MOD(extack, "Too few free TX rings available");
> -		netdev_warn(dev, "request %i queues but max is %i\n",
> -			    curr_qp + xdp_qp, vi->max_queue_pairs);
> -		return -ENOMEM;
> -	}
> +	if (curr_qp + xdp_qp > vi->max_queue_pairs)
> +		xdp_qp = 0;

I think we should keep a netdev_warn message, but as a warning (not
error) that this will cause XDP_TX and XDP_REDIRECT to be slower on
this device due to too few free TX rings available.

In the future, we can mark a XDP features flag that this device is
operating in a slower "locked" Tx mode.

>  
>  	old_prog = rtnl_dereference(vi->rq[0].xdp_prog);
>  	if (!prog && !old_prog)



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
