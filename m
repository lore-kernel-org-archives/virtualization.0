Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83429C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 08:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A43D40112;
	Tue,  8 Feb 2022 08:16:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Ee_wsGroAo7; Tue,  8 Feb 2022 08:16:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 25351400D1;
	Tue,  8 Feb 2022 08:16:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EACDBC001A;
	Tue,  8 Feb 2022 08:16:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AC8CC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BB5A817A3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:16:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EsnCzEpxZk7h
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:16:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C96DA81777
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 08:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644308160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lPUhepJnZFvIynAYCQmnRqPG0WoeBnyxmrDrFwKAF+M=;
 b=MfrfOiNz27GI7dkJcrmYR0nFvDiWsQpq1fVO6hACrvt3NP8ixw2dNwHozMEEA5bHpiMcBm
 bhOArLcjno8T62m8MCHNglnBLanqzgvWqfwOeKdyIV8CqYGrf1jwtnyow0LZBPL1A2rXeN
 i+Tto68V82TiGkQKrZP9I7ou7J6cjzY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-tnbOEp5gNQKCuo-J79N8-g-1; Tue, 08 Feb 2022 03:15:59 -0500
X-MC-Unique: tnbOEp5gNQKCuo-J79N8-g-1
Received: by mail-pl1-f197.google.com with SMTP id
 e7-20020a170902ef4700b0014d2b420f1fso3992202plx.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 00:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=lPUhepJnZFvIynAYCQmnRqPG0WoeBnyxmrDrFwKAF+M=;
 b=Pn3Vc3TJKdIp57VALYHjB5ULsvGCUSn3psrp7UiVT3c8JwH0ZyChtmSTx4OeCLzfr1
 j9y4yAMDszMCK/kG4mDc99iP0XePDCiSxCiiEmiQxu/UYzxPOQtjLNwde7RTmARV0I7Q
 ek9XkZwX1KBjCBo6E4y7ZoXTwwn7FL0F+AsyDp7WyUOKCg+gqS3wBEP+i5qKvWSWty5u
 gfYX3o5OAtzXszz94iIcVrZ9RVjW820HUcy2/i+M2tzfMs/Kb584uLI1TpLBsnbTtJlY
 fgDoxG1Vr5oEHJX7x34kJDaOl0GPYyca5wbmPd3t1fuTxntvKPEC9HnXC+kC219Da6D6
 TL+Q==
X-Gm-Message-State: AOAM5320A45CcIq5dt3QCdHyp/P/YlQHvWvl4Iodn937RDJ2TI3qlnBw
 wrGgNrTiKqW9OqzGK8+C+A5soDFc5vyQ3+mkCyj3g7osyjq+3iIgvsqjEIUZp6IG7I8cerE1JgR
 RA/b9ppLv3YqkV8DLP5A6DJpVDhz8LFkCdo8dkAO3jw==
X-Received: by 2002:aa7:880d:: with SMTP id c13mr3323686pfo.3.1644308157765;
 Tue, 08 Feb 2022 00:15:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnzYYG0ci5jutgI+Tglk0FOxWgNFgcSVn2e7M0dV6Cvx73rMXZnbaQyaR7OSg2rkav1rXvIA==
X-Received: by 2002:aa7:880d:: with SMTP id c13mr3323649pfo.3.1644308157482;
 Tue, 08 Feb 2022 00:15:57 -0800 (PST)
Received: from [10.72.13.12] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 38sm10583060pgl.82.2022.02.08.00.15.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Feb 2022 00:15:56 -0800 (PST)
Message-ID: <7c52e50a-4c8e-7865-1c3d-8b156986c13a@redhat.com>
Date: Tue, 8 Feb 2022 16:15:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 18/31] vhost: Shadow virtqueue buffers forwarding
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-19-eperezma@redhat.com>
 <62e877ca-51d7-da85-13c9-d469a85f33c9@redhat.com>
 <CAJaqyWfF01k3LntM7RLEmFcej=EY2d4+2MARKXPptQ2J7VnB9A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWfF01k3LntM7RLEmFcej=EY2d4+2MARKXPptQ2J7VnB9A@mail.gmail.com>
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

CuWcqCAyMDIyLzIvMSDkuIvljYg3OjI1LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6Cj4g
T24gU3VuLCBKYW4gMzAsIDIwMjIgYXQgNzo0NyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4KPj4g5ZyoIDIwMjIvMS8yMiDkuIrljYg0OjI3LCBFdWdlbmlvIFDD
qXJleiDlhpnpgZM6Cj4+PiBAQCAtMjcyLDYgKzU5MCwyOCBAQCB2b2lkIHZob3N0X3N2cV9zZXRf
c3ZxX2tpY2tfZmQoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwgaW50IHN2cV9raWNrX2ZkKQo+
Pj4gICAgdm9pZCB2aG9zdF9zdnFfc3RvcChWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxKQo+Pj4g
ICAgewo+Pj4gICAgICAgIGV2ZW50X25vdGlmaWVyX3NldF9oYW5kbGVyKCZzdnEtPnN2cV9raWNr
LCBOVUxMKTsKPj4+ICsgICAgZ19hdXRvZnJlZSBWaXJ0UXVldWVFbGVtZW50ICpuZXh0X2F2YWls
X2VsZW0gPSBOVUxMOwo+Pj4gKwo+Pj4gKyAgICBpZiAoIXN2cS0+dnEpIHsKPj4+ICsgICAgICAg
IHJldHVybjsKPj4+ICsgICAgfQo+Pj4gKwo+Pj4gKyAgICAvKiBTZW5kIGFsbCBwZW5kaW5nIHVz
ZWQgZGVzY3JpcHRvcnMgdG8gZ3Vlc3QgKi8KPj4+ICsgICAgdmhvc3Rfc3ZxX2ZsdXNoKHN2cSwg
ZmFsc2UpOwo+Pgo+PiBEbyB3ZSBuZWVkIHRvIHdhaXQgZm9yIGFsbCB0aGUgcGVuZGluZyBkZXNj
cmlwdG9ycyB0byBiZSBjb21wbGV0ZWQgaGVyZT8KPj4KPiBObywgdGhpcyBmdW5jdGlvbiBkb2Vz
IG5vdCB3YWl0LCBpdCBvbmx5IGNvbXBsZXRlcyB0aGUgZm9yd2FyZGluZyBvZgo+IHRoZSAqdXNl
ZCogZGVzY3JpcHRvcnMuCj4KPiBUaGUgYmVzdCBleGFtcGxlIGlzIHRoZSBuZXQgcnggcXVldWUg
aW4gbXkgb3Bpbmlvbi4gVGhpcyBjYWxsIHdpbGwKPiBjaGVjayBTVlEncyB2cmluZyB1c2VkX2lk
eCBhbmQgd2lsbCBmb3J3YXJkIHRoZSBsYXN0IHVzZWQgZGVzY3JpcHRvcnMKPiBpZiBhbnksIGJ1
dCBhbGwgYXZhaWxhYmxlIGRlc2NyaXB0b3JzIHdpbGwgcmVtYWluIGFzIGF2YWlsYWJsZSBmb3IK
PiBxZW11J3MgVlEgY29kZS4KPgo+IFRvIHNraXAgaXQgd291bGQgbWlzcyB0aG9zZSBsYXN0IHJ4
IGRlc2NyaXB0b3JzIGluIG1pZ3JhdGlvbi4KPgo+IFRoYW5rcyEKCgpTbyBpdCdzIHByb2JhYmx5
IHRvIG5vdCB0aGUgYmVzdCBwbGFjZSB0byBhc2suIEl0J3MgbW9yZSBhYm91dCB0aGUgCmluZmxp
Z2h0IGRlc2NyaXB0b3JzIHNvIGl0IHNob3VsZCBiZSBUWCBpbnN0ZWFkIG9mIFJYLgoKSSBjYW4g
aW1hZ2luZSB0aGUgbWlncmF0aW9uIGxhc3QgcGhhc2UsIHdlIHNob3VsZCBzdG9wIHRoZSB2aG9z
dC12RFBBIApiZWZvcmUgY2FsbGluZyB2aG9zdF9zdnFfc3RvcCgpLiBUaGVuIHdlIHNob3VsZCBi
ZSBmaW5lIHJlZ2FyZGxlc3Mgb2YgCmluZmxpZ2h0IGRlc2NyaXB0b3JzLgoKVGhhbmtzCgoKPgo+
PiBUaGFua3MKPj4KPj4KPj4+ICsKPj4+ICsgICAgZm9yICh1bnNpZ25lZCBpID0gMDsgaSA8IHN2
cS0+dnJpbmcubnVtOyArK2kpIHsKPj4+ICsgICAgICAgIGdfYXV0b2ZyZWUgVmlydFF1ZXVlRWxl
bWVudCAqZWxlbSA9IE5VTEw7Cj4+PiArICAgICAgICBlbGVtID0gZ19zdGVhbF9wb2ludGVyKCZz
dnEtPnJpbmdfaWRfbWFwc1tpXSk7Cj4+PiArICAgICAgICBpZiAoZWxlbSkgewo+Pj4gKyAgICAg
ICAgICAgIHZpcnRxdWV1ZV9kZXRhY2hfZWxlbWVudChzdnEtPnZxLCBlbGVtLCBlbGVtLT5sZW4p
Owo+Pj4gKyAgICAgICAgfQo+Pj4gKyAgICB9Cj4+PiArCj4+PiArICAgIG5leHRfYXZhaWxfZWxl
bSA9IGdfc3RlYWxfcG9pbnRlcigmc3ZxLT5uZXh0X2d1ZXN0X2F2YWlsX2VsZW0pOwo+Pj4gKyAg
ICBpZiAobmV4dF9hdmFpbF9lbGVtKSB7Cj4+PiArICAgICAgICB2aXJ0cXVldWVfZGV0YWNoX2Vs
ZW1lbnQoc3ZxLT52cSwgbmV4dF9hdmFpbF9lbGVtLAo+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG5leHRfYXZhaWxfZWxlbS0+bGVuKTsKPj4+ICsgICAgfQo+Pj4gICAgfQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
