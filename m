Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DDCC001DF
	for <virtualization@archiver.kernel.org>; Tue,  1 Aug 2023 13:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8C97400B1;
	Tue,  1 Aug 2023 13:34:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C8C97400B1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YEFydGcS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BhA815_rp-3C; Tue,  1 Aug 2023 13:34:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E3AFD4035E;
	Tue,  1 Aug 2023 13:34:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E3AFD4035E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9A36C0072;
	Tue,  1 Aug 2023 13:34:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B571CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 13:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BA8060B36
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 13:34:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BA8060B36
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YEFydGcS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SgQWp9aoJ7S8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 13:34:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF0B560B16
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 13:34:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF0B560B16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690896853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqfuQ5ydc8BWluTZSg66rTJLLt1lR5wSRY1RU47pUBI=;
 b=YEFydGcS2gXO7VRAuc8QuVSEeO2qzDUwlwSWAmLbDk/OrzTpXmQGsPidq/EXubhefEtS8g
 20fZdGr9AwJ0crG4o8vuw5Z93KNPvNBdBzXCEjVZ2sMZijEgH1zxN5LdEyKa7DOZI+l4a3
 BXdAI7SimmGIufsdHYyd6L4xSdZZ8e0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-o-W5EdTbOPy9cb8-dhuciw-1; Tue, 01 Aug 2023 09:34:11 -0400
X-MC-Unique: o-W5EdTbOPy9cb8-dhuciw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76cb9958d60so35646685a.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Aug 2023 06:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690896851; x=1691501651;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m3EuGMRXqXwIjso57QFZOBRIJwj3UoGAkDVIx/t2tOw=;
 b=Nxfk7qBKuSwcL6B/qRef+zCL07BpKSC9KqW11DkmZ4COMRm3LBLKatp7W2Z0IY0s9x
 Y+XMU/f8vaiWuOty5pKKtFXEKmYVqEWerI+hcq0ehTxLW5ytTW66MVG7HrWiZTV+eOqP
 d3A0NQoaTQPhzvYNutEkhREppfpJW4DHEFQKJY5IdxFFqbIri/ftCip+Ywrqfmr+fl15
 2XtpiCpvDngh/lX0ZofYqajgVXid1XonjTLH500DJtOa23ndXav/YEz2bDi0Tuop0xUE
 yR3+Ct5wcFunm1DC4NLouEd765diF831w6ZLU7IdQX9RSIrmbhxK7ayMT3W4PrdECpqv
 RdBA==
X-Gm-Message-State: ABy/qLbmvyZF7lxrxyUKX5lGzBo8lxZHosSwHiqG2WBc6WztluUckbbx
 LIftt906tMzIzwn5vNgMmdRH4eU+519pOkhktYa4oRm4J/Vi652bFUq75olwCSjsn0O1nOcTgOI
 gV3xo1e9XrEPr0Pf+krktbIF9MRe1JRQ6lU1fESUMQA==
X-Received: by 2002:a05:620a:430a:b0:767:346c:4b37 with SMTP id
 u10-20020a05620a430a00b00767346c4b37mr11487662qko.7.1690896851424; 
 Tue, 01 Aug 2023 06:34:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF2f6rViFVq6s9ZoHhoK5v+BjyA/rYc7oOn3EuiWdiJ1W4rbVP76VwVvUC5Ka+gXuoKt2VQqA==
X-Received: by 2002:a05:620a:430a:b0:767:346c:4b37 with SMTP id
 u10-20020a05620a430a00b00767346c4b37mr11487637qko.7.1690896851093; 
 Tue, 01 Aug 2023 06:34:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-251.dyn.eolo.it.
 [146.241.225.251]) by smtp.gmail.com with ESMTPSA id
 op51-20020a05620a537300b00767dc4c539bsm4136811qkn.44.2023.08.01.06.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 06:34:10 -0700 (PDT)
Message-ID: <8a7772a50a16fbbcb82fc0c5e09f9e31f3427e3d.camel@redhat.com>
Subject: Re: [PATCH net-next v5 4/4] vsock/virtio: MSG_ZEROCOPY flag support
From: Paolo Abeni <pabeni@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Tue, 01 Aug 2023 15:34:07 +0200
In-Reply-To: <20230730085905.3420811-5-AVKrasnov@sberdevices.ru>
References: <20230730085905.3420811-1-AVKrasnov@sberdevices.ru>
 <20230730085905.3420811-5-AVKrasnov@sberdevices.ru>
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

On Sun, 2023-07-30 at 11:59 +0300, Arseniy Krasnov wrote:
> +static int virtio_transport_fill_skb(struct sk_buff *skb,
> +				     struct virtio_vsock_pkt_info *info,
> +				     size_t len,
> +				     bool zcopy)
> +{
> +	if (zcopy) {
> +		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
> +					      &info->msg->msg_iter,
> +					      len);
> +	} else {


No need for an else statement after 'return'

> +		void *payload;
> +		int err;
> +
> +		payload = skb_put(skb, len);
> +		err = memcpy_from_msg(payload, info->msg, len);
> +		if (err)
> +			return -1;
> +
> +		if (msg_data_left(info->msg))
> +			return 0;
> +

This path does not update truesize, evem if it increases the skb len...

> +		return 0;
> +	}
> +}

[...]

> @@ -214,6 +251,70 @@ static u16 virtio_transport_get_type(struct sock *sk)
>  		return VIRTIO_VSOCK_TYPE_SEQPACKET;
>  }
>  
> +static struct sk_buff *virtio_transport_alloc_skb(struct vsock_sock *vsk,
> +						  struct virtio_vsock_pkt_info *info,
> +						  size_t payload_len,
> +						  bool zcopy,
> +						  u32 src_cid,
> +						  u32 src_port,
> +						  u32 dst_cid,
> +						  u32 dst_port)
> +{
> +	struct sk_buff *skb;
> +	size_t skb_len;
> +
> +	skb_len = VIRTIO_VSOCK_SKB_HEADROOM;
> +
> +	if (!zcopy)
> +		skb_len += payload_len;
> +
> +	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
> +	if (!skb)
> +		return NULL;
> +
> +	virtio_transport_init_hdr(skb, info, src_cid, src_port,
> +				  dst_cid, dst_port,
> +				  payload_len);
> +
> +	/* Set owner here, because '__zerocopy_sg_from_iter()' uses
> +	 * owner of skb without check to update 'sk_wmem_alloc'.
> +	 */
> +	if (vsk)
> +		skb_set_owner_w(skb, sk_vsock(vsk));

... which can lead to bad things(TM) if the skb goes trough some later
non trivial processing, due to the above skb_set_owner_w().

Additionally can be the following condition be true:

	vsk == NULL && (info->msg && payload_len > 0) && zcopy

???

If so it looks like skb can go through __zerocopy_sg_from_iter() even
without a prior skb_set_owner_w()...


Cheers,

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
