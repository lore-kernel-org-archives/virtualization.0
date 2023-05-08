Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26946C77B75
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 06:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FBA441A06;
	Mon,  8 May 2023 06:46:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FBA441A06
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R3qEb5gL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rYsS-kDK_gby; Mon,  8 May 2023 06:46:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DEBCC40343;
	Mon,  8 May 2023 06:46:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DEBCC40343
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF34DC0037;
	Mon,  8 May 2023 06:46:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9F01C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8FDB14182C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:46:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8FDB14182C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OUkLND7C6BQX
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:46:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3679940343
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3679940343
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683528375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k3fs6RPd+rpkyqQt3khyJ527IXYfeK7UBkSfPv276PM=;
 b=R3qEb5gLgdKevry6yy5JEZoN4pUByLRiYcVjmE5xHmNkDgq7ArL1xfnO13hLbahv7N0bWc
 2bd4VBmEaj5uT9JxA102hU+sSuEeMosGurle4YSvdsoon44xlSXf8/AtzmDQLzNQwkH0IA
 fybqEODrihyirCFlzeOLOvXhedq46Ko=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43--Ea2At-zMyKswR_0KfMp0Q-1; Mon, 08 May 2023 02:46:14 -0400
X-MC-Unique: -Ea2At-zMyKswR_0KfMp0Q-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ac828fcd98so17764511fa.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 May 2023 23:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683528373; x=1686120373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k3fs6RPd+rpkyqQt3khyJ527IXYfeK7UBkSfPv276PM=;
 b=YLdU5XgHZ4xREDWZ3bVRo7kvT7WUIrJV/YzH7aPJYc20b5X6T7sPbcgnaNVAmsTeJH
 9x9ChIWVslAXR7K0voQkzdQqg0cm7PPVUmC0inArNGpZ//fBQt3Pnl5QiZr2wf0EPiWM
 pNk6wywdVqdeYzo+XWZ5iC2B0KwbJKcavi6Gs87O+/Xs2waExXyFvWBTlSjWqLtqq/GQ
 DrBDX8yldH6bF65mtoINCzy3B3a7RXm1xfe5FNW0Dq1xz0Oluc59bMS2ghmKsAFbWLuT
 /qKflXsxpgVQTlvN99G5tVzIQvGV3rpbWDRMA+oRwrUwnRYMeMqfiXYincGUImab0Z82
 QlBg==
X-Gm-Message-State: AC+VfDwnENMTNFbEsXXps0UkCBVKnNcdnUkkJj8xBwQdg1XS8Nmk+7ad
 PE4P0vxKjZP8qSf+b1UqtoPqnkBou9vADnTzPgrMPEzhwxdTqCwEiMMsvJs4WENDu5w6CfqsfTv
 2dsIHGHYtGux9fp12KuCSerwVy+4pOMS+Cw8V782IWWwc/tk8xXx+PQQQ1Q==
X-Received: by 2002:a2e:87c7:0:b0:2ab:51ce:649d with SMTP id
 v7-20020a2e87c7000000b002ab51ce649dmr2423164ljj.37.1683528373279; 
 Sun, 07 May 2023 23:46:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50J/yunbHFbeBJhY0AaPZdF9nZ2vK5gM3Exi7uCH8wGtCV8GnhhqTg9TvrQVh2X8Qm8JLQRjWgVfuMQMwVrW0=
X-Received: by 2002:a2e:87c7:0:b0:2ab:51ce:649d with SMTP id
 v7-20020a2e87c7000000b002ab51ce649dmr2423156ljj.37.1683528372991; Sun, 07 May
 2023 23:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230508061417.65297-1-xuanzhuo@linux.alibaba.com>
 <20230508061417.65297-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230508061417.65297-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 May 2023 14:46:01 +0800
Message-ID: <CACGkMEvZaehjDEH4rb7F-Gg_88W_AOXFockMxBLcGZqS9DLAWg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 07/15] virtio_net: virtnet_build_xdp_buff_mrg()
 auto release xdp shinfo
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
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

T24gTW9uLCBNYXkgOCwgMjAyMyBhdCAyOjE04oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiB2aXJ0bmV0X2J1aWxkX3hkcF9idWZmX21yZygpIGF1
dG8gcmVsZWFzZSB4ZHAgc2hpbmZvIHRoZW4gdGhlIGNhbGxlciBubwo+IG5lZWQgdG8gY2FyZWZ1
bCB0aGUgeGRwIHNoaW5mby4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9A
bGludXguYWxpYmFiYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4KClRoYW5rcwoKPiAtLS0KPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMTAgKysr
KysrKy0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYwo+IGluZGV4IGIyNmU5NWM5NjE0MS4uMmQxMzI5YzMyNzUxIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRp
b19uZXQuYwo+IEBAIC0xMTk0LDcgKzExOTQsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfYnVpbGRf
eGRwX2J1ZmZfbXJnKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZGV2LT5uYW1lLCAqbnVtX2J1ZiwKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2aXJ0aW8xNl90b19jcHUodmktPnZkZXYsIGhkci0+bnVtX2J1ZmZlcnMp
KTsKPiAgICAgICAgICAgICAgICAgICAgICAgICBkZXYtPnN0YXRzLnJ4X2xlbmd0aF9lcnJvcnMr
KzsKPiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiArICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIGVycjsKPiAgICAgICAgICAgICAgICAgfQo+Cj4gICAgICAgICAg
ICAgICAgIHN0YXRzLT5ieXRlcyArPSBsZW47Cj4gQEAgLTEyMTMsNyArMTIxMyw3IEBAIHN0YXRp
YyBpbnQgdmlydG5ldF9idWlsZF94ZHBfYnVmZl9tcmcoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwK
PiAgICAgICAgICAgICAgICAgICAgICAgICBwcl9kZWJ1ZygiJXM6IHJ4IGVycm9yOiBsZW4gJXUg
ZXhjZWVkcyB0cnVlc2l6ZSAlbHVcbiIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZGV2LT5uYW1lLCBsZW4sICh1bnNpZ25lZCBsb25nKSh0cnVlc2l6ZSAtIHJvb20pKTsKPiAg
ICAgICAgICAgICAgICAgICAgICAgICBkZXYtPnN0YXRzLnJ4X2xlbmd0aF9lcnJvcnMrKzsKPiAt
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiArICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIGVycjsKPiAgICAgICAgICAgICAgICAgfQo+Cj4gICAgICAgICAgICAgICAg
IGZyYWcgPSAmc2hpbmZvLT5mcmFnc1tzaGluZm8tPm5yX2ZyYWdzKytdOwo+IEBAIC0xMjI4LDYg
KzEyMjgsMTAgQEAgc3RhdGljIGludCB2aXJ0bmV0X2J1aWxkX3hkcF9idWZmX21yZyhzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2LAo+Cj4gICAgICAgICAqeGRwX2ZyYWdzX3RydWVzaXplID0geGRwX2Zy
YWdzX3RydWVzejsKPiAgICAgICAgIHJldHVybiAwOwo+ICsKPiArZXJyOgo+ICsgICAgICAgcHV0
X3hkcF9mcmFncyh4ZHApOwo+ICsgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gIH0KPgo+ICBzdGF0
aWMgdm9pZCAqbWVyZ2VhYmxlX3hkcF9nZXRfYnVmKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+
IEBAIC0xMzU3LDcgKzEzNjEsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVy
Z2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgIGVyciA9IHZp
cnRuZXRfYnVpbGRfeGRwX2J1ZmZfbXJnKGRldiwgdmksIHJxLCAmeGRwLCBkYXRhLCBsZW4sIGZy
YW1lX3N6LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmbnVtX2J1ZiwgJnhkcF9mcmFnc190cnVlc3osIHN0YXRzKTsKPiAgICAgICAgICAgICAgICAg
aWYgKHVubGlrZWx5KGVycikpCj4gLSAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfeGRw
X2ZyYWdzOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX3hkcDsKPgo+ICAgICAg
ICAgICAgICAgICBhY3QgPSB2aXJ0bmV0X3hkcF9oYW5kbGVyKHhkcF9wcm9nLCAmeGRwLCBkZXYs
IHhkcF94bWl0LCBzdGF0cyk7Cj4KPiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
