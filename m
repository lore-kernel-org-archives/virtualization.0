Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B2AC77B73
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 06:32:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 690CB42641;
	Thu, 20 Apr 2023 06:32:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 690CB42641
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZiIlYa2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9eEgU-iGx5Ln; Thu, 20 Apr 2023 06:32:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B2864263A;
	Thu, 20 Apr 2023 06:32:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B2864263A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E13F9C0036;
	Thu, 20 Apr 2023 06:32:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D28D6C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:32:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A395540127
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:32:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A395540127
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZiIlYa2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kAcDp162Yros
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:32:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 609D6400D1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 609D6400D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681972371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSt4vJ6JebWC94KoDTMIHxTA6Bf2J+lWbCuixu0az/4=;
 b=dZiIlYa2/wIPqUP+8AU3HjO9o8YFE1SQVwEGApiXwL68M3njGy2bL5SSif1VVAnwNP8cEn
 v8aLtaSbeoyVonC6mlDoFM1Z9p2fesw7x3QJk+43wGIWIwPooMs+8E8G3d11TymdPIEPWt
 uN2Jjo3mhiD2Xy+I5TgX98VJtjSW+Es=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-2pAZYH2zOfW2Ld_MmLJBhw-1; Thu, 20 Apr 2023 02:32:50 -0400
X-MC-Unique: 2pAZYH2zOfW2Ld_MmLJBhw-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-38de987ca58so377299b6e.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 23:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681972370; x=1684564370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PSt4vJ6JebWC94KoDTMIHxTA6Bf2J+lWbCuixu0az/4=;
 b=f8qHMBy3sjOBRB5aVW/whVyRY4g4fIcyMyIbUOGnGssvOfLGGvn8AVjG/OSAXhzlEK
 3U96yImbsrKMyYpb4e2BN7v9iLOxrjeum6A75BfOjvivojxbYiteEvb1XNUiUvzzBt9U
 NTTXJ/dMPoIML96V5e0IwVZTfbDQFeE9pvpo9VUuJHX6/fLnw6yetQXZUtN1a51Gw8hb
 HiInEKZut/F6IBgUNRCtB981C1gLpTS1VFE2/vQotJzzK3DezXH8znQI4hVii6H2jPbl
 AGGErd79b8HbJfWvJ/JCBdMmPHXoLPGC9R4CKm7wAl7S6sLlJOhL/LmThAet6aiMJk/B
 z8Ag==
X-Gm-Message-State: AAQBX9c4/J+nJMLQyHSER76P15xm5Amv8HzTiesP2IEU35lBv381YM3a
 EMDqw3PebEHwnkb9uWgQlXz9QnMz0n5f3qu0mT307mda3qzBB37PdO13wPZeWGjBqW8X5QXEyfM
 pgAbghjMDNTAuco8OeQ42pg/5JGDRVuBkmmVc3t8Qn9Y6rYbyQV5uPmPVrw==
X-Received: by 2002:a05:6808:30a2:b0:38e:67d7:9d0e with SMTP id
 bl34-20020a05680830a200b0038e67d79d0emr328353oib.31.1681972369451; 
 Wed, 19 Apr 2023 23:32:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350aeHvzKzDJfinP2eZ1Sdj3X4Zpydu2RwxzgLVr1a7/071YWVYaLIeuA0ANa6w9WFB2KKl0o7pvkgAkp4OyBTE4=
X-Received: by 2002:a05:6808:30a2:b0:38e:67d7:9d0e with SMTP id
 bl34-20020a05680830a200b0038e67d79d0emr328341oib.31.1681972368876; Wed, 19
 Apr 2023 23:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
 <20230418065327.72281-14-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230418065327.72281-14-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Apr 2023 14:32:37 +0800
Message-ID: <CACGkMEtubJ8ND01J+Arpa4TB5kfdap7t6f9D5qc7-XkeFZYRKQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 13/14] virtio_net: small: optimize code
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

T24gVHVlLCBBcHIgMTgsIDIwMjMgYXQgMjo1M+KAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gQXZvaWQgdGhlIHByb2JsZW0gdGhhdCBzb21lIHZh
cmlhYmxlcyhoZWFkcm9vbSBhbmQgc28gb24pIHdpbGwgcmVwZWF0Cj4gdGhlIGNhbGN1bGF0aW9u
IHdoZW4gcHJvY2VzcyB4ZHAuCgpXaGlsZSBhdCBpdCwgaWYgd2UgYWdyZWUgdG8gdXNlIHNlcGFy
YXRlIGNvZGUgcGF0aHMgZm9yIGJ1aWxkaW5nIHNrYnMuCgpJdCB3b3VsZCBiZSBiZXR0ZXIgdG8g
aGF2ZSBhIGhlbHBlciBmb3IgYnVpbGRpbmcgc2tiIGZvciBub24gWERQCmNhc2VzLCB0aGVuIHdl
IGNhbiBoaWRlIHRob3NlIGNhbGN1bGF0aW9uIHRoZXJlLgoKVGhhbmtzCgo+Cj4gU2lnbmVkLW9m
Zi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jIHwgMTIgKysrKysrKystLS0tCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggZjZm
NTkwM2ZhY2UyLi41YTU2MzYxNzhiZDMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTEwNDAsMTEgKzEw
NDAsMTAgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX3NtYWxsKHN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYsCj4gICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiOwo+ICAgICAgICAgc3Ry
dWN0IGJwZl9wcm9nICp4ZHBfcHJvZzsKPiAgICAgICAgIHVuc2lnbmVkIGludCB4ZHBfaGVhZHJv
b20gPSAodW5zaWduZWQgbG9uZyljdHg7Cj4gLSAgICAgICB1bnNpZ25lZCBpbnQgaGVhZGVyX29m
ZnNldCA9IFZJUlRORVRfUlhfUEFEICsgeGRwX2hlYWRyb29tOwo+IC0gICAgICAgdW5zaWduZWQg
aW50IGhlYWRyb29tID0gdmktPmhkcl9sZW4gKyBoZWFkZXJfb2Zmc2V0Owo+IC0gICAgICAgdW5z
aWduZWQgaW50IGJ1ZmxlbiA9IFNLQl9EQVRBX0FMSUdOKEdPT0RfUEFDS0VUX0xFTiArIGhlYWRy
b29tKSArCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0tCX0RBVEFfQUxJR04oc2l6
ZW9mKHN0cnVjdCBza2Jfc2hhcmVkX2luZm8pKTsKPiAgICAgICAgIHN0cnVjdCBwYWdlICpwYWdl
ID0gdmlydF90b19oZWFkX3BhZ2UoYnVmKTsKPiArICAgICAgIHVuc2lnbmVkIGludCBoZWFkZXJf
b2Zmc2V0Owo+ICsgICAgICAgdW5zaWduZWQgaW50IGhlYWRyb29tOwo+ICsgICAgICAgdW5zaWdu
ZWQgaW50IGJ1ZmxlbjsKPgo+ICAgICAgICAgbGVuIC09IHZpLT5oZHJfbGVuOwo+ICAgICAgICAg
c3RhdHMtPmJ5dGVzICs9IGxlbjsKPiBAQCAtMTA3Miw2ICsxMDcxLDExIEBAIHN0YXRpYyBzdHJ1
Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9zbWFsbChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgICAg
ICAgcmN1X3JlYWRfdW5sb2NrKCk7Cj4KPiAgc2tpcF94ZHA6Cj4gKyAgICAgICBoZWFkZXJfb2Zm
c2V0ID0gVklSVE5FVF9SWF9QQUQgKyB4ZHBfaGVhZHJvb207Cj4gKyAgICAgICBoZWFkcm9vbSA9
IHZpLT5oZHJfbGVuICsgaGVhZGVyX29mZnNldDsKPiArICAgICAgIGJ1ZmxlbiA9IFNLQl9EQVRB
X0FMSUdOKEdPT0RfUEFDS0VUX0xFTiArIGhlYWRyb29tKSArCj4gKyAgICAgICAgICAgICAgIFNL
Ql9EQVRBX0FMSUdOKHNpemVvZihzdHJ1Y3Qgc2tiX3NoYXJlZF9pbmZvKSk7Cj4gKwo+ICAgICAg
ICAgc2tiID0gYnVpbGRfc2tiKGJ1ZiwgYnVmbGVuKTsKPiAgICAgICAgIGlmICghc2tiKQo+ICAg
ICAgICAgICAgICAgICBnb3RvIGVycjsKPiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
