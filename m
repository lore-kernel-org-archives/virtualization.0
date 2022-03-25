Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FE2C433EF
	for <virtualization@archiver.kernel.org>; Fri, 25 Mar 2022 07:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 27039400D8;
	Fri, 25 Mar 2022 07:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VMiDnjabTDoJ; Fri, 25 Mar 2022 07:37:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3D73D40491;
	Fri, 25 Mar 2022 07:37:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 119B8C002C;
	Fri, 25 Mar 2022 07:37:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88909C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:37:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6081640491
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:37:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SO0ze1T9szly
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:37:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 171CC400D8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648193855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+u21dQM1qzDmbWffj78hAjrJstFjwXEL/dMQcaC4brE=;
 b=Mmq3QEdyO7CKMZlxUSRpFBfqH0EICjMR60x7ZPaoR2sdBtYkFBdkbndL/4++WSckD5XcKg
 y/EUk2we063PyIYNkRqUl3AkFttgcYP3IxAZHsoAbhOmF3sNdCtk8WDhjOEhOgjpCkwGeS
 CvXCi6FOr/8S+juED2xur0ZO7XJl2qM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-fe4jVlBnMG6CaxWCOQzluw-1; Fri, 25 Mar 2022 03:37:34 -0400
X-MC-Unique: fe4jVlBnMG6CaxWCOQzluw-1
Received: by mail-yb1-f200.google.com with SMTP id
 a12-20020a25938c000000b0063467614126so5536377ybm.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 00:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+u21dQM1qzDmbWffj78hAjrJstFjwXEL/dMQcaC4brE=;
 b=yNfaAn/6gsta5nKQ4Msd3QTBO/4yG5Mby/bOXp1Nbo0Z/E2MN+T7ohz2LrRyCsEy+b
 CknQmCEyJhGdauc13I3XQ4G554eCU1/GNm5seyOn7o93APM7hR5dZ7KOCNKFTeqmYJ3f
 uuo8E8m/MdFokjWqj/soxnYJsDA9W5Wc2ULvI35EH+kr2hCiINQpc8YiPX3+fiTe8WgJ
 q9/4eXu2XBLM1ETsJVhDnEfed88yL2NIM5XNvn2F47z72wlBk2dy6aXDNGayxutGuCr+
 +xr4VrN8GdPQPtjqXJ57HHV6xMmSP8tiloj/6V0tE95pjYbKagEZV7OjNhLLhNjZPIfw
 4CTA==
X-Gm-Message-State: AOAM533doFgUgFD8RLQpYclPxM6jts+L0LUKTs6auVVcNsyVgSrXLhe+
 UCirT2OpkPaTf8mZyzzjeId8P0qMCLjJevzZY+EGxWb3oUcg6TD30zYPoHwrLe0RteCN607KgFM
 1JWJKmKUZCtHMiqHMjUoZsQHXsmLnwCFBYOTo/M1Kq/MsYbvfm7sJ/uncag==
X-Received: by 2002:a25:3bd4:0:b0:633:6772:5ac1 with SMTP id
 i203-20020a253bd4000000b0063367725ac1mr8215468yba.431.1648193854336; 
 Fri, 25 Mar 2022 00:37:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0/3K5rHNK3jc76GysNfvhDyn8mzjKOfUOQKo/A0z/bsWiNLsDhFRXVgLUkd6kZG34GCnKlcAwwXyOS7WbLtk=
X-Received: by 2002:a25:3bd4:0:b0:633:6772:5ac1 with SMTP id
 i203-20020a253bd4000000b0063367725ac1mr8215459yba.431.1648193854063; Fri, 25
 Mar 2022 00:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-17-xuanzhuo@linux.alibaba.com>
 <e61a9ff4-621b-e7ec-b819-1b4c7e38fa67@redhat.com>
 <1648110896.1444745-3-xuanzhuo@linux.alibaba.com>
 <20220324063723-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220324063723-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 25 Mar 2022 15:37:23 +0800
Message-ID: <CACGkMEvLELsBZWPYbh7TbnGW43m6ahKZouWePy+4VnWADsr1tw@mail.gmail.com>
Subject: Re: [PATCH v8 16/16] virtio_ring: introduce virtqueue_resize()
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

T24gVGh1LCBNYXIgMjQsIDIwMjIgYXQgNjo0MSBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgTWFyIDI0LCAyMDIyIGF0IDA0OjM0OjU2UE0g
KzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPiA+IE9uIFR1ZSwgMjIgTWFyIDIwMjIgMTQ6MDI6NDcg
KzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4g
PiDlnKggMjAyMi8zLzE0IOS4i+WNiDU6MzQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+ID4gSW50
cm9kdWNlIHZpcnRxdWV1ZV9yZXNpemUoKSB0byBpbXBsZW1lbnQgdGhlIHJlc2l6ZSBvZiB2cmlu
Zy4KPiA+ID4gPiBCYXNlZCBvbiB0aGVzZSwgdGhlIGRyaXZlciBjYW4gZHluYW1pY2FsbHkgYWRq
dXN0IHRoZSBzaXplIG9mIHRoZSB2cmluZy4KPiA+ID4gPiBGb3IgZXhhbXBsZTogZXRodG9vbCAt
Ry4KPiA+ID4gPgo+ID4gPiA+IHZpcnRxdWV1ZV9yZXNpemUoKSBpbXBsZW1lbnRzIHJlc2l6ZSBi
YXNlZCBvbiB0aGUgdnEgcmVzZXQgZnVuY3Rpb24uIEluCj4gPiA+ID4gY2FzZSBvZiBmYWlsdXJl
IHRvIGFsbG9jYXRlIGEgbmV3IHZyaW5nLCBpdCB3aWxsIGdpdmUgdXAgcmVzaXplIGFuZCB1c2UK
PiA+ID4gPiB0aGUgb3JpZ2luYWwgdnJpbmcuCj4gPiA+ID4KPiA+ID4gPiBEdXJpbmcgdGhpcyBw
cm9jZXNzLCBpZiB0aGUgcmUtZW5hYmxlIHJlc2V0IHZxIGZhaWxzLCB0aGUgdnEgY2FuIG5vCj4g
PiA+ID4gbG9uZ2VyIGJlIHVzZWQuIEFsdGhvdWdoIHRoZSBwcm9iYWJpbGl0eSBvZiB0aGlzIHNp
dHVhdGlvbiBpcyBub3QgaGlnaC4KPiA+ID4gPgo+ID4gPiA+IFRoZSBwYXJhbWV0ZXIgcmVjeWNs
ZSBpcyB1c2VkIHRvIHJlY3ljbGUgdGhlIGJ1ZmZlciB0aGF0IGlzIG5vIGxvbmdlcgo+ID4gPiA+
IHVzZWQuCj4gPiA+ID4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVv
QGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+ICAgZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYyB8IDY3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+
ID4gPiA+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAzICsrCj4gPiA+ID4gICAy
IGZpbGVzIGNoYW5nZWQsIDcwIGluc2VydGlvbnMoKykKPiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYwo+ID4gPiA+IGluZGV4IGZiMGFiZjlhMmY1Ny4uYjFkZGUwODZhOGE0IDEwMDY0NAo+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gPiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gQEAgLTI1MjgsNiArMjUyOCw3MyBA
QCBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlKAo+ID4gPiA+ICAgfQo+
ID4gPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwodnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZSk7Cj4gPiA+
ID4KPiA+ID4gPiArLyoqCj4gPiA+ID4gKyAqIHZpcnRxdWV1ZV9yZXNpemUgLSByZXNpemUgdGhl
IHZyaW5nIG9mIHZxCj4gPiA+ID4gKyAqIEB2cTogdGhlIHN0cnVjdCB2aXJ0cXVldWUgd2UncmUg
dGFsa2luZyBhYm91dC4KPiA+ID4gPiArICogQG51bTogbmV3IHJpbmcgbnVtCj4gPiA+ID4gKyAq
IEByZWN5Y2xlOiBjYWxsYmFjayBmb3IgcmVjeWNsZSB0aGUgdXNlbGVzcyBidWZmZXIKPiA+ID4g
PiArICoKPiA+ID4gPiArICogV2hlbiBpdCBpcyByZWFsbHkgbmVjZXNzYXJ5IHRvIGNyZWF0ZSBh
IG5ldyB2cmluZywgaXQgd2lsbCBzZXQgdGhlIGN1cnJlbnQgdnEKPiA+ID4gPiArICogaW50byB0
aGUgcmVzZXQgc3RhdGUuIFRoZW4gY2FsbCB0aGUgcGFzc2VkIGNiIHRvIHJlY3ljbGUgdGhlIGJ1
ZmZlciB0aGF0IGlzCj4gPiA+ID4gKyAqIG5vIGxvbmdlciB1c2VkLiBPbmx5IGFmdGVyIHRoZSBu
ZXcgdnJpbmcgaXMgc3VjY2Vzc2Z1bGx5IGNyZWF0ZWQsIHRoZSBvbGQKPiA+ID4gPiArICogdnJp
bmcgd2lsbCBiZSByZWxlYXNlZC4KPiA+ID4gPiArICoKPiA+ID4gPiArICogQ2FsbGVyIG11c3Qg
ZW5zdXJlIHdlIGRvbid0IGNhbGwgdGhpcyB3aXRoIG90aGVyIHZpcnRxdWV1ZSBvcGVyYXRpb25z
Cj4gPiA+ID4gKyAqIGF0IHRoZSBzYW1lIHRpbWUgKGV4Y2VwdCB3aGVyZSBub3RlZCkuCj4gPiA+
ID4gKyAqCj4gPiA+ID4gKyAqIFJldHVybnMgemVybyBvciBhIG5lZ2F0aXZlIGVycm9yLgo+ID4g
PiA+ICsgKiAtRU5PTUVNOiBjcmVhdGUgbmV3IHZyaW5nIGZhaWwuIEJ1dCB2cSBjYW4gc3RpbGwg
d29yawo+ID4gPiA+ICsgKiAtRUJVU1k6ICByZXNldC9yZS1lbmFibGUgdnEgZmFpbC4gdnEgbWF5
IGNhbm5vdCB3b3JrCj4gPiA+ID4gKyAqIC1FTk9FTlQ6IG5vdCBzdXBwb3J0IHJlc2l6ZQo+ID4g
PiA+ICsgKiAtRTJCSUcvLUVJTlZBTDogcGFyYW0gbnVtIGVycm9yCj4gPiA+ID4gKyAqLwo+ID4g
PiA+ICtpbnQgdmlydHF1ZXVlX3Jlc2l6ZShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdTMyIG51bSwK
PiA+ID4gPiArICAgICAgICAgICAgICB2b2lkICgqcmVjeWNsZSkoc3RydWN0IHZpcnRxdWV1ZSAq
dnEsIHZvaWQgKmJ1ZikpCj4gPiA+ID4gK3sKPiA+ID4gPiArIHN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2ID0gdnEtPnZkZXY7Cj4gPiA+ID4gKyB2b2lkICpidWY7Cj4gPiA+ID4gKyBpbnQgZXJy
Owo+ID4gPiA+ICsKPiA+ID4gPiArIGlmIChudW0gPiB2cS0+bnVtX21heCkKPiA+ID4gPiArICAg
ICAgICAgcmV0dXJuIC1FMkJJRzsKPiA+ID4gPiArCj4gPiA+ID4gKyBpZiAoIW51bSkKPiA+ID4g
PiArICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gPiA+ID4gKwo+ID4gPiA+ICsgaWYgKHRvX3Z2
cSh2cSktPnBhY2tlZC52cmluZy5udW0gPT0gbnVtKQo+ID4gPiA+ICsgICAgICAgICByZXR1cm4g
MDsKPiA+ID4KPiA+ID4KPiA+ID4gQW55IHJlYXNvbiB3ZSBuZWVkIHRvIGNoZWNrIGEgcGFja2Vk
IHNwZWNpZmljIGF0dHJpYnV0ZSBoZXJlPwo+ID4KPiA+IFRoaXMgaXMgYSBtaXN0YWtlLiBTb3Jy
eSBmb3IgdGhpcy4KPiA+Cj4gPiA+Cj4gPiA+Cj4gPiA+ID4gKwo+ID4gPiA+ICsgaWYgKCF2cS0+
dmRldi0+Y29uZmlnLT5yZXNldF92cSkKPiA+ID4gPiArICAgICAgICAgcmV0dXJuIC1FTk9FTlQ7
Cj4gPiA+ID4gKwo+ID4gPiA+ICsgaWYgKCF2cS0+dmRldi0+Y29uZmlnLT5lbmFibGVfcmVzZXRf
dnEpCj4gPiA+ID4gKyAgICAgICAgIHJldHVybiAtRU5PRU5UOwo+ID4gPiA+ICsKPiA+ID4gPiAr
IGVyciA9IHZxLT52ZGV2LT5jb25maWctPnJlc2V0X3ZxKHZxKTsKPiA+ID4gPiArIGlmIChlcnIp
IHsKPiA+ID4gPiArICAgICAgICAgaWYgKGVyciAhPSAtRU5PRU5UKQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgIGVyciA9IC1FQlVTWTsKPiA+ID4gPiArICAgICAgICAgcmV0dXJuIGVycjsKPiA+
ID4gPiArIH0KPiA+ID4gPiArCj4gPiA+ID4gKyB3aGlsZSAoKGJ1ZiA9IHZpcnRxdWV1ZV9kZXRh
Y2hfdW51c2VkX2J1Zih2cSkpICE9IE5VTEwpCj4gPiA+ID4gKyAgICAgICAgIHJlY3ljbGUodnEs
IGJ1Zik7Cj4gPiA+ID4gKwo+ID4gPiA+ICsgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBW
SVJUSU9fRl9SSU5HX1BBQ0tFRCkpCj4gPiA+ID4gKyAgICAgICAgIGVyciA9IHZpcnRxdWV1ZV9y
ZXNpemVfcGFja2VkKHZxLCBudW0pOwo+ID4gPiA+ICsgZWxzZQo+ID4gPiA+ICsgICAgICAgICBl
cnIgPSB2aXJ0cXVldWVfcmVzaXplX3NwbGl0KHZxLCBudW0pOwo+ID4gPiA+ICsKPiA+ID4gPiAr
IGlmIChlcnIpCj4gPiA+ID4gKyAgICAgICAgIGVyciA9IC1FTk9NRU07Cj4gPiA+Cj4gPiA+Cj4g
PiA+IFNvIHRoaXMgYXNzdW1lcyB0aGF0IHRoZSAtRU5PTUVNIGlzIHRoZSBvbmx5IHBvc3NpYmxl
IGVycm9yIHZhbHVlIGZvcgo+ID4gPiB2aXJ0cXVldWVfcmVzaXplX3h4eCgpLiBJcyB0aGlzIHRy
dWU/IChFLmcgd3Jvbmcgc2l6ZSkKPiA+Cj4gPiBZZXMsIEkgd2FudCB0aGUgdXNlciB0byBrbm93
IGF0IHdoaWNoIHN0ZXAgdGhlIGVycm9yIGlzIHJldHVybmVkLgo+ID4KPiA+ID4KPiA+ID4KPiA+
ID4gPiArCj4gPiA+ID4gKyBpZiAodnEtPnZkZXYtPmNvbmZpZy0+ZW5hYmxlX3Jlc2V0X3ZxKHZx
KSkKPiA+ID4gPiArICAgICAgICAgcmV0dXJuIC1FQlVTWTsKPiA+ID4gPiArCj4gPiA+ID4gKyBy
ZXR1cm4gZXJyOwo+ID4gPiA+ICt9Cj4gPiA+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1
ZV9yZXNpemUpOwo+ID4gPiA+ICsKPiA+ID4gPiAgIC8qIE9ubHkgYXZhaWxhYmxlIGZvciBzcGxp
dCByaW5nICovCj4gPiA+ID4gICBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19uZXdfdmlydHF1ZXVl
KHVuc2lnbmVkIGludCBpbmRleCwKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgaW50IG51bSwKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC92aXJ0aW8uaCBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiA+ID4gPiBpbmRleCBk
NTlhZGM0YmUwNjguLmM4NmZmMDJlMGNhMCAxMDA2NDQKPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xp
bnV4L3ZpcnRpby5oCj4gPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ID4gPiA+
IEBAIC05MSw2ICs5MSw5IEBAIGRtYV9hZGRyX3QgdmlydHF1ZXVlX2dldF9kZXNjX2FkZHIoc3Ry
dWN0IHZpcnRxdWV1ZSAqdnEpOwo+ID4gPiA+ICAgZG1hX2FkZHJfdCB2aXJ0cXVldWVfZ2V0X2F2
YWlsX2FkZHIoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ID4gPiA+ICAgZG1hX2FkZHJfdCB2aXJ0
cXVldWVfZ2V0X3VzZWRfYWRkcihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gPiA+ID4KPiA+ID4g
PiAraW50IHZpcnRxdWV1ZV9yZXNpemUoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHUzMiBudW0sCj4g
PiA+ID4gKyAgICAgICAgICAgICAgdm9pZCAoKnJlY3ljbGUpKHN0cnVjdCB2aXJ0cXVldWUgKnZx
LCB2b2lkICpidWYpKTsKPiA+ID4KPiA+ID4KPiA+ID4gSSB3b25kZXIgd2hhdCdzIHRoZSBhZHZh
bnRhZ2VzIG9mIGNvdXBsaW5nIHZpcnRxdWV1ZV9yZXNldCBpbgo+ID4gPiB2aXJ0cXVldWVfcmVz
aXplKCkuCj4gPgo+ID4gVGhpcyBpcyBNaWNoYWVsJ3MgY29tbWVudCBvbiB0aGUgcHJldmlvdXMg
dmVyc2lvbgo+ID4KPiA+ID4KPiA+ID4gSXQgbG9va3MgdG8gbWUgaXQgd29sZCBiZSBtb3JlIGZs
ZXhpYmxlIHRvIGxldCB0aGUgZHJpdmVyIGRvOgo+ID4gPgo+ID4gPiByZXN0KCkKPiA+ID4KPiA+
ID4gZGV0YWNoKCkKPiA+ID4KPiA+ID4gcmVzaXplKCkKPiA+ID4KPiA+ID4gZW5hYmxlX3Jlc2V0
KCkKPiA+ID4KPiA+ID4gT25lIHJlYXNvbiBpcyB0aGF0IGluIHRoZSBmdXR1cmUgd2UgbWF5IHdh
bnQgdG8gYWRkIG1vcmUgZnVuY3Rpb25hbGl0eQo+ID4gPiBlLmcgc3dpdGNoaW5nIFBBU0lEIGR1
cmluZyB2aXJ0cXVldWUgcmVzZXQuCj4gPgo+ID4gTWljaGFlbCwgZnJvbSBKYXNvbiBXYW5nJ3Mg
cGxhbiwgc2hvdWxkIHdlIGdvIGJhY2sgdG8gdGhlIG9yaWdpbmFsIDQgYXBpIG1vZGVsPwo+ID4K
PiA+IFRoYW5rcy4KPgo+Cj4gSmFzb24sIEkgZmVlbCBhIHNpbmdsZSBhcGkgaXMgcHJlZmVyYWJs
ZSwgYmVjYXVzZSB0aGUgbmVlZCB0byBkbyByZXNldAo+IGFzIHBhcnQgb2YgcmVzaXplIGlzIGFu
IGltcGxlbWVudGF0aW9uIGRldGFpbCwgSSBjYW4gZWFzaWx5Cj4gaW1hZ2luZSB2aXJ0aW8gc3Bl
YyBiZWluZyBleHRlbmRlZCB3aXRoIGEgcmVzaXplIGludGVyZmFjZQo+IHdoaWNoIGRvZXMgbm90
IHJlcXVpcmUgYSBxdWV1ZSByZXNldC4KPgo+IE1ha2VzIHNlbnNlIHRvIHlvdT8KClllcy4gSSdt
IGZpbmUgd2l0aCB0aGUgc2luZ2xlIEFQSSB0aGVuLgoKVGhhbmtzCgo+Cj4gPgo+ID4gPgo+ID4g
PiBUaGFua3MKPiA+ID4KPiA+ID4KPiA+ID4gPiArCj4gPiA+ID4gICAvKioKPiA+ID4gPiAgICAq
IHZpcnRpb19kZXZpY2UgLSByZXByZXNlbnRhdGlvbiBvZiBhIGRldmljZSB1c2luZyB2aXJ0aW8K
PiA+ID4gPiAgICAqIEBpbmRleDogdW5pcXVlIHBvc2l0aW9uIG9uIHRoZSB2aXJ0aW8gYnVzCj4g
PiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
