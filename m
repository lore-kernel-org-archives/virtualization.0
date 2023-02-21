Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3132EC61DA3
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 02:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1A1E400CC;
	Tue, 21 Feb 2023 02:38:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1A1E400CC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qpyn/DRa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s5vfdSQy5Rru; Tue, 21 Feb 2023 02:38:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1CAC44012A;
	Tue, 21 Feb 2023 02:38:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1CAC44012A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6810C0032;
	Tue, 21 Feb 2023 02:38:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 765EAC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 02:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49C44700D9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 02:38:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49C44700D9
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qpyn/DRa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5nzcV2wYWJwE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 02:38:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3675C6FFE9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3675C6FFE9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 02:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676947098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O1eETGbsNJ3o4GhZE8orvsa9aWlXBtgkGSwcd3OHgbs=;
 b=Qpyn/DRa24FN5Q0osHpA3pvuIO08RfoSU2RdhsJXYgFvlxvErfWOmO5L/EYkCu0+79R2mE
 zpVhiu22Io7MV0gLraifmTyTsdlJjow/U1fXlhLndt7eJ/T50F8bYlTRTAEByJfIVjf4Ky
 UKye+JBVn/s9GZ97xjyWpuFBiyHEnGo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-137-quVOgpMdOw2rz5ZiD_eoGg-1; Mon, 20 Feb 2023 21:38:17 -0500
X-MC-Unique: quVOgpMdOw2rz5ZiD_eoGg-1
Received: by mail-pg1-f198.google.com with SMTP id
 q68-20020a632a47000000b004f74bc0c71fso916951pgq.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 18:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O1eETGbsNJ3o4GhZE8orvsa9aWlXBtgkGSwcd3OHgbs=;
 b=pzKZ9cVuAjTNEyoVFOWxpK8eqC4hhdWmYyitpdmOLkzLaqSxtR+batEkb/iOvXTt4a
 HbtbPvJnqwt1dW+cQ06PF+OvylmW5PK64o/9js1l0OvbA8yP7N+mKWVASkcgUxja1gMa
 0HXuz9vjbTb8vKwCgKaIJ/teqzdu4CgE5sTTq1qezT5hfYAnrT0yofLCXruBXlc1otUu
 XJWKjdEvKlF8/FJGdQoSwsI9tN/JZGVSspCQqEM3Sp6LGk6qcvMqxNElP9AUTHw1bNAq
 LMdPPPSzL3a98EJK1JbOe7c6snpCsZHWjXzt7N55Pk9BUBeUk/ak6MbehRS4OmUOVDqO
 WJWw==
X-Gm-Message-State: AO0yUKVnKAqy9ApHwW6410OGauGX6cE4uvbXgN1e4qc1j4zBZLtaQtaf
 YK0IfHV1X65YxzfQT8mWE0n4qx6cnSpv0xHhCPgS9pORRyqexu4tqswlVgbvmGa9HViG01tCwzU
 nvOTg8a8aDaOK+LQ4cC305OTxC1drFzzCKsfCgZcDYQ==
X-Received: by 2002:a05:6a20:3ca0:b0:be:e0c3:5012 with SMTP id
 b32-20020a056a203ca000b000bee0c35012mr2696231pzj.1.1676947096339; 
 Mon, 20 Feb 2023 18:38:16 -0800 (PST)
X-Google-Smtp-Source: AK7set/720MKakE5XCGQ7Uh5rmW8ucJCIgp1rd9sNEeFmTZV4diZNLLhb5dWRXWL+38RQ13GmZ68VA==
X-Received: by 2002:a05:6a20:3ca0:b0:be:e0c3:5012 with SMTP id
 b32-20020a056a203ca000b000bee0c35012mr2696208pzj.1.1676947095997; 
 Mon, 20 Feb 2023 18:38:15 -0800 (PST)
Received: from [10.72.13.11] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 i26-20020aa78b5a000000b005a8e9e2f1c5sm845882pfd.187.2023.02.20.18.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Feb 2023 18:38:15 -0800 (PST)
Message-ID: <cc14248c-cd6c-d604-003c-7384363dab8e@redhat.com>
Date: Tue, 21 Feb 2023 10:38:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [patch net-next] net: virtio_net: implement exact header length
 guest feature
To: Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230217121547.3958716-1-jiri@resnulli.us>
 <20230217072032-mutt-send-email-mst@kernel.org> <Y+94418p73aUQyIn@nanopsycho>
 <20230217083915-mutt-send-email-mst@kernel.org> <Y/MwtAGru3yAY7r3@nanopsycho>
 <20230220074947-mutt-send-email-mst@kernel.org> <Y/N7+IJ+gzvP0IEf@nanopsycho>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <Y/N7+IJ+gzvP0IEf@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vitaly Mireyno <vmireyno@marvell.com>, netdev@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIzLzIvMjAgMjE6NTYsIEppcmkgUGlya28g5YaZ6YGTOgo+IE1vbiwgRmViIDIwLCAy
MDIzIGF0IDAxOjU1OjMzUE0gQ0VULCBtc3RAcmVkaGF0LmNvbSB3cm90ZToKPj4gT24gTW9uLCBG
ZWIgMjAsIDIwMjMgYXQgMDk6MzU6MDBBTSArMDEwMCwgSmlyaSBQaXJrbyB3cm90ZToKPj4+IEZy
aSwgRmViIDE3LCAyMDIzIGF0IDAyOjQ3OjM2UE0gQ0VULCBtc3RAcmVkaGF0LmNvbSB3cm90ZToK
Pj4+PiBPbiBGcmksIEZlYiAxNywgMjAyMyBhdCAwMTo1Mzo1NVBNICswMTAwLCBKaXJpIFBpcmtv
IHdyb3RlOgo+Pj4+PiBGcmksIEZlYiAxNywgMjAyMyBhdCAwMToyMjowMVBNIENFVCwgbXN0QHJl
ZGhhdC5jb20gd3JvdGU6Cj4+Pj4+PiBPbiBGcmksIEZlYiAxNywgMjAyMyBhdCAwMToxNTo0N1BN
ICswMTAwLCBKaXJpIFBpcmtvIHdyb3RlOgo+Pj4+Pj4+IEZyb206IEppcmkgUGlya28gPGppcmlA
bnZpZGlhLmNvbT4KPj4+Pj4+Pgo+Pj4+Pj4+IHZpcnRpb19uZXRfaGRyX2Zyb21fc2tiKCkgZmls
bHMgdXAgaGRyX2xlbiB0byBza2JfaGVhZGxlbihza2IpLgo+Pj4+Pj4+Cj4+Pj4+Pj4gVmlydGlv
IHNwZWMgaW50cm9kdWNlZCBhIGZlYXR1cmUgVklSVElPX05FVF9GX0dVRVNUX0hEUkxFTiB3aGlj
aCB3aGVuCj4+Pj4+Pj4gc2V0IGltcGxpY2F0ZXMgdGhhdCB0aGUgZHJpdmVyIHByb3ZpZGVzIHRo
ZSBleGFjdCBzaXplIG9mIHRoZSBoZWFkZXIuCj4+Pj4+Pj4KPj4+Pj4+PiBUaGUgZHJpdmVyIGFs
cmVhZHkgY29tcGxpZXMgdG8gZmlsbCB0aGUgY29ycmVjdCB2YWx1ZS4gSW50cm9kdWNlIHRoZQo+
Pj4+Pj4+IGZlYXR1cmUgYW5kIGFkdmVydGlzZSBpdC4KPj4+Pj4+Pgo+Pj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IEppcmkgUGlya28gPGppcmlAbnZpZGlhLmNvbT4KPj4+Pj4+IENvdWxkIHlvdSBhZGQg
YSBiaXQgb2YgbW90aXZhdGlvbiBqdXN0IGZvciB0aGUgcmVjb3JkPwo+Pj4+Pj4gRG9lcyB0aGlz
IGltcHJvdmUgcGVyZm9ybWFuY2UgZm9yIHNvbWUgY2FyZD8gQnkgaG93IG11Y2g/Cj4+Pj4+PiBF
eHBlY3RlZCB0byBoZWxwIHNvbWUgZnV0dXJlIGNhcmQ/Cj4+Pj4+IEkgY2FuIGdldCB0aGF0IGlu
Zm8sIGJ1dCBpc24ndCB0aGF0IHJhdGhlciBzb21ldGhpbmcgdG8gYmUgYXBwZW5kZWQgdG8KPj4+
Pj4gdGhlIHZpcnRpby1zcGVjIHBhdGNoPyBJIG1lYW4sIHRoZSBmZWF0dXJlIGlzIHRoZXJlLCB0
aGlzIGlzIGp1c3QKPj4+Pj4gaW1wbGVtZW50aW5nIGl0IGluIG9uZSBkcml2ZXIuCj4+Pj4gSXQg
aXMgbW9yZSBsaWtlIHVzaW5nIGl0IGluIHRoZSBkcml2ZXIuICBJdCdzIG5vdCBsaWtlIHdlIGhh
dmUgdG8gdXNlCj4+Pj4gZXZlcnl0aGluZyAtIGl0IGNvdWxkIGJlIHVzZWZ1bCBmb3IgZS5nLiBk
cGRrIGJ1dCBub3QgbGludXguCj4+Pj4gSW1wbGVtZW50aW5nIGl0IGluIHRoZSBMaW51eCBkcml2
ZXIgaGFzIHN1cHBvcnQgY29zdHMgLSBmb3IgZXhhbXBsZSB3aGF0Cj4+Pj4gaWYgdGhlcmUncyBh
IGJ1ZyBhbmQgc29tZXRpbWVzIHRoZSBsZW5ndGggaXMgaW5jb3JyZWN0Pwo+Pj4+IFdlJ2xsIGJl
IGJyZWFraW5nIHRoaW5ncy4KPj4+IEkgdW5kZXJzdGFuZC4gVG8gbXkgdW5kZXJzdGFuZGluZyB0
aGlzIGZlYXR1cmUganVzdCBmaXhlcyB0aGUgb3JpZ2luYWwKPj4+IGFtYmlndWl0eSBpbiB0aGUg
dmlydGlvIHNwZWMuCj4+Pgo+Pj4gUXVvdGluZyB0aGUgb3JpZ2luYWwgdmlydGlvIHNwZWM6Cj4+
PiAiaGRyX2xlbiBpcyBhIGhpbnQgdG8gdGhlIGRldmljZSBhcyB0byBob3cgbXVjaCBvZiB0aGUg
aGVhZGVyIG5lZWRzIHRvCj4+PiAgIGJlIGtlcHQgdG8gY29weSBpbnRvIGVhY2ggcGFja2V0Igo+
Pj4KPj4+ICJhIGhpbnQiIG1pZ2h0IG5vdCBiZSBjbGVhciBmb3IgdGhlIHJlYWRlciB3aGF0IGRv
ZXMgaXQgbWVhbiwgaWYgaXQgaXMKPj4+ICJtYXliZSBsaWtlIHRoYXQiIG9mICJleGFjdGx5IGxp
a2UgdGhhdCIuIFRoaXMgZmVhdHVyZSBqdXN0IG1ha2VzIGl0Cj4+PiBjcnlzdGFsIGNsZWFyLgo+
Pj4KPj4+IElmIHlvdSBsb29rIGF0IHRoZSB0YXAgaW1wbGVtZW50YXRpb24sIGl0IHVzZXMgaGRy
X2xlbiB0byBhbGxvYwo+Pj4gc2tiIGxpbmVhciBwYXJ0LiBObyBoaW50LCBpdCBjb3VudHMgd2l0
aCB0aGUgcHJvdmlkZWQgdmFsdWUuCj4+PiBTbyBpZiB0aGUgZHJpdmVyIGlzIGN1cnJlbnRseSBu
b3QgcHJlY2lzZSwgaXQgYnJlYWtzIHRhcC4KPj4gV2VsbCB0aGF0J3Mgb25seSBmb3IgZ3NvIHRo
b3VnaCByaWdodD8KPiBZZXAuCj4KPgo+PiBBbmQgbWFraW5nIGl0IGJpZ2dlciB0aGFuIG5lY2Vz
c2FyeSB3b3JrcyBmaW5lIC4uLgo+IFdlbGwgeWVhaC4gQnV0IHRhcCBkb2VzIG5vdCBkbyB0aGF0
LCBkb2VzIGl0PyBpdCB1c2VzIGhkcl9sZW4gZGlyZWN0bHkuCgoKdGFwX2dldF91c2VyKCkgbGlt
aXQgdGhlIGhlYWQgbGVuZ3RoOgoKCnN0YXRpYyBzc2l6ZV90IHRhcF9nZXRfdXNlcihzdHJ1Y3Qg
dGFwX3F1ZXVlICpxLCB2b2lkICptc2dfY29udHJvbCwKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaW92X2l0ZXIgKmZyb20sIGlu
dCBub2Jsb2NrKQp7CiDCoMKgIMKgaW50IGdvb2RfbGluZWFyID0gU0tCX01BWF9IRUFEKFRBUF9S
RVNFUlZFKTsKLi4uCgoKPgo+Cj4+PiBJIHdpbGwgYWRkIHRoaXMgdG8gdGhlIHBhdGNoIGRlc2Ny
aXB0aW9uIGFuZCBzZW5kIHYyLgo+Pj4KPj4gSSBmZWVsIHRoaXMgZG9lcyBub3QgYW5zd2VyIHRo
ZSBxdWVzdGlvbiB5ZXQsIG9yIG1heWJlIEkgYW0gYmVpbmcgZGVuc2UuCj4+IE15IHBvaW50IHdh
cyBub3QgYWJvdXQgbWFraW5nIGhkcl9sZW4gcHJlY2lzZS4gIE15IHBvaW50IHdhcyB0aGF0IHdl
IGFyZQo+PiBtYWtpbmcgYSBjaGFuZ2UgaGVyZSBmb3Igbm8gYXBwYXJlbnQgcmVhc29uLiBJIGFt
IGd1ZXNzaW5nIHlvdSBhcmUgbm90Cj4+IGRvaW5nIGl0IGZvciBmdW4gLSBzbyB3aHk/IElzIHRo
ZXJlIGEgZGV2aWNlIHdpdGggdGhpcyBmZWF0dXJlIGJpdAo+PiB5b3UgYXJlIGF3YXJlIG9mPwo+
IEFmYWlrIHJlYWwgaHcgd2hpY2ggZG9lcyBlbXVsYXRpb24gb2YgdmlydGlvX25ldCB3b3VsZCBi
ZW5lZml0IGZyb20KPiB0aGF0LCBvdXIgaHcgaW5jbHVkaW5nLgoKCk5vdGUgdGhhdCBkcml2ZXIg
Y2FuIGNob29zZSB0byBubyBuZWdvdGlhdGUgdGhpcyBmZWF0dXJlLCBzbyBtYWxpY2lvdXMgCmRy
aXZlcnMgY2FuIHN0aWxsIHRyeSB0byB1c2UgaWxsZWdhbCB2YWx1ZS4KClRoYW5rcwoKCj4KPgo+
Pgo+Pgo+Pj4+IFRoZSBwYXRjaCB3YXMgc3VibWl0dGVkIGJ5IE1hcnZlbGwgYnV0IHRoZXkgbmV2
ZXIgYm90aGVyZWQgd2l0aAo+Pj4+IHVzaW5nIGl0IGluIExpbnV4LiBJIGd1ZXNzIHRoZXkgYXJl
IHVzaW5nIGl0IGZvciBzb21ldGhpbmcgZWxzZT8KPj4+PiBDQyBWaXRhbHkgd2hvIHB1dCB0aGlz
IGluLgo+Pj4+Cj4+Pj4+PiB0aGFua3MhCj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+PiAtLS0KPj4+Pj4+
PiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyAgICAgICAgfCA2ICsrKystLQo+Pj4+Pj4+ICAg
aW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19uZXQuaCB8IDEgKwo+Pj4+Pj4+ICAgMiBmaWxlcyBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pj4+Pj4KPj4+Pj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4+Pj4+Pj4gaW5kZXggZmI1ZTY4ZWQzZWMyLi5lODViMDM5ODg3MzMgMTAwNjQ0Cj4+
Pj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+Pj4+Pj4gKysrIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4+Pj4+Pj4gQEAgLTYyLDcgKzYyLDggQEAgc3RhdGljIGNvbnN0
IHVuc2lnbmVkIGxvbmcgZ3Vlc3Rfb2ZmbG9hZHNbXSA9IHsKPj4+Pj4+PiAgIAlWSVJUSU9fTkVU
X0ZfR1VFU1RfVUZPLAo+Pj4+Pj4+ICAgCVZJUlRJT19ORVRfRl9HVUVTVF9DU1VNLAo+Pj4+Pj4+
ICAgCVZJUlRJT19ORVRfRl9HVUVTVF9VU080LAo+Pj4+Pj4+IC0JVklSVElPX05FVF9GX0dVRVNU
X1VTTzYKPj4+Pj4+PiArCVZJUlRJT19ORVRfRl9HVUVTVF9VU082LAo+Pj4+Pj4+ICsJVklSVElP
X05FVF9GX0dVRVNUX0hEUkxFTgo+Pj4+Pj4+ICAgfTsKPj4+Pj4+PiAgIAo+Pj4+Pj4+ICAgI2Rl
ZmluZSBHVUVTVF9PRkZMT0FEX0dST19IV19NQVNLICgoMVVMTCA8PCBWSVJUSU9fTkVUX0ZfR1VF
U1RfVFNPNCkgfCBcCj4+Pj4+Pj4gQEAgLTQyMTMsNyArNDIxNCw4IEBAIHN0YXRpYyBzdHJ1Y3Qg
dmlydGlvX2RldmljZV9pZCBpZF90YWJsZVtdID0gewo+Pj4+Pj4+ICAgCVZJUlRJT19ORVRfRl9D
VFJMX01BQ19BRERSLCBcCj4+Pj4+Pj4gICAJVklSVElPX05FVF9GX01UVSwgVklSVElPX05FVF9G
X0NUUkxfR1VFU1RfT0ZGTE9BRFMsIFwKPj4+Pj4+PiAgIAlWSVJUSU9fTkVUX0ZfU1BFRURfRFVQ
TEVYLCBWSVJUSU9fTkVUX0ZfU1RBTkRCWSwgXAo+Pj4+Pj4+IC0JVklSVElPX05FVF9GX1JTUywg
VklSVElPX05FVF9GX0hBU0hfUkVQT1JULCBWSVJUSU9fTkVUX0ZfTk9URl9DT0FMCj4+Pj4+Pj4g
KwlWSVJUSU9fTkVUX0ZfUlNTLCBWSVJUSU9fTkVUX0ZfSEFTSF9SRVBPUlQsIFZJUlRJT19ORVRf
Rl9OT1RGX0NPQUwsIFwKPj4+Pj4+PiArCVZJUlRJT19ORVRfRl9HVUVTVF9IRFJMRU4KPj4+Pj4+
PiAgIAo+Pj4+Pj4+ICAgc3RhdGljIHVuc2lnbmVkIGludCBmZWF0dXJlc1tdID0gewo+Pj4+Pj4+
ICAgCVZJUlRORVRfRkVBVFVSRVMsCj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9s
aW51eC92aXJ0aW9fbmV0LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oCj4+Pj4+
Pj4gaW5kZXggYjQwNjJiZWQxODZhLi4xMmMxYzk2OTk5MzUgMTAwNjQ0Cj4+Pj4+Pj4gLS0tIGEv
aW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19uZXQuaAo+Pj4+Pj4+ICsrKyBiL2luY2x1ZGUvdWFw
aS9saW51eC92aXJ0aW9fbmV0LmgKPj4+Pj4+PiBAQCAtNjEsNiArNjEsNyBAQAo+Pj4+Pj4+ICAg
I2RlZmluZSBWSVJUSU9fTkVUX0ZfR1VFU1RfVVNPNgk1NQkvKiBHdWVzdCBjYW4gaGFuZGxlIFVT
T3Y2IGluLiAqLwo+Pj4+Pj4+ICAgI2RlZmluZSBWSVJUSU9fTkVUX0ZfSE9TVF9VU08JNTYJLyog
SG9zdCBjYW4gaGFuZGxlIFVTTyBpbi4gKi8KPj4+Pj4+PiAgICNkZWZpbmUgVklSVElPX05FVF9G
X0hBU0hfUkVQT1JUICA1NwkvKiBTdXBwb3J0cyBoYXNoIHJlcG9ydCAqLwo+Pj4+Pj4+ICsjZGVm
aW5lIFZJUlRJT19ORVRfRl9HVUVTVF9IRFJMRU4gIDU5CS8qIEd1ZXN0IHByb3ZpZGVzIHRoZSBl
eGFjdCBoZHJfbGVuIHZhbHVlLiAqLwo+Pj4+Pj4+ICAgI2RlZmluZSBWSVJUSU9fTkVUX0ZfUlNT
CSAgNjAJLyogU3VwcG9ydHMgUlNTIFJYIHN0ZWVyaW5nICovCj4+Pj4+Pj4gICAjZGVmaW5lIFZJ
UlRJT19ORVRfRl9SU0NfRVhUCSAgNjEJLyogZXh0ZW5kZWQgY29hbGVzY2luZyBpbmZvICovCj4+
Pj4+Pj4gICAjZGVmaW5lIFZJUlRJT19ORVRfRl9TVEFOREJZCSAgNjIJLyogQWN0IGFzIHN0YW5k
YnkgZm9yIGFub3RoZXIgZGV2aWNlCj4+Pj4+Pj4gLS0gCj4+Pj4+Pj4gMi4zOS4wCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
