Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5527C04A6A
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 06:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D09460FBB;
	Thu, 10 Aug 2023 06:37:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D09460FBB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kn8MYQcB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HiDdLdwW-F4H; Thu, 10 Aug 2023 06:37:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 967E060AE5;
	Thu, 10 Aug 2023 06:37:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 967E060AE5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C7FFC0072;
	Thu, 10 Aug 2023 06:37:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E822AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 06:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B92EC83A67
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 06:37:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B92EC83A67
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kn8MYQcB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yoTov6d9Foxe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 06:37:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 194358380B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 06:37:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 194358380B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691649456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSNLC6BB/rIG6JAwglNeuVJJEDiOdKe+AYgeEbBc/lo=;
 b=Kn8MYQcBkgCE0wJbe8ObKStr/TGnVM6qHKMh9cpynTI0wd8B8fxi+qOf9rOQ1cK9Rje7P+
 cxlWcEeDeGK3xUghA1WI/LZ4K1L+wfPiEDIYhXylnESYJ2r/Eo8C7Xj+8Td6jGl8nxBIOs
 /h8sehZNxj/ftRAI8zHvGp5GuUmFSOA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-m-o_9dwPMJi-ZWeYn1DcSA-1; Thu, 10 Aug 2023 02:37:33 -0400
X-MC-Unique: m-o_9dwPMJi-ZWeYn1DcSA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fe3fb358easo526660e87.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Aug 2023 23:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691649452; x=1692254252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSNLC6BB/rIG6JAwglNeuVJJEDiOdKe+AYgeEbBc/lo=;
 b=B5Ki72psHwdyejUCWo67kJr1vTNxNjR3aYieazVcxTDU1thI55QL+S2r8YLMW/0TE6
 yPt4sHU+2A7Q6INcx8tJGcQ2NcZNT/yyAzBrtBDqkL1PD+AcP4erZnvFLT770xXBmRr6
 vrsLalBYpClqtlbXr8LqaV2k12MEaqAIRYQ5hddTqKLLHzrs2L5caZA5NXecjWyKESXH
 eCektT48M1FefQRCA2QOncihD2tavCjGiDa1eYU6tF5hpUAIbC22BtKI0tres1fNY4Hd
 sHZ5HHXovMldO7Kx602wROg1LCds+WxnP1Womhui4tsgJEiwHxVzjU7dllwki1WWZ7lp
 Zyog==
X-Gm-Message-State: AOJu0YyGKY1sWVgrKLC1ayd/Lhl7+TbDgqFDemc/f1IdNsMUvvjt5JPh
 u/U7RC5AndCu0BrXBVFCisTkc0/PP9f5HRIyvFQY4j5Z6wwQUPeb754VF2EEpUUQ3C06D0iwK70
 Td6wVkX0v7D064yyprpq6d/+j8/EfOX7SwDBVmzcUPbnbmDmrrbt3PVJ4Zw==
X-Received: by 2002:a2e:3a13:0:b0:2ba:3eac:bece with SMTP id
 h19-20020a2e3a13000000b002ba3eacbecemr1006405lja.49.1691649452061; 
 Wed, 09 Aug 2023 23:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJpXi/a4Vbryg7Fl7HPBw1URqscGlQaQzUr+KC+DXEyOalDWFvBvFxtKqjVMF2nh7cLKtEKJ77bDQThv1jTFw=
X-Received: by 2002:a2e:3a13:0:b0:2ba:3eac:bece with SMTP id
 h19-20020a2e3a13000000b002ba3eacbecemr1006397lja.49.1691649451800; Wed, 09
 Aug 2023 23:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230801121543-mutt-send-email-mst@kernel.org>
 <1690940971.9409487-2-xuanzhuo@linux.alibaba.com>
 <1691388845.9121156-1-xuanzhuo@linux.alibaba.com>
 <1691632614.950658-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691632614.950658-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Aug 2023 14:37:20 +0800
Message-ID: <CACGkMEuBytsv3uZcEVMKU_JvSzfHxXU9Er3Yha7=DqjMMDxpng@mail.gmail.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
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

T24gVGh1LCBBdWcgMTAsIDIwMjMgYXQgOTo1OeKAr0FNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4KPiBQaW5nISEKPgo+IENvdWxkIHdlIHB1c2ggdGhp
cyB0byB0aGUgbmV4dCBsaW51eCB2ZXJzaW9uPwoKSG93IGFib3V0IGltcGxlbWVudGluZyB0aGUg
d3JhcHBlcnMgYWxvbmcgd2l0aCB2aXJ0cXVldWVfZG1hX2RldigpIHRvCnNlZSBpZiBDaHJpc3Rv
cGggaXMgaGFwcHk/CgpUaGFua3MKCj4KPiBUaGFua3MuCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
