Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D95CDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 08:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 419DA83313;
	Thu, 19 Oct 2023 08:43:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 419DA83313
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a9jH7pcJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IP_510zN0AZ7; Thu, 19 Oct 2023 08:43:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B4A4683312;
	Thu, 19 Oct 2023 08:43:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4A4683312
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CFA5C0071;
	Thu, 19 Oct 2023 08:43:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 326CDC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 08:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B70483313
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 08:43:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B70483313
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qdkHKBfT3Xcu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 08:43:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA8FF83312
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 08:43:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA8FF83312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697704984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlqhhHztKcdEt3pYJWxTUFdsjzqtezTAvUlB2zTyOgA=;
 b=a9jH7pcJCR6DVbvpHNeXpnHF+iixdYT4v5chFfsVGoOqZeid+TyajgxRNAdN7LarF0LsNb
 81cFR8R89xxfj/n5Co8+GZDGpmZWjt4t9WxLII4znedgKuhv1ietHuZ4gw+8v/8sC0mbhy
 /kdi2qBxfKrkRw44HI9+/l5XPa/Pf3Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-E2WUrf1xMlirDn3s7TWjxw-1; Thu, 19 Oct 2023 04:43:03 -0400
X-MC-Unique: E2WUrf1xMlirDn3s7TWjxw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4083717431eso13244515e9.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697704982; x=1698309782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AlqhhHztKcdEt3pYJWxTUFdsjzqtezTAvUlB2zTyOgA=;
 b=Az6ZyttFj3J2SvoEeSEgunAh8iYGz8vzRiZGirbEMXPBH0dE+YdBbzodXb+S/KIHHV
 JngSfly0BhiZUCqyvq921to6dxFPx6XNexuWQTGzNxQgDjeofhGQW/HxtGTQ0PgKw80N
 HWjdmN00ChaIto0LHPSo0YwgisQEobRhMKNgVPH5lRZWKt63dr4Z25RgXYitFzi0Kiou
 7cV8RGgk26mwweSejbChp/68UcH+TqK5CZ7HsOEWugSrn18NwExst/qhqK1mCPw9Bm0h
 1dWhnbX1C9M56tkazf3w+60uZVgYAhwvn93O+ELfct8FRmEIhuTOMdhfVMhuAB1wto+W
 1h/Q==
X-Gm-Message-State: AOJu0Yx/1Zbq0TFSy2fMkCJtDrPgqJ5ryckFWH8lDxKht5wN3u0V2Ji1
 IauWIG2KtcXZuLvQVgmb1E/rjwXU+TfihDHPSxsgVE8BL1xO1p9uoOAu37/FwMPQ91Knkqp2RMp
 Z0Azji9wzIrMop2d5lqlNUVcU8hCJzQmNinacvZURaw==
X-Received: by 2002:a05:600c:19ca:b0:407:5b54:bb0c with SMTP id
 u10-20020a05600c19ca00b004075b54bb0cmr1374836wmq.19.1697704981951; 
 Thu, 19 Oct 2023 01:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcs+PI3KpQMhigTtyQ8yweB5gsDVKRRB+EK96wCv4w25J7K7DMddnUtKuq/gzlzEZ+F/Hmfw==
X-Received: by 2002:a05:600c:19ca:b0:407:5b54:bb0c with SMTP id
 u10-20020a05600c19ca00b004075b54bb0cmr1374826wmq.19.1697704981619; 
 Thu, 19 Oct 2023 01:43:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 o30-20020a05600c511e00b004063cd8105csm3878145wms.22.2023.10.19.01.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 01:43:01 -0700 (PDT)
Date: Thu, 19 Oct 2023 04:42:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 13/19] virtio_net: xsk: tx:
 virtnet_free_old_xmit() distinguishes xsk buffer
Message-ID: <20231019043958-mutt-send-email-mst@kernel.org>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-14-xuanzhuo@linux.alibaba.com>
 <20231016164434.3a1a51e1@kernel.org>
 <1697508125.07194-1-xuanzhuo@linux.alibaba.com>
 <20231019023739-mutt-send-email-mst@kernel.org>
 <1697699628.4189832-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1697699628.4189832-1-xuanzhuo@linux.alibaba.com>
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

On Thu, Oct 19, 2023 at 03:13:48PM +0800, Xuan Zhuo wrote:
> On Thu, 19 Oct 2023 02:38:16 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Oct 17, 2023 at 10:02:05AM +0800, Xuan Zhuo wrote:
> > > On Mon, 16 Oct 2023 16:44:34 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > > > On Mon, 16 Oct 2023 20:00:27 +0800 Xuan Zhuo wrote:
> > > > > @@ -305,9 +311,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > > > >
> > > > >  			stats->bytes += xdp_get_frame_len(frame);
> > > > >  			xdp_return_frame(frame);
> > > > > +		} else {
> > > > > +			stats->bytes += virtnet_ptr_to_xsk(ptr);
> > > > > +			++xsknum;
> > > > >  		}
> > > > >  		stats->packets++;
> > > > >  	}
> > > > > +
> > > > > +	if (xsknum)
> > > > > +		xsk_tx_completed(sq->xsk.pool, xsknum);
> > > > >  }
> > > >
> > > > sparse complains:
> > > >
> > > > drivers/net/virtio/virtio_net.h:322:41: warning: incorrect type in argument 1 (different address spaces)
> > > > drivers/net/virtio/virtio_net.h:322:41:    expected struct xsk_buff_pool *pool
> > > > drivers/net/virtio/virtio_net.h:322:41:    got struct xsk_buff_pool
> > > > [noderef] __rcu *pool
> > > >
> > > > please build test with W=1 C=1
> > >
> > > OK. I will add C=1 to may script.
> > >
> > > Thanks.
> >
> > And I hope we all understand, rcu has to be used properly it's not just
> > about casting the warning away.
> 
> 
> Yes. I see. I will use rcu_dereference() and rcu_read_xxx().
> 
> Thanks.

When you do, pls don't forget to add comments documenting what does
rcu_read_lock and synchronize_rcu.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
