Return-Path: <SRS0=l/A6=KW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDA0C47089
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 04:01:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B864610CC
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 04:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B864610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5D586078C;
	Thu, 27 May 2021 04:01:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 93DfG0vzM42s; Thu, 27 May 2021 04:01:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A252605D8;
	Thu, 27 May 2021 04:01:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19C7BC000D;
	Thu, 27 May 2021 04:01:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40219C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26A4840153
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:01:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FLzCwcC8_Aan
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:01:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3BA09400C7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622088084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YFTuqobSNbOR8Wq6p+a7ao2//KKDypGgE4erIL0zlEM=;
 b=b1s5HhanVptRawpD407ioiyNwHcd5++t0lF8jgqWEmxayipEJjoHhsy36R0HY+/puxVFzd
 c/RUmeVVbvVdCqvqwHpaP+r+KbAs/SoAtwP/ep0CfxsFyqWyKREoMzXzNckyKS7h7PiRVQ
 THosOtz/0IL3wOlMYc+6MpeJvz1XP7E=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-i56BVbq7OL62qKmF6pzTuQ-1; Thu, 27 May 2021 00:01:23 -0400
X-MC-Unique: i56BVbq7OL62qKmF6pzTuQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 d3-20020a1709026543b02900ef00d14127so1635862pln.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 21:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=YFTuqobSNbOR8Wq6p+a7ao2//KKDypGgE4erIL0zlEM=;
 b=Djh1zTNQFkPVs8hqqRILAOw9hO7y4uab0Devn9qRYO3rCO3u9VBfYjKDwoCz664mae
 FRf7/0zNrGQs0MoGnOPRZUjJJ1hsXiXC8urFFfIE0Qx5upzN5D/UyY0sKQWC4GN5tJPO
 anLhJFbA83IPO4XIOK+cnIwi9xInNK2rtuafXphZuWFrO0dk7gWD/7n4Ba98tPZipWoh
 6uatzquqrP/5HQodA2GqX6H/DIln/O98M+hVPl0mE1OfG2BoA1EnbtUs2Z7FTORnaHH+
 cE396cgX21+nyuYOzPf3cHmIc142tsNCzQQ69qs7KDuvqReDW55IHcfpsn3J7+Mp/F+y
 gXgw==
X-Gm-Message-State: AOAM531TB7VSiuph+eJY5S6AZNpXNUEomaVKnM6+AS6/roRiU54L2Lgl
 +zZopN6fFXAE7aqHbtnzCI/mg/D5Qt4buKAPALicaj8glbbe3ZDSlGIh0e9AL9bwcbN/HYCvrGF
 M+9qjKJtlaZExun79cF8Vw88nHcJ/9pXUBANbEizRNy1YzOrwp9+ukwxQBrU6RlBnoPkOc5OEVF
 X/3ZHQIzS6BxQRPEf5gg==
X-Received: by 2002:a05:6a00:1705:b029:2e7:60df:7413 with SMTP id
 h5-20020a056a001705b02902e760df7413mr1764237pfc.48.1622088081774; 
 Wed, 26 May 2021 21:01:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzT94njfKbzIhMIA4Q1yN5K+12taVUkR5i/koVkhVbs5xSnZwAsySH3w+t2YxLpWBdJTfGJuQ==
X-Received: by 2002:a05:6a00:1705:b029:2e7:60df:7413 with SMTP id
 h5-20020a056a001705b02902e760df7413mr1764191pfc.48.1622088081275; 
 Wed, 26 May 2021 21:01:21 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p14sm529443pgb.2.2021.05.26.21.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 21:01:20 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] virtio: fix up virtio_disable_cb
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20210526082423.47837-1-mst@redhat.com>
 <20210526082423.47837-4-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c5dbc2b4-7b14-ea5a-27cf-ed88810f9b37@redhat.com>
Date: Thu, 27 May 2021 12:01:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210526082423.47837-4-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNS8yNiDPws7nNDoyNCwgTWljaGFlbCBTLiBUc2lya2luINC0tcA6Cj4gdmlydGlv
X2Rpc2FibGVfY2IgaXMgY3VycmVudGx5IGEgbm9wIGZvciBzcGxpdCByaW5nIHdpdGggZXZlbnQg
aW5kZXguCj4gVGhpcyBpcyBiZWNhdXNlIGl0IHVzZWQgdG8gYmUgYWx3YXlzIGNhbGxlZCBmcm9t
IGEgY2FsbGJhY2sgd2hlbiB3ZSBrbm93Cj4gZGV2aWNlIHdvbid0IHRyaWdnZXIgbW9yZSBldmVu
dHMgdW50aWwgd2UgdXBkYXRlIHRoZSBpbmRleC4gIEhvd2V2ZXIsCj4gbm93IHRoYXQgd2UgcnVu
IHdpdGggaW50ZXJydXB0cyBlbmFibGVkIGEgbG90IHdlIGFsc28gcG9sbCB3aXRob3V0IGEKPiBj
YWxsYmFjayBzbyB0aGF0IGlzIGRpZmZlcmVudDogZGlzYWJsaW5nIGNhbGxiYWNrcyB3aWxsIGhl
bHAgcmVkdWNlIHRoZQo+IG51bWJlciBvZiBzcHVyaW91cyBpbnRlcnJ1cHRzLgo+IEZ1cnRoZXIs
IGlmIHVzaW5nIGV2ZW50IGluZGV4IHdpdGggYSBwYWNrZWQgcmluZywgYW5kIGlmIGJlaW5nIGNh
bGxlZAo+IGZyb20gYSBjYWxsYmFjaywgd2UgYWN0dWFsbHkgZG8gZGlzYWJsZSBpbnRlcnJ1cHRz
IHdoaWNoIGlzIHVubmVjZXNzYXJ5Lgo+Cj4gRml4IGJvdGggaXNzdWVzIGJ5IHRyYWNraW5nIHdo
ZW5ldmVyIHdlIGdldCBhIGNhbGxiYWNrLiBJZiB0aGF0IGlzCj4gdGhlIGNhc2UgZGlzYWJsaW5n
IGludGVycnVwdHMgd2l0aCBldmVudCBpbmRleCBjYW4gYmUgYSBub3AuCgoKVGhpcyBzZWVtcyB1
bm5lY2Vzc2FyeToKCjEpIHdlIGNoZWNrIGF2YWlsX2ZsYWdzX3NoYWRvdyBiZWZvcmUgdG91Y2hp
bmcgdG91Y2hpbmcgdGhlIGluZGV4CjIpIFRoZSBub3AgaXMgbm90IGdvb2QgYXQgbGVhc3QgZm9y
IHNwbGl0LCBpZiB3ZSBjaG9vc2UgYSBzdWl0YWJsZSBldmVudCAKaW5kZXgsIGl0IGNhbiBoZWxw
IHRvIHJlZHVjZSB0aGUgY2hhbmNlIG9mIDEvTiBpbnRlcnJ1cHQsIChzZWUgYmVsb3cpLgoKCj4g
SWYgbm90IHRoZSBjYXNlIGRpc2FibGUgaW50ZXJydXB0cy4gTm90ZTogd2l0aCBhIHNwbGl0IHJp
bmcKPiB0aGVyZSdzIG5vIGV4cGxpY2l0ICJubyBpbnRlcnJ1cHRzIiB2YWx1ZS4gRm9yIG5vdyB3
ZSB3cml0ZQo+IGEgZml4ZWQgdmFsdWUgc28gb3VyIGNoYW5jZSBvZiB0cmlnZ2VyaW5nIGFuIGlu
dGVydXB0Cj4gaXMgMS9yaW5nIHNpemUuCgoKMS82NTUzNSBhY3R1YWxseT8gSWYgeWVzLCBkbyB3
ZSBzdGlsbCBuZWVkIHRoaXMgdHJpY2s/CgoKPiAgIEl0J3MgcHJvYmFibHkgYmV0dGVyIHRvIHdy
aXRlIHNvbWV0aGluZwo+IHJlbGF0ZWQgdG8gdGhlIGxhc3QgdXNlZCBpbmRleCB0aGVyZSB0byBy
ZWR1Y2UgdGhlIGNoYW5jZQo+IGV2ZW4gZnVydGhlci4gRm9yIG5vdyBJJ20ga2VlcGluZyBpdCBz
aW1wbGUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQu
Y29tPgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDI2ICsrKysrKysr
KysrKysrKysrKysrKysrKystCj4gICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggNzFlMTZiNTNlOWMxLi44
OGYwYjE2YjExYjggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+
ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMTEzLDYgKzExMyw5IEBA
IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgewo+ICAgCS8qIExhc3QgdXNlZCBpbmRleCB3ZSd2ZSBz
ZWVuLiAqLwo+ICAgCXUxNiBsYXN0X3VzZWRfaWR4Owo+ICAgCj4gKwkvKiBIaW50IGZvciBldmVu
dCBpZHg6IGFscmVhZHkgdHJpZ2dlcmVkIG5vIG5lZWQgdG8gZGlzYWJsZS4gKi8KPiArCWJvb2wg
ZXZlbnRfdHJpZ2dlcmVkOwo+ICsKPiAgIAl1bmlvbiB7Cj4gICAJCS8qIEF2YWlsYWJsZSBmb3Ig
c3BsaXQgcmluZyAqLwo+ICAgCQlzdHJ1Y3Qgewo+IEBAIC03MzksNyArNzQyLDEwIEBAIHN0YXRp
YyB2b2lkIHZpcnRxdWV1ZV9kaXNhYmxlX2NiX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSkK
PiAgIAo+ICAgCWlmICghKHZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cgJiBWUklOR19BVkFJ
TF9GX05PX0lOVEVSUlVQVCkpIHsKPiAgIAkJdnEtPnNwbGl0LmF2YWlsX2ZsYWdzX3NoYWRvdyB8
PSBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVDsKPiAtCQlpZiAoIXZxLT5ldmVudCkKPiArCQlp
ZiAodnEtPmV2ZW50KQo+ICsJCQkvKiBUT0RPOiB0aGlzIGlzIGEgaGFjay4gRmlndXJlIG91dCBh
IGNsZWFuZXIgdmFsdWUgdG8gd3JpdGUuICovCj4gKwkJCXZyaW5nX3VzZWRfZXZlbnQoJnZxLT5z
cGxpdC52cmluZykgPSAweDA7CgoKdXNlZF9pZHggb3IgbGFzdF91c2VkX2lkeCBzZWVtcyBiZXR0
ZXIgaGVyZS4KCgo+ICsJCWVsc2UKPiAgIAkJCXZxLT5zcGxpdC52cmluZy5hdmFpbC0+ZmxhZ3Mg
PQo+ICAgCQkJCWNwdV90b192aXJ0aW8xNihfdnEtPnZkZXYsCj4gICAJCQkJCQl2cS0+c3BsaXQu
YXZhaWxfZmxhZ3Nfc2hhZG93KTsKPiBAQCAtMTYwNSw2ICsxNjExLDcgQEAgc3RhdGljIHN0cnVj
dCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+ICAgCXZxLT53ZWFr
X2JhcnJpZXJzID0gd2Vha19iYXJyaWVyczsKPiAgIAl2cS0+YnJva2VuID0gZmFsc2U7Cj4gICAJ
dnEtPmxhc3RfdXNlZF9pZHggPSAwOwo+ICsJdnEtPmV2ZW50X3RyaWdnZXJlZCA9IGZhbHNlOwo+
ICAgCXZxLT5udW1fYWRkZWQgPSAwOwo+ICAgCXZxLT5wYWNrZWRfcmluZyA9IHRydWU7Cj4gICAJ
dnEtPnVzZV9kbWFfYXBpID0gdnJpbmdfdXNlX2RtYV9hcGkodmRldik7Cj4gQEAgLTE5MTksNiAr
MTkyNiwxMiBAQCB2b2lkIHZpcnRxdWV1ZV9kaXNhYmxlX2NiKHN0cnVjdCB2aXJ0cXVldWUgKl92
cSkKPiAgIHsKPiAgIAlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+
ICAgCj4gKwkvKiBJZiBkZXZpY2UgdHJpZ2dlcmVkIGFuIGV2ZW50IGFscmVhZHkgaXQgd29uJ3Qg
dHJpZ2dlciBvbmUgYWdhaW46Cj4gKwkgKiBubyBuZWVkIHRvIGRpc2FibGUuCj4gKwkgKi8KPiAr
CWlmICh2cS0+ZXZlbnRfdHJpZ2dlcmVkKQo+ICsJCXJldHVybjsKPiArCj4gICAJaWYgKHZxLT5w
YWNrZWRfcmluZykKPiAgIAkJdmlydHF1ZXVlX2Rpc2FibGVfY2JfcGFja2VkKF92cSk7Cj4gICAJ
ZWxzZQo+IEBAIC0xOTQyLDYgKzE5NTUsOSBAQCB1bnNpZ25lZCB2aXJ0cXVldWVfZW5hYmxlX2Ni
X3ByZXBhcmUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ICAgewo+ICAgCXN0cnVjdCB2cmluZ192
aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gICAKPiArCWlmICh2cS0+ZXZlbnRfdHJpZ2dl
cmVkKQo+ICsJCXZxLT5ldmVudF90cmlnZ2VyZWQgPSBmYWxzZTsKPiArCj4gICAJcmV0dXJuIHZx
LT5wYWNrZWRfcmluZyA/IHZpcnRxdWV1ZV9lbmFibGVfY2JfcHJlcGFyZV9wYWNrZWQoX3ZxKSA6
Cj4gICAJCQkJIHZpcnRxdWV1ZV9lbmFibGVfY2JfcHJlcGFyZV9zcGxpdChfdnEpOwo+ICAgfQo+
IEBAIC0yMDA1LDYgKzIwMjEsOSBAQCBib29sIHZpcnRxdWV1ZV9lbmFibGVfY2JfZGVsYXllZChz
dHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gICB7Cj4gICAJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAq
dnEgPSB0b192dnEoX3ZxKTsKPiAgIAo+ICsJaWYgKHZxLT5ldmVudF90cmlnZ2VyZWQpCj4gKwkJ
dnEtPmV2ZW50X3RyaWdnZXJlZCA9IGZhbHNlOwo+ICsKPiAgIAlyZXR1cm4gdnEtPnBhY2tlZF9y
aW5nID8gdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkX3BhY2tlZChfdnEpIDoKPiAgIAkJCQkg
dmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkX3NwbGl0KF92cSk7Cj4gICB9CgoKTWlzcyB0aGUg
Y2FzZSBvZiB2aXJ0cXVldWVfZW5hYmxlX2NiKCk/CgpUaGFua3MKCgo+IEBAIC0yMDQ0LDYgKzIw
NjMsMTAgQEAgaXJxcmV0dXJuX3QgdnJpbmdfaW50ZXJydXB0KGludCBpcnEsIHZvaWQgKl92cSkK
PiAgIAlpZiAodW5saWtlbHkodnEtPmJyb2tlbikpCj4gICAJCXJldHVybiBJUlFfSEFORExFRDsK
PiAgIAo+ICsJLyogSnVzdCBhIGhpbnQgZm9yIHBlcmZvcm1hbmNlOiBzbyBpdCdzIG9rIHRoYXQg
dGhpcyBjYW4gYmUgcmFjeSEgKi8KPiArCWlmICh2cS0+ZXZlbnQpCj4gKwkJdnEtPmV2ZW50X3Ry
aWdnZXJlZCA9IHRydWU7Cj4gKwo+ICAgCXByX2RlYnVnKCJ2aXJ0cXVldWUgY2FsbGJhY2sgZm9y
ICVwICglcClcbiIsIHZxLCB2cS0+dnEuY2FsbGJhY2spOwo+ICAgCWlmICh2cS0+dnEuY2FsbGJh
Y2spCj4gICAJCXZxLT52cS5jYWxsYmFjaygmdnEtPnZxKTsKPiBAQCAtMjA4Myw2ICsyMTA2LDcg
QEAgc3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBp
bmRleCwKPiAgIAl2cS0+d2Vha19iYXJyaWVycyA9IHdlYWtfYmFycmllcnM7Cj4gICAJdnEtPmJy
b2tlbiA9IGZhbHNlOwo+ICAgCXZxLT5sYXN0X3VzZWRfaWR4ID0gMDsKPiArCXZxLT5ldmVudF90
cmlnZ2VyZWQgPSBmYWxzZTsKPiAgIAl2cS0+bnVtX2FkZGVkID0gMDsKPiAgIAl2cS0+dXNlX2Rt
YV9hcGkgPSB2cmluZ191c2VfZG1hX2FwaSh2ZGV2KTsKPiAgICNpZmRlZiBERUJVRwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
