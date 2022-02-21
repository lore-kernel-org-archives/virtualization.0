Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432A8C433EF
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 07:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFA4660BB1;
	Mon, 21 Feb 2022 07:39:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1kkcjNggQahu; Mon, 21 Feb 2022 07:39:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5138960B44;
	Mon, 21 Feb 2022 07:39:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25A3EC0033;
	Mon, 21 Feb 2022 07:39:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B674AC001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A415A81366
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:39:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZXeSBvrg1pkg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:39:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB1B381364
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645429190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=euif6hZnu8n4lnHw4rXa9aanECut0B89Uu6Ed07JMYU=;
 b=cJsfcGqRJjsbgV90HN52Kd0zp52Gp7YnGdIjjNaxoDlpj3feZxMqWI/uvH30E3MEawJ2Rm
 cvVEtVoJnZ2kiooXMtYHoJWCzxVHxG3Rhjv7KBKw5X3tSC+m03KjZvmvilCA0eCTVifOPg
 z79yleROkfOw7uaRISrhzgaU8JADr6g=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-7P6CzDXJOxGvk-0v3_NH6A-1; Mon, 21 Feb 2022 02:39:48 -0500
X-MC-Unique: 7P6CzDXJOxGvk-0v3_NH6A-1
Received: by mail-pg1-f197.google.com with SMTP id
 145-20020a630397000000b00373b72d65f5so6524786pgd.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 23:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=euif6hZnu8n4lnHw4rXa9aanECut0B89Uu6Ed07JMYU=;
 b=GbG2afqGyJFKfirlKCzKkazHK3Pdy120ld+NSoxXuFdJ9AlyencZYhCPgSWGHa20i2
 Z/LGZNyY01qGL2vpCey9smxT6gh+6YZqiAYh/rjrJySDq1HuA5LibhdEf6/KjVG8pcjO
 tc2lCLB1b0EWU2QqwUffP4ech24q59W+uMIY0NkHOJ22o8MBoKI0yW+LOcPkFv3OIgHS
 DHh6otWXhyHlb18/8QVjHswq8SjQzcNxtMl4RG1T0OVn7LHv7FsE0djwi5noQYNbw7P2
 KOihDHLYqpoutDnH1RAdHHs7sSfttaueC+Y7AJMoRucMWpImdvcjSg35hY2yCNxUVUkg
 nVsw==
X-Gm-Message-State: AOAM5335oGtYZVgVQ97QryejSxglZDHo8vsLnWrxpT0Muw+y6Vi3Fp3B
 Nr84jCNvd8FmmDx49dS6bmgit90JEXXz/bGha6b0G3k4FyxGySDcE6AnMTqe9nw8y3RDc+ltFyg
 zs/OipYh6Lo9KKf0fc8UWcwIxoyZJQfiZdhPezUlc/w==
X-Received: by 2002:a17:902:9b8b:b0:14c:cbb8:cfb3 with SMTP id
 y11-20020a1709029b8b00b0014ccbb8cfb3mr17434585plp.64.1645429187641; 
 Sun, 20 Feb 2022 23:39:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0GdZ8NX2+bT1lQEqm5524QB8sCv8aZjBVuXw3mT46uudvhnkSx19VhBPENncMF+R0pBBNAQ==
X-Received: by 2002:a17:902:9b8b:b0:14c:cbb8:cfb3 with SMTP id
 y11-20020a1709029b8b00b0014ccbb8cfb3mr17434563plp.64.1645429187382; 
 Sun, 20 Feb 2022 23:39:47 -0800 (PST)
Received: from [10.72.12.96] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id n37sm18265204pgl.48.2022.02.20.23.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Feb 2022 23:39:46 -0800 (PST)
Message-ID: <bccdecdd-fa2d-48c0-43b8-7afe7b230b7b@redhat.com>
Date: Mon, 21 Feb 2022 15:39:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH 09/31] vhost-vdpa: Take into account SVQ in
 vhost_vdpa_set_vring_call
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-10-eperezma@redhat.com>
 <cbfbd909-4ee8-8ad2-effd-4b9f60270581@redhat.com>
 <CAJaqyWda5sBw9VGBrz8g60OJ07Eeq45RRYu9vwgOPZFwten9rw@mail.gmail.com>
 <cbdf79c3-48ed-bac2-a9cc-e5c29729e4af@redhat.com>
 <CAJaqyWeisXmZ9+xw2Rj50K7aKx4khNZZjLZEz4MY97B9pQQm3w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWeisXmZ9+xw2Rj50K7aKx4khNZZjLZEz4MY97B9pQQm3w@mail.gmail.com>
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

CuWcqCAyMDIyLzIvMTgg5LiL5Y2IODozNSwgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+
IE9uIFR1ZSwgRmViIDgsIDIwMjIgYXQgNDoyMyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4KPj4g5ZyoIDIwMjIvMS8zMSDkuIvljYgxMTozNCwgRXVnZW5pbyBQ
ZXJleiBNYXJ0aW4g5YaZ6YGTOgo+Pj4gT24gU2F0LCBKYW4gMjksIDIwMjIgYXQgOTowNiBBTSBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+PiDlnKggMjAyMi8xLzIy
IOS4iuWNiDQ6MjcsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPj4+Pj4gU2lnbmVkLW9mZi1ieTog
RXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiAgICAg
aHcvdmlydGlvL3Zob3N0LXZkcGEuYyB8IDIwICsrKysrKysrKysrKysrKysrKy0tCj4+Pj4+ICAg
ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pj4K
Pj4+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMgYi9ody92aXJ0aW8vdmhv
c3QtdmRwYS5jCj4+Pj4+IGluZGV4IDE4ZGUxNGYwZmIuLjAyOWY5OGZlZWUgMTAwNjQ0Cj4+Pj4+
IC0tLSBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPj4+Pj4gKysrIGIvaHcvdmlydGlvL3Zob3N0
LXZkcGEuYwo+Pj4+PiBAQCAtNjg3LDEzICs2ODcsMjkgQEAgc3RhdGljIGludCB2aG9zdF92ZHBh
X3NldF92cmluZ19raWNrKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPj4+Pj4gICAgICAgICB9Cj4+
Pj4+ICAgICB9Cj4+Pj4+Cj4+Pj4+IC1zdGF0aWMgaW50IHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2Nh
bGwoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX2ZpbGUgKmZpbGUpCj4+Pj4+ICtzdGF0
aWMgaW50IHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2Rldl9jYWxsKHN0cnVjdCB2aG9zdF9kZXYgKmRl
diwKPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHZob3N0X3ZyaW5nX2ZpbGUgKmZpbGUpCj4+Pj4+ICAgICB7Cj4+Pj4+ICAgICAgICAgdHJhY2Vf
dmhvc3RfdmRwYV9zZXRfdnJpbmdfY2FsbChkZXYsIGZpbGUtPmluZGV4LCBmaWxlLT5mZCk7Cj4+
Pj4+ICAgICAgICAgcmV0dXJuIHZob3N0X3ZkcGFfY2FsbChkZXYsIFZIT1NUX1NFVF9WUklOR19D
QUxMLCBmaWxlKTsKPj4+Pj4gICAgIH0KPj4+Pj4KPj4+Pj4gK3N0YXRpYyBpbnQgdmhvc3RfdmRw
YV9zZXRfdnJpbmdfY2FsbChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX2ZpbGUgKmZpbGUp
Cj4+Pj4+ICt7Cj4+Pj4+ICsgICAgc3RydWN0IHZob3N0X3ZkcGEgKnYgPSBkZXYtPm9wYXF1ZTsK
Pj4+Pj4gKwo+Pj4+PiArICAgIGlmICh2LT5zaGFkb3dfdnFzX2VuYWJsZWQpIHsKPj4+Pj4gKyAg
ICAgICAgaW50IHZkcGFfaWR4ID0gdmhvc3RfdmRwYV9nZXRfdnFfaW5kZXgoZGV2LCBmaWxlLT5p
bmRleCk7Cj4+Pj4+ICsgICAgICAgIFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEgPSBnX3B0cl9h
cnJheV9pbmRleCh2LT5zaGFkb3dfdnFzLCB2ZHBhX2lkeCk7Cj4+Pj4+ICsKPj4+Pj4gKyAgICAg
ICAgdmhvc3Rfc3ZxX3NldF9ndWVzdF9jYWxsX25vdGlmaWVyKHN2cSwgZmlsZS0+ZmQpOwo+Pj4+
IFR3byBxdWVzdGlvbnMgaGVyZSAoaGFkIHNpbWlsYXIgcXVlc3Rpb25zIGZvciB2cmluZyBraWNr
KToKPj4+Pgo+Pj4+IDEpIEFueSByZWFzb24gdGhhdCB3ZSBzZXR1cCB0aGUgZXZlbnRmZCBmb3Ig
dmhvc3QtdmRwYSBpbgo+Pj4+IHZob3N0X3ZkcGFfc3ZxX3NldHVwKCkgbm90IGhlcmU/Cj4+Pj4K
Pj4+IEknbSBub3Qgc3VyZSB3aGF0IHlvdSBtZWFuLgo+Pj4KPj4+IFRoZSBndWVzdC0+U1ZRIGNh
bGwgYW5kIGtpY2sgZmRzIGFyZSBzZXQgaGVyZSBhbmQgYXQKPj4+IHZob3N0X3ZkcGFfc2V0X3Zy
aW5nX2tpY2suIFRoZSBldmVudCBub3RpZmllciBoYW5kbGVyIG9mIHRoZSBndWVzdCAtPgo+Pj4g
U1ZRIGtpY2tfZmQgaXMgc2V0IGF0IHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2tpY2sgLwo+Pj4gdmhv
c3Rfc3ZxX3NldF9zdnFfa2lja19mZC4gVGhlIGd1ZXN0IC0+IFNWUSBjYWxsIGZkIGhhcyBubyBl
dmVudAo+Pj4gbm90aWZpZXIgaGFuZGxlciBzaW5jZSB3ZSBkb24ndCBwb2xsIGl0Lgo+Pj4KPj4+
IE9uIHRoZSBvdGhlciBoYW5kLCB0aGUgY29ubmVjdGlvbiBTVlEgPC0+IGRldmljZSB1c2VzIHRo
ZSBzYW1lIGZkcwo+Pj4gZnJvbSB0aGUgYmVnaW5uaW5nIHRvIHRoZSBlbmQsIGFuZCB0aGV5IHdp
bGwgbm90IGNoYW5nZSB3aXRoLCBmb3IKPj4+IGV4YW1wbGUsIGNhbGwgZmQgbWFza2luZy4gVGhh
dCdzIHdoeSBpdCdzIHNldHVwIGZyb20KPj4+IHZob3N0X3ZkcGFfc3ZxX3NldHVwLiBEZWxheWlu
ZyB0byB2aG9zdF92ZHBhX3NldF92cmluZ19jYWxsIHdvdWxkIG1ha2UKPj4+IHVzIGFkZCB3YXkg
bW9yZSBsb2dpYyB0aGVyZS4KPj4KPj4gTW9yZSBsb2dpYyBpbiBnZW5lcmFsIHNoYWRvdyB2cSBj
b2RlIGJ1dCBsZXNzIGNvZGVzIGZvciB2aG9zdC12ZHBhCj4+IHNwZWNpZmljIGNvZGUgSSB0aGlu
ay4KPj4KPj4gRS5nIGZvciB3ZSBjYW4gbW92ZSB0aGUga2ljayBzZXQgbG9naWMgZnJvbSB2aG9z
dF92ZHBhX3N2cV9zZXRfZmRzKCkgdG8KPj4gaGVyZS4KPj4KPiBCdXQgdGhleSBhcmUgZGlmZmVy
ZW50IGZkcy4gdmhvc3RfdmRwYV9zdnFfc2V0X2ZkcyBzZXRzIHRoZQo+IFNWUTwtPmRldmljZS4g
VGhpcyBmdW5jdGlvbiBzZXRzIHRoZSBTVlEtPmd1ZXN0IGNhbGwgZmlsZSBkZXNjcmlwdG9yLgo+
Cj4gVG8gbW92ZSB0aGUgbG9naWMgb2Ygdmhvc3RfdmRwYV9zdnFfc2V0X2ZkcyBoZXJlIHdvdWxk
IGltcGx5IGVpdGhlcjoKPiBhKSBMb2dpYyB0byBrbm93IGlmIHdlIGFyZSByZWNlaXZpbmcgdGhl
IGZpcnN0IGNhbGwgZmQgb3Igbm90LgoKCkFueSByZWFzb24gZm9yIHRoaXM/IEkgZ3Vlc3MgeW91
IG1lYW50IG11bHRpcXVldWUuIElmIHllcywgaXQgc2hvdWxkIG5vdCAKYmUgbXVjaCBkaWZmZXJl
bmNlIHNpbmNlIHdlIGhhdmUgaWR4IGFzIHRoZSBwYXJhbWV0ZXIuCgoKPiAgIFRoYXQKPiBjb2Rl
IGlzIG5vdCBpbiB0aGUgc2VyaWVzIGF0IHRoZSBtb21lbnQsIGJlY2F1c2Ugc2V0dGluZyBhdAo+
IHZob3N0X3ZkcGFfZGV2X3N0YXJ0IHRlbGxzIHRoZSBkaWZmZXJlbmNlIGZvciBmcmVlLiBJcyBq
dXN0IGFkZGluZwo+IGNvZGUsIG5vdCBtb3ZpbmcuCj4gYikgTG9naWMgdG8gc2V0IGFnYWluICp0
aGUgc2FtZSogZmlsZSBkZXNjcmlwdG9yIHRvIGRldmljZSwgd2l0aCBsb2dpYwo+IHRvIHRlbGwg
aWYgd2UgaGF2ZSBtaXNzZWQgY2FsbHMuIFRoYXQgbG9naWMgaXMgbm90IGltcGxlbWVudGVkIGZv
cgo+IGRldmljZS0+U1ZRIGNhbGwgZmlsZSBkZXNjcmlwdG9yLCBiZWNhdXNlIHdlIGFyZSBhc3N1
bWluZyBpdCBuZXZlcgo+IGNoYW5nZXMgZnJvbSB2aG9zdF92ZHBhX3N2cV9zZXRfZmRzLiBTbyB0
aGlzIGlzIGFnYWluIGFkZGluZyBjb2RlLgo+Cj4gQXQgdGhpcyBtb21lbnQsIHdlIGhhdmU6Cj4g
dmhvc3RfdmRwYV9zdnFfc2V0X2ZkczoKPiAgICBzZXQgU1ZRPC0+ZGV2aWNlIGZkcwo+Cj4gdmhv
c3RfdmRwYV9zZXRfdnJpbmdfY2FsbDoKPiAgICBzZXQgZ3Vlc3Q8LVNWUSBjYWxsCj4KPiB2aG9z
dF92ZHBhX3NldF92cmluZ19raWNrOgo+ICAgIHNldCBndWVzdC0+U1ZRIGtpY2suCj4KPiBJZiBJ
IHVuZGVyc3Rvb2QgY29ycmVjdGx5LCB0aGUgYWx0ZXJuYXRpdmUgd291bGQgYmUgc29tZXRoaW5n
IGxpa2U6Cj4gdmhvc3RfdmRwYV9zZXRfdnJpbmdfY2FsbDoKPiAgICBzZXQgZ3Vlc3Q8LVNWUSBj
YWxsCj4gICAgaWYoIXZxLT5jYWxsX3NldCkgewo+ICAgICAgLSBzZXQgU1ZRPC1kZXZpY2UgY2Fs
bC4KPiAgICAgIC0gdnEtPmNhbGxfc2V0ID0gdHJ1ZQo+ICAgIH0KPgo+IHZob3N0X3ZkcGFfc2V0
X3ZyaW5nX2tpY2s6Cj4gICAgc2V0IGd1ZXN0PC1TVlEgY2FsbAo+ICAgIGlmKCF2cS0+ZGV2X2tp
Y2tfc2V0KSB7Cj4gICAgICAtIHNldCBndWVzdC0+ZGV2aWNlIGtpY2suCj4gICAgICAtIHZxLT5k
ZXZfa2lja19zZXQgPSB0cnVlCj4gICAgfQo+Cj4gZGV2X3Jlc2V0IC8gZGV2X3N0b3A6Cj4gZm9y
IHZxIGluIHZxczoKPiAgICB2cS0+ZGV2X2tpY2tfc2V0ID0gdnEtPmRldl9jYWxsX3NldCA9IGZh
bHNlCj4gLi4uCj4KPiBPciBoYXZlIEkgbWlzdW5kZXJzdG9vZCBzb21ldGhpbmc/CgoKSSB3b25k
ZXIgd2hhdCBoYXBwZW5zIGlmIE1TSS1YIGlzIG1hc2tpbmcgaW4gZ3Vlc3QuIFNvIGlmIEkgdW5k
ZXJzdGFuZCAKY29ycmVjdGx5LCB3ZSBkb24ndCBkaXNhYmxlIHRoZSBldmVudGZkIGZyb20gZGV2
aWNlPyBJZiB5ZXMsIHRoaXMgc2VlbXMgCnN1Ym9wdGluYWwuCgpUaGFua3MKCgo+Cj4gVGhhbmtz
IQo+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4+IDIpIFRoZSBjYWxsIGNvdWxkIGJlIGRpc2FibGVkIGJ5
IHVzaW5nIC0xIGFzIHRoZSBmZCwgSSBkb24ndCBzZWUgYW55Cj4+Pj4gY29kZSB0byBkZWFsIHdp
dGggdGhhdC4KPj4+Pgo+Pj4gUmlnaHQsIEkgZGlkbid0IHRha2UgdGhhdCBpbnRvIGFjY291bnQu
IHZob3N0LWtlcm5lbCB0YWtlcyBhbHNvIC0xIGFzCj4+PiBraWNrX2ZkIHRvIHVuYmluZCwgc28g
U1ZRIGNhbiBiZSByZXdvcmtlZCB0byB0YWtlIHRoYXQgaW50byBhY2NvdW50Cj4+PiBmb3Igc3Vy
ZS4KPj4+Cj4+PiBUaGFua3MhCj4+Pgo+Pj4+IFRoYW5rcwo+Pj4+Cj4+Pj4KPj4+Pj4gKyAgICAg
ICAgcmV0dXJuIDA7Cj4+Pj4+ICsgICAgfSBlbHNlIHsKPj4+Pj4gKyAgICAgICAgcmV0dXJuIHZo
b3N0X3ZkcGFfc2V0X3ZyaW5nX2Rldl9jYWxsKGRldiwgZmlsZSk7Cj4+Pj4+ICsgICAgfQo+Pj4+
PiArfQo+Pj4+PiArCj4+Pj4+ICAgICAvKioKPj4+Pj4gICAgICAqIFNldCBzaGFkb3cgdmlydHF1
ZXVlIGRlc2NyaXB0b3JzIHRvIHRoZSBkZXZpY2UKPj4+Pj4gICAgICAqCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
