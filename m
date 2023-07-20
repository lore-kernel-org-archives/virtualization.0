Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98724EB64DC
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 07:42:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28E8360AFF;
	Thu, 20 Jul 2023 07:42:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28E8360AFF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g12sMbNC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L8syqx0O6vuK; Thu, 20 Jul 2023 07:42:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A2B6B60C1F;
	Thu, 20 Jul 2023 07:42:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2B6B60C1F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70092C0072;
	Thu, 20 Jul 2023 07:42:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5A47C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 07:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A866660E25
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 07:42:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A866660E25
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PYppkz5_J5mj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 07:42:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40A2660C1F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 07:42:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 40A2660C1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689838931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJtpCG9zhhGX7NtLxzTudWbkt/DuRh61nie9AceVl2I=;
 b=g12sMbNC9EmjBQe7cUbwWqv391x8cEp1re1RCWVN/yI1sa8/c+pfCAdweBwe7UWYBhRku6
 Ez3MONLo0HfPEGYJuOBfymvMWobEywfceVMKDU26gvP0udLCc3YCOGattDb0chk2LrGJ//
 +oNTqi2ExWwpCuiw9MQhv2XWpkSFn3I=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-qCF-Zk0lNqWzjAiEBSzepQ-1; Thu, 20 Jul 2023 03:42:09 -0400
X-MC-Unique: qCF-Zk0lNqWzjAiEBSzepQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6fbf1305fso4573041fa.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 00:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689838928; x=1692430928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJtpCG9zhhGX7NtLxzTudWbkt/DuRh61nie9AceVl2I=;
 b=GstxxrjrmwUuHGZ3y81DtVn/XcHcJPDs8qeXNoIrlHSuhh0fk1k1UvRAi56YpBB0G9
 LpQQJpG8NfC7PO1Rp7ab4aEiltIFPKtuGDn6QrbKUWV/V7Y3qqUMTK3TdHxSP/qneDn1
 LlJ4ITDFDHBIY8OP2wWYrlAz/TlIMBEQATYV1rA0ugc0+xJY3h69qYLyWfyxTiT7Jo04
 TzeZlXsah/AZBTy3whTThwJK2z7LPvmbsWbBkqqEoGBKAaKTmWLvIThsM1Uj8MaW5zuc
 6QmB6kQL3AUnh5K3OayO54yMLWPwcFCHOcT8iZTYPXJASNxy3g/PojJnHIsk+5x2j7dU
 a0/g==
X-Gm-Message-State: ABy/qLaef2JwaO+jNKIY5woghvNWo+cC9bbdH7qrMAVvjV5qeVoLgkU5
 ucfgmqdvk39moMeSqMUm170PUNbjb517eBidOHVU/prsNTdiKMeoocU91DjO6/6p1i9fBP5n46t
 ing+ZFn3yZ8MqQ6gsM6NYeGu5FGZCC7gMREVYQGeBicBb08ZqFnrCjDFrjQ==
X-Received: by 2002:a2e:b705:0:b0:2b9:5fd2:763a with SMTP id
 j5-20020a2eb705000000b002b95fd2763amr1615003ljo.35.1689838928241; 
 Thu, 20 Jul 2023 00:42:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFu+k5ZrMkQd2anF8aWE9EZzH1m96rLrkmjQzi71csOsVj3MZfM8zyG9H1kdd7cZfq4E2nEHoiz7btC/Za/LcQ=
X-Received: by 2002:a2e:b705:0:b0:2b9:5fd2:763a with SMTP id
 j5-20020a2eb705000000b002b95fd2763amr1614992ljo.35.1689838927964; Thu, 20 Jul
 2023 00:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-11-xuanzhuo@linux.alibaba.com>
 <CACGkMEtoiHXese1sNJELeidmFc6nFR8rE1aA8MooaEKKUSw_eg@mail.gmail.com>
 <1689231087.0744615-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsf4+56veqem1HMWiqYhiW5LVw-1CbWX-cQSN6Z0zYMRQ@mail.gmail.com>
 <ZLjS4D7urgIK1MxV@infradead.org>
In-Reply-To: <ZLjS4D7urgIK1MxV@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jul 2023 15:41:56 +0800
Message-ID: <CACGkMEsbzWU3+pA1kLNwGEmwYjP9riRANpUtsmE-YXJmnFAuhw@mail.gmail.com>
Subject: Re: [PATCH vhost v11 10/10] virtio_net: merge dma operation for one
 page
To: Christoph Hellwig <hch@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBKdWwgMjAsIDIwMjMgYXQgMjoyM+KAr1BNIENocmlzdG9waCBIZWxsd2lnIDxoY2hA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4KPiBIaSBKYXNvbiwKPgo+IGNhbiB5b3UgcGxlYXNlIHJl
c2VuZCB5b3VyIHJlcGx5IHdpdGggcHJvcGVyIHF1b3Rpbmc/ICBJIGhhZCB0byBnaXZlCj4gdXAg
YWZ0ZXIgbXVsdGlwbGUgcGFnZXMgb2Ygc2Nyb2xsaW5nIHdpdGhvdXQgZmluZGluZyBhbnl0aGlu
ZyB0aGF0Cj4geW91IGFkZGVkIHRvIHRoZSBmdWxsIHF1b3RlLgoKSSBndWVzcyBpdCdzIHRoaXMg
cGFydD8KCj4gPiA+IFlvdSBzaG91bGQgYWxzbyB0ZXN0IHdpdGhvdXQgaW9tbXUgYnV0IHdpdGgg
c3dpb3RsYj1mb3JjZQo+ID4KPiA+Cj4gPiBGb3Igc3dpb3RsYiwgbWVyZ2UgRE1BIGhhcyBubyBi
ZW5lZml0LCBiZWNhdXNlIHdlIHN0aWxsIG5lZWQgdG8gY29weSBkYXRhIGZyb20KPiA+IHN3aW90
bGIgYnVmZmVyIHRvIHRoZSBvcmlnaW4gYnVmZmVyLgo+ID4gVGhlIGJlbmVmaXQgb2YgdGhlIG1l
cmdlIERNQSBpcyB0byByZWR1Y2UgdGhlIG9wZXJhdGUgdG8gdGhlIGlvbW11IGRldmljZS4KPiA+
Cj4gPiBJIGRpZCBzb21lIHRlc3QgZm9yIHRoaXMuIFRoZSByZXN1bHQgaXMgc2FtZS4KPiA+Cj4g
PiBUaGFua3MuCj4gPgo+Cj4gRGlkIHlvdSBhY3R1YWxseSBjaGVjayB0aGF0IGl0IHdvcmtzIHRo
b3VnaD8KPiBMb29rcyBsaWtlIHdpdGggc3dpb3RsYiB5b3UgbmVlZCB0byBzeW5jaCB0byB0cmln
Z2VyIGEgY29weQo+IGJlZm9yZSB1bm1hcCwgYW5kIEkgZG9uJ3Qgc2VlIHdoZXJlIGl0J3MgZG9u
ZSBpbiB0aGUgY3VycmVudAo+IHBhdGNoLgoKQW5kIHRoaXMgaXMgbmVlZGVkIGZvciBYRFBfUkVE
SVJFQ1QgYXMgd2VsbC4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
