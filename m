Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30346C433EF
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 06:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE2BD813BE;
	Mon, 17 Jan 2022 06:59:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aXQnYtFp1l5C; Mon, 17 Jan 2022 06:59:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D0E59813BD;
	Mon, 17 Jan 2022 06:59:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8857DC0039;
	Mon, 17 Jan 2022 06:59:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68309C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59691401A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:59:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O6AZiFRCKCbS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:59:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 608FD40126
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642402751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2NegQvCaiSmjnS1vj3800KA10Cn7v2Is0bJ/5jWyGU=;
 b=ZSLnJRtdVODAKR77FCKDlDTsjTWLgYko7FamZFs3l8xA8SxCfZgfgu+EGVVAkEjMknIQsP
 gQfDXqQZW+AtT9zgrZ1+mphTNCEaznWtHsHEzCZ7oSmdNNtgtd2N4IvJNIQ+WZHqdoVVVz
 4k0hdc2eNaPdK2Al/T/OFrif4YdKTtw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-Smx3-6CJMJuCXZ1mwlrJJg-1; Mon, 17 Jan 2022 01:59:10 -0500
X-MC-Unique: Smx3-6CJMJuCXZ1mwlrJJg-1
Received: by mail-pf1-f198.google.com with SMTP id
 h196-20020a6283cd000000b004bed33745c9so5695378pfe.23
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Jan 2022 22:59:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=H2NegQvCaiSmjnS1vj3800KA10Cn7v2Is0bJ/5jWyGU=;
 b=nG2BLYatZxs4Sug0tOIa7kyLJwlYbQN9IgGRtzVwTwzIXSNSHRgIUd9umCEt/43oOB
 QRxcn/0Vmg5uQLzFqDNaNOATsLW9f+IRqZvi9mITDqCphrQ8pM0VFA9xm9d9gSSwLeFz
 2CZrciHYfBOnmbwEj9YtBTHSrralPC87Tz54OnGNcjbsS5NGbXX8D8nTOuGlSanp5r53
 rAEbvhvWlp8V8o7X+Lu7duUG7/PfXTP6rMNzbcHIZp7GCJxj2ITvekQW/933wWRwMktA
 +p0+VpEg+2Oh7uYWMpJWEK6a48n65HCm46MGRtUWacI0WFybSegAf6SAjn3uYrKD857h
 VECQ==
X-Gm-Message-State: AOAM533kNu/lOxOEydBZlUZjbs6WY13C+KfMIQmuzs3vya5ZweFa/hBE
 127cblbEkxmKhNl3LZunaddwJm7xYkJI5oPdt1hB8gWD9EkHHDw8alqJikgA11L/e3/4EzQEJvf
 EqJTm3IwIhYfjFaFDLz75a0kVJOGLlUVuDJYy4J+JDw==
X-Received: by 2002:a17:902:7617:b0:149:9c02:f260 with SMTP id
 k23-20020a170902761700b001499c02f260mr20935895pll.30.1642402749328; 
 Sun, 16 Jan 2022 22:59:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJk9KjcD1ls8O+A/NAQ7xQQ5Nqr5oBVypyZgGfRcZYF+SBHCARlQ9gdJw9xC5wMLfhsvPv/g==
X-Received: by 2002:a17:902:7617:b0:149:9c02:f260 with SMTP id
 k23-20020a170902761700b001499c02f260mr20935876pll.30.1642402749060; 
 Sun, 16 Jan 2022 22:59:09 -0800 (PST)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g10sm12214396pfo.103.2022.01.16.22.59.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jan 2022 22:59:08 -0800 (PST)
Message-ID: <fafc6e27-a824-95d8-269b-d98887989e32@redhat.com>
Date: Mon, 17 Jan 2022 14:59:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] vdpa/mlx5: should verify CTRL_VQ feature exists
 for MQ
To: Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1642206481-30721-1-git-send-email-si-wei.liu@oracle.com>
 <1642206481-30721-3-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1642206481-30721-3-git-send-email-si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lvivier@redhat.com, eperezma@redhat.com
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

CuWcqCAyMDIyLzEvMTUg5LiK5Y2IODoyOCwgU2ktV2VpIExpdSDlhpnpgZM6Cj4gUGVyIFZJUlRJ
TyB2MS4xIHNwZWNpZmljYXRpb24sIHNlY3Rpb24gNS4xLjMuMSBGZWF0dXJlIGJpdCByZXF1aXJl
bWVudHM6Cj4gIlZJUlRJT19ORVRfRl9NUSBSZXF1aXJlcyBWSVJUSU9fTkVUX0ZfQ1RSTF9WUSIu
Cj4KPiBUaGVyZSdzIGFzc3VtcHRpb24gaW4gdGhlIG1seDVfdmRwYSBtdWx0aXF1ZXVlIGNvZGUg
dGhhdCBNUSBtdXN0IGNvbWUKPiB0b2dldGhlciB3aXRoIENUUkxfVlEuIEhvd2V2ZXIsIHRoZXJl
J3Mgbm93aGVyZSBpbiB0aGUgdXBwZXIgbGF5ZXIgdG8KPiBndWFyYW50ZWUgdGhpcyBhc3N1bXB0
aW9uIHdvdWxkIGhvbGQuIFdlcmUgdGhlcmUgYW4gdW50cnVzdGVkIGRyaXZlcgo+IHNlbmRpbmcg
ZG93biBNUSB3aXRob3V0IENUUkxfVlEsIGl0IHdvdWxkIGNvbXByb21pc2UgdmFyaW91cyBzcG90
cyBmb3IKPiBlLmcuIGlzX2luZGV4X3ZhbGlkKCkgYW5kIGlzX2N0cmxfdnFfaWR4KCkuIEFsdGhv
dWdoIHRoaXMgZG9lc24ndCBlbmQKPiB1cCB3aXRoIGltbWVkaWF0ZSBwYW5pYyBvciBzZWN1cml0
eSBsb29waG9sZSBhcyBvZiB0b2RheSdzIGNvZGUsIHRoZQo+IGNoYW5jZSBmb3IgdGhpcyB0byBi
ZSB0YWtlbiBhZHZhbnRhZ2Ugb2YgZHVlIHRvIGZ1dHVyZSBjb2RlIGNoYW5nZSBpcwo+IG5vdCB6
ZXJvLgo+Cj4gSGFyZGVuIHRoZSBjcmlzcHkgYXNzdW1wdGlvbiBieSBmYWlsaW5nIHRoZSBzZXRf
ZHJpdmVyX2ZlYXR1cmVzKCkgY2FsbAo+IHdoZW4gc2VlaW5nIChNUSAmJiAhQ1RSTF9WUSkuIEZv
ciB0aGF0IGVuZCwgdmVyaWZ5X21pbl9mZWF0dXJlcygpIGlzCj4gcmVuYW1lZCB0byB2ZXJpZnlf
ZHJpdmVyX2ZlYXR1cmVzKCkgdG8gcmVmbGVjdCB0aGUgZmFjdCB0aGF0IGl0IG5vdyBkb2VzCj4g
bW9yZSB0aGFuIGp1c3QgdmFsaWRhdGUgdGhlIG1pbmltdW0gZmVhdHVyZXMuIHZlcmlmeV9kcml2
ZXJfZmVhdHVyZXMoKQo+IGlzIG5vdyB1c2VkIHRvIGFjY29tbW9kYXRlIHZhcmlvdXMgY2hlY2tz
IGFnYWluc3QgdGhlIGRyaXZlciBmZWF0dXJlcwo+IGZvciBzZXRfZHJpdmVyX2ZlYXR1cmVzKCku
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+CgoK
QWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRy
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDE4ICsrKysrKysrKysrKysrKystLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gaW5kZXggYjUzNjAzZC4uNmZhOTY4ZiAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiArKysgYi9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBAQCAtMTg5NywxMSArMTg5NywyNSBAQCBzdGF0
aWMgdTY0IG1seDVfdmRwYV9nZXRfZGV2aWNlX2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldikKPiAgIAlyZXR1cm4gbmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzOwo+ICAgfQo+ICAgCj4g
LXN0YXRpYyBpbnQgdmVyaWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZk
ZXYsIHU2NCBmZWF0dXJlcykKPiArc3RhdGljIGludCB2ZXJpZnlfZHJpdmVyX2ZlYXR1cmVzKHN0
cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdTY0IGZlYXR1cmVzKQo+ICAgewo+ICsJLyogTWlu
aW11bSBmZWF0dXJlcyB0byBleHBlY3QgKi8KPiAgIAlpZiAoIShmZWF0dXJlcyAmIEJJVF9VTEwo
VklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKSkpCj4gICAJCXJldHVybiAtRU9QTk9UU1VQUDsKPiAg
IAo+ICsJLyogRG91YmxlIGNoZWNrIGZlYXR1cmVzIGNvbWJpbmF0aW9uIHNlbnQgZG93biBieSB0
aGUgZHJpdmVyLgo+ICsJICogRmFpbCBpbnZhbGlkIGZlYXR1cmVzIGR1ZSB0byBhYnNlbmNlIG9m
IHRoZSBkZXBlbmRlZCBmZWF0dXJlLgo+ICsJICoKPiArCSAqIFBlciBWSVJUSU8gdjEuMSBzcGVj
aWZpY2F0aW9uLCBzZWN0aW9uIDUuMS4zLjEgRmVhdHVyZSBiaXQKPiArCSAqIHJlcXVpcmVtZW50
czogIlZJUlRJT19ORVRfRl9NUSBSZXF1aXJlcyBWSVJUSU9fTkVUX0ZfQ1RSTF9WUSIuCj4gKwkg
KiBCeSBmYWlsaW5nIHRoZSBpbnZhbGlkIGZlYXR1cmVzIHNlbnQgZG93biBieSB1bnRydXN0ZWQg
ZHJpdmVycywKPiArCSAqIHdlJ3JlIGFzc3VyZWQgdGhlIGFzc3VtcHRpb24gbWFkZSB1cG9uIGlz
X2luZGV4X3ZhbGlkKCkgYW5kCj4gKwkgKiBpc19jdHJsX3ZxX2lkeCgpIHdpbGwgbm90IGJlIGNv
bXByb21pc2VkLgo+ICsJICovCj4gKwlpZiAoKGZlYXR1cmVzICYgKEJJVF9VTEwoVklSVElPX05F
VF9GX01RKSB8IEJJVF9VTEwoVklSVElPX05FVF9GX0NUUkxfVlEpKSkgPT0KPiArICAgICAgICAg
ICAgQklUX1VMTChWSVJUSU9fTkVUX0ZfTVEpKQo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsKPiAg
IAlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+IEBAIC0xOTc3LDcgKzE5OTEsNyBAQCBzdGF0aWMgaW50
IG1seDVfdmRwYV9zZXRfZHJpdmVyX2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwg
dTY0IGZlYXR1cmVzKQo+ICAgCj4gICAJcHJpbnRfZmVhdHVyZXMobXZkZXYsIGZlYXR1cmVzLCB0
cnVlKTsKPiAgIAo+IC0JZXJyID0gdmVyaWZ5X21pbl9mZWF0dXJlcyhtdmRldiwgZmVhdHVyZXMp
Owo+ICsJZXJyID0gdmVyaWZ5X2RyaXZlcl9mZWF0dXJlcyhtdmRldiwgZmVhdHVyZXMpOwo+ICAg
CWlmIChlcnIpCj4gICAJCXJldHVybiBlcnI7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
