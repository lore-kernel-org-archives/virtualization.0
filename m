Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75987CDB482
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 06:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D8C0428CE;
	Thu, 19 Oct 2023 06:38:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D8C0428CE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XB+Ruy6T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7lNXLQl4dacv; Thu, 19 Oct 2023 06:38:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8471442892;
	Thu, 19 Oct 2023 06:38:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8471442892
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F96EC0071;
	Thu, 19 Oct 2023 06:38:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16224C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F36E06FAD2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:38:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F36E06FAD2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XB+Ruy6T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tPoBmYPoM3dR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:38:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1FE26FAA3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:38:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1FE26FAA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697697509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Blqwk8CZOAuxak9k7tu36Lndth1mX4n5z0UG75CC1Vc=;
 b=XB+Ruy6TfvZmN1OzV6R/RcN28CUwYvB3wJlf0CfMpb2duH8dWVq8SskWXQthHYaXeJTIEz
 wwpye0fGs9uC2cAB8SPYQE0hi/Wn4c6YZfVcPoly6/evrxehTmO3zZ2VXnysDvesdcrxqV
 pxMpKwaaDPhoT3g9RrGuMACh4Qd4VTU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-tUDaoNTNOGqUUv57vs84-w-1; Thu, 19 Oct 2023 02:38:23 -0400
X-MC-Unique: tUDaoNTNOGqUUv57vs84-w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so55413795e9.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 23:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697697502; x=1698302302;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Blqwk8CZOAuxak9k7tu36Lndth1mX4n5z0UG75CC1Vc=;
 b=K4vTTqU2XvnJKhtioy4IIfjA3yCARQdBD8FfWdxh5acKnLO4c0395TriPxM8aT67Sm
 1j+Hq4x9klBqwoxP1eBCFlHVh8pKZ0dvo4KJuko9ABZIjSp0hSqDOdGC0rCcuksM0+aI
 FjervtIxf3ZMSWYk6MGOjmOA66vB4Jk4FoGm/tdXE1SVcsy3b6+g/3Ww2m2inBfxilCf
 RKNNgKGET6U28QWjogFbJNJvmHnJpel81RGTE4dEKQdKawfIFanKq6kYeNJtR5G3vr3m
 opbw40uXOB1Hul/4dtRDK4r7uOyHnS7b3zJtxlxVJIgYbsER4h0WTixxksyXTP5sRMBb
 PokQ==
X-Gm-Message-State: AOJu0YylwjxFlVpN6ve43whxIpcNG2MnU1tnR8GwPsp9bf5gPcJ04eFu
 FA3EdicW2SMV3ac37zBdmRNYxgA1mZEP77CskAbY+u3+v3k9lYpZAvbMqjooID4XTFEGlv322oz
 U5W8rivV8/4TkgbdU8fbvRlxZWOmg/scBppVY2NsH1Q==
X-Received: by 2002:a05:600c:c0c:b0:407:7e5f:ffb9 with SMTP id
 fm12-20020a05600c0c0c00b004077e5fffb9mr1104335wmb.9.1697697502081; 
 Wed, 18 Oct 2023 23:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9qh0cDCENMRB0qEBa29pUmbeWcdQ3FQ1ygusFYggBDj+0Bntc+WUE/xD8GAaiDYHR1Jei5w==
X-Received: by 2002:a05:600c:c0c:b0:407:7e5f:ffb9 with SMTP id
 fm12-20020a05600c0c0c00b004077e5fffb9mr1104320wmb.9.1697697501762; 
 Wed, 18 Oct 2023 23:38:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c1c1400b004065daba6casm3604423wms.46.2023.10.18.23.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 23:38:21 -0700 (PDT)
Date: Thu, 19 Oct 2023 02:38:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 13/19] virtio_net: xsk: tx:
 virtnet_free_old_xmit() distinguishes xsk buffer
Message-ID: <20231019023739-mutt-send-email-mst@kernel.org>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-14-xuanzhuo@linux.alibaba.com>
 <20231016164434.3a1a51e1@kernel.org>
 <1697508125.07194-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1697508125.07194-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

On Tue, Oct 17, 2023 at 10:02:05AM +0800, Xuan Zhuo wrote:
> On Mon, 16 Oct 2023 16:44:34 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Mon, 16 Oct 2023 20:00:27 +0800 Xuan Zhuo wrote:
> > > @@ -305,9 +311,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > >
> > >  			stats->bytes += xdp_get_frame_len(frame);
> > >  			xdp_return_frame(frame);
> > > +		} else {
> > > +			stats->bytes += virtnet_ptr_to_xsk(ptr);
> > > +			++xsknum;
> > >  		}
> > >  		stats->packets++;
> > >  	}
> > > +
> > > +	if (xsknum)
> > > +		xsk_tx_completed(sq->xsk.pool, xsknum);
> > >  }
> >
> > sparse complains:
> >
> > drivers/net/virtio/virtio_net.h:322:41: warning: incorrect type in argument 1 (different address spaces)
> > drivers/net/virtio/virtio_net.h:322:41:    expected struct xsk_buff_pool *pool
> > drivers/net/virtio/virtio_net.h:322:41:    got struct xsk_buff_pool
> > [noderef] __rcu *pool
> >
> > please build test with W=1 C=1
> 
> OK. I will add C=1 to may script.
> 
> Thanks.

And I hope we all understand, rcu has to be used properly it's not just
about casting the warning away.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
