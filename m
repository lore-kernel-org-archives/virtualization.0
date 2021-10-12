Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D87C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 03:46:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E09E6101D
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 03:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E09E6101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 641F26070D;
	Tue, 12 Oct 2021 03:46:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rE69IYgp1UWm; Tue, 12 Oct 2021 03:46:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1B3BC60672;
	Tue, 12 Oct 2021 03:46:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8566C000F;
	Tue, 12 Oct 2021 03:46:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2753FC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 03:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08358401B2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 03:46:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U80X-gZrzW_0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 03:46:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1EEC8401AE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 03:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634010396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/aq/QD9ZXHUwVYlvJZeP6YP9G9ayvsCZ2eIQxsrG8wE=;
 b=IV/GBYLWZ0Ra6R9BvC5klAMtShdg+V2RGGVlUxnTsHyS8UXDlCwpVAXOHI8UfWL8A8AUVP
 6wYTMXcSYYnlshOeDsBUtJ+EgCKd3ikoz+aJx3yTAGn+msdWvmvPGC6DTCJGRPKgFXCe2v
 tW7a70QrZqfJQ5E0SaQWEbTZHdEp4G4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-XaQU4E9NPyi1mJutGabP0g-1; Mon, 11 Oct 2021 23:46:33 -0400
X-MC-Unique: XaQU4E9NPyi1mJutGabP0g-1
Received: by mail-lf1-f71.google.com with SMTP id
 k18-20020a05651210d200b003fd86616d39so4498426lfg.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 20:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/aq/QD9ZXHUwVYlvJZeP6YP9G9ayvsCZ2eIQxsrG8wE=;
 b=KcjwxX7Tf7PYQUutZC35TViFvFoQ4vwis8y6p9Kf2sRll764rIsRF4ZmWFrISifS2i
 qd3g0ywxz+Z1rZlAppN5WX58mUaI3hAe17B8a4gmOk0a3VYFOLb8S/wClZLId83dJPLK
 40BeXcIvtVdqmIsOGg18H2/0qE4jfiYajJ6shayGjLpSSeytd4F9WQHzQanh9dI82W2J
 +jwehP7QZPh3KzXWP412w97YwU2T9Pgz+ZbIc4qCLHk5qxkOMtxnlx3ITDdL2UMxagmG
 8JbzsyeLf7rWHZCR2WBL/SIfqK1yJhESmr2VPnWkpqREuk6VENeJ1x/5RYgg/ZJY4Py/
 1MWg==
X-Gm-Message-State: AOAM5334ryzQ5KtqO4ANcES06ncSWw81WnaYAhL7qJPzeaaT/oXuZN5d
 Wz/bEwpWnJZlLv0X+vh2KvfykSssXJ/2XYwtMTDxgLRje8hC2NGgnoAhXM7UWohMGmMOx3Gd0y6
 rO+JoM/eEmXvJK/4l6RXCvcNAXqUjiO7ebCOg82S+7v5Cpwb6xD9ecixCUw==
X-Received: by 2002:a05:6512:3d29:: with SMTP id
 d41mr19163383lfv.481.1634010392241; 
 Mon, 11 Oct 2021 20:46:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbV5HiKvmKHdL8CJgHGUCSc94w+OzRryKx7X5HJqvmo6pCfiReQzQYjZVPz+jhzHeSg3metnjgt5+Renvf6BY=
X-Received: by 2002:a05:6512:3d29:: with SMTP id
 d41mr19163375lfv.481.1634010392066; 
 Mon, 11 Oct 2021 20:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211005134843.439050-1-eperezma@redhat.com>
 <20211005134843.439050-3-eperezma@redhat.com>
In-Reply-To: <20211005134843.439050-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Oct 2021 11:46:21 +0800
Message-ID: <CACGkMEt3CtrOpbGMpoJ-OcgXM84UzwpugC3EAj_oGxukvNgk8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vdpa: Add vhost_vdpa_section_end
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>
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

T24gVHVlLCBPY3QgNSwgMjAyMSBhdCA5OjQ5IFBNIEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IEFic3RyYWN0IHRoaXMgb3BlcmF0aW9uLCB0aGF0IHdpbGwg
YmUgcmV1c2VkIHdoZW4gdmFsaWRhdGluZyB0aGUgcmVnaW9uCj4gYWdhaW5zdCB0aGUgaW92YSBy
YW5nZSB0aGF0IHRoZSBkZXZpY2Ugc3VwcG9ydHMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlv
IFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgoKPiAtLS0KPiAgaHcvdmlydGlvL3Zob3N0LXZkcGEuYyB8IDIyICsr
KysrKysrKysrKysrKy0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYyBi
L2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBpbmRleCBlYTFhYTcxYWQ4Li5iZTdjNjNiNGJhIDEw
MDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiArKysgYi9ody92aXJ0aW8vdmhv
c3QtdmRwYS5jCj4gQEAgLTI0LDYgKzI0LDE5IEBACj4gICNpbmNsdWRlICJ0cmFjZS5oIgo+ICAj
aW5jbHVkZSAicWVtdS1jb21tb24uaCIKPgo+ICsvKgo+ICsgKiBSZXR1cm4gb25lIHBhc3QgdGhl
IGVuZCBvZiB0aGUgZW5kIG9mIHNlY3Rpb24uIEJlIGNhcmVmdWwgd2l0aCB1aW50NjRfdAo+ICsg
KiBjb252ZXJzaW9ucyEKPiArICovCj4gK3N0YXRpYyBJbnQxMjggdmhvc3RfdmRwYV9zZWN0aW9u
X2VuZChjb25zdCBNZW1vcnlSZWdpb25TZWN0aW9uICpzZWN0aW9uKQo+ICt7Cj4gKyAgICBJbnQx
MjggbGxlbmQgPSBpbnQxMjhfbWFrZTY0KHNlY3Rpb24tPm9mZnNldF93aXRoaW5fYWRkcmVzc19z
cGFjZSk7Cj4gKyAgICBsbGVuZCA9IGludDEyOF9hZGQobGxlbmQsIHNlY3Rpb24tPnNpemUpOwo+
ICsgICAgbGxlbmQgPSBpbnQxMjhfYW5kKGxsZW5kLCBpbnQxMjhfZXh0czY0KFRBUkdFVF9QQUdF
X01BU0spKTsKPiArCj4gKyAgICByZXR1cm4gbGxlbmQ7Cj4gK30KPiArCj4gIHN0YXRpYyBib29s
IHZob3N0X3ZkcGFfbGlzdGVuZXJfc2tpcHBlZF9zZWN0aW9uKE1lbW9yeVJlZ2lvblNlY3Rpb24g
KnNlY3Rpb24pCj4gIHsKPiAgICAgIHJldHVybiAoIW1lbW9yeV9yZWdpb25faXNfcmFtKHNlY3Rp
b24tPm1yKSAmJgo+IEBAIC0xNjAsMTAgKzE3Myw3IEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFf
bGlzdGVuZXJfcmVnaW9uX2FkZChNZW1vcnlMaXN0ZW5lciAqbGlzdGVuZXIsCj4gICAgICB9Cj4K
PiAgICAgIGlvdmEgPSBUQVJHRVRfUEFHRV9BTElHTihzZWN0aW9uLT5vZmZzZXRfd2l0aGluX2Fk
ZHJlc3Nfc3BhY2UpOwo+IC0gICAgbGxlbmQgPSBpbnQxMjhfbWFrZTY0KHNlY3Rpb24tPm9mZnNl
dF93aXRoaW5fYWRkcmVzc19zcGFjZSk7Cj4gLSAgICBsbGVuZCA9IGludDEyOF9hZGQobGxlbmQs
IHNlY3Rpb24tPnNpemUpOwo+IC0gICAgbGxlbmQgPSBpbnQxMjhfYW5kKGxsZW5kLCBpbnQxMjhf
ZXh0czY0KFRBUkdFVF9QQUdFX01BU0spKTsKPiAtCj4gKyAgICBsbGVuZCA9IHZob3N0X3ZkcGFf
c2VjdGlvbl9lbmQoc2VjdGlvbik7Cj4gICAgICBpZiAoaW50MTI4X2dlKGludDEyOF9tYWtlNjQo
aW92YSksIGxsZW5kKSkgewo+ICAgICAgICAgIHJldHVybjsKPiAgICAgIH0KPiBAQCAtMjIxLDkg
KzIzMSw3IEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfbGlzdGVuZXJfcmVnaW9uX2RlbChNZW1v
cnlMaXN0ZW5lciAqbGlzdGVuZXIsCj4gICAgICB9Cj4KPiAgICAgIGlvdmEgPSBUQVJHRVRfUEFH
RV9BTElHTihzZWN0aW9uLT5vZmZzZXRfd2l0aGluX2FkZHJlc3Nfc3BhY2UpOwo+IC0gICAgbGxl
bmQgPSBpbnQxMjhfbWFrZTY0KHNlY3Rpb24tPm9mZnNldF93aXRoaW5fYWRkcmVzc19zcGFjZSk7
Cj4gLSAgICBsbGVuZCA9IGludDEyOF9hZGQobGxlbmQsIHNlY3Rpb24tPnNpemUpOwo+IC0gICAg
bGxlbmQgPSBpbnQxMjhfYW5kKGxsZW5kLCBpbnQxMjhfZXh0czY0KFRBUkdFVF9QQUdFX01BU0sp
KTsKPiArICAgIGxsZW5kID0gdmhvc3RfdmRwYV9zZWN0aW9uX2VuZChzZWN0aW9uKTsKPgo+ICAg
ICAgdHJhY2Vfdmhvc3RfdmRwYV9saXN0ZW5lcl9yZWdpb25fZGVsKHYsIGlvdmEsIGludDEyOF9n
ZXQ2NChsbGVuZCkpOwo+Cj4gLS0KPiAyLjI3LjAKPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
