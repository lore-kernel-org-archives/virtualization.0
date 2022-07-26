Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F393C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 07:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E57F783FE8;
	Tue, 26 Jul 2022 07:36:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E57F783FE8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GizBc+2L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KzxqKMrBCfWk; Tue, 26 Jul 2022 07:36:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BCD9C83298;
	Tue, 26 Jul 2022 07:36:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCD9C83298
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85F90C0033;
	Tue, 26 Jul 2022 07:36:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32875C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBDB760DF6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:36:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EBDB760DF6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GizBc+2L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g9evK52quvrb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:36:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C829960AFF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C829960AFF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658820973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2X6PqCMeHc1eaWE4k5DTUECIGHthtw+h76LSBegAoc=;
 b=GizBc+2Lp1Z2dgVA8kY+6obkF3WbYVupqRDej2MN8tmEP2gFe9eyTsJjzhE5n0stUV1ZuO
 0fyZi2F0iDgBKT8lUDA1kZ2X+xMQyNczagnN9X5IxSTL2Sk2bfU1zExtUJYfQS/qmtzxHL
 B/BKRK7oLS7d6KRLrtnv3oppCrzYuuE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-rF7sbuAfNTyg8tpddbRIww-1; Tue, 26 Jul 2022 03:36:11 -0400
X-MC-Unique: rF7sbuAfNTyg8tpddbRIww-1
Received: by mail-pl1-f197.google.com with SMTP id
 z15-20020a170903018f00b0016d6e7a043dso3328103plg.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 00:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=I2X6PqCMeHc1eaWE4k5DTUECIGHthtw+h76LSBegAoc=;
 b=dRioHDho0AvbjgMcqM/Ktnyqz921KqclMYf9MNuekLYBvAEcX2oQKUPRAb1Pg1r5VT
 NwVcnnbSOPeCKcH+re9N+xOIIHD8SxxLC2mhAmJ/fIlRHpx999GzxlB3Ca3gN3creMHN
 nkoMBEOtxq/EpODYt426K5vwIvSz+NU5lxOHzTjMwBhh8oAyDSnYWI2cJjkjhTchDzhL
 1AMtxdHwCxqDHwLk91YxJgrEAAxlFdwlZq1tNOfa8cOh2NeppwLFGcZwCBmkkOW6bQ/K
 7HJ30ZEK5Sev0NK9YpXc2hped5rQfR2h9WXyLEzLtufDROq8Yq5X1+nL0e4L2/wVX/Kf
 jgVw==
X-Gm-Message-State: AJIora8Kf+ObQjSTSMJ0elqL3oYZroh0b7hlT7FYwngn/AHs5KLAnzCe
 i/3hppTcFoWLrdikYqgrfCSTyH2P8ITI6MryHvoLliwIItUL95A3qkv/ObgKxo7DvENtYvwBBGD
 IIQmBJ2PlNkH1qnReI9Q6qwlqD3gyQsemfaCqPGU/mQ==
X-Received: by 2002:a17:902:cf4a:b0:16b:d4a8:b92e with SMTP id
 e10-20020a170902cf4a00b0016bd4a8b92emr7837092plg.16.1658820970472; 
 Tue, 26 Jul 2022 00:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tdX+kz6MU69RxO0ipZjRMbzb/5fxM+oxpalwEkNhFemmJUH/+vCfJ8sm1F0bb0Jbjv0YZ/yg==
X-Received: by 2002:a17:902:cf4a:b0:16b:d4a8:b92e with SMTP id
 e10-20020a170902cf4a00b0016bd4a8b92emr7837079plg.16.1658820970172; 
 Tue, 26 Jul 2022 00:36:10 -0700 (PDT)
Received: from [10.72.12.201] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 x23-20020a1709027c1700b0016c57657977sm10604451pll.41.2022.07.26.00.36.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jul 2022 00:36:09 -0700 (PDT)
Message-ID: <16a232ad-e0a1-fd4c-ae3e-27db168daacb@redhat.com>
Date: Tue, 26 Jul 2022 15:36:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC 1/5] vhost: reorder used descriptors in a batch
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>, eperezma@redhat.com,
 sgarzare@redhat.com, mst@redhat.com
References: <20220721084341.24183-1-qtxuning1999@sjtu.edu.cn>
 <20220721084341.24183-2-qtxuning1999@sjtu.edu.cn>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220721084341.24183-2-qtxuning1999@sjtu.edu.cn>
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

CuWcqCAyMDIyLzcvMjEgMTY6NDMsIEd1byBaaGkg5YaZ6YGTOgo+IERldmljZSBtYXkgbm90IHVz
ZSBkZXNjcmlwdG9ycyBpbiBvcmRlciwgZm9yIGV4YW1wbGUsIE5JQyBhbmQgU0NTSSBtYXkKPiBu
b3QgY2FsbCBfX3Zob3N0X2FkZF91c2VkX24gd2l0aCBidWZmZXJzIGluIG9yZGVyLiAgSXQncyB0
aGUgdGFzayBvZgo+IF9fdmhvc3RfYWRkX3VzZWRfbiB0byBvcmRlciB0aGVtLgoKCkknbSBub3Qg
c3VyZSB0aGlzIGlzIHR1cmUuIEhhdmluZyBvb28gZGVzY3JpcHRvcnMgaXMgcHJvYmFibHkgYnkg
ZGVzaWduIAp0byBoYXZlIGJldHRlciBwZXJmb3JtYW5jZS4KClRoaXMgbWlnaHQgYmUgb2J2aW91
cyBmb3IgZGV2aWNlIHRoYXQgbWF5IGhhdmUgZWxldmF0b3Igb3IgUU9TIHN0dWZmcy4KCkkgc3Vz
cGVjdCB0aGUgcmlnaHQgdGhpbmcgdG8gZG8gaGVyZSBpcywgZm9yIHRoZSBkZXZpY2UgdGhhdCBj
YW4ndCAKcGVyZm9ybSBiZXR0ZXIgaW4gdGhlIGNhc2Ugb2YgSU5fT1JERVIsIGxldCdzIHNpbXBs
eSBub3Qgb2ZmZXIgSU5fT1JERVIgCih6ZXJvY29weSBvciBzY3NpKS4gQW5kIGZvciB0aGUgZGV2
aWNlIHdlIGtub3cgaXQgY2FuIHBlcmZvcm0gYmV0dGVyLCAKbm9uLXplcmNvcHkgZXRoZXJuZXQg
ZGV2aWNlIHdlIGNhbiBkbyB0aGF0LgoKCj4gICBUaGlzIGNvbW1pdCByZW9yZGVyIHRoZSBidWZm
ZXJzIHVzaW5nCj4gdnEtPmhlYWRzLCBvbmx5IHRoZSBiYXRjaCBpcyBiZWdpbiBmcm9tIHRoZSBl
eHBlY3RlZCBzdGFydCBwb2ludCBhbmQgaXMKPiBjb250aW51b3VzIGNhbiB0aGUgYmF0Y2ggYmUg
ZXhwb3NlZCB0byBkcml2ZXIuICBBbmQgb25seSB3cml0aW5nIG91dCBhCj4gc2luZ2xlIHVzZWQg
cmluZyBmb3IgYSBiYXRjaCBvZiBkZXNjcmlwdG9ycywgYWNjb3JkaW5nIHRvIFZJUlRJTyAxLjEK
PiBzcGVjLgoKClNvIHRoaXMgc291bmRzIG1vcmUgbGlrZSBhICJ3b3JrYXJvdW5kIiBvZiB0aGUg
ZGV2aWNlIHRoYXQgY2FuJ3QgY29uc3VtZSAKYnVmZmVyIGluIG9yZGVyLCBJIHN1c3BlY3QgaXQg
Y2FuIGhlbHAgaW4gcGVyZm9ybWFuY2UuCgpNb3JlIGJlbG93LgoKCj4KPiBTaWduZWQtb2ZmLWJ5
OiBHdW8gWmhpIDxxdHh1bmluZzE5OTlAc2p0dS5lZHUuY24+Cj4gLS0tCj4gICBkcml2ZXJzL3Zo
b3N0L3Zob3N0LmMgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tCj4gICBkcml2ZXJzL3Zob3N0L3Zob3N0LmggfCAgMyArKysKPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgNDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBpbmRleCA0MDA5Nzgy
NmMuLmUyZTc3ZTI5ZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiArKysg
Yi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBAQCAtMzE3LDYgKzMxNyw3IEBAIHN0YXRpYyB2b2lk
IHZob3N0X3ZxX3Jlc2V0KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPiAgIAl2cS0+dXNlZF9mbGFn
cyA9IDA7Cj4gICAJdnEtPmxvZ191c2VkID0gZmFsc2U7Cj4gICAJdnEtPmxvZ19hZGRyID0gLTF1
bGw7Cj4gKwl2cS0+bmV4dF91c2VkX2hlYWRfaWR4ID0gMDsKPiAgIAl2cS0+cHJpdmF0ZV9kYXRh
ID0gTlVMTDsKPiAgIAl2cS0+YWNrZWRfZmVhdHVyZXMgPSAwOwo+ICAgCXZxLT5hY2tlZF9iYWNr
ZW5kX2ZlYXR1cmVzID0gMDsKPiBAQCAtMzk4LDYgKzM5OSw4IEBAIHN0YXRpYyBsb25nIHZob3N0
X2Rldl9hbGxvY19pb3ZlY3Moc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ICAgCQkJCQkgIEdGUF9L
RVJORUwpOwo+ICAgCQlpZiAoIXZxLT5pbmRpcmVjdCB8fCAhdnEtPmxvZyB8fCAhdnEtPmhlYWRz
KQo+ICAgCQkJZ290byBlcnJfbm9tZW07Cj4gKwo+ICsJCW1lbXNldCh2cS0+aGVhZHMsIDAsIHNp
emVvZigqdnEtPmhlYWRzKSAqIGRldi0+aW92X2xpbWl0KTsKPiAgIAl9Cj4gICAJcmV0dXJuIDA7
Cj4gICAKPiBAQCAtMjM3NCwxMiArMjM3Nyw0OSBAQCBzdGF0aWMgaW50IF9fdmhvc3RfYWRkX3Vz
ZWRfbihzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2cSwKPiAgIAkJCSAgICB1bnNpZ25lZCBjb3Vu
dCkKPiAgIHsKPiAgIAl2cmluZ191c2VkX2VsZW1fdCBfX3VzZXIgKnVzZWQ7Cj4gKwlzdHJ1Y3Qg
dnJpbmdfZGVzYyBkZXNjOwo+ICAgCXUxNiBvbGQsIG5ldzsKPiAgIAlpbnQgc3RhcnQ7Cj4gKwlp
bnQgYmVnaW4sIGVuZCwgaTsKPiArCWludCBjb3B5X24gPSBjb3VudDsKPiArCj4gKwlpZiAodmhv
c3RfaGFzX2ZlYXR1cmUodnEsIFZJUlRJT19GX0lOX09SREVSKSkgewoKCkhvdyBkbyB5b3UgZ3Vh
cmFudGVlIHRoYXQgaWRzIG9mIGhlYWRzIGFyZSBjb250aWd1b3VzPwoKCj4gKwkJLyogY2FsY3Vs
YXRlIGRlc2NyaXB0b3IgY2hhaW4gbGVuZ3RoIGZvciBlYWNoIHVzZWQgYnVmZmVyICovCgoKSSdt
IGEgbGl0dGxlIGJpdCBjb25mdXNlZCBhYm91dCB0aGlzIGNvbW1lbnQsIHdlIGhhdmUgaGVhZHNb
aV0ubGVuIGZvciB0aGlzPwoKCj4gKwkJZm9yIChpID0gMDsgaSA8IGNvdW50OyBpKyspIHsKPiAr
CQkJYmVnaW4gPSBoZWFkc1tpXS5pZDsKPiArCQkJZW5kID0gYmVnaW47Cj4gKwkJCXZxLT5oZWFk
c1tiZWdpbl0ubGVuID0gMDsKCgpEb2VzIHRoaXMgd29yayBmb3IgZS5nIFJYIHZpcnRxdWV1ZT8K
Cgo+ICsJCQlkbyB7Cj4gKwkJCQl2cS0+aGVhZHNbYmVnaW5dLmxlbiArPSAxOwo+ICsJCQkJaWYg
KHVubGlrZWx5KHZob3N0X2dldF9kZXNjKHZxLCAmZGVzYywgZW5kKSkpIHsKCgpMZXQncyB0cnkg
aGFyZCB0byBhdm9pZCBtb3JlIHVzZXJzcGFjZSBjb3B5IGhlcmUsIGl0J3MgdGhlIHNvdXJjZSBv
ZiAKcGVyZm9ybWFuY2UgcmVncmVzc2lvbi4KClRoYW5rcwoKCj4gKwkJCQkJdnFfZXJyKHZxLCAi
RmFpbGVkIHRvIGdldCBkZXNjcmlwdG9yOiBpZHggJWQgYWRkciAlcFxuIiwKPiArCQkJCQkgICAg
ICAgZW5kLCB2cS0+ZGVzYyArIGVuZCk7Cj4gKwkJCQkJcmV0dXJuIC1FRkFVTFQ7Cj4gKwkJCQl9
Cj4gKwkJCX0gd2hpbGUgKChlbmQgPSBuZXh0X2Rlc2ModnEsICZkZXNjKSkgIT0gLTEpOwo+ICsJ
CX0KPiArCj4gKwkJY291bnQgPSAwOwo+ICsJCS8qIHNvcnQgYW5kIGJhdGNoIGNvbnRpbnVvdXMg
dXNlZCByaW5nIGVudHJ5ICovCj4gKwkJd2hpbGUgKHZxLT5oZWFkc1t2cS0+bmV4dF91c2VkX2hl
YWRfaWR4XS5sZW4gIT0gMCkgewo+ICsJCQljb3VudCsrOwo+ICsJCQlpID0gdnEtPm5leHRfdXNl
ZF9oZWFkX2lkeDsKPiArCQkJdnEtPm5leHRfdXNlZF9oZWFkX2lkeCA9ICh2cS0+bmV4dF91c2Vk
X2hlYWRfaWR4ICsKPiArCQkJCQkJICB2cS0+aGVhZHNbdnEtPm5leHRfdXNlZF9oZWFkX2lkeF0u
bGVuKQo+ICsJCQkJCQkgICUgdnEtPm51bTsKPiArCQkJdnEtPmhlYWRzW2ldLmxlbiA9IDA7Cj4g
KwkJfQo+ICsJCS8qIG9ubHkgd3JpdGUgb3V0IGEgc2luZ2xlIHVzZWQgcmluZyBlbnRyeSB3aXRo
IHRoZSBpZCBjb3JyZXNwb25kaW5nCj4gKwkJICogdG8gdGhlIGhlYWQgZW50cnkgb2YgdGhlIGRl
c2NyaXB0b3IgY2hhaW4gZGVzY3JpYmluZyB0aGUgbGFzdCBidWZmZXIKPiArCQkgKiBpbiB0aGUg
YmF0Y2guCj4gKwkJICovCj4gKwkJaGVhZHNbMF0uaWQgPSBpOwo+ICsJCWNvcHlfbiA9IDE7Cj4g
Kwl9Cj4gICAKPiAgIAlzdGFydCA9IHZxLT5sYXN0X3VzZWRfaWR4ICYgKHZxLT5udW0gLSAxKTsK
PiAgIAl1c2VkID0gdnEtPnVzZWQtPnJpbmcgKyBzdGFydDsKPiAtCWlmICh2aG9zdF9wdXRfdXNl
ZCh2cSwgaGVhZHMsIHN0YXJ0LCBjb3VudCkpIHsKPiArCWlmICh2aG9zdF9wdXRfdXNlZCh2cSwg
aGVhZHMsIHN0YXJ0LCBjb3B5X24pKSB7Cj4gICAJCXZxX2Vycih2cSwgIkZhaWxlZCB0byB3cml0
ZSB1c2VkIik7Cj4gICAJCXJldHVybiAtRUZBVUxUOwo+ICAgCX0KPiBAQCAtMjQxMCw3ICsyNDUw
LDcgQEAgaW50IHZob3N0X2FkZF91c2VkX24oc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEsIHN0
cnVjdCB2cmluZ191c2VkX2VsZW0gKmhlYWRzLAo+ICAgCj4gICAJc3RhcnQgPSB2cS0+bGFzdF91
c2VkX2lkeCAmICh2cS0+bnVtIC0gMSk7Cj4gICAJbiA9IHZxLT5udW0gLSBzdGFydDsKPiAtCWlm
IChuIDwgY291bnQpIHsKPiArCWlmIChuIDwgY291bnQgJiYgIXZob3N0X2hhc19mZWF0dXJlKHZx
LCBWSVJUSU9fRl9JTl9PUkRFUikpIHsKPiAgIAkJciA9IF9fdmhvc3RfYWRkX3VzZWRfbih2cSwg
aGVhZHMsIG4pOwo+ICAgCQlpZiAociA8IDApCj4gICAJCQlyZXR1cm4gcjsKPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aG9zdC92aG9zdC5oIGIvZHJpdmVycy92aG9zdC92aG9zdC5oCj4gaW5kZXgg
ZDkxMDkxMDdhLi43YjJjMGZiYjUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5o
Cj4gKysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5oCj4gQEAgLTEwNyw2ICsxMDcsOSBAQCBzdHJ1
Y3Qgdmhvc3RfdmlydHF1ZXVlIHsKPiAgIAlib29sIGxvZ191c2VkOwo+ICAgCXU2NCBsb2dfYWRk
cjsKPiAgIAo+ICsJLyogU29ydCBoZWFkcyBpbiBvcmRlciAqLwo+ICsJdTE2IG5leHRfdXNlZF9o
ZWFkX2lkeDsKPiArCj4gICAJc3RydWN0IGlvdmVjIGlvdltVSU9fTUFYSU9WXTsKPiAgIAlzdHJ1
Y3QgaW92ZWMgaW90bGJfaW92WzY0XTsKPiAgIAlzdHJ1Y3QgaW92ZWMgKmluZGlyZWN0OwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
