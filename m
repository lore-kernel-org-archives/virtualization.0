Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC31EB64DA
	for <virtualization@archiver.kernel.org>; Wed, 19 Jul 2023 07:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99D114187C;
	Wed, 19 Jul 2023 07:43:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99D114187C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E3lLKEFP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 99i2RklCQycS; Wed, 19 Jul 2023 07:43:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C6A6041862;
	Wed, 19 Jul 2023 07:43:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6A6041862
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A915C0072;
	Wed, 19 Jul 2023 07:43:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29040C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 07:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 011A441879
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 07:43:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 011A441879
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YoR1rzFORZQz
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 07:43:11 +0000 (UTC)
X-Greylist: delayed 395 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 19 Jul 2023 07:43:10 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C14DA41862
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C14DA41862
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 07:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689752589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/l/BFx3Ouxomc0W5crH0QEL+N5uRN2SeYoUdCWhVZBA=;
 b=E3lLKEFPqeohJDdAYVIgclTm6farV2hxggHuCKHdC1UA9rYiSDNVRLwLQuRA66NKjw+z+s
 FTq9/USGs10AipMXh2c/5ZwynBGQUZlRml/zaRfdIjWE+DRvC16vsrjlR9j87nzt0pfgq3
 WyyDEE5ywaXHQYQIcVK2/uiIIEi9A2k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-_thwS79hN5y6zgnYmnQF0w-1; Wed, 19 Jul 2023 03:36:32 -0400
X-MC-Unique: _thwS79hN5y6zgnYmnQF0w-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b95eac8399so878221fa.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 00:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689752191; x=1690356991;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/l/BFx3Ouxomc0W5crH0QEL+N5uRN2SeYoUdCWhVZBA=;
 b=aTi02G3KwJQLu2SheSx3KaQJrdT+1fKei3DipVSzQqzEFFUSR1vavgmLAFuIRlQj4z
 kxmEmgiX5ZmOpd0MxY6VMqbU7NsuodRdjTuVW//2ZWUNa+1M0RNGiGEn+qQhpnkzW7ZA
 TTfk1J/M77Gk2jqn+JuXzys0DdRQY5IkrfUuNPxKkcb9EN6pS1D7TxcNZvCHDP5VrQhE
 F6g8u/P8dOnEmpAOft781e7qtNiPJT+bsh1kJN+dzAvtw/wwJxQkgaieuAvkCtz4F8HL
 NaqHInzInzzdQiCPrG9xZ6z7oIFGR58i8ZabXfDd6uJDQ8xDLQvzI8sUgGWamyMUnSKE
 +kpQ==
X-Gm-Message-State: ABy/qLZqDeSX32jaZpWaCILrtABhGp6Q3QtwO7z4GkoPf3rw/ofC5P9a
 iif2absWnHZGl9IZcDZ6Z+5Hb6qT4oxZD6mlCKr4RkVks6nZgIFXu6FETaqoCmpe/8yIeiWfnBC
 7EmPj7RqcAAYus2tIb+TmlWbZ6ZsNuYU5pDaqI/kSoQ==
X-Received: by 2002:a05:6512:15a6:b0:4fd:d3aa:e425 with SMTP id
 bp38-20020a05651215a600b004fdd3aae425mr1581929lfb.27.1689752191000; 
 Wed, 19 Jul 2023 00:36:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH1vDeqm1BTcVm9t1Zzvu6JlLhYTYor1hjJsu8aGBt07Q6f2nfDA4itiCmBAX5Xer/YiP+tpg==
X-Received: by 2002:a05:6512:15a6:b0:4fd:d3aa:e425 with SMTP id
 bp38-20020a05651215a600b004fdd3aae425mr1581912lfb.27.1689752190665; 
 Wed, 19 Jul 2023 00:36:30 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-29.business.telecomitalia.it.
 [87.12.25.29]) by smtp.gmail.com with ESMTPSA id
 by27-20020a0564021b1b00b0051d87e72159sm2315237edb.13.2023.07.19.00.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 00:36:29 -0700 (PDT)
Date: Wed, 19 Jul 2023 09:36:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v2 2/4] vsock/virtio: support to send non-linear
 skb
Message-ID: <4batgyn7pmxn2rysqpztuaim4dxtpfjbrjyyuodsct3qun7w5e@ebd45ngrsfut>
References: <20230718180237.3248179-1-AVKrasnov@sberdevices.ru>
 <20230718180237.3248179-3-AVKrasnov@sberdevices.ru>
 <20230718162202-mutt-send-email-mst@kernel.org>
 <1ac4be11-0814-05af-6c2e-8563ac15e206@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <1ac4be11-0814-05af-6c2e-8563ac15e206@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jul 19, 2023 at 07:46:05AM +0300, Arseniy Krasnov wrote:
>
>
>On 18.07.2023 23:27, Michael S. Tsirkin wrote:
>> On Tue, Jul 18, 2023 at 09:02:35PM +0300, Arseniy Krasnov wrote:
>>> For non-linear skb use its pages from fragment array as buffers in
>>> virtio tx queue. These pages are already pinned by 'get_user_pages()'
>>> during such skb creation.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>>  net/vmw_vsock/virtio_transport.c | 40 +++++++++++++++++++++++++++-----
>>>  1 file changed, 34 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>>> index e95df847176b..6cbb45bb12d2 100644
>>> --- a/net/vmw_vsock/virtio_transport.c
>>> +++ b/net/vmw_vsock/virtio_transport.c
>>> @@ -100,7 +100,9 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>>  	vq = vsock->vqs[VSOCK_VQ_TX];
>>>
>>>  	for (;;) {
>>> -		struct scatterlist hdr, buf, *sgs[2];
>>> +		/* +1 is for packet header. */
>>> +		struct scatterlist *sgs[MAX_SKB_FRAGS + 1];
>>> +		struct scatterlist bufs[MAX_SKB_FRAGS + 1];
>>>  		int ret, in_sg = 0, out_sg = 0;
>>>  		struct sk_buff *skb;
>>>  		bool reply;
>>> @@ -111,12 +113,38 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>>
>>>  		virtio_transport_deliver_tap_pkt(skb);
>>>  		reply = virtio_vsock_skb_reply(skb);
>>> +		sg_init_one(&bufs[out_sg], virtio_vsock_hdr(skb),
>>> +			    sizeof(*virtio_vsock_hdr(skb)));
>>> +		sgs[out_sg] = &bufs[out_sg];
>>> +		out_sg++;
>>> +
>>> +		if (!skb_is_nonlinear(skb)) {
>>> +			if (skb->len > 0) {
>>> +				sg_init_one(&bufs[out_sg], skb->data, skb->len);
>>> +				sgs[out_sg] = &bufs[out_sg];
>>> +				out_sg++;
>>> +			}
>>> +		} else {
>>> +			struct skb_shared_info *si;
>>> +			int i;
>>> +
>>> +			si = skb_shinfo(skb);
>>> +
>>> +			for (i = 0; i < si->nr_frags; i++) {
>>> +				skb_frag_t *skb_frag = &si->frags[i];
>>> +				void *va = page_to_virt(skb_frag->bv_page);
>>>
>>> -		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>>> -		sgs[out_sg++] = &hdr;
>>> -		if (skb->len > 0) {
>>> -			sg_init_one(&buf, skb->data, skb->len);
>>> -			sgs[out_sg++] = &buf;
>>> +				/* We will use 'page_to_virt()' for userspace page here,
>>
>> don't put comments after code they refer to, please?
>>
>>> +				 * because virtio layer will call 'virt_to_phys()' later
>>
>> it will but not always. sometimes it's the dma mapping layer.
>>
>>
>>> +				 * to fill buffer descriptor. We don't touch memory at
>>> +				 * "virtual" address of this page.
>>
>>
>> you need to stick "the" in a bunch of places above.
>
>Ok, I'll fix this comment!
>
>>
>>> +				 */
>>> +				sg_init_one(&bufs[out_sg],
>>> +					    va + skb_frag->bv_offset,
>>> +					    skb_frag->bv_len);
>>> +				sgs[out_sg] = &bufs[out_sg];
>>> +				out_sg++;
>>> +			}
>>>  		}
>>>
>>>  		ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
>>
>>
>> There's a problem here: if there vq is small this will fail.
>> So you really should check free vq s/gs and switch to non-zcopy
>> if too small.
>
>Ok, so idea is that:
>
>if (out_sg > vq->num_free)
>    reorganise current skb for copy mode (e.g. 2 out_sg - header and data)
>    and try to add it to vq again.
>
>?
>
>@Stefano, I'll remove net-next tag (guess RFC is not required again, but not net-next
>anyway) as this change will require review. R-b I think should be also removed. All
>other patches in this set still unchanged.

It's still a new feature so we have net-next tree as the target, right?

I think we should keep net-next. Even if patches require to be
re-reviewed, net-next indicates the tree where we want these to be merge
and for new features is the right one.

Ack for not putting RFC again and for R-b removal for this patch.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
