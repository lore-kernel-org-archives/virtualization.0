Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08E6C0015E
	for <virtualization@archiver.kernel.org>; Tue,  1 Aug 2023 14:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 410A681CE7;
	Tue,  1 Aug 2023 14:05:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 410A681CE7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Eme66kJV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hrJyM7VKYSpH; Tue,  1 Aug 2023 14:05:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E1D0E81F01;
	Tue,  1 Aug 2023 14:05:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1D0E81F01
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAC62C0071;
	Tue,  1 Aug 2023 14:05:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DC55C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 14:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F080416CE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 14:05:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F080416CE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Eme66kJV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FkIfZtcesjZG
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 14:05:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2936402E1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 14:05:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2936402E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690898703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3NCys7lxXzoTW53F4TGIW9wI9wbDlTJ+4789+4Qeyg=;
 b=Eme66kJVYT7uaItgRpJjMqj4w/Q5dSM92LZbKjZ57diyI7GwTW0NcBYEUH/4KYbxQsdwpl
 ifns0GvQCr5qPAl3KgxHvzJwTRKRtXGg5FTb++Uw9rPVNI3Eqbzhrqp/kPL8Sh7nhh6IWH
 Hjksc1KRQFNZbRyadKMV4jIbMCEC5Zs=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-fI4Sru1LNhKCgZ8BTW4dJQ-1; Tue, 01 Aug 2023 10:05:00 -0400
X-MC-Unique: fI4Sru1LNhKCgZ8BTW4dJQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-56ce4f82d18so209002eaf.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Aug 2023 07:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690898700; x=1691503500;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wrQZYdlPHfqAXUcA6lbzNx8CU3rrSsjWUivdGMgi/i8=;
 b=bLoVET4LEnsX7ogbJwXNNoYLSTBJdqbcsRz+7SsiJGfS/2bzVTo5u3HtEMg5iiWULQ
 /rDHWdiuDAEoT54d21LmL3MJcGyay7ynXx88V662Bk+jccGQigIb+eZUMaLswbHOtraB
 hd1nW9DlSBd70wBUIHh/K2CwL/olgA2PJ6JD9VN9H8820RkOM6061P8WKYLGKlClJirt
 ydX354Fb6LOBINstzLZR3NMF9a7Y3eeDqPNLbgZAW5S/cx4N0hmtyAiIBrm0MP6XH4MX
 WmWjAeOjzoIYp0iD/how7uMz4qtLkggUG1dh+tkAdte0y8YiZBGy6rR4ssqq25aPkPDm
 kUYA==
X-Gm-Message-State: ABy/qLZ5qu1GXy7FVwR+0SdmgbLZ5FKiXttlxiZbtvVTD0uJXXHmwauP
 o23Digc5CFv+HE6CBlacDuFf2Zi+h7ZzppYnGtOpqKQNsK1hT1DiTurs2IWaK14c0fd6O6HcPwO
 RDtgsjDu9rmhhSZ+PAla2gt+nheGWW22oiY/wBwb5Ng==
X-Received: by 2002:a4a:a585:0:b0:56c:484a:923d with SMTP id
 d5-20020a4aa585000000b0056c484a923dmr7768048oom.1.1690898700135; 
 Tue, 01 Aug 2023 07:05:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkYK567OZvBBNHPM2ndAyrlc5sazvLUju3ozUYOY4HGl86ZO4bap40IQmhQfYLniD5hAHXvA==
X-Received: by 2002:a4a:a585:0:b0:56c:484a:923d with SMTP id
 d5-20020a4aa585000000b0056c484a923dmr7768012oom.1.1690898699795; 
 Tue, 01 Aug 2023 07:04:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-251.dyn.eolo.it.
 [146.241.225.251]) by smtp.gmail.com with ESMTPSA id
 o2-20020a0ce402000000b0063d14bfa5absm4658714qvl.36.2023.08.01.07.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 07:04:59 -0700 (PDT)
Message-ID: <00f2b7bdb18e0eaa42f0cca542a9530564615475.camel@redhat.com>
Subject: Re: [PATCH net-next v5 4/4] vsock/virtio: MSG_ZEROCOPY flag support
From: Paolo Abeni <pabeni@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Tue, 01 Aug 2023 16:04:55 +0200
In-Reply-To: <1c9f9851-2228-c92b-ce3d-6a84d44e6628@sberdevices.ru>
References: <20230730085905.3420811-1-AVKrasnov@sberdevices.ru>
 <20230730085905.3420811-5-AVKrasnov@sberdevices.ru>
 <8a7772a50a16fbbcb82fc0c5e09f9e31f3427e3d.camel@redhat.com>
 <1c9f9851-2228-c92b-ce3d-6a84d44e6628@sberdevices.ru>
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

On Tue, 2023-08-01 at 16:36 +0300, Arseniy Krasnov wrote:
> 
> On 01.08.2023 16:34, Paolo Abeni wrote:
> > On Sun, 2023-07-30 at 11:59 +0300, Arseniy Krasnov wrote:
> > > +static int virtio_transport_fill_skb(struct sk_buff *skb,
> > > +				     struct virtio_vsock_pkt_info *info,
> > > +				     size_t len,
> > > +				     bool zcopy)
> > > +{
> > > +	if (zcopy) {
> > > +		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
> > > +					      &info->msg->msg_iter,
> > > +					      len);
> > > +	} else {
> > 
> > 
> > No need for an else statement after 'return'
> > 
> > > +		void *payload;
> > > +		int err;
> > > +
> > > +		payload = skb_put(skb, len);
> > > +		err = memcpy_from_msg(payload, info->msg, len);
> > > +		if (err)
> > > +			return -1;
> > > +
> > > +		if (msg_data_left(info->msg))
> > > +			return 0;
> > > +
> > 
> > This path does not update truesize, evem if it increases the skb len...
> 
> Thanks, I'll fix it.
> 
> > 
> > > +		return 0;
> > > +	}
> > > +}
> > 
> > [...]
> > 
> > > @@ -214,6 +251,70 @@ static u16 virtio_transport_get_type(struct sock *sk)
> > >  		return VIRTIO_VSOCK_TYPE_SEQPACKET;
> > >  }
> > >  
> > > +static struct sk_buff *virtio_transport_alloc_skb(struct vsock_sock *vsk,
> > > +						  struct virtio_vsock_pkt_info *info,
> > > +						  size_t payload_len,
> > > +						  bool zcopy,
> > > +						  u32 src_cid,
> > > +						  u32 src_port,
> > > +						  u32 dst_cid,
> > > +						  u32 dst_port)
> > > +{
> > > +	struct sk_buff *skb;
> > > +	size_t skb_len;
> > > +
> > > +	skb_len = VIRTIO_VSOCK_SKB_HEADROOM;
> > > +
> > > +	if (!zcopy)
> > > +		skb_len += payload_len;
> > > +
> > > +	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
> > > +	if (!skb)
> > > +		return NULL;
> > > +
> > > +	virtio_transport_init_hdr(skb, info, src_cid, src_port,
> > > +				  dst_cid, dst_port,
> > > +				  payload_len);
> > > +
> > > +	/* Set owner here, because '__zerocopy_sg_from_iter()' uses
> > > +	 * owner of skb without check to update 'sk_wmem_alloc'.
> > > +	 */
> > > +	if (vsk)
> > > +		skb_set_owner_w(skb, sk_vsock(vsk));
> > 
> > ... which can lead to bad things(TM) if the skb goes trough some later
> > non trivial processing, due to the above skb_set_owner_w().
> > 
> > Additionally can be the following condition be true:
> > 
> > 	vsk == NULL && (info->msg && payload_len > 0) && zcopy
> > 
> > ???
> 
> No, vsk == NULL only when we reset connection, in that case both info->msg == NULL and payload_len == 0,
> as this is control message without any data.

Perhaps a comment with possibly even a WARN_ON_ONCE(!<the above>) could
help ;)

Thanks!

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
