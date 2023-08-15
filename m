Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4408C001DE
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 07:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3017681E4E;
	Tue, 15 Aug 2023 07:50:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3017681E4E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U6jN1H5l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GftlAa5w4pJM; Tue, 15 Aug 2023 07:50:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ACCAA8137F;
	Tue, 15 Aug 2023 07:50:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ACCAA8137F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8498EC0071;
	Tue, 15 Aug 2023 07:50:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76492C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 07:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 48EB260F90
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 07:50:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 48EB260F90
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U6jN1H5l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zT642qx1Nngj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 07:50:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9354160F83
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 07:50:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9354160F83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692085838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUb2n6Q11KVMArkdv0WcRmLKrFLcgRyJRWatuAzlaDY=;
 b=U6jN1H5lo0nfUfm5EFL3f+knEauKYJF0K/SZtdiVoG6JsmR5cRk9Ows5rcZLZh4nZ0tuVW
 VqzYl181x/G+hYBCJjpdkV503RD7JMn58gLg2h4Z9toXn2+izCLZ8vD3qZdUtJymyLD8F+
 YRGMS8WFsHX/AU8BuHm5+DlsbNRikgE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-abtqhc-TN4Oz860kor0USw-1; Tue, 15 Aug 2023 03:50:36 -0400
X-MC-Unique: abtqhc-TN4Oz860kor0USw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b980182002so33210811fa.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 00:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692085835; x=1692690635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUb2n6Q11KVMArkdv0WcRmLKrFLcgRyJRWatuAzlaDY=;
 b=bc+V+p7u8xjLiv/A0s+AhuKANcJ+7G/Cf+D8v/aBsVrDUEQsHFhC/V/Vxq+8OI564/
 xA867q9q875xtqk/6v6aLM/ViHem9WbH9a00ERl2ZT7BJpriJuxvJsRRVIZYGo3YKJlb
 EW+66wuptbKG7eDLUBx1TSJ1xzOAiRQtnwOCh2JMBdodo0sOTMkfuRRuHq5PY66oUNUM
 XPBAQJ1v68yBl1EaLKDjhRDobST7mCa48lJ/9xeFNrgoDi9pS9lK53CQ0WJjcwYe2lKp
 tvRrHYcX8fzCq1ARKtE1+cAORF8vheG8iriLg9iBBBhzb2Om1rxEeLpkAq1eXuWcn0bi
 ua0g==
X-Gm-Message-State: AOJu0Yw23zxIGa0/IviRLRNrR2VLhTKp1w0WuxqfqGRhYkEOjxDPUIbz
 IFc9aIM1dUfzT5NCYwfIPl7L1Re3jty2CPRJbzHONnCNuFHgBkwvWx5I59AaFcRpAx8MSCjPGQ+
 9KewM6QL2t886uiPbh5o9GpagtDHxrwiIP1oMhtoWMFOKYQtaetX0XdD7pA==
X-Received: by 2002:a2e:b5cd:0:b0:2ba:8197:5b42 with SMTP id
 g13-20020a2eb5cd000000b002ba81975b42mr364200ljn.10.1692085835595; 
 Tue, 15 Aug 2023 00:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2PAmBtKQ9ZnmjhZ9eS5fy7BGjFEsLr29JIN9ZtyHi+hnDN0FBcYAl19yjmo+5USD8xM2Rvyvilm8K6oTA9Eo=
X-Received: by 2002:a2e:b5cd:0:b0:2ba:8197:5b42 with SMTP id
 g13-20020a2eb5cd000000b002ba81975b42mr364187ljn.10.1692085835304; Tue, 15 Aug
 2023 00:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1692081029.4299796-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Aug 2023 15:50:23 +0800
Message-ID: <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
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

T24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgMjozMuKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4KPiBIaSwgSmFzb24KPgo+IENvdWxkIHlvdSBza2lw
IHRoaXMgcGF0Y2g/CgpJJ20gZmluZSB3aXRoIGVpdGhlciBtZXJnaW5nIG9yIGRyb3BwaW5nIHRo
aXMuCgo+Cj4gTGV0IHdlIHJldmlldyBvdGhlciBwYXRjaGVzIGZpcnN0bHk/CgpJIHdpbGwgYmUg
b24gdmFjYXRpb24gc29vbiwgYW5kIHdvbid0IGhhdmUgdGltZSB0byBkbyB0aGlzIHVudGlsIG5l
eHQgd2Vlay4KCkJ1dCBJIHNwb3QgdHdvIHBvc3NpYmxlICJpc3N1ZXMiOgoKMSkgdGhlIERNQSBt
ZXRhZGF0YSB3ZXJlIHN0b3JlZCBpbiB0aGUgaGVhZHJvb20gb2YgdGhlIHBhZ2UsIHRoaXMKYnJl
YWtzIGZyYWdzIGNvYWxlc2NpbmcsIHdlIG5lZWQgdG8gYmVuY2htYXJrIGl0J3MgaW1wYWN0CjIp
IHByZSBtYXBwZWQgRE1BIGFkZHJlc3NlcyB3ZXJlIG5vdCByZXVzZWQgaW4gdGhlIGNhc2Ugb2Yg
WERQX1RYL1hEUF9SRURJUkVDVAoKSSBzZWUgTWljaGFlbCBoYXMgbWVyZ2UgdGhpcyBzZXJpZXMg
c28gSSdtIGZpbmUgdG8gbGV0IGl0IGdvIGZpcnN0LgoKVGhhbmtzCgo+Cj4gVGhhbmtzLgo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
