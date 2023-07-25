Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F090BC41513
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 11:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 807BB60EC6;
	Tue, 25 Jul 2023 11:59:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 807BB60EC6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XyGr+Wq7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1-SV1JSetE7o; Tue, 25 Jul 2023 11:59:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 958EE60A65;
	Tue, 25 Jul 2023 11:59:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 958EE60A65
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64942C0071;
	Tue, 25 Jul 2023 11:59:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E71D4C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 11:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B406981A46
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 11:59:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B406981A46
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XyGr+Wq7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wX8HMZ9fmXBI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 11:59:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56F7481A24
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 11:59:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56F7481A24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690286368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=okOn5qk+Zagsc1jw31M9EPwgSZHJ2cIbfpv9vwx0KEI=;
 b=XyGr+Wq7UUvWkza6KgzBEgwWrqsqKZVSp3BCTBEsJRVjpweKAAf+83EcANSVUNoY2WnXwu
 hxc9AuIXXjCLbpwfNaQ/fCB/cvnjLIGzeEXmRUCs0uDFTbOU1AKiozULHr/iTiGTWuOxV9
 J0StE+YXQh6DNMvQP1wPulMBv18ZU2o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-9lFb-KMONbGEPdG0VqJW3Q-1; Tue, 25 Jul 2023 07:59:24 -0400
X-MC-Unique: 9lFb-KMONbGEPdG0VqJW3Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a35b0d4ceso372214166b.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 04:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690286363; x=1690891163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okOn5qk+Zagsc1jw31M9EPwgSZHJ2cIbfpv9vwx0KEI=;
 b=LNl2AucaMVYG9J/I4FR9qkL6X1OD1mauoZSZEDG4t90bau1/0TBbOJEuSF4iAaOiYf
 IH542lZnk2PgQ/rdbTFOgdOto66g1kzATjJX2e8hb03/Cl6KeutsTdNU6u1AILvXq9k3
 Fk9WFDT/PBRYW1ovE61179ftss1E43uDikVULPMF3yuwxU9jGPwAZ0mdiyPmJjYCFBec
 jqq3yJj9Px3W4STsy3ZcbbpmIz7wUAo62sWkoT2lBwbMLXwBnCMedii1k5tRWTHbGFZL
 mY7UFixh+47hiRg/ML6X7LeRaiNDLh3Z0Jl/MEh7FwAAI7i85lPgkgo+JeAuPAcE0fSc
 E+7w==
X-Gm-Message-State: ABy/qLZxp6bZppkSmwcnummEfHdGHsXYqWpGH24V+dbJyTAT8kdjSdy9
 c9MbruXKarwoWlRlyxzuU8vu71egsK2cP0R14OopZPTEdUT+ORi0uAjAmVHfN5x2na85fbXrxRr
 W8fEz4FOHHjKKY7Qehw1lW8h1INFrEfyX261zjoTofA==
X-Received: by 2002:a17:906:3109:b0:99b:4afc:7714 with SMTP id
 9-20020a170906310900b0099b4afc7714mr11389924ejx.44.1690286363394; 
 Tue, 25 Jul 2023 04:59:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFcBFPECD/gB4CgUpUfzaQesVnrrPtk87fMcijld0tKdhJuFTlgm2OqfQP3ItOCTbdR2a2Bgg==
X-Received: by 2002:a17:906:3109:b0:99b:4afc:7714 with SMTP id
 9-20020a170906310900b0099b4afc7714mr11389907ejx.44.1690286362980; 
 Tue, 25 Jul 2023 04:59:22 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 o6-20020a170906288600b00992b0745548sm8136912ejd.152.2023.07.25.04.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 04:59:22 -0700 (PDT)
Date: Tue, 25 Jul 2023 07:59:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v3 4/4] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <20230725075413-mutt-send-email-mst@kernel.org>
References: <20230720214245.457298-1-AVKrasnov@sberdevices.ru>
 <20230720214245.457298-5-AVKrasnov@sberdevices.ru>
 <20230725042452-mutt-send-email-mst@kernel.org>
 <f0a48597-801c-2d7e-9b8c-27bc8587ad49@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <f0a48597-801c-2d7e-9b8c-27bc8587ad49@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Tue, Jul 25, 2023 at 11:39:22AM +0300, Arseniy Krasnov wrote:
> 
> 
> On 25.07.2023 11:25, Michael S. Tsirkin wrote:
> > On Fri, Jul 21, 2023 at 12:42:45AM +0300, Arseniy Krasnov wrote:
> >> This adds handling of MSG_ZEROCOPY flag on transmission path: if this
> >> flag is set and zerocopy transmission is possible (enabled in socket
> >> options and transport allows zerocopy), then non-linear skb will be
> >> created and filled with the pages of user's buffer. Pages of user's
> >> buffer are locked in memory by 'get_user_pages()'. Second thing that
> >> this patch does is replace type of skb owning: instead of calling
> >> 'skb_set_owner_sk_safe()' it calls 'skb_set_owner_w()'. Reason of this
> >> change is that '__zerocopy_sg_from_iter()' increments 'sk_wmem_alloc'
> >> of socket, so to decrease this field correctly proper skb destructor is
> >> needed: 'sock_wfree()'. This destructor is set by 'skb_set_owner_w()'.
> >>
> >> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >> ---
> >>  Changelog:
> >>  v5(big patchset) -> v1:
> >>   * Refactorings of 'if' conditions.
> >>   * Remove extra blank line.
> >>   * Remove 'frag_off' field unneeded init.
> >>   * Add function 'virtio_transport_fill_skb()' which fills both linear
> >>     and non-linear skb with provided data.
> >>  v1 -> v2:
> >>   * Use original order of last four arguments in 'virtio_transport_alloc_skb()'.
> >>  v2 -> v3:
> >>   * Add new transport callback: 'msgzerocopy_check_iov'. It checks that
> >>     provided 'iov_iter' with data could be sent in a zerocopy mode.
> >>     If this callback is not set in transport - transport allows to send
> >>     any 'iov_iter' in zerocopy mode. Otherwise - if callback returns 'true'
> >>     then zerocopy is allowed. Reason of this callback is that in case of
> >>     G2H transmission we insert whole skb to the tx virtio queue and such
> >>     skb must fit to the size of the virtio queue to be sent in a single
> >>     iteration (may be tx logic in 'virtio_transport.c' could be reworked
> >>     as in vhost to support partial send of current skb). This callback
> >>     will be enabled only for G2H path. For details pls see comment 
> >>     'Check that tx queue...' below.
> >>
> >>  include/net/af_vsock.h                  |   3 +
> >>  net/vmw_vsock/virtio_transport.c        |  39 ++++
> >>  net/vmw_vsock/virtio_transport_common.c | 257 ++++++++++++++++++------
> >>  3 files changed, 241 insertions(+), 58 deletions(-)
> >>
> >> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> >> index 0e7504a42925..a6b346eeeb8e 100644
> >> --- a/include/net/af_vsock.h
> >> +++ b/include/net/af_vsock.h
> >> @@ -177,6 +177,9 @@ struct vsock_transport {
> >>  
> >>  	/* Read a single skb */
> >>  	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
> >> +
> >> +	/* Zero-copy. */
> >> +	bool (*msgzerocopy_check_iov)(const struct iov_iter *);
> >>  };
> >>  
> >>  /**** CORE ****/
> >> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> >> index 7bbcc8093e51..23cb8ed638c4 100644
> >> --- a/net/vmw_vsock/virtio_transport.c
> >> +++ b/net/vmw_vsock/virtio_transport.c
> >> @@ -442,6 +442,43 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
> >>  	queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> >>  }
> >>  
> >> +static bool virtio_transport_msgzerocopy_check_iov(const struct iov_iter *iov)
> >> +{
> >> +	struct virtio_vsock *vsock;
> >> +	bool res = false;
> >> +
> >> +	rcu_read_lock();
> >> +
> >> +	vsock = rcu_dereference(the_virtio_vsock);
> >> +	if (vsock) {
> >> +		struct virtqueue *vq;
> >> +		int iov_pages;
> >> +
> >> +		vq = vsock->vqs[VSOCK_VQ_TX];
> >> +
> >> +		iov_pages = round_up(iov->count, PAGE_SIZE) / PAGE_SIZE;
> >> +
> >> +		/* Check that tx queue is large enough to keep whole
> >> +		 * data to send. This is needed, because when there is
> >> +		 * not enough free space in the queue, current skb to
> >> +		 * send will be reinserted to the head of tx list of
> >> +		 * the socket to retry transmission later, so if skb
> >> +		 * is bigger than whole queue, it will be reinserted
> >> +		 * again and again, thus blocking other skbs to be sent.
> >> +		 * Each page of the user provided buffer will be added
> >> +		 * as a single buffer to the tx virtqueue, so compare
> >> +		 * number of pages against maximum capacity of the queue.
> >> +		 * +1 means buffer for the packet header.
> >> +		 */
> >> +		if (iov_pages + 1 <= vq->num_max)
> >> +			res = true;
> > 
> > 
> > Yes but can't there already be buffers in the queue?
> > Then you can't stick num_max there.
> 
> I think, that it is not critical, because vhost part always tries to process all
> incoming buffers (yes, 'vhost_exceeds_weight()' breaks at some moment, but it will
> reschedule tx kick ('vhost_vsock_handle_tx_kick()') work again), so current "too
> big" skb will wait until there will be enough space in queue and as it is requeued
> to the head of tx list it will be inserted to tx queue first.
> 
> But anyway, I agree that comparing to 'num_free' may be more effective to the whole
> system performance...
> 
> Thanks, Arseniy

Oh I see. It makes sense then - instead of copying just so we can
stick it in the queue, wait a bit and send later.
Also - for stream transports can't the message be split
and sent chunk by chunk? Better than copying ...


> > 
> > 
> >> +	}
> >> +
> >> +	rcu_read_unlock();
> >> +
> >> +	return res;
> >> +}
> >> +
> >>  static bool virtio_transport_seqpacket_allow(u32 remote_cid);
> >>  
> >>  static struct virtio_transport virtio_transport = {
> >> @@ -475,6 +512,8 @@ static struct virtio_transport virtio_transport = {
> >>  		.seqpacket_allow          = virtio_transport_seqpacket_allow,
> >>  		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
> >>  
> >> +		.msgzerocopy_check_iov	  = virtio_transport_msgzerocopy_check_iov,
> >> +
> >>  		.notify_poll_in           = virtio_transport_notify_poll_in,
> >>  		.notify_poll_out          = virtio_transport_notify_poll_out,
> >>  		.notify_recv_init         = virtio_transport_notify_recv_init,
> >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >> index 26a4d10da205..e4e3d541aff4 100644
> >> --- a/net/vmw_vsock/virtio_transport_common.c
> >> +++ b/net/vmw_vsock/virtio_transport_common.c
> >> @@ -37,73 +37,122 @@ virtio_transport_get_ops(struct vsock_sock *vsk)
> >>  	return container_of(t, struct virtio_transport, transport);
> >>  }
> >>  
> >> -/* Returns a new packet on success, otherwise returns NULL.
> >> - *
> >> - * If NULL is returned, errp is set to a negative errno.
> >> - */
> >> -static struct sk_buff *
> >> -virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> >> -			   size_t len,
> >> -			   u32 src_cid,
> >> -			   u32 src_port,
> >> -			   u32 dst_cid,
> >> -			   u32 dst_port)
> >> -{
> >> -	const size_t skb_len = VIRTIO_VSOCK_SKB_HEADROOM + len;
> >> -	struct virtio_vsock_hdr *hdr;
> >> -	struct sk_buff *skb;
> >> -	void *payload;
> >> -	int err;
> >> +static bool virtio_transport_can_zcopy(struct virtio_vsock_pkt_info *info,
> >> +				       size_t max_to_send)
> >> +{
> >> +	const struct vsock_transport *t;
> >> +	struct iov_iter *iov_iter;
> >>  
> >> -	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
> >> -	if (!skb)
> >> -		return NULL;
> >> +	if (!info->msg)
> >> +		return false;
> >>  
> >> -	hdr = virtio_vsock_hdr(skb);
> >> -	hdr->type	= cpu_to_le16(info->type);
> >> -	hdr->op		= cpu_to_le16(info->op);
> >> -	hdr->src_cid	= cpu_to_le64(src_cid);
> >> -	hdr->dst_cid	= cpu_to_le64(dst_cid);
> >> -	hdr->src_port	= cpu_to_le32(src_port);
> >> -	hdr->dst_port	= cpu_to_le32(dst_port);
> >> -	hdr->flags	= cpu_to_le32(info->flags);
> >> -	hdr->len	= cpu_to_le32(len);
> >> +	iov_iter = &info->msg->msg_iter;
> >>  
> >> -	if (info->msg && len > 0) {
> >> -		payload = skb_put(skb, len);
> >> -		err = memcpy_from_msg(payload, info->msg, len);
> >> -		if (err)
> >> -			goto out;
> >> +	t = vsock_core_get_transport(info->vsk);
> >>  
> >> -		if (msg_data_left(info->msg) == 0 &&
> >> -		    info->type == VIRTIO_VSOCK_TYPE_SEQPACKET) {
> >> -			hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
> >> +	if (t->msgzerocopy_check_iov &&
> >> +	    !t->msgzerocopy_check_iov(iov_iter))
> >> +		return false;
> >>  
> >> -			if (info->msg->msg_flags & MSG_EOR)
> >> -				hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
> >> -		}
> >> +	/* Data is simple buffer. */
> >> +	if (iter_is_ubuf(iov_iter))
> >> +		return true;
> >> +
> >> +	if (!iter_is_iovec(iov_iter))
> >> +		return false;
> >> +
> >> +	if (iov_iter->iov_offset)
> >> +		return false;
> >> +
> >> +	/* We can't send whole iov. */
> >> +	if (iov_iter->count > max_to_send)
> >> +		return false;
> >> +
> >> +	return true;
> >> +}
> >> +
> >> +static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
> >> +					   struct sk_buff *skb,
> >> +					   struct msghdr *msg,
> >> +					   bool zerocopy)
> >> +{
> >> +	struct ubuf_info *uarg;
> >> +
> >> +	if (msg->msg_ubuf) {
> >> +		uarg = msg->msg_ubuf;
> >> +		net_zcopy_get(uarg);
> >> +	} else {
> >> +		struct iov_iter *iter = &msg->msg_iter;
> >> +		struct ubuf_info_msgzc *uarg_zc;
> >> +		int len;
> >> +
> >> +		/* Only ITER_IOVEC or ITER_UBUF are allowed and
> >> +		 * checked before.
> >> +		 */
> >> +		if (iter_is_iovec(iter))
> >> +			len = iov_length(iter->__iov, iter->nr_segs);
> >> +		else
> >> +			len = iter->count;
> >> +
> >> +		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> >> +					    len,
> >> +					    NULL);
> >> +		if (!uarg)
> >> +			return -1;
> >> +
> >> +		uarg_zc = uarg_to_msgzc(uarg);
> >> +		uarg_zc->zerocopy = zerocopy ? 1 : 0;
> >>  	}
> >>  
> >> -	if (info->reply)
> >> -		virtio_vsock_skb_set_reply(skb);
> >> +	skb_zcopy_init(skb, uarg);
> >>  
> >> -	trace_virtio_transport_alloc_pkt(src_cid, src_port,
> >> -					 dst_cid, dst_port,
> >> -					 len,
> >> -					 info->type,
> >> -					 info->op,
> >> -					 info->flags);
> >> +	return 0;
> >> +}
> >>  
> >> -	if (info->vsk && !skb_set_owner_sk_safe(skb, sk_vsock(info->vsk))) {
> >> -		WARN_ONCE(1, "failed to allocate skb on vsock socket with sk_refcnt == 0\n");
> >> -		goto out;
> >> +static int virtio_transport_fill_skb(struct sk_buff *skb,
> >> +				     struct virtio_vsock_pkt_info *info,
> >> +				     size_t len,
> >> +				     bool zcopy)
> >> +{
> >> +	if (zcopy) {
> >> +		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
> >> +					      &info->msg->msg_iter,
> >> +					      len);
> >> +	} else {
> >> +		void *payload;
> >> +		int err;
> >> +
> >> +		payload = skb_put(skb, len);
> >> +		err = memcpy_from_msg(payload, info->msg, len);
> >> +		if (err)
> >> +			return -1;
> >> +
> >> +		if (msg_data_left(info->msg))
> >> +			return 0;
> >> +
> >> +		return 0;
> >>  	}
> >> +}
> >>  
> >> -	return skb;
> >> +static void virtio_transport_init_hdr(struct sk_buff *skb,
> >> +				      struct virtio_vsock_pkt_info *info,
> >> +				      u32 src_cid,
> >> +				      u32 src_port,
> >> +				      u32 dst_cid,
> >> +				      u32 dst_port,
> >> +				      size_t len)
> >> +{
> >> +	struct virtio_vsock_hdr *hdr;
> >>  
> >> -out:
> >> -	kfree_skb(skb);
> >> -	return NULL;
> >> +	hdr = virtio_vsock_hdr(skb);
> >> +	hdr->type	= cpu_to_le16(info->type);
> >> +	hdr->op		= cpu_to_le16(info->op);
> >> +	hdr->src_cid	= cpu_to_le64(src_cid);
> >> +	hdr->dst_cid	= cpu_to_le64(dst_cid);
> >> +	hdr->src_port	= cpu_to_le32(src_port);
> >> +	hdr->dst_port	= cpu_to_le32(dst_port);
> >> +	hdr->flags	= cpu_to_le32(info->flags);
> >> +	hdr->len	= cpu_to_le32(len);
> >>  }
> >>  
> >>  static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
> >> @@ -214,6 +263,70 @@ static u16 virtio_transport_get_type(struct sock *sk)
> >>  		return VIRTIO_VSOCK_TYPE_SEQPACKET;
> >>  }
> >>  
> >> +static struct sk_buff *virtio_transport_alloc_skb(struct vsock_sock *vsk,
> >> +						  struct virtio_vsock_pkt_info *info,
> >> +						  size_t payload_len,
> >> +						  bool zcopy,
> >> +						  u32 src_cid,
> >> +						  u32 src_port,
> >> +						  u32 dst_cid,
> >> +						  u32 dst_port)
> >> +{
> >> +	struct sk_buff *skb;
> >> +	size_t skb_len;
> >> +
> >> +	skb_len = VIRTIO_VSOCK_SKB_HEADROOM;
> >> +
> >> +	if (!zcopy)
> >> +		skb_len += payload_len;
> >> +
> >> +	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
> >> +	if (!skb)
> >> +		return NULL;
> >> +
> >> +	virtio_transport_init_hdr(skb, info, src_cid, src_port,
> >> +				  dst_cid, dst_port,
> >> +				  payload_len);
> >> +
> >> +	/* Set owner here, because '__zerocopy_sg_from_iter()' uses
> >> +	 * owner of skb without check to update 'sk_wmem_alloc'.
> >> +	 */
> >> +	if (vsk)
> >> +		skb_set_owner_w(skb, sk_vsock(vsk));
> >> +
> >> +	if (info->msg && payload_len > 0) {
> >> +		int err;
> >> +
> >> +		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
> >> +		if (err)
> >> +			goto out;
> >> +
> >> +		if (info->type == VIRTIO_VSOCK_TYPE_SEQPACKET) {
> >> +			struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >> +
> >> +			hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
> >> +
> >> +			if (info->msg->msg_flags & MSG_EOR)
> >> +				hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
> >> +		}
> >> +	}
> >> +
> >> +	if (info->reply)
> >> +		virtio_vsock_skb_set_reply(skb);
> >> +
> >> +	trace_virtio_transport_alloc_pkt(src_cid, src_port,
> >> +					 dst_cid, dst_port,
> >> +					 payload_len,
> >> +					 info->type,
> >> +					 info->op,
> >> +					 info->flags);
> >> +
> >> +	return skb;
> >> +out:
> >> +	kfree_skb(skb);
> >> +	return NULL;
> >> +}
> >> +
> >>  /* This function can only be used on connecting/connected sockets,
> >>   * since a socket assigned to a transport is required.
> >>   *
> >> @@ -222,10 +335,12 @@ static u16 virtio_transport_get_type(struct sock *sk)
> >>  static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> >>  					  struct virtio_vsock_pkt_info *info)
> >>  {
> >> +	u32 max_skb_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
> >>  	u32 src_cid, src_port, dst_cid, dst_port;
> >>  	const struct virtio_transport *t_ops;
> >>  	struct virtio_vsock_sock *vvs;
> >>  	u32 pkt_len = info->pkt_len;
> >> +	bool can_zcopy = false;
> >>  	u32 rest_len;
> >>  	int ret;
> >>  
> >> @@ -254,15 +369,30 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> >>  	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
> >>  		return pkt_len;
> >>  
> >> +	if (info->msg) {
> >> +		/* If zerocopy is not enabled by 'setsockopt()', we behave as
> >> +		 * there is no MSG_ZEROCOPY flag set.
> >> +		 */
> >> +		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
> >> +			info->msg->msg_flags &= ~MSG_ZEROCOPY;
> >> +
> >> +		if (info->msg->msg_flags & MSG_ZEROCOPY)
> >> +			can_zcopy = virtio_transport_can_zcopy(info, pkt_len);
> >> +
> >> +		if (can_zcopy)
> >> +			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
> >> +					    (MAX_SKB_FRAGS * PAGE_SIZE));
> >> +	}
> >> +
> >>  	rest_len = pkt_len;
> >>  
> >>  	do {
> >>  		struct sk_buff *skb;
> >>  		size_t skb_len;
> >>  
> >> -		skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE, rest_len);
> >> +		skb_len = min(max_skb_len, rest_len);
> >>  
> >> -		skb = virtio_transport_alloc_skb(info, skb_len,
> >> +		skb = virtio_transport_alloc_skb(vsk, info, skb_len, can_zcopy,
> >>  						 src_cid, src_port,
> >>  						 dst_cid, dst_port);
> >>  		if (!skb) {
> >> @@ -270,6 +400,17 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> >>  			break;
> >>  		}
> >>  
> >> +		/* This is last skb to send this portion of data. */
> >> +		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
> >> +		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
> >> +			if (virtio_transport_init_zcopy_skb(vsk, skb,
> >> +							    info->msg,
> >> +							    can_zcopy)) {
> >> +				ret = -ENOMEM;
> >> +				break;
> >> +			}
> >> +		}
> >> +
> >>  		virtio_transport_inc_tx_pkt(vvs, skb);
> >>  
> >>  		ret = t_ops->send_pkt(skb);
> >> @@ -934,7 +1075,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> >>  	if (!t)
> >>  		return -ENOTCONN;
> >>  
> >> -	reply = virtio_transport_alloc_skb(&info, 0,
> >> +	reply = virtio_transport_alloc_skb(NULL, &info, 0, false,
> >>  					   le64_to_cpu(hdr->dst_cid),
> >>  					   le32_to_cpu(hdr->dst_port),
> >>  					   le64_to_cpu(hdr->src_cid),
> >> -- 
> >> 2.25.1
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
