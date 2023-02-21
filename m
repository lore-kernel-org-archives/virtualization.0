Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F71C6379F
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 12:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90EF482A83;
	Tue, 21 Feb 2023 12:29:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90EF482A83
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=QU9Sy9oM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xlPXb1wkCZzG; Tue, 21 Feb 2023 12:29:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D6538827D8;
	Tue, 21 Feb 2023 12:29:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6538827D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD4F7C0033;
	Tue, 21 Feb 2023 12:29:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 807B7C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 12:29:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B15F42CE6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 12:29:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B15F42CE6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com
 header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=QU9Sy9oM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mYAF_bt8a9GX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 12:29:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D56842CBB
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D56842CBB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 12:29:31 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id ee7so1424574edb.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 04:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yPNUlcZMBhrjIgLpJx3TAFo49SK7Sn/N+0dd4lpy5r4=;
 b=QU9Sy9oM/2YIMMU4vK16zNUL84LlqbKfVsF4kwcRv/ueBjtkBZa4C3lWWxXAc5SdzH
 40ico2/9qhpITQYT5rzi20H56PU6tCHFTPofXD4PWqbDMJJSfi/PSS54rwNuu5VFne5R
 ZL6MP7L8vpdnkMnYH7UueMW54hU3xoLqYnHHel6Fcvrfev8dCNj4/oy45VPbnLv+wRYV
 YeRi1dmhLnUrg7TLeVB+gl6oOBC8WbFOiZc6VlDQ+YBtiIsjG40mb0WSR5/uRem+x2nc
 qZMDK3Fo/Xn9BViWeI2CeByuqcJKWfK8O1lb+lp2l9f6+YlMQqj4eOOtUVkKr1kNLY8l
 g/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yPNUlcZMBhrjIgLpJx3TAFo49SK7Sn/N+0dd4lpy5r4=;
 b=DF4INe0RmEF8w9fHUsOSIfkgGEx6wZKfzLQ9r7f/j6MDkc72VAOAaeVV3xfDgAh/dJ
 K8KK8sNGVAr6tqzph5ZEI6BhjIt5ByebmthQ6EcoEV+/+IBaDjAPk/6Y5TzeAl4Z7ETQ
 KU94cw+fVE/dM6MzUzUhoWWTHfdXVXeG8zKyU1anyDLqCcqnF/hTm0uWYB+qhC0MNVQH
 RwsIISH1b2Vnq2TYMZaIiKUC1ogQApFw8wozMUCyffFv94NeK7EBamZOq47nwY+b6PuW
 FwGG6N7hAoDwAqGwIXYG4l7E9Ifg5aAZr/au18srM0N8X/ylQkNjGBl5WmFgbGbXXtv9
 La6A==
X-Gm-Message-State: AO0yUKWcwT+VFMVmvYnuBY729QnEQrYGKsZufsfvLB+gGVkyTHQiHEhg
 v29xHTpk5XZ/tbskqeuLIm7AxA==
X-Google-Smtp-Source: AK7set/WE/4jcq71W5OC19pxOo6brwpC18w8vr4W0gSDRYYU3pLBET5CnIcnluiBj6UxHmQLi2E+Ig==
X-Received: by 2002:a17:907:6025:b0:878:683c:f0d1 with SMTP id
 fs37-20020a170907602500b00878683cf0d1mr9909884ejc.38.1676982569540; 
 Tue, 21 Feb 2023 04:29:29 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 n4-20020a170906724400b008df97fae83dsm718201ejk.91.2023.02.21.04.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Feb 2023 04:29:28 -0800 (PST)
Date: Tue, 21 Feb 2023 13:29:27 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [patch net-next] net: virtio_net: implement exact header length
 guest feature
Message-ID: <Y/S5J3wZ8CDB6lVT@nanopsycho>
References: <20230217121547.3958716-1-jiri@resnulli.us>
 <20230217072032-mutt-send-email-mst@kernel.org>
 <Y+94418p73aUQyIn@nanopsycho>
 <20230217083915-mutt-send-email-mst@kernel.org>
 <Y/MwtAGru3yAY7r3@nanopsycho>
 <20230220074947-mutt-send-email-mst@kernel.org>
 <Y/N7+IJ+gzvP0IEf@nanopsycho>
 <cc14248c-cd6c-d604-003c-7384363dab8e@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cc14248c-cd6c-d604-003c-7384363dab8e@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Vitaly Mireyno <vmireyno@marvell.com>,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

VHVlLCBGZWIgMjEsIDIwMjMgYXQgMDM6Mzg6MTBBTSBDRVQsIGphc293YW5nQHJlZGhhdC5jb20g
d3JvdGU6Cj4KPuWcqCAyMDIzLzIvMjAgMjE6NTYsIEppcmkgUGlya28g5YaZ6YGTOgo+PiBNb24s
IEZlYiAyMCwgMjAyMyBhdCAwMTo1NTozM1BNIENFVCwgbXN0QHJlZGhhdC5jb20gd3JvdGU6Cj4+
ID4gT24gTW9uLCBGZWIgMjAsIDIwMjMgYXQgMDk6MzU6MDBBTSArMDEwMCwgSmlyaSBQaXJrbyB3
cm90ZToKPj4gPiA+IEZyaSwgRmViIDE3LCAyMDIzIGF0IDAyOjQ3OjM2UE0gQ0VULCBtc3RAcmVk
aGF0LmNvbSB3cm90ZToKPj4gPiA+ID4gT24gRnJpLCBGZWIgMTcsIDIwMjMgYXQgMDE6NTM6NTVQ
TSArMDEwMCwgSmlyaSBQaXJrbyB3cm90ZToKPj4gPiA+ID4gPiBGcmksIEZlYiAxNywgMjAyMyBh
dCAwMToyMjowMVBNIENFVCwgbXN0QHJlZGhhdC5jb20gd3JvdGU6Cj4+ID4gPiA+ID4gPiBPbiBG
cmksIEZlYiAxNywgMjAyMyBhdCAwMToxNTo0N1BNICswMTAwLCBKaXJpIFBpcmtvIHdyb3RlOgo+
PiA+ID4gPiA+ID4gPiBGcm9tOiBKaXJpIFBpcmtvIDxqaXJpQG52aWRpYS5jb20+Cj4+ID4gPiA+
ID4gPiA+IAo+PiA+ID4gPiA+ID4gPiB2aXJ0aW9fbmV0X2hkcl9mcm9tX3NrYigpIGZpbGxzIHVw
IGhkcl9sZW4gdG8gc2tiX2hlYWRsZW4oc2tiKS4KPj4gPiA+ID4gPiA+ID4gCj4+ID4gPiA+ID4g
PiA+IFZpcnRpbyBzcGVjIGludHJvZHVjZWQgYSBmZWF0dXJlIFZJUlRJT19ORVRfRl9HVUVTVF9I
RFJMRU4gd2hpY2ggd2hlbgo+PiA+ID4gPiA+ID4gPiBzZXQgaW1wbGljYXRlcyB0aGF0IHRoZSBk
cml2ZXIgcHJvdmlkZXMgdGhlIGV4YWN0IHNpemUgb2YgdGhlIGhlYWRlci4KPj4gPiA+ID4gPiA+
ID4gCj4+ID4gPiA+ID4gPiA+IFRoZSBkcml2ZXIgYWxyZWFkeSBjb21wbGllcyB0byBmaWxsIHRo
ZSBjb3JyZWN0IHZhbHVlLiBJbnRyb2R1Y2UgdGhlCj4+ID4gPiA+ID4gPiA+IGZlYXR1cmUgYW5k
IGFkdmVydGlzZSBpdC4KPj4gPiA+ID4gPiA+ID4gCj4+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEppcmkgUGlya28gPGppcmlAbnZpZGlhLmNvbT4KPj4gPiA+ID4gPiA+IENvdWxkIHlvdSBh
ZGQgYSBiaXQgb2YgbW90aXZhdGlvbiBqdXN0IGZvciB0aGUgcmVjb3JkPwo+PiA+ID4gPiA+ID4g
RG9lcyB0aGlzIGltcHJvdmUgcGVyZm9ybWFuY2UgZm9yIHNvbWUgY2FyZD8gQnkgaG93IG11Y2g/
Cj4+ID4gPiA+ID4gPiBFeHBlY3RlZCB0byBoZWxwIHNvbWUgZnV0dXJlIGNhcmQ/Cj4+ID4gPiA+
ID4gSSBjYW4gZ2V0IHRoYXQgaW5mbywgYnV0IGlzbid0IHRoYXQgcmF0aGVyIHNvbWV0aGluZyB0
byBiZSBhcHBlbmRlZCB0bwo+PiA+ID4gPiA+IHRoZSB2aXJ0aW8tc3BlYyBwYXRjaD8gSSBtZWFu
LCB0aGUgZmVhdHVyZSBpcyB0aGVyZSwgdGhpcyBpcyBqdXN0Cj4+ID4gPiA+ID4gaW1wbGVtZW50
aW5nIGl0IGluIG9uZSBkcml2ZXIuCj4+ID4gPiA+IEl0IGlzIG1vcmUgbGlrZSB1c2luZyBpdCBp
biB0aGUgZHJpdmVyLiAgSXQncyBub3QgbGlrZSB3ZSBoYXZlIHRvIHVzZQo+PiA+ID4gPiBldmVy
eXRoaW5nIC0gaXQgY291bGQgYmUgdXNlZnVsIGZvciBlLmcuIGRwZGsgYnV0IG5vdCBsaW51eC4K
Pj4gPiA+ID4gSW1wbGVtZW50aW5nIGl0IGluIHRoZSBMaW51eCBkcml2ZXIgaGFzIHN1cHBvcnQg
Y29zdHMgLSBmb3IgZXhhbXBsZSB3aGF0Cj4+ID4gPiA+IGlmIHRoZXJlJ3MgYSBidWcgYW5kIHNv
bWV0aW1lcyB0aGUgbGVuZ3RoIGlzIGluY29ycmVjdD8KPj4gPiA+ID4gV2UnbGwgYmUgYnJlYWtp
bmcgdGhpbmdzLgo+PiA+ID4gSSB1bmRlcnN0YW5kLiBUbyBteSB1bmRlcnN0YW5kaW5nIHRoaXMg
ZmVhdHVyZSBqdXN0IGZpeGVzIHRoZSBvcmlnaW5hbAo+PiA+ID4gYW1iaWd1aXR5IGluIHRoZSB2
aXJ0aW8gc3BlYy4KPj4gPiA+IAo+PiA+ID4gUXVvdGluZyB0aGUgb3JpZ2luYWwgdmlydGlvIHNw
ZWM6Cj4+ID4gPiAiaGRyX2xlbiBpcyBhIGhpbnQgdG8gdGhlIGRldmljZSBhcyB0byBob3cgbXVj
aCBvZiB0aGUgaGVhZGVyIG5lZWRzIHRvCj4+ID4gPiAgIGJlIGtlcHQgdG8gY29weSBpbnRvIGVh
Y2ggcGFja2V0Igo+PiA+ID4gCj4+ID4gPiAiYSBoaW50IiBtaWdodCBub3QgYmUgY2xlYXIgZm9y
IHRoZSByZWFkZXIgd2hhdCBkb2VzIGl0IG1lYW4sIGlmIGl0IGlzCj4+ID4gPiAibWF5YmUgbGlr
ZSB0aGF0IiBvZiAiZXhhY3RseSBsaWtlIHRoYXQiLiBUaGlzIGZlYXR1cmUganVzdCBtYWtlcyBp
dAo+PiA+ID4gY3J5c3RhbCBjbGVhci4KPj4gPiA+IAo+PiA+ID4gSWYgeW91IGxvb2sgYXQgdGhl
IHRhcCBpbXBsZW1lbnRhdGlvbiwgaXQgdXNlcyBoZHJfbGVuIHRvIGFsbG9jCj4+ID4gPiBza2Ig
bGluZWFyIHBhcnQuIE5vIGhpbnQsIGl0IGNvdW50cyB3aXRoIHRoZSBwcm92aWRlZCB2YWx1ZS4K
Pj4gPiA+IFNvIGlmIHRoZSBkcml2ZXIgaXMgY3VycmVudGx5IG5vdCBwcmVjaXNlLCBpdCBicmVh
a3MgdGFwLgo+PiA+IFdlbGwgdGhhdCdzIG9ubHkgZm9yIGdzbyB0aG91Z2ggcmlnaHQ/Cj4+IFll
cC4KPj4gCj4+IAo+PiA+IEFuZCBtYWtpbmcgaXQgYmlnZ2VyIHRoYW4gbmVjZXNzYXJ5IHdvcmtz
IGZpbmUgLi4uCj4+IFdlbGwgeWVhaC4gQnV0IHRhcCBkb2VzIG5vdCBkbyB0aGF0LCBkb2VzIGl0
PyBpdCB1c2VzIGhkcl9sZW4gZGlyZWN0bHkuCj4KPgo+dGFwX2dldF91c2VyKCkgbGltaXQgdGhl
IGhlYWQgbGVuZ3RoOgo+Cj4KPnN0YXRpYyBzc2l6ZV90IHRhcF9nZXRfdXNlcihzdHJ1Y3QgdGFw
X3F1ZXVlICpxLCB2b2lkICptc2dfY29udHJvbCwKPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaW92X2l0ZXIgKmZyb20sIGludCBu
b2Jsb2NrKQo+ewo+wqDCoCDCoGludCBnb29kX2xpbmVhciA9IFNLQl9NQVhfSEVBRChUQVBfUkVT
RVJWRSk7Cj4uLi4KPgo+Cj4+IAo+PiAKPj4gPiA+IEkgd2lsbCBhZGQgdGhpcyB0byB0aGUgcGF0
Y2ggZGVzY3JpcHRpb24gYW5kIHNlbmQgdjIuCj4+ID4gPiAKPj4gPiBJIGZlZWwgdGhpcyBkb2Vz
IG5vdCBhbnN3ZXIgdGhlIHF1ZXN0aW9uIHlldCwgb3IgbWF5YmUgSSBhbSBiZWluZyBkZW5zZS4K
Pj4gPiBNeSBwb2ludCB3YXMgbm90IGFib3V0IG1ha2luZyBoZHJfbGVuIHByZWNpc2UuICBNeSBw
b2ludCB3YXMgdGhhdCB3ZSBhcmUKPj4gPiBtYWtpbmcgYSBjaGFuZ2UgaGVyZSBmb3Igbm8gYXBw
YXJlbnQgcmVhc29uLiBJIGFtIGd1ZXNzaW5nIHlvdSBhcmUgbm90Cj4+ID4gZG9pbmcgaXQgZm9y
IGZ1biAtIHNvIHdoeT8gSXMgdGhlcmUgYSBkZXZpY2Ugd2l0aCB0aGlzIGZlYXR1cmUgYml0Cj4+
ID4geW91IGFyZSBhd2FyZSBvZj8KPj4gQWZhaWsgcmVhbCBodyB3aGljaCBkb2VzIGVtdWxhdGlv
biBvZiB2aXJ0aW9fbmV0IHdvdWxkIGJlbmVmaXQgZnJvbQo+PiB0aGF0LCBvdXIgaHcgaW5jbHVk
aW5nLgo+Cj4KPk5vdGUgdGhhdCBkcml2ZXIgY2FuIGNob29zZSB0byBubyBuZWdvdGlhdGUgdGhp
cyBmZWF0dXJlLCBzbyBtYWxpY2lvdXMKPmRyaXZlcnMgY2FuIHN0aWxsIHRyeSB0byB1c2UgaWxs
ZWdhbCB2YWx1ZS4KClRoYXQncyBwcm9iYWJseSB3aHkgdGhlIHNwZWMgc2F5czoKNS4xLjYuMi4y
Ci4uLgpOb3RlOiBDYXV0aW9uIHNob3VsZCBiZSB0YWtlbiBieSB0aGUgaW1wbGVtZW50YXRpb24g
c28gYXMgdG8gcHJldmVudCBhIG1hbGljaW91cyBkcml2ZXIgZnJvbSBhdHRhY2tpbmcKdGhlIGRl
dmljZSBieSBzZXR0aW5nIGFuIGluY29ycmVjdCBoZHJfbGVuLgoKQW5kIHRoYXQgaXMgZXhhY3Rs
eSB3aGF0IHR1biBkb2VzIGJ5IGNhcGluZyB0aGUgbGluZWFyIHNpemUgdG8KU0tCX01BWF9IRUFE
KFRBUF9SRVNFUlZFKQoKCgo+Cj5UaGFua3MKPgo+Cj4+IAo+PiAKPj4gPiAKPj4gPiAKPj4gPiA+
ID4gVGhlIHBhdGNoIHdhcyBzdWJtaXR0ZWQgYnkgTWFydmVsbCBidXQgdGhleSBuZXZlciBib3Ro
ZXJlZCB3aXRoCj4+ID4gPiA+IHVzaW5nIGl0IGluIExpbnV4LiBJIGd1ZXNzIHRoZXkgYXJlIHVz
aW5nIGl0IGZvciBzb21ldGhpbmcgZWxzZT8KPj4gPiA+ID4gQ0MgVml0YWx5IHdobyBwdXQgdGhp
cyBpbi4KPj4gPiA+ID4gCj4+ID4gPiA+ID4gPiB0aGFua3MhCj4+ID4gPiA+ID4gPiAKPj4gPiA+
ID4gPiA+IAo+PiA+ID4gPiA+ID4gPiAtLS0KPj4gPiA+ID4gPiA+ID4gICBkcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgICAgICAgIHwgNiArKysrLS0KPj4gPiA+ID4gPiA+ID4gICBpbmNsdWRlL3Vh
cGkvbGludXgvdmlydGlvX25ldC5oIHwgMSArCj4+ID4gPiA+ID4gPiA+ICAgMiBmaWxlcyBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+ID4gPiA+ID4gPiA+IAo+PiA+
ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4+ID4gPiA+ID4gPiA+IGluZGV4IGZiNWU2OGVkM2VjMi4uZTg1
YjAzOTg4NzMzIDEwMDY0NAo+PiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKPj4gPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+ID4g
PiA+ID4gPiA+IEBAIC02Miw3ICs2Miw4IEBAIHN0YXRpYyBjb25zdCB1bnNpZ25lZCBsb25nIGd1
ZXN0X29mZmxvYWRzW10gPSB7Cj4+ID4gPiA+ID4gPiA+ICAgCVZJUlRJT19ORVRfRl9HVUVTVF9V
Rk8sCj4+ID4gPiA+ID4gPiA+ICAgCVZJUlRJT19ORVRfRl9HVUVTVF9DU1VNLAo+PiA+ID4gPiA+
ID4gPiAgIAlWSVJUSU9fTkVUX0ZfR1VFU1RfVVNPNCwKPj4gPiA+ID4gPiA+ID4gLQlWSVJUSU9f
TkVUX0ZfR1VFU1RfVVNPNgo+PiA+ID4gPiA+ID4gPiArCVZJUlRJT19ORVRfRl9HVUVTVF9VU082
LAo+PiA+ID4gPiA+ID4gPiArCVZJUlRJT19ORVRfRl9HVUVTVF9IRFJMRU4KPj4gPiA+ID4gPiA+
ID4gICB9Owo+PiA+ID4gPiA+ID4gPiAgICNkZWZpbmUgR1VFU1RfT0ZGTE9BRF9HUk9fSFdfTUFT
SyAoKDFVTEwgPDwgVklSVElPX05FVF9GX0dVRVNUX1RTTzQpIHwgXAo+PiA+ID4gPiA+ID4gPiBA
QCAtNDIxMyw3ICs0MjE0LDggQEAgc3RhdGljIHN0cnVjdCB2aXJ0aW9fZGV2aWNlX2lkIGlkX3Rh
YmxlW10gPSB7Cj4+ID4gPiA+ID4gPiA+ICAgCVZJUlRJT19ORVRfRl9DVFJMX01BQ19BRERSLCBc
Cj4+ID4gPiA+ID4gPiA+ICAgCVZJUlRJT19ORVRfRl9NVFUsIFZJUlRJT19ORVRfRl9DVFJMX0dV
RVNUX09GRkxPQURTLCBcCj4+ID4gPiA+ID4gPiA+ICAgCVZJUlRJT19ORVRfRl9TUEVFRF9EVVBM
RVgsIFZJUlRJT19ORVRfRl9TVEFOREJZLCBcCj4+ID4gPiA+ID4gPiA+IC0JVklSVElPX05FVF9G
X1JTUywgVklSVElPX05FVF9GX0hBU0hfUkVQT1JULCBWSVJUSU9fTkVUX0ZfTk9URl9DT0FMCj4+
ID4gPiA+ID4gPiA+ICsJVklSVElPX05FVF9GX1JTUywgVklSVElPX05FVF9GX0hBU0hfUkVQT1JU
LCBWSVJUSU9fTkVUX0ZfTk9URl9DT0FMLCBcCj4+ID4gPiA+ID4gPiA+ICsJVklSVElPX05FVF9G
X0dVRVNUX0hEUkxFTgo+PiA+ID4gPiA+ID4gPiAgIHN0YXRpYyB1bnNpZ25lZCBpbnQgZmVhdHVy
ZXNbXSA9IHsKPj4gPiA+ID4gPiA+ID4gICAJVklSVE5FVF9GRUFUVVJFUywKPj4gPiA+ID4gPiA+
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fbmV0LmggYi9pbmNsdWRl
L3VhcGkvbGludXgvdmlydGlvX25ldC5oCj4+ID4gPiA+ID4gPiA+IGluZGV4IGI0MDYyYmVkMTg2
YS4uMTJjMWM5Njk5OTM1IDEwMDY0NAo+PiA+ID4gPiA+ID4gPiAtLS0gYS9pbmNsdWRlL3VhcGkv
bGludXgvdmlydGlvX25ldC5oCj4+ID4gPiA+ID4gPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fbmV0LmgKPj4gPiA+ID4gPiA+ID4gQEAgLTYxLDYgKzYxLDcgQEAKPj4gPiA+ID4g
PiA+ID4gICAjZGVmaW5lIFZJUlRJT19ORVRfRl9HVUVTVF9VU082CTU1CS8qIEd1ZXN0IGNhbiBo
YW5kbGUgVVNPdjYgaW4uICovCj4+ID4gPiA+ID4gPiA+ICAgI2RlZmluZSBWSVJUSU9fTkVUX0Zf
SE9TVF9VU08JNTYJLyogSG9zdCBjYW4gaGFuZGxlIFVTTyBpbi4gKi8KPj4gPiA+ID4gPiA+ID4g
ICAjZGVmaW5lIFZJUlRJT19ORVRfRl9IQVNIX1JFUE9SVCAgNTcJLyogU3VwcG9ydHMgaGFzaCBy
ZXBvcnQgKi8KPj4gPiA+ID4gPiA+ID4gKyNkZWZpbmUgVklSVElPX05FVF9GX0dVRVNUX0hEUkxF
TiAgNTkJLyogR3Vlc3QgcHJvdmlkZXMgdGhlIGV4YWN0IGhkcl9sZW4gdmFsdWUuICovCj4+ID4g
PiA+ID4gPiA+ICAgI2RlZmluZSBWSVJUSU9fTkVUX0ZfUlNTCSAgNjAJLyogU3VwcG9ydHMgUlNT
IFJYIHN0ZWVyaW5nICovCj4+ID4gPiA+ID4gPiA+ICAgI2RlZmluZSBWSVJUSU9fTkVUX0ZfUlND
X0VYVAkgIDYxCS8qIGV4dGVuZGVkIGNvYWxlc2NpbmcgaW5mbyAqLwo+PiA+ID4gPiA+ID4gPiAg
ICNkZWZpbmUgVklSVElPX05FVF9GX1NUQU5EQlkJICA2MgkvKiBBY3QgYXMgc3RhbmRieSBmb3Ig
YW5vdGhlciBkZXZpY2UKPj4gPiA+ID4gPiA+ID4gLS0gCj4+ID4gPiA+ID4gPiA+IDIuMzkuMAo+
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
