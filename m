Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977FEC433EF
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 10:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2870F408B7;
	Mon, 10 Jan 2022 10:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uScQ3Z05qw48; Mon, 10 Jan 2022 10:06:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A77F34088F;
	Mon, 10 Jan 2022 10:06:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 671E3C0030;
	Mon, 10 Jan 2022 10:06:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC3E9C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 10:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CAE4D408AD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 10:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9lYSrKUn4y9n
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 10:06:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E03AA4088F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 10:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641809193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HesmnWxg1xJeBVtRyG77TZ9HBhzyRJZQ+LajAsWmBaw=;
 b=XJ5ajLiuK9Qfvod+ZgIQ6jd7A4bnADsZ6jY1uWq+x+3LPXAKfgK7rJaDQPeewkMsSf3H2S
 2RIOkn6q5yl3V/Hjymc4pFmJhOh5GVpNTDpSaAwOVnXYQJoIeMEFRhtlB2J0QEAMNBRY6+
 YnVoF8fkGrpZM2OCMcOhvrfuZbTawa0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-AnZT9qX3NTKKLDxXs9yqgQ-1; Mon, 10 Jan 2022 05:06:32 -0500
X-MC-Unique: AnZT9qX3NTKKLDxXs9yqgQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 w6-20020a05640234c600b003f916e1b615so9687748edc.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 02:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HesmnWxg1xJeBVtRyG77TZ9HBhzyRJZQ+LajAsWmBaw=;
 b=JV9izfsjgkSfTar0o72zqapB+/vsDiJd24mwNq1sUutLWP//xEZyrE+YtyKhiwbP87
 3h/j61FePWUtnY9lfd58sAEO3uiXCaXtTlVvYqDhePNjOqIIEPGnIA7K8sqTl9J9ZbX+
 k7deBk3NiJtgvA0tCC4ozlruVy5WhQpsTitQt0UCwSbWtz7mdvuU5dY4itBPv2F7hZE7
 TBAqvETfR22NFEsHfHOUGKWZA4kdhufrKz0kpiCKxKGiCCGvI7uz79/BRVCHWjz++L0s
 cnQmpy07NTdCZ/aYBa+oQGdlAu6CoBIU59KVfN+tSYDfbxgYaTyQ/0WaklPRr7FWYeg2
 sLqg==
X-Gm-Message-State: AOAM5303daULVnrPqDTVMGK1oTyBNd4cUG4Zxv/b8YdMPulNli1x/g99
 0Txadockz+l329l+5oCGuEkxB3f+x64EGzq0inKc2+Wd8/C7YbE2pgSO7/mku4DPk54gcO560dU
 zEAmp5C0pYpVxe3ovHQg+VYPwm0JQj8voHBQTlyq3Mw==
X-Received: by 2002:a17:907:86ab:: with SMTP id
 qa43mr59644123ejc.583.1641809191165; 
 Mon, 10 Jan 2022 02:06:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+6Kuwoxbck4lXYbwF+9bmBWmPXTMMjz65i9g7ygHswL2OcGIUQUpkxyrwNO5wTGKeFEZzrg==
X-Received: by 2002:a17:907:86ab:: with SMTP id
 qa43mr59644114ejc.583.1641809190948; 
 Mon, 10 Jan 2022 02:06:30 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107d:b60c:c297:16fe:7528:e989])
 by smtp.gmail.com with ESMTPSA id s20sm3342081edd.41.2022.01.10.02.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jan 2022 02:06:30 -0800 (PST)
Date: Mon, 10 Jan 2022 05:06:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 2/6] virtio: split: alloc indirect desc with extra
Message-ID: <20220110050531-mutt-send-email-mst@kernel.org>
References: <20220110044217-mutt-send-email-mst@kernel.org>
 <1641808716.6985362-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1641808716.6985362-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

T24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMDU6NTg6MzZQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3Rl
Ogo+IE9uIE1vbiwgMTAgSmFuIDIwMjIgMDQ6NDk6MjUgLTA1MDAsIE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMDU6
MjM6MTNQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3RlOgo+ID4gPiBPbiBNb24sIDEwIEphbiAyMDIy
IDE2OjU0OjU4ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToK
PiA+ID4gPiBPbiBNb24sIEphbiAxMCwgMjAyMiBhdCAzOjU5IFBNIFh1YW4gWmh1byA8eHVhbnpo
dW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IE9uIE1vbiwg
MTAgSmFuIDIwMjIgMTU6NDE6MjcgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBNb24sIEphbiAxMCwgMjAyMiBhdCAzOjI0IFBNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gT24gTW9uLCAxMCBKYW4gMjAyMiAxNDo0MzozOSArMDgwMCwgSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4g5ZyoIDIwMjIvMS83IOS4i+WNiDI6MzMsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+
ID4gPiA+ID4gPiA+IEluIHRoZSBzY2VuYXJpbyB3aGVyZSBpbmRpcmVjdCBpcyBub3QgdXNlZCwg
ZWFjaCBkZXNjIGNvcnJlc3BvbmRzIHRvIGFuCj4gPiA+ID4gPiA+ID4gPiA+IGV4dHJhLCB3aGlj
aCBpcyB1c2VkIHRvIHJlY29yZCBpbmZvcm1hdGlvbiBzdWNoIGFzIGRtYSwgZmxhZ3MsIGFuZAo+
ID4gPiA+ID4gPiA+ID4gPiBuZXh0Lgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiBJbiB0aGUgc2NlbmFyaW8gb2YgdXNpbmcgaW5kaXJlY3QsIHRoZSBhc3NpZ25lZCBkZXNjIGRv
ZXMgbm90IGhhdmUgdGhlCj4gPiA+ID4gPiA+ID4gPiA+IGNvcnJlc3BvbmRpbmcgZXh0cmEgcmVj
b3JkIGRtYSBpbmZvcm1hdGlvbiwgYW5kIHRoZSBkbWEgaW5mb3JtYXRpb24gbXVzdAo+ID4gPiA+
ID4gPiA+ID4gPiBiZSBvYnRhaW5lZCBmcm9tIHRoZSBkZXNjIHdoZW4gdW5tYXAuCj4gPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggYWxsb2NhdGVzIHRoZSBjb3Jy
ZXNwb25kaW5nIGV4dHJhIGFycmF5IHdoZW4gaW5kaXJlY3QgZGVzYyBpcwo+ID4gPiA+ID4gPiA+
ID4gPiBhbGxvY2F0ZWQuIFRoaXMgaGFzIHRoZXNlIGFkdmFudGFnZXM6Cj4gPiA+ID4gPiA+ID4g
PiA+IDEuIFJlY29yZCB0aGUgZG1hIGluZm9ybWF0aW9uIG9mIGRlc2MsIG5vIG5lZWQgdG8gcmVh
ZCBkZXNjIHdoZW4gdW5tYXAKPiA+ID4gPiA+ID4gPiA+ID4gMi4gSXQgd2lsbCBiZSBtb3JlIGNv
bnZlbmllbnQgYW5kIHVuaWZpZWQgaW4gcHJvY2Vzc2luZwo+ID4gPiA+ID4gPiA+ID4gPiAzLiBT
b21lIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24gY2FuIGJlIHJlY29yZGVkIGluIGV4dHJhLCB3aGlj
aCB3aWxsIGJlCj4gPiA+ID4gPiA+ID4gPiA+ICAgICB1c2VkIGluIHN1YnNlcXVlbnQgcGF0Y2hl
cy4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gVHdvIHF1
ZXN0aW9uczoKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiAxKSBJcyB0aGVyZSBhbnkg
cGVyZm9ybWFuY2UgbnVtYmVyIGZvciB0aGlzIGNoYW5nZT8gSSBndWVzcyBpdCBnaXZlcwo+ID4g
PiA+ID4gPiA+ID4gbW9yZSBzdHJlc3Mgb24gdGhlIGNhY2hlLgo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gSSB3aWxsIGFkZCBwZXJmb3JtYW5jZSB0ZXN0IGRhdGEgaW4gdGhlIG5leHQgdmVy
c2lvbi4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gMikgSXMgdGhlcmUgYSByZXF1aXJl
bWVudCB0byBtaXggdGhlIHByZSBtYXBwZWQgc2cgd2l0aCB1bm1hcHBlZCBzZz8gSWYKPiA+ID4g
PiA+ID4gPiA+IG5vdCwgYSBwZXIgdmlydHF1ZXVlIGZsYWcgbG9va3Mgc3VmZmljaWVudAo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhlcmUgaXMgdGhpcyByZXF1aXJlbWVudC4gRm9yIGV4
YW1wbGUsIGluIHRoZSBjYXNlIG9mIEFGX1hEUCwgYSBwYXRja2V0Cj4gPiA+ID4gPiA+ID4gY29u
dGFpbnMgdHdvIHBhcnRzLCBvbmUgaXMgdmlydGlvX25ldF9oZHIsIGFuZCB0aGUgb3RoZXIgaXMg
dGhlIGFjdHVhbCBkYXRhCj4gPiA+ID4gPiA+ID4gcGFja2V0IGZyb20gQUZfWERQLiBUaGUgZm9y
bWVyIGlzIHVubWFwcGVkIHNnLCBhbmQgdGhlIGxhdHRlciBpcyBwcmUgbWFwcGVkIHNnLgo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiBBbnkgY2hhbmNlIHRvIG1hcCB2aXJ0aW9fbmV0X2hkcigpIG1h
bnVhbGx5IGJ5IEFGX1hEUCByb3V0aW5lIGluIHRoaXMgY2FzZT8KPiA+ID4gPiA+Cj4gPiA+ID4g
PiBXZWxsLCBpdCBpcyBpbmRlZWQgcG9zc2libGUgdG8gZG8gc28uIEluIHRoZSBpbmRpcmVjdCBz
Y2VuYXJpbywgd2UgY2FuIHJlY29yZCBpdAo+ID4gPiA+ID4gaW4gdnJpbmctPnNwbGl0LmRlc2Nf
ZXh0cmFbaGVhZF0uZmxhZ3MKPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGVuIHdlIGhhdmUgdG8gYWdy
ZWUgdGhhdCB0aGVyZSBjYW4gYmUgbm8gbWl4ZWQgc2l0dWF0aW9uLgo+ID4gPiA+Cj4gPiA+ID4g
SSB0aGluayBpdCB3b3VsZCBiZSBlYXNpZXIgYW5kIGxlc3MgcGVyZm9ybWFuY2UgcmVncmVzc2lv
biBpZiB3ZSBkb24ndAo+ID4gPiA+IGRvIGh1Z2UgY2hhbmdlcyBpbiB0aGUgY29yZSB1bmxlc3Mg
aXQncyBhIG11c3QuCj4gPiA+ID4KPiA+ID4KPiA+ID4gT2ssIEkgcGxhbiB0byBhZGQgdHdvIG5l
dyBpbnRlcmZhY2UgdmlydHF1ZXVlX2FkZF9vdXRidWZfZmxhZygpLAo+ID4gPiB2aXJ0cXVldWVf
YWRkX2luYnVmX2ZsYWcoKSBwYXNzIGEgZmxhZyBwYXJhbWV0ZXIgdG8gdmlydHF1ZXVlX2FkZCgp
IHRvCj4gPiA+IG1hcmsgc2dzIGFkZHIgaXMgcHJlZG1hLgo+ID4KPiA+IEkgd291bGQgbWF5YmUg
anVzdCBkbyBhIHZhcmlhbnQgd29ya2luZyB3aXRoIG1hcHBlZCBTR3MuCj4gCj4gRG8geW91IG1l
YW4gdmlydHF1ZXVlX2FkZF9pbmJ1Zl9kbWEoKSwgdmlydHF1ZXVlX2FkZF9vdXRidWZfZG1hKCk/
CgpGb3IgZXhhbXBsZS4gSGF2ZW4ndCB0aG91Z2h0IGFib3V0IHRoZSBiZXN0IG5hbWUgeWV0LgoK
PiA+Cj4gPiA+IEkgZG9uJ3Qgd2FudCB0byB1c2Ugc2ctPmRtYV9hZGRyZXNzLCBzbyB3ZSBoYXZl
IHRvIGNoZWNrIHdoZXRoZXIgZWFjaCBzZyB1c2VzCj4gPiA+IGRtYV9hZGRyZXNzLiBJZiBpdCBp
cyBub3QgdW5pZmllZCwgd2Ugd2lsbCBhbHNvIGhhbmRsZSBleGNlcHRpb24uCj4gPiA+Cj4gPiA+
ID4gQnR3LCBJIGZvcmdvdCB0aGUgY29uY2x1c2lvbiBvZiB0aGUgbGFzdCBBRl9YRFAgc2VyaWVz
LiBXaHkgaXMgaXQKPiA+ID4gPiBiZXR0ZXIgdG8gY2hhbmdlIHZpcnRpb19yaW5nIGluc3RlYWQg
b2YgQUZfWERQICh3aGljaCBzZWVtcyBlYXNpZXIpLgo+ID4gPgo+ID4gPiBSZWdhcmRpbmcgdGhp
cyBxdWVzdGlvbiwgSSdtIGd1ZXNzaW5nIHlvdSBtZWFuIHRvIG1ha2UgQUZfWERQIG5vdCB1c2Ug
RE1BCj4gPiA+IGFkZHJlc3Nlcz8gSW5zdGVhZCBwYXNzIHZpcnR1YWwgYWRkcmVzc2VzIHRvIHZp
cnRpby4KPiA+ID4KPiA+ID4gSXQgd291bGQgY2VydGFpbmx5IGJlIHNpbXBsZXIsIGJ1dCBJIHRo
aW5rIHRoZXJlIGlzIGEgcGVyZm9ybWFuY2UgZ2FpbiBpbiBkb2luZwo+ID4gPiB0aGUgRE1BIG1h
cHBpbmcgYWhlYWQgb2YgdGltZS4KPiA+ID4KPiA+ID4gVGhhbmtzLgo+ID4KPiA+IFRoYXQgd291
bGQgYXQgbGVhc3QgaW4gcGFydCBkZXBlbmQgb24gd2hldGhlciBETUEgbWFwcGluZyBpcyBldmVu
dHVhbGx5IHVzZWQgOykKPiAKPiBZZXMsIHNvbWUgb2YgdGhlIHNjZW5hcmlvcyBJIHRlc3RlZCB0
aGF0IGFjdHVhbGx5IHJlcXVpcmUgZG1hIHdpbGwgZ2V0Cj4gcGVyZm9ybWFuY2UgaW1wcm92ZW1l
bnRzLiBeX14KPiAKPiAKPiA+IFRlc3RpbmcgdGhlIGFjdHVhbCBnYWluIGJlZm9yZSB3ZSBpbnRy
b2R1Y2UgY29tcGxleGl0eSBhbmQgaW5jbHVkaW5nCj4gPiB0aGF0IGluZm8gaW4gdGhlIGNvbW1p
dCBsb2cgaXMgbm90IGEgYmFkIGlkZWEuCj4gCj4gSSB3aWxsIGJyaW5nIHRoaXMgcGFydCBvZiB0
aGUgZGF0YSBpbiB0aGUgbmV4dCB2ZXJzaW9uLgo+IAo+IFRoYW5rcy4KPiAKPiAKPiA+Cj4gPiA+
Cj4gPiA+ID4KPiA+ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5r
cy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhhbmtzLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
