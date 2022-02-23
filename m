Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DE2C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 03:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E78360C0E;
	Wed, 23 Feb 2022 03:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 79K6SUcAsf0G; Wed, 23 Feb 2022 03:45:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B305600C4;
	Wed, 23 Feb 2022 03:45:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 025F1C0021;
	Wed, 23 Feb 2022 03:45:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECA7BC0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E804040179
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xLe4CWo6ChEt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:45:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C250140105
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645587912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1o+0armOqUzJn42Y1mrJrz2NXyOv3BHdeaxhPRh+Dus=;
 b=OUcga6RepjBsAbuZij7nZdd1rlTtdyyDk9XnrPDQmKN2hgaPeByoq/iUbXHSdUq+agXsNY
 OZlAzvh1+t800chD5aGjUXTv4MKw4WhnhgIEsWfGJm9DUHuXIRuvhl7MfddJRnIPHu4Ofh
 kySVreWtwF1DoHnYkc5V6nqqUkwl38I=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-jTgNkomePt6px3YczlXoiA-1; Tue, 22 Feb 2022 22:45:11 -0500
X-MC-Unique: jTgNkomePt6px3YczlXoiA-1
Received: by mail-lf1-f70.google.com with SMTP id
 m18-20020a0565120a9200b004439214844dso3066642lfu.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 19:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1o+0armOqUzJn42Y1mrJrz2NXyOv3BHdeaxhPRh+Dus=;
 b=Vc+ighyQTXOnvUUgVZi2Q2Q78didVN9i1t5EOs88o1UVZrA7WBGKvZAPmFK4qZ5zdZ
 Exkt+XxKhjCj4hc88Hed8GVol6ZwPgX1CJVVnsgnANAve79wwWmFrAtmXJYe2FLOo/xI
 TruuGJF+XrD1oFuRmUUcm3JFM+C2Wwkh8P2d6s7FP9JBIjfI9bwtr0Q4qyBs14o2rFRi
 eD+dD+bU9BsoPTry7uleB45yfxy1vwXPfItD0FwtqTi1K0oQjGzHfwvorAWfG/t5SGrF
 v8mQTJNCKVWUKrjkH3Bct7q0XPhcYFc+Mzc3yLgN1NNl5HFd7NVQUjObRCs+7wa8hazO
 Kcmg==
X-Gm-Message-State: AOAM533R8iAjZO/CQFhTS1E8FMT4BK9SStfwIoAEHSL1mp2Lj7PW+qPT
 J/8jum+AlhAbshP9oqfB+G97Dpnc3nhCsZt+6ZinIXfSS9ddYB4XulcLeN8ZBdCkbgq6kuoUM58
 8QvtTvpUYs45hNJCuo9BAhUtaj0cPVo28vywsXtQ6V8VQyNBivoPx4ubltA==
X-Received: by 2002:a2e:88ca:0:b0:23f:1e76:465d with SMTP id
 a10-20020a2e88ca000000b0023f1e76465dmr19725313ljk.177.1645587909435; 
 Tue, 22 Feb 2022 19:45:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjE9sUaz3W1db5Fg+/f8LJpwTvsY7IYhCLU9FstH2QJs8nUrL/ztrSumu5yswzFDIiBAsLekYXLc9jvVakppg=
X-Received: by 2002:a2e:88ca:0:b0:23f:1e76:465d with SMTP id
 a10-20020a2e88ca000000b0023f1e76465dmr19725305ljk.177.1645587909185; Tue, 22
 Feb 2022 19:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtE+Bcdru43F5dOkMO1kDhUe19gKwaN4FqkztTCRXSjmw@mail.gmail.com>
 <1645174523.8877885-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv-rhha5WFg+ef181RR5xZmyHkNyfDdcPA=HoDFZ_-Oxg@mail.gmail.com>
 <1645442604.5901623-1-xuanzhuo@linux.alibaba.com>
 <c98a4fd4-af0e-f97f-55a7-a8804eb1fb40@redhat.com>
 <1645516096.2526364-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvU-tVX5WznH_vm1P=LK_zNUqmB7Hz2HRG=bsA0ibp1kg@mail.gmail.com>
In-Reply-To: <CACGkMEvU-tVX5WznH_vm1P=LK_zNUqmB7Hz2HRG=bsA0ibp1kg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Feb 2022 11:44:57 +0800
Message-ID: <CACGkMEshibgUXDB+M-RAU83XbsK_uzZdqNtfG3_DUKcsfqCPjw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] virtio: support advance DMA
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCBGZWIgMjMsIDIwMjIgYXQgMTA6NTggQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEZlYiAyMiwgMjAyMiBhdCA0OjAwIFBNIFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1ZSwg
MjIgRmViIDIwMjIgMTI6MDI6MTQgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPgo+ID4gPiDlnKggMjAyMi8yLzIxIOS4i+WNiDc6MjMsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiA+ID4gT24gTW9uLCAyMSBGZWIgMjAyMiAxMTozMjo1MiArMDgwMCwgSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4+IE9uIEZyaSwgRmVi
IDE4LCAyMDIyIGF0IDU6MDAgUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNv
bT4gd3JvdGU6Cj4gPiA+ID4+PiBPbiBUaHUsIDE3IEZlYiAyMDIyIDE1OjE5OjQ0ICswODAwLCBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPj4+PiBPbiBUaHUs
IEZlYiAxMCwgMjAyMiBhdCA0OjUxIFBNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFi
YS5jb20+IHdyb3RlOgo+ID4gPiA+Pj4+PiB2aXJ0cXVldWVfYWRkKCkgb25seSBzdXBwb3J0cyB2
aXJ0dWFsIGFkZHJlc3NlcywgZG1hIGlzIGNvbXBsZXRlZCBpbgo+ID4gPiA+Pj4+PiB2aXJ0cXVl
dWVfYWRkKCkuCj4gPiA+ID4+Pj4+Cj4gPiA+ID4+Pj4+IEluIHNvbWUgc2NlbmFyaW9zIChzdWNo
IGFzIHRoZSBBRl9YRFAgc2NlbmFyaW8pLCBETUEgaXMgY29tcGxldGVkIGluIGFkdmFuY2UsIHNv
Cj4gPiA+ID4+Pj4+IGl0IGlzIG5lY2Vzc2FyeSBmb3IgdXMgdG8gc3VwcG9ydCBwYXNzaW5nIHRo
ZSBETUEgYWRkcmVzcyB0byB2aXJ0cXVldWVfYWRkKCkuCj4gPiA+ID4+Pj4gSSdkIHN1Z2dlc3Qg
cmVuYW1lIHRoaXMgZmVhdHVyZSBhcyAidW5tYW5hZ2VkIERNQSIuCj4gPiA+ID4+PiBPSwo+ID4g
PiA+Pj4KPiA+ID4gPj4+Pj4gUmVjb3JkIHRoaXMgcHJlZG1hIGluZm9ybWF0aW9uIGluIGV4dHJh
LT5mbGFncywgd2hpY2ggY2FuIGJlIHNraXBwZWQgd2hlbgo+ID4gPiA+Pj4+PiBleGVjdXRpbmcg
ZG1hIHVubWFwLgo+ID4gPiA+Pj4+IFF1ZXN0aW9uIHN0aWxsLCBjYW4gd2UgdXNlIHBlci12aXJ0
cXVldWUgZmxhZyBpbnN0ZWFkIG9mIHBlcgo+ID4gPiA+Pj4+IGRlc2NyaXB0b3IgZmxhZz8gSWYg
bXkgbWVtb3J5IGlzIGNvcnJlY3QsIHRoZSBhbnN3ZXIgaXMgeWVzIGluIHRoZQo+ID4gPiA+Pj4+
IGRpc2N1c3Npb24gZm9yIHRoZSBwcmV2aW91cyB2ZXJzaW9uLgo+ID4gPiA+Pj4+Cj4gPiA+ID4+
PiBZZXMuCj4gPiA+ID4+Pgo+ID4gPiA+Pj4gcGVyLXZpcnRxdWV1ZT8gSSBndWVzcyBpdCBzaG91
bGQgYmUgcGVyLXN1Ym1pdC4KPiA+ID4gPj4+Cj4gPiA+ID4+PiBUaGlzIHBhdGNoIHNldCBvbmx5
IGFkZHMgYSBmbGFnIHRvIGRlc2NfZXh0cmFbaGVhZF0uZmxhZ3MsIHNvIHRoYXQgd2UgY2FuIGtu
b3cKPiA+ID4gPj4+IGlmIHdlIG5lZWQgdG8gdW5tYXAgZG1hIHdoZW4gd2UgZGV0YWNoLgo+ID4g
PiA+PiBJIG1lYW50IGlmIHdlIGNhbiBtYW5hZ2UgdG8gbWFrZSBpdCBwZXIgdmlydHF1ZXVlLCB0
aGVyZSdzIG5vIG5lZWQgdG8KPiA+ID4gPj4gbWFpbnRhaW4gcGVyIGJ1ZmZlciBmbGFnLgo+ID4g
PiA+Pgo+ID4gPiA+IFJldGhpbmtpbmcgdGhpcyBxdWVzdGlvbiwgSSBmZWVsIHRoZXJlIGlzIG5v
IGVzc2VudGlhbCBkaWZmZXJlbmNlIGJldHdlZW4gcGVyCj4gPiA+ID4gdmlydHF1ZXVlIGFuZCBw
ZXIgc2dzLgo+ID4gPiA+Cj4gPiA+ID4gcGVyIHZpcnRxdWV1ZToKPiA+ID4gPiAgICAgMS4gYWRk
IGJ1ZjoKPiA+ID4gPiAgICAgICAgICAgICBhLiBjaGVjayB2cS0+cHJlbWFwcGVkIGZvciBtYXAg
ZXZlcnkgc2cKPiA+ID4gPiAgICAgMi4gZGV0YWNoOgo+ID4gPiA+ICAgICAgICAgICAgIGEuIGNo
ZWNrIHZxLT5wcmVtYXBlZCBmb3IgdW5tYXAKPiA+ID4gPgo+ID4gPiA+IHBlciBzZ3M6Cj4gPiA+
ID4gICAgIDEuIGFkZCBidWY6Cj4gPiA+ID4gICAgICAgICAgICAgYS4gY2hlY2sgZnVuY3Rpb24g
cGFyYW1ldGVyICJwcmVtYXBwZWQiIGZvciBtYXAgZXZlcnkgc2cKPiA+ID4gPiAgICAgICAgICAg
ICBiLiBhZGQgZmxhZyB0byBleHRyYVtoZWFkXS5mbGFnCj4gPiA+ID4KPiA+ID4gPiAgICAgMi4g
ZGV0YWNoOgo+ID4gPiA+ICAgICAgICAgICAgIGE6IGNoZWNrIGV4dHJhW2hlYWRdLmZsYWcgZm9y
IHVubWFwCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcy4KPiA+ID4KPiA+ID4KPiA+ID4g
UGVyLXZpcnRxdWV1ZSBpcyBzdGlsbCBhIGxpdHRsZSBiaXQgZWFzaWVyIGF0IHRoZSBmaXJzdCBn
bGFuY2UuCj4gPiA+Cj4gPiA+IEFjdHVhbGx5LCBwZXItc2cgaGF2ZSBvbmUgYWR2YW50YWdlOiBp
dCBjYW4gYmUgdXNlZCB3aXRob3V0IHZpcnRxdWV1ZQo+ID4gPiByZXNldCAodG8gYWxsb3cgc3dp
dGNoaW5nIGJldHdlZW4gdGhlIHR3byBtb2RlcykuIEJ1dCBJJ20gbm90IHN1cmUKPiA+ID4gd2hl
dGhlciB3ZSBoYWQgc3VjaCByZXF1aXJlbWVudHMuCj4gPiA+Cj4gPiA+IEkgdGhpbmsgdG8gYW5z
d2VyIHRoaXMgcXVlc3Rpb24sIHdlIHByb2JhYmx5IG5lZWQgYSByZWFsIHVzZSBjYXNlIChpZiB3
ZQo+ID4gPiBjYW4gY29tZSB1cCB3aXRoIGEgY2FzZSB0aGF0IGlzIG1vcmUgbGlnaHR3ZWlnaHQg
dGhhbiBBRl9YRFAsIHRoYXQgd291bGQKPiA+ID4gYmUgZXZlbiBiZXR0ZXIpLgo+ID4KPiA+IFNh
ZGx5LCBJIGRpZG4ndCB0aGluayBvZiBvdGhlciBzY2VuYXJpb3MuIEhvcGUgc29tZW9uZSBjYW4g
Z2l2ZSBhIHNjZW5hcmlvLgo+ID4KPiA+IEZvciBwZXIgdmlydHF1ZXVlLCB2aXJ0aW8tbmV0IHdp
bGwgYWxzbyBzd2l0Y2ggdG8gcHJlbWFwcGVkLiBCZWNhdXNlIHRoZSB0eAo+ID4gcXVldWUgaXMg
c2hhcmVkLgo+ID4KPiA+IEJ1dCBpbiB0aGUgcHJvY2VzcyBvZiBpbXBsZW1lbnRpbmcgdGhpcywg
SSBlbmNvdW50ZXJlZCBhIHRyb3VibGVzb21lIHByb2JsZW0uIFdlCj4gPiBuZWVkIHRvIHJlY29y
ZCB0aGUgZG1hIGFkZHJlc3MgaW4gdmlydG5ldC4gRm9yIHR4LCBzaW5jZSBza2IgY29udGFpbnMg
bXVsdGlwbGUKPiA+IGZyYWdzLCB0aGVyZSB3aWxsIGJlIG1hbnkgZG1hIGFkZHJlc3Nlcy4gV2hl
biB1bm1hcCBpbiB2aXJ0bmV0IEl0IHdpbGwgYmUgbW9yZQo+ID4gdHJvdWJsZXNvbWUuIEJlY2F1
c2Ugd2UgaGF2ZSB0byByZWdhaW4gdGhlc2UgZG1hIGFkZHJlc3Nlcy4KPgo+IFJpZ2h0LCBhY3R1
YWxseSwgd2Ugc3RvcmUgdGhlIGRtYSBhZGRyZXNzIGluIGRlc2NfZXh0cmEsIGJ1dCBleHBvc2lu
Zwo+IGl0IHRvIHRoZSBkcml2ZXIgc2VlbXMgbGlrZSBhbiBvdmVya2lsbC4KPgo+ID4KPiA+IEkg
dGhpbmsgb2YgdHdvIHdheXM6Cj4gPgo+ID4gMS4gTGV0IHZpcnRpbyByZXR1cm4gdGhlIGFkZHIg
b2YgZWFjaCBkZXNjIHdoZW4gZGV0YWNoZWQuCj4gPiAyLiBBbGxvY2F0ZSBhIGJsb2NrIG9mIG1l
bW9yeSBmb3IgZWFjaCBzcS9ycSB0byBob2xkIHRoZSBkbWEgYWRkcmVzcy4KPiA+Cj4gPiBUaGFu
a3MuCj4KPiBTbyBpdCBsb29rcyB0byBtZSBoYXZpbmcgYSBwZXIgYnVmZmVyIGZsYWcgc2VlbXMg
b2suIExldCBtZSBnbyB0aHJvdWdoCj4gdGhpcyBzZXJpZXMuCj4KCk9rLCBzbyB0aGUgc2VyaWVz
IGxvb2tzIGdvb2Qgb3ZlcmFsbCwgYnV0IHdlIG5lZWQgYSB1c2VyLiAgSSB3b25kZXIgaWYKd2Ug
Y2FuIGNvbnZlcnQgWERQIHRvIHVzZSB0aGF0IGFzIGFuIGV4YW1wbGUuIChhbmQgQUZfWERQIG9u
IHRvcCkuCgpUaGFua3MKCj4gVGhhbmtzCj4KPiA+Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4gPgo+
ID4gPgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPj4gU28gd2Uga25vdyBzb21ldGhpbmcgdGhhdCBu
ZWVkcyB0byBiZSBtYXBwZWQgYnkgdmlydGlvIGNvcmUgaXRzZWxmLAo+ID4gPiA+PiBlLmcgdGhl
IGluZGlyZWN0IHBhZ2UuIE90aGVyIHRoYW4gdGhpcywgYWxsIHRoZSByZXN0IGNvdWxkIGJlCj4g
PiA+ID4+IHByZS1tYXBwZWQuCj4gPiA+ID4+Cj4gPiA+ID4+IEZvciB2bmV0IGhlYWRlciwgaXQg
Y291bGQgYmUgbWFwcGVkIGJ5IHZpcnRpby1uZXQgd2hpY2ggY291bGQgYmUgc3RpbGwKPiA+ID4g
Pj4gdHJlYXRlZCBhcyBwcmUgbWFwcGVkIERNQSBzaW5jZSBpdCdzIG5vdCB0aGUgdmlydGlvIHJp
bmcgY29kZS4KPiA+ID4gPj4KPiA+ID4gPj4gQW55dGhpbmcgSSBtaXNzIGhlcmU/Cj4gPiA+ID4+
Cj4gPiA+ID4+IFRoYW5rcwo+ID4gPiA+Pgo+ID4gPiA+Pgo+ID4gPiA+Pj4gVGhhbmtzLgo+ID4g
PiA+Pj4KPiA+ID4gPj4+PiBUaGFua3MKPiA+ID4gPj4+Pgo+ID4gPiA+Pj4+PiB2MToKPiA+ID4g
Pj4+Pj4gICAgIDEuIEFsbCBzZ3MgcmVxdWVzdGVkIGF0IG9uZSB0aW1lIGFyZSByZXF1aXJlZCB0
byBiZSB1bmlmaWVkIFBSRURNQSwgYW5kIHNldmVyYWwKPiA+ID4gPj4+Pj4gICAgICAgIG9mIHRo
ZW0gYXJlIG5vdCBzdXBwb3J0ZWQgdG8gYmUgUFJFRE1BCj4gPiA+ID4+Pj4+ICAgICAyLiB2aXJ0
aW9fZG1hX21hcCgpIGlzIHJlbW92ZWQgZnJvbSB0aGlzIHBhdGNoIHNldCBhbmQgd2lsbCBiZSBz
dWJtaXR0ZWQKPiA+ID4gPj4+Pj4gICAgICAgIHRvZ2V0aGVyIHdpdGggdGhlIG5leHQgdGltZSBB
Rl9YRFAgc3VwcG9ydHMgdmlydGlvIGRtYQo+ID4gPiA+Pj4+PiAgICAgMy4gQWRkZWQgcGF0Y2gg
IzIgIzMgdG8gcmVtb3ZlIHRoZSBjaGVjayBmb3IgZmxhZ3Mgd2hlbiBwZXJmb3JtaW5nIHVubWFw
Cj4gPiA+ID4+Pj4+ICAgICAgICBpbmRpcmVjdCBkZXNjCj4gPiA+ID4+Pj4+Cj4gPiA+ID4+Pj4+
IFh1YW4gWmh1byAoNik6Cj4gPiA+ID4+Pj4+ICAgIHZpcnRpbzogcmVuYW1lIHZyaW5nX3VubWFw
X3N0YXRlX3BhY2tlZCgpIHRvCj4gPiA+ID4+Pj4+ICAgICAgdnJpbmdfdW5tYXBfZXh0cmFfcGFj
a2VkKCkKPiA+ID4gPj4+Pj4gICAgdmlydGlvOiByZW1vdmUgZmxhZ3MgY2hlY2sgZm9yIHVubWFw
IHNwbGl0IGluZGlyZWN0IGRlc2MKPiA+ID4gPj4+Pj4gICAgdmlydGlvOiByZW1vdmUgZmxhZ3Mg
Y2hlY2sgZm9yIHVubWFwIHBhY2tlZCBpbmRpcmVjdCBkZXNjCj4gPiA+ID4+Pj4+ICAgIHZpcnRp
bzogdmlydHF1ZXVlX2FkZCgpIHN1cHBvcnQgcHJlZG1hCj4gPiA+ID4+Pj4+ICAgIHZpcnRpbzog
c3BsaXQ6IHZpcnRxdWV1ZV9hZGRfc3BsaXQoKSBzdXBwb3J0IGRtYSBhZGRyZXNzCj4gPiA+ID4+
Pj4+ICAgIHZpcnRpbzogcGFja2VkOiB2aXJ0cXVldWVfYWRkX3BhY2tlZCgpIHN1cHBvcnQgZG1h
IGFkZHJlc3MKPiA+ID4gPj4+Pj4KPiA+ID4gPj4+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jIHwgMTk5ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCj4gPiA+ID4+
Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEyNiBpbnNlcnRpb25zKCspLCA3MyBkZWxldGlvbnMoLSkK
PiA+ID4gPj4+Pj4KPiA+ID4gPj4+Pj4gLS0KPiA+ID4gPj4+Pj4gMi4zMS4wCj4gPiA+ID4+Pj4+
Cj4gPiA+Cj4gPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
