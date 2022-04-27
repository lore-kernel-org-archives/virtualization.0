Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66F0C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 03:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33D3241930;
	Wed, 27 Apr 2022 03:53:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id scDAx5_dBtwn; Wed, 27 Apr 2022 03:53:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 576FF41927;
	Wed, 27 Apr 2022 03:53:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24EF4C0039;
	Wed, 27 Apr 2022 03:53:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15DF7C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 03:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8B4A833CD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 03:53:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QUKUvV1ZjrMy
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 03:53:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD803831DE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 03:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651031622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWn4QcTkQHPFNmV74dP0SQTZ8wKjKrW6mTFA+kq3cd4=;
 b=hkw7U9UVZPjiByEWH8rZUWkI9VOrwzRaVfxUgTguumQLScGoP/ynIvIETa8gUKX7C7/zdg
 Wu3kfPEcUnKyEr4J4qbE0uP8vNJlMP6wEtOnTkC+sFKWzwuKVNUIEYqaZKl7PNndyPy7o+
 w0NsH5NImEzmone/7uA+Uqqd4Zclv7s=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-fXbPNTmkM4esVatEcAr2-g-1; Tue, 26 Apr 2022 23:53:38 -0400
X-MC-Unique: fXbPNTmkM4esVatEcAr2-g-1
Received: by mail-lj1-f197.google.com with SMTP id
 l26-20020a2e99da000000b0024f02d881cdso269464ljj.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 20:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WWn4QcTkQHPFNmV74dP0SQTZ8wKjKrW6mTFA+kq3cd4=;
 b=lPG9hi1Tq9b0/Z/93qWn2ugVNFW3vXQRirUYT/Vs4K4EyTqGqNmkLgSY+wGOcJ+0Ts
 jma6IS3sPg1fy7nzpLoSyhXN+oP78MhAwSH4XxXMdg6HLaBAvKyoZ0SZo4oY4Z7/Z/HJ
 kQbDQk2miaFwKmtGWUrobwSSuirz2rnY9va+xtChkI4nbjYemoNI3+2preSKRqpHOYq1
 uBWLMzbyotrZhyinhfAW0XTJk6hKYXqjwF62njROfEeVTmRCxAlQeOaSmMpnlwlC8SLJ
 jBUy2WyC7taRUwaEGVZN0e3ZkEmR6Tat/epWriK5Y1vD+n6tolPNYR4bD5y4gcn05Q7/
 kr8g==
X-Gm-Message-State: AOAM531PqMzOmqmdZi7m6dzVl4v6rDaTVr8wvXHHWZm28qh127XaXrHQ
 d32toUTDzYmvu9Su4Co7kgrn0Zkeq4DEGGZ4jy34ENDBNaZItr1sL6A4Dm01yF4yuIjHD7OiMfX
 913obaYgnxG33rXMBfiEM7gGZb41jEVH/h3v94HpdD2ki9A31M6AlR9AkvA==
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id
 b5-20020a2ebc05000000b0024b212d7521mr16611053ljf.243.1651031617259; 
 Tue, 26 Apr 2022 20:53:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUCsW1tzgdyZ/4HEecNYbfI0VWNOBTAmhDHWJbGXXlLTJNKIv7AA9FCGpHA8BouSZJiRdxUqIa59/fOUQl6Jw=
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id
 b5-20020a2ebc05000000b0024b212d7521mr16611037ljf.243.1651031617102; Tue, 26
 Apr 2022 20:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com> <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <CACGkMEve+3ugK-Kgao3_2wbjb=fbF7AO2uEuArGjKgEAQcGdiQ@mail.gmail.com>
 <20220426022420-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220426022420-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Apr 2022 11:53:25 +0800
Message-ID: <CACGkMEtt8irvYVx482Zc4vkjtDANXFvUYHGFoCh=C-Xf3C2JUg@mail.gmail.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

T24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMjozMCBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgQXByIDI2LCAyMDIyIGF0IDEyOjA3OjM5UE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAxMTo1
NSBBTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4KPiA+
ID4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTE6NTM6MjRQTSAtMDQwMCwgTWljaGFlbCBTLiBU
c2lya2luIHdyb3RlOgo+ID4gPiA+IE9uIFR1ZSwgQXByIDI2LCAyMDIyIGF0IDExOjQyOjQ1QU0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4g5ZyoIDIwMjIvNC8y
NiAxMTozOCwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4gPiA+ID4gT24gTW9uLCBB
cHIgMjUsIDIwMjIgYXQgMTE6MzU6NDFQTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgQXByIDI2LCAyMDIyIGF0IDA0OjI5OjExQU0gKzAyMDAs
IEhhbGlsIFBhc2ljIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCAyNSBBcHIgMjAyMiAw
OTo1OTo1NSAtMDQwMAo+ID4gPiA+ID4gPiA+ID4gIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIE1v
biwgQXByIDI1LCAyMDIyIGF0IDEwOjU0OjI0QU0gKzAyMDAsIENvcm5lbGlhIEh1Y2sgd3JvdGU6
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCBBcHIgMjUgMjAyMiwgIk1pY2hhZWwgUy4gVHNp
cmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIE1v
biwgQXByIDI1LCAyMDIyIGF0IDEwOjQ0OjE1QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggdHJpZXMgdG8gaW1wbGVtZW50IHRoZSBz
eW5jaHJvbml6ZV9jYnMoKSBmb3IgY2N3LiBGb3IgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IHZyaW5nX2ludGVycnVwdCgpIHRoYXQgaXMgY2FsbGVkIHZpYSB2aXJ0aW9fYWlycV9oYW5kbGVy
KCksIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBzeW5jaHJvbml6YXRpb24gaXMgc2ltcGx5
IGRvbmUgdmlhIHRoZSBhaXJxX2luZm8ncyBsb2NrLiBGb3IgdGhlCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IHZyaW5nX2ludGVycnVwdCgpIHRoYXQgaXMgY2FsbGVkIHZpYSB2aXJ0aW9fY2N3X2lu
dF9oYW5kbGVyKCksIGEgcGVyCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGRldmljZSBzcGlubG9j
ayBmb3IgaXJxIGlzIGludHJvZHVjZWQgYW5zIHVzZWQgaW4gdGhlIHN5bmNocm9uaXphdGlvbgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBtZXRob2QuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpA
aW5mcmFkZWFkLm9yZz4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQ2M6ICJQYXVsIEUuIE1jS2Vu
bmV5IiA8cGF1bG1ja0BrZXJuZWwub3JnPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBDYzogTWFy
YyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQ2M6IEhh
bGlsIFBhc2ljIDxwYXNpY0BsaW51eC5pYm0uY29tPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBD
YzogQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBpcyB0aGUgb25seSBv
bmUgdGhhdCBpcyBnaXZpbmcgbWUgcGF1c2UuIEhhbGlsLCBDb3JuZWxpYSwKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IHNob3VsZCB3ZSBiZSBjb25jZXJuZWQgYWJvdXQgdGhlIHBlcmZvcm1hbmNlIGlt
cGFjdCBoZXJlPwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQW55IGNoYW5jZSBpdCBjYW4gYmUgdGVz
dGVkPwo+ID4gPiA+ID4gPiA+ID4gPiA+IFdlIGNhbiBoYXZlIGEgYnVuY2ggb2YgZGV2aWNlcyB1
c2luZyB0aGUgc2FtZSBhaXJxIHN0cnVjdHVyZSwgYW5kIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+
IHN5bmMgY2IgY3JlYXRlcyBhIGNob2tlIHBvaW50LCBzYW1lIGFzIHJlZ2lzdGVyaW5nL3VucmVn
aXN0ZXJpbmcuCj4gPiA+ID4gPiA+ID4gPiA+IEJUVyBjYW4gY2FsbGJhY2tzIGZvciBtdWx0aXBs
ZSBWUXMgcnVuIG9uIG11bHRpcGxlIENQVXMgYXQgdGhlIG1vbWVudD8KPiA+ID4gPiA+ID4gPiA+
IEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhlIHF1ZXN0aW9uLgo+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+IEkgZG8gdGhpbmsgd2UgY2FuIGhhdmUgbXVsdGlwbGUgQ1BVcyB0aGF0
IGFyZSBleGVjdXRpbmcgc29tZSBwb3J0aW9uIG9mCj4gPiA+ID4gPiA+ID4gPiB2aXJ0aW9fY2N3
X2ludF9oYW5kbGVyKCkuIFNvIEkgZ3Vlc3MgdGhlIGFuc3dlciBpcyB5ZXMuIENvbm5pZSB3aGF0
IGRvIHlvdSB0aGluaz8KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBPbiB0aGUgb3Ro
ZXIgaGFuZCB3ZSBjb3VsZCBhbHNvIGVuZCB1cCBzZXJpYWxpemluZyBzeW5jaHJvbml6ZV9jYnMo
KQo+ID4gPiA+ID4gPiA+ID4gY2FsbHMgZm9yIGRpZmZlcmVudCBkZXZpY2VzIGlmIHRoZXkgaGFw
cGVuIHRvIHVzZSB0aGUgc2FtZSBhaXJxX2luZm8uIEJ1dAo+ID4gPiA+ID4gPiA+ID4gdGhpcyBw
cm9iYWJseSB3YXMgbm90IHlvdXIgcXVlc3Rpb24KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
IEkgYW0gbGVzcyBjb25jZXJuZWQgYWJvdXQgIHN5bmNocm9uaXplX2NicyBiZWluZyBzbG93IGFu
ZCBtb3JlIGFib3V0Cj4gPiA+ID4gPiA+ID4gdGhlIHNsb3dkb3duIGluIGludGVycnVwdCBwcm9j
ZXNzaW5nIGl0c2VsZi4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiB0aGlzIHBhdGNo
IHNlcmlhbGl6ZXMgdGhlbSBvbiBhIHNwaW5sb2NrLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gVGhvc2UgY291bGQgdGhlbiBwaWxlIHVwIG9uIHRoZSBuZXdseSBpbnRyb2R1Y2Vk
IHNwaW5sb2NrLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFJlZ2FyZHMsCj4gPiA+
ID4gPiA+ID4gPiBIYWxpbAo+ID4gPiA+ID4gPiA+IEhtbSB5ZWEgLi4uIG5vdCBnb29kLgo+ID4g
PiA+ID4gPiBJcyB0aGVyZSBhbnkgb3RoZXIgd2F5IHRvIHN5bmNocm9uaXplIHdpdGggYWxsIGNh
bGxiYWNrcz8KPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gTWF5YmUgdXNpbmcgcndsb2Nr
IGFzIGFpcnEgaGFuZGxlcj8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+Cj4g
PiA+ID4KPiA+ID4gPiByd2xvY2sgaXMgc3RpbGwgYSBzaGFyZWQgY2FjaGVsaW5lIGJvdW5jaW5n
IGJldHdlZW4gQ1BVcyBhbmQKPiA+ID4gPiBhIGJ1bmNoIG9mIG9yZGVyaW5nIGluc3RydWN0aW9u
cy4KPiA+Cj4gPiBZZXMsIGJ1dCBpdCBzaG91bGQgYmUgZmFzdGVyIHRoYW4gc3BpbmxvY2tzIGFu
eWhvdy4KPiA+Cj4gPiA+ID4gTWF5YmUgc29tZXRoaW5nIHBlci1jcHUgKyBzb21lIElQSXMgdG8g
cnVuIHRoaW5ncyBvbiBhbGwgQ1BVcyBpbnN0ZWFkPwo+ID4KPiA+IElzIHRoaXMgc29tZXRoaW5n
IGxpa2UgYSBjdXN0b21pemVkIHZlcnNpb24gb2Ygc3luY2hyb256aWVfcmN1X2V4cGVkaXRlZCgp
Pwo+Cj4gV2l0aCBpbnRlcnJ1cHRzIHJ1bm5pbmcgaW4gYW4gUkNVIHJlYWQgc2l6ZSBjcml0aWNh
bCBzZWN0aW9uPwoKRm9yIHZyaW5nX2ludGVycnVwdCgpLCB5ZXMuCgoKPiBRdWl0ZSBwb3NzaWJs
eSB0aGF0IGlzIGFsc28gYW4gb3B0aW9uLgo+IFRoaXMgd2lsbCBuZWVkIGEgYnVuY2ggb2YgZG9j
dW1lbnRhdGlvbiBzaW5jZSB0aGlzIGlzIG5vdAo+IGEgc3RhbmRhcmQgdXNlIG9mIFJDVSwKCkFj
Y29yZGluZyB0byBEb2N1bWVudGF0aW9uL1JDVS9yZXF1aXJlbWVudHMucnN0LCBpdCBsb29rcyBs
aWtlIGEgbGVnYWwgY2FzZToKCiIKVGhlIExpbnV4IGtlcm5lbCBoYXMgaW50ZXJydXB0cywgYW5k
IFJDVSByZWFkLXNpZGUgY3JpdGljYWwgc2VjdGlvbnMgYXJlCmxlZ2FsIHdpdGhpbiBpbnRlcnJ1
cHQgaGFuZGxlcnMgYW5kIHdpdGhpbiBpbnRlcnJ1cHQtZGlzYWJsZWQgcmVnaW9ucyBvZgpjb2Rl
LCBhcyBhcmUgaW52b2NhdGlvbnMgb2YgY2FsbF9yY3UoKS4KIgoKQW5kIGFzIGRpc2N1c3NlZCwg
c3luY2hyb25pemVfcmN1X2V4cGVkaXRlZCgpIGlzIG5vdCBmcmllbmRseSB0byByZWFsCnRpbWUg
d29ya2xvYWQuIEkgdGhpbmsgd2UgY2FuIHNpbXBseQoKMSkgcHJvdGVjdCB2cmluZ19pbnRlcnJ1
cHQoKSB3aXRoIHJjdV9yZWFkX2xvY2soKQoyKSB1c2Ugc3luY2hyb25pemVfcmN1KCkgaW4gc3lu
Y2hyb25pemVfY2JzIGZvciBjY3cKCkFuZCBpZiB3ZSBjYXJlIGFib3V0IHRoZSBsb25nIGRlbGF5
IHdlIGNhbiB1c2UgcGVyIGRldmljZSBzcmN1IHRvIHJlZHVjZSB0aGF0PwoKVGhhbmtzCgo+IGFu
ZCBwcm9iYWJseSBnZXQgYSBjb25maXJtYXRpb24KPiBmcm9tIFJDVSBtYWludGFpbmVycyB0aGF0
IHdoYXRldmVyIGFzc3VtcHRpb25zIHdlIG1ha2UKPiBhcmUgZ3VhcmFudGVlZCB0byBob2xkIGRv
d24gdGhlIHJvYWQuCj4KPiA+ID4KPiA+ID4gLi4uIGFuZCBJIHRoaW5rIGNsYXNzaWMgYW5kIGRl
dmljZSBpbnRlcnJ1cHRzIGFyZSBkaWZmZXJlbnQgZW5vdWdoCj4gPiA+IGhlcmUgLi4uCj4gPgo+
ID4gWWVzLgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiAtLQo+ID4gPiA+ID4gPiA+IE1TVAo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
