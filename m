Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD06C4332F
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 10:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D9F260ABF;
	Tue, 27 Dec 2022 10:22:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D9F260ABF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=NoTyXYNT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9x6aRJ6Vhy2U; Tue, 27 Dec 2022 10:22:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D73766059B;
	Tue, 27 Dec 2022 10:22:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D73766059B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B46C4C0032;
	Tue, 27 Dec 2022 10:22:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA32BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 10:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 907A3812FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 10:22:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 907A3812FE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=NoTyXYNT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yFcpTYJa1_lB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 10:22:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D2B8812FB
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D2B8812FB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 10:22:48 +0000 (UTC)
Received: by mail-vk1-xa29.google.com with SMTP id f184so1921346vkh.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5/0JksOM2lGuEYSzF1Qu3MnIOgzw58Ul9AktACBNVI=;
 b=NoTyXYNTcm9i+GC7/+I09XJcPjGPm2toisrvYx3dF44c57grwNAzYz5vVRbhRnJA9S
 B34KZz4oVKrZN6wpBQ+QnVG35XqSCtcpouGuyB3/fUIXDDIpvt2o1dete8IQ4jhB2VK4
 pTiaILZwM41NBdToO6kueGNZ1CXaHt5GRY3XI59BNUIdJR6mN615Mf+88Gmm6QxHb95p
 U2SNRsXu3eqo5n5Smjbcca054NvBvgIuwPw6R1Xds9lzkojAc2OLtCvD9hN5aBTgkIPV
 WpOHVwYJ4HgifzdLK3a+ewkHHdUb5DUt4wNyHa5aVn0xUqXEJ4EnpoZHjRQsUqZ3yip/
 TFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5/0JksOM2lGuEYSzF1Qu3MnIOgzw58Ul9AktACBNVI=;
 b=EpP/56e8zGsnVoMZCvZz6UXJ2uFS7bVDOrsvg/PkpiDElt8MsgDacgsk3GQgdRRZEA
 N6Vrf+oY85g38eqizf/D4XbeGvHDgzQLMukG6Co0P2Z6hBUPu5HkQDb96tjSsJltfLB9
 lfJSItLwBvLOUvuQYpdn26QBxhwBfMh/AIrEVJVxOd02XpPF94n5XWYUIPwa938Yx0J/
 JM39LWScrfNnd0sNNjvgbOdmYZKeSgjgSx6C+CR0VpRYY1JzDwTwmx90uh9Gh75lnu5c
 VCA4MVnbYQDnE4hmV78jR7vPMOevVlVoO416Jar7C2dMROnFJAw+UFWwE2t37IAeJY7B
 yuFA==
X-Gm-Message-State: AFqh2koztTHedMyQA3a5PueVu0N3LrTnvaUkPla2AOwU+Axs3jAjEK/F
 /LcfkTMbI62aHk159KmBHBncaVY6P3K8YEefbevtIw==
X-Google-Smtp-Source: AMrXdXuBs2JliWerOZZXmJNVHzg/xf71Hb0VEHnA0XGAF1ihq/iN1gmrkZTToN9EzxIyzAeEgwTxu37dmgcPKXEXKFI=
X-Received: by 2002:a1f:2016:0:b0:3d5:53d8:aa10 with SMTP id
 g22-20020a1f2016000000b003d553d8aa10mr872944vkg.21.1672136567160; Tue, 27 Dec
 2022 02:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20221227022528.609839-1-mie@igel.co.jp>
 <20221227022528.609839-5-mie@igel.co.jp>
 <20221227020007-mutt-send-email-mst@kernel.org>
 <CANXvt5pRy-i7=_ikNkZPp2HcRmWZYNJYpjO_ieBJJVc90nds+A@mail.gmail.com>
In-Reply-To: <CANXvt5pRy-i7=_ikNkZPp2HcRmWZYNJYpjO_ieBJJVc90nds+A@mail.gmail.com>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 27 Dec 2022 19:22:36 +0900
Message-ID: <CANXvt5qUUOqB1CVgAk5KyL9sV+NsnJSKhatvdV12jH5=kBjjJw@mail.gmail.com>
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

MjAyMuW5tDEy5pyIMjfml6Uo54GrKSAxNjo0OSBTaHVuc3VrZSBNaWUgPG1pZUBpZ2VsLmNvLmpw
PjoKPgo+IDIwMjLlubQxMuaciDI35pelKOeBqykgMTY6MDQgTWljaGFlbCBTLiBUc2lya2luIDxt
c3RAcmVkaGF0LmNvbT46Cj4gPgo+ID4gT24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMTE6MjU6MjZB
TSArMDkwMCwgU2h1bnN1a2UgTWllIHdyb3RlOgo+ID4gPiBFYWNoIHZyaW5naCBtZW1vcnkgYWNj
ZXNzb3JzIHRoYXQgYXJlIGZvciB1c2VyLCBrZXJuIGFuZCBpb3RsYiBoYXMgb3duCj4gPiA+IGlu
dGVyZmFjZXMgdGhhdCBjYWxscyBjb21tb24gY29kZS4gQnV0IHNvbWUgY29kZXMgYXJlIGR1cGxp
Y2F0ZWQgYW5kIHRoYXQKPiA+ID4gYmVjb21lcyBsb3NzIGV4dGVuZGFiaWxpdHkuCj4gPiA+Cj4g
PiA+IEludHJvZHVjZSBhIHN0cnVjdCB2cmluZ2hfb3BzIGFuZCBwcm92aWRlIGEgY29tbW9uIEFQ
SXMgZm9yIGFsbCBhY2Nlc3NvcnMuCj4gPiA+IEl0IGNhbiBiZWUgZWFzaWx5IGV4dGVuZGVkIHZy
aW5naCBjb2RlIGZvciBuZXcgbWVtb3J5IGFjY2Vzc29yIGFuZAo+ID4gPiBzaW1wbGlmaWVkIGEg
Y2FsbGVyIGNvZGUuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNodW5zdWtlIE1pZSA8bWll
QGlnZWwuY28uanA+Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy92aG9zdC92cmluZ2guYyB8IDY2
NyArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gPiAgaW5jbHVk
ZS9saW51eC92cmluZ2guaCB8IDEwMCArKystLS0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjI1
IGluc2VydGlvbnMoKyksIDU0MiBkZWxldGlvbnMoLSkKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gPiA+IGlu
ZGV4IGFhM2NkMjdkMjM4NC4uZWJmZDM2NDRhMWEzIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJz
L3Zob3N0L3ZyaW5naC5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMKPiA+ID4g
QEAgLTM1LDE1ICszNSwxMiBAQCBzdGF0aWMgX19wcmludGYoMSwyKSBfX2NvbGQgdm9pZCB2cmlu
Z2hfYmFkKGNvbnN0IGNoYXIgKmZtdCwgLi4uKQo+ID4gPiAgfQo+ID4gPgo+ID4gPiAgLyogUmV0
dXJucyB2cmluZy0+bnVtIGlmIGVtcHR5LCAtdmUgb24gZXJyb3IuICovCj4gPiA+IC1zdGF0aWMg
aW5saW5lIGludCBfX3ZyaW5naF9nZXRfaGVhZChjb25zdCBzdHJ1Y3QgdnJpbmdoICp2cmgsCj4g
PiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgKCpnZXR1MTYpKGNvbnN0
IHN0cnVjdCB2cmluZ2ggKnZyaCwKPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdTE2ICp2YWwsIGNvbnN0IF9fdmlydGlvMTYgKnApLAo+ID4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTE2ICpsYXN0X2F2YWlsX2lkeCkKPiA+
ID4gK3N0YXRpYyBpbmxpbmUgaW50IF9fdnJpbmdoX2dldF9oZWFkKGNvbnN0IHN0cnVjdCB2cmlu
Z2ggKnZyaCwgdTE2ICpsYXN0X2F2YWlsX2lkeCkKPiA+ID4gIHsKPiA+ID4gICAgICAgdTE2IGF2
YWlsX2lkeCwgaSwgaGVhZDsKPiA+ID4gICAgICAgaW50IGVycjsKPiA+ID4KPiA+ID4gLSAgICAg
ZXJyID0gZ2V0dTE2KHZyaCwgJmF2YWlsX2lkeCwgJnZyaC0+dnJpbmcuYXZhaWwtPmlkeCk7Cj4g
PiA+ICsgICAgIGVyciA9IHZyaC0+b3BzLmdldHUxNih2cmgsICZhdmFpbF9pZHgsICZ2cmgtPnZy
aW5nLmF2YWlsLT5pZHgpOwo+ID4gPiAgICAgICBpZiAoZXJyKSB7Cj4gPiA+ICAgICAgICAgICAg
ICAgdnJpbmdoX2JhZCgiRmFpbGVkIHRvIGFjY2VzcyBhdmFpbCBpZHggYXQgJXAiLAo+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgJnZyaC0+dnJpbmcuYXZhaWwtPmlkeCk7Cj4gPgo+ID4g
SSBsaWtlIHRoYXQgdGhpcyBwYXRjaCByZW1vdmVzIG1vcmUgbGluZXMgb2YgY29kZSB0aGFuIGl0
IGFkZHMuCj4gPgo+ID4gSG93ZXZlciBvbmUgb2YgdGhlIGRlc2lnbiBwb2ludHMgb2YgdnJpbmdo
IGFic3RyYWN0aW9ucyBpcyB0aGF0IHRoZXkgd2VyZQo+ID4gY2FyZWZ1bGx5IHdyaXR0ZW4gdG8g
YmUgdmVyeSBsb3cgb3ZlcmhlYWQuCj4gPiBUaGlzIGlzIHdoeSB3ZSBhcmUgcGFzc2luZyBmdW5j
dGlvbiBwb2ludGVycyB0byBpbmxpbmUgZnVuY3Rpb25zIC0KPiA+IGNvbXBpbGVyIGNhbiBvcHRp
bWl6ZSB0aGF0IG91dC4KPiA+Cj4gPiBJIHRoaW5rIHRoYXQgaW50cm9kdWNpbmcgb3BzIGluZGly
ZWN0IGZ1bmN0aW9ucyBjYWxscyBoZXJlIGlzIGdvaW5nIHRvIGJyZWFrCj4gPiB0aGVzZSBhc3N1
bXB0aW9ucyBhbmQgaHVydCBwZXJmb3JtYW5jZS4KPiA+IFVubGVzcyBjb21waWxlciBjYW4gc29t
ZWhvdyBmaWd1cmUgaXQgb3V0IGFuZCBvcHRpbWl6ZT8KPiA+IEkgZG9uJ3Qgc2VlIGhvdyBpdCdz
IHBvc3NpYmxlIHdpdGggb3BzIHBvaW50ZXIgaW4gbWVtb3J5Cj4gPiBidXQgbWF5YmUgSSdtIHdy
b25nLgo+IEkgdGhpbmsgeW91ciBjb25jZXJuIGlzIGNvcnJlY3QuIEkgaGF2ZSB0byB1bmRlcnN0
YW5kIHRoZSBjb21waWxlcgo+IG9wdGltaXphdGlvbiBhbmQgcmVkZXNpZ24gdGhpcyBhcHByb2Fj
aCBJZiBpdCBpcyBuZWVkZWQuCj4gPiBXYXMgYW55IGVmZm9ydCB0YWtlbiB0byB0ZXN0IGVmZmVj
dCBvZiB0aGVzZSBwYXRjaGVzIG9uIHBlcmZvcm1hbmNlPwo+IEkganVzdCB0ZXN0ZWQgdnJpbmdo
X3Rlc3QgYW5kIGFscmVhZHkgZmFjZWQgbGl0dGxlIHBlcmZvcm1hbmNlIHJlZHVjdGlvbi4KPiBJ
IGhhdmUgdG8gaW52ZXN0aWdhdGUgdGhhdCwgYXMgeW91IHNhaWQuCkkgYXR0ZW1wdGVkIHRvIHRl
c3Qgd2l0aCBwZXJmLiBJIGZvdW5kIHRoYXQgdGhlIHBlcmZvcm1hbmNlIG9mIHBhdGNoZWQgY29k
ZQppcyBhbG1vc3QgdGhlIHNhbWUgYXMgdGhlIHVwc3RyZWFtIG9uZS4gSG93ZXZlciwgSSBoYXZl
IHRvIGludmVzdGlnYXRlIHdheQp0aGlzIHBhdGNoIGxlYWRzIHRvIHRoaXMgcmVzdWx0LCBhbHNv
IHRoZSBwcm9maWxpbmcgc2hvdWxkIGJlIHJ1biBvbgptb3JlIHBvd2VyZnVsCm1hY2hpbmVzIHRv
by4KCmVudmlyb25tZW50OgokIGdyZXAgJ21vZGVsIG5hbWUnIC9wcm9jL2NwdWluZm8KbW9kZWwg
bmFtZSAgICAgIDogSW50ZWwoUikgQ29yZShUTSkgaTMtNzAyMFUgQ1BVIEAgMi4zMEdIegptb2Rl
bCBuYW1lICAgICAgOiBJbnRlbChSKSBDb3JlKFRNKSBpMy03MDIwVSBDUFUgQCAyLjMwR0h6Cm1v
ZGVsIG5hbWUgICAgICA6IEludGVsKFIpIENvcmUoVE0pIGkzLTcwMjBVIENQVSBAIDIuMzBHSHoK
bW9kZWwgbmFtZSAgICAgIDogSW50ZWwoUikgQ29yZShUTSkgaTMtNzAyMFUgQ1BVIEAgMi4zMEdI
egoKcmVzdWx0czoKKiBmb3IgcGF0Y2hlZCBjb2RlCiBQZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRz
IGZvciAnbmljZSAtbiAtMjAgLi92cmluZ2hfdGVzdF9wYXRjaGVkCi0tcGFyYWxsZWwgLS1ldmVu
dGlkeCAtLWZhc3QtdnJpbmdoIC0taW5kaXJlY3QgLS12aXJ0aW8tMScgKDIwIHJ1bnMpOgoKICAg
ICAgICAgIDMsMDI4LjA1IG1zZWMgdGFzay1jbG9jayAgICAgICAgICAgICAgICAjICAgIDAuOTk1
IENQVXMKdXRpbGl6ZWQgICAgICAgICAgICAoICstICAwLjEyJSApCiAgICAgICAgICAgIDc4LDE1
MCAgICAgIGNvbnRleHQtc3dpdGNoZXMgICAgICAgICAgIyAgIDI1LjY5MSBLL3NlYwogICAgICAg
ICAgICAgICAoICstICAwLjAwJSApCiAgICAgICAgICAgICAgICAgNSAgICAgIGNwdS1taWdyYXRp
b25zICAgICAgICAgICAgIyAgICAxLjY0NCAvc2VjCiAgICAgICAgICAgICAgICggKy0gIDMuMzMl
ICkKICAgICAgICAgICAgICAgMTkwICAgICAgcGFnZS1mYXVsdHMgICAgICAgICAgICAgICAjICAg
NjIuNDYxIC9zZWMKICAgICAgICAgICAgICAgKCArLSAgMC40MSUgKQogICAgIDYsOTE5LDAyNSwy
MjIgICAgICBjeWNsZXMgICAgICAgICAgICAgICAgICAgICMgICAgMi4yNzUgR0h6CiAgICAgICAg
ICAgICAgICggKy0gIDAuMTMlICkKICAgICA4LDk5MCwyMjAsMTYwICAgICAgaW5zdHJ1Y3Rpb25z
ICAgICAgICAgICAgICAjICAgIDEuMjkgIGluc24gcGVyCmN5Y2xlICAgICAgICAgICAoICstICAw
LjA0JSApCiAgICAgMSw3ODgsMzI2LDc4NiAgICAgIGJyYW5jaGVzICAgICAgICAgICAgICAgICAg
IyAgNTg3Ljg5OSBNL3NlYwogICAgICAgICAgICAgICAoICstICAwLjA1JSApCiAgICAgICAgIDQs
NTU3LDM5OCAgICAgIGJyYW5jaC1taXNzZXMgICAgICAgICAgICAgIyAgICAwLjI1JSBvZiBhbGwK
YnJhbmNoZXMgICAgICAgICAgKCArLSAgMC40MyUgKQoKICAgICAgICAgICAzLjA0MzU5ICstIDAu
MDAzNzggc2Vjb25kcyB0aW1lIGVsYXBzZWQgICggKy0gIDAuMTIlICkKCiogZm9yIHVwc3RyZWFt
IGNvZGUKIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICduaWNlIC1uIC0yMCAuL3ZyaW5n
aF90ZXN0X2Jhc2UKLS1wYXJhbGxlbCAtLWV2ZW50aWR4IC0tZmFzdC12cmluZ2ggLS1pbmRpcmVj
dCAtLXZpcnRpby0xJyAoMTAgcnVucyk6CgogICAgICAgICAgMywwNTguNDEgbXNlYyB0YXNrLWNs
b2NrICAgICAgICAgICAgICAgICMgICAgMC45OTkgQ1BVcwp1dGlsaXplZCAgICAgICAgICAgICgg
Ky0gIDAuMTQlICkKICAgICAgICAgICAgNzgsMTQ5ICAgICAgY29udGV4dC1zd2l0Y2hlcyAgICAg
ICAgICAjICAgMjUuNTQ1IEsvc2VjCiAgICAgICAgICAgICAgICggKy0gIDAuMDAlICkKICAgICAg
ICAgICAgICAgICA1ICAgICAgY3B1LW1pZ3JhdGlvbnMgICAgICAgICAgICAjICAgIDEuNjM0IC9z
ZWMKICAgICAgICAgICAgICAgKCArLSAgMi42NyUgKQogICAgICAgICAgICAgICAxOTQgICAgICBw
YWdlLWZhdWx0cyAgICAgICAgICAgICAgICMgICA2My40MTQgL3NlYwogICAgICAgICAgICAgICAo
ICstICAwLjQzJSApCiAgICAgNiw5ODgsNzEzLDk2MyAgICAgIGN5Y2xlcyAgICAgICAgICAgICAg
ICAgICAgIyAgICAyLjI4NCBHSHoKICAgICAgICAgICAgICAgKCArLSAgMC4xNCUgKQogICAgIDgs
NTEyLDUzMywyNjkgICAgICBpbnN0cnVjdGlvbnMgICAgICAgICAgICAgICMgICAgMS4yMiAgaW5z
biBwZXIKY3ljbGUgICAgICAgICAgICggKy0gIDAuMDQlICkKICAgICAxLDYzOCwzNzUsMzcxICAg
ICAgYnJhbmNoZXMgICAgICAgICAgICAgICAgICAjICA1MzUuNTQ5IE0vc2VjCiAgICAgICAgICAg
ICAgICggKy0gIDAuMDUlICkKICAgICAgICAgNCw0MjgsODY2ICAgICAgYnJhbmNoLW1pc3NlcyAg
ICAgICAgICAgICAjICAgIDAuMjclIG9mIGFsbApicmFuY2hlcyAgICAgICAgICAoICstIDIyLjU3
JSApCgogICAgICAgICAgIDMuMDYwODUgKy0gMC4wMDQyMCBzZWNvbmRzIHRpbWUgZWxhcHNlZCAg
KCArLSAgMC4xNCUgKQoKPiBUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMuCj4gPiBUaGFua3Mh
Cj4gPgo+ID4KPiBCZXN0LAo+IFNodW5zdWtlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
