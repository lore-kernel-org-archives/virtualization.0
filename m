Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F42C77B72
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 05:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7534C8213B;
	Thu, 20 Apr 2023 05:59:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7534C8213B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ys0WoRPc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8LFltUljAw2l; Thu, 20 Apr 2023 05:59:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0D71382116;
	Thu, 20 Apr 2023 05:59:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D71382116
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7FE9C0037;
	Thu, 20 Apr 2023 05:59:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57F8CC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 32F0F403BE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:59:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 32F0F403BE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ys0WoRPc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yDiYtmFQt5QU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:59:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CD4640235
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CD4640235
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681970384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOT/kX4gf+xT7Jpgl6i4GUFgvOJ6y//TH2KtWxwy3rM=;
 b=Ys0WoRPcid6vE/vsWTlfBs/oT+9qXOxadfdQSOtVWossALOzzbjPwiTK25wP1gJaG5rqmP
 ht2DVHL2QF886Eg164V8oCXLlecBlKfcMmm4PNCxsoa8UG+rD6wtY92yhoLSivp1jD3AWg
 PMf4hAWbG+pzfy+jybUU4zY7D+SJi3w=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-CvQ1Crr0Ps2I26ul5moRJA-1; Thu, 20 Apr 2023 01:59:42 -0400
X-MC-Unique: CvQ1Crr0Ps2I26ul5moRJA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1880c463494so101165fac.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 22:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681970381; x=1684562381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MOT/kX4gf+xT7Jpgl6i4GUFgvOJ6y//TH2KtWxwy3rM=;
 b=QI4f5LXjOx3Ym3kPR10vx52cJxd+YGYCYZGAKrPu+YcDaLX+qy2lngyWLZYAZHodnW
 T5L2IubCMKdrM8t7fT2RM0fhX1RUT/w6AQpYjxMy4o5t6YVCbQk8NyVTcJqwlwoCZRp1
 n3ZiyzWEQzJT8KHrsMP1qY+LWaxpdN2oFAvVxUEBncYgs0MBHn1glq1nJYxTafGJMtJn
 D3/6aIvPEKOR56BwnHTQWbBJJsvt3dCSjmCJZWsNkiMh17Y8K0nwLhhmw2hF3eftjDm0
 lHHe2839V5OpnCroQvIz4R2mo2NpAwnTadOYIcecJfXCo6N/Tr3n5vHXtuYmosQvQ5r9
 dbhw==
X-Gm-Message-State: AAQBX9d3rTNHuJMLpJ8VG6vhhOMNypQpdZK8wd+khQfB5SyS61jJfbAB
 ruGSy2yGjmiUoEWkNi9alBNC76gzJwyzrY2UCzQ6HYBEkNVHGU9kyDBoYc/U3Ngc+rTbl8yNm9E
 qJk4eU4rHKzBDylxGhDkEuYI0z1sPqS0pDq1JkqNMNr4CJIIag6MnTRE3CA==
X-Received: by 2002:a4a:9568:0:b0:546:bf26:49c7 with SMTP id
 n37-20020a4a9568000000b00546bf2649c7mr282658ooi.8.1681970381685; 
 Wed, 19 Apr 2023 22:59:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZAYMlIc/3+pmbc1QJgAczTJTKv7IFleZBke0nUWM4eoioQaqflifvfwcgxp+AH90EwVvJSeCdgT6Z6jiSv410=
X-Received: by 2002:a4a:9568:0:b0:546:bf26:49c7 with SMTP id
 n37-20020a4a9568000000b00546bf2649c7mr282648ooi.8.1681970381445; Wed, 19 Apr
 2023 22:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
 <20230418065327.72281-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230418065327.72281-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Apr 2023 13:59:30 +0800
Message-ID: <CACGkMEuNxh-YC6A=nyt682ReSbujbgepABgwX0Y+WW30XgFktA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 08/14] virtio_net: auto release xdp shinfo
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
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gdmlydG5ldF9idWlsZF94ZHBfYnVmZl9tcmcoKSBh
bmQgdmlydG5ldF94ZHBfaGFuZGxlcigpIGF1dG8KPiByZWxlYXNlIHhkcCBzaGluZm8gdGhlbiB0
aGUgY2FsbGVyIG5vIG5lZWQgdG8gY2FyZWZ1bCB0aGUgeGRwIHNoaW5mby4KPgo+IFNpZ25lZC1v
ZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gIGRy
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDI5ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiBpbmRleCBlMmVhZGU4N2QyZDQuLjI2NmMxNjcwYmVkYSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPiBAQCAtODM0LDcgKzgzNCw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94ZHBfaGFuZGxlcihz
dHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nLCBzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCwKPiAgICAgICAg
ICAgICAgICAgeGRwZiA9IHhkcF9jb252ZXJ0X2J1ZmZfdG9fZnJhbWUoeGRwKTsKPiAgICAgICAg
ICAgICAgICAgaWYgKHVubGlrZWx5KCF4ZHBmKSkgewo+ICAgICAgICAgICAgICAgICAgICAgICAg
IG5ldGRldl9kYmcoZGV2LCAiY29udmVydCBidWZmIHRvIGZyYW1lIGZhaWxlZCBmb3IgeGRwXG4i
KTsKPiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gVklSVE5FVF9YRFBfUkVTX0RST1A7
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBkcm9wOwo+ICAgICAgICAgICAgICAgICB9
Cj4KPiAgICAgICAgICAgICAgICAgZXJyID0gdmlydG5ldF94ZHBfeG1pdChkZXYsIDEsICZ4ZHBm
LCAwKTsKPiBAQCAtODQyLDcgKzg0Miw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94ZHBfaGFuZGxl
cihzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nLCBzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCwKPiAgICAg
ICAgICAgICAgICAgICAgICAgICB4ZHBfcmV0dXJuX2ZyYW1lX3J4X25hcGkoeGRwZik7Cj4gICAg
ICAgICAgICAgICAgIH0gZWxzZSBpZiAodW5saWtlbHkoZXJyIDwgMCkpIHsKPiAgICAgICAgICAg
ICAgICAgICAgICAgICB0cmFjZV94ZHBfZXhjZXB0aW9uKGRldiwgeGRwX3Byb2csIGFjdCk7Cj4g
LSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFZJUlRORVRfWERQX1JFU19EUk9QOwo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZHJvcDsKPiAgICAgICAgICAgICAgICAgfQo+Cj4g
ICAgICAgICAgICAgICAgICp4ZHBfeG1pdCB8PSBWSVJUSU9fWERQX1RYOwo+IEBAIC04NTIsNyAr
ODUyLDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF9oYW5kbGVyKHN0cnVjdCBicGZfcHJvZyAq
eGRwX3Byb2csIHN0cnVjdCB4ZHBfYnVmZiAqeGRwLAo+ICAgICAgICAgICAgICAgICBzdGF0cy0+
eGRwX3JlZGlyZWN0cysrOwo+ICAgICAgICAgICAgICAgICBlcnIgPSB4ZHBfZG9fcmVkaXJlY3Qo
ZGV2LCB4ZHAsIHhkcF9wcm9nKTsKPiAgICAgICAgICAgICAgICAgaWYgKGVycikKPiAtICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gVklSVE5FVF9YRFBfUkVTX0RST1A7Cj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgZ290byBkcm9wOwo+Cj4gICAgICAgICAgICAgICAgICp4ZHBfeG1pdCB8
PSBWSVJUSU9fWERQX1JFRElSOwo+ICAgICAgICAgICAgICAgICByZXR1cm4gVklSVE5FVF9YRFBf
UkVTX0NPTlNVTUVEOwo+IEBAIC04NjQsOCArODY0LDEyIEBAIHN0YXRpYyBpbnQgdmlydG5ldF94
ZHBfaGFuZGxlcihzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nLCBzdHJ1Y3QgeGRwX2J1ZmYgKnhk
cCwKPiAgICAgICAgICAgICAgICAgdHJhY2VfeGRwX2V4Y2VwdGlvbihkZXYsIHhkcF9wcm9nLCBh
Y3QpOwo+ICAgICAgICAgICAgICAgICBmYWxsdGhyb3VnaDsKPiAgICAgICAgIGNhc2UgWERQX0RS
T1A6Cj4gLSAgICAgICAgICAgICAgIHJldHVybiBWSVJUTkVUX1hEUF9SRVNfRFJPUDsKPiArICAg
ICAgICAgICAgICAgYnJlYWs7Cj4gICAgICAgICB9Cj4gKwo+ICtkcm9wOgo+ICsgICAgICAgcHV0
X3hkcF9mcmFncyh4ZHApOwo+ICsgICAgICAgcmV0dXJuIFZJUlRORVRfWERQX1JFU19EUk9QOwo+
ICB9CgpQYXRjaCBsb29rcyBjb3JyZWN0IGJ1dCB3ZSBlbmQgdXAgc29tZSBpbmNvbnNpc3RlbmN5
IGhlcmUuCgpmcmFncyBhcmUgYXV0b21hdGljYWxseSByZWxlYXNlZC4KCmJ1dCB0aGUgcGFnZSBz
dGlsbCBuZWVkcyB0byBiZSBmcmVlZCBieSB0aGUgY2FsbGVyPwoKVGhhbmtzCgoKPgo+ICBzdGF0
aWMgdW5zaWduZWQgaW50IHZpcnRuZXRfZ2V0X2hlYWRyb29tKHN0cnVjdCB2aXJ0bmV0X2luZm8g
KnZpKQo+IEBAIC0xMjAxLDcgKzEyMDUsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfYnVpbGRfeGRw
X2J1ZmZfbXJnKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZGV2LT5uYW1lLCAqbnVtX2J1ZiwKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB2aXJ0aW8xNl90b19jcHUodmktPnZkZXYsIGhkci0+bnVtX2J1ZmZlcnMpKTsK
PiAgICAgICAgICAgICAgICAgICAgICAgICBkZXYtPnN0YXRzLnJ4X2xlbmd0aF9lcnJvcnMrKzsK
PiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiArICAgICAgICAgICAg
ICAgICAgICAgICBnb3RvIGVycjsKPiAgICAgICAgICAgICAgICAgfQo+Cj4gICAgICAgICAgICAg
ICAgIHN0YXRzLT5ieXRlcyArPSBsZW47Cj4gQEAgLTEyMjAsNyArMTIyNCw3IEBAIHN0YXRpYyBp
bnQgdmlydG5ldF9idWlsZF94ZHBfYnVmZl9tcmcoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAg
ICAgICAgICAgICAgICAgICAgICAgICBwcl9kZWJ1ZygiJXM6IHJ4IGVycm9yOiBsZW4gJXUgZXhj
ZWVkcyB0cnVlc2l6ZSAlbHVcbiIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZGV2LT5uYW1lLCBsZW4sICh1bnNpZ25lZCBsb25nKSh0cnVlc2l6ZSAtIHJvb20pKTsKPiAgICAg
ICAgICAgICAgICAgICAgICAgICBkZXYtPnN0YXRzLnJ4X2xlbmd0aF9lcnJvcnMrKzsKPiAtICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiArICAgICAgICAgICAgICAgICAg
ICAgICBnb3RvIGVycjsKPiAgICAgICAgICAgICAgICAgfQo+Cj4gICAgICAgICAgICAgICAgIGZy
YWcgPSAmc2hpbmZvLT5mcmFnc1tzaGluZm8tPm5yX2ZyYWdzKytdOwo+IEBAIC0xMjM1LDYgKzEy
MzksMTAgQEAgc3RhdGljIGludCB2aXJ0bmV0X2J1aWxkX3hkcF9idWZmX21yZyhzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2LAo+Cj4gICAgICAgICAqeGRwX2ZyYWdzX3RydWVzaXplID0geGRwX2ZyYWdz
X3RydWVzejsKPiAgICAgICAgIHJldHVybiAwOwo+ICsKPiArZXJyOgo+ICsgICAgICAgcHV0X3hk
cF9mcmFncyh4ZHApOwo+ICsgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gIH0KPgo+ICBzdGF0aWMg
dm9pZCAqbWVyZ2VhYmxlX3hkcF9wcmVwYXJlKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+IEBA
IC0xMzY0LDcgKzEzNzIsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2Vh
YmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgIGVyciA9IHZpcnRu
ZXRfYnVpbGRfeGRwX2J1ZmZfbXJnKGRldiwgdmksIHJxLCAmeGRwLCBkYXRhLCBsZW4sIGZyYW1l
X3N6LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
bnVtX2J1ZiwgJnhkcF9mcmFnc190cnVlc3osIHN0YXRzKTsKPiAgICAgICAgICAgICAgICAgaWYg
KHVubGlrZWx5KGVycikpCj4gLSAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfeGRwX2Zy
YWdzOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX3hkcDsKPgo+ICAgICAgICAg
ICAgICAgICBhY3QgPSB2aXJ0bmV0X3hkcF9oYW5kbGVyKHhkcF9wcm9nLCAmeGRwLCBkZXYsIHhk
cF94bWl0LCBzdGF0cyk7Cj4KPiBAQCAtMTM3Miw3ICsxMzgwLDcgQEAgc3RhdGljIHN0cnVjdCBz
a19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgICAg
ICAgICAgICAgICBjYXNlIFZJUlRORVRfWERQX1JFU19QQVNTOgo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGhlYWRfc2tiID0gYnVpbGRfc2tiX2Zyb21feGRwX2J1ZmYoZGV2LCB2aSwgJnhkcCwg
eGRwX2ZyYWdzX3RydWVzeik7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5
KCFoZWFkX3NrYikpCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl94
ZHBfZnJhZ3M7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl94ZHA7
Cj4KPiAgICAgICAgICAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiAgICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gaGVhZF9za2I7Cj4gQEAgLTEzODIsMTEgKzEzOTAsOCBA
QCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byB4ZHBfeG1pdDsKPgo+ICAg
ICAgICAgICAgICAgICBjYXNlIFZJUlRORVRfWERQX1JFU19EUk9QOgo+IC0gICAgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX3hkcDsK
PiAgICAgICAgICAgICAgICAgfQo+IC1lcnJfeGRwX2ZyYWdzOgo+IC0gICAgICAgICAgICAgICBw
dXRfeGRwX2ZyYWdzKCZ4ZHApOwo+IC0gICAgICAgICAgICAgICBnb3RvIGVycl94ZHA7Cj4gICAg
ICAgICB9Cj4gICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPgo+IC0tCj4gMi4zMi4wLjMuZzAx
MTk1Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
