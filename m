Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DECC77B73
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 06:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AA6D84075;
	Thu, 20 Apr 2023 06:01:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AA6D84075
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qmhm/gx0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DZ9S0ZtQTaP8; Thu, 20 Apr 2023 06:01:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B27308406A;
	Thu, 20 Apr 2023 06:01:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B27308406A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74EEFC0037;
	Thu, 20 Apr 2023 06:01:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CC21C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1515742122
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:01:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1515742122
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qmhm/gx0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eMipTbdevmDS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:01:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCF7E420F6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DCF7E420F6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681970505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lrr9mch7KfxogTYrVf9KA/GmagliQT/y0/Zyp+kIu6o=;
 b=Qmhm/gx06vIFGGKLDVC84RntsdKD/o28bB34ddwtwqJRiMhzhWvqnsmR7SWZRO+c1liNqZ
 bO6sdt7LWCNgKK/Lg8tI39jKPqqRkdo67iBRj5mqxQbHeaHsw7QCrfFM4RAhnQ899SWBdh
 Phrc21/8LPKpmgp0ZLjXINRuLMS/AuE=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-Juk2rSG0OkmruyQqwDVXbA-1; Thu, 20 Apr 2023 02:01:44 -0400
X-MC-Unique: Juk2rSG0OkmruyQqwDVXbA-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-547240735f4so147478eaf.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 23:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681970503; x=1684562503;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lrr9mch7KfxogTYrVf9KA/GmagliQT/y0/Zyp+kIu6o=;
 b=MxFXpD2KXKCeIZg23F28ufkc0gZGjMKlX4hePdEC91/lplhmaCVaeCCdSoCx3VVEWX
 4JddtiEXLgNxWuuLZYnuu/HxDBnSae0OVq1oOS9NI6vD011Mj67IyTWrJDFCGHj5zpcO
 sXPIYxI51BI3il/PA3Z3YnWwfv5JoxD21gfCXTOpLD/0YPVct7avQqbg72EGKweHdNcf
 3NOmsQwyxzLxTHXnf5/sojdNV+/pLJlz3/9ZBAt+q4XF2BTRViADVrWp8Sk61lHvtZSP
 bBE21LzaVofkv5Y2mplqCAdnfhOnCSFWcGtb/E7byWPm4o61XX3cXXaGkNeftE66IxC+
 8cjw==
X-Gm-Message-State: AAQBX9e2JFe4SZyjsvQFgHGe3hs/gsSpJAmbeANy53RQj4LLuW1nO4Ue
 sLzRRfAIQsneZGa7bLuF63RDTWNEQuELlE4VsBHhaQANJM5bt2AYlVoi5DuMXKbu5KBVrt5eo4U
 IkvQ38UCi5p81rjFJPLyC6shKL3PhPbEHFK9Wi542g4OKE5pLziel+YiKow==
X-Received: by 2002:a05:6870:7026:b0:188:53:a7bd with SMTP id
 u38-20020a056870702600b001880053a7bdmr338730oae.49.1681970503653; 
 Wed, 19 Apr 2023 23:01:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350b6PZiipmQV9mNOyk6NSBCGwsiqG0tLD6/ZyhFxrrAWSm5AcpzGZJoe5CwDu+zEr1lo6tCWD9x6Vk14+gXDt3c=
X-Received: by 2002:a05:6870:7026:b0:188:53:a7bd with SMTP id
 u38-20020a056870702600b001880053a7bdmr338714oae.49.1681970503429; Wed, 19 Apr
 2023 23:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
 <20230418065327.72281-10-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230418065327.72281-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Apr 2023 14:01:32 +0800
Message-ID: <CACGkMEt0Z4LzfZp6PGV-6-a-+jLed=1fbhxmdaqxrU7C4qEYEA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 09/14] virtio_net: introduce
 receive_mergeable_xdp()
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
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gVGhlIHB1cnBvc2Ugb2YgdGhpcyBwYXRjaCBpcyB0
byBzaW1wbGlmeSB0aGUgcmVjZWl2ZV9tZXJnZWFibGUoKS4KPiBTZXBhcmF0ZSBhbGwgdGhlIGxv
Z2ljIG9mIFhEUCBpbnRvIGEgZnVuY3Rpb24uCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8g
PHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
YyB8IDEwMCArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKyksIDM5IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+
IGluZGV4IDI2NmMxNjcwYmVkYS4uNDJlOTkyN2UzMTZiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0x
MzE5LDYgKzEzMTksNjMgQEAgc3RhdGljIHZvaWQgKm1lcmdlYWJsZV94ZHBfcHJlcGFyZShzdHJ1
Y3QgdmlydG5ldF9pbmZvICp2aSwKPiAgICAgICAgIHJldHVybiBwYWdlX2FkZHJlc3MoKnBhZ2Up
ICsgVklSVElPX1hEUF9IRUFEUk9PTTsKPiAgfQo+Cj4gK3N0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAq
cmVjZWl2ZV9tZXJnZWFibGVfeGRwKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRuZXRfaW5mbyAq
dmksCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHJlY2VpdmVfcXVldWUgKnJxLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBicGZfcHJvZyAqeGRwX3Byb2csCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqYnVmLAo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmN0eCwKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgbGVuLAo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCAqeGRwX3ht
aXQsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHZpcnRuZXRfcnFfc3RhdHMgKnN0YXRzKQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3QgdmlydGlvX25l
dF9oZHJfbXJnX3J4YnVmICpoZHIgPSBidWY7Cj4gKyAgICAgICBpbnQgbnVtX2J1ZiA9IHZpcnRp
bzE2X3RvX2NwdSh2aS0+dmRldiwgaGRyLT5udW1fYnVmZmVycyk7Cj4gKyAgICAgICBzdHJ1Y3Qg
cGFnZSAqcGFnZSA9IHZpcnRfdG9faGVhZF9wYWdlKGJ1Zik7Cj4gKyAgICAgICBpbnQgb2Zmc2V0
ID0gYnVmIC0gcGFnZV9hZGRyZXNzKHBhZ2UpOwo+ICsgICAgICAgdW5zaWduZWQgaW50IHhkcF9m
cmFnc190cnVlc3ogPSAwOwo+ICsgICAgICAgc3RydWN0IHNrX2J1ZmYgKmhlYWRfc2tiOwo+ICsg
ICAgICAgdW5zaWduZWQgaW50IGZyYW1lX3N6Owo+ICsgICAgICAgc3RydWN0IHhkcF9idWZmIHhk
cDsKPiArICAgICAgIHZvaWQgKmRhdGE7Cj4gKyAgICAgICB1MzIgYWN0Owo+ICsgICAgICAgaW50
IGVycjsKPiArCj4gKyAgICAgICBkYXRhID0gbWVyZ2VhYmxlX3hkcF9wcmVwYXJlKHZpLCBycSwg
eGRwX3Byb2csIGN0eCwgJmZyYW1lX3N6LCAmbnVtX2J1ZiwgJnBhZ2UsCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG9mZnNldCwgJmxlbiwgaGRyKTsKPiArICAgICAgIGlm
ICh1bmxpa2VseSghZGF0YSkpCj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX3hkcDsKPiArCj4g
KyAgICAgICBlcnIgPSB2aXJ0bmV0X2J1aWxkX3hkcF9idWZmX21yZyhkZXYsIHZpLCBycSwgJnhk
cCwgZGF0YSwgbGVuLCBmcmFtZV9zeiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICZudW1fYnVmLCAmeGRwX2ZyYWdzX3RydWVzeiwgc3RhdHMpOwo+ICsgICAgICAg
aWYgKHVubGlrZWx5KGVycikpCj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX3hkcDsKPiArCj4g
KyAgICAgICBhY3QgPSB2aXJ0bmV0X3hkcF9oYW5kbGVyKHhkcF9wcm9nLCAmeGRwLCBkZXYsIHhk
cF94bWl0LCBzdGF0cyk7Cj4gKwo+ICsgICAgICAgc3dpdGNoIChhY3QpIHsKPiArICAgICAgIGNh
c2UgVklSVE5FVF9YRFBfUkVTX1BBU1M6Cj4gKyAgICAgICAgICAgICAgIGhlYWRfc2tiID0gYnVp
bGRfc2tiX2Zyb21feGRwX2J1ZmYoZGV2LCB2aSwgJnhkcCwgeGRwX2ZyYWdzX3RydWVzeik7Cj4g
KyAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSghaGVhZF9za2IpKQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gZXJyX3hkcDsKPiArICAgICAgICAgICAgICAgcmV0dXJuIGhlYWRfc2ti
Owo+ICsKPiArICAgICAgIGNhc2UgVklSVE5FVF9YRFBfUkVTX0NPTlNVTUVEOgo+ICsgICAgICAg
ICAgICAgICByZXR1cm4gTlVMTDsKPiArCj4gKyAgICAgICBjYXNlIFZJUlRORVRfWERQX1JFU19E
Uk9QOgo+ICsgICAgICAgICAgICAgICBicmVhazsKPiArICAgICAgIH0KPiArCj4gK2Vycl94ZHA6
Cj4gKyAgICAgICBwdXRfcGFnZShwYWdlKTsKPiArICAgICAgIG1lcmdlYWJsZV9idWZfZnJlZShy
cSwgbnVtX2J1ZiwgZGV2LCBzdGF0cyk7Cj4gKwo+ICsgICAgICAgc3RhdHMtPnhkcF9kcm9wcysr
Owo+ICsgICAgICAgc3RhdHMtPmRyb3BzKys7Cj4gKyAgICAgICByZXR1cm4gTlVMTDsKPiArfQo+
ICsKPiAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsCj4gQEAgLTEzMzgsOCArMTM5NSw2
IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3RydWN0IG5ldF9k
ZXZpY2UgKmRldiwKPiAgICAgICAgIHVuc2lnbmVkIGludCBoZWFkcm9vbSA9IG1lcmdlYWJsZV9j
dHhfdG9faGVhZHJvb20oY3R4KTsKPiAgICAgICAgIHVuc2lnbmVkIGludCB0YWlscm9vbSA9IGhl
YWRyb29tID8gc2l6ZW9mKHN0cnVjdCBza2Jfc2hhcmVkX2luZm8pIDogMDsKPiAgICAgICAgIHVu
c2lnbmVkIGludCByb29tID0gU0tCX0RBVEFfQUxJR04oaGVhZHJvb20gKyB0YWlscm9vbSk7Cj4g
LSAgICAgICB1bnNpZ25lZCBpbnQgZnJhbWVfc3o7Cj4gLSAgICAgICBpbnQgZXJyOwo+Cj4gICAg
ICAgICBoZWFkX3NrYiA9IE5VTEw7Cj4gICAgICAgICBzdGF0cy0+Ynl0ZXMgKz0gbGVuIC0gdmkt
Pmhkcl9sZW47Cj4gQEAgLTEzNTksMzkgKzE0MTQsMTAgQEAgc3RhdGljIHN0cnVjdCBza19idWZm
ICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgICAgICAgcmN1
X3JlYWRfbG9jaygpOwo+ICAgICAgICAgeGRwX3Byb2cgPSByY3VfZGVyZWZlcmVuY2UocnEtPnhk
cF9wcm9nKTsKPiAgICAgICAgIGlmICh4ZHBfcHJvZykgewo+IC0gICAgICAgICAgICAgICB1bnNp
Z25lZCBpbnQgeGRwX2ZyYWdzX3RydWVzeiA9IDA7Cj4gLSAgICAgICAgICAgICAgIHN0cnVjdCB4
ZHBfYnVmZiB4ZHA7Cj4gLSAgICAgICAgICAgICAgIHZvaWQgKmRhdGE7Cj4gLSAgICAgICAgICAg
ICAgIHUzMiBhY3Q7Cj4gLQo+IC0gICAgICAgICAgICAgICBkYXRhID0gbWVyZ2VhYmxlX3hkcF9w
cmVwYXJlKHZpLCBycSwgeGRwX3Byb2csIGN0eCwgJmZyYW1lX3N6LAo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZudW1fYnVmLCAmcGFnZSwgb2Zmc2V0LCAm
bGVuLCBoZHIpOwo+IC0gICAgICAgICAgICAgICBpZiAodW5saWtlbHkoIWRhdGEpKQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX3hkcDsKPiAtCj4gLSAgICAgICAgICAgICAgIGVy
ciA9IHZpcnRuZXRfYnVpbGRfeGRwX2J1ZmZfbXJnKGRldiwgdmksIHJxLCAmeGRwLCBkYXRhLCBs
ZW4sIGZyYW1lX3N6LAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmbnVtX2J1ZiwgJnhkcF9mcmFnc190cnVlc3osIHN0YXRzKTsKPiAtICAgICAgICAg
ICAgICAgaWYgKHVubGlrZWx5KGVycikpCj4gLSAgICAgICAgICAgICAgICAgICAgICAgZ290byBl
cnJfeGRwOwo+IC0KPiAtICAgICAgICAgICAgICAgYWN0ID0gdmlydG5ldF94ZHBfaGFuZGxlcih4
ZHBfcHJvZywgJnhkcCwgZGV2LCB4ZHBfeG1pdCwgc3RhdHMpOwo+IC0KPiAtICAgICAgICAgICAg
ICAgc3dpdGNoIChhY3QpIHsKPiAtICAgICAgICAgICAgICAgY2FzZSBWSVJUTkVUX1hEUF9SRVNf
UEFTUzoKPiAtICAgICAgICAgICAgICAgICAgICAgICBoZWFkX3NrYiA9IGJ1aWxkX3NrYl9mcm9t
X3hkcF9idWZmKGRldiwgdmksICZ4ZHAsIHhkcF9mcmFnc190cnVlc3opOwo+IC0gICAgICAgICAg
ICAgICAgICAgICAgIGlmICh1bmxpa2VseSghaGVhZF9za2IpKQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZ290byBlcnJfeGRwOwo+IC0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICByY3VfcmVhZF91bmxvY2soKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gaGVh
ZF9za2I7Cj4gLQo+IC0gICAgICAgICAgICAgICBjYXNlIFZJUlRORVRfWERQX1JFU19DT05TVU1F
RDoKPiAtICAgICAgICAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiAtICAgICAg
ICAgICAgICAgICAgICAgICBnb3RvIHhkcF94bWl0Owo+IC0KPiAtICAgICAgICAgICAgICAgY2Fz
ZSBWSVJUTkVUX1hEUF9SRVNfRFJPUDoKPiAtICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVy
cl94ZHA7Cj4gLSAgICAgICAgICAgICAgIH0KPiArICAgICAgICAgICAgICAgaGVhZF9za2IgPSBy
ZWNlaXZlX21lcmdlYWJsZV94ZHAoZGV2LCB2aSwgcnEsIHhkcF9wcm9nLCBidWYsIGN0eCwKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGVuLCB4ZHBf
eG1pdCwgc3RhdHMpOwo+ICsgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiArICAg
ICAgICAgICAgICAgcmV0dXJuIGhlYWRfc2tiOwo+ICAgICAgICAgfQo+ICAgICAgICAgcmN1X3Jl
YWRfdW5sb2NrKCk7Cj4KPiBAQCAtMTQ2MSw5ICsxNDg3LDYgQEAgc3RhdGljIHN0cnVjdCBza19i
dWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgICAgICAg
ZXdtYV9wa3RfbGVuX2FkZCgmcnEtPm1yZ19hdmdfcGt0X2xlbiwgaGVhZF9za2ItPmxlbik7Cj4g
ICAgICAgICByZXR1cm4gaGVhZF9za2I7Cj4KPiAtZXJyX3hkcDoKPiAtICAgICAgIHJjdV9yZWFk
X3VubG9jaygpOwo+IC0gICAgICAgc3RhdHMtPnhkcF9kcm9wcysrOwo+ICBlcnJfc2tiOgo+ICAg
ICAgICAgcHV0X3BhZ2UocGFnZSk7Cj4gICAgICAgICBtZXJnZWFibGVfYnVmX2ZyZWUocnEsIG51
bV9idWYsIGRldiwgc3RhdHMpOwo+IEBAIC0xNDcxLDcgKzE0OTQsNiBAQCBzdGF0aWMgc3RydWN0
IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gIGVy
cl9idWY6Cj4gICAgICAgICBzdGF0cy0+ZHJvcHMrKzsKPiAgICAgICAgIGRldl9rZnJlZV9za2Io
aGVhZF9za2IpOwo+IC14ZHBfeG1pdDoKPiAgICAgICAgIHJldHVybiBOVUxMOwo+ICB9Cj4KPiAt
LQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
