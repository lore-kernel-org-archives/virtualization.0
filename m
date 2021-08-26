Return-Path: <SRS0=dyh5=NR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E17C432BE
	for <virtualization@archiver.kernel.org>; Thu, 26 Aug 2021 08:04:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C0E610A7
	for <virtualization@archiver.kernel.org>; Thu, 26 Aug 2021 08:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25C0E610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFBC9605F2;
	Thu, 26 Aug 2021 08:04:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S0nXmMc_K45J; Thu, 26 Aug 2021 08:04:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 83B76605BF;
	Thu, 26 Aug 2021 08:04:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 503E4C0010;
	Thu, 26 Aug 2021 08:04:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0820C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Aug 2021 08:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCA53605F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Aug 2021 08:04:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fEeyoChfULDq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Aug 2021 08:04:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5679605BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Aug 2021 08:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629965051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pWFRIWqKee+uNGi6ntfJMO9CHCFiXtFiAILQZ1d0jY=;
 b=GNy47utOYP8ftGW7g3ENCRU1ClHA2OQGtPgRr7dcgaO62JeUgEPAFJnQdTL3X2c3wzMBN0
 A8kkS7CTjKqGEBSgRXh8FzSBF22yDHQmtImme7ZZQVKyxMWxs47uHQ4FGsbwYMtxr0DVh8
 pN0E08i1npOes3X9BVi1xiedrqxRdLo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-BGD4Xl08P0m63qtP23SOyw-1; Thu, 26 Aug 2021 04:04:10 -0400
X-MC-Unique: BGD4Xl08P0m63qtP23SOyw-1
Received: by mail-pf1-f198.google.com with SMTP id
 f23-20020aa782d7000000b003eb2baced8bso1137774pfn.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Aug 2021 01:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=3pWFRIWqKee+uNGi6ntfJMO9CHCFiXtFiAILQZ1d0jY=;
 b=hENoR5yoxUnvDUd93ElU8wPEYgxSaJayfUBunBaP8yNRBMZR42h64kShD7mhxNJAIp
 q/WDeastLhysMqQ3+waCoASQCLaKcDGeTybqhxp0UMt47LzjyoiQpTUdO0ped7vSRrbC
 ShXO58iYJqHG0ATCeNWwfZ6Pv68CTJRnWemdrWf9LPmKh6nUASB6AHm0FcUg0uKZ8O2j
 i3t2Qu9W3ukB0wZvRDKZ4j50UPAT3kG2F8afDzm5L9N+PaZ7N69vMzrplW3whuHwHezi
 pTDOjNt0IpDvDQiMIzTILwAsOuChViIMYVzCN4ECbnPk3/plfS++1cAyG/SXU2jJsxqi
 kTlQ==
X-Gm-Message-State: AOAM532epHoFkoTvxrkcUXN9rb9j03i8Z0vt5CBK4j0ZzeG4cL9aeXM9
 IW/racnt2oT3Ab0hzbMU+vbwcpL2Vzh/K3NZp5CSG4GKC2a7xCbfpmohK4iWV6CzCLMReQvCfTJ
 vgBHvsA1WA0J5EY8z2gsRUx7OyIdgEfp9vD2EBpjonw==
X-Received: by 2002:a17:90a:8b12:: with SMTP id
 y18mr15367548pjn.72.1629965049069; 
 Thu, 26 Aug 2021 01:04:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzYc7I4z8+dG5RaFdcryin8c05voA+Aywjgpqeqb8sEKoqndW5KfDBt4iwHhgw2aEnCzh2WQ==
X-Received: by 2002:a17:90a:8b12:: with SMTP id
 y18mr15367533pjn.72.1629965048810; 
 Thu, 26 Aug 2021 01:04:08 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c73sm1516595pfb.14.2021.08.26.01.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Aug 2021 01:04:08 -0700 (PDT)
Subject: Re: [PATCH v4 5/6] vdpa/mlx5: Add support for control VQ and MAC
 setting
To: Eugenio Perez Martin <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20210823052123.14909-1-elic@nvidia.com>
 <20210823052123.14909-6-elic@nvidia.com>
 <CAJaqyWdqSsmD6Z+2BqFMujJD-2zuYTqrhb-dpBjXG5+e6ViGVA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <48ed4750-5a24-189e-43e5-a4214fe4195b@redhat.com>
Date: Thu, 26 Aug 2021 16:04:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdqSsmD6Z+2BqFMujJD-2zuYTqrhb-dpBjXG5+e6ViGVA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org, Michael Tsirkin <mst@redhat.com>
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

CuWcqCAyMDIxLzgvMjQg5LiL5Y2IODo1OSwgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+
PiBAQCAtMTM3OCwxMSArMTUwOCwxOSBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9zZXRfdnFfYWRk
cmVzcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgsIHU2NCBkZXNjXwo+PiAgIHsK
Pj4gICAgICAgICAgc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7
Cj4+ICAgICAgICAgIHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25k
ZXYobXZkZXYpOwo+PiAtICAgICAgIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptdnEgPSAm
bmRldi0+dnFzW2lkeF07Cj4+ICsgICAgICAgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgKm12
cTsKPj4KPj4gICAgICAgICAgaWYgKCFpc19pbmRleF92YWxpZChtdmRldiwgaWR4KSkKPj4gICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPj4KPj4gKyAgICAgICBpZiAoaXNfY3RybF92
cV9pZHgobXZkZXYsIGlkeCkpIHsKPj4gKyAgICAgICAgICAgICAgIG12ZGV2LT5jdnEuZGVzY19h
ZGRyID0gZGVzY19hcmVhOwo+PiArICAgICAgICAgICAgICAgbXZkZXYtPmN2cS5kZXZpY2VfYWRk
ciA9IGRldmljZV9hcmVhOwo+PiArICAgICAgICAgICAgICAgbXZkZXYtPmN2cS5kcml2ZXJfYWRk
ciA9IGRyaXZlcl9hcmVhOwo+IEhpIEVsaSwKPgo+IFNvbWUgbWVjaGFuaXNtIGZvciB1cGRhdGlu
ZyB2cmluZ2ggYWRkcmVzc2VzIGlzIGFsc28gbmVlZGVkIGhlcmUuCj4gc2V0dXBfdmlydHF1ZXVl
cyBpcyBjYWxsZWQgYSBsb3QgZWFybGllciB0aGFuIGN2cSBhZGRyZXNzIHNldCwgYW5kCj4gd2hl
biBjdnEgaXMga2lja2VkIGl0IHRyaWVzIHRvIHJlYWQgZnJvbSBhbiBvdXRkYXRlZC9pbnZhbGlk
IGFkZHJlc3MuCgoKSGkgRXVnZW5pbzoKClVzdWFsbHkgdGhlIGRyaXZlciBzaG91bGQgc2V0IHRo
ZSBjdnEgYWRkcmVzcyBiZWZvcmUgc2V0IERSSVZFUl9PSy4KCkFuZCBkdXJpbmcgRFJJVkVSX09L
IHRoZSBtbHg1IGRyaXZlciB3aWxsIGNhbGwgc2V0dXBfdmlydHF1ZXVlcygpLgoKRGlkIHlvdSBz
ZWUgdGhlIGN2cSBpcyBzZXQgYWZ0ZXIgRFJJVkVSX09LPwoKVGhhbmtzCgoKPgo+IEluIG15IGVu
dmlyb25tZW50IEkganVzdCBzZXQgbXZkZXYtPmN2cS52cmluZy52cmluZy57ZGVzYyxhdmFpbCx1
c2VkfQo+IGFzIGEgd29ya2Fyb3VuZCBhbmQgdGhlbiBJIGhhdmUgY3ZxLCBidXQgSSB0aGluayBt
b3JlIHByb3RlY3Rpb24gaXMKPiBuZWVkZWQgYmVjYXVzZSBvZiB0aGUgd29ya3F1ZXVlLgo+Cj4g
U29ycnkgZm9yIHRoZSBkcmlwcGluZyBvZiBjb21tZW50cywgaXQgdG9vayBhIHdoaWxlIHRvIGtu
b3cgd2hhdCB3YXMKPiBmYWlsaW5nIGluIHRoZSBlbnZpcm9ubWVudC4KPgo+IFRoYW5rcyEKPgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
