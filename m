Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B761CC47083
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 06:00:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3456140F
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 06:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3456140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A187405A9;
	Fri,  4 Jun 2021 06:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dk6jLIiTOvXb; Fri,  4 Jun 2021 06:00:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8ED27400F3;
	Fri,  4 Jun 2021 06:00:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BA16C000E;
	Fri,  4 Jun 2021 06:00:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9339C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 06:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2A0984036
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 06:00:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ALhzaHUUZfrh
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 06:00:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ACDF384330
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 06:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622786417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iBJhxtrnOYsi+Y8OaVI5OTALm56FJkC4KNF0o6yFuxQ=;
 b=dcpQ1zotfoZfmOBuIw0qX4gAr5DY8iohVP4wt9HMLps6ieDQdCRyO6Aa+dhhhxKTqMQ1R2
 +P0jKKiPvEaQUz1wD5HLDxjIApHqC+T+u0KxQpThYo9iDtTFzJeEH8OZJh+W9ihdW6b5vL
 P2T4WjsCtZSpX5ftQIYxzPnQpYOk8Pw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-oyGx-avKMj-Xtw7eeOI61g-1; Fri, 04 Jun 2021 02:00:15 -0400
X-MC-Unique: oyGx-avKMj-Xtw7eeOI61g-1
Received: by mail-pf1-f197.google.com with SMTP id
 j206-20020a6280d70000b02902e9e02e1654so4822768pfd.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 23:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=iBJhxtrnOYsi+Y8OaVI5OTALm56FJkC4KNF0o6yFuxQ=;
 b=qf03UyF95Y9HbyvJLuAGpY0ez9fegiGG3WJqTfcZUfBv80ox+dDaITETE6ZZ4FQV32
 PmnWD/cH93A5hiprMdS9af6cgMqQGQPGEwf61Sk2VGOdMUYuaJsQk7qz4Mpj4oyzAZCy
 mbLl4+aaRRsGR2vbYjFpApzVxT6lIdChSarBunsKtbY3bRZz65dGXwxnZPHUFHuBKdc4
 jkBDGoDMopzfYw+uDiHgwToRxiv/ngc5eYGK6w8ZJqIRELDmEXONo7faiQsRnmC+hR13
 5/EGwNrsyhcWk4z0W/l0lWFdC3q12mtEj/7wImLaO5vjIxvXhtvJ+EgHJyIeF/HzeWv1
 c4Wg==
X-Gm-Message-State: AOAM533u44jl5BwMDmRbh93sp7lh+J7eUKHKKBSeIdmuR35z47MbaSLs
 9FtyYNGCltRNKlbsCGxFERADUS7k/p1HjWcWQcoMXWzN/efaE+CrxsYxyt1TQySXTTBT12OjOeK
 jgoAHWdUb+3uONGieKCZjiyMFg3b+euQCrwYQme7xtQ==
X-Received: by 2002:a63:5504:: with SMTP id j4mr3327253pgb.238.1622786414125; 
 Thu, 03 Jun 2021 23:00:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxD4rpw/wgVIft/eHf0FtdHuY/ufgrcGmVbrjoybgnSsV4bV+QXRJn9+kFtfgsyckxGF9Adg==
X-Received: by 2002:a63:5504:: with SMTP id j4mr3327226pgb.238.1622786413831; 
 Thu, 03 Jun 2021 23:00:13 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m12sm3598393pjq.53.2021.06.03.23.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 23:00:13 -0700 (PDT)
Subject: Re: [PATCH net] virtio-net: fix for skb_over_panic inside big mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1622775955.0233824-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <620c6905-d528-1992-a08e-b22b21871f7e@redhat.com>
Date: Fri, 4 Jun 2021 14:00:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1622775955.0233824-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 =?UTF-8?Q?Corentin_No=c3=abl?= <corentin.noel@collabora.com>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIxLzYvNCDkuIrljYgxMTowNSwgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBGcmksIDQg
SnVuIDIwMjEgMTE6MDA6MjUgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+PiDlnKggMjAyMS82LzQg5LiK5Y2IMTA6MzAsIFh1YW4gWmh1byDlhpnpgZM6Cj4+
PiBPbiBGcmksIDQgSnVuIDIwMjEgMTA6Mjg6NDEgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+IOWcqCAyMDIxLzYvNCDkuIrljYgxOjA5LCBYdWFuIFpo
dW8g5YaZ6YGTOgo+Pj4+PiBJbiB2aXJ0aW8tbmV0J3MgbGFyZ2UgcGFja2V0IG1vZGUsIHRoZXJl
IGlzIGEgaG9sZSBpbiB0aGUgc3BhY2UgYmVoaW5kCj4+Pj4+IGJ1Zi4KPj4+PiBiZWZvcmUgdGhl
IGJ1ZiBhY3R1YWxseSBvciBiZWhpbmQgdGhlIHZuZXQgaGVhZGVyPwo+Pj4+Cj4+Pj4KPj4+Pj4g
ICAgICAgIGhkcl9wYWRkZWRfbGVuIC0gaGRyX2xlbgo+Pj4+Pgo+Pj4+PiBXZSBtdXN0IHRha2Ug
dGhpcyBpbnRvIGFjY291bnQgd2hlbiBjYWxjdWxhdGluZyB0YWlscm9vbS4KPj4+Pj4KPj4+Pj4g
WyAgIDQ0LjU0NDM4NV0gc2tiX3B1dC5jb2xkIChuZXQvY29yZS9za2J1ZmYuYzo1MjU0IChkaXNj
cmltaW5hdG9yIDEpIG5ldC9jb3JlL3NrYnVmZi5jOjUyNTIgKGRpc2NyaW1pbmF0b3IgMSkpCj4+
Pj4+IFsgICA0NC41NDQ4NjRdIHBhZ2VfdG9fc2tiIChkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmM6
NDg1KSBbICAgNDQuNTQ1MzYxXSByZWNlaXZlX2J1ZiAoZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Ojg0OSBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmM6MTEzMSkKPj4+Pj4gWyAgIDQ0LjU0NTg3MF0g
PyBuZXRpZl9yZWNlaXZlX3NrYl9saXN0X2ludGVybmFsIChuZXQvY29yZS9kZXYuYzo1NzE0KQo+
Pj4+PiBbICAgNDQuNTQ2NjI4XSA/IGRldl9ncm9fcmVjZWl2ZSAobmV0L2NvcmUvZGV2LmM6NjEw
MykKPj4+Pj4gWyAgIDQ0LjU0NzEzNV0gPyBuYXBpX2NvbXBsZXRlX2RvbmUgKC4vaW5jbHVkZS9s
aW51eC9saXN0Lmg6MzUgbmV0L2NvcmUvZGV2LmM6NTg2NyBuZXQvY29yZS9kZXYuYzo1ODYyIG5l
dC9jb3JlL2Rldi5jOjY1NjUpCj4+Pj4+IFsgICA0NC41NDc2NzJdIHZpcnRuZXRfcG9sbCAoZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jOjE0MjcgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jOjE1MjUp
Cj4+Pj4+IFsgICA0NC41NDgyNTFdIF9fbmFwaV9wb2xsIChuZXQvY29yZS9kZXYuYzo2OTg1KQo+
Pj4+PiBbICAgNDQuNTQ4NzQ0XSBuZXRfcnhfYWN0aW9uIChuZXQvY29yZS9kZXYuYzo3MDU0IG5l
dC9jb3JlL2Rldi5jOjcxMzkpCj4+Pj4+IFsgICA0NC41NDkyNjRdIF9fZG9fc29mdGlycSAoLi9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9qdW1wX2xhYmVsLmg6MTkgLi9pbmNsdWRlL2xpbnV4L2p1bXBf
bGFiZWwuaDoyMDAgLi9pbmNsdWRlL3RyYWNlL2V2ZW50cy9pcnEuaDoxNDIga2VybmVsL3NvZnRp
cnEuYzo1NjApCj4+Pj4+IFsgICA0NC41NDk3NjJdIGlycV9leGl0X3JjdSAoa2VybmVsL3NvZnRp
cnEuYzo0MzMga2VybmVsL3NvZnRpcnEuYzo2Mzcga2VybmVsL3NvZnRpcnEuYzo2NDkpCj4+Pj4+
IFsgICA0NC41NTEzODRdIGNvbW1vbl9pbnRlcnJ1cHQgKGFyY2gveDg2L2tlcm5lbC9pcnEuYzoy
NDAgKGRpc2NyaW1pbmF0b3IgMTMpKQo+Pj4+PiBbICAgNDQuNTUxOTkxXSA/IGFzbV9jb21tb25f
aW50ZXJydXB0ICguL2FyY2gveDg2L2luY2x1ZGUvYXNtL2lkdGVudHJ5Lmg6NjM4KQo+Pj4+PiBb
ICAgNDQuNTUyNjU0XSBhc21fY29tbW9uX2ludGVycnVwdCAoLi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9pZHRlbnRyeS5oOjYzOCkKPj4+Pj4KPj4+Pj4gRml4ZXM6IGZiMzI4NTZiMTZhZCAoInZpcnRp
by1uZXQ6IHBhZ2VfdG9fc2tiKCkgdXNlIGJ1aWxkX3NrYiB3aGVuIHRoZXJlJ3Mgc3VmZmljaWVu
dCB0YWlscm9vbSIpCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+Cj4+Pj4+IFJlcG9ydGVkLWJ5OiBDb3JlbnRpbiBOb8OrbCA8Y29yZW50
aW4ubm9lbEBjb2xsYWJvcmEuY29tPgo+Pj4+PiBUZXN0ZWQtYnk6IENvcmVudGluIE5vw6tsIDxj
b3JlbnRpbi5ub2VsQGNvbGxhYm9yYS5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiAgICAgZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIHwgMiArLQo+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+Pj4gaW5kZXggZmE0
MDdlYjhiNDU3Li43OGEwMWM3MWExN2MgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+Pj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+Pj4gQEAg
LTQwNiw3ICs0MDYsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVj
dCB2aXJ0bmV0X2luZm8gKnZpLAo+Pj4+PiAgICAgCSAqIGFkZF9yZWN2YnVmX21lcmdlYWJsZSgp
ICsgZ2V0X21lcmdlYWJsZV9idWZfbGVuKCkKPj4+Pj4gICAgIAkgKi8KPj4+Pj4gICAgIAl0cnVl
c2l6ZSA9IGhlYWRyb29tID8gUEFHRV9TSVpFIDogdHJ1ZXNpemU7Cj4+Pj4+IC0JdGFpbHJvb20g
PSB0cnVlc2l6ZSAtIGxlbiAtIGhlYWRyb29tOwo+Pj4+PiArCXRhaWxyb29tID0gdHJ1ZXNpemUg
LSBsZW4gLSBoZWFkcm9vbSAtIChoZHJfcGFkZGVkX2xlbiAtIGhkcl9sZW4pOwo+Pj4+IFRoZSBw
YXRjaCBsb29rcyBjb3JyZWN0IGFuZCBJIHNhdyBpdCBoYXMgYmVlbiBtZXJnZWQuCj4+Pj4KPj4+
PiBCdXQgSSBwcmVmZXIgdG8gZG8gdGhhdCBpbiByZWNlaXZlX2JpZygpIGluc3RlYWQgb2YgaGVy
ZS4KPj4+Pgo+Pj4+IFRoYW5rcwo+Pj4gSG93Pwo+Pj4KPj4+IGNoYW5nZSB0cnVlc2l6ZSBvciBo
ZWFkcm9vbT8KPj4+Cj4+PiBJIGRpZG4ndCBmaW5kIGEgZ29vZCB3YXkuIERvIHlvdSBoYXZlIGEg
Z29vZCB3YXk/Cj4+Cj4+IFNvbWV0aGluZyBsaWtlIHRoZSBmb2xsb3dpbmc/IFRoZSBBUEkgaXMg
ZGVzaWduZWQgdG8gbGV0IHRoZSBjYWxsZXIgdG8KPj4gcGFzcyBhIGNvcnJlY3QgaGVhZHJvb20g
aW5zdGVhZCBvZiBmaWd1cmUgaXQgb3V0IGJ5IGl0c2VsZi4KPj4KPj4gICDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiID0KPj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcGFnZV90b19za2IodmksIHJxLCBwYWdlLCAwLCBsZW4sIFBBR0VfU0laRSwgdHJ1ZSwgMCwK
Pj4gaGRyX3BhZGRlZF9sZW4gLSBoZHJfbGVuKTsKPj4KPj4gVGhhbmtzCj4KPiBUaGlzIGxpbmUg
bWF5IGJlIGFmZmVjdGVkLgo+Cj4gCWJ1ZiA9IHAgLSBoZWFkcm9vbTsKPgo+IEluIG15IG9waW5p
b24sIHRoaXMgY2hhbmdlcyB0aGUgc2VtYW50aWNzIG9mIHRoZSBvcmlnaW5hbCBoZWFkcm9vbS4g
VGhlIG1lYW5pbmcKPiBvZiBoZWFkcm9vbSBpbiBiaWcgbW9kZSBhbmQgbWVyZ2UgbW9kZSBoYXMg
YmVjb21lIGRpZmZlcmVudC4gVGhlIG1vcmUgY29uZnVzaW5nCj4gcHJvYmxlbSBpcyB0aGF0IHRo
ZSBwYXJhbWV0ZXJzIG9mIHBhZ2VfdG9fc2tiKCkgYXJlIGdldHRpbmcgbW9yZSBhbmQgbW9yZQo+
IGNoYW90aWMuICBTbyBJIHdyb3RlIHRoZSBwcmV2aW91cyBwYXRjaC4gT2YgY291cnNlLCBJIHVu
ZGVyc3RhbmQgeW91ciBjb25jZXJuLgo+IFRoaXMgcGF0Y2ggbWF5IGJyaW5nIEhlcmUgYXJlIG1v
cmUgcXVlc3Rpb25zLCBhbHRob3VnaCBJIGRpZCBhIGxvdCBvZiB0ZXN0cy4KPgo+IAkidmlydGlv
LW5ldDogUmVmYWN0b3IgdGhlIGNvZGUgcmVsYXRlZCB0byBwYWdlX3RvX3NrYiIKPgo+IEJ1dCBJ
IGhvcGUgdGhhdCBvdXIgY29kZSBkZXZlbG9wbWVudCBkaXJlY3Rpb24gaXMgYXMgY2xvc2UgdG8g
d2hhdCB0aGlzIHBhdGNoCj4gcmVhbGl6ZXMuIEkgaG9wZSB0aGF0IHRoZSBtZWFuaW5nIG9mIHRo
ZSBwYXJhbWV0ZXJzIGNhbiBiZSBtb3JlIGNsZWFyLgoKClNvIEkgZG9uJ3Qgb2JqZWN0IHRvIHRo
aXMgbWV0aG9kLCBidXQgYXMgSSByZXBsaWVkLCBpdCdzIGJldHRlciB0byBkbyAKc29tZSBiZW5j
aG1hcmsgdG8gc2VlIGlmIGl0IGludHJvZHVjZXMgYW55IHJlZ3Jlc3Npb24KCgo+Cj4gRG8geW91
IHRoaW5rIHRoaXMgaXMgb2s/CgoKTG9va3Mgb2ssIGJ1dCBpZiB3ZSBkZWNpZGUgdG8gZ28gd2l0
aCB5b3VyIGFwcHJvYWNoLCBpdCBjYW4gYmUgc3F1YXNoZWQgCmludG8gdGhhdCBwYXRjaC4KClRo
YW5rcwoKCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggNzhhMDFjNzFhMTdjLi42ZDYyYmI0NWExODggMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4gQEAgLTM4MCwzNCArMzgwLDIwIEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVm
ZiAqcGFnZV90b19za2Ioc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJCQkJICAgc3RydWN0
IHBhZ2UgKnBhZ2UsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4gICAJCQkJICAgdW5zaWduZWQgaW50
IGxlbiwgdW5zaWduZWQgaW50IHRydWVzaXplLAo+ICAgCQkJCSAgIGJvb2wgaGRyX3ZhbGlkLCB1
bnNpZ25lZCBpbnQgbWV0YXNpemUsCj4gLQkJCQkgICB1bnNpZ25lZCBpbnQgaGVhZHJvb20pCj4g
KwkJCQkgICBpbnQgdGFpbHJvb20sIGNoYXIgKmJ1ZiwKPiArCQkJCSAgIHVuc2lnbmVkIGludCBo
ZHJfcGFkZGVkX2xlbikKPiAgIHsKPiAgIAlzdHJ1Y3Qgc2tfYnVmZiAqc2tiOwo+ICAgCXN0cnVj
dCB2aXJ0aW9fbmV0X2hkcl9tcmdfcnhidWYgKmhkcjsKPiAtCXVuc2lnbmVkIGludCBjb3B5LCBo
ZHJfbGVuLCBoZHJfcGFkZGVkX2xlbjsKPiArCXVuc2lnbmVkIGludCBjb3B5LCBoZHJfbGVuOwo+
ICAgCXN0cnVjdCBwYWdlICpwYWdlX3RvX2ZyZWUgPSBOVUxMOwo+IC0JaW50IHRhaWxyb29tLCBz
aGluZm9fc2l6ZTsKPiAtCWNoYXIgKnAsICpoZHJfcCwgKmJ1ZjsKPiArCWludCBzaGluZm9fc2l6
ZTsKPiArCWNoYXIgKnAsICpoZHJfcDsKPgo+ICAgCXAgPSBwYWdlX2FkZHJlc3MocGFnZSkgKyBv
ZmZzZXQ7Cj4gICAJaGRyX3AgPSBwOwo+Cj4gICAJaGRyX2xlbiA9IHZpLT5oZHJfbGVuOwo+IC0J
aWYgKHZpLT5tZXJnZWFibGVfcnhfYnVmcykKPiAtCQloZHJfcGFkZGVkX2xlbiA9IHNpemVvZigq
aGRyKTsKPiAtCWVsc2UKPiAtCQloZHJfcGFkZGVkX2xlbiA9IHNpemVvZihzdHJ1Y3QgcGFkZGVk
X3ZuZXRfaGRyKTsKPiAtCj4gLQkvKiBJZiBoZWFkcm9vbSBpcyBub3QgMCwgdGhlcmUgaXMgYW4g
b2Zmc2V0IGJldHdlZW4gdGhlIGJlZ2lubmluZyBvZiB0aGUKPiAtCSAqIGRhdGEgYW5kIHRoZSBh
bGxvY2F0ZWQgc3BhY2UsIG90aGVyd2lzZSB0aGUgZGF0YSBhbmQgdGhlIGFsbG9jYXRlZAo+IC0J
ICogc3BhY2UgYXJlIGFsaWduZWQuCj4gLQkgKgo+IC0JICogQnVmZmVycyB3aXRoIGhlYWRyb29t
IHVzZSBQQUdFX1NJWkUgYXMgYWxsb2Mgc2l6ZSwgc2VlCj4gLQkgKiBhZGRfcmVjdmJ1Zl9tZXJn
ZWFibGUoKSArIGdldF9tZXJnZWFibGVfYnVmX2xlbigpCj4gLQkgKi8KPiAtCXRydWVzaXplID0g
aGVhZHJvb20gPyBQQUdFX1NJWkUgOiB0cnVlc2l6ZTsKPiAtCXRhaWxyb29tID0gdHJ1ZXNpemUg
LSBsZW4gLSBoZWFkcm9vbSAtIChoZHJfcGFkZGVkX2xlbiAtIGhkcl9sZW4pOwo+IC0JYnVmID0g
cCAtIGhlYWRyb29tOwo+Cj4gICAJbGVuIC09IGhkcl9sZW47Cj4gICAJb2Zmc2V0ICs9IGhkcl9w
YWRkZWRfbGVuOwo+IEBAIC00OTIsNiArNDc4LDUxIEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAq
cGFnZV90b19za2Ioc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJcmV0dXJuIHNrYjsKPiAg
IH0KPgo+ICtzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKm1lcmdlX3BhZ2VfdG9fc2tiKHN0cnVjdCB2
aXJ0bmV0X2luZm8gKnZpLAo+ICsJCQkJCSBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsCj4gKwkJ
CQkJIHN0cnVjdCBwYWdlICpwYWdlLCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+ICsJCQkJCSB1bnNp
Z25lZCBpbnQgbGVuLCB1bnNpZ25lZCBpbnQgdHJ1ZXNpemUsCj4gKwkJCQkJIGJvb2wgaGRyX3Zh
bGlkLCB1bnNpZ25lZCBpbnQgbWV0YXNpemUsCj4gKwkJCQkJIHVuc2lnbmVkIGludCBoZWFkcm9v
bSkKPiArewo+ICsJaW50IHRhaWxyb29tOwo+ICsJY2hhciAqYnVmOwo+ICsKPiArCS8qIElmIGhl
YWRyb29tIGlzIG5vdCAwLCB0aGVyZSBpcyBhbiBvZmZzZXQgYmV0d2VlbiB0aGUgYmVnaW5uaW5n
IG9mIHRoZQo+ICsJICogZGF0YSBhbmQgdGhlIGFsbG9jYXRlZCBzcGFjZSwgb3RoZXJ3aXNlIHRo
ZSBkYXRhIGFuZCB0aGUgYWxsb2NhdGVkCj4gKwkgKiBzcGFjZSBhcmUgYWxpZ25lZC4KPiArCSAq
Cj4gKwkgKiBCdWZmZXJzIHdpdGggaGVhZHJvb20gdXNlIFBBR0VfU0laRSBhcyBhbGxvYyBzaXpl
LCBzZWUKPiArCSAqIGFkZF9yZWN2YnVmX21lcmdlYWJsZSgpICsgZ2V0X21lcmdlYWJsZV9idWZf
bGVuKCkKPiArCSAqLwo+ICsJdHJ1ZXNpemUgPSBoZWFkcm9vbSA/IFBBR0VfU0laRSA6IHRydWVz
aXplOwo+ICsJdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbiAtIGhlYWRyb29tOwo+ICsJYnVmID0g
cGFnZV9hZGRyZXNzKHBhZ2UpICsgb2Zmc2V0IC0gaGVhZHJvb207Cj4gKwo+ICsJcGFnZV90b19z
a2IodmksIHJxLCBwYWdlLCBvZmZzZXQsIGxlbiwgdHJ1ZXNpemUsIGhkcl92YWxpZCwgbWV0YXNp
emUsCj4gKwkJICAgIHRhaWxyb29tLCBidWYsIHNpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9oZHJf
bXJnX3J4YnVmKSkKPiArCj4gK30KPiArCj4gK3N0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqYmlnX3Bh
Z2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICsJCQkJICAgICAgIHN0cnVjdCBy
ZWNlaXZlX3F1ZXVlICpycSwKPiArCQkJCSAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSwgdW5zaWdu
ZWQgaW50IG9mZnNldCwKPiArCQkJCSAgICAgICB1bnNpZ25lZCBpbnQgbGVuLCB1bnNpZ25lZCBp
bnQgdHJ1ZXNpemUsCj4gKwkJCQkgICAgICAgYm9vbCBoZHJfdmFsaWQsIHVuc2lnbmVkIGludCBt
ZXRhc2l6ZSwKPiArCQkJCSAgICAgICB1bnNpZ25lZCBpbnQgaGVhZHJvb20pCj4gK3sKPiArCWNo
YXIgKnAgPSBwYWdlX2FkZHJlc3MocGFnZSk7Cj4gKwlpbnQgaG9sZDsKPiArCWludCB0YWlscm9v
bTsKPiArCj4gKwlob2xkID0gc2l6ZW9mKHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIpIC0gdmktPmhk
cl9sZW47Cj4gKwo+ICsJdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbiAtIGhlYWRyb29tIC0gaG9s
ZDsKPiArCj4gKwlwYWdlX3RvX3NrYih2aSwgcnEsIHBhZ2UsIG9mZnNldCwgbGVuLCB0cnVlc2l6
ZSwgaGRyX3ZhbGlkLCBtZXRhc2l6ZSwKPiArCQkgICAgdGFpbHJvb20sIHAsIHNpemVvZihzdHJ1
Y3QgcGFkZGVkX3ZuZXRfaGRyKSk7Cj4gK30KPiArCj4gICBzdGF0aWMgaW50IF9fdmlydG5ldF94
ZHBfeG1pdF9vbmUoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJCQkJICAgc3RydWN0IHNl
bmRfcXVldWUgKnNxLAo+ICAgCQkJCSAgIHN0cnVjdCB4ZHBfZnJhbWUgKnhkcGYpCj4KPgo+Pgo+
Pj4gVGhhbmtzLgo+Pj4KPj4+Pgo+Pj4+PiAgICAgCWJ1ZiA9IHAgLSBoZWFkcm9vbTsKPj4+Pj4K
Pj4+Pj4gICAgIAlsZW4gLT0gaGRyX2xlbjsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
