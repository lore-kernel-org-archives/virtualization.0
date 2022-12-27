Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35198C10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 14:37:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A619960C05;
	Tue, 27 Dec 2022 14:37:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A619960C05
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fzPa3yTR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nhPUOILRE_Zy; Tue, 27 Dec 2022 14:37:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0808A60C06;
	Tue, 27 Dec 2022 14:37:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0808A60C06
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C965FC0032;
	Tue, 27 Dec 2022 14:37:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3769EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 14:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1192040459
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 14:37:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1192040459
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fzPa3yTR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I-Al8izZQBCy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 14:37:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01CE8401AD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01CE8401AD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672151846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xgCz+tLYAfF9d3fkcqmVpnYWdED3weMm6ilwwtC+TyE=;
 b=fzPa3yTR0JMwQ2SRs2eYsCz1kzN+CqeiQ+fPLwe/jhSqbLDmFEFaa7BqFkGttHPamBvl+X
 uuyhCCXvSaHzRf79ttaQzO3nV+PYSj3eH+V3vuWktrdpwh0MC3+GdUZf+fA9J0dCe8cvRs
 bEGRzpsuNXBqAgDZ0r55h+CnYJPGWZ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-107-YCkLzJaWMAmHYkv7rrN9Ag-1; Tue, 27 Dec 2022 09:37:25 -0500
X-MC-Unique: YCkLzJaWMAmHYkv7rrN9Ag-1
Received: by mail-wr1-f69.google.com with SMTP id
 t18-20020adfa2d2000000b00277e6c6f275so693256wra.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 06:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xgCz+tLYAfF9d3fkcqmVpnYWdED3weMm6ilwwtC+TyE=;
 b=lPM1gyzOJ4UCvZNhNdmIMD/IUI//JX1gttajWH4yJdK/z6KyshRd1f8TwZGrciPBwy
 +vMak/TutGC96FgKov91mxhI88kqf55CfRP8kwoe3F6bfBP0DTmSdCTnDmtp73XNNi5i
 M72yqpZcq4LqnQtatoWL4BpHN5DBrHnpbTVA7bhiJFK4gOKL3h+YxIyo+pDn7BLFC9LW
 A/YxtVHdHDu0eZtB90reYeq0XdTUrSHGRw93De5iDgch87iIDxp8ylvMxRYJc0zQaO9C
 bfFq5+JDTNwfJG0zdOXEp466vQELPgFe2Xsg4T42gECyBnBpAgLz8WOwUyvCXusa+7yI
 UJwQ==
X-Gm-Message-State: AFqh2kpM0VNFWyrvRVtt8slMKalWFpi9Gu3PqPUO3PmFufBZ2J4KNd0S
 ThK5sCGzs8OfCveCx4ozKGFDDdAVaj9gTd9zPd3yQT+dChoRGxF5wbXOsEzCLoUGrLW5xPGFwgZ
 +OBTct/qI2apKJydu4L12qZl4a5Q1knKwe1USUL9XsA==
X-Received: by 2002:adf:e810:0:b0:276:4089:81c2 with SMTP id
 o16-20020adfe810000000b00276408981c2mr7127720wrm.41.1672151843986; 
 Tue, 27 Dec 2022 06:37:23 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuEQROGF+oitUSmj1Q8NX620ccWWcAn/1+eRYCelPItDeRg6waNVMMHTHrgmKbV/c3RtVQv9g==
X-Received: by 2002:adf:e810:0:b0:276:4089:81c2 with SMTP id
 o16-20020adfe810000000b00276408981c2mr7127707wrm.41.1672151843730; 
 Tue, 27 Dec 2022 06:37:23 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b0027e5501f7f5sm5002656wru.53.2022.12.27.06.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Dec 2022 06:37:23 -0800 (PST)
Date: Tue, 27 Dec 2022 09:37:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [RFC PATCH 4/9] vringh: unify the APIs for all accessors
Message-ID: <20221227075332-mutt-send-email-mst@kernel.org>
References: <20221227022528.609839-1-mie@igel.co.jp>
 <20221227022528.609839-5-mie@igel.co.jp>
 <20221227020007-mutt-send-email-mst@kernel.org>
 <CANXvt5pRy-i7=_ikNkZPp2HcRmWZYNJYpjO_ieBJJVc90nds+A@mail.gmail.com>
 <CANXvt5qUUOqB1CVgAk5KyL9sV+NsnJSKhatvdV12jH5=kBjjJw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANXvt5qUUOqB1CVgAk5KyL9sV+NsnJSKhatvdV12jH5=kBjjJw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMDc6MjI6MzZQTSArMDkwMCwgU2h1bnN1a2UgTWllIHdy
b3RlOgo+IDIwMjLlubQxMuaciDI35pelKOeBqykgMTY6NDkgU2h1bnN1a2UgTWllIDxtaWVAaWdl
bC5jby5qcD46Cj4gPgo+ID4gMjAyMuW5tDEy5pyIMjfml6Uo54GrKSAxNjowNCBNaWNoYWVsIFMu
IFRzaXJraW4gPG1zdEByZWRoYXQuY29tPjoKPiA+ID4KPiA+ID4gT24gVHVlLCBEZWMgMjcsIDIw
MjIgYXQgMTE6MjU6MjZBTSArMDkwMCwgU2h1bnN1a2UgTWllIHdyb3RlOgo+ID4gPiA+IEVhY2gg
dnJpbmdoIG1lbW9yeSBhY2Nlc3NvcnMgdGhhdCBhcmUgZm9yIHVzZXIsIGtlcm4gYW5kIGlvdGxi
IGhhcyBvd24KPiA+ID4gPiBpbnRlcmZhY2VzIHRoYXQgY2FsbHMgY29tbW9uIGNvZGUuIEJ1dCBz
b21lIGNvZGVzIGFyZSBkdXBsaWNhdGVkIGFuZCB0aGF0Cj4gPiA+ID4gYmVjb21lcyBsb3NzIGV4
dGVuZGFiaWxpdHkuCj4gPiA+ID4KPiA+ID4gPiBJbnRyb2R1Y2UgYSBzdHJ1Y3QgdnJpbmdoX29w
cyBhbmQgcHJvdmlkZSBhIGNvbW1vbiBBUElzIGZvciBhbGwgYWNjZXNzb3JzLgo+ID4gPiA+IEl0
IGNhbiBiZWUgZWFzaWx5IGV4dGVuZGVkIHZyaW5naCBjb2RlIGZvciBuZXcgbWVtb3J5IGFjY2Vz
c29yIGFuZAo+ID4gPiA+IHNpbXBsaWZpZWQgYSBjYWxsZXIgY29kZS4KPiA+ID4gPgo+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IFNodW5zdWtlIE1pZSA8bWllQGlnZWwuY28uanA+Cj4gPiA+ID4gLS0t
Cj4gPiA+ID4gIGRyaXZlcnMvdmhvc3QvdnJpbmdoLmMgfCA2NjcgKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4gPiAgaW5jbHVkZS9saW51eC92cmluZ2guaCB8
IDEwMCArKystLS0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMjUgaW5zZXJ0aW9ucygrKSwg
NTQyIGRlbGV0aW9ucygtKQo+ID4gPiA+Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhv
c3QvdnJpbmdoLmMgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gPiA+ID4gaW5kZXggYWEzY2Qy
N2QyMzg0Li5lYmZkMzY0NGExYTMgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy92aG9zdC92
cmluZ2guYwo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMKPiA+ID4gPiBAQCAt
MzUsMTUgKzM1LDEyIEBAIHN0YXRpYyBfX3ByaW50ZigxLDIpIF9fY29sZCB2b2lkIHZyaW5naF9i
YWQoY29uc3QgY2hhciAqZm10LCAuLi4pCj4gPiA+ID4gIH0KPiA+ID4gPgo+ID4gPiA+ICAvKiBS
ZXR1cm5zIHZyaW5nLT5udW0gaWYgZW1wdHksIC12ZSBvbiBlcnJvci4gKi8KPiA+ID4gPiAtc3Rh
dGljIGlubGluZSBpbnQgX192cmluZ2hfZ2V0X2hlYWQoY29uc3Qgc3RydWN0IHZyaW5naCAqdnJo
LAo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgKCpnZXR1MTYp
KGNvbnN0IHN0cnVjdCB2cmluZ2ggKnZyaCwKPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1MTYgKnZhbCwgY29uc3QgX192aXJ0aW8xNiAqcCks
Cj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHUxNiAqbGFzdF9hdmFp
bF9pZHgpCj4gPiA+ID4gK3N0YXRpYyBpbmxpbmUgaW50IF9fdnJpbmdoX2dldF9oZWFkKGNvbnN0
IHN0cnVjdCB2cmluZ2ggKnZyaCwgdTE2ICpsYXN0X2F2YWlsX2lkeCkKPiA+ID4gPiAgewo+ID4g
PiA+ICAgICAgIHUxNiBhdmFpbF9pZHgsIGksIGhlYWQ7Cj4gPiA+ID4gICAgICAgaW50IGVycjsK
PiA+ID4gPgo+ID4gPiA+IC0gICAgIGVyciA9IGdldHUxNih2cmgsICZhdmFpbF9pZHgsICZ2cmgt
PnZyaW5nLmF2YWlsLT5pZHgpOwo+ID4gPiA+ICsgICAgIGVyciA9IHZyaC0+b3BzLmdldHUxNih2
cmgsICZhdmFpbF9pZHgsICZ2cmgtPnZyaW5nLmF2YWlsLT5pZHgpOwo+ID4gPiA+ICAgICAgIGlm
IChlcnIpIHsKPiA+ID4gPiAgICAgICAgICAgICAgIHZyaW5naF9iYWQoIkZhaWxlZCB0byBhY2Nl
c3MgYXZhaWwgaWR4IGF0ICVwIiwKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgJnZy
aC0+dnJpbmcuYXZhaWwtPmlkeCk7Cj4gPiA+Cj4gPiA+IEkgbGlrZSB0aGF0IHRoaXMgcGF0Y2gg
cmVtb3ZlcyBtb3JlIGxpbmVzIG9mIGNvZGUgdGhhbiBpdCBhZGRzLgo+ID4gPgo+ID4gPiBIb3dl
dmVyIG9uZSBvZiB0aGUgZGVzaWduIHBvaW50cyBvZiB2cmluZ2ggYWJzdHJhY3Rpb25zIGlzIHRo
YXQgdGhleSB3ZXJlCj4gPiA+IGNhcmVmdWxseSB3cml0dGVuIHRvIGJlIHZlcnkgbG93IG92ZXJo
ZWFkLgo+ID4gPiBUaGlzIGlzIHdoeSB3ZSBhcmUgcGFzc2luZyBmdW5jdGlvbiBwb2ludGVycyB0
byBpbmxpbmUgZnVuY3Rpb25zIC0KPiA+ID4gY29tcGlsZXIgY2FuIG9wdGltaXplIHRoYXQgb3V0
Lgo+ID4gPgo+ID4gPiBJIHRoaW5rIHRoYXQgaW50cm9kdWNpbmcgb3BzIGluZGlyZWN0IGZ1bmN0
aW9ucyBjYWxscyBoZXJlIGlzIGdvaW5nIHRvIGJyZWFrCj4gPiA+IHRoZXNlIGFzc3VtcHRpb25z
IGFuZCBodXJ0IHBlcmZvcm1hbmNlLgo+ID4gPiBVbmxlc3MgY29tcGlsZXIgY2FuIHNvbWVob3cg
ZmlndXJlIGl0IG91dCBhbmQgb3B0aW1pemU/Cj4gPiA+IEkgZG9uJ3Qgc2VlIGhvdyBpdCdzIHBv
c3NpYmxlIHdpdGggb3BzIHBvaW50ZXIgaW4gbWVtb3J5Cj4gPiA+IGJ1dCBtYXliZSBJJ20gd3Jv
bmcuCj4gPiBJIHRoaW5rIHlvdXIgY29uY2VybiBpcyBjb3JyZWN0LiBJIGhhdmUgdG8gdW5kZXJz
dGFuZCB0aGUgY29tcGlsZXIKPiA+IG9wdGltaXphdGlvbiBhbmQgcmVkZXNpZ24gdGhpcyBhcHBy
b2FjaCBJZiBpdCBpcyBuZWVkZWQuCj4gPiA+IFdhcyBhbnkgZWZmb3J0IHRha2VuIHRvIHRlc3Qg
ZWZmZWN0IG9mIHRoZXNlIHBhdGNoZXMgb24gcGVyZm9ybWFuY2U/Cj4gPiBJIGp1c3QgdGVzdGVk
IHZyaW5naF90ZXN0IGFuZCBhbHJlYWR5IGZhY2VkIGxpdHRsZSBwZXJmb3JtYW5jZSByZWR1Y3Rp
b24uCj4gPiBJIGhhdmUgdG8gaW52ZXN0aWdhdGUgdGhhdCwgYXMgeW91IHNhaWQuCj4gSSBhdHRl
bXB0ZWQgdG8gdGVzdCB3aXRoIHBlcmYuIEkgZm91bmQgdGhhdCB0aGUgcGVyZm9ybWFuY2Ugb2Yg
cGF0Y2hlZCBjb2RlCj4gaXMgYWxtb3N0IHRoZSBzYW1lIGFzIHRoZSB1cHN0cmVhbSBvbmUuIEhv
d2V2ZXIsIEkgaGF2ZSB0byBpbnZlc3RpZ2F0ZSB3YXkKPiB0aGlzIHBhdGNoIGxlYWRzIHRvIHRo
aXMgcmVzdWx0LCBhbHNvIHRoZSBwcm9maWxpbmcgc2hvdWxkIGJlIHJ1biBvbgo+IG1vcmUgcG93
ZXJmdWwKPiBtYWNoaW5lcyB0b28uCj4gCj4gZW52aXJvbm1lbnQ6Cj4gJCBncmVwICdtb2RlbCBu
YW1lJyAvcHJvYy9jcHVpbmZvCj4gbW9kZWwgbmFtZSAgICAgIDogSW50ZWwoUikgQ29yZShUTSkg
aTMtNzAyMFUgQ1BVIEAgMi4zMEdIego+IG1vZGVsIG5hbWUgICAgICA6IEludGVsKFIpIENvcmUo
VE0pIGkzLTcwMjBVIENQVSBAIDIuMzBHSHoKPiBtb2RlbCBuYW1lICAgICAgOiBJbnRlbChSKSBD
b3JlKFRNKSBpMy03MDIwVSBDUFUgQCAyLjMwR0h6Cj4gbW9kZWwgbmFtZSAgICAgIDogSW50ZWwo
UikgQ29yZShUTSkgaTMtNzAyMFUgQ1BVIEAgMi4zMEdIego+IAo+IHJlc3VsdHM6Cj4gKiBmb3Ig
cGF0Y2hlZCBjb2RlCj4gIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICduaWNlIC1uIC0y
MCAuL3ZyaW5naF90ZXN0X3BhdGNoZWQKPiAtLXBhcmFsbGVsIC0tZXZlbnRpZHggLS1mYXN0LXZy
aW5naCAtLWluZGlyZWN0IC0tdmlydGlvLTEnICgyMCBydW5zKToKPiAKPiAgICAgICAgICAgMyww
MjguMDUgbXNlYyB0YXNrLWNsb2NrICAgICAgICAgICAgICAgICMgICAgMC45OTUgQ1BVcwo+IHV0
aWxpemVkICAgICAgICAgICAgKCArLSAgMC4xMiUgKQo+ICAgICAgICAgICAgIDc4LDE1MCAgICAg
IGNvbnRleHQtc3dpdGNoZXMgICAgICAgICAgIyAgIDI1LjY5MSBLL3NlYwo+ICAgICAgICAgICAg
ICAgICggKy0gIDAuMDAlICkKPiAgICAgICAgICAgICAgICAgIDUgICAgICBjcHUtbWlncmF0aW9u
cyAgICAgICAgICAgICMgICAgMS42NDQgL3NlYwo+ICAgICAgICAgICAgICAgICggKy0gIDMuMzMl
ICkKPiAgICAgICAgICAgICAgICAxOTAgICAgICBwYWdlLWZhdWx0cyAgICAgICAgICAgICAgICMg
ICA2Mi40NjEgL3NlYwo+ICAgICAgICAgICAgICAgICggKy0gIDAuNDElICkKPiAgICAgIDYsOTE5
LDAyNSwyMjIgICAgICBjeWNsZXMgICAgICAgICAgICAgICAgICAgICMgICAgMi4yNzUgR0h6Cj4g
ICAgICAgICAgICAgICAgKCArLSAgMC4xMyUgKQo+ICAgICAgOCw5OTAsMjIwLDE2MCAgICAgIGlu
c3RydWN0aW9ucyAgICAgICAgICAgICAgIyAgICAxLjI5ICBpbnNuIHBlcgo+IGN5Y2xlICAgICAg
ICAgICAoICstICAwLjA0JSApCj4gICAgICAxLDc4OCwzMjYsNzg2ICAgICAgYnJhbmNoZXMgICAg
ICAgICAgICAgICAgICAjICA1ODcuODk5IE0vc2VjCj4gICAgICAgICAgICAgICAgKCArLSAgMC4w
NSUgKQo+ICAgICAgICAgIDQsNTU3LDM5OCAgICAgIGJyYW5jaC1taXNzZXMgICAgICAgICAgICAg
IyAgICAwLjI1JSBvZiBhbGwKPiBicmFuY2hlcyAgICAgICAgICAoICstICAwLjQzJSApCj4gCj4g
ICAgICAgICAgICAzLjA0MzU5ICstIDAuMDAzNzggc2Vjb25kcyB0aW1lIGVsYXBzZWQgICggKy0g
IDAuMTIlICkKPiAKPiAqIGZvciB1cHN0cmVhbSBjb2RlCj4gIFBlcmZvcm1hbmNlIGNvdW50ZXIg
c3RhdHMgZm9yICduaWNlIC1uIC0yMCAuL3ZyaW5naF90ZXN0X2Jhc2UKPiAtLXBhcmFsbGVsIC0t
ZXZlbnRpZHggLS1mYXN0LXZyaW5naCAtLWluZGlyZWN0IC0tdmlydGlvLTEnICgxMCBydW5zKToK
PiAKPiAgICAgICAgICAgMywwNTguNDEgbXNlYyB0YXNrLWNsb2NrICAgICAgICAgICAgICAgICMg
ICAgMC45OTkgQ1BVcwo+IHV0aWxpemVkICAgICAgICAgICAgKCArLSAgMC4xNCUgKQo+ICAgICAg
ICAgICAgIDc4LDE0OSAgICAgIGNvbnRleHQtc3dpdGNoZXMgICAgICAgICAgIyAgIDI1LjU0NSBL
L3NlYwo+ICAgICAgICAgICAgICAgICggKy0gIDAuMDAlICkKPiAgICAgICAgICAgICAgICAgIDUg
ICAgICBjcHUtbWlncmF0aW9ucyAgICAgICAgICAgICMgICAgMS42MzQgL3NlYwo+ICAgICAgICAg
ICAgICAgICggKy0gIDIuNjclICkKPiAgICAgICAgICAgICAgICAxOTQgICAgICBwYWdlLWZhdWx0
cyAgICAgICAgICAgICAgICMgICA2My40MTQgL3NlYwo+ICAgICAgICAgICAgICAgICggKy0gIDAu
NDMlICkKPiAgICAgIDYsOTg4LDcxMyw5NjMgICAgICBjeWNsZXMgICAgICAgICAgICAgICAgICAg
ICMgICAgMi4yODQgR0h6Cj4gICAgICAgICAgICAgICAgKCArLSAgMC4xNCUgKQo+ICAgICAgOCw1
MTIsNTMzLDI2OSAgICAgIGluc3RydWN0aW9ucyAgICAgICAgICAgICAgIyAgICAxLjIyICBpbnNu
IHBlcgo+IGN5Y2xlICAgICAgICAgICAoICstICAwLjA0JSApCj4gICAgICAxLDYzOCwzNzUsMzcx
ICAgICAgYnJhbmNoZXMgICAgICAgICAgICAgICAgICAjICA1MzUuNTQ5IE0vc2VjCj4gICAgICAg
ICAgICAgICAgKCArLSAgMC4wNSUgKQo+ICAgICAgICAgIDQsNDI4LDg2NiAgICAgIGJyYW5jaC1t
aXNzZXMgICAgICAgICAgICAgIyAgICAwLjI3JSBvZiBhbGwKPiBicmFuY2hlcyAgICAgICAgICAo
ICstIDIyLjU3JSApCj4gCj4gICAgICAgICAgICAzLjA2MDg1ICstIDAuMDA0MjAgc2Vjb25kcyB0
aW1lIGVsYXBzZWQgICggKy0gIDAuMTQlICkKCgpIb3cgeW91IGNvbXBpbGVkIGl0IGFsc28gbWF0
dGVycy4gQVRNIHdlIGRvbid0IGVuYWJsZSByZXRwb2xpbmVzCmFuZCBpdCBkaWQgbm90IG1hdHRl
ciBzaW5jZSB3ZSBkaWRuJ3QgaGF2ZSBpbmRpcmVjdCBjYWxscywKYnV0IHdlIHNob3VsZC4gRGlk
bid0IHlldCBpbnZlc3RpZ2F0ZSBob3cgdG8gZG8gdGhhdCBmb3IgdmlydGlvIHRvb2xzLgoKCj4g
PiBUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMuCj4gPiA+IFRoYW5rcyEKPiA+ID4KPiA+ID4K
PiA+IEJlc3QsCj4gPiBTaHVuc3VrZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
