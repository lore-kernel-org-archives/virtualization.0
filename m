Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B6EC46467
	for <virtualization@archiver.kernel.org>; Wed, 28 Dec 2022 02:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19C7B80BFA;
	Wed, 28 Dec 2022 02:24:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19C7B80BFA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=vLsxbKjn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5UXtMUIb_QsI; Wed, 28 Dec 2022 02:24:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5D4BF80BCA;
	Wed, 28 Dec 2022 02:24:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D4BF80BCA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DE93C0032;
	Wed, 28 Dec 2022 02:24:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FF90C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 02:24:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA89240921
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 02:24:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA89240921
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=vLsxbKjn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nohxBsUlmAII
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 02:24:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 424D34091B
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 424D34091B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 02:24:22 +0000 (UTC)
Received: by mail-vk1-xa35.google.com with SMTP id f24so6903151vkl.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 18:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lttqZKeMZ42Wftl+a8lEKBwDe2IpQRheXD3/dUIOrPE=;
 b=vLsxbKjnqmN7ZOTHeMz7NeULAaBP7Lfep7XHvKEKppWhzJsr0kdCDXNIueyDJW7iVL
 la70SsV6Ie6ZMuuy9gZiH0wLLJMRYSg2bTYDV14tlozyS3xAPU9gEHvXZVlTYbrgIuP8
 aE9qw7gWzsANwTwSfOkhq3eh/Fo6ZRciivXlZObFquyr6pMO+DGhNIoEEW34DoTxowO0
 CqQx7pam0TnoF72zI1W2XVJI5r5x9tD2jHyPsMl3d/IiP/Yx8UCWe2S1Ziw91SkBk8bU
 NjTJYO+lSwXDsoRKiRin6oAsX+ieLJnv8B2QE/DPzvPaDbHM60/L30bM7tXNrBDN+PqM
 qXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lttqZKeMZ42Wftl+a8lEKBwDe2IpQRheXD3/dUIOrPE=;
 b=hqoFTz8T0PYbDTVqrjvX7hp7XfsScEbMvNp35vUkfXC8f5ahaGO7fYkL0IueXYcdce
 kKi9K14H/ZWGl8Xm9f+3M5LxNlScIPRaq8UvxTOA6PbuAgHnsedGZQ+tZk3LnSs43IW7
 NExA/t7mzXSziXA1MFwGbsUIN4Kxf/cvM6dGoZJch1ZF8MwOQ6aVaoBU1/lmg0s16u/K
 QDDEDTNMH+awkgK3EXBuULtbDJc/2R9f+yz+5iXVg8sn190wkKIMc1Jd4tV/Yn1aUr7u
 ++zAyr9zY+lRL1CDSHrznLiW28OYk29nEHtdVWfUqbdKRbO2IYOOZ66TfonkhcJn6DzW
 KMew==
X-Gm-Message-State: AFqh2koKP0VT2RUiOf+RA66mhTCF0ziRwHtH9IYPkMZXJ0k4mZYaYppz
 pGq+7/3INEyHlpcxuGy9T68ykDesuvsg8R3tiLDPEw==
X-Google-Smtp-Source: AMrXdXvLQNIe1PcsU5De/1MFPipsfDOPkaOr3HULUDZN915fVJLoMYjD7SkPBo8QjiIJb6mDo9iqWmSJIrELWUFy1fw=
X-Received: by 2002:a1f:2016:0:b0:3d5:53d8:aa10 with SMTP id
 g22-20020a1f2016000000b003d553d8aa10mr1129190vkg.21.1672194261032; Tue, 27
 Dec 2022 18:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20221227022528.609839-1-mie@igel.co.jp>
 <20221227022528.609839-5-mie@igel.co.jp>
 <20221227020007-mutt-send-email-mst@kernel.org>
 <CANXvt5pRy-i7=_ikNkZPp2HcRmWZYNJYpjO_ieBJJVc90nds+A@mail.gmail.com>
 <CANXvt5qUUOqB1CVgAk5KyL9sV+NsnJSKhatvdV12jH5=kBjjJw@mail.gmail.com>
 <20221227075332-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221227075332-mutt-send-email-mst@kernel.org>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Wed, 28 Dec 2022 11:24:10 +0900
Message-ID: <CANXvt5qTbGi7p5Y7eVSjyHJ7MLjiMgGKyAM-LEkJZXvhtSh7vw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] vringh: unify the APIs for all accessors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

MjAyMuW5tDEy5pyIMjfml6Uo54GrKSAyMzozNyBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRo
YXQuY29tPjoKPgo+IE9uIFR1ZSwgRGVjIDI3LCAyMDIyIGF0IDA3OjIyOjM2UE0gKzA5MDAsIFNo
dW5zdWtlIE1pZSB3cm90ZToKPiA+IDIwMjLlubQxMuaciDI35pelKOeBqykgMTY6NDkgU2h1bnN1
a2UgTWllIDxtaWVAaWdlbC5jby5qcD46Cj4gPiA+Cj4gPiA+IDIwMjLlubQxMuaciDI35pelKOeB
qykgMTY6MDQgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT46Cj4gPiA+ID4KPiA+
ID4gPiBPbiBUdWUsIERlYyAyNywgMjAyMiBhdCAxMToyNToyNkFNICswOTAwLCBTaHVuc3VrZSBN
aWUgd3JvdGU6Cj4gPiA+ID4gPiBFYWNoIHZyaW5naCBtZW1vcnkgYWNjZXNzb3JzIHRoYXQgYXJl
IGZvciB1c2VyLCBrZXJuIGFuZCBpb3RsYiBoYXMgb3duCj4gPiA+ID4gPiBpbnRlcmZhY2VzIHRo
YXQgY2FsbHMgY29tbW9uIGNvZGUuIEJ1dCBzb21lIGNvZGVzIGFyZSBkdXBsaWNhdGVkIGFuZCB0
aGF0Cj4gPiA+ID4gPiBiZWNvbWVzIGxvc3MgZXh0ZW5kYWJpbGl0eS4KPiA+ID4gPiA+Cj4gPiA+
ID4gPiBJbnRyb2R1Y2UgYSBzdHJ1Y3QgdnJpbmdoX29wcyBhbmQgcHJvdmlkZSBhIGNvbW1vbiBB
UElzIGZvciBhbGwgYWNjZXNzb3JzLgo+ID4gPiA+ID4gSXQgY2FuIGJlZSBlYXNpbHkgZXh0ZW5k
ZWQgdnJpbmdoIGNvZGUgZm9yIG5ldyBtZW1vcnkgYWNjZXNzb3IgYW5kCj4gPiA+ID4gPiBzaW1w
bGlmaWVkIGEgY2FsbGVyIGNvZGUuCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
U2h1bnN1a2UgTWllIDxtaWVAaWdlbC5jby5qcD4KPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gIGRy
aXZlcnMvdmhvc3QvdnJpbmdoLmMgfCA2NjcgKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KPiA+ID4gPiA+ICBpbmNsdWRlL2xpbnV4L3ZyaW5naC5oIHwgMTAwICsrKy0t
LQo+ID4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjI1IGluc2VydGlvbnMoKyksIDU0MiBkZWxl
dGlvbnMoLSkKPiA+ID4gPiA+Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92
cmluZ2guYyBiL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMKPiA+ID4gPiA+IGluZGV4IGFhM2NkMjdk
MjM4NC4uZWJmZDM2NDRhMWEzIDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92aG9zdC92
cmluZ2guYwo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+ID4gPiA+ID4g
QEAgLTM1LDE1ICszNSwxMiBAQCBzdGF0aWMgX19wcmludGYoMSwyKSBfX2NvbGQgdm9pZCB2cmlu
Z2hfYmFkKGNvbnN0IGNoYXIgKmZtdCwgLi4uKQo+ID4gPiA+ID4gIH0KPiA+ID4gPiA+Cj4gPiA+
ID4gPiAgLyogUmV0dXJucyB2cmluZy0+bnVtIGlmIGVtcHR5LCAtdmUgb24gZXJyb3IuICovCj4g
PiA+ID4gPiAtc3RhdGljIGlubGluZSBpbnQgX192cmluZ2hfZ2V0X2hlYWQoY29uc3Qgc3RydWN0
IHZyaW5naCAqdnJoLAo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGludCAoKmdldHUxNikoY29uc3Qgc3RydWN0IHZyaW5naCAqdnJoLAo+ID4gPiA+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTE2ICp2YWwsIGNvbnN0
IF9fdmlydGlvMTYgKnApLAo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHUxNiAqbGFzdF9hdmFpbF9pZHgpCj4gPiA+ID4gPiArc3RhdGljIGlubGluZSBpbnQgX192
cmluZ2hfZ2V0X2hlYWQoY29uc3Qgc3RydWN0IHZyaW5naCAqdnJoLCB1MTYgKmxhc3RfYXZhaWxf
aWR4KQo+ID4gPiA+ID4gIHsKPiA+ID4gPiA+ICAgICAgIHUxNiBhdmFpbF9pZHgsIGksIGhlYWQ7
Cj4gPiA+ID4gPiAgICAgICBpbnQgZXJyOwo+ID4gPiA+ID4KPiA+ID4gPiA+IC0gICAgIGVyciA9
IGdldHUxNih2cmgsICZhdmFpbF9pZHgsICZ2cmgtPnZyaW5nLmF2YWlsLT5pZHgpOwo+ID4gPiA+
ID4gKyAgICAgZXJyID0gdnJoLT5vcHMuZ2V0dTE2KHZyaCwgJmF2YWlsX2lkeCwgJnZyaC0+dnJp
bmcuYXZhaWwtPmlkeCk7Cj4gPiA+ID4gPiAgICAgICBpZiAoZXJyKSB7Cj4gPiA+ID4gPiAgICAg
ICAgICAgICAgIHZyaW5naF9iYWQoIkZhaWxlZCB0byBhY2Nlc3MgYXZhaWwgaWR4IGF0ICVwIiwK
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAmdnJoLT52cmluZy5hdmFpbC0+aWR4
KTsKPiA+ID4gPgo+ID4gPiA+IEkgbGlrZSB0aGF0IHRoaXMgcGF0Y2ggcmVtb3ZlcyBtb3JlIGxp
bmVzIG9mIGNvZGUgdGhhbiBpdCBhZGRzLgo+ID4gPiA+Cj4gPiA+ID4gSG93ZXZlciBvbmUgb2Yg
dGhlIGRlc2lnbiBwb2ludHMgb2YgdnJpbmdoIGFic3RyYWN0aW9ucyBpcyB0aGF0IHRoZXkgd2Vy
ZQo+ID4gPiA+IGNhcmVmdWxseSB3cml0dGVuIHRvIGJlIHZlcnkgbG93IG92ZXJoZWFkLgo+ID4g
PiA+IFRoaXMgaXMgd2h5IHdlIGFyZSBwYXNzaW5nIGZ1bmN0aW9uIHBvaW50ZXJzIHRvIGlubGlu
ZSBmdW5jdGlvbnMgLQo+ID4gPiA+IGNvbXBpbGVyIGNhbiBvcHRpbWl6ZSB0aGF0IG91dC4KPiA+
ID4gPgo+ID4gPiA+IEkgdGhpbmsgdGhhdCBpbnRyb2R1Y2luZyBvcHMgaW5kaXJlY3QgZnVuY3Rp
b25zIGNhbGxzIGhlcmUgaXMgZ29pbmcgdG8gYnJlYWsKPiA+ID4gPiB0aGVzZSBhc3N1bXB0aW9u
cyBhbmQgaHVydCBwZXJmb3JtYW5jZS4KPiA+ID4gPiBVbmxlc3MgY29tcGlsZXIgY2FuIHNvbWVo
b3cgZmlndXJlIGl0IG91dCBhbmQgb3B0aW1pemU/Cj4gPiA+ID4gSSBkb24ndCBzZWUgaG93IGl0
J3MgcG9zc2libGUgd2l0aCBvcHMgcG9pbnRlciBpbiBtZW1vcnkKPiA+ID4gPiBidXQgbWF5YmUg
SSdtIHdyb25nLgo+ID4gPiBJIHRoaW5rIHlvdXIgY29uY2VybiBpcyBjb3JyZWN0LiBJIGhhdmUg
dG8gdW5kZXJzdGFuZCB0aGUgY29tcGlsZXIKPiA+ID4gb3B0aW1pemF0aW9uIGFuZCByZWRlc2ln
biB0aGlzIGFwcHJvYWNoIElmIGl0IGlzIG5lZWRlZC4KPiA+ID4gPiBXYXMgYW55IGVmZm9ydCB0
YWtlbiB0byB0ZXN0IGVmZmVjdCBvZiB0aGVzZSBwYXRjaGVzIG9uIHBlcmZvcm1hbmNlPwo+ID4g
PiBJIGp1c3QgdGVzdGVkIHZyaW5naF90ZXN0IGFuZCBhbHJlYWR5IGZhY2VkIGxpdHRsZSBwZXJm
b3JtYW5jZSByZWR1Y3Rpb24uCj4gPiA+IEkgaGF2ZSB0byBpbnZlc3RpZ2F0ZSB0aGF0LCBhcyB5
b3Ugc2FpZC4KPiA+IEkgYXR0ZW1wdGVkIHRvIHRlc3Qgd2l0aCBwZXJmLiBJIGZvdW5kIHRoYXQg
dGhlIHBlcmZvcm1hbmNlIG9mIHBhdGNoZWQgY29kZQo+ID4gaXMgYWxtb3N0IHRoZSBzYW1lIGFz
IHRoZSB1cHN0cmVhbSBvbmUuIEhvd2V2ZXIsIEkgaGF2ZSB0byBpbnZlc3RpZ2F0ZSB3YXkKPiA+
IHRoaXMgcGF0Y2ggbGVhZHMgdG8gdGhpcyByZXN1bHQsIGFsc28gdGhlIHByb2ZpbGluZyBzaG91
bGQgYmUgcnVuIG9uCj4gPiBtb3JlIHBvd2VyZnVsCj4gPiBtYWNoaW5lcyB0b28uCj4gPgo+ID4g
ZW52aXJvbm1lbnQ6Cj4gPiAkIGdyZXAgJ21vZGVsIG5hbWUnIC9wcm9jL2NwdWluZm8KPiA+IG1v
ZGVsIG5hbWUgICAgICA6IEludGVsKFIpIENvcmUoVE0pIGkzLTcwMjBVIENQVSBAIDIuMzBHSHoK
PiA+IG1vZGVsIG5hbWUgICAgICA6IEludGVsKFIpIENvcmUoVE0pIGkzLTcwMjBVIENQVSBAIDIu
MzBHSHoKPiA+IG1vZGVsIG5hbWUgICAgICA6IEludGVsKFIpIENvcmUoVE0pIGkzLTcwMjBVIENQ
VSBAIDIuMzBHSHoKPiA+IG1vZGVsIG5hbWUgICAgICA6IEludGVsKFIpIENvcmUoVE0pIGkzLTcw
MjBVIENQVSBAIDIuMzBHSHoKPiA+Cj4gPiByZXN1bHRzOgo+ID4gKiBmb3IgcGF0Y2hlZCBjb2Rl
Cj4gPiAgUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ25pY2UgLW4gLTIwIC4vdnJpbmdo
X3Rlc3RfcGF0Y2hlZAo+ID4gLS1wYXJhbGxlbCAtLWV2ZW50aWR4IC0tZmFzdC12cmluZ2ggLS1p
bmRpcmVjdCAtLXZpcnRpby0xJyAoMjAgcnVucyk6Cj4gPgo+ID4gICAgICAgICAgIDMsMDI4LjA1
IG1zZWMgdGFzay1jbG9jayAgICAgICAgICAgICAgICAjICAgIDAuOTk1IENQVXMKPiA+IHV0aWxp
emVkICAgICAgICAgICAgKCArLSAgMC4xMiUgKQo+ID4gICAgICAgICAgICAgNzgsMTUwICAgICAg
Y29udGV4dC1zd2l0Y2hlcyAgICAgICAgICAjICAgMjUuNjkxIEsvc2VjCj4gPiAgICAgICAgICAg
ICAgICAoICstICAwLjAwJSApCj4gPiAgICAgICAgICAgICAgICAgIDUgICAgICBjcHUtbWlncmF0
aW9ucyAgICAgICAgICAgICMgICAgMS42NDQgL3NlYwo+ID4gICAgICAgICAgICAgICAgKCArLSAg
My4zMyUgKQo+ID4gICAgICAgICAgICAgICAgMTkwICAgICAgcGFnZS1mYXVsdHMgICAgICAgICAg
ICAgICAjICAgNjIuNDYxIC9zZWMKPiA+ICAgICAgICAgICAgICAgICggKy0gIDAuNDElICkKPiA+
ICAgICAgNiw5MTksMDI1LDIyMiAgICAgIGN5Y2xlcyAgICAgICAgICAgICAgICAgICAgIyAgICAy
LjI3NSBHSHoKPiA+ICAgICAgICAgICAgICAgICggKy0gIDAuMTMlICkKPiA+ICAgICAgOCw5OTAs
MjIwLDE2MCAgICAgIGluc3RydWN0aW9ucyAgICAgICAgICAgICAgIyAgICAxLjI5ICBpbnNuIHBl
cgo+ID4gY3ljbGUgICAgICAgICAgICggKy0gIDAuMDQlICkKPiA+ICAgICAgMSw3ODgsMzI2LDc4
NiAgICAgIGJyYW5jaGVzICAgICAgICAgICAgICAgICAgIyAgNTg3Ljg5OSBNL3NlYwo+ID4gICAg
ICAgICAgICAgICAgKCArLSAgMC4wNSUgKQo+ID4gICAgICAgICAgNCw1NTcsMzk4ICAgICAgYnJh
bmNoLW1pc3NlcyAgICAgICAgICAgICAjICAgIDAuMjUlIG9mIGFsbAo+ID4gYnJhbmNoZXMgICAg
ICAgICAgKCArLSAgMC40MyUgKQo+ID4KPiA+ICAgICAgICAgICAgMy4wNDM1OSArLSAwLjAwMzc4
IHNlY29uZHMgdGltZSBlbGFwc2VkICAoICstICAwLjEyJSApCj4gPgo+ID4gKiBmb3IgdXBzdHJl
YW0gY29kZQo+ID4gIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICduaWNlIC1uIC0yMCAu
L3ZyaW5naF90ZXN0X2Jhc2UKPiA+IC0tcGFyYWxsZWwgLS1ldmVudGlkeCAtLWZhc3QtdnJpbmdo
IC0taW5kaXJlY3QgLS12aXJ0aW8tMScgKDEwIHJ1bnMpOgo+ID4KPiA+ICAgICAgICAgICAzLDA1
OC40MSBtc2VjIHRhc2stY2xvY2sgICAgICAgICAgICAgICAgIyAgICAwLjk5OSBDUFVzCj4gPiB1
dGlsaXplZCAgICAgICAgICAgICggKy0gIDAuMTQlICkKPiA+ICAgICAgICAgICAgIDc4LDE0OSAg
ICAgIGNvbnRleHQtc3dpdGNoZXMgICAgICAgICAgIyAgIDI1LjU0NSBLL3NlYwo+ID4gICAgICAg
ICAgICAgICAgKCArLSAgMC4wMCUgKQo+ID4gICAgICAgICAgICAgICAgICA1ICAgICAgY3B1LW1p
Z3JhdGlvbnMgICAgICAgICAgICAjICAgIDEuNjM0IC9zZWMKPiA+ICAgICAgICAgICAgICAgICgg
Ky0gIDIuNjclICkKPiA+ICAgICAgICAgICAgICAgIDE5NCAgICAgIHBhZ2UtZmF1bHRzICAgICAg
ICAgICAgICAgIyAgIDYzLjQxNCAvc2VjCj4gPiAgICAgICAgICAgICAgICAoICstICAwLjQzJSAp
Cj4gPiAgICAgIDYsOTg4LDcxMyw5NjMgICAgICBjeWNsZXMgICAgICAgICAgICAgICAgICAgICMg
ICAgMi4yODQgR0h6Cj4gPiAgICAgICAgICAgICAgICAoICstICAwLjE0JSApCj4gPiAgICAgIDgs
NTEyLDUzMywyNjkgICAgICBpbnN0cnVjdGlvbnMgICAgICAgICAgICAgICMgICAgMS4yMiAgaW5z
biBwZXIKPiA+IGN5Y2xlICAgICAgICAgICAoICstICAwLjA0JSApCj4gPiAgICAgIDEsNjM4LDM3
NSwzNzEgICAgICBicmFuY2hlcyAgICAgICAgICAgICAgICAgICMgIDUzNS41NDkgTS9zZWMKPiA+
ICAgICAgICAgICAgICAgICggKy0gIDAuMDUlICkKPiA+ICAgICAgICAgIDQsNDI4LDg2NiAgICAg
IGJyYW5jaC1taXNzZXMgICAgICAgICAgICAgIyAgICAwLjI3JSBvZiBhbGwKPiA+IGJyYW5jaGVz
ICAgICAgICAgICggKy0gMjIuNTclICkKPiA+Cj4gPiAgICAgICAgICAgIDMuMDYwODUgKy0gMC4w
MDQyMCBzZWNvbmRzIHRpbWUgZWxhcHNlZCAgKCArLSAgMC4xNCUgKQo+Cj4KPiBIb3cgeW91IGNv
bXBpbGVkIGl0IGFsc28gbWF0dGVycy4gQVRNIHdlIGRvbid0IGVuYWJsZSByZXRwb2xpbmVzCj4g
YW5kIGl0IGRpZCBub3QgbWF0dGVyIHNpbmNlIHdlIGRpZG4ndCBoYXZlIGluZGlyZWN0IGNhbGxz
LAo+IGJ1dCB3ZSBzaG91bGQuIERpZG4ndCB5ZXQgaW52ZXN0aWdhdGUgaG93IHRvIGRvIHRoYXQg
Zm9yIHZpcnRpbyB0b29scy4KSSB0aGluayB0aGUgcmV0cG9saW5lcyBjZXJ0YWlubHkgYWZmZWN0
IHBlcmZvcm1hbmNlLiBUaGFuayB5b3UgZm9yIHBvaW50aW5nCml0IG91dC4gSSdkIGxpa2UgdG8g
c3RhcnQgdGhlIGludmVzdGlnYXRpb24gdGhhdCBob3cgdG8gYXBwbHkgdGhlCnJldHBvbGluZXMg
dG8gdGhlCnZpcnRpbyB0b29scy4KPiA+ID4gVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLgo+
ID4gPiA+IFRoYW5rcyEKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+IEJlc3QsCj4gPiA+IFNodW5zdWtl
Lgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
