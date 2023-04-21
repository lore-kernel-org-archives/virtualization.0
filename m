Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F087C7618E
	for <virtualization@archiver.kernel.org>; Fri, 21 Apr 2023 07:11:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 415DD40526;
	Fri, 21 Apr 2023 07:11:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 415DD40526
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=En6//Mch
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LzzX-RzX288a; Fri, 21 Apr 2023 07:11:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CA9A040148;
	Fri, 21 Apr 2023 07:11:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA9A040148
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DF03C0036;
	Fri, 21 Apr 2023 07:11:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF801C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8D8360F3A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:11:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8D8360F3A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=En6//Mch
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dI2rKZzSG953
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:11:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E420B60B06
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E420B60B06
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682061084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Hel2lvkUNp3cy9BYWMzYJ5GhkmTlSKb52dwGchz6iE=;
 b=En6//Mchm9zTH6aKISuTX39YqffQf/znUChZMW7LbgC3zQ4yBAHHfUo3yKR1K4sVKOVTIK
 yaEvqA5IJCegGbwVAvdJaYrCfk0wbCDgAVAuYVSuQjgE53fWiuAnkdHhDJfGNz/Q+ivCxZ
 KST7yLyigetjhWVjSP05pTSQ0VNk7jo=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-C40FXdHNN52mAJgfV5HVog-1; Fri, 21 Apr 2023 03:11:23 -0400
X-MC-Unique: C40FXdHNN52mAJgfV5HVog-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6a5e616d5d3so1586554a34.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 00:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682061083; x=1684653083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Hel2lvkUNp3cy9BYWMzYJ5GhkmTlSKb52dwGchz6iE=;
 b=R8Hf7nhb1IIAU6WlwqEBH+ugINL6oDjRodKn26xvCxN3WWxLvxswFVb6W5g80N0xMM
 UZyrEU5o4nXmYbTn1ksZ2n5QUpBTOrt2yxsm7RnY0Bx6rL7Qbtob9GoV3c/TzacXjQsO
 bruqYfZhQJcgdwTko0Vn+ux10QzhDOF471ja0RkAX4SqsKVK70P+L75TPg6bqajToOa4
 piQ8Tqg0ZnRLPRFGG81tQ31uqrES+MQygmuy/YiPhPk5BmN0ys12DdosH27mr0o8Vzd0
 OfA8pVPtKEPxhriNb1ubUJUl09AhHuzzvyWjLwhh8udVnDG1JYlwLarWM1aOTCeip+/I
 xeaQ==
X-Gm-Message-State: AAQBX9d4QNtvpELQs3nMGyMpDsn6J5jtnsGnF56ASjOG0SGn/c7xYpXJ
 4QZeimwx7citzNDZmb4xwlJ/5nLk4ELQw4es/gJ/t4ccfUI2iT09Ff8jw+QVdnTV9Z7FtOCcA3G
 B3Gg2dGY6aW44IwxkqZ8Y/EE6Ty3JRU1tcPgpPHhAyOSqgt+yOCzHBKUt5A==
X-Received: by 2002:aca:100d:0:b0:38e:1ee1:982 with SMTP id
 13-20020aca100d000000b0038e1ee10982mr2391090oiq.7.1682061082565; 
 Fri, 21 Apr 2023 00:11:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZdspLDBkX4UR5Dt85qLMuFsxfyjUCXK87ZmqnGFhfDDXACeESMDThi+Q9XtnTMnXrA9rajHiS8urkCLXJBtO0=
X-Received: by 2002:aca:100d:0:b0:38e:1ee1:982 with SMTP id
 13-20020aca100d000000b0038e1ee10982mr2391079oiq.7.1682061082091; Fri, 21 Apr
 2023 00:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221123102207.451527-1-asmetanin@yandex-team.ru>
 <CACGkMEs3gdcQ5_PkYmz2eV-kFodZnnPPhvyRCyLXBYYdfHtNjw@mail.gmail.com>
 <20230421030345-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230421030345-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Apr 2023 15:11:11 +0800
Message-ID: <CACGkMEujFHDR4NCxtBm5DyE_H=xkZA_YnH-p0SNiwbWQFPa_bg@mail.gmail.com>
Subject: Re: [PATCH] vhost_net: revert upend_idx only on retriable error
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Andrey Smetanin <asmetanin@yandex-team.ru>, yc-core@yandex-team.ru
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

T24gRnJpLCBBcHIgMjEsIDIwMjMgYXQgMzowNOKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBEZWMgMDEsIDIwMjIgYXQgMDU6MDE6NThQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIFdlZCwgTm92IDIzLCAyMDIyIGF0IDY6
MjQgUE0gQW5kcmV5IFNtZXRhbmluCj4gPiA8YXNtZXRhbmluQHlhbmRleC10ZWFtLnJ1PiB3cm90
ZToKPiA+ID4KPiA+ID4gRml4IHBvc3NpYmxlIHZpcnRxdWV1ZSB1c2VkIGJ1ZmZlcnMgbGVhayBh
bmQgY29ycmVzcG9uZGluZyBzdHVjawo+ID4gPiBpbiBjYXNlIG9mIHRlbXBvcmFyeSAtRUlPIGZy
b20gc2VuZG1zZygpIHdoaWNoIGlzIHByb2R1Y2VkIGJ5Cj4gPiA+IHR1biBkcml2ZXIgd2hpbGUg
YmFja2VuZCBkZXZpY2UgaXMgbm90IHVwLgo+ID4gPgo+ID4gPiBJbiBjYXNlIG9mIG5vLXJldHJp
YWJsZSBlcnJvciBhbmQgemNvcHkgZG8gbm90IHJldmVydCB1cGVuZF9pZHgKPiA+ID4gdG8gcGFz
cyBwYWNrZXQgZGF0YSAodGhhdCBpcyB1cGRhdGUgdXNlZF9pZHggaW4gY29ycmVzcG9uZGluZwo+
ID4gPiB2aG9zdF96ZXJvY29weV9zaWduYWxfdXNlZCgpKSBhcyBpZiBwYWNrZXQgZGF0YSBoYXMg
YmVlbgo+ID4gPiB0cmFuc2ZlcnJlZCBzdWNjZXNzZnVsbHkuCj4gPgo+ID4gU2hvdWxkIHdlIG1h
cmsgaGVhZC5sZW4gYXMgVkhPU1RfRE1BX0RPTkVfTEVOIGluIHRoaXMgY2FzZT8KPiA+Cj4gPiBU
aGFua3MKPgo+IEphc29uIGRvIHlvdSB3YW50IHRvIHRha2Ugb3ZlciB0aGlzIHdvcms/IEl0J3Mg
YmVlbiBzdHVjawo+IGluIG15IGluYm94IGZvciBhIHdoaWxlLgoKQW5kcmV5LAoKQW55IHVwZGF0
ZSBvbiB0aGlzIHBhdGNoPwoKQnR3LCBpZiB3ZSBoYXZlbid0IGhlYXJkIGZyb20gQW5kcmV5IGZv
ciBhIHdlZWssIEkgY2FuIGRvIHRoYXQuCgpUaGFua3MKCj4KPiA+ID4KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogQW5kcmV5IFNtZXRhbmluIDxhc21ldGFuaW5AeWFuZGV4LXRlYW0ucnU+Cj4gPiA+IC0t
LQo+ID4gPiAgZHJpdmVycy92aG9zdC9uZXQuYyB8IDkgKysrKysrLS0tCj4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+ID4gPgo+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92aG9zdC9uZXQuYyBiL2RyaXZlcnMvdmhvc3QvbmV0LmMKPiA+ID4g
aW5kZXggMjAyNjUzOTNhZWU3Li45M2U5MTY2MDM5YjkgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZl
cnMvdmhvc3QvbmV0LmMKPiA+ID4gKysrIGIvZHJpdmVycy92aG9zdC9uZXQuYwo+ID4gPiBAQCAt
OTM0LDEzICs5MzQsMTYgQEAgc3RhdGljIHZvaWQgaGFuZGxlX3R4X3plcm9jb3B5KHN0cnVjdCB2
aG9zdF9uZXQgKm5ldCwgc3RydWN0IHNvY2tldCAqc29jaykKPiA+ID4KPiA+ID4gICAgICAgICAg
ICAgICAgIGVyciA9IHNvY2stPm9wcy0+c2VuZG1zZyhzb2NrLCAmbXNnLCBsZW4pOwo+ID4gPiAg
ICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KGVyciA8IDApKSB7Cj4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGJvb2wgcmV0cnkgPSBlcnIgPT0gLUVBR0FJTiB8fCBlcnIgPT0gLUVOT01F
TSB8fCBlcnIgPT0gLUVOT0JVRlM7Cj4gPiA+ICsKPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKHpjb3B5X3VzZWQpIHsKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpZiAodnEtPmhlYWRzW3VidWYtPmRlc2NdLmxlbiA9PSBWSE9TVF9ETUFfSU5fUFJPR1JFU1Mp
Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aG9zdF9uZXRf
dWJ1Zl9wdXQodWJ1ZnMpOwo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG52
cS0+dXBlbmRfaWR4ID0gKCh1bnNpZ25lZCludnEtPnVwZW5kX2lkeCAtIDEpCj4gPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAlIFVJT19NQVhJT1Y7Cj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldHJ5KQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbnZxLT51cGVuZF9pZHggPSAoKHVuc2lnbmVk
KW52cS0+dXBlbmRfaWR4IC0gMSkKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJSBVSU9fTUFYSU9WOwo+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICB9Cj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmIChlcnIgPT0gLUVBR0FJTiB8
fCBlcnIgPT0gLUVOT01FTSB8fCBlcnIgPT0gLUVOT0JVRlMpIHsKPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKHJldHJ5KSB7Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdmhvc3RfZGlzY2FyZF92cV9kZXNjKHZxLCAxKTsKPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB2aG9zdF9uZXRfZW5hYmxlX3ZxKG5ldCwgdnEpOwo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gPiAtLQo+ID4gPiAyLjI1LjEK
PiA+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
