Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4CDC7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 05:41:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD90860F4A;
	Tue, 11 Apr 2023 05:41:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD90860F4A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SjFh3DVI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gHVx-VJX0haf; Tue, 11 Apr 2023 05:41:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2DF8260F10;
	Tue, 11 Apr 2023 05:41:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2DF8260F10
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04AD6C0036;
	Tue, 11 Apr 2023 05:41:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E250C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DDE234175C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:41:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDE234175C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SjFh3DVI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AvavY5SD06Hm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:41:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05ECD4109F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 05ECD4109F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681191660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Lc8+CXiaC7kZLTFmLHcV9MWZzh4/VM+o+UitxvfuTg=;
 b=SjFh3DVIsfGolsunMW16IJX+beGCLzAiRxkQfncHhQyCo4hIEmx8bRnvp6ZtT/qGGPixDz
 DhuYNhtb362c0nbH7MBqZLV31QY7Pn9/Gd2+AEO53YJzo3X9B73OgPFMAUoEZbc5GV7qRo
 I+cnSUAKMNAf7BLS7bxPzTHpCkXJOBM=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-K4dKv10tOoeR6MX2XLKlug-1; Tue, 11 Apr 2023 01:40:54 -0400
X-MC-Unique: K4dKv10tOoeR6MX2XLKlug-1
Received: by mail-oo1-f72.google.com with SMTP id
 n2-20020a4ad622000000b0053e2e3db15dso1236349oon.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 22:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681191652; x=1683783652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Lc8+CXiaC7kZLTFmLHcV9MWZzh4/VM+o+UitxvfuTg=;
 b=5vRdSlhapV0DhWqUX/e2oSNBPvwIfMdapIJPaBpo+FDHqQUVOLZbKCIsZfy76g5+4k
 LmTUR+NJV38Je/dJrRleQVDUtJlFny3d6SSSO25VHdZR8YzYVOg+13tdKvGXvqEyvxci
 LbDoRT2KPf5Wp6RKGwtVvzaK6FF5DFojAs9QdOLyReuK6qLTHyAD3OajSGMQin6J2jCC
 ng8cTBkEylIX8DwCg7HcMW9bv7ryDH/2UPNUFNwSpjSBTnZuQjybB2LOTei2Agdb/Mpq
 DuQihwZvljxOJGEyKnqCqmJLo8Z17MG0NFm72o456IXQwt9ETVneemOYYs5vwZpMWL93
 R3xQ==
X-Gm-Message-State: AAQBX9drRlDUAM29rqAnZK4cj0CJxbtUQiRTFevnCQQJKaBTKJ6vhv9N
 eF5AfY2kdrC0GlAtrNhdhdbnCvpP14x668DFEdHU32pRbGmaLYEJ44XD5HcvwHQ6Xec1GctA1tk
 Bex/xFNUg1/R2z3pGBI3VlCQIPRKWiLGptarVaA+J3fsZulLaMSREQDM20rhrkljQFnJeqOY=
X-Received: by 2002:aca:2105:0:b0:37f:ab56:ff42 with SMTP id
 5-20020aca2105000000b0037fab56ff42mr382969oiz.9.1681191652464; 
 Mon, 10 Apr 2023 22:40:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZDv1ledLRdmNQyCWbksADq4zEavS68uqQs0Gsi3+bqVtEYCjFkNdzhA2mCtntAdKw7yIEaHAyObDume0j4N5E=
X-Received: by 2002:aca:2105:0:b0:37f:ab56:ff42 with SMTP id
 5-20020aca2105000000b0037fab56ff42mr382966oiz.9.1681191652266; Mon, 10 Apr
 2023 22:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230404131326.44403-1-sgarzare@redhat.com>
 <20230404131326.44403-5-sgarzare@redhat.com>
In-Reply-To: <20230404131326.44403-5-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Apr 2023 13:40:41 +0800
Message-ID: <CACGkMEvv0L7cFTHgi=4xwJ73ydhkp+Qd+tgPVcwC+b0V_U1ujQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] vringh: define the stride used for translation
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gVHVlLCBBcHIgNCwgMjAyMyBhdCA5OjE04oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2Fy
emFyZUByZWRoYXQuY29tPiB3cm90ZToKPgo+IERlZmluZSBhIG1hY3JvIHRvIGJlIHJldXNlZCBp
biB0aGUgZGlmZmVyZW50IHBhcnRzIG9mIHRoZSBjb2RlLgo+Cj4gVXNlZnVsIGZvciB0aGUgbmV4
dCBwYXRjaGVzIHdoZXJlIHdlIGFkZCBtb3JlIGFycmF5cyB0byBtYW5hZ2UgYWxzbwo+IHRyYW5z
bGF0aW9ucyB3aXRoIHVzZXIgVkEuCj4KPiBTdWdnZXN0ZWQtYnk6IEV1Z2VuaW8gUGVyZXogTWFy
dGluIDxlcGVyZXptYUByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFy
ZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0tLQo+Cj4gTm90ZXM6Cj4gICAgIHY0Ogo+ICAgICAt
IGFkZGVkIHRoaXMgcGF0Y2ggd2l0aCB0aGUgY2hhbmdlcyBleHRyYWN0ZWQgZnJvbSB0aGUgbmV4
dCBwYXRjaCBbRXVnZW5pb10KPiAgICAgLSB1c2VkIF9TVFJJREUgaW5zdGVhZCBvZiBfU0laRSBb
RXVnZW5pb10KPgo+ICBkcml2ZXJzL3Zob3N0L3ZyaW5naC5jIHwgNiArKysrLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jIGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+IGluZGV4
IDBiYTNlZjgwOWU0OC4uNGFlZTIzMGY3NjIyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qv
dnJpbmdoLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gQEAgLTExNDEsMTMgKzEx
NDEsMTUgQEAgc3RhdGljIGludCBpb3RsYl90cmFuc2xhdGUoY29uc3Qgc3RydWN0IHZyaW5naCAq
dnJoLAo+ICAgICAgICAgcmV0dXJuIHJldDsKPiAgfQo+Cj4gKyNkZWZpbmUgSU9UTEJfSU9WX1NU
UklERSAxNgo+ICsKPiAgc3RhdGljIGlubGluZSBpbnQgY29weV9mcm9tX2lvdGxiKGNvbnN0IHN0
cnVjdCB2cmluZ2ggKnZyaCwgdm9pZCAqZHN0LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2b2lkICpzcmMsIHNpemVfdCBsZW4pCj4gIHsKPiAgICAgICAgIHU2NCB0b3RhbF90
cmFuc2xhdGVkID0gMDsKPgo+ICAgICAgICAgd2hpbGUgKHRvdGFsX3RyYW5zbGF0ZWQgPCBsZW4p
IHsKPiAtICAgICAgICAgICAgICAgc3RydWN0IGJpb192ZWMgaW92WzE2XTsKPiArICAgICAgICAg
ICAgICAgc3RydWN0IGJpb192ZWMgaW92W0lPVExCX0lPVl9TVFJJREVdOwo+ICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgaW92X2l0ZXIgaXRlcjsKPiAgICAgICAgICAgICAgICAgdTY0IHRyYW5zbGF0
ZWQ7Cj4gICAgICAgICAgICAgICAgIGludCByZXQ7Cj4gQEAgLTExODAsNyArMTE4Miw3IEBAIHN0
YXRpYyBpbmxpbmUgaW50IGNvcHlfdG9faW90bGIoY29uc3Qgc3RydWN0IHZyaW5naCAqdnJoLCB2
b2lkICpkc3QsCj4gICAgICAgICB1NjQgdG90YWxfdHJhbnNsYXRlZCA9IDA7Cj4KPiAgICAgICAg
IHdoaWxlICh0b3RhbF90cmFuc2xhdGVkIDwgbGVuKSB7Cj4gLSAgICAgICAgICAgICAgIHN0cnVj
dCBiaW9fdmVjIGlvdlsxNl07Cj4gKyAgICAgICAgICAgICAgIHN0cnVjdCBiaW9fdmVjIGlvdltJ
T1RMQl9JT1ZfU1RSSURFXTsKPiAgICAgICAgICAgICAgICAgc3RydWN0IGlvdl9pdGVyIGl0ZXI7
Cj4gICAgICAgICAgICAgICAgIHU2NCB0cmFuc2xhdGVkOwo+ICAgICAgICAgICAgICAgICBpbnQg
cmV0Owo+IC0tCj4gMi4zOS4yCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
