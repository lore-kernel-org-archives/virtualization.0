Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95177C433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 07:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2BFBB40144;
	Mon, 21 Feb 2022 07:31:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id StQ-9TsmYLAE; Mon, 21 Feb 2022 07:31:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2EE7740242;
	Mon, 21 Feb 2022 07:31:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2994C0033;
	Mon, 21 Feb 2022 07:31:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B52BBC001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EC5981424
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:31:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ub_YaWNw_Uoz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:31:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7269D81421
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645428686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ahPHimZsQ2sv/IVieJaDo6Bj0pzBzI/VI/ciHrGoEo=;
 b=RO746LJrdvkZ+7MI8rkMUwTV1tYEGp9ot1uLO7/Q0X0p54V9fqaASxNUURav9xMy5pgOv/
 jO+BvLSD6Bds56idjAOxIii7ZBlNTMK9kg910zThoOlHuHSZEmnAdk69Gveu6XiMnC9TJE
 AGfDe/1ndA9Csnu5zJtYuIbZisjbHic=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-4mAfrE6LNNaT5lvgHHqxUg-1; Mon, 21 Feb 2022 02:31:22 -0500
X-MC-Unique: 4mAfrE6LNNaT5lvgHHqxUg-1
Received: by mail-pj1-f71.google.com with SMTP id
 mn16-20020a17090b189000b001bc2315d75cso3094935pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 23:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7ahPHimZsQ2sv/IVieJaDo6Bj0pzBzI/VI/ciHrGoEo=;
 b=1JLxqRKQqsuTtTQSU1xHxSvT0trdkDVlIBvNB3XowsGQhIE3wORG4AtY4dGy2T2taa
 lisB6CZoiHKBTigkHhH9gMPo6/QFhGQeDbS0XAcJU1mdWuD077SYQnRfLmPlTgwP5jTP
 ajZKpVPMQzNlJ66xaH2sr/XwyKaBkFOi7c0GYSHvInGzsvkOYDfqfxHnbFy9hek+/aCT
 BPucmESSCI+lQ5F28OE7Mwq2Y61h0yO7FVcjfqKE4g3T85cULK8C/NkJSDQqYlWeq/Ad
 JZBmU7MGlKJ7QHmwRF5QNNIp7N69o9W9wqgCqAvQ4b59Pu1s/4oBEVMpYiFQXR0bUthL
 SDlg==
X-Gm-Message-State: AOAM533Wpux8Ic2mIJY4v5BJlQ/IcQD32Kb2TuxoxFsgKx59lV9CblgQ
 1JAp5qpCdG2dlDLP9eqpHUghb4Uj1mpD5Z4zqg1dJkfhnEA06N/r4OWIGrson9P1J7cv1Wt/yiR
 C08vpeqv9qvvRrRQaWXuqrioxjUt10pTWuEMmDWqAOw==
X-Received: by 2002:a17:903:183:b0:14f:2e5:4a85 with SMTP id
 z3-20020a170903018300b0014f02e54a85mr18193463plg.45.1645428681687; 
 Sun, 20 Feb 2022 23:31:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxa4BJWNGemcwUU9bXy9x9QuxRP3jZOJRYubMBy7Z+6z48v6vBy3HLVUfIF7/G3XMZhnUzTA==
X-Received: by 2002:a17:903:183:b0:14f:2e5:4a85 with SMTP id
 z3-20020a170903018300b0014f02e54a85mr18193429plg.45.1645428681338; 
 Sun, 20 Feb 2022 23:31:21 -0800 (PST)
Received: from [10.72.12.96] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s5sm17545818pgo.37.2022.02.20.23.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Feb 2022 23:31:20 -0800 (PST)
Message-ID: <2de34fc2-3184-accb-6c3d-327d62cb330c@redhat.com>
Date: Mon, 21 Feb 2022 15:31:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH 01/31] vdpa: Reorder virtio/vhost-vdpa.c functions
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-2-eperezma@redhat.com>
 <bb5490a4-8fae-0cc8-56dd-0953a2b40922@redhat.com>
 <CAJaqyWffGzYv2+HufFZzzBPtu5z3_vaKh4evGXqj7hqTB0WU3A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWffGzYv2+HufFZzzBPtu5z3_vaKh4evGXqj7hqTB0WU3A@mail.gmail.com>
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

CuWcqCAyMDIyLzEvMjgg5LiL5Y2IMzo1NywgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+
IE9uIEZyaSwgSmFuIDI4LCAyMDIyIGF0IDY6NTkgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IOWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQ
w6lyZXog5YaZ6YGTOgo+Pj4gdmhvc3RfdmRwYV9zZXRfZmVhdHVyZXMgYW5kIHZob3N0X3ZkcGFf
aW5pdCBuZWVkIHRvIHVzZQo+Pj4gdmhvc3RfdmRwYV9nZXRfZmVhdHVyZXMgaW4gc3ZxIG1vZGUu
Cj4+Pgo+Pj4gdmhvc3RfdmRwYV9kZXZfc3RhcnQgbmVlZHMgdG8gdXNlIGFsbW9zdCBhbGwgX3Nl
dF8gZnVuY3Rpb25zOgo+Pj4gdmhvc3RfdmRwYV9zZXRfdnJpbmdfZGV2X2tpY2ssIHZob3N0X3Zk
cGFfc2V0X3ZyaW5nX2Rldl9jYWxsLAo+Pj4gdmhvc3RfdmRwYV9zZXRfZGV2X3ZyaW5nX2Jhc2Ug
YW5kIHZob3N0X3ZkcGFfc2V0X2Rldl92cmluZ19udW0uCj4+Pgo+Pj4gTm8gZnVuY3Rpb25hbCBj
aGFuZ2UgaW50ZW5kZWQuCj4+Cj4+IElzIGl0IHJlbGF0ZWQgKGEgbXVzdCkgdG8gdGhlIFNWUSBj
b2RlPwo+Pgo+IFllcywgU1ZRIG5lZWRzIHRvIGFjY2VzcyB0aGUgZGV2aWNlIHZhcmlhbnRzIHRv
IGNvbmZpZ3VyZSBpdCwgd2hpbGUKPiBleHBvc2luZyB0aGUgU1ZRIG9uZXMuCj4KPiBGb3IgZXhh
bXBsZSBmb3Igc2V0X2ZlYXR1cmVzLCBTVlEgbmVlZHMgdG8gc2V0IGRldmljZSBmZWF0dXJlcyBp
biB0aGUKPiBzdGFydCBjb2RlLCBidXQgZXhwb3NlIFNWUSBvbmVzIHRvIHRoZSBndWVzdC4KPgo+
IEFub3RoZXIgcG9zc2liaWxpdHkgaXMgdG8gZm9yd2FyZC1kZWNsYXJlIHRoZW0gYnV0IEkgZmVl
bCBpdCBwb2xsdXRlcwo+IHRoZSBjb2RlIG1vcmUsIGRvZXNuJ3QgaXQ/IElzIHRoZXJlIGFueSBy
ZWFzb24gdG8gYXZvaWQgdGhlIHJlb3JkZXJpbmcKPiBiZXlvbmQgcmVkdWNpbmcgdGhlIG51bWJl
ciBvZiBjaGFuZ2VzL3BhdGNoZXM/CgoKTm8sIGJ1dCBmb3IgcmV2aWV3ZXIsIGl0IG1pZ2h0IGJl
IGVhc2llciBpZiB5b3Ugc3F1YXNoIHRoZSByZW9yZGVyaW5nIApsb2dpYyBpbnRvIHRoZSBwYXRj
aCB3aGljaCBuZWVkcyB0aGF0LgoKVGhhbmtzCgoKPgo+IFRoYW5rcyEKPgo+Cj4+IFRoYW5rcwo+
Pgo+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5j
b20+Cj4+PiAtLS0KPj4+ICAgIGh3L3ZpcnRpby92aG9zdC12ZHBhLmMgfCAxNjQgKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA4
MiBpbnNlcnRpb25zKCspLCA4MiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvaHcv
dmlydGlvL3Zob3N0LXZkcGEuYyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPj4+IGluZGV4IDA0
ZWE0MzcwNGYuLjZjMTBhN2YwNWYgMTAwNjQ0Cj4+PiAtLS0gYS9ody92aXJ0aW8vdmhvc3QtdmRw
YS5jCj4+PiArKysgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4+PiBAQCAtMzQyLDQxICszNDIs
NiBAQCBzdGF0aWMgYm9vbCB2aG9zdF92ZHBhX29uZV90aW1lX3JlcXVlc3Qoc3RydWN0IHZob3N0
X2RldiAqZGV2KQo+Pj4gICAgICAgIHJldHVybiB2LT5pbmRleCAhPSAwOwo+Pj4gICAgfQo+Pj4K
Pj4+IC1zdGF0aWMgaW50IHZob3N0X3ZkcGFfaW5pdChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHZv
aWQgKm9wYXF1ZSwgRXJyb3IgKiplcnJwKQo+Pj4gLXsKPj4+IC0gICAgc3RydWN0IHZob3N0X3Zk
cGEgKnY7Cj4+PiAtICAgIGFzc2VydChkZXYtPnZob3N0X29wcy0+YmFja2VuZF90eXBlID09IFZI
T1NUX0JBQ0tFTkRfVFlQRV9WRFBBKTsKPj4+IC0gICAgdHJhY2Vfdmhvc3RfdmRwYV9pbml0KGRl
diwgb3BhcXVlKTsKPj4+IC0gICAgaW50IHJldDsKPj4+IC0KPj4+IC0gICAgLyoKPj4+IC0gICAg
ICogU2ltaWxhciB0byBWRklPLCB3ZSBlbmQgdXAgcGlubmluZyBhbGwgZ3Vlc3QgbWVtb3J5IGFu
ZCBoYXZlIHRvCj4+PiAtICAgICAqIGRpc2FibGUgZGlzY2FyZGluZyBvZiBSQU0uCj4+PiAtICAg
ICAqLwo+Pj4gLSAgICByZXQgPSByYW1fYmxvY2tfZGlzY2FyZF9kaXNhYmxlKHRydWUpOwo+Pj4g
LSAgICBpZiAocmV0KSB7Cj4+PiAtICAgICAgICBlcnJvcl9yZXBvcnQoIkNhbm5vdCBzZXQgZGlz
Y2FyZGluZyBvZiBSQU0gYnJva2VuIik7Cj4+PiAtICAgICAgICByZXR1cm4gcmV0Owo+Pj4gLSAg
ICB9Cj4+PiAtCj4+PiAtICAgIHYgPSBvcGFxdWU7Cj4+PiAtICAgIHYtPmRldiA9IGRldjsKPj4+
IC0gICAgZGV2LT5vcGFxdWUgPSAgb3BhcXVlIDsKPj4+IC0gICAgdi0+bGlzdGVuZXIgPSB2aG9z
dF92ZHBhX21lbW9yeV9saXN0ZW5lcjsKPj4+IC0gICAgdi0+bXNnX3R5cGUgPSBWSE9TVF9JT1RM
Ql9NU0dfVjI7Cj4+PiAtCj4+PiAtICAgIHZob3N0X3ZkcGFfZ2V0X2lvdmFfcmFuZ2Uodik7Cj4+
PiAtCj4+PiAtICAgIGlmICh2aG9zdF92ZHBhX29uZV90aW1lX3JlcXVlc3QoZGV2KSkgewo+Pj4g
LSAgICAgICAgcmV0dXJuIDA7Cj4+PiAtICAgIH0KPj4+IC0KPj4+IC0gICAgdmhvc3RfdmRwYV9h
ZGRfc3RhdHVzKGRldiwgVklSVElPX0NPTkZJR19TX0FDS05PV0xFREdFIHwKPj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgVklSVElPX0NPTkZJR19TX0RSSVZFUik7Cj4+PiAtCj4+
PiAtICAgIHJldHVybiAwOwo+Pj4gLX0KPj4+IC0KPj4+ICAgIHN0YXRpYyB2b2lkIHZob3N0X3Zk
cGFfaG9zdF9ub3RpZmllcl91bmluaXQoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgcXVldWVfaW5kZXgp
Cj4+PiAgICB7Cj4+PiBAQCAtNTA2LDI0ICs0NzEsNiBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFf
c2V0X21lbV90YWJsZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4+PiAgICAgICAgcmV0dXJuIDA7
Cj4+PiAgICB9Cj4+Pgo+Pj4gLXN0YXRpYyBpbnQgdmhvc3RfdmRwYV9zZXRfZmVhdHVyZXMoc3Ry
dWN0IHZob3N0X2RldiAqZGV2LAo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDY0X3QgZmVhdHVyZXMpCj4+PiAtewo+Pj4gLSAgICBpbnQgcmV0Owo+Pj4gLQo+Pj4g
LSAgICBpZiAodmhvc3RfdmRwYV9vbmVfdGltZV9yZXF1ZXN0KGRldikpIHsKPj4+IC0gICAgICAg
IHJldHVybiAwOwo+Pj4gLSAgICB9Cj4+PiAtCj4+PiAtICAgIHRyYWNlX3Zob3N0X3ZkcGFfc2V0
X2ZlYXR1cmVzKGRldiwgZmVhdHVyZXMpOwo+Pj4gLSAgICByZXQgPSB2aG9zdF92ZHBhX2NhbGwo
ZGV2LCBWSE9TVF9TRVRfRkVBVFVSRVMsICZmZWF0dXJlcyk7Cj4+PiAtICAgIGlmIChyZXQpIHsK
Pj4+IC0gICAgICAgIHJldHVybiByZXQ7Cj4+PiAtICAgIH0KPj4+IC0KPj4+IC0gICAgcmV0dXJu
IHZob3N0X3ZkcGFfYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19GRUFUVVJFU19PSyk7
Cj4+PiAtfQo+Pj4gLQo+Pj4gICAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF9iYWNrZW5kX2Nh
cChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4+PiAgICB7Cj4+PiAgICAgICAgdWludDY0X3QgZmVh
dHVyZXM7Cj4+PiBAQCAtNjQ2LDM1ICs1OTMsNiBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfZ2V0
X2NvbmZpZyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHVpbnQ4X3QgKmNvbmZpZywKPj4+ICAgICAg
ICByZXR1cm4gcmV0Owo+Pj4gICAgIH0KPj4+Cj4+PiAtc3RhdGljIGludCB2aG9zdF92ZHBhX2Rl
dl9zdGFydChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGJvb2wgc3RhcnRlZCkKPj4+IC17Cj4+PiAt
ICAgIHN0cnVjdCB2aG9zdF92ZHBhICp2ID0gZGV2LT5vcGFxdWU7Cj4+PiAtICAgIHRyYWNlX3Zo
b3N0X3ZkcGFfZGV2X3N0YXJ0KGRldiwgc3RhcnRlZCk7Cj4+PiAtCj4+PiAtICAgIGlmIChzdGFy
dGVkKSB7Cj4+PiAtICAgICAgICB2aG9zdF92ZHBhX2hvc3Rfbm90aWZpZXJzX2luaXQoZGV2KTsK
Pj4+IC0gICAgICAgIHZob3N0X3ZkcGFfc2V0X3ZyaW5nX3JlYWR5KGRldik7Cj4+PiAtICAgIH0g
ZWxzZSB7Cj4+PiAtICAgICAgICB2aG9zdF92ZHBhX2hvc3Rfbm90aWZpZXJzX3VuaW5pdChkZXYs
IGRldi0+bnZxcyk7Cj4+PiAtICAgIH0KPj4+IC0KPj4+IC0gICAgaWYgKGRldi0+dnFfaW5kZXgg
KyBkZXYtPm52cXMgIT0gZGV2LT52cV9pbmRleF9lbmQpIHsKPj4+IC0gICAgICAgIHJldHVybiAw
Owo+Pj4gLSAgICB9Cj4+PiAtCj4+PiAtICAgIGlmIChzdGFydGVkKSB7Cj4+PiAtICAgICAgICBt
ZW1vcnlfbGlzdGVuZXJfcmVnaXN0ZXIoJnYtPmxpc3RlbmVyLCAmYWRkcmVzc19zcGFjZV9tZW1v
cnkpOwo+Pj4gLSAgICAgICAgcmV0dXJuIHZob3N0X3ZkcGFfYWRkX3N0YXR1cyhkZXYsIFZJUlRJ
T19DT05GSUdfU19EUklWRVJfT0spOwo+Pj4gLSAgICB9IGVsc2Ugewo+Pj4gLSAgICAgICAgdmhv
c3RfdmRwYV9yZXNldF9kZXZpY2UoZGV2KTsKPj4+IC0gICAgICAgIHZob3N0X3ZkcGFfYWRkX3N0
YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19BQ0tOT1dMRURHRSB8Cj4+PiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fQ09ORklHX1NfRFJJVkVSKTsKPj4+IC0gICAg
ICAgIG1lbW9yeV9saXN0ZW5lcl91bnJlZ2lzdGVyKCZ2LT5saXN0ZW5lcik7Cj4+PiAtCj4+PiAt
ICAgICAgICByZXR1cm4gMDsKPj4+IC0gICAgfQo+Pj4gLX0KPj4+IC0KPj4+ICAgIHN0YXRpYyBp
bnQgdmhvc3RfdmRwYV9zZXRfbG9nX2Jhc2Uoc3RydWN0IHZob3N0X2RldiAqZGV2LCB1aW50NjRf
dCBiYXNlLAo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCB2aG9zdF9sb2cgKmxvZykKPj4+ICAgIHsKPj4+IEBAIC03MzUsNiArNjUzLDM1IEBAIHN0YXRp
YyBpbnQgdmhvc3RfdmRwYV9zZXRfdnJpbmdfY2FsbChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4+
PiAgICAgICAgcmV0dXJuIHZob3N0X3ZkcGFfY2FsbChkZXYsIFZIT1NUX1NFVF9WUklOR19DQUxM
LCBmaWxlKTsKPj4+ICAgIH0KPj4+Cj4+PiArc3RhdGljIGludCB2aG9zdF92ZHBhX2Rldl9zdGFy
dChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGJvb2wgc3RhcnRlZCkKPj4+ICt7Cj4+PiArICAgIHN0
cnVjdCB2aG9zdF92ZHBhICp2ID0gZGV2LT5vcGFxdWU7Cj4+PiArICAgIHRyYWNlX3Zob3N0X3Zk
cGFfZGV2X3N0YXJ0KGRldiwgc3RhcnRlZCk7Cj4+PiArCj4+PiArICAgIGlmIChzdGFydGVkKSB7
Cj4+PiArICAgICAgICB2aG9zdF92ZHBhX2hvc3Rfbm90aWZpZXJzX2luaXQoZGV2KTsKPj4+ICsg
ICAgICAgIHZob3N0X3ZkcGFfc2V0X3ZyaW5nX3JlYWR5KGRldik7Cj4+PiArICAgIH0gZWxzZSB7
Cj4+PiArICAgICAgICB2aG9zdF92ZHBhX2hvc3Rfbm90aWZpZXJzX3VuaW5pdChkZXYsIGRldi0+
bnZxcyk7Cj4+PiArICAgIH0KPj4+ICsKPj4+ICsgICAgaWYgKGRldi0+dnFfaW5kZXggKyBkZXYt
Pm52cXMgIT0gZGV2LT52cV9pbmRleF9lbmQpIHsKPj4+ICsgICAgICAgIHJldHVybiAwOwo+Pj4g
KyAgICB9Cj4+PiArCj4+PiArICAgIGlmIChzdGFydGVkKSB7Cj4+PiArICAgICAgICBtZW1vcnlf
bGlzdGVuZXJfcmVnaXN0ZXIoJnYtPmxpc3RlbmVyLCAmYWRkcmVzc19zcGFjZV9tZW1vcnkpOwo+
Pj4gKyAgICAgICAgcmV0dXJuIHZob3N0X3ZkcGFfYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05G
SUdfU19EUklWRVJfT0spOwo+Pj4gKyAgICB9IGVsc2Ugewo+Pj4gKyAgICAgICAgdmhvc3RfdmRw
YV9yZXNldF9kZXZpY2UoZGV2KTsKPj4+ICsgICAgICAgIHZob3N0X3ZkcGFfYWRkX3N0YXR1cyhk
ZXYsIFZJUlRJT19DT05GSUdfU19BQ0tOT1dMRURHRSB8Cj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBWSVJUSU9fQ09ORklHX1NfRFJJVkVSKTsKPj4+ICsgICAgICAgIG1l
bW9yeV9saXN0ZW5lcl91bnJlZ2lzdGVyKCZ2LT5saXN0ZW5lcik7Cj4+PiArCj4+PiArICAgICAg
ICByZXR1cm4gMDsKPj4+ICsgICAgfQo+Pj4gK30KPj4+ICsKPj4+ICAgIHN0YXRpYyBpbnQgdmhv
c3RfdmRwYV9nZXRfZmVhdHVyZXMoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+Pj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90ICpmZWF0dXJlcykKPj4+ICAg
IHsKPj4+IEBAIC03NDUsNiArNjkyLDI0IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9nZXRfZmVh
dHVyZXMoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+Pj4gICAgICAgIHJldHVybiByZXQ7Cj4+PiAg
ICB9Cj4+Pgo+Pj4gK3N0YXRpYyBpbnQgdmhvc3RfdmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZo
b3N0X2RldiAqZGV2LAo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDY0X3QgZmVhdHVyZXMpCj4+PiArewo+Pj4gKyAgICBpbnQgcmV0Owo+Pj4gKwo+Pj4gKyAgICBp
ZiAodmhvc3RfdmRwYV9vbmVfdGltZV9yZXF1ZXN0KGRldikpIHsKPj4+ICsgICAgICAgIHJldHVy
biAwOwo+Pj4gKyAgICB9Cj4+PiArCj4+PiArICAgIHRyYWNlX3Zob3N0X3ZkcGFfc2V0X2ZlYXR1
cmVzKGRldiwgZmVhdHVyZXMpOwo+Pj4gKyAgICByZXQgPSB2aG9zdF92ZHBhX2NhbGwoZGV2LCBW
SE9TVF9TRVRfRkVBVFVSRVMsICZmZWF0dXJlcyk7Cj4+PiArICAgIGlmIChyZXQpIHsKPj4+ICsg
ICAgICAgIHJldHVybiByZXQ7Cj4+PiArICAgIH0KPj4+ICsKPj4+ICsgICAgcmV0dXJuIHZob3N0
X3ZkcGFfYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19GRUFUVVJFU19PSyk7Cj4+PiAr
fQo+Pj4gKwo+Pj4gICAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF9vd25lcihzdHJ1Y3Qgdmhv
c3RfZGV2ICpkZXYpCj4+PiAgICB7Cj4+PiAgICAgICAgaWYgKHZob3N0X3ZkcGFfb25lX3RpbWVf
cmVxdWVzdChkZXYpKSB7Cj4+PiBAQCAtNzcyLDYgKzczNyw0MSBAQCBzdGF0aWMgYm9vbCAgdmhv
c3RfdmRwYV9mb3JjZV9pb21tdShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4+PiAgICAgICAgcmV0
dXJuIHRydWU7Cj4+PiAgICB9Cj4+Pgo+Pj4gK3N0YXRpYyBpbnQgdmhvc3RfdmRwYV9pbml0KHN0
cnVjdCB2aG9zdF9kZXYgKmRldiwgdm9pZCAqb3BhcXVlLCBFcnJvciAqKmVycnApCj4+PiArewo+
Pj4gKyAgICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdjsKPj4+ICsgICAgYXNzZXJ0KGRldi0+dmhvc3Rf
b3BzLT5iYWNrZW5kX3R5cGUgPT0gVkhPU1RfQkFDS0VORF9UWVBFX1ZEUEEpOwo+Pj4gKyAgICB0
cmFjZV92aG9zdF92ZHBhX2luaXQoZGV2LCBvcGFxdWUpOwo+Pj4gKyAgICBpbnQgcmV0Owo+Pj4g
Kwo+Pj4gKyAgICAvKgo+Pj4gKyAgICAgKiBTaW1pbGFyIHRvIFZGSU8sIHdlIGVuZCB1cCBwaW5u
aW5nIGFsbCBndWVzdCBtZW1vcnkgYW5kIGhhdmUgdG8KPj4+ICsgICAgICogZGlzYWJsZSBkaXNj
YXJkaW5nIG9mIFJBTS4KPj4+ICsgICAgICovCj4+PiArICAgIHJldCA9IHJhbV9ibG9ja19kaXNj
YXJkX2Rpc2FibGUodHJ1ZSk7Cj4+PiArICAgIGlmIChyZXQpIHsKPj4+ICsgICAgICAgIGVycm9y
X3JlcG9ydCgiQ2Fubm90IHNldCBkaXNjYXJkaW5nIG9mIFJBTSBicm9rZW4iKTsKPj4+ICsgICAg
ICAgIHJldHVybiByZXQ7Cj4+PiArICAgIH0KPj4+ICsKPj4+ICsgICAgdiA9IG9wYXF1ZTsKPj4+
ICsgICAgdi0+ZGV2ID0gZGV2Owo+Pj4gKyAgICBkZXYtPm9wYXF1ZSA9ICBvcGFxdWUgOwo+Pj4g
KyAgICB2LT5saXN0ZW5lciA9IHZob3N0X3ZkcGFfbWVtb3J5X2xpc3RlbmVyOwo+Pj4gKyAgICB2
LT5tc2dfdHlwZSA9IFZIT1NUX0lPVExCX01TR19WMjsKPj4+ICsKPj4+ICsgICAgdmhvc3RfdmRw
YV9nZXRfaW92YV9yYW5nZSh2KTsKPj4+ICsKPj4+ICsgICAgaWYgKHZob3N0X3ZkcGFfb25lX3Rp
bWVfcmVxdWVzdChkZXYpKSB7Cj4+PiArICAgICAgICByZXR1cm4gMDsKPj4+ICsgICAgfQo+Pj4g
Kwo+Pj4gKyAgICB2aG9zdF92ZHBhX2FkZF9zdGF0dXMoZGV2LCBWSVJUSU9fQ09ORklHX1NfQUNL
Tk9XTEVER0UgfAo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fQ09O
RklHX1NfRFJJVkVSKTsKPj4+ICsKPj4+ICsgICAgcmV0dXJuIDA7Cj4+PiArfQo+Pj4gKwo+Pj4g
ICAgY29uc3QgVmhvc3RPcHMgdmRwYV9vcHMgPSB7Cj4+PiAgICAgICAgICAgIC5iYWNrZW5kX3R5
cGUgPSBWSE9TVF9CQUNLRU5EX1RZUEVfVkRQQSwKPj4+ICAgICAgICAgICAgLnZob3N0X2JhY2tl
bmRfaW5pdCA9IHZob3N0X3ZkcGFfaW5pdCwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
