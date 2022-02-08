Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDD8C433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 08:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 306B160D61;
	Tue,  8 Feb 2022 08:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NuOcOBUmLOoF; Tue,  8 Feb 2022 08:25:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B4AFB60C34;
	Tue,  8 Feb 2022 08:25:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83BFFC001A;
	Tue,  8 Feb 2022 08:25:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF401C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA27B4018D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:25:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tTfS2tA0qgeZ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:25:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49B7840112
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644308750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OvZ3skWvcjwQCHC15ak56nu4PuC+lnsPOhP5C4s3ZEQ=;
 b=PReXTkLpVrVLe/dSd0tGNz+z5vUUR31zJwM2Kq1YMoVand/kQY/guBblefeVYnZ+oYkRFH
 C4yiApaijkGoFD0+86jQuicvb9iNshcRHaVbWkwg709t67EvtOJWeaDdqak2ua9j/YyBrk
 GfmlHTxXzmbGzB/8ahAXXJGLeMJWEsA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-M-WswAyEPpOTNX9D5n5lXw-1; Tue, 08 Feb 2022 03:25:49 -0500
X-MC-Unique: M-WswAyEPpOTNX9D5n5lXw-1
Received: by mail-pl1-f200.google.com with SMTP id
 q4-20020a170902f78400b0014d57696618so3257414pln.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 00:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=OvZ3skWvcjwQCHC15ak56nu4PuC+lnsPOhP5C4s3ZEQ=;
 b=3mVHkJKQg8deaCrTTBmEvdCF0LMfXZHBkaLkzSmSiBEm3aEnz7iwFOGf0etNST9W5V
 EbpUAleVX2bcBNejK1c9J17ZXgqaSemgML5quuNKVknxsqpa1rTshbtgm/6ICtuLVCFh
 fdwDrp1SMKMuJhP4JcoQ4FxS7/fdPOsw0i1kO6d7JZWfjq8c5rgkfQONNeSPsGs68/Tw
 uZmPGnkI6M4yp3qSpzozMbLtyuw5InitA8oRD/lhrCcBotqr+B22Qg1Y21fuxvSbZLJS
 iVCWL2OvOFiNEdkYlOJWs9vea92UaC99ly4+9mqwVcq5Uq8t8ByFwFDl8P/OZhEyreab
 ipog==
X-Gm-Message-State: AOAM532zEGAMg7wShqBfomyXJzUM+Be7gqZkzhxux+gWEx3T84yIzrEN
 MWAfGKVV6Bo0gfjasiUwTWvd80varUDsDMOSEe7SE6kANq9jb4rynS7Nfuiem23lMjcNtrz3q4/
 YL+zGTCFKmu1U6tqN2IUCOvTFy1TPlMa5cZiCZUZpmQ==
X-Received: by 2002:a05:6a00:b50:: with SMTP id
 p16mr2791038pfo.22.1644308748543; 
 Tue, 08 Feb 2022 00:25:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNJH3HAOFTtxMQIz2wdXElKxle89R+EYAzwlYVtcwK6gFzJuV3MpgT0r+gpjqe4DAUryDZVw==
X-Received: by 2002:a05:6a00:b50:: with SMTP id
 p16mr2790999pfo.22.1644308748233; 
 Tue, 08 Feb 2022 00:25:48 -0800 (PST)
Received: from [10.72.13.12] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z22sm14828788pfe.42.2022.02.08.00.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Feb 2022 00:25:47 -0800 (PST)
Message-ID: <9b32f664-56a9-3718-cf48-49003f87d430@redhat.com>
Date: Tue, 8 Feb 2022 16:25:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 28/31] vdpa: Expose VHOST_F_LOG_ALL on SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-29-eperezma@redhat.com>
 <42664143-6d0c-b107-ec90-8e6336bae29b@redhat.com>
 <CAJaqyWdBLU+maEhByepzeH7iwLmqUba0rRb8PM4VwBy2P8Vtow@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWdBLU+maEhByepzeH7iwLmqUba0rRb8PM4VwBy2P8Vtow@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Blake <eblake@redhat.com>
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

CuWcqCAyMDIyLzIvMSDkuIvljYg3OjQ1LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6Cj4g
T24gU3VuLCBKYW4gMzAsIDIwMjIgYXQgNzo1MCBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4KPj4g5ZyoIDIwMjIvMS8yMiDkuIrljYg0OjI3LCBFdWdlbmlvIFDD
qXJleiDlhpnpgZM6Cj4+PiBTVlEgaXMgYWJsZSB0byBsb2cgdGhlIGRpcnR5IGJpdHMgYnkgaXRz
ZWxmLCBzbyBsZXQncyB1c2UgaXQgdG8gbm90Cj4+PiBibG9jayBtaWdyYXRpb24uCj4+Pgo+Pj4g
QWxzbywgaWdub3JlIHNldCBhbmQgY2xlYXIgb2YgVkhPU1RfRl9MT0dfQUxMIG9uIHNldF9mZWF0
dXJlcyBpZiBTVlEgaXMKPj4+IGVuYWJsZWQuIEV2ZW4gaWYgdGhlIGRldmljZSBzdXBwb3J0cyBp
dCwgdGhlIHJlcG9ydHMgd291bGQgYmUgbm9uc2Vuc2UKPj4+IGJlY2F1c2UgU1ZRIG1lbW9yeSBp
cyBpbiB0aGUgcWVtdSByZWdpb24uCj4+Pgo+Pj4gVGhlIGxvZyByZWdpb24gaXMgc3RpbGwgYWxs
b2NhdGVkLiBGdXR1cmUgY2hhbmdlcyBtaWdodCBza2lwIHRoYXQsIGJ1dAo+Pj4gdGhpcyBzZXJp
ZXMgaXMgYWxyZWFkeSBsb25nIGVub3VnaC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlv
IFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPj4+IC0tLQo+Pj4gICAgaHcvdmlydGlvL3Zo
b3N0LXZkcGEuYyB8IDIwICsrKysrKysrKysrKysrKysrKysrCj4+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgMjAgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qt
dmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+Pj4gaW5kZXggZmIwYTMzOGJhYS4uNzUw
OTBkNjVlOCAxMDA2NDQKPj4+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPj4+ICsrKyBi
L2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPj4+IEBAIC0xMDIyLDYgKzEwMjIsOSBAQCBzdGF0aWMg
aW50IHZob3N0X3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdWludDY0
X3QgKmZlYXR1cmVzKQo+Pj4gICAgICAgIGlmIChyZXQgPT0gMCAmJiB2LT5zaGFkb3dfdnFzX2Vu
YWJsZWQpIHsKPj4+ICAgICAgICAgICAgLyogRmlsdGVyIG9ubHkgZmVhdHVyZXMgdGhhdCBTVlEg
Y2FuIG9mZmVyIHRvIGd1ZXN0ICovCj4+PiAgICAgICAgICAgIHZob3N0X3N2cV92YWxpZF9ndWVz
dF9mZWF0dXJlcyhmZWF0dXJlcyk7Cj4+PiArCj4+PiArICAgICAgICAvKiBBZGQgU1ZRIGxvZ2dp
bmcgY2FwYWJpbGl0aWVzICovCj4+PiArICAgICAgICAqZmVhdHVyZXMgfD0gQklUX1VMTChWSE9T
VF9GX0xPR19BTEwpOwo+Pj4gICAgICAgIH0KPj4+Cj4+PiAgICAgICAgcmV0dXJuIHJldDsKPj4+
IEBAIC0xMDM5LDggKzEwNDIsMjUgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF9mZWF0dXJl
cyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4+Pgo+Pj4gICAgICAgIGlmICh2LT5zaGFkb3dfdnFz
X2VuYWJsZWQpIHsKPj4+ICAgICAgICAgICAgdWludDY0X3QgZGV2X2ZlYXR1cmVzLCBzdnFfZmVh
dHVyZXMsIGFja2VkX2ZlYXR1cmVzOwo+Pj4gKyAgICAgICAgdWludDhfdCBzdGF0dXMgPSAwOwo+
Pj4gICAgICAgICAgICBib29sIG9rOwo+Pj4KPj4+ICsgICAgICAgIHJldCA9IHZob3N0X3ZkcGFf
Y2FsbChkZXYsIFZIT1NUX1ZEUEFfR0VUX1NUQVRVUywgJnN0YXR1cyk7Cj4+PiArICAgICAgICBp
ZiAodW5saWtlbHkocmV0KSkgewo+Pj4gKyAgICAgICAgICAgIHJldHVybiByZXQ7Cj4+PiArICAg
ICAgICB9Cj4+PiArCj4+PiArICAgICAgICBpZiAoc3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RS
SVZFUl9PSykgewo+Pj4gKyAgICAgICAgICAgIC8qCj4+PiArICAgICAgICAgICAgICogdmhvc3Qg
aXMgdHJ5aW5nIHRvIGVuYWJsZSBvciBkaXNhYmxlIF9GX0xPRywgYW5kIHRoZSBkZXZpY2UKPj4+
ICsgICAgICAgICAgICAgKiB3b3VsZCByZXBvcnQgd3JvbmcgZGlydHkgcGFnZXMuIFNWUSBoYW5k
bGVzIGl0Lgo+Pj4gKyAgICAgICAgICAgICAqLwo+Pgo+PiBJIGZhaWwgdG8gdW5kZXJzdGFuZCB0
aGlzIGNvbW1lbnQsIEknZCB0aGluayB0aGVyZSdzIG5vIHdheSB0byBkaXNhYmxlCj4+IGRpcnR5
IHBhZ2UgdHJhY2tpbmcgZm9yIFNWUS4KPj4KPiB2aG9zdF9sb2dfZ2xvYmFsX3tzdGFydCxzdG9w
fSBhcmUgY2FsbGVkIGF0IHRoZSBiZWdpbm5pbmcgYW5kIGVuZCBvZgo+IG1pZ3JhdGlvbi4gVG8g
aW5mb3JtIHRoZSBkZXZpY2UgdGhhdCBpdCBzaG91bGQgc3RhcnQgbG9nZ2luZywgdGhleSBzZXQK
PiBvciBjbGVhbiBWSE9TVF9GX0xPR19BTEwgYXQgdmhvc3RfZGV2X3NldF9sb2cuCgoKWWVzLCBi
dXQgZm9yIFNWUSwgd2UgY2FuJ3QgZGlzYWJsZSBkaXJ0eSBwYWdlIHRyYWNraW5nLCBpc24ndCBp
dD8gVGhlIApvbmx5IHRoaW5nIGlzIHRvIGlnbm9yZSBvciBmaWx0ZXIgb3V0IHRoZSBGX0xPR19B
TEwgYW5kIHByZXRlbmQgdG8gYmUgCmVuYWJsZWQgYW5kIGRpc2FibGVkLgoKCj4KPiBXaGlsZSBT
VlEgZG9lcyBub3QgdXNlIFZIT1NUX0ZfTE9HX0FMTCwgaXQgZXhwb3J0cyB0aGUgZmVhdHVyZSBi
aXQgc28KPiB2aG9zdCBkb2VzIG5vdCBibG9jayBtaWdyYXRpb24uIE1heWJlIHdlIG5lZWQgdG8g
bG9vayBmb3IgYW5vdGhlciB3YXkKPiB0byBkbyB0aGlzPwoKCkknbSBmaW5lIHdpdGggZmlsdGVy
aW5nIHNpbmNlIGl0J3MgbXVjaCBtb3JlIHNpbXBsZXIsIGJ1dCBJIGZhaWwgdG8gCnVuZGVyc3Rh
bmQgd2h5IHdlIG5lZWQgdG8gY2hlY2sgRFJJVkVSX09LLgoKVGhhbmtzCgoKPgo+IFRoYW5rcyEK
Pgo+PiBUaGFua3MKPj4KPj4KPj4+ICsgICAgICAgICAgICByZXR1cm4gMDsKPj4+ICsgICAgICAg
IH0KPj4+ICsKPj4+ICsgICAgICAgIC8qIFdlIG11c3Qgbm90IGFjayBfRl9MT0cgaWYgU1ZRIGlz
IGVuYWJsZWQgKi8KPj4+ICsgICAgICAgIGZlYXR1cmVzICY9IH5CSVRfVUxMKFZIT1NUX0ZfTE9H
X0FMTCk7Cj4+PiArCj4+PiAgICAgICAgICAgIHJldCA9IHZob3N0X3ZkcGFfZ2V0X2Rldl9mZWF0
dXJlcyhkZXYsICZkZXZfZmVhdHVyZXMpOwo+Pj4gICAgICAgICAgICBpZiAocmV0ICE9IDApIHsK
Pj4+ICAgICAgICAgICAgICAgIGVycm9yX3JlcG9ydCgiQ2FuJ3QgZ2V0IHZkcGEgZGV2aWNlIGZl
YXR1cmVzLCBnb3QgKCVkKSIsIHJldCk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
