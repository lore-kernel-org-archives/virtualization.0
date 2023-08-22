Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F193BEE4996
	for <virtualization@archiver.kernel.org>; Tue, 22 Aug 2023 08:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FDB660D6B;
	Tue, 22 Aug 2023 08:16:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4FDB660D6B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bwTGoTZA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fAO0IzDyYvvS; Tue, 22 Aug 2023 08:16:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B1E6460AC6;
	Tue, 22 Aug 2023 08:16:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1E6460AC6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73D49C0071;
	Tue, 22 Aug 2023 08:16:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D89C4C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 08:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B858E40508
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 08:16:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B858E40508
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bwTGoTZA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D4KntRIlZep9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 08:16:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 940BC404EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 08:16:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 940BC404EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692692212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmKJUAQUhZ5s6gEAWef7Qkt+0qpYi/NgvhI9XcefrjU=;
 b=bwTGoTZA+bXFJJHbG5ZZtkL+SUiotzAr58wNUw1r7KZUhMP7vmSpaG0unRfBmMtoIonXN1
 mrnJrQ2LrfamiunH6BtNxXNzzW1g0WldnwBD8XR19J/6Vq2ZcGHO1OZCFYHV9rTo1hxuXf
 /8MQxS9tCiLnEvsALmB8ow2FDW7TIk4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-HDk4O4OZOliW0p-OZsEQLg-1; Tue, 22 Aug 2023 04:16:50 -0400
X-MC-Unique: HDk4O4OZOliW0p-OZsEQLg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-51e3bb0aeedso404236a12.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 01:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692692209; x=1693297009;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zckv6oFww2IAYABuKXRpSyWhyYXXDqhNviwTg2vLyFU=;
 b=LqICD8awyYRa2J6K4SgpWpH29VXQAW/OiqBn/IRcGLMYhfUGpBzm5bh1fQhvatgE96
 BpknPI6taPTsYLUiEb2EYa4RKnGfpslgxcnnrOaDV/3RI2uKeJxMDT1vJV+Rf9bajHkx
 1UWsW2+h5Uf++XCan7umHUQL1aZr/dCy6ipXblss7sYnLuiGTlTd83OtHf9jS3qGTdjs
 jq+va9oFHdQexCEdeKCVSisYxReDqdV0nsfOq64kBABHq0COfTQ1XD9PggTpjJSoSKmc
 u4aeC/wKizUkbJ/90JgEau4SmCpf9Aq5ZbAygKLvCA3YOBvxY/BXyfr/0wYVTWZXUsoq
 RUgg==
X-Gm-Message-State: AOJu0YypBS6J/LBG7ymHVb/yIqXbNXVaqM1SOWQsgyriW8GcluOUs9My
 LuRw/D5iShFXlAjlw+2OsAbH4gvrKFS/sYvDei2wunikFoBauIf4P/cSgll0XLxllE1MNjSAt79
 IbH0Kmh08vXnkn1ESEZzEc3lz62ulqB4kSLzG5HNjhg==
X-Received: by 2002:a05:6402:268e:b0:523:2e64:122b with SMTP id
 w14-20020a056402268e00b005232e64122bmr6755163edd.3.1692692209657; 
 Tue, 22 Aug 2023 01:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLSFMBKhUwaZNzwUhuDk7yvXSZjSgwouQMRlutTKOK/6Gw8nbnhQGL5h8TQ+NkO3C5To+oqw==
X-Received: by 2002:a05:6402:268e:b0:523:2e64:122b with SMTP id
 w14-20020a056402268e00b005232e64122bmr6755152edd.3.1692692209318; 
 Tue, 22 Aug 2023 01:16:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
 by smtp.gmail.com with ESMTPSA id
 m4-20020aa7c484000000b0052328d4268asm7109439edq.81.2023.08.22.01.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 01:16:48 -0700 (PDT)
Message-ID: <85ff931ea180e19ae3df83367cf1e7cac99fa0d8.camel@redhat.com>
Subject: Re: [PATCH net-next v6 2/4] vsock/virtio: support to send
 non-linear skb
From: Paolo Abeni <pabeni@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Tue, 22 Aug 2023 10:16:47 +0200
In-Reply-To: <20230814212720.3679058-3-AVKrasnov@sberdevices.ru>
References: <20230814212720.3679058-1-AVKrasnov@sberdevices.ru>
 <20230814212720.3679058-3-AVKrasnov@sberdevices.ru>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 kernel@sberdevices.ru
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

Hi,

I'm sorry for the long delay here. I was OoO in the past few weeks.

On Tue, 2023-08-15 at 00:27 +0300, Arseniy Krasnov wrote:
> For non-linear skb use its pages from fragment array as buffers in
> virtio tx queue. These pages are already pinned by 'get_user_pages()'
> during such skb creation.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  Changelog:
>  v2 -> v3:
>   * Comment about 'page_to_virt()' is updated. I don't remove R-b,
>     as this change is quiet small I guess.
> 
>  net/vmw_vsock/virtio_transport.c | 41 +++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index e95df847176b..7bbcc8093e51 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -100,7 +100,9 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>  	vq = vsock->vqs[VSOCK_VQ_TX];
>  
>  	for (;;) {
> -		struct scatterlist hdr, buf, *sgs[2];
> +		/* +1 is for packet header. */
> +		struct scatterlist *sgs[MAX_SKB_FRAGS + 1];
> +		struct scatterlist bufs[MAX_SKB_FRAGS + 1];

Note that MAX_SKB_FRAGS depends on a config knob (CONFIG_MAX_SKB_FRAGS)
and valid/reasonable values are up to 45. The total stack usage can be
pretty large (~700 bytes).

As this is under the vsk tx lock, have you considered moving such data
in the virtio_vsock struct?

>  		int ret, in_sg = 0, out_sg = 0;
>  		struct sk_buff *skb;
>  		bool reply;
> @@ -111,12 +113,39 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>  
>  		virtio_transport_deliver_tap_pkt(skb);
>  		reply = virtio_vsock_skb_reply(skb);
> +		sg_init_one(&bufs[out_sg], virtio_vsock_hdr(skb),
> +			    sizeof(*virtio_vsock_hdr(skb)));
> +		sgs[out_sg] = &bufs[out_sg];
> +		out_sg++;
> +
> +		if (!skb_is_nonlinear(skb)) {
> +			if (skb->len > 0) {
> +				sg_init_one(&bufs[out_sg], skb->data, skb->len);
> +				sgs[out_sg] = &bufs[out_sg];
> +				out_sg++;
> +			}
> +		} else {
> +			struct skb_shared_info *si;
> +			int i;
> +
> +			si = skb_shinfo(skb);

This assumes that the paged skb does not carry any actual data in the
head buffer (only the header). Is that constraint enforced somewhere
else? Otherwise a

	WARN_ON_ONCE(skb_headlen(skb) > sizeof(*virtio_vsock_hdr(skb))

could be helpful to catch early possible bugs.

Thanks!

Paolo

> +
> +			for (i = 0; i < si->nr_frags; i++) {
> +				skb_frag_t *skb_frag = &si->frags[i];
> +				void *va;
>  
> -		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
> -		sgs[out_sg++] = &hdr;
> -		if (skb->len > 0) {
> -			sg_init_one(&buf, skb->data, skb->len);
> -			sgs[out_sg++] = &buf;
> +				/* We will use 'page_to_virt()' for the userspace page
> +				 * here, because virtio or dma-mapping layers will call
> +				 * 'virt_to_phys()' later to fill the buffer descriptor.
> +				 * We don't touch memory at "virtual" address of this page.
> +				 */
> +				va = page_to_virt(skb_frag->bv_page);
> +				sg_init_one(&bufs[out_sg],
> +					    va + skb_frag->bv_offset,
> +					    skb_frag->bv_len);
> +				sgs[out_sg] = &bufs[out_sg];
> +				out_sg++;
> +			}
>  		}
>  
>  		ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
