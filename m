Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAF6C04A6A
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 06:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C18D360FF8;
	Thu, 10 Aug 2023 06:40:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C18D360FF8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SgpTqDpN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VD7jbCBsKCFU; Thu, 10 Aug 2023 06:40:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 67E1660FC8;
	Thu, 10 Aug 2023 06:40:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 67E1660FC8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F008C0072;
	Thu, 10 Aug 2023 06:40:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 708A2C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 06:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BAF8839E5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 06:40:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BAF8839E5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SgpTqDpN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BiC9TzbjDNwI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 06:40:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A556581E76
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 06:40:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A556581E76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691649642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpAVHBguoEYSzp1zJv4UMPmI6nbgaJQrFx4hgJVwo4I=;
 b=SgpTqDpNfwFC7ATASlWq0PPnJKhL9gKrFs53ZPYqdjsl19HLErpOcwo0P6bI9AT3m+5icv
 8sVEFhePpikMvanSrrDshsyEONmnMypOsz5jT9hyNKp9pX3e3RW4lSShtr3XdgogcvUv9I
 dICa2NWB38gkN3ZyenowLW93w2Z3Gvo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-e-wdP6CzMCSsUIb7hcQYUQ-1; Thu, 10 Aug 2023 02:40:41 -0400
X-MC-Unique: e-wdP6CzMCSsUIb7hcQYUQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe2477947eso3355105e9.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Aug 2023 23:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691649640; x=1692254440;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mpAVHBguoEYSzp1zJv4UMPmI6nbgaJQrFx4hgJVwo4I=;
 b=akQlcRnUxONcJNRVjjzROF/+t60hRFhfjn6xrd2YvSpTN/NdISTCXk4xGLk9rqiqGi
 FMJ24PfNkMvPO/ObbD42alDydGnLup46zKCAV4ek4aCvJ0gGFKGa9MhjpK9HFLX63JWr
 Xwh/ij9/paWtY8f9wq1dQIqpFJmr181uYojJYhkHloPmbDX4wBfF1usiJMy4gme/f2LX
 tR47VKUn53ypOScD9bQ4gBtb61K3yFC0XXRDqJ44M+YScWL/2obMW6Q83nK+s5j2CfOG
 /Pe00OEXPX8q3f4CPIOiIvb8YVrmylF0qxIJ6v/8107ugL0uAburhbzfdMDnVW+VVEaP
 MPpw==
X-Gm-Message-State: AOJu0YxuiLTUisdHBBGRNCBBeZH1u7MDjV7N709ojeZP+VkJ43BiSpaE
 tlqh4iMr+SXyIioaEnpaogAzb6rHrdhIfzxgZb9wSD2euYbwkHyIsdFAtNQzF/5BwqLsbmcZnUj
 LF2Xvguj2pyPcsPX6rEJJb/LegfLNh5Lb5QPnA8EeIlijUBRxfg==
X-Received: by 2002:a05:600c:450:b0:3fe:16c8:65fa with SMTP id
 s16-20020a05600c045000b003fe16c865famr1121049wmb.4.1691649639923; 
 Wed, 09 Aug 2023 23:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCM6lkgAXBlz0LUqL1E+QXYUzuyeeUE3clBD4wLwypBgmV9fSOtf45rM0/vHayWl88OQHUtg==
X-Received: by 2002:a05:600c:450:b0:3fe:16c8:65fa with SMTP id
 s16-20020a05600c045000b003fe16c865famr1121034wmb.4.1691649639742; 
 Wed, 09 Aug 2023 23:40:39 -0700 (PDT)
Received: from redhat.com ([2.52.137.93]) by smtp.gmail.com with ESMTPSA id
 h18-20020a1ccc12000000b003fbd9e390e1sm4008587wmb.47.2023.08.09.23.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 23:40:39 -0700 (PDT)
Date: Thu, 10 Aug 2023 02:40:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <20230810024024-mutt-send-email-mst@kernel.org>
References: <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230801121543-mutt-send-email-mst@kernel.org>
 <1690940971.9409487-2-xuanzhuo@linux.alibaba.com>
 <1691388845.9121156-1-xuanzhuo@linux.alibaba.com>
 <1691632614.950658-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuBytsv3uZcEVMKU_JvSzfHxXU9Er3Yha7=DqjMMDxpng@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuBytsv3uZcEVMKU_JvSzfHxXU9Er3Yha7=DqjMMDxpng@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBBdWcgMTAsIDIwMjMgYXQgMDI6Mzc6MjBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIEF1ZyAxMCwgMjAyMyBhdCA5OjU54oCvQU0gWHVhbiBaaHVvIDx4dWFuemh1
b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4KPiA+IFBpbmchIQo+ID4KPiA+IENv
dWxkIHdlIHB1c2ggdGhpcyB0byB0aGUgbmV4dCBsaW51eCB2ZXJzaW9uPwo+IAo+IEhvdyBhYm91
dCBpbXBsZW1lbnRpbmcgdGhlIHdyYXBwZXJzIGFsb25nIHdpdGggdmlydHF1ZXVlX2RtYV9kZXYo
KSB0bwo+IHNlZSBpZiBDaHJpc3RvcGggaXMgaGFwcHk/Cj4gCj4gVGhhbmtzCgpUaGF0LCB0b28u
Cgo+ID4KPiA+IFRoYW5rcy4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
