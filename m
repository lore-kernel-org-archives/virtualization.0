Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1EFC433B4
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 18:53:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF9861350
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 18:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF9861350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19A3E83D05;
	Mon, 12 Apr 2021 18:53:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5KP0jtIs5KKf; Mon, 12 Apr 2021 18:53:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8763383C80;
	Mon, 12 Apr 2021 18:53:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A9D6C000B;
	Mon, 12 Apr 2021 18:53:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2066C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 18:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D35B7400BA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 18:53:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QRZmvIS82Jgi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 18:53:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8845400CB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 18:53:27 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 f75-20020a9d03d10000b0290280def9ab76so8670398otf.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=q2c2bk4hAZv4IyXDtl2zFlaq8cOREJUwdyV+adc37xQ=;
 b=ahRnXFg+qJQ/5cQIanHCUpnM9kuddJNfB3qXIvfYI8qhgZcW6xNoRw2daO6UzD+w0K
 JA0bRZaZH15rZo6d1ICZFXSDWA4WaJvNbRMO8YBpJxPpykFr8t6nIK+W6kNi4iIzMg9A
 V13LO+HVJylG5O1b6RDkj85aRq+K5emT97phWu0yo/lAdx1rcThuKAlGeIH2Aa0nOgAd
 XyIk/cj9On6bshY1BxOqVLszek6lt3r1xuPheWgFKog95pwAWOtLMj3erJt/WE9mIrAc
 gw5N/8yR5OYEZdblsRDxzyxisMMraqJtoJByH1Fr45Bj6pOkC2SxToQ73w9oyHqTdSPg
 qbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q2c2bk4hAZv4IyXDtl2zFlaq8cOREJUwdyV+adc37xQ=;
 b=dzYf2RzFtC+XS1qBWZMdlf7vUTF9ChvcO0SuPn8hHrff2/hOZFO97MURGB/vAPfq7+
 1e2uQD4eRoOEdJJAbXyVFnxtbQyuvlKNmTH1vpPRXIe74vtMXWnX3H79pXfY5tr/GpAe
 MkAKIuAEz3IiZ7JkEcgaAN1qHKZq0arGgCA86QLFSe6ACaQhGNgm8Qq/bzhLxJwku4L2
 Os97S73WQom+zbZYSTAm4IeqM1kdHQa79XEyykJXLr6gCzX0zZ5bzgvw88y4DdeRdey1
 u3H8+5Hndsa9Mr1ngawN/UKPazSnVNnTtqvLocUnOA7bZSXeAceRmg6Y/gpLxF1jWZao
 1gyw==
X-Gm-Message-State: AOAM533G7J/SMRtc8CcoDbQLtIWvIFFoGQU8/4nt2sNNvZ9ELaz+MMR0
 mNe21Y9Kh8D10PR239mIC7ZMDVZezV7hl26ZFSunfg==
X-Google-Smtp-Source: ABdhPJymT0/XuxJEv3V6pf63kR+k0XtHJ2ohWWNDUrFefR6PqXGWKyVFM7EOI2TMjTDJIUXpgDuvoXkyE8WlU2DxbrU=
X-Received: by 2002:a05:6830:22c3:: with SMTP id
 q3mr24732558otc.56.1618253606238; 
 Mon, 12 Apr 2021 11:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210406183112.1150657-1-jiang.wang@bytedance.com>
 <1D46A084-5B77-4803-8B5F-B2F36541DA10@vmware.com>
 <CAP_N_Z-KFUYZc7p1z_-9nb9CvjtyGFkgkX1PEbh-SgKbX_snQw@mail.gmail.com>
 <20210412140437.6k3zxw2cv4p54lvm@steredhat>
In-Reply-To: <20210412140437.6k3zxw2cv4p54lvm@steredhat>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Mon, 12 Apr 2021 11:53:15 -0700
Message-ID: <CAP_N_Z9yi96YDW3gJdCFrPJpNhwpJnaT8gruk7JJSsBne8J-8Q@mail.gmail.com>
Subject: Re: Re: [RFC] vsock: add multiple transports support for dgram
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "cong.wang@bytedance.com" <cong.wang@bytedance.com>,
 "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
 Andra Paraschiv <andraprs@amazon.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Alexander Popov <alex.popov@linux.com>
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

T24gTW9uLCBBcHIgMTIsIDIwMjEgYXQgNzowNCBBTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6
YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gSGkgSmlhbmcsCj4gdGhhbmtzIGZvciByZS1zdGFy
dGluZyB0aGUgbXVsdGktdHJhbnNwb3J0IHN1cHBvcnQgZm9yIGRncmFtIQoKTm8gcHJvYmxlbS4K
Cj4gT24gV2VkLCBBcHIgMDcsIDIwMjEgYXQgMTE6MjU6MzZBTSAtMDcwMCwgSmlhbmcgV2FuZyAu
IHdyb3RlOgo+ID5PbiBXZWQsIEFwciA3LCAyMDIxIGF0IDI6NTEgQU0gSm9yZ2VuIEhhbnNlbiA8
amhhbnNlbkB2bXdhcmUuY29tPiB3cm90ZToKPiA+Pgo+ID4+Cj4gPj4gPiBPbiA2IEFwciAyMDIx
LCBhdCAyMDozMSwgSmlhbmcgV2FuZyA8amlhbmcud2FuZ0BieXRlZGFuY2UuY29tPiB3cm90ZToK
PiA+PiA+Cj4gPj4gPiBGcm9tOiAiamlhbmcud2FuZyIgPGppYW5nLndhbmdAYnl0ZWRhbmNlLmNv
bT4KPiA+PiA+Cj4gPj4gPiBDdXJyZW50bHksIG9ubHkgVk1DSSBzdXBwb3J0cyBkZ3JhbSBzb2Nr
ZXRzLiBUbyBzdXBwb3J0ZWQKPiA+PiA+IG5lc3RlZCBWTSB1c2UgY2FzZSwgdGhpcyBwYXRjaCBy
ZW1vdmVzIHRyYW5zcG9ydF9kZ3JhbSBhbmQKPiA+PiA+IHVzZXMgdHJhbnNwb3J0X2cyaCBhbmQg
dHJhbnNwb3J0X2gyZyBmb3IgZGdyYW0gdG9vLgo+Cj4gSSBhZ3JlZSBvbiB0aGlzIHBhcnQsIEkg
dGhpbmsgdGhhdCdzIHRoZSBkaXJlY3Rpb24gdG8gZ28uCj4gdHJhbnNwb3J0X2RncmFtIHdhcyBh
ZGRlZCBhcyBhIHNob3J0Y3V0LgoKR290IGl0LgoKPiA+Pgo+ID4+IENvdWxkIHlvdSBwcm92aWRl
IHNvbWUgYmFja2dyb3VuZCBmb3IgaW50cm9kdWNpbmcgdGhpcyBjaGFuZ2UgLSBhcmUgeW91Cj4g
Pj4gbG9va2luZyBhdCBpbnRyb2R1Y2luZyBkYXRhZ3JhbXMgZm9yIGEgZGlmZmVyZW50IHRyYW5z
cG9ydD8gVk1DSSBkYXRhZ3JhbXMKPiA+PiBhbHJlYWR5IHN1cHBvcnQgdGhlIG5lc3RlZCB1c2Ug
Y2FzZSwKPiA+Cj4gPlllcywgSSBhbSB0cnlpbmcgdG8gaW50cm9kdWNlIGRhdGFncmFtIGZvciB2
aXJ0aW8gdHJhbnNwb3J0LiBJIHdyb3RlIGEKPiA+c3BlYyBwYXRjaCBmb3IKPiA+dmlydGlvIGRn
cmFtIHN1cHBvcnQgYW5kIGFsc28gYSBjb2RlIHBhdGNoLCBidXQgdGhlIGNvZGUgcGF0Y2ggaXMg
c3RpbGwgV0lQLgo+ID5XaGVuIEkgd3JvdGUgdGhpcyBjb21taXQgbWVzc2FnZSwgSSB3YXMgdGhp
bmtpbmcgbmVzdGVkIFZNIGlzIHRoZSBzYW1lIGFzCj4gPm11bHRpcGxlIHRyYW5zcG9ydCBzdXBw
b3J0LiBCdXQgbm93LCBJIHJlYWxpemUgdGhleSBhcmUgZGlmZmVyZW50Lgo+ID5OZXN0ZWQgVk1z
IG1heSB1c2UKPiA+dGhlIHNhbWUgdmlydHVhbGl6YXRpb24gbGF5ZXIoS1ZNIG9uIEtWTSksIG9y
IGRpZmZlcmVudCB2aXJ0dWFsaXphdGlvbiBsYXllcnMKPiA+KEtWTSBvbiBFU1hpKS4gVGhhbmtz
IGZvciBsZXR0aW5nIG1lIGtub3cgdGhhdCBWTUNJIGFscmVhZHkgc3VwcG9ydGVkIG5lc3RlZAo+
ID51c2UgY2FzZXMuIEkgdGhpbmsgeW91IG1lYW4gVk1DSSBvbiBWTUNJLCByaWdodD8KPiA+Cj4g
Pj4gYnV0IGlmIHdlIG5lZWQgdG8gc3VwcG9ydCBtdWx0aXBsZSBkYXRhZ3JhbQo+ID4+IHRyYW5z
cG9ydHMgd2UgbmVlZCB0byByZXdvcmsgaG93IHdlIGFkbWluaXN0ZXIgcG9ydCBhc3NpZ25tZW50
IGZvciBkYXRhZ3JhbXMuCj4gPj4gT25lIHNwZWNpZmljIGlzc3VlIGlzIHRoYXQgdGhlIHZtY2kg
dHJhbnNwb3J0IHdvbuKAmXQgcmVjZWl2ZSBhbnkgZGF0YWdyYW1zIGZvciBhCj4gPj4gcG9ydCB1
bmxlc3MgdGhlIGRhdGFncmFtIHNvY2tldCBoYXMgYWxyZWFkeSBiZWVuIGFzc2lnbmVkIHRoZSB2
bWNpIHRyYW5zcG9ydAo+ID4+IGFuZCB0aGUgcG9ydCBib3VuZCB0byB0aGUgdW5kZXJseWluZyBW
TUNJIGRldmljZSAoc2VlIGJlbG93IGZvciBtb3JlIGRldGFpbHMpLgo+ID4+Cj4gPkkgc2VlLgo+
ID4KPiA+PiA+IFRoZSB0cmFuc3BvcnQgaXMgYXNzZ2luZWQgd2hlbiBzZW5kaW5nIGV2ZXJ5IHBh
Y2tldCBhbmQKPiA+PiA+IHJlY2VpdmluZyBldmVyeSBwYWNrZXQgb24gZGdyYW0gc29ja2V0cy4K
PiA+Pgo+ID4+IElzIHRoZSBpbnRlbnQgdGhhdCB0aGUgc2FtZSBkYXRhZ3JhbSBzb2NrZXQgY2Fu
IGJlIHVzZWQgZm9yIHNlbmRpbmcgcGFja2V0cyBib3RoCj4gPj4gSW4gdGhlIGhvc3QgdG8gZ3Vl
c3QsIGFuZCB0aGUgZ3Vlc3QgdG8gZGlyZWN0aW9ucz8KPiA+Cj4gPk5vcGUuIE9uZSBkYXRhZ3Jh
bSBzb2NrZXQgd2lsbCBvbmx5IHNlbmQgcGFja2V0cyB0byBvbmUgZGlyZWN0aW9uLCBlaXRoZXIg
dG8gdGhlCj4gPmhvc3Qgb3IgdG8gdGhlIGd1ZXN0LiBNeSBhYm92ZSBkZXNjcmlwdGlvbiBpcyB3
cm9uZy4gV2hlbiBzZW5kaW5nIHBhY2tldHMsIHRoZQo+ID50cmFuc3BvcnQgaXMgYXNzaWduZWQg
d2l0aCB0aGUgZmlyc3QgcGFja2V0ICh3aXRoIGF1dG9fYmluZCkuCj4KPiBJJ20gbm90IHN1cmUg
dGhpcyBpcyByaWdodC4KPiBUaGUgYXV0b19iaW5kIG9uIHRoZSBmaXJzdCBwYWNrZXQgc2hvdWxk
IG9ubHkgYXNzaWduIGEgbG9jYWwgcG9ydCB0byB0aGUKPiBzb2NrZXQsIGJ1dCBkb2VzIG5vdCBh
ZmZlY3QgdGhlIHRyYW5zcG9ydCB0byBiZSB1c2VkLgo+Cj4gQSB1c2VyIGNvdWxkIHNlbmQgb25l
IHBhY2tldCB0byB0aGUgbmVzdGVkIGd1ZXN0IGFuZCBhbm90aGVyIHRvIHRoZSBob3N0Cj4gdXNp
bmcgdGhlIHNhbWUgc29ja2V0LCBvciBhbSBJIHdyb25nPwoKT0suIEkgdGhpbmsgeW91IGFyZSBy
aWdodC4KCj4gPgo+ID5UaGUgcHJvYmxlbSBpcyB3aGVuIHJlY2VpdmluZyBwYWNrZXRzLiBUaGUg
bGlzdGVuZXIgY2FuIGJpbmQgdG8gdGhlCj4gPlZNQUREUl9DSURfQU5ZCj4gPmFkZHJlc3MuIFRo
ZW4gaXQgaXMgdW5jbGVhciB3aGljaCB0cmFuc3BvcnQgd2Ugc2hvdWxkIHVzZS4gRm9yIHN0cmVh
bQo+ID5zb2NrZXRzLCB0aGVyZSB3aWxsIGJlIGEgbmV3IHNvY2tldCBmb3IgZWFjaCBjb25uZWN0
aW9uLCBhbmQgdHJhbnNwb3J0Cj4gPmNhbiBiZSBkZWNpZGVkCj4gPmF0IHRoYXQgdGltZS4gRm9y
IGRhdGFncmFtIHNvY2tldHMsIEkgYW0gbm90IHN1cmUgaG93IHRvIGhhbmRsZSB0aGF0Lgo+Cj4g
eWVzLCB0aGlzIEkgdGhpbmsgaXMgdGhlIG1haW4gcHJvYmxlbSwgYnV0IG1heWJlIHRoZSBzZW5k
ZXIgb25lIGlzIGV2ZW4KPiBtb3JlIGNvbXBsaWNhdGVkLgo+Cj4gTWF5YmUgd2Ugc2hvdWxkIHJl
bW92ZSB0aGUgMToxIGFzc29jaWF0aW9uIHdlIGhhdmUgbm93IGJldHdlZW4gdnNrIGFuZAo+IHRy
YW5zcG9ydC4KClllcywgSSB0aG91Z2h0IGFib3V0IHRoYXQgdG9vLiBPbmUgaWRlYSBpcyB0byBk
ZWZpbmUgdHdvIHRyYW5zcG9ydHMgaW4gdnNrLgpGb3Igc2VuZGluZyBwa3QsIHdlIGNhbiBwaWNr
IHRoZSByaWdodCB0cmFuc3BvcnQgd2hlbiB3ZSBnZXQgdGhlIHBhY2tldCwgbGlrZQppbiB2aXJ0
aW9fdHJhbnNwb3J0X3NlbmRfcGt0X2luZm8oKS4gRm9yIHJlY2VpdmluZyBwa3RzLCB3ZSBoYXZl
IHRvIGNoZWNrCmFuZCBjYWxsIGJvdGgKdHJhbnNwb3J0cyBkZXF1ZXVlIGNhbGxiYWNrcyBpZiB0
aGUgbG9jYWwgY2lkIGlzIENJRF9BTlkuCgo+IEF0IGxlYXN0IGZvciBER1JBTSwgZm9yIGNvbm5l
Y3RlZCBzb2NrZXRzIEkgdGhpbmsgdGhlIGFzc29jaWF0aW9uIG1ha2VzCj4gc2Vuc2UuCgpZZWFo
LiBGb3IgYSBjb25uZWN0ZWQgc29ja2V0LCB3ZSB3aWxsIG9ubHkgdXNlIG9uZSB0cmFuc3BvcnQu
Cgo+ID5Gb3IgVk1DSSwgZG9lcyB0aGUgc2FtZSB0cmFuc3BvcnQgY2FuIGJlIHVzZWQgZm9yIGJv
dGggcmVjZWl2aW5nIGZyb20KPiA+aG9zdCBhbmQgZnJvbQo+ID50aGUgZ3Vlc3Q/Cj4KPiBZZXMs
IHRoZXkncmUgcmVnaXN0ZXJlZCBhdCBkaWZmZXJlbnQgdGltZXMsIGJ1dCBpdCdzIHRoZSBzYW1l
IHRyYW5zcG9ydC4KPgo+ID4KPiA+Rm9yIHZpcnRpbywgdGhlIGgyZyBhbmQgZzJoIHRyYW5zcG9y
dHMgYXJlIGRpZmZlcmVudCwsIHNvIHdlIGhhdmUgdG8KPiA+Y2hvb3NlCj4gPm9uZSBvZiB0aGVt
LiBNeSBvcmlnaW5hbCB0aG91Z2h0IGlzIHRvIHdhaXQgdW50aWwgdGhlIGZpcnN0IHBhY2tldAo+
ID5hcnJpdmVzLgo+ID4KPiA+QW5vdGhlciBpZGVhIGlzIHRoYXQgd2UgYWx3YXlzIGJpbmQgdG8g
aG9zdCBhZGRyIGFuZCB1c2UgaDJnCj4gPnRyYW5zcG9ydCBiZWNhdXNlIEkgdGhpbmsgdGhhdCBt
aWdodAo+ID5iZSBtb3JlIGNvbW1vbi4gSWYgYSBsaXN0ZW5lciB3YW50cyB0byByZWN2IHBhY2tl
dHMgZnJvbSB0aGUgaG9zdCwgdGhlbgo+ID5pdAo+ID5zaG91bGQgYmluZCB0byB0aGUgZ3Vlc3Qg
YWRkciBpbnN0ZWFkIG9mIENJRF9BTlkuCj4KPiBZZXMsIEkgcmVtZW1iZXIgd2UgZGlzY3Vzc2Vk
IHRoaXMgaWRlYSwgdGhpcyB3b3VsZCBzaW1wbGlmeSB0aGUKPiByZWNlaXZpbmcsIGJ1dCB0aGVy
ZSBpcyBzdGlsbCB0aGUgaXNzdWUgb2YgYSB1c2VyIHdhbnRpbmcgdG8gcmVjZWl2ZQo+IHBhY2tl
dHMgZnJvbSBib3RoIHRoZSBuZXN0ZWQgZ3Vlc3QgYW5kIHRoZSBob3N0LgoKT0suIEFncmVlLgoK
PiA+QW55IG90aGVyIHN1Z2dlc3Rpb25zPwo+ID4KPgo+IEkgdGhpbmsgb25lIHNvbHV0aW9uIGNv
dWxkIGJlIHRvIHJlbW92ZSB0aGUgMToxIGFzc29jaWF0aW9uIGJldHdlZW4KPiBER1JBTSBzb2Nr
ZXQgYW5kIHRyYW5zcG9ydC4KPgo+IElJVUMgVk1DSSBjcmVhdGVzIGEgc2tiIGZvciBlYWNoIHJl
Y2VpdmVkIHBhY2tldCBhbmQgcXVldWVzIGl0IHRocm91Z2gKPiBza19yZWNlaXZlX3NrYigpIGRp
cmVjdGx5IGluIHRoZSBzdHJ1Y3Qgc29jay4KPgo+IFRoZW4gdGhlIC5kZ3JhbV9kZXF1ZXVlKCkg
Y2FsbGJhY2sgZGVxdWV1ZXMgdGhlbSB1c2luZwo+IHNrYl9yZWN2X2RhdGFncmFtKCkuCj4KPiBX
ZSBjYW4gbW92ZSB0aGVzZSBwYXJ0cyBpbiB0aGUgdnNvY2sgY29yZSwgYW5kIGNyZWF0ZSBzb21l
IGhlbHBlcnMgdG8KPiBhbGxvdyB0aGUgdHJhbnNwb3J0cyB0byBlbnF1ZXVlIHJlY2VpdmVkIERH
UkFNIHBhY2tldHMgaW4gdGhlIHNhbWUgd2F5Cj4gKGFuZCB3aXRoIHRoZSBzYW1lIGZvcm1hdCkg
ZGlyZWN0bHkgaW4gdGhlIHN0cnVjdCBzb2NrLgo+CgpJIGFncmVlIHRvIHVzZSBza2JzIChhbmQg
bW92ZSB0aGVtIHRvIHZzY29rIGNvcmUpLiBXZSBoYXZlIGFub3RoZXIgdXNlIGNhc2UKd2hpY2gg
d2lsbCBuZWVkIHRvIHVzZSBza2IuIEJ1dCBJIGFtIG5vdCBzdXJlIGhvdyB0aGlzIGhlbHBzIHdp
dGggbXVsdGlwbGUKdHJhbnNwb3J0IGNhc2VzLiBFYWNoIHRyYW5zcG9ydCBoYXMgYSBkZ3JhbV9k
ZXF1ZXVlIGNhbGxiYWNrLiBTbyB3ZSBzdGlsbApuZWVkIHRvIGxldCB2c2sgaGF2ZSBtdWx0aXBs
ZSB0cmFuc3BvcnRzIHNvbWVob3cuIENvdWxkIHlvdSBlbGFib3JhdGUgaG93CnVzaW5nIHNrYiBo
ZWxwIHdpdGggbXVsdGlwbGUgdHJhbnNwb3J0IHN1cHBvcnQ/IFdpbGwgdGhhdCBiZSBzaW1pbGFy
IHRvIHdoYXQgSQptZW50aW9uZWQgYWJvdmU/IFRoYW5rcy4KClJlZ2FyZHMsCgpKaWFuZwoKPiBX
aGF0IGRvIHlvdSB0aGluaz8KPgo+IFRoYW5rcywKPiBTdGVmYW5vCj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
