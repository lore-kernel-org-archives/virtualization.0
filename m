Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4E4C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 15:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B34641936;
	Wed, 27 Apr 2022 15:15:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CxJnsu2wwSQp; Wed, 27 Apr 2022 15:15:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0F1E741930;
	Wed, 27 Apr 2022 15:15:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D830DC0032;
	Wed, 27 Apr 2022 15:15:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 093D8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 15:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA70640ABB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 15:15:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Cfj7F1CmZsx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 15:15:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BDD3A4014C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651072550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XWOAdhImrq2/TYQ+L3686e0RCpgtyiJg1rlmg+GyPGc=;
 b=PwuaW4XwlmAjCWoIX3iW4ZSvMMhL8B5IARL5MBYzJc5NjQjJHU+fTIuRAkmOz4P7e8GYq7
 CJl9biVr8gedxfWR+MotzbIphZd/JcHcGcF+RQnBfoPNBS02lJRzOXbHKVXWx2N+cypUem
 OzXUYNztb8hvrgCGNJYpmCI78lO9TEA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-m3ql83ZvPkSEmsnzV9IwwQ-1; Wed, 27 Apr 2022 11:15:41 -0400
X-MC-Unique: m3ql83ZvPkSEmsnzV9IwwQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 d6-20020a05600c34c600b0039296a2ac7cso691397wmq.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 08:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=XWOAdhImrq2/TYQ+L3686e0RCpgtyiJg1rlmg+GyPGc=;
 b=MNySHOIIIJr3onVG+jiw0DPn5WYts9GEjP8p8osVLDErkXdcUcW1o4CEEEA18DUUAv
 TinT719hQ6SiYK4/5nilz/F+OQCAIm5F7Yw3FkwgSqNDYV3/NNPLWCZgWyimy8fYW7pY
 yBN1VKSgQZa9VRKqZnXmgOhyuzQvmMkVJJl6mODWyNB6o8dRm8Y1KI7kP3M9p5VK5wI3
 7UexLuVn8HZxhpgBVLcKsErMr5pcvc+GhTKll3hsvoo+hqvoCP+G9OqK+bpEjsVpRcmX
 fR0qLmVaDnY8cY+B6/Lbv9EBf9HbeQXtp69vZ/MkoOqHGHaDIgyHt/bbGA+3yhfvcHha
 TQlw==
X-Gm-Message-State: AOAM531CkYasnFgcRpq6dlu5PP742E1bfM3b2hDzhyn5l4AMkbouC3u/
 j7vYhu2W00qUagysmS6DMXzbiel5QYumOBfDYBvulVsUZsmVtHqluQo6n8uzs5//M/0xGKPWCL4
 Ne3F5GLkapFQBrYZhssfB3LbuCIQtFUWWpG6X39wnwg==
X-Received: by 2002:a05:6000:1a8b:b0:20a:aaf7:75e8 with SMTP id
 f11-20020a0560001a8b00b0020aaaf775e8mr22115524wry.66.1651072540654; 
 Wed, 27 Apr 2022 08:15:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE2AlpbHYOLX4zY56a2kJT8noUAH/+2Yr1v5MnPXpsBur3d6mwrrg1tCJ6Nr9H5Fv/c4lYyw==
X-Received: by 2002:a05:6000:1a8b:b0:20a:aaf7:75e8 with SMTP id
 f11-20020a0560001a8b00b0020aaaf775e8mr22115488wry.66.1651072540308; 
 Wed, 27 Apr 2022 08:15:40 -0700 (PDT)
Received: from redhat.com ([191.96.168.103]) by smtp.gmail.com with ESMTPSA id
 o26-20020adfa11a000000b0020ade8b8fc5sm7088993wro.107.2022.04.27.08.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 08:15:39 -0700 (PDT)
Date: Wed, 27 Apr 2022 11:15:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220427111228-mutt-send-email-mst@kernel.org>
References: <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <CACGkMEve+3ugK-Kgao3_2wbjb=fbF7AO2uEuArGjKgEAQcGdiQ@mail.gmail.com>
 <20220426022420-mutt-send-email-mst@kernel.org>
 <CACGkMEtt8irvYVx482Zc4vkjtDANXFvUYHGFoCh=C-Xf3C2JUg@mail.gmail.com>
 <20220427022907-mutt-send-email-mst@kernel.org>
 <CACGkMEvfWA9vzVWU6yVdGNwueAAR9MhW8sFAAnGaRB7T+3GYeQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvfWA9vzVWU6yVdGNwueAAR9MhW8sFAAnGaRB7T+3GYeQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Cindy Lu <lulu@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBBcHIgMjcsIDIwMjIgYXQgMDM6NTc6NTdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIEFwciAyNywgMjAyMiBhdCAyOjMwIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFdlZCwgQXByIDI3LCAyMDIyIGF0IDEx
OjUzOjI1QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIFR1ZSwgQXByIDI2LCAy
MDIyIGF0IDI6MzAgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+ID4KPiA+ID4gPiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAxMjowNzozOVBNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gT24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMTE6
NTUgQU0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDExOjUzOjI0UE0gLTA0MDAs
IE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBUdWUsIEFwciAyNiwg
MjAyMiBhdCAxMTo0Mjo0NUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+IOWcqCAyMDIyLzQvMjYgMTE6MzgsIE1pY2hhZWwgUy4gVHNpcmtp
biDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDExOjM1
OjQxUE0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4g
PiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAwNDoyOToxMUFNICswMjAwLCBIYWxpbCBQYXNpYyB3
cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgMjUgQXByIDIwMjIgMDk6NTk6NTUg
LTA0MDAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAxMDo1NDoyNEFNICswMjAwLCBDb3JuZWxpYSBI
dWNrIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgQXByIDI1IDIwMjIs
ICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAxMDo0NDoxNUFNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGlzIHBh
dGNoIHRyaWVzIHRvIGltcGxlbWVudCB0aGUgc3luY2hyb25pemVfY2JzKCkgZm9yIGNjdy4gRm9y
IHRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB2cmluZ19pbnRlcnJ1cHQoKSB0aGF0
IGlzIGNhbGxlZCB2aWEgdmlydGlvX2FpcnFfaGFuZGxlcigpLCB0aGUKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gc3luY2hyb25pemF0aW9uIGlzIHNpbXBseSBkb25lIHZpYSB0aGUgYWly
cV9pbmZvJ3MgbG9jay4gRm9yIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB2cmlu
Z19pbnRlcnJ1cHQoKSB0aGF0IGlzIGNhbGxlZCB2aWEgdmlydGlvX2Njd19pbnRfaGFuZGxlcigp
LCBhIHBlcgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBkZXZpY2Ugc3BpbmxvY2sgZm9y
IGlycSBpcyBpbnRyb2R1Y2VkIGFucyB1c2VkIGluIHRoZSBzeW5jaHJvbml6YXRpb24KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gbWV0aG9kLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0
Z2x4QGxpbnV0cm9uaXguZGU+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IENjOiBQZXRl
ciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IENjOiAiUGF1bCBFLiBNY0tlbm5leSIgPHBhdWxtY2tAa2VybmVsLm9yZz4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQ2M6IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IENjOiBIYWxpbCBQYXNpYyA8cGFzaWNAbGlu
dXguaWJtLmNvbT4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQ2M6IENvcm5lbGlhIEh1
Y2sgPGNvaHVja0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRoaXMgaXMgdGhlIG9u
bHkgb25lIHRoYXQgaXMgZ2l2aW5nIG1lIHBhdXNlLiBIYWxpbCwgQ29ybmVsaWEsCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBzaG91bGQgd2UgYmUgY29uY2VybmVkIGFib3V0IHRoZSBwZXJm
b3JtYW5jZSBpbXBhY3QgaGVyZT8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEFueSBjaGFu
Y2UgaXQgY2FuIGJlIHRlc3RlZD8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXZSBjYW4gaGF2
ZSBhIGJ1bmNoIG9mIGRldmljZXMgdXNpbmcgdGhlIHNhbWUgYWlycSBzdHJ1Y3R1cmUsIGFuZCB0
aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBzeW5jIGNiIGNyZWF0ZXMgYSBjaG9rZSBwb2lu
dCwgc2FtZSBhcyByZWdpc3RlcmluZy91bnJlZ2lzdGVyaW5nLgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBCVFcgY2FuIGNhbGxiYWNrcyBmb3IgbXVsdGlwbGUgVlFzIHJ1biBvbiBtdWx0aXBsZSBD
UFVzIGF0IHRoZSBtb21lbnQ/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJJ20gbm90IHN1cmUgSSB1
bmRlcnN0YW5kIHRoZSBxdWVzdGlvbi4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBJIGRvIHRoaW5rIHdlIGNhbiBoYXZlIG11bHRpcGxlIENQVXMgdGhhdCBhcmUg
ZXhlY3V0aW5nIHNvbWUgcG9ydGlvbiBvZgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdmlydGlvX2Nj
d19pbnRfaGFuZGxlcigpLiBTbyBJIGd1ZXNzIHRoZSBhbnN3ZXIgaXMgeWVzLiBDb25uaWUgd2hh
dCBkbyB5b3UgdGhpbms/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gT24gdGhlIG90aGVyIGhhbmQgd2UgY291bGQgYWxzbyBlbmQgdXAgc2VyaWFsaXppbmcgc3lu
Y2hyb25pemVfY2JzKCkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNhbGxzIGZvciBkaWZmZXJlbnQg
ZGV2aWNlcyBpZiB0aGV5IGhhcHBlbiB0byB1c2UgdGhlIHNhbWUgYWlycV9pbmZvLiBCdXQKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IHRoaXMgcHJvYmFibHkgd2FzIG5vdCB5b3VyIHF1ZXN0aW9uCj4g
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBJIGFtIGxlc3MgY29uY2VybmVk
IGFib3V0ICBzeW5jaHJvbml6ZV9jYnMgYmVpbmcgc2xvdyBhbmQgbW9yZSBhYm91dAo+ID4gPiA+
ID4gPiA+ID4gPiA+IHRoZSBzbG93ZG93biBpbiBpbnRlcnJ1cHQgcHJvY2Vzc2luZyBpdHNlbGYu
Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdGhpcyBwYXRjaCBz
ZXJpYWxpemVzIHRoZW0gb24gYSBzcGlubG9jay4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IFRob3NlIGNvdWxkIHRoZW4gcGlsZSB1cCBvbiB0aGUgbmV3bHkg
aW50cm9kdWNlZCBzcGlubG9jay4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBSZWdhcmRzLAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSGFsaWwKPiA+ID4gPiA+ID4g
PiA+ID4gPiBIbW0geWVhIC4uLiBub3QgZ29vZC4KPiA+ID4gPiA+ID4gPiA+ID4gSXMgdGhlcmUg
YW55IG90aGVyIHdheSB0byBzeW5jaHJvbml6ZSB3aXRoIGFsbCBjYWxsYmFja3M/Cj4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IE1heWJlIHVzaW5nIHJ3bG9j
ayBhcyBhaXJxIGhhbmRsZXI/Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gVGhhbmtz
Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gcndsb2NrIGlzIHN0
aWxsIGEgc2hhcmVkIGNhY2hlbGluZSBib3VuY2luZyBiZXR3ZWVuIENQVXMgYW5kCj4gPiA+ID4g
PiA+ID4gYSBidW5jaCBvZiBvcmRlcmluZyBpbnN0cnVjdGlvbnMuCj4gPiA+ID4gPgo+ID4gPiA+
ID4gWWVzLCBidXQgaXQgc2hvdWxkIGJlIGZhc3RlciB0aGFuIHNwaW5sb2NrcyBhbnlob3cuCj4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+IE1heWJlIHNvbWV0aGluZyBwZXItY3B1ICsgc29tZSBJUElz
IHRvIHJ1biB0aGluZ3Mgb24gYWxsIENQVXMgaW5zdGVhZD8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJ
cyB0aGlzIHNvbWV0aGluZyBsaWtlIGEgY3VzdG9taXplZCB2ZXJzaW9uIG9mIHN5bmNocm9uemll
X3JjdV9leHBlZGl0ZWQoKT8KPiA+ID4gPgo+ID4gPiA+IFdpdGggaW50ZXJydXB0cyBydW5uaW5n
IGluIGFuIFJDVSByZWFkIHNpemUgY3JpdGljYWwgc2VjdGlvbj8KPiA+ID4KPiA+ID4gRm9yIHZy
aW5nX2ludGVycnVwdCgpLCB5ZXMuCj4gPiA+Cj4gPiA+Cj4gPiA+ID4gUXVpdGUgcG9zc2libHkg
dGhhdCBpcyBhbHNvIGFuIG9wdGlvbi4KPiA+ID4gPiBUaGlzIHdpbGwgbmVlZCBhIGJ1bmNoIG9m
IGRvY3VtZW50YXRpb24gc2luY2UgdGhpcyBpcyBub3QKPiA+ID4gPiBhIHN0YW5kYXJkIHVzZSBv
ZiBSQ1UsCj4gPiA+Cj4gPiA+IEFjY29yZGluZyB0byBEb2N1bWVudGF0aW9uL1JDVS9yZXF1aXJl
bWVudHMucnN0LCBpdCBsb29rcyBsaWtlIGEgbGVnYWwgY2FzZToKPiA+ID4KPiA+ID4gIgo+ID4g
PiBUaGUgTGludXgga2VybmVsIGhhcyBpbnRlcnJ1cHRzLCBhbmQgUkNVIHJlYWQtc2lkZSBjcml0
aWNhbCBzZWN0aW9ucyBhcmUKPiA+ID4gbGVnYWwgd2l0aGluIGludGVycnVwdCBoYW5kbGVycyBh
bmQgd2l0aGluIGludGVycnVwdC1kaXNhYmxlZCByZWdpb25zIG9mCj4gPiA+IGNvZGUsIGFzIGFy
ZSBpbnZvY2F0aW9ucyBvZiBjYWxsX3JjdSgpLgo+ID4gPiAiCj4gPgo+ID4gTXkgcHJvYmxlbSBp
cyBpdCBpcyBub3QgY2xlYXIgd2hhdCBkYXRhIGlzIHByb3RlY3RlZCBieSByY3UgaGVyZS4KPiA+
IE5vdGhpbmcgaXMgdGFnZ2VkIHdpdGggX19yY3Ugb3IgdXNlcyByY3VfZGVyZWZlcmVuY2UuCj4g
Cj4gSXQgc2hvdWxkIGJlIHRoZSB2cS0+YnJva2VuIGhlcmUuIFdlIGNhbiByY3VpZnkgaXQuCgoK
SSBkb24ndCBleGFjdGx5IGV4YWN0bHkgc2VlIGhvdyAtIHJjdV9kZXJlZmVyZW5jZSB3b3JrcyBv
biBwb2ludGVycy4KRmVlbCBmcmVlIHRvIHNlbmQgYSBwYXRjaC4KCgo+IAo+ID4gV2UgbmVlZCBh
dCBsZWFzdCBhbiBhY2sgZnJvbSByY3UgbWFpbnRhaW5lcnMgdGhhdCB0aGlzIGlzCj4gPiBhIHZh
bGlkIHVzZSBvZiByY3UgYW5kIG5vdCBhbiB1bmRvY3VtZW50ZWQgc2lkZSBlZmZlY3QuCj4gCj4g
WWVzLgo+IAo+IFRoYW5rcwo+IAo+IAo+ID4KPiA+ID4gQW5kIGFzIGRpc2N1c3NlZCwgc3luY2hy
b25pemVfcmN1X2V4cGVkaXRlZCgpIGlzIG5vdCBmcmllbmRseSB0byByZWFsCj4gPiA+IHRpbWUg
d29ya2xvYWQuIEkgdGhpbmsgd2UgY2FuIHNpbXBseQo+ID4gPgo+ID4gPiAxKSBwcm90ZWN0IHZy
aW5nX2ludGVycnVwdCgpIHdpdGggcmN1X3JlYWRfbG9jaygpCj4gPiA+IDIpIHVzZSBzeW5jaHJv
bml6ZV9yY3UoKSBpbiBzeW5jaHJvbml6ZV9jYnMgZm9yIGNjdwo+ID4gPgo+ID4gPiBBbmQgaWYg
d2UgY2FyZSBhYm91dCB0aGUgbG9uZyBkZWxheSB3ZSBjYW4gdXNlIHBlciBkZXZpY2Ugc3JjdSB0
byByZWR1Y2UgdGhhdD8KPiA+ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+ID4gYW5kIHByb2Jh
Ymx5IGdldCBhIGNvbmZpcm1hdGlvbgo+ID4gPiA+IGZyb20gUkNVIG1haW50YWluZXJzIHRoYXQg
d2hhdGV2ZXIgYXNzdW1wdGlvbnMgd2UgbWFrZQo+ID4gPiA+IGFyZSBndWFyYW50ZWVkIHRvIGhv
bGQgZG93biB0aGUgcm9hZC4KPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAuLi4gYW5k
IEkgdGhpbmsgY2xhc3NpYyBhbmQgZGV2aWNlIGludGVycnVwdHMgYXJlIGRpZmZlcmVudCBlbm91
Z2gKPiA+ID4gPiA+ID4gaGVyZSAuLi4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBZZXMuCj4gPiA+ID4g
Pgo+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiA+ID4gPiA+ID4gTVNUCj4gPiA+ID4g
PiA+Cj4gPiA+ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
