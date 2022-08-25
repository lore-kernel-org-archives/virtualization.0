Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760F4C28D13
	for <virtualization@archiver.kernel.org>; Thu, 25 Aug 2022 07:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06E5483380;
	Thu, 25 Aug 2022 07:45:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06E5483380
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cn4a36+p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ouCP7NR9hDSI; Thu, 25 Aug 2022 07:45:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7D79A831A9;
	Thu, 25 Aug 2022 07:45:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D79A831A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54B8EC0032;
	Thu, 25 Aug 2022 07:45:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7229C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9810D41859
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:45:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9810D41859
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cn4a36+p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pRD7w88A4YHK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:44:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF23241858
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF23241858
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661413497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWHJOua38RJS2VpD323EH8m9oocDDSERK05+Run3Kgw=;
 b=Cn4a36+pAlLqtFvozHucJSfObtk/j6MgF5jPPgiZ1FLg+zLrx59SPHbSc+UerGE6E8VYKJ
 eqvza90QBqIzYOC9WA8V6QQEzGjtuoYS/6i6Utwk2GDJIhni/DRuFc4Hd6Z+AmTPjMB1C6
 7hcS8/auePgW1ialHfEI6mmpRq0lHQE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-456-R91C4hY0N9uGqFNg4vb_Fw-1; Thu, 25 Aug 2022 03:44:55 -0400
X-MC-Unique: R91C4hY0N9uGqFNg4vb_Fw-1
Received: by mail-pf1-f199.google.com with SMTP id
 b25-20020aa78119000000b00536a929d8e4so5066363pfi.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 00:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=zWHJOua38RJS2VpD323EH8m9oocDDSERK05+Run3Kgw=;
 b=Znxm3j6Y2GlOmKlxmbrBeKzLDvmQgFJWpRL+XHZp3i83ebQzGYxASyivReus9MGcO7
 mlHifrRW8IKcSltM8yAfu2KHuylThkvFBWhq7tY6G76/95I9ub+IaK8uaN3Ab9SQDjvV
 eRyn3I+IRqFiwWulYRzkGViKxJm+nopD956K7zk+LIqgg/1JnwT4KbLF5zmhReG8N5vZ
 9h5B78gTOPwqiazu1EtFCBgHBWNPjfOX5jBhPAe/fXeALK3BYTArshpRryIx7HUkt5Er
 g526YbWVtJ99P1WL4+KmGZTMLCzgbbmhWWizs0NPlFVniqDCttlE23B7sPS7tK9Gt7rN
 aNBA==
X-Gm-Message-State: ACgBeo0iIxlfILKER4VvKykmqciC7l2n7r0MTMu8Uqy5lq16on+JEFlQ
 QWIyh/sfYNdEHPfVPZR4Mpiv0/fLSjMQj68qb0T+7sA9aNoiUA4UDopo5OkBTtG00hTQyDZueCM
 Ow9LCMCJsi2oCLwaxKoKFBq6X11AJbkKGSXB0XRrvyA==
X-Received: by 2002:a65:6949:0:b0:41c:cb9d:3d1f with SMTP id
 w9-20020a656949000000b0041ccb9d3d1fmr2255955pgq.334.1661413494973; 
 Thu, 25 Aug 2022 00:44:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR75sNLCKhijU2tO7/6br2jUgmaSbR8Md7x1+OjmLVGn+Q+XRO2Hc97nH7XGtW3SfJCxbzuBEQ==
X-Received: by 2002:a65:6949:0:b0:41c:cb9d:3d1f with SMTP id
 w9-20020a656949000000b0041ccb9d3d1fmr2255934pgq.334.1661413494644; 
 Thu, 25 Aug 2022 00:44:54 -0700 (PDT)
Received: from [10.72.12.107] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 z24-20020aa79f98000000b0053627e0e860sm11687572pfr.27.2022.08.25.00.44.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Aug 2022 00:44:54 -0700 (PDT)
Message-ID: <ebf4b376-6a5c-3cfa-38ab-1559ace13b27@redhat.com>
Date: Thu, 25 Aug 2022 15:44:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [RFC v2 6/7] virtio: in order support for virtio_ring
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>, eperezma@redhat.com,
 sgarzare@redhat.com, mst@redhat.com
References: <20220817135718.2553-1-qtxuning1999@sjtu.edu.cn>
 <20220817135718.2553-7-qtxuning1999@sjtu.edu.cn>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220817135718.2553-7-qtxuning1999@sjtu.edu.cn>
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

CuWcqCAyMDIyLzgvMTcgMjE6NTcsIEd1byBaaGkg5YaZ6YGTOgo+IElmIGluIG9yZGVyIGZlYXR1
cmUgbmVnb3RpYXRlZCwgd2UgY2FuIHNraXAgdGhlIHVzZWQgcmluZyB0byBnZXQKPiBidWZmZXIn
cyBkZXNjIGlkIHNlcXVlbnRpYWxseS4KPgo+IFNpZ25lZC1vZmYtYnk6IEd1byBaaGkgPHF0eHVu
aW5nMTk5OUBzanR1LmVkdS5jbj4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMgfCA1MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gaW5kZXggMWMxYjNmYTM3NmEyLi4xNDMxODRlYmI1YTEgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMKPiBAQCAtMTQ0LDYgKzE0NCw5IEBAIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgewo+ICAg
CQkJLyogRE1BIGFkZHJlc3MgYW5kIHNpemUgaW5mb3JtYXRpb24gKi8KPiAgIAkJCWRtYV9hZGRy
X3QgcXVldWVfZG1hX2FkZHI7Cj4gICAJCQlzaXplX3QgcXVldWVfc2l6ZV9pbl9ieXRlczsKPiAr
Cj4gKwkJCS8qIEluIG9yZGVyIGZlYXR1cmUgYmF0Y2ggYmVnaW4gaGVyZSAqLwoKCldlIG5lZWQg
dHdlYWsgdGhlIGNvbW1lbnQsIGl0J3Mgbm90IGVhc3kgZm9yIG1lIHRvIHVuZGVyc3RhbmQgdGhl
IAptZWFuaW5nIGhlcmUuCgoKPiArCQkJdTE2IG5leHRfZGVzY19iZWdpbjsKPiAgIAkJfSBzcGxp
dDsKPiAgIAo+ICAgCQkvKiBBdmFpbGFibGUgZm9yIHBhY2tlZCByaW5nICovCj4gQEAgLTcwMiw4
ICs3MDUsMTMgQEAgc3RhdGljIHZvaWQgZGV0YWNoX2J1Zl9zcGxpdChzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlICp2cSwgdW5zaWduZWQgaW50IGhlYWQsCj4gICAJfQo+ICAgCj4gICAJdnJpbmdfdW5t
YXBfb25lX3NwbGl0KHZxLCBpKTsKPiAtCXZxLT5zcGxpdC5kZXNjX2V4dHJhW2ldLm5leHQgPSB2
cS0+ZnJlZV9oZWFkOwo+IC0JdnEtPmZyZWVfaGVhZCA9IGhlYWQ7Cj4gKwkvKiBJbiBvcmRlciBm
ZWF0dXJlIHVzZSBkZXNjIGluIG9yZGVyLAo+ICsJICogdGhhdCBtZWFucywgdGhlIG5leHQgZGVz
YyB3aWxsIGFsd2F5cyBiZSBmcmVlCj4gKwkgKi8KCgpNYXliZSB3ZSBzaG91bGQgYWRkIHNvbWV0
aGluZyBsaWtlICJUaGUgZGVzY3JpcHRvcnMgYXJlIHByZXBhcmVkIGluIG9yZGVyIi4KCgo+ICsJ
aWYgKCF2aXJ0aW9faGFzX2ZlYXR1cmUodnEtPnZxLnZkZXYsIFZJUlRJT19GX0lOX09SREVSKSkg
ewo+ICsJCXZxLT5zcGxpdC5kZXNjX2V4dHJhW2ldLm5leHQgPSB2cS0+ZnJlZV9oZWFkOwo+ICsJ
CXZxLT5mcmVlX2hlYWQgPSBoZWFkOwo+ICsJfQo+ICAgCj4gICAJLyogUGx1cyBmaW5hbCBkZXNj
cmlwdG9yICovCj4gICAJdnEtPnZxLm51bV9mcmVlKys7Cj4gQEAgLTc0NSw3ICs3NTMsNyBAQCBz
dGF0aWMgdm9pZCAqdmlydHF1ZXVlX2dldF9idWZfY3R4X3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUg
Kl92cSwKPiAgIHsKPiAgIAlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEp
Owo+ICAgCXZvaWQgKnJldDsKPiAtCXVuc2lnbmVkIGludCBpOwo+ICsJdW5zaWduZWQgaW50IGks
IGo7Cj4gICAJdTE2IGxhc3RfdXNlZDsKPiAgIAo+ICAgCVNUQVJUX1VTRSh2cSk7Cj4gQEAgLTc2
NCwxMSArNzcyLDM4IEBAIHN0YXRpYyB2b2lkICp2aXJ0cXVldWVfZ2V0X2J1Zl9jdHhfc3BsaXQo
c3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ICAgCS8qIE9ubHkgZ2V0IHVzZWQgYXJyYXkgZW50cmll
cyBhZnRlciB0aGV5IGhhdmUgYmVlbiBleHBvc2VkIGJ5IGhvc3QuICovCj4gICAJdmlydGlvX3Jt
Yih2cS0+d2Vha19iYXJyaWVycyk7Cj4gICAKPiAtCWxhc3RfdXNlZCA9ICh2cS0+bGFzdF91c2Vk
X2lkeCAmICh2cS0+c3BsaXQudnJpbmcubnVtIC0gMSkpOwo+IC0JaSA9IHZpcnRpbzMyX3RvX2Nw
dShfdnEtPnZkZXYsCj4gLQkJCXZxLT5zcGxpdC52cmluZy51c2VkLT5yaW5nW2xhc3RfdXNlZF0u
aWQpOwo+IC0JKmxlbiA9IHZpcnRpbzMyX3RvX2NwdShfdnEtPnZkZXYsCj4gLQkJCXZxLT5zcGxp
dC52cmluZy51c2VkLT5yaW5nW2xhc3RfdXNlZF0ubGVuKTsKPiArCWlmICh2aXJ0aW9faGFzX2Zl
YXR1cmUoX3ZxLT52ZGV2LCBWSVJUSU9fRl9JTl9PUkRFUikpIHsKPiArCQkvKiBTa2lwIHVzZWQg
cmluZyBhbmQgZ2V0IHVzZWQgZGVzYyBpbiBvcmRlciovCj4gKwkJaSA9IHZxLT5zcGxpdC5uZXh0
X2Rlc2NfYmVnaW47Cj4gKwkJaiA9IGk7Cj4gKwkJLyogSW5kaXJlY3Qgb25seSB0YWtlcyBvbmUg
ZGVzY3JpcHRvciBpbiBkZXNjcmlwdG9yIHRhYmxlICovCj4gKwkJd2hpbGUgKCF2cS0+aW5kaXJl
Y3QgJiYgKHZxLT5zcGxpdC5kZXNjX2V4dHJhW2pdLmZsYWdzICYgVlJJTkdfREVTQ19GX05FWFQp
KQo+ICsJCQlqID0gKGogKyAxKSAlIHZxLT5zcGxpdC52cmluZy5udW07CgoKTGV0J3MgbW92ZSB0
aGUgZXhwZW5zaXZlIG1vZCBvdXRzaWRlIHRoZSBsb29wLiBPciBpdCdzIHNwbGl0IHNvIHdlIGNh
biAKdXNlIGFuZCBoZXJlIGFjdHVhbGx5IHNpbmNlIHRoZSBzaXplIGlzIGd1YXJhbnRlZWQgdG8g
YmUgcG93ZXIgb2YgdGhlIAp0d28/IEFub3RoZXIgcXVlc3Rpb24sIGlzIGl0IGJldHRlciB0byBz
dG9yZSB0aGUgbmV4dF9kZXNjIGluIGUuZyAKZGVzY19leHRyYT8KCkFuZCB0aGlzIHNlZW1zIHZl
cnkgZXhwZW5zaXZlIGlmIHRoZSBkZXZpY2UgZG9lc24ndCBkbyB0aGUgYmF0Y2hpbmcgCih3aGlj
aCBpcyBub3QgbWFuZGF0b3J5KS4KCgo+ICsJCS8qIG1vdmUgdG8gbmV4dCAqLwo+ICsJCWogPSAo
aiArIDEpICUgdnEtPnNwbGl0LnZyaW5nLm51bTsKPiArCQkvKiBOZXh0IGJ1ZmZlciB3aWxsIHVz
ZSB0aGlzIGRlc2NyaXB0b3IgaW4gb3JkZXIgKi8KPiArCQl2cS0+c3BsaXQubmV4dF9kZXNjX2Jl
Z2luID0gajsKPiArCQlpZiAoIXZxLT5pbmRpcmVjdCkgewo+ICsJCQkqbGVuID0gdnEtPnNwbGl0
LmRlc2NfZXh0cmFbaV0ubGVuOwo+ICsJCX0gZWxzZSB7Cj4gKwkJCXN0cnVjdCB2cmluZ19kZXNj
ICppbmRpcl9kZXNjID0KPiArCQkJCXZxLT5zcGxpdC5kZXNjX3N0YXRlW2ldLmluZGlyX2Rlc2M7
Cj4gKwkJCXUzMiBpbmRpcl9udW0gPSB2cS0+c3BsaXQuZGVzY19leHRyYVtpXS5sZW4sIGJ1ZmZl
cl9sZW4gPSAwOwo+ICsKPiArCQkJaWYgKGluZGlyX2Rlc2MpIHsKPiArCQkJCWZvciAoaiA9IDA7
IGogPCBpbmRpcl9udW0gLyBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2MpOyBqKyspCj4gKwkJCQkJ
YnVmZmVyX2xlbiArPSBpbmRpcl9kZXNjW2pdLmxlbjsKCgpTbyBJIHRoaW5rIHdlIG5lZWQgdG8g
ZmluYWxpemUgdGhpcywgdGhlbiB3ZSBjYW4gaGF2ZSBtdWNoIG1vcmUgc3RyZXNzIApvbiB0aGUg
Y2FjaGU6CgpodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMS8xMC8yNi8xMzAwCgpJdCB3YXMgcmV2
ZXJ0ZWQgc2luY2UgaXQncyB0b28gYWdncmVzc2l2ZSwgd2Ugc2hvdWxkIGluc3RlYWQ6CgoxKSBk
byB0aGUgdmFsaWRhdGlvbiBvbmx5IGZvciBtb3JkZW4gZGV2aWNlCgoyKSBmYWlsIG9ubHkgd2hl
biB3ZSBlbmFibGUgdGhlIHZhbGlkYXRpb24gdmlhIChlLmcgYSBtb2R1bGUgcGFyYW1ldGVyKS4K
ClRoYW5rcwoKCj4gKwkJCX0KPiArCj4gKwkJCSpsZW4gPSBidWZmZXJfbGVuOwo+ICsJCX0KPiAr
CX0gZWxzZSB7Cj4gKwkJbGFzdF91c2VkID0gKHZxLT5sYXN0X3VzZWRfaWR4ICYgKHZxLT5zcGxp
dC52cmluZy5udW0gLSAxKSk7Cj4gKwkJaSA9IHZpcnRpbzMyX3RvX2NwdShfdnEtPnZkZXYsCj4g
KwkJCQkgICAgdnEtPnNwbGl0LnZyaW5nLnVzZWQtPnJpbmdbbGFzdF91c2VkXS5pZCk7Cj4gKwkJ
KmxlbiA9IHZpcnRpbzMyX3RvX2NwdShfdnEtPnZkZXYsCj4gKwkJCQkgICAgICAgdnEtPnNwbGl0
LnZyaW5nLnVzZWQtPnJpbmdbbGFzdF91c2VkXS5sZW4pOwo+ICsJfQo+ICAgCj4gICAJaWYgKHVu
bGlrZWx5KGkgPj0gdnEtPnNwbGl0LnZyaW5nLm51bSkpIHsKPiAgIAkJQkFEX1JJTkcodnEsICJp
ZCAldSBvdXQgb2YgcmFuZ2VcbiIsIGkpOwo+IEBAIC0yMjM2LDYgKzIyNzEsOCBAQCBzdHJ1Y3Qg
dmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ICAg
CXZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cgPSAwOwo+ICAgCXZxLT5zcGxpdC5hdmFpbF9p
ZHhfc2hhZG93ID0gMDsKPiAgIAo+ICsJdnEtPnNwbGl0Lm5leHRfZGVzY19iZWdpbiA9IDA7Cj4g
Kwo+ICAgCS8qIE5vIGNhbGxiYWNrPyAgVGVsbCBvdGhlciBzaWRlIG5vdCB0byBib3RoZXIgdXMu
ICovCj4gICAJaWYgKCFjYWxsYmFjaykgewo+ICAgCQl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hh
ZG93IHw9IFZSSU5HX0FWQUlMX0ZfTk9fSU5URVJSVVBUOwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
