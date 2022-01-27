Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69E5C433F5
	for <virtualization@archiver.kernel.org>; Thu, 27 Jan 2022 08:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8530884D50;
	Thu, 27 Jan 2022 08:12:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ItLHXus85Jqc; Thu, 27 Jan 2022 08:12:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1D51584D6E;
	Thu, 27 Jan 2022 08:12:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6EAAC001A;
	Thu, 27 Jan 2022 08:12:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53D30C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 08:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 32C3C4163F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 08:12:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kbaFfm6mDlCF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 08:11:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A8BD40986
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 08:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643271115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZuylhvZW6x86a+V3ZnUj04ytdDhKjPy9bvsW6hie+MI=;
 b=CmTvI6wYGOhbmZkrNocNaksdwJeZV/9zWNpwu8JFZeis4rxwGFC4pSyxY095Y54/elharb
 6LGIrIU6r2ShZAvl1csXnNHKgcz0Z9UkAW7V9ZYSA3SP9miC5XSIsN7wkfUF9s+05iuBgt
 yMe3WeHya/NTHgaUe0ab0kgZlsIDDp0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-ELxn_uekMP6KAxlQlMN0qg-1; Thu, 27 Jan 2022 03:11:52 -0500
X-MC-Unique: ELxn_uekMP6KAxlQlMN0qg-1
Received: by mail-pl1-f200.google.com with SMTP id
 o9-20020a170903210900b0014b36bee5b9so1211272ple.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 00:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ZuylhvZW6x86a+V3ZnUj04ytdDhKjPy9bvsW6hie+MI=;
 b=dAUQKRRkvFyzqC6AL3r5ONa5hSM8wrHSUypswMW67awlcn5pknULOaPMIZ5eLCW1Z6
 ct6OkHrR+igyIlLmPbTV8SzltbFnwByNr6ZwQ3+oNXxh+XAZdylvCiGoxdgJH6pQHEfG
 2PqNtzkGpvMtijzXBQOLjyg6Es5GWVgoIFi+szNg0gHw9xkZpeo3hLJsrEAx+J0YN2r8
 w0U5Qg+/rvjTY9Sb99AdblVTH/2sfd1k0y86dZvIHmp/KWj2cjUN+pPwBP2Uh8tLDuv5
 BWPttwwJ1j9kT3vaRvzkzhlB50Od4jN58qVYHsZLlDe6WRx0alDwS5kcSa9K6xijFHqS
 hlMQ==
X-Gm-Message-State: AOAM531M0VFMnkiirrA0w9TeHpyhVanTSgDSerTbThgoa87aLIAHWXHb
 mGtUiMgO8VlXeApGHFpfSFVoOAvn8HYLoYw6E/1raHbGntAukZ5AkaeCFNL9h0qtxrKVI739J17
 velGF51SoA8j0voXgCPXDIoPfeMSAwjDthsZEzAtB2g==
X-Received: by 2002:a17:902:c406:: with SMTP id
 k6mr2860120plk.96.1643271110824; 
 Thu, 27 Jan 2022 00:11:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypuog472VkiNADz94IYec37oeQ0JMAbX9TfSK1gaeX1KWEh/IsZjnP5oH8QAPttv41Px2E6g==
X-Received: by 2002:a17:902:c406:: with SMTP id
 k6mr2860100plk.96.1643271110503; 
 Thu, 27 Jan 2022 00:11:50 -0800 (PST)
Received: from [10.72.13.129] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m11sm18368079pgb.15.2022.01.27.00.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 00:11:49 -0800 (PST)
Message-ID: <6ef76a28-4836-cb55-cb4c-b9d0c5fac95e@redhat.com>
Date: Thu, 27 Jan 2022 16:11:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] drivers/net/virtio_net: Added RSS hash report.
To: Andrew Melnychenko <andrew@daynix.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, mst@redhat.com
References: <20220117080009.3055012-1-andrew@daynix.com>
 <20220117080009.3055012-4-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220117080009.3055012-4-andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzEvMTcg5LiL5Y2INDowMCwgQW5kcmV3IE1lbG55Y2hlbmtvIOWGmemBkzoKPiBB
ZGRlZCBmZWF0dXJlcyBmb3IgUlNTIGhhc2ggcmVwb3J0Lgo+IElmIGhhc2ggaXMgcHJvdmlkZWQg
LSBpdCBzZXRzIHRvIHNrYi4KPiBBZGRlZCBjaGVja3MgaWYgcnNzIGFuZC9vciBoYXNoIGFyZSBl
bmFibGVkIHRvZ2V0aGVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmV3IE1lbG55Y2hlbmtvIDxh
bmRyZXdAZGF5bml4LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDU4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCA0NyBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRl
eCA5YWFlMTFjYjU2OGUuLjJjNjFmOTZjZTNlNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMjI3LDYg
KzIyNyw3IEBAIHN0cnVjdCB2aXJ0bmV0X2luZm8gewo+ICAgCj4gICAJLyogSG9zdCBzdXBwb3J0
cyByc3MgYW5kL29yIGhhc2ggcmVwb3J0ICovCj4gICAJYm9vbCBoYXNfcnNzOwo+ICsJYm9vbCBo
YXNfcnNzX2hhc2hfcmVwb3J0Owo+ICAgCXU4IHJzc19rZXlfc2l6ZTsKPiAgIAl1MTYgcnNzX2lu
ZGlyX3RhYmxlX3NpemU7Cj4gICAJdTMyIHJzc19oYXNoX3R5cGVzX3N1cHBvcnRlZDsKPiBAQCAt
NDIwLDcgKzQyMSw5IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcGFnZV90b19za2Ioc3RydWN0
IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJaGRyX3AgPSBwOwo+ICAgCj4gICAJaGRyX2xlbiA9IHZp
LT5oZHJfbGVuOwo+IC0JaWYgKHZpLT5tZXJnZWFibGVfcnhfYnVmcykKPiArCWlmICh2aS0+aGFz
X3Jzc19oYXNoX3JlcG9ydCkKPiArCQloZHJfcGFkZGVkX2xlbiA9IHNpemVvZihzdHJ1Y3Qgdmly
dGlvX25ldF9oZHJfdjFfaGFzaCk7CgoKVGhpcyBzZWVtcyB3cm9uZywgYWRkX3JlY3ZidWZfYmln
KCkgd2lsbCBhbHdheXMgdHJ5IHRvIHVzZSBzaXplb2Yoc3RydWN0IApwYWRkZWRfdm5ldF9oZHIp
LgoKVGhpcyBjYW4gYmUgdGVzdGVkIGJ5IGRpc2FibGluZyBtcmdfcnhidWYuCgoKPiArCWVsc2Ug
aWYgKHZpLT5tZXJnZWFibGVfcnhfYnVmcykKPiAgIAkJaGRyX3BhZGRlZF9sZW4gPSBzaXplb2Yo
Kmhkcik7Cj4gICAJZWxzZQo+ICAgCQloZHJfcGFkZGVkX2xlbiA9IHNpemVvZihzdHJ1Y3QgcGFk
ZGVkX3ZuZXRfaGRyKTsKPiBAQCAtMTE1Niw2ICsxMTU5LDggQEAgc3RhdGljIHZvaWQgcmVjZWl2
ZV9idWYoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwK
PiAgIAlzdHJ1Y3QgbmV0X2RldmljZSAqZGV2ID0gdmktPmRldjsKPiAgIAlzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiOwo+ICAgCXN0cnVjdCB2aXJ0aW9fbmV0X2hkcl9tcmdfcnhidWYgKmhkcjsKPiArCXN0
cnVjdCB2aXJ0aW9fbmV0X2hkcl92MV9oYXNoICpoZHJfaGFzaDsKPiArCWVudW0gcGt0X2hhc2hf
dHlwZXMgcnNzX2hhc2hfdHlwZTsKPiAgIAo+ICAgCWlmICh1bmxpa2VseShsZW4gPCB2aS0+aGRy
X2xlbiArIEVUSF9ITEVOKSkgewo+ICAgCQlwcl9kZWJ1ZygiJXM6IHNob3J0IHBhY2tldCAlaVxu
IiwgZGV2LT5uYW1lLCBsZW4pOwo+IEBAIC0xMTgyLDYgKzExODcsMjkgQEAgc3RhdGljIHZvaWQg
cmVjZWl2ZV9idWYoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHN0cnVjdCByZWNlaXZlX3F1ZXVl
ICpycSwKPiAgIAkJcmV0dXJuOwo+ICAgCj4gICAJaGRyID0gc2tiX3ZuZXRfaGRyKHNrYik7Cj4g
KwlpZiAoZGV2LT5mZWF0dXJlcyAmIE5FVElGX0ZfUlhIQVNIICYmIHZpLT5oYXNfcnNzX2hhc2hf
cmVwb3J0KSB7Cj4gKwkJaGRyX2hhc2ggPSAoc3RydWN0IHZpcnRpb19uZXRfaGRyX3YxX2hhc2gg
KikoaGRyKTsKPiArCj4gKwkJc3dpdGNoIChoZHJfaGFzaC0+aGFzaF9yZXBvcnQpIHsKPiArCQlj
YXNlIFZJUlRJT19ORVRfSEFTSF9SRVBPUlRfVENQdjQ6Cj4gKwkJY2FzZSBWSVJUSU9fTkVUX0hB
U0hfUkVQT1JUX1VEUHY0Ogo+ICsJCWNhc2UgVklSVElPX05FVF9IQVNIX1JFUE9SVF9UQ1B2NjoK
PiArCQljYXNlIFZJUlRJT19ORVRfSEFTSF9SRVBPUlRfVURQdjY6Cj4gKwkJY2FzZSBWSVJUSU9f
TkVUX0hBU0hfUkVQT1JUX1RDUHY2X0VYOgo+ICsJCWNhc2UgVklSVElPX05FVF9IQVNIX1JFUE9S
VF9VRFB2Nl9FWDoKPiArCQkJcnNzX2hhc2hfdHlwZSA9IFBLVF9IQVNIX1RZUEVfTDQ7Cj4gKwkJ
CWJyZWFrOwo+ICsJCWNhc2UgVklSVElPX05FVF9IQVNIX1JFUE9SVF9JUHY0Ogo+ICsJCWNhc2Ug
VklSVElPX05FVF9IQVNIX1JFUE9SVF9JUHY2Ogo+ICsJCWNhc2UgVklSVElPX05FVF9IQVNIX1JF
UE9SVF9JUHY2X0VYOgo+ICsJCQlyc3NfaGFzaF90eXBlID0gUEtUX0hBU0hfVFlQRV9MMzsKPiAr
CQkJYnJlYWs7Cj4gKwkJY2FzZSBWSVJUSU9fTkVUX0hBU0hfUkVQT1JUX05PTkU6Cj4gKwkJZGVm
YXVsdDoKPiArCQkJcnNzX2hhc2hfdHlwZSA9IFBLVF9IQVNIX1RZUEVfTk9ORTsKPiArCQl9Cj4g
KwkJc2tiX3NldF9oYXNoKHNrYiwgaGRyX2hhc2gtPmhhc2hfdmFsdWUsIHJzc19oYXNoX3R5cGUp
Owo+ICsJfQo+ICAgCj4gICAJaWYgKGhkci0+aGRyLmZsYWdzICYgVklSVElPX05FVF9IRFJfRl9E
QVRBX1ZBTElEKQo+ICAgCQlza2ItPmlwX3N1bW1lZCA9IENIRUNLU1VNX1VOTkVDRVNTQVJZOwo+
IEBAIC0yMjMyLDcgKzIyNjAsOCBAQCBzdGF0aWMgYm9vbCB2aXJ0bmV0X2NvbW1pdF9yc3NfY29t
bWFuZChzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiAgIAlzZ19zZXRfYnVmKCZzZ3NbM10sIHZp
LT5jdHJsLT5yc3Mua2V5LCBzZ19idWZfc2l6ZSk7Cj4gICAKPiAgIAlpZiAoIXZpcnRuZXRfc2Vu
ZF9jb21tYW5kKHZpLCBWSVJUSU9fTkVUX0NUUkxfTVEsCj4gLQkJCQkgIFZJUlRJT19ORVRfQ1RS
TF9NUV9SU1NfQ09ORklHLCBzZ3MpKSB7Cj4gKwkJCQkgIHZpLT5oYXNfcnNzID8gVklSVElPX05F
VF9DVFJMX01RX1JTU19DT05GSUcKPiArCQkJCSAgOiBWSVJUSU9fTkVUX0NUUkxfTVFfSEFTSF9D
T05GSUcsIHNncykpIHsKPiAgIAkJZGV2X3dhcm4oJmRldi0+ZGV2LCAiVklSVElPTkVUIGlzc3Vl
IHdpdGggY29tbWl0dGluZyBSU1Mgc2dzXG4iKTsKPiAgIAkJcmV0dXJuIGZhbHNlOwo+ICAgCX0K
PiBAQCAtMzIzMCw2ICszMjU5LDggQEAgc3RhdGljIGJvb2wgdmlydG5ldF92YWxpZGF0ZV9mZWF0
dXJlcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIAkgICAgIFZJUlRORVRfRkFJTF9P
Tih2ZGV2LCBWSVJUSU9fTkVUX0ZfQ1RSTF9NQUNfQUREUiwKPiAgIAkJCSAgICAgIlZJUlRJT19O
RVRfRl9DVFJMX1ZRIikgfHwKPiAgIAkgICAgIFZJUlRORVRfRkFJTF9PTih2ZGV2LCBWSVJUSU9f
TkVUX0ZfUlNTLAo+ICsJCQkgICAgICJWSVJUSU9fTkVUX0ZfQ1RSTF9WUSIpIHx8Cj4gKwkgICAg
IFZJUlRORVRfRkFJTF9PTih2ZGV2LCBWSVJUSU9fTkVUX0ZfSEFTSF9SRVBPUlQsCj4gICAJCQkg
ICAgICJWSVJUSU9fTkVUX0ZfQ1RSTF9WUSIpKSkgewo+ICAgCQlyZXR1cm4gZmFsc2U7Cj4gICAJ
fQo+IEBAIC0zMzY1LDE2ICszMzk2LDE4IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wcm9iZShzdHJ1
Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIAlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYs
IFZJUlRJT19ORVRfRl9NUkdfUlhCVUYpKQo+ICAgCQl2aS0+bWVyZ2VhYmxlX3J4X2J1ZnMgPSB0
cnVlOwo+ICAgCj4gLQlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9S
U1MpKSB7Cj4gKwlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9IQVNI
X1JFUE9SVCkpCj4gKwkJdmktPmhhc19yc3NfaGFzaF9yZXBvcnQgPSB0cnVlOwo+ICsKPiArCWlm
ICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX1JTUykpCj4gICAJCXZpLT5o
YXNfcnNzID0gdHJ1ZTsKPiArCj4gKwlpZiAodmktPmhhc19yc3MgfHwgdmktPmhhc19yc3NfaGFz
aF9yZXBvcnQpIHsKPiAgIAkJdmktPnJzc19pbmRpcl90YWJsZV9zaXplID0KPiAgIAkJCXZpcnRp
b19jcmVhZDE2KHZkZXYsIG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywKPiAtCQkJ
CQkJICAgICAgcnNzX21heF9pbmRpcmVjdGlvbl90YWJsZV9sZW5ndGgpKTsKPiArCQkJCQlyc3Nf
bWF4X2luZGlyZWN0aW9uX3RhYmxlX2xlbmd0aCkpOwoKClVubmVjZXNzYXJ5IGNoYW5nZXMuCgoK
PiAgIAkJdmktPnJzc19rZXlfc2l6ZSA9Cj4gICAJCQl2aXJ0aW9fY3JlYWQ4KHZkZXYsIG9mZnNl
dG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywgcnNzX21heF9rZXlfc2l6ZSkpOwo+IC0JfQo+
IC0KPiAtCWlmICh2aS0+aGFzX3JzcykgewoKClRoaXMgY2FuIGJlIHNxdWFzaGVkIGludG8gcHJl
dmlvdXMgcGF0Y2guCgpUaGFua3MKCgo+ICAgCQl2aS0+cnNzX2hhc2hfdHlwZXNfc3VwcG9ydGVk
ID0KPiAgIAkJICAgIHZpcnRpb19jcmVhZDMyKHZkZXYsIG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9f
bmV0X2NvbmZpZywgc3VwcG9ydGVkX2hhc2hfdHlwZXMpKTsKPiAgIAkJdmktPnJzc19oYXNoX3R5
cGVzX3N1cHBvcnRlZCAmPQo+IEBAIC0zMzg0LDggKzM0MTcsMTEgQEAgc3RhdGljIGludCB2aXJ0
bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICAgCj4gICAJCWRldi0+aHdf
ZmVhdHVyZXMgfD0gTkVUSUZfRl9SWEhBU0g7Cj4gICAJfQo+IC0JaWYgKHZpcnRpb19oYXNfZmVh
dHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGKSB8fAo+IC0JICAgIHZpcnRpb19oYXNf
ZmVhdHVyZSh2ZGV2LCBWSVJUSU9fRl9WRVJTSU9OXzEpKQo+ICsKPiArCWlmICh2aS0+aGFzX3Jz
c19oYXNoX3JlcG9ydCkKPiArCQl2aS0+aGRyX2xlbiA9IHNpemVvZihzdHJ1Y3QgdmlydGlvX25l
dF9oZHJfdjFfaGFzaCk7Cj4gKwllbHNlIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklS
VElPX05FVF9GX01SR19SWEJVRikgfHwKPiArCQkgdmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJ
UlRJT19GX1ZFUlNJT05fMSkpCj4gICAJCXZpLT5oZHJfbGVuID0gc2l6ZW9mKHN0cnVjdCB2aXJ0
aW9fbmV0X2hkcl9tcmdfcnhidWYpOwo+ICAgCWVsc2UKPiAgIAkJdmktPmhkcl9sZW4gPSBzaXpl
b2Yoc3RydWN0IHZpcnRpb19uZXRfaGRyKTsKPiBAQCAtMzQ1Miw3ICszNDg4LDcgQEAgc3RhdGlj
IGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICAgCQl9Cj4g
ICAJfQo+ICAgCj4gLQlpZiAodmktPmhhc19yc3MpCj4gKwlpZiAodmktPmhhc19yc3MgfHwgdmkt
Pmhhc19yc3NfaGFzaF9yZXBvcnQpCj4gICAJCXZpcnRuZXRfaW5pdF9kZWZhdWx0X3Jzcyh2aSk7
Cj4gICAKPiAgIAllcnIgPSByZWdpc3Rlcl9uZXRkZXYoZGV2KTsKPiBAQCAtMzU4Nyw3ICszNjIz
LDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0aW9fZGV2aWNlX2lkIGlkX3RhYmxlW10gPSB7Cj4gICAJ
VklSVElPX05FVF9GX0NUUkxfTUFDX0FERFIsIFwKPiAgIAlWSVJUSU9fTkVUX0ZfTVRVLCBWSVJU
SU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUywgXAo+ICAgCVZJUlRJT19ORVRfRl9TUEVFRF9E
VVBMRVgsIFZJUlRJT19ORVRfRl9TVEFOREJZLCBcCj4gLQlWSVJUSU9fTkVUX0ZfUlNTCj4gKwlW
SVJUSU9fTkVUX0ZfUlNTLCBWSVJUSU9fTkVUX0ZfSEFTSF9SRVBPUlQKPiAgIAo+ICAgc3RhdGlj
IHVuc2lnbmVkIGludCBmZWF0dXJlc1tdID0gewo+ICAgCVZJUlRORVRfRkVBVFVSRVMsCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
