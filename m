Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D97C761A6
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 10:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4402160BA6;
	Thu, 30 Mar 2023 10:48:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4402160BA6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VVWCSo8O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jlBUFFfAhxLe; Thu, 30 Mar 2023 10:48:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CA8C560B14;
	Thu, 30 Mar 2023 10:48:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA8C560B14
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ADD2C0036;
	Thu, 30 Mar 2023 10:48:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74172C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 10:48:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48E93817F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 10:48:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48E93817F2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VVWCSo8O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z42buFqffs-v
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 10:48:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5602A80ED4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5602A80ED4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 10:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680173308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vN5xMBVq4cWcTC28D5eE/t2cXHtSpq/nlebQVk8U7ho=;
 b=VVWCSo8OsYv0fzwTIU6oyS8LkD8BpmidHXzo0TMTFirnuWE6UjihC7wwmhr68W5ZDQ/8c7
 7RioHsOY2xLJwJnhogFM59+5r3kpkf0G4EgcR5qjV0FKyKocSQU2bEbeWQg0smTbtIF59w
 c+Ek7VHXDLQ1SZFmHKwLTLXQBn6S3NA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-zPOmfeSIN42drYLyEC4MSA-1; Thu, 30 Mar 2023 06:48:27 -0400
X-MC-Unique: zPOmfeSIN42drYLyEC4MSA-1
Received: by mail-qv1-f69.google.com with SMTP id
 w2-20020a0cc242000000b00583d8e55181so7999492qvh.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 03:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680173306; x=1682765306;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TIDod7ZXofypu7NUVBtHJ0EV23P25HL2cdjDfrBqZcY=;
 b=pWjrR6gpyMxpsQwSHZhEczZE2M6qpqRhm3UMRkyEHwbhpdgjUq/gya/5Ld5h0WxDIp
 dAXxCUeF6V13cf9zjFGQfIudCoULEoK9ocv80rsJlugK3YFnTKF35KwVWVwHbWa8T71W
 ja1DZ9V5lyl44jXX5RwUS65Jgp3lL0lpeGPZhf7Ynqbbx06cKQKDnAJk8wZb0eUWQ9/b
 J13a7BCLoiGb3FZxg1z+8A0nqD0oPARDgXzZMB4lr4Hgb0pC7ROWHJMJJ9SApKh95Igb
 BO2VGbkPHAP+7H2W/joATzZlZt6kxxKer3ElNzzmUeXPKBNOnEa5K7OZkb5C3Dbr6BxC
 bjgg==
X-Gm-Message-State: AAQBX9fuKePsYX0GDcRTfdiEKBGyStcL80ZZcuSRpiS33XBw9xjZB6Ta
 y5tVesOXrhXOysXjKDluFgziNJ2HXvS0z+ubyXdp2kX8cCBwfWWhoIn2A+46xe7XxXN7ab2pO0A
 rMR9ApvT/D4e2SPYBAJT0by+JGsp+1hIBKR0XvroXJg==
X-Received: by 2002:a05:6214:4005:b0:5ab:af50:eb45 with SMTP id
 kd5-20020a056214400500b005abaf50eb45mr34992151qvb.3.1680173306614; 
 Thu, 30 Mar 2023 03:48:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350YDY67tBy0o9RQ5k6yj5iqQLAx/6owd7X3mSyyUGV6oV18zIIWEsjIBgDH+/vr4WGfXsj8SYQ==
X-Received: by 2002:a05:6214:4005:b0:5ab:af50:eb45 with SMTP id
 kd5-20020a056214400500b005abaf50eb45mr34992135qvb.3.1680173306396; 
 Thu, 30 Mar 2023 03:48:26 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-125.dyn.eolo.it.
 [146.241.228.125]) by smtp.gmail.com with ESMTPSA id
 l2-20020a0cee22000000b005dd8b9345d4sm5231323qvs.108.2023.03.30.03.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Mar 2023 03:48:26 -0700 (PDT)
Message-ID: <343825bad568ec0a21c283f876585585b040da9f.camel@redhat.com>
Subject: Re: [PATCH net-next 8/8] virtio_net: introduce receive_small_xdp()
From: Paolo Abeni <pabeni@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Date: Thu, 30 Mar 2023 12:48:22 +0200
In-Reply-To: <20230328120412.110114-9-xuanzhuo@linux.alibaba.com>
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
 <20230328120412.110114-9-xuanzhuo@linux.alibaba.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
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

On Tue, 2023-03-28 at 20:04 +0800, Xuan Zhuo wrote:
> @@ -949,15 +1042,11 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  {
>  	struct sk_buff *skb;
>  	struct bpf_prog *xdp_prog;
> -	unsigned int xdp_headroom = (unsigned long)ctx;
> -	unsigned int header_offset = VIRTNET_RX_PAD + xdp_headroom;
> +	unsigned int header_offset = VIRTNET_RX_PAD;
>  	unsigned int headroom = vi->hdr_len + header_offset;

This changes (reduces) the headroom for non-xpd-pass skbs.

[...]
> +	buf += header_offset;
> +	memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);

AFAICS, that also means that receive_small(), for such packets, will
look for the virtio header in a different location. Is that expected?

Thanks.

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
