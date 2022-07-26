Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D652C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 08:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDA9282F4A;
	Tue, 26 Jul 2022 08:08:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDA9282F4A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P6XvNV0O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FZoJUDXvCaV4; Tue, 26 Jul 2022 08:08:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1E1F682F51;
	Tue, 26 Jul 2022 08:08:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E1F682F51
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7581C0035;
	Tue, 26 Jul 2022 08:08:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16672C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 08:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DECDA40BD1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 08:07:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DECDA40BD1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=P6XvNV0O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hckOTZkoIzR5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 08:07:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 14A30401D5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14A30401D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 08:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658822877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v2FS+wcLS276CjyoJxXnom+ZC/VQJoGiBzM4C9YEjwQ=;
 b=P6XvNV0OggGFFfkSr7IsoCZDABR5vDodtvb2vc3uA+//YJ1kWrpyploq3ijuUu6ajZMgh2
 zoZJ+00tPwe0oJO0XhEy0w4iKDHAQmCWpAcaHTo2kGci+sPut7ymvubHLED3Z1f2ai9p0k
 4jhxA7HQO0TgWAajy5DY4O46lglRT2s=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-DltUbTB_O22oRUnavZvlDA-1; Tue, 26 Jul 2022 04:07:53 -0400
X-MC-Unique: DltUbTB_O22oRUnavZvlDA-1
Received: by mail-pl1-f200.google.com with SMTP id
 s6-20020a170902ea0600b0016d5c8c4164so4344767plg.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 01:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=v2FS+wcLS276CjyoJxXnom+ZC/VQJoGiBzM4C9YEjwQ=;
 b=EZB7y71QqGETqsYumx1d0e8PD+64DLPVOQIA6bAsKGH+ulKloQUXyzV74b2WrS4wAx
 c+dZE9NbK2Dq3nfgOFTHdK8C20bJ6VdT0bmPgSY6qkydhrMyHwb1Z8qg+sORvzVBp58a
 qsH5LGSW3ApABt5elDZyTsj/8UVdw+0FPKBi/3naUlvmzVx0KOa3NHxXDlYhsYEMBkIy
 eJfv7DxNG8h+sG3JzgmttYy8W7QoniXSS9Mxpp2FBETlXt/e4ffoxgHCT6eoe4iyAXXT
 EoP9oRlnNHUbUVjq8nRufsDzYFonT5RwMOm0RW/W18XsPdNzX9GpzEZLM8ygp1/aaXeX
 roPg==
X-Gm-Message-State: AJIora+hcFpb6D4/PDXPQ++IWBkimvM7UC7HvnCX85DqsGLCj8G1IEf1
 0+kU6Fw8sC8PHWBeUtADhY3aXL8oiXpWbzZcgnJXN4sw6VdzlzIC67eOb+Bum0Tcrdqp+RaGJiZ
 Jr9KrAcwulGcdM0LBPFZOgljTV1f8HWyGNA1QXUJIiA==
X-Received: by 2002:a17:90b:3ece:b0:1f0:6b2e:6fbf with SMTP id
 rm14-20020a17090b3ece00b001f06b2e6fbfmr35013942pjb.203.1658822872181; 
 Tue, 26 Jul 2022 01:07:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t6pDFB5xcS97km93rf91OBUoaDmySnwXucaOEG95lnhcHdHOmDqsphKxM28DLJ13n4R8FnIg==
X-Received: by 2002:a17:90b:3ece:b0:1f0:6b2e:6fbf with SMTP id
 rm14-20020a17090b3ece00b001f06b2e6fbfmr35013922pjb.203.1658822871777; 
 Tue, 26 Jul 2022 01:07:51 -0700 (PDT)
Received: from [10.72.12.201] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a62cd09000000b0052abfc4b4a4sm11290893pfg.12.2022.07.26.01.07.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jul 2022 01:07:51 -0700 (PDT)
Message-ID: <9d4c24de-f2cc-16a0-818a-16695946f3a3@redhat.com>
Date: Tue, 26 Jul 2022 16:07:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC 4/5] virtio: get desc id in order
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>, eperezma@redhat.com,
 sgarzare@redhat.com, mst@redhat.com
References: <20220721084341.24183-1-qtxuning1999@sjtu.edu.cn>
 <20220721084341.24183-5-qtxuning1999@sjtu.edu.cn>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220721084341.24183-5-qtxuning1999@sjtu.edu.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIyLzcvMjEgMTY6NDMsIEd1byBaaGkg5YaZ6YGTOgo+IElmIGluIG9yZGVyIGZlYXR1
cmUgbmVnb3RpYXRlZCwgd2UgY2FuIHNraXAgdGhlIHVzZWQgcmluZyB0byBnZXQKPiBidWZmZXIn
cyBkZXNjIGlkIHNlcXVlbnRpYWxseS4KCgpMZXQncyByZW5hbWUgdGhlIHBhdGNoIHRvIHNvbWV0
aGluZyBsaWtlICJpbiBvcmRlciBzdXBwb3J0IGZvciB2aXJ0aW9fcmluZyIKCgo+Cj4gU2lnbmVk
LW9mZi1ieTogR3VvIFpoaSA8cXR4dW5pbmcxOTk5QHNqdHUuZWR1LmNuPgo+IC0tLQo+ICAgZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pCgoKSSBkb24ndCBzZWUgcGFja2VkIHN1cHBvcnQgaW4gdGhpcyBwYXRjaCwgd2UgbmVl
ZCB0byBpbXBsZW1lbnQgdGhhdC4KCgo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggYTVlYzcy
NGMwLi40ZDU3YTRlZGMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMTQ0LDYgKzE0NCw5
IEBAIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgewo+ICAgCQkJLyogRE1BIGFkZHJlc3MgYW5kIHNp
emUgaW5mb3JtYXRpb24gKi8KPiAgIAkJCWRtYV9hZGRyX3QgcXVldWVfZG1hX2FkZHI7Cj4gICAJ
CQlzaXplX3QgcXVldWVfc2l6ZV9pbl9ieXRlczsKPiArCj4gKwkJCS8qIEluIG9yZGVyIGZlYXR1
cmUgYmF0Y2ggYmVnaW4gaGVyZSAqLwo+ICsJCQl1MTYgbmV4dF9iYXRjaF9kZXNjX2JlZ2luOwo+
ICAgCQl9IHNwbGl0Owo+ICAgCj4gICAJCS8qIEF2YWlsYWJsZSBmb3IgcGFja2VkIHJpbmcgKi8K
PiBAQCAtNzAwLDggKzcwMywxMCBAQCBzdGF0aWMgdm9pZCBkZXRhY2hfYnVmX3NwbGl0KHN0cnVj
dCB2cmluZ192aXJ0cXVldWUgKnZxLCB1bnNpZ25lZCBpbnQgaGVhZCwKPiAgIAl9Cj4gICAKPiAg
IAl2cmluZ191bm1hcF9vbmVfc3BsaXQodnEsIGkpOwo+IC0JdnEtPnNwbGl0LmRlc2NfZXh0cmFb
aV0ubmV4dCA9IHZxLT5mcmVlX2hlYWQ7Cj4gLQl2cS0+ZnJlZV9oZWFkID0gaGVhZDsKPiArCWlm
ICghdmlydGlvX2hhc19mZWF0dXJlKHZxLT52cS52ZGV2LCBWSVJUSU9fRl9JTl9PUkRFUikpIHsK
PiArCQl2cS0+c3BsaXQuZGVzY19leHRyYVtpXS5uZXh0ID0gdnEtPmZyZWVfaGVhZDsKPiArCQl2
cS0+ZnJlZV9oZWFkID0gaGVhZDsKPiArCX0KCgpMZXQncyBhZGQgYSBjb21tZW50IHRvIGV4cGxh
aW4gd2h5IHdlIGRvbid0IG5lZWQgYW55dGhpbmcgaWYgaW4gb3JkZXIgaXMgCm5lb2dpdGF0ZWQu
CgoKPiAgIAo+ICAgCS8qIFBsdXMgZmluYWwgZGVzY3JpcHRvciAqLwo+ICAgCXZxLT52cS5udW1f
ZnJlZSsrOwo+IEBAIC03NDMsNyArNzQ4LDggQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9nZXRf
YnVmX2N0eF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICB7Cj4gICAJc3RydWN0IHZy
aW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPiAgIAl2b2lkICpyZXQ7Cj4gLQl1bnNp
Z25lZCBpbnQgaTsKPiArCV9fdmlydGlvMTYgbmV4dGZsYWcgPSBjcHVfdG9fdmlydGlvMTYodnEt
PnZxLnZkZXYsIFZSSU5HX0RFU0NfRl9ORVhUKTsKPiArCXVuc2lnbmVkIGludCBpLCBqOwo+ICAg
CXUxNiBsYXN0X3VzZWQ7Cj4gICAKPiAgIAlTVEFSVF9VU0UodnEpOwo+IEBAIC03NjIsMTEgKzc2
OCwyNCBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2dldF9idWZfY3R4X3NwbGl0KHN0cnVjdCB2
aXJ0cXVldWUgKl92cSwKPiAgIAkvKiBPbmx5IGdldCB1c2VkIGFycmF5IGVudHJpZXMgYWZ0ZXIg
dGhleSBoYXZlIGJlZW4gZXhwb3NlZCBieSBob3N0LiAqLwo+ICAgCXZpcnRpb19ybWIodnEtPndl
YWtfYmFycmllcnMpOwo+ICAgCj4gLQlsYXN0X3VzZWQgPSAodnEtPmxhc3RfdXNlZF9pZHggJiAo
dnEtPnNwbGl0LnZyaW5nLm51bSAtIDEpKTsKPiAtCWkgPSB2aXJ0aW8zMl90b19jcHUoX3ZxLT52
ZGV2LAo+IC0JCQl2cS0+c3BsaXQudnJpbmcudXNlZC0+cmluZ1tsYXN0X3VzZWRdLmlkKTsKPiAt
CSpsZW4gPSB2aXJ0aW8zMl90b19jcHUoX3ZxLT52ZGV2LAo+IC0JCQl2cS0+c3BsaXQudnJpbmcu
dXNlZC0+cmluZ1tsYXN0X3VzZWRdLmxlbik7Cj4gKwlpZiAodmlydGlvX2hhc19mZWF0dXJlKF92
cS0+dmRldiwgVklSVElPX0ZfSU5fT1JERVIpKSB7Cj4gKwkJLyogU2tpcCB1c2VkIHJpbmcgYW5k
IGdldCB1c2VkIGRlc2MgaW4gb3JkZXIqLwo+ICsJCWkgPSB2cS0+c3BsaXQubmV4dF9iYXRjaF9k
ZXNjX2JlZ2luOwo+ICsJCWogPSBpOwo+ICsJCXdoaWxlICh2cS0+c3BsaXQudnJpbmcuZGVzY1tq
XS5mbGFncyAmIG5leHRmbGFnKQoKCkxldCdzIGRvbid0IGRlcGVuZCBvbiB0aGUgZGVzY3JpcHRv
ciByaW5nIHdoaWNoIGlzIHVuZGVyIHRoZSBjb250cm9sIG9mIAp0aGUgbWFsaWNpb3VzIGh5cGVy
dmlzb3IuCgpMZXQncyB1c2UgZGVzY19leHRyYSB0aGF0IGlzIG5vdCB2aXNpYmxlIGJ5IHRoZSBo
eXBlcnZpc29yLiBNb3JlIGNhbiBiZSAKc2VlbiBpbiB0aGlzIGNvbW1pdDoKCjcyYjVlODk1ODcz
OCAoInZpcnRpby1yaW5nOiBzdG9yZSBETUEgbWV0YWRhdGEgaW4gZGVzY19leHRyYSBmb3Igc3Bs
aXQgCnZpcnRxdWV1ZSIpCgoKPiArCQkJaiA9IChqICsgMSkgJSB2cS0+c3BsaXQudnJpbmcubnVt
Owo+ICsJCS8qIG1vdmUgdG8gbmV4dCAqLwo+ICsJCWogPSAoaiArIDEpICUgdnEtPnNwbGl0LnZy
aW5nLm51bTsKPiArCQl2cS0+c3BsaXQubmV4dF9iYXRjaF9kZXNjX2JlZ2luID0gajsKCgpJJ20g
bm90IHN1cmUgSSBnZXQgdGhlIGxvZ2ljIGhlcmUsIGJhc2ljYWxseSBJIHRoaW5rIHdlIHNob3Vs
ZCBjaGVjayAKYnVmZmVyIGluc3RlYWQgb2YgZGVzY3JpcHRvciBoZXJlLgoKU28gaWYgdnJpbmcu
dXNlZC0+cmluZ1tsYXN0X3VzZWRdLmlkICE9IGxhc3RfdXNlZCwgd2Uga25vdyBhbGwgCltsYXN0
X3VzZWQsIHZyaW5nLnVzZWQtPnJpbmdbbGFzdF91c2VkXS5pZF0gaGF2ZSBiZWVuIHVzZWQgaW4g
YSBiYXRjaD8KCgo+ICsKPiArCQkvKiBUT0RPOiBsZW4gb2YgYnVmZmVyICovCgoKU28gc3BlYyBz
YWlkOgoKIgoKVGhlIHNraXBwZWQgYnVmZmVycyAoZm9yIHdoaWNoIG5vIHVzZWQgcmluZyBlbnRy
eSB3YXMgd3JpdHRlbikgYXJlIAphc3N1bWVkIHRvIGhhdmUgYmVlbiB1c2VkIChyZWFkIG9yIHdy
aXR0ZW4pIGJ5IHRoZSBkZXZpY2UgY29tcGxldGVseS4KCgoiCgpUaGFua3MKCgo+ICsJfSBlbHNl
IHsKPiArCQlsYXN0X3VzZWQgPSAodnEtPmxhc3RfdXNlZF9pZHggJiAodnEtPnNwbGl0LnZyaW5n
Lm51bSAtIDEpKTsKPiArCQlpID0gdmlydGlvMzJfdG9fY3B1KF92cS0+dmRldiwKPiArCQkJCSAg
ICB2cS0+c3BsaXQudnJpbmcudXNlZC0+cmluZ1tsYXN0X3VzZWRdLmlkKTsKPiArCQkqbGVuID0g
dmlydGlvMzJfdG9fY3B1KF92cS0+dmRldiwKPiArCQkJCSAgICAgICB2cS0+c3BsaXQudnJpbmcu
dXNlZC0+cmluZ1tsYXN0X3VzZWRdLmxlbik7Cj4gKwl9Cj4gICAKPiAgIAlpZiAodW5saWtlbHko
aSA+PSB2cS0+c3BsaXQudnJpbmcubnVtKSkgewo+ICAgCQlCQURfUklORyh2cSwgImlkICV1IG91
dCBvZiByYW5nZVxuIiwgaSk7Cj4gQEAgLTIyMzQsNiArMjI1Myw4IEBAIHN0cnVjdCB2aXJ0cXVl
dWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAJdnEtPnNw
bGl0LmF2YWlsX2ZsYWdzX3NoYWRvdyA9IDA7Cj4gICAJdnEtPnNwbGl0LmF2YWlsX2lkeF9zaGFk
b3cgPSAwOwo+ICAgCj4gKwl2cS0+c3BsaXQubmV4dF9iYXRjaF9kZXNjX2JlZ2luID0gMDsKPiAr
Cj4gICAJLyogTm8gY2FsbGJhY2s/ICBUZWxsIG90aGVyIHNpZGUgbm90IHRvIGJvdGhlciB1cy4g
Ki8KPiAgIAlpZiAoIWNhbGxiYWNrKSB7Cj4gICAJCXZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFk
b3cgfD0gVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQ7CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
