Return-Path: <SRS0=GDYi=MZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE090C4338F
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 20:13:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D5560EFF
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 20:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8D5560EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67AEF405FA;
	Mon,  2 Aug 2021 20:13:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S_v6Pd_fbDmt; Mon,  2 Aug 2021 20:13:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5BDD0405F2;
	Mon,  2 Aug 2021 20:13:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19CA1C001A;
	Mon,  2 Aug 2021 20:13:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C436C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87A15404D7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:13:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ji1soExVdRxk
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:13:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5AF940270
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627935232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lvAKbFSCFU59TOTJPC3/cAvD7UXJ3lZqXOvWWs7Do/0=;
 b=V15sAEoiBPDX8eoCD1Ebj6RvPl6Ax2sUozEaTbgbxlGCmtAus+qbv00C38x1sLPpyo7Ld8
 nJyRJ1d5J/gHqoJld9e7blqMgHy+JBbxhp3tWRQd6+WIMg3HZ8we3FKR44R2RGMqgK18T+
 TwpltQXRjoepL4JW6kLqEFRBrr8yY5s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-2oLouOm6Mv6v95a-SNocNA-1; Mon, 02 Aug 2021 16:13:49 -0400
X-MC-Unique: 2oLouOm6Mv6v95a-SNocNA-1
Received: by mail-ed1-f69.google.com with SMTP id
 eg53-20020a05640228b5b02903bd6e6f620cso2032282edb.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Aug 2021 13:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lvAKbFSCFU59TOTJPC3/cAvD7UXJ3lZqXOvWWs7Do/0=;
 b=pubNZdbC1R5owX/RRct6xOIIlTsGPcHGHWzWk2ARJebwgeYotqV7e+NriKYLOVGgfk
 SOnu1bCIqRT/X+LSvRvt7ZFi4YeTx1ifgtn3rCIEolvBm5i0oI+jTriYQxYBUWPoicQl
 DCwZE1ydyKzUf1monmMg1EkjpeX8KMIVEUDDCRE3ZmGoGLIFJ9Mq9rT362LOJo+9vQaF
 G6uMIngMrtYbleIPyDCo6JD6QqdQZO0vVCnZ8N2Ow/D/xp97nQhjwYbN2G7mu+qX3IOD
 /XhKycgDR8eHuInYpdpCr/RegjUvWgDn6NEEPDQ4ROZ68f/pG3oB03+gPF3QLj7aF9eK
 4CNA==
X-Gm-Message-State: AOAM533bUKfTeqwwj34eM+AkBPfIOs8BYr22H13Q+jS6pMQkA9n7B2RD
 L40FaI9bLYpJaoM0PvWnENckVf+Akakbmp73N/Dh7zLP0SM20yBLLi216EUHWqu9TivMXjmmc0V
 SwN1iP+yieII39Sl3UQiZACMRrvm/C+QAl7sNN5ypfA==
X-Received: by 2002:a50:9350:: with SMTP id n16mr21099673eda.176.1627935228271; 
 Mon, 02 Aug 2021 13:13:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzU6tBMdbFDrItN+Pjs2g1o8FRDEi2q6zyU0jPrfqeUAovxmkXpeJ8x0MoP+XNjVZM/InUOOA==
X-Received: by 2002:a50:9350:: with SMTP id n16mr21099649eda.176.1627935228137; 
 Mon, 02 Aug 2021 13:13:48 -0700 (PDT)
Received: from redhat.com ([2.55.140.205])
 by smtp.gmail.com with ESMTPSA id yc29sm5141187ejb.104.2021.08.02.13.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Aug 2021 13:13:47 -0700 (PDT)
Date: Mon, 2 Aug 2021 16:13:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: fuguancheng <fuguancheng@bytedance.com>
Subject: Re: [PATCH 2/4] VSOCK DRIVER: support communication using additional
 guest cid
Message-ID: <20210802161257-mutt-send-email-mst@kernel.org>
References: <20210802120720.547894-1-fuguancheng@bytedance.com>
 <20210802120720.547894-3-fuguancheng@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210802120720.547894-3-fuguancheng@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: andraprs@amazon.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, colin.king@canonical.com, kuba@kernel.org,
 arseny.krasnov@kaspersky.com, davem@davemloft.net
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

On Mon, Aug 02, 2021 at 08:07:18PM +0800, fuguancheng wrote:
> Changes in this patch are made to allow the guest communicate
> with the host using the additional cids specified when
> creating the guest.
> 
> In original settings, the packet sent with the additional CIDS will
> be rejected when received by the host, the newly added function
> vhost_vsock_contain_cid will fix this error.
> 
> Now that we have multiple CIDS, the VMADDR_CID_ANY now behaves like
> this:
> 1. The client will use the first available cid specified in the cids
> array if VMADDR_CID_ANY is used.
> 2. The host will still use the original default CID.
> 3. If a guest server binds to VMADDR_CID_ANY, then the server can
> choose to connect to any of the available CIDs for this guest.
> 
> Signed-off-by: fuguancheng <fuguancheng@bytedance.com>
> ---
>  drivers/vhost/vsock.c                   | 14 +++++++++++++-
>  net/vmw_vsock/af_vsock.c                |  2 +-
>  net/vmw_vsock/virtio_transport_common.c |  5 ++++-
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index f66c87de91b8..013f8ebf8189 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -74,6 +74,18 @@ struct vhost_vsock {
>  	bool seqpacket_allow;
>  };
>  
> +static bool
> +vhost_vsock_contain_cid(struct vhost_vsock *vsock, u32 cid)
> +{
> +	u32 index;
> +
> +	for (index = 0; index < vsock->num_cid; index++) {
> +		if (cid == vsock->cids[index])
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static u32 vhost_transport_get_local_cid(void)
>  {
>  	return VHOST_VSOCK_DEFAULT_HOST_CID;

Doing this linear scan on data path is not going to scale
well with lots of CIDs.

> @@ -584,7 +596,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>  
>  		/* Only accept correctly addressed packets */
>  		if (vsock->num_cid > 0 &&
> -		    (pkt->hdr.src_cid) == vsock->cids[0] &&
> +			vhost_vsock_contain_cid(vsock, pkt->hdr.src_cid) &&
>  		    le64_to_cpu(pkt->hdr.dst_cid) == vhost_transport_get_local_cid())
>  			virtio_transport_recv_pkt(&vhost_transport, pkt);
>  		else
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 4e1fbe74013f..c22ae7101e55 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -251,7 +251,7 @@ static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
>  	list_for_each_entry(vsk, vsock_connected_sockets(src, dst),
>  			    connected_table) {
>  		if (vsock_addr_equals_addr(src, &vsk->remote_addr) &&
> -		    dst->svm_port == vsk->local_addr.svm_port) {
> +		    vsock_addr_equals_addr(&vsk->local_addr, dst)) {
>  			return sk_vsock(vsk);
>  		}
>  	}
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 169ba8b72a63..cb45e2f801f1 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -197,7 +197,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	if (unlikely(!t_ops))
>  		return -EFAULT;
>  
> -	src_cid = t_ops->transport.get_local_cid();
> +	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> +		src_cid = vsk->local_addr.svm_cid;
> +	else
> +		src_cid = t_ops->transport.get_local_cid();
>  	src_port = vsk->local_addr.svm_port;
>  	if (!info->remote_cid) {
>  		dst_cid	= vsk->remote_addr.svm_cid;
> -- 
> 2.11.0
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
