Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E559EC433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 03:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 924B060E7F;
	Tue,  8 Feb 2022 03:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lD-kKpqdKW2H; Tue,  8 Feb 2022 03:58:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2DCDC60C01;
	Tue,  8 Feb 2022 03:58:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1150BC0011;
	Tue,  8 Feb 2022 03:58:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9B3AC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C431660C01
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nnHJmYC7HGZh
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:58:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7F0860A9C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644292692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z71Y7mAci7WudsLVnnxS6ExjSgl5fpuaW6hKF3XF864=;
 b=B1bhKauUzxHCytozfpjFhKC5vIKS3EtOtqwQRXiXmc4ye8j3cVF5rDe/8svgnf88YylOa8
 OANFxO/ajdmG1vjdIZJCCuIBo7d5+OZurjkMR2w8RRjVL9vXMIZybYw/U88jdt2CLRR7NX
 6worfdkW0bK1P5EjfB+sGl8w3/XZDe4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-FK7pDjGBOjWlWg_QkecGNg-1; Mon, 07 Feb 2022 22:58:09 -0500
X-MC-Unique: FK7pDjGBOjWlWg_QkecGNg-1
Received: by mail-pl1-f200.google.com with SMTP id
 w3-20020a170902a70300b0014cced44ad7so6618162plq.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Feb 2022 19:58:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Z71Y7mAci7WudsLVnnxS6ExjSgl5fpuaW6hKF3XF864=;
 b=lY1li4uWnKL9NfBQPDqLLHBXnmlSbKa8y3gKzG1G0hHF3fx03tzJpB8bcr2RnZzsQT
 8E4mtf/hyBi0ubrPmwiY2YPRkCGY2QSwWn3CjFOLFcE4p3BUstDZ0NWXX1gsiKjN5y55
 D1J0Ka9LYgDGIqw2S3nS7khnM9PV3yYz5lCDeJrDHz3bPobYaEwSCqY/1QNP3YKZ6IPE
 huvdPzeCPdx4CI4QN6ppKBHHniyq34U/bBKpQFA7qY0U1MjpF4UZtNDXSg7wAe+fRBfc
 IjdKiW7kWN+yB0hytnSczyez+wDwHabyO9u97Q3OFL6CW0ZD/3uDCIg9TW4d+7f7tb6D
 Wlkw==
X-Gm-Message-State: AOAM533/8wCSiv8rWHRsKju/RBV2npIucXS3HAyT38X2+iQ7UdGrQxRw
 c3smCs7nvjjkTb1TT8wULkmGkb5Z3oDKqJ90cLJ0ffYNcdWzlaKPQjjDvCgaFI14Q5aoLJGrD5E
 EsTsQGiQ977ZdW6yO0vjRPf8CQmnCzf/5vITyU1BxQg==
X-Received: by 2002:a63:2c16:: with SMTP id s22mr2009671pgs.297.1644292688473; 
 Mon, 07 Feb 2022 19:58:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9JwQP0iEEay3cftKFLYNY8OLGJatgqmLrrsOZtTmMke6ErdSkHREjsziUdiSnxxmUEIILNw==
X-Received: by 2002:a63:2c16:: with SMTP id s22mr2009642pgs.297.1644292688200; 
 Mon, 07 Feb 2022 19:58:08 -0800 (PST)
Received: from [10.72.13.233] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h5sm14053164pfi.111.2022.02.07.19.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Feb 2022 19:58:07 -0800 (PST)
Message-ID: <3d0dfaaa-a67c-6f48-fd03-45d2661ba92a@redhat.com>
Date: Tue, 8 Feb 2022 11:57:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 17/31] vdpa: adapt vhost_ops callbacks to svq
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-18-eperezma@redhat.com>
 <82b8c3bf-1b11-86c7-4fad-294f5ccf1278@redhat.com>
 <CAJaqyWdRKZp6CwnE+HAr0JALhSRh-trJbZ01kddnLTuRX_tMKQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWdRKZp6CwnE+HAr0JALhSRh-trJbZ01kddnLTuRX_tMKQ@mail.gmail.com>
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

CuWcqCAyMDIyLzIvMSDkuIrljYgyOjU4LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6Cj4g
T24gU3VuLCBKYW4gMzAsIDIwMjIgYXQgNTowMyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4KPj4g5ZyoIDIwMjIvMS8yMiDkuIrljYg0OjI3LCBFdWdlbmlvIFDD
qXJleiDlhpnpgZM6Cj4+PiBGaXJzdCBoYWxmIG9mIHRoZSBidWZmZXJzIGZvcndhcmRpbmcgcGFy
dCwgcHJlcGFyaW5nIHZob3N0LXZkcGEKPj4+IGNhbGxiYWNrcyB0byBTVlEgdG8gb2ZmZXIgaXQu
IFFFTVUgY2Fubm90IGVuYWJsZSBpdCBhdCB0aGlzIG1vbWVudCwgc28KPj4+IHRoaXMgaXMgZWZm
ZWN0aXZlbHkgZGVhZCBjb2RlIGF0IHRoZSBtb21lbnQsIGJ1dCBpdCBoZWxwcyB0byByZWR1Y2UK
Pj4+IHBhdGNoIHNpemUuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVw
ZXJlem1hQHJlZGhhdC5jb20+Cj4+PiAtLS0KPj4+ICAgIGh3L3ZpcnRpby92aG9zdC1zaGFkb3ct
dmlydHF1ZXVlLmggfCAgIDIgKy0KPj4+ICAgIGh3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1
ZXVlLmMgfCAgMjEgKysrKy0KPj4+ICAgIGh3L3ZpcnRpby92aG9zdC12ZHBhLmMgICAgICAgICAg
ICAgfCAxMzMgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0KPj4+ICAgIDMgZmlsZXMgY2hh
bmdlZCwgMTQzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1n
aXQgYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oIGIvaHcvdmlydGlvL3Zob3N0
LXNoYWRvdy12aXJ0cXVldWUuaAo+Pj4gaW5kZXggMDM1MjA3YTQ2OS4uMzlhZWY1ZmZkZiAxMDA2
NDQKPj4+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmgKPj4+ICsrKyBi
L2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmgKPj4+IEBAIC0zNSw3ICszNSw3IEBA
IHNpemVfdCB2aG9zdF9zdnFfZGV2aWNlX2FyZWFfc2l6ZShjb25zdCBWaG9zdFNoYWRvd1ZpcnRx
dWV1ZSAqc3ZxKTsKPj4+Cj4+PiAgICB2b2lkIHZob3N0X3N2cV9zdG9wKFZob3N0U2hhZG93Vmly
dHF1ZXVlICpzdnEpOwo+Pj4KPj4+IC1WaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqdmhvc3Rfc3ZxX25l
dyh2b2lkKTsKPj4+ICtWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqdmhvc3Rfc3ZxX25ldyh1aW50MTZf
dCBxc2l6ZSk7Cj4+Pgo+Pj4gICAgdm9pZCB2aG9zdF9zdnFfZnJlZShWaG9zdFNoYWRvd1ZpcnRx
dWV1ZSAqdnEpOwo+Pj4KPj4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZp
cnRxdWV1ZS5jIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+Pj4gaW5kZXgg
ZjEyOWVjODM5NS4uN2MxNjgwNzVkNyAxMDA2NDQKPj4+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC1z
aGFkb3ctdmlydHF1ZXVlLmMKPj4+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1
ZXVlLmMKPj4+IEBAIC0yNzcsOSArMjc3LDE3IEBAIHZvaWQgdmhvc3Rfc3ZxX3N0b3AoVmhvc3RT
aGFkb3dWaXJ0cXVldWUgKnN2cSkKPj4+ICAgIC8qKgo+Pj4gICAgICogQ3JlYXRlcyB2aG9zdCBz
aGFkb3cgdmlydHF1ZXVlLCBhbmQgaW5zdHJ1Y3Qgdmhvc3QgZGV2aWNlIHRvIHVzZSB0aGUgc2hh
ZG93Cj4+PiAgICAgKiBtZXRob2RzIGFuZCBmaWxlIGRlc2NyaXB0b3JzLgo+Pj4gKyAqCj4+PiAr
ICogQHFzaXplIFNoYWRvdyBWaXJ0UXVldWUgc2l6ZQo+Pj4gKyAqCj4+PiArICogUmV0dXJucyB0
aGUgbmV3IHZpcnRxdWV1ZSBvciBOVUxMLgo+Pj4gKyAqCj4+PiArICogSW4gY2FzZSBvZiBlcnJv
ciwgcmVhc29uIGlzIHJlcG9ydGVkIHRocm91Z2ggZXJyb3JfcmVwb3J0Lgo+Pj4gICAgICovCj4+
PiAtVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnZob3N0X3N2cV9uZXcodm9pZCkKPj4+ICtWaG9zdFNo
YWRvd1ZpcnRxdWV1ZSAqdmhvc3Rfc3ZxX25ldyh1aW50MTZfdCBxc2l6ZSkKPj4+ICAgIHsKPj4+
ICsgICAgc2l6ZV90IGRlc2Nfc2l6ZSA9IHNpemVvZih2cmluZ19kZXNjX3QpICogcXNpemU7Cj4+
PiArICAgIHNpemVfdCBkZXZpY2Vfc2l6ZSwgZHJpdmVyX3NpemU7Cj4+PiAgICAgICAgZ19hdXRv
ZnJlZSBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxID0gZ19uZXcwKFZob3N0U2hhZG93VmlydHF1
ZXVlLCAxKTsKPj4+ICAgICAgICBpbnQgcjsKPj4+Cj4+PiBAQCAtMzAwLDYgKzMwOCwxNSBAQCBW
aG9zdFNoYWRvd1ZpcnRxdWV1ZSAqdmhvc3Rfc3ZxX25ldyh2b2lkKQo+Pj4gICAgICAgIC8qIFBs
YWNlaG9sZGVyIGRlc2NyaXB0b3IsIGl0IHNob3VsZCBiZSBkZWxldGVkIGF0IHNldF9raWNrX2Zk
ICovCj4+PiAgICAgICAgZXZlbnRfbm90aWZpZXJfaW5pdF9mZCgmc3ZxLT5zdnFfa2ljaywgSU5W
QUxJRF9TVlFfS0lDS19GRCk7Cj4+Pgo+Pj4gKyAgICBzdnEtPnZyaW5nLm51bSA9IHFzaXplOwo+
Pgo+PiBJIHdvbmRlciBpZiB0aGlzIGlzIHRoZSBiZXN0LiBFLmcgc29tZSBoYXJkd2FyZSBjYW4g
c3VwcG9ydCB1cCB0byAzMksKPj4gcXVldWUgc2l6ZS4gU28gdGhpcyB3aWxsIHByb2JhYmx5IGVu
ZCB1cCB3aXRoOgo+Pgo+PiAxKSBTVlEgdXNlIDMySyBxdWV1ZSBzaXplCj4+IDIpIGhhcmR3YXJl
IHF1ZXVlIHVzZXMgMjU2Cj4+Cj4gSW4gdGhhdCBjYXNlIFNWUSB2cmluZyBxdWV1ZSBzaXplIHdp
bGwgYmUgMzJLIGFuZCBndWVzdCdzIHZyaW5nIGNhbgo+IG5lZ290aWF0ZSBhbnkgbnVtYmVyIHdp
dGggU1ZRIGVxdWFsIG9yIGxlc3MgdGhhbiAzMkssCgoKU29ycnkgZm9yIGJlaW5nIHVuY2xlYXIg
d2hhdCBJIG1lYW50IGlzIGFjdHVhbGx5CgoxKSBTVlEgdXNlcyAzMksgcXVldWUgc2l6ZQoKMikg
Z3Vlc3QgdnEgdXNlcyAyNTYKClRoaXMgbG9va3MgbGlrZSBhIGJ1cmRlbiB0aGF0IG5lZWRzIGV4
dHJhIGxvZ2ljIGFuZCBtYXkgZGFtYWdlIHRoZSAKcGVyZm9ybWFuY2UuCgpBbmQgdGhpcyBjYW4g
bGVhZCBvdGhlciBpbnRlcmVzdGluZyBzaXR1YXRpb246CgoxKSBTVlEgdXNlcyAyNTYKCjIpIGd1
ZXN0IHZxIHVzZXMgMTAyNAoKV2hlcmUgYSBsb3Qgb2YgbW9yZSBTVlEgbG9naWMgaXMgbmVlZGVk
LgoKCj4gaW5jbHVkaW5nIDI1Ni4KPiBJcyB0aGF0IHdoYXQgeW91IG1lYW4/CgoKSSBtZWFuLCBp
dCBsb29rcyB0byBtZSB0aGUgbG9naWMgd2lsbCBiZSBtdWNoIG1vcmUgc2ltcGxpZmllZCBpZiB3
ZSBqdXN0IAphbGxvY2F0ZSB0aGUgc2hhZG93IHZpcnRxdWV1ZSB3aXRoIHRoZSBzaXplIHdoYXQg
Z3Vlc3QgY2FuIHNlZSAoZ3Vlc3QgCnZyaW5nKS4KClRoZW4gd2UgZG9uJ3QgbmVlZCB0byB0aGlu
ayBpZiB0aGUgZGlmZmVyZW5jZSBvZiB0aGUgcXVldWUgc2l6ZSBjYW4gaGF2ZSAKYW55IHNpZGUg
ZWZmZWN0cy4KCgo+Cj4gSWYgd2l0aCBoYXJkd2FyZSBxdWV1ZXMgeW91IG1lYW4gZ3Vlc3QncyB2
cmluZywgbm90IHN1cmUgd2h5IGl0IGlzCj4gInByb2JhYmx5IDI1NiIuIEknZCBzYXkgdGhhdCBp
biB0aGF0IGNhc2Ugd2l0aCB0aGUgdmlydGlvLW5ldCBrZXJuZWwKPiBkcml2ZXIgdGhlIHJpbmcg
c2l6ZSB3aWxsIGJlIHRoZSBzYW1lIGFzIHRoZSBkZXZpY2UgZXhwb3J0LCBmb3IKPiBleGFtcGxl
LCBpc24ndCBpdD8KPgo+IFRoZSBpbXBsZW1lbnRhdGlvbiBzaG91bGQgc3VwcG9ydCBhbnkgY29t
YmluYXRpb24gb2Ygc2l6ZXMsIGJ1dCB0aGUKPiByaW5nIHNpemUgZXhwb3NlZCB0byB0aGUgZ3Vl
c3QgaXMgbmV2ZXIgYmlnZ2VyIHRoYW4gaGFyZHdhcmUgb25lLgo+Cj4+ID8gT3Igd2UgU1ZRIGNh
biBzdGljayB0byAyNTYgYnV0IHRoaXMgd2lsbCB0aGlzIGNhdXNlIHRyb3VibGUgaWYgd2Ugd2Fu
dAo+PiB0byBhZGQgZXZlbnQgaW5kZXggc3VwcG9ydD8KPj4KPiBJIHRoaW5rIHdlIHNob3VsZCBu
b3QgaGF2ZSBhbnkgcHJvYmxlbSB3aXRoIGV2ZW50IGlkeC4gSWYgeW91IG1lYW4KPiB0aGF0IHRo
ZSBndWVzdCBjb3VsZCBtYXJrIG1vcmUgYnVmZmVycyBhdmFpbGFibGUgdGhhbiBTVlEgdnJpbmcn
cwo+IHNpemUsIHRoYXQgc2hvdWxkIG5vdCBoYXBwZW4gYmVjYXVzZSB0aGVyZSBtdXN0IGJlIGxl
c3MgZW50cmllcyBpbiB0aGUKPiBndWVzdCB0aGFuIFNWUS4KPgo+IEJ1dCBpZiBJIHVuZGVyc3Rv
b2QgeW91IGNvcnJlY3RseSwgYSBzaW1pbGFyIHNpdHVhdGlvbiBjb3VsZCBoYXBwZW4gaWYKPiBh
IGd1ZXN0J3MgY29udGlndW91cyBidWZmZXIgaXMgc2NhdHRlcmVkIGFjcm9zcyBtYW55IHFlbXUn
cyBWQSBjaHVua3MuCj4gRXZlbiBpZiB0aGF0IHdvdWxkIGhhcHBlbiwgdGhlIHNpdHVhdGlvbiBz
aG91bGQgYmUgb2sgdG9vOiBTVlEga25vd3MKPiB0aGUgZ3Vlc3QncyBhdmFpbCBpZHggYW5kLCBp
ZiBTVlEgaXMgZnVsbCwgaXQgd2lsbCBjb250aW51ZSBmb3J3YXJkaW5nCj4gYXZhaWwgYnVmZmVy
cyB3aGVuIHRoZSBkZXZpY2UgdXNlcyBtb3JlIGJ1ZmZlcnMuCj4KPiBEb2VzIHRoYXQgbWFrZSBz
ZW5zZSB0byB5b3U/CgoKWWVzLgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
