Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102814;
	b=y3YzHeslUG62A0qZkd1rPzSGdi3ew0RqxsTLOUatlRkTIlccfzV7jfu1aUnpkzSIImd9
	 95/WPiAUdHl9V1SYt34vjLOdNO+cUYdxfyxRfhYteqK5z/JSPl45WMIGAXELk9RwDVBrG
	 DGIydicWN4xyE71hF0PNmm9pGlaK1zJaY7NJJ3BgiWbQozVvjSl2+pYWMSrn2Uli6wnAM
	 qU4oU8dftOsYBBBGGOHSnhwv3LJ233PoEdzXVY752lTlvjtmz+kymeF5qD+N5uIY2mRfa
	 EAlhOblrAYjN5VVDVZHU5LGyl3f0V+9Mnra+O0wcUKM1ZDhSWur57lQaXvTnhYR5a9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102814;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=g8KMQj2HsPBF8Jjs/G4X6DPysUQ80f4vvkU0TZL7PsU=;
	b=r0e089ONWuMFdc9ijyXTEorbUFj7q2s3WlXO52lZLdyJKFc4u54fCX7Kesyboynnay7Q
	 ii+2CTKZ2pBlH0wEcfEZ3YqJcFMaR745ULB1MDifRPuWFLixq1+7WAeA9SFnqVPWdUgyA
	 oS+Xsxrw9ihke1Esz/zCsrdWIK6hZFlgGYp6PI2gU9BWopB710o+aVM5noyfWiwuBdloL
	 4J12woSnmRIauPiuGP6Ey34Pte9vkNBom1AvsDDcBMv+BIFet0JDeK5IQYMZVj0iYbcSA
	 FDUF+/XNJcyZ9RmJu5M7TEGIWapaDRq+OySX1KsCs1fe56Kf7J7F9eLuBiJ0l3LsLPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WCt6+Kv8;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A0606A333
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 12:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 364A0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WCt6+Kv8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793102808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8KMQj2HsPBF8Jjs/G4X6DPysUQ80f4vvkU0TZL7PsU=;
	b=WCt6+Kv8oDU+LPsbbvqFB0CMyUA1ThpJONEU19usgDjVrenWAfwHc4ix+pi5VUeG/CJl+N
	1nI9Vfo92Ref/7085c9ohJSbyDxlO04LuiO+fPw2Baa1Vo0dJciKkF6nGQ8kh5q3ZvrB5E
	ymV/IeXQPy7AtO1rvRHrDBXzPRMBPNI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-n6f20YalO3OqTr5sX9fxuw-1; Tue, 27 Oct 2026 08:06:45 -0400
X-MC-Unique: n6f20YalO3OqTr5sX9fxuw-1
X-Mimecast-MFC-AGG-ID: n6f20YalO3OqTr5sX9fxuw_1793102804
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so20434105e9.3
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 05:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793102804; x=1793707604;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g8KMQj2HsPBF8Jjs/G4X6DPysUQ80f4vvkU0TZL7PsU=;
        b=tOAKvobSN22xsB/lVkN6vLm1EUc9XE8L7pdiEVDZ3k2qyC5Y/53gZumA/pPsJ77jPG
         rrNu4Gi5rjsYad7DceQbCEVIv4rqUbx7gKWqgZ4vke3ntlGPIhnC7FKciufAXwPFdRBU
         DidyWjyZdP2pzOVS6gFnjIKvQEIZMxi8bYYrR5pnzhn6Yg85RvOKIeMu2STiwzcecCW6
         mJKj+4dQj/YXN7lJpa/dC8WmIuyIlQw4lLQdcweOLOAfqHFguuRiem/oTT9+KpnELW1/
         pEVYZNeb1Lh0OFXoxhcdsC2s5k7WHUZ8E4f28mgLeUPH+z29PfRqges1pFegICf921VI
         ksHg==
X-Forwarded-Encrypted: i=1; AKwUvBzdavh0VIQnRRH5J1zHSCtlc1bqgOvzvgnuDvxS1KD69pY/Jtuf8fSoPzvQlfjuEZ0aL8/sKhqAT2vr4NQ3pg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKRmeu1VmLElN8AkbWxkgiMJ7Nlw0z9rGcVROQztG/+UgN3KDFY
	72cj+XTQfK1TDJDJlwY1Esl1WlWFQXKQxCsMSJPO1XuREXQU+Jkx1Su+bFRnmdwkJe4uS1Zr+Ga
	T/sRO7JrpelHMtTDmDM9L8z+jy2Xmv//n88or49YhmRPRJMlH2IGgLL5QsgmV79IA+J9y
X-Gm-Gg: AYBFou399y54m2AzaMkgPg4cAcGV3mnNr+AP97DyXpPEPpnr44lhYcmwNKib2zXMr1p
	OyzqlQb2nfUrS5npvljtl3ympmx3/0tXUGZ2sq4/nSZ2qNqxiKZmoIrtE4l6HD84jOwjm+BKu8V
	+AZ22K61EygdJj3t86jfvYk+/aMAaf6lLTP8xbzdctMk02xF/xJg6HxQbsqTljEgci2XDVnQuoU
	hHSrv8IdicPGQKMH30/x8tbSPRTTC45PPiqp0Af7oFwrEBk0jsk4+hUCPQGaquXePVyV4hd2Wmq
	+QdTrQVuYLnHDIemWDKR6f4V+B0Pn3JoUVakpiWCw+knG9qfCffaqtJjDhW96JwulTjgvrvlua5
	CHSHMXmhO7W70io2PhYt/0sncBH8xTILnuBZcwL3sGwg26LNTvxSJUJGiwUKTwYz0fJfnCITyFA
	==
X-Received: by 2002:a05:600c:608e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4a642ccc70emr103979935e9.11.1793102803704;
        Tue, 27 Oct 2026 05:06:43 -0700 (PDT)
X-Received: by 2002:a05:600c:608e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4a642ccc70emr103979245e9.11.1793102803120;
        Tue, 27 Oct 2026 05:06:43 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2d9280sm259748385e9.13.2026.10.27.05.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 05:06:42 -0700 (PDT)
Message-ID: <096bd22b-c569-4998-a943-0381c3fa9998@redhat.com>
Date: Tue, 27 Oct 2026 13:06:41 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio_net: reject stats replies for queues outside
 the request
To: Lianjie Wang <karin0.zst@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261022182710.2055771-1-karin0.zst@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261022182710.2055771-1-karin0.zst@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QoklOkGZD611ZQ6pXhZSHkd2rMaJ9FxJ1LZqpcF0AgI_1793102804
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 20:26, Lianjie Wang wrote:
> __virtnet_get_hw_stats() passes the vq_index of each record in the
> device's statistics reply to virtnet_fill_stats() without checking it,
> so the device decides where the driver writes the counters.
> 
> For ethtool -S, virtnet_fill_stats() uses vq_index as an offset into the
> output array, which the ethtool core sized for curr_queue_pairs. A
> record with the vq_index of a higher queue makes the driver write past
> the end of the array.
> 
> For the per-queue netlink stats, the queue type also comes from
> vq_index. A receive record in reply to a request for a transmit queue
> makes the driver fill the struct netdev_queue_stats_tx on the stack as
> if it were a struct netdev_queue_stats_rx. If the device offers
> VIRTIO_NET_STATS_TYPE_RX_SPEED, this writes one counter to the eight
> bytes after the tx struct.
> 
> Fix this by rejecting the reply when the vq_index of a record lies
> outside the range of queues the request asked about.
> 
> Claude Opus 5.5 was used to review the driver code and draft this patch.
> To reproduce, the virtio-net device in QEMU was modified to answer an
> ethtool -S request on a one-pair device with a record for a receive
> queue the device does not have. On an unmodified kernel, KASAN then
> reports a write past the ethtool -S output array. With this patch, the
> driver rejects the same reply with "Failed to get hw stats.", a
> well-formed reply fills the statistics as before, and the
> drivers/net/stats.py selftest passes.
> 
> Fixes: 941168f8b40e ("virtio_net: support device stats")
> Fixes: d888f04c09bb ("virtio-net: support queue stat")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <karin0.zst@gmail.com>
> ---
>   drivers/net/virtio_net.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index daab43ac92ce4..0473fa9947858 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4955,7 +4955,8 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
>   static int __virtnet_get_hw_stats(struct virtnet_info *vi,
>   				  struct virtnet_stats_ctx *ctx,
>   				  struct virtio_net_ctrl_queue_stats *req,
> -				  int req_size, void *reply, int res_size)
> +				  int req_size, void *reply, int res_size,
> +				  int first_vq, int last_vq, bool enable_cvq)
>   {
>   	struct virtio_net_stats_reply_hdr *hdr;
>   	struct scatterlist sgs_in, sgs_out;
> @@ -4976,6 +4977,10 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
>   	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
>   		hdr = p;
>   		qid = le16_to_cpu(hdr->vq_index);
> +		if ((qid < first_vq || qid > last_vq) &&
> +		    !(enable_cvq && qid == vi->max_queue_pairs * 2))
> +			return -EINVAL;

I think the above check could be simplified to:
		if (qid < first_vq || qid > last_vq)
			return -EINVAL;

squashing the following in virtnet_get_hw_stats():

-       if (enable_cvq)
+       if (enable_cvq) {
                 virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
+               last_vq++;
+       }

(likely with some meaningful comment).

/P

