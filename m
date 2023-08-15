Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDCFC001DB
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 11:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7329481F55;
	Tue, 15 Aug 2023 11:57:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7329481F55
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KQRlDnBH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q-mg1zsx4rue; Tue, 15 Aug 2023 11:57:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 14F3A81F50;
	Tue, 15 Aug 2023 11:57:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14F3A81F50
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D948EC0071;
	Tue, 15 Aug 2023 11:57:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50B01C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 11:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E1DB61102
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 11:57:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E1DB61102
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KQRlDnBH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P8j-3Gmc9H0Y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 11:57:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E9B8610FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 11:57:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5E9B8610FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692100663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bjmiQ78zXka/be7wSlHzWAbQz0mNi9OuhXjHfAzz0s=;
 b=KQRlDnBHT+PmRsgYNggYvy84rx7SKlI8RBaZWsY8XNd2Tj89hV0nVqNd2PJEPmIdjHHHzO
 bKQ4orG2jTZMkMdCMLwVaidbmEPteRBPQ418BdYLNRqeAQSyIa/ZPMsP2XSAQVALMP6WrH
 Tmm9RWAE87BmAhsG8d821ruWeKZWbL0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-EBaZtqo8MwiUaMbjuKgrOA-1; Tue, 15 Aug 2023 07:57:42 -0400
X-MC-Unique: EBaZtqo8MwiUaMbjuKgrOA-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-589ac93bc6eso71801227b3.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 04:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692100661; x=1692705461;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3bjmiQ78zXka/be7wSlHzWAbQz0mNi9OuhXjHfAzz0s=;
 b=XAiJBGiI20ZK1OUkGZzFrxyvRyXhM3ki0871yKfeEIZ43vxm2MH/hteC30Eecvbvnp
 oW0R42fOq1kKd/fywippvzlQVA3rKGgYBdqoBFAytKWuIKSz/MHpUq7Pvn7D1nvzfXss
 p7LSi6H/4iaruND5HAeH9rvj85N0Pa7vENYKiZ3NOz/V7Fhnb8Q6DBBxtP3wDiEebsNf
 NGLpRLr713LlPw2wEY4ElYBoQ5EdKMfx1XZBB2+Yl823NePo7HIIpZtsLtQ1MaTahnMj
 fRH1RakuVcNv7IwhU5Am0MHH7diSvUMwieaVIb1J+qTaQ4Stkb1AUgc7zEN1s7yy8FBe
 I+fg==
X-Gm-Message-State: AOJu0YzDoVJUhyzGuWCMjLlQ/nKzdO6PQwogDpTp8sP6b/NEh/4BRkUL
 7YBD+0Heoo5KUq9txAajjLCS+FtAeV6sDk9+1xu3NMxccBmg4k6RjalPjk7+/3uQlL22I1ETi5w
 UsFalUL49rg4kdZSHGigqCklt66dIVCYbduz0aNOUSg==
X-Received: by 2002:a81:9485:0:b0:579:e318:4c01 with SMTP id
 l127-20020a819485000000b00579e3184c01mr18861431ywg.19.1692100661585; 
 Tue, 15 Aug 2023 04:57:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa32SRzmLDzRL9d7mFMGVtctsdkaYjp8FEkY7pKzeAFfj3pB6VWOajMjS+DzIe14yU1WjDiw==
X-Received: by 2002:a81:9485:0:b0:579:e318:4c01 with SMTP id
 l127-20020a819485000000b00579e3184c01mr18861394ywg.19.1692100661208; 
 Tue, 15 Aug 2023 04:57:41 -0700 (PDT)
Received: from redhat.com ([172.58.160.133]) by smtp.gmail.com with ESMTPSA id
 b4-20020a0dd904000000b005772154dddbsm3327997ywe.24.2023.08.15.04.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 04:57:40 -0700 (PDT)
Date: Tue, 15 Aug 2023 07:57:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <20230815075702-mutt-send-email-mst@kernel.org>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
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

T24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgMDM6NTA6MjNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIEF1ZyAxNSwgMjAyMyBhdCAyOjMy4oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1
b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4KPiA+IEhpLCBKYXNvbgo+ID4KPiA+
IENvdWxkIHlvdSBza2lwIHRoaXMgcGF0Y2g/Cj4gCj4gSSdtIGZpbmUgd2l0aCBlaXRoZXIgbWVy
Z2luZyBvciBkcm9wcGluZyB0aGlzLgo+IAo+ID4KPiA+IExldCB3ZSByZXZpZXcgb3RoZXIgcGF0
Y2hlcyBmaXJzdGx5Pwo+IAo+IEkgd2lsbCBiZSBvbiB2YWNhdGlvbiBzb29uLCBhbmQgd29uJ3Qg
aGF2ZSB0aW1lIHRvIGRvIHRoaXMgdW50aWwgbmV4dCB3ZWVrLgo+IAo+IEJ1dCBJIHNwb3QgdHdv
IHBvc3NpYmxlICJpc3N1ZXMiOgo+IAo+IDEpIHRoZSBETUEgbWV0YWRhdGEgd2VyZSBzdG9yZWQg
aW4gdGhlIGhlYWRyb29tIG9mIHRoZSBwYWdlLCB0aGlzCj4gYnJlYWtzIGZyYWdzIGNvYWxlc2Np
bmcsIHdlIG5lZWQgdG8gYmVuY2htYXJrIGl0J3MgaW1wYWN0Cj4gMikgcHJlIG1hcHBlZCBETUEg
YWRkcmVzc2VzIHdlcmUgbm90IHJldXNlZCBpbiB0aGUgY2FzZSBvZiBYRFBfVFgvWERQX1JFRElS
RUNUCj4gCj4gSSBzZWUgTWljaGFlbCBoYXMgbWVyZ2UgdGhpcyBzZXJpZXMgc28gSSdtIGZpbmUg
dG8gbGV0IGl0IGdvIGZpcnN0Lgo+IAo+IFRoYW5rcwoKaXQncyBzdGlsbCBxdWV1ZWQgZm9yIG5l
eHQuIG5vdCB0b28gbGF0ZSB0byBkcm9wIG9yIGJldHRlciBhZGQKYSBwYXRjaCBvbiB0b3AuCgoK
PiA+Cj4gPiBUaGFua3MuCj4gPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
