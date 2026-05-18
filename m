Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5233E51D2
	for <virtualization@lists.linux.dev>; Mon, 18 May 2026 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095916; cv=none; b=rmRIQHv2rlxyaFlVqITiQC8Dvws73wVCo1owWkL2KDyb2lP5FUkUzme3KnZqhw+FmJIbYetaIMU7sBKvphFbVJZF8Kqopz/MsCEy5/eLHgLps/QCoRShJjpBP+GaLFbtenXpnNhmCrYJaB+ojcJb/1WAg++soWahVzVq2JbibuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095916; c=relaxed/simple;
	bh=+8/VJhhwAWRz5iKAyGx7YnwI1nUcMidMBg/lFGhMB3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=izgpWOD8yK9o6SvUaBOdPpCSViMZMqzYFfM5YzbtZSFFrHvrVXirdtIh57ycjcuvxj1AtMnjOB/+4on1WNpU+8f0+3MMU54a8hJ5qTIn50T9JTQnq2gxtF3fsvR0W2pdM/eWMMPT4m4XExbaAIFMxOusIT8TNSKVsnlNmOuG4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PId+cVhc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PId+cVhc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EqKUKOs8Xdi2Db46H+lGN1qYJFfdvrNsugQmOuQMj5w=;
	b=PId+cVhcgwMKOdro6Jy6rhfc+CnHqw3eB5SoHnufgcN15SYlE5KLieI2AxH3zpSD5Lp43+
	NiZfVcRvhYw7WAP2YwMRtDqWYX1xIyV0G6lvHH14NJZ6lVaHVmS4BCXZfkM21adwK/7orI
	+tNi95HlxCdNyWmImGWLDhXmPjYdtQg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-9evmw3g6McCMDBjRKX5JZw-1; Mon, 18 May 2026 05:18:31 -0400
X-MC-Unique: 9evmw3g6McCMDBjRKX5JZw-1
X-Mimecast-MFC-AGG-ID: 9evmw3g6McCMDBjRKX5JZw_1779095911
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48e79219704so17187625e9.1
        for <virtualization@lists.linux.dev>; Mon, 18 May 2026 02:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095911; x=1779700711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqKUKOs8Xdi2Db46H+lGN1qYJFfdvrNsugQmOuQMj5w=;
        b=lB8VjsRKB772/NBo/Ipr9mnkZ/iRMhNxJZNQSEI0+upJICJFn4bvVcDnkgv1i5oILv
         Tfgz3rRGeaJbeMGd7BE3zKnhMaqE1DLcAbBqX4AXV+L29M+wWvfcPS87cTj+nBJFNWzK
         AP/pKFroHAZHUXCc6n3XD3rbv76lQo5Pw7ZLk98uMSTEBiCBuiftt/l769RZ/1HbsuRM
         AWRd9d3wFZ1g1NZ4R5aCgkNd6rUfRP5fn5GfHi00DrnfwKDvwSjVJ+f0YFPtGcEHGiIi
         tzzkE8eXOkEYJ77vWoEWcVtC4lqo9H/PJfuxkYq8sW5Enc67b4WyJyT1na+aYMk2/+Pm
         64KA==
X-Forwarded-Encrypted: i=1; AFNElJ9mx/1d+0Ztfi6wBv5Y61Pla7skPmgbxYp5Go5ztE7AYg1q/0nveCUMppr5/ZGQLIepY7lquL0JAjDNDrmh7w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyt0N/d4YUPK7sW9+q9a+3qsu/SPzi0Ic5D5X68yoUx15FYTFsp
	1ZYSmAkgKIWp3s/JYCJkqjthlF+WYXiP72DsuDgjo2UTpyykM+jNEi6bwybJtIRdCcO6ceKgWsx
	ii0LNOFMwbC14f8/YpVRGHSgrFhxAIZKS4OhW/pkCkmPqe2Bk1lutPnvFCIYWNfNzAFGM
X-Gm-Gg: Acq92OHdNINcfq7rxdHufNNBP8vuF48FmcQ7oVbu453vI5+nfAC2RoKIYuneYKpHqGD
	s3idSn7AYHgLWstPR47bcMByjdfrlNc2bkzoBqVUyAxjD4idNeT/DM/5bHx9ks3q876HsHQaa8q
	im8SxQhyYqA1OUm2H63BeeylF0smGVbM7hGgnGEZ0ZOCHM+AeA33DHCqxGLR295Nk0+CbNzFelo
	3vZrrGn9qKCwUMbPyxK10tps3GikAM3Nv8HwPHDEpZvXiCpnTBNgsDSo4bfpgTPlvinRiY3BNM1
	9AaXf/1ERs7jbGeSbAFubI5HVs7ZdO4/zjKEnfH9Nuj1UtUnYYIbSRGhNL7Xq2feqKJ70Jg8FG4
	8IF40WwJHsibO9RAB4oTVCj67Cks3EUM7nso0h/BWLue2jTh9gutXOFCBt8k+HPZ2vvIMRZmUsw
	==
X-Received: by 2002:a05:600c:35cc:b0:48f:fe2a:107b with SMTP id 5b1f17b1804b1-48ffe2a1125mr137667275e9.7.1779095910554;
        Mon, 18 May 2026 02:18:30 -0700 (PDT)
X-Received: by 2002:a05:600c:35cc:b0:48f:fe2a:107b with SMTP id 5b1f17b1804b1-48ffe2a1125mr137666435e9.7.1779095910029;
        Mon, 18 May 2026 02:18:30 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57944c1sm263396765e9.7.2026.05.18.02.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:18:29 -0700 (PDT)
Date: Mon, 18 May 2026 11:18:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Message-ID: <agrXvCtNRlySlwgx@sgarzare-redhat>
References: <20260514092948.268720-1-sgarzare@redhat.com>
 <20260516125329.7b699c6f@pumpkin>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260516125329.7b699c6f@pumpkin>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: daEReeTQouLb6HWtfP5Ex55LhQ7gQBehzXfUenYSlgo_1779095911
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, May 16, 2026 at 12:53:29PM +0100, David Laight wrote:
>On Thu, 14 May 2026 11:29:48 +0200
>Stefano Garzarella <sgarzare@redhat.com> wrote:
>
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> When a large message is fragmented into multiple skbs, the zerocopy
>> uarg is only allocated and attached to the last skb in the loop.
>> Non-final skbs carry pinned user pages with no completion tracking,
>> so the kernel has no way to notify userspace when those pages are safe
>> to reuse. If the loop breaks early the uarg is never allocated at all,
>> leaking pinned pages with no completion notification.
>>
>> Fix this by following the approach used by TCP: allocate the zerocopy
>> uarg (if not provided by the caller) before the send loop and attach
>> it to every skb via skb_zcopy_set(), which takes a reference per skb.
>> Each skb's completion properly decrements the refcount, and the
>> notification only fires after the last skb is freed.
>> On failure, if no data was sent, the uarg is cleanly aborted via
>> net_zcopy_put_abort().
>>
>> This issue was initially discovered by sashiko while reviewing commit
>> 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
>> but was pre-existing.
>>
>> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>> Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
>> Reported-by: Maher Azzouzi <maherazz04@gmail.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
>>  1 file changed, 34 insertions(+), 49 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 989cc252d3d3..1e3409d28164 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>>  	return true;
>>  }
>>
>> -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>> -					   struct sk_buff *skb,
>> -					   struct msghdr *msg,
>> -					   size_t pkt_len,
>> -					   bool zerocopy)
>> -{
>> -	struct ubuf_info *uarg;
>> -
>> -	if (msg->msg_ubuf) {
>> -		uarg = msg->msg_ubuf;
>> -		net_zcopy_get(uarg);
>> -	} else {
>> -		struct ubuf_info_msgzc *uarg_zc;
>> -
>> -		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>> -					    pkt_len, NULL, false);
>> -		if (!uarg)
>> -			return -1;
>> -
>> -		uarg_zc = uarg_to_msgzc(uarg);
>> -		uarg_zc->zerocopy = zerocopy ? 1 : 0;
>> -	}
>> -
>> -	skb_zcopy_init(skb, uarg);
>> -
>> -	return 0;
>> -}
>> -
>>  static int virtio_transport_fill_skb(struct sk_buff *skb,
>>  				     struct virtio_vsock_pkt_info *info,
>>  				     size_t len,
>> @@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  	u32 src_cid, src_port, dst_cid, dst_port;
>>  	const struct virtio_transport *t_ops;
>>  	struct virtio_vsock_sock *vvs;
>> +	struct ubuf_info *uarg = NULL;
>>  	u32 pkt_len = info->pkt_len;
>>  	bool can_zcopy = false;
>> +	bool have_uref = false;
>>  	u32 rest_len;
>>  	int ret;
>>
>> @@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  		if (can_zcopy)
>>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
>> +
>> +		if (info->msg->msg_flags & MSG_ZEROCOPY &&
>> +		    info->op == VIRTIO_VSOCK_OP_RW) {
>> +			uarg = info->msg->msg_ubuf;
>> +
>> +			if (!uarg) {
>> +				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>> +							    pkt_len, NULL, false);
>> +				if (!uarg) {
>> +					virtio_transport_put_credit(vvs, pkt_len);
>> +					return -ENOMEM;
>> +				}
>> +
>> +				if (!can_zcopy)
>> +					uarg_to_msgzc(uarg)->zerocopy = 0;
>> +
>> +				have_uref = true;
>> +			}
>> +		}
>
>Surely that block should only be done if can_zcopy is true?
>And shouldn't something unset it if info->op != VIRTIO_VSOCK_OP_RW ?
>If the msg_zerocopy_realloc() fails then can't you just set can_zcopy to false.
>
>It info->msg->msg_buf is already set then I think you have to disable zero-copy.
>The caller has already requested a callback - and you can't add another.
>
>In any case by the end of this can_zcopy and have_uref are really the same flag.

I kept the same approach we had before, trying to make as few changes as 
possible.

All these potential issues seem to be pre-existing and should be 
eventually  addressed in other patches IMHO. This patch one only 
resolves the main issue of calling `skb_zcopy_set()` for every skb to 
avoid leaking pages, etc.

@Arseniy can you help on this?

>
>>  	}
>>
>>  	rest_len = pkt_len;
>> @@ -378,27 +371,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  			break;
>>  		}
>>
>> -		/* We process buffer part by part, allocating skb on
>> -		 * each iteration. If this is last skb for this buffer
>> -		 * and MSG_ZEROCOPY mode is in use - we must allocate
>> -		 * completion for the current syscall.
>> -		 *
>> -		 * Pass pkt_len because msg iter is already consumed
>> -		 * by virtio_transport_fill_skb(), so iter->count
>> -		 * can not be used for RLIMIT_MEMLOCK pinned-pages
>> -		 * accounting done by msg_zerocopy_realloc().
>> -		 */
>> -		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
>> -		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
>> -			if (virtio_transport_init_zcopy_skb(vsk, skb,
>> -							    info->msg,
>> -							    pkt_len,
>> -							    can_zcopy)) {
>> -				kfree_skb(skb);
>> -				ret = -ENOMEM;
>> -				break;
>> -			}
>> -		}
>> +		skb_zcopy_set(skb, uarg, NULL);
>>
>>  		virtio_transport_inc_tx_pkt(vvs, skb);
>>
>> @@ -422,6 +395,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>
>>  	virtio_transport_put_credit(vvs, rest_len);
>>
>> +	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
>> +	 * skb_zcopy_set() increases it for each skb, so we can drop that
>                                                            ^ must
>
>> +	 * initial reference to keep it balanced.
>> +	 */
>> +	if (have_uref) {
>> +		if (rest_len == pkt_len)
>> +			/* No data sent, abort the notification. */
>> +			net_zcopy_put_abort(uarg, true);
>
>Is it worth optimising for the 'nothing sent' case ?

What do you suggest doing?

I followed what TCP does.

Thanks,
Stefano

>
>-- David
>
>> +		else
>> +			net_zcopy_put(uarg);
>> +	}
>> +
>>  	/* Return number of bytes, if any data has been sent. */
>>  	if (rest_len != pkt_len)
>>  		ret = pkt_len - rest_len;
>

