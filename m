Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EEFC76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 05:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6AED04029F;
	Tue, 11 Apr 2023 05:40:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6AED04029F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rj4wmIBp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9_occ_3SFo9d; Tue, 11 Apr 2023 05:40:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D5499403B7;
	Tue, 11 Apr 2023 05:40:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5499403B7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD236C0036;
	Tue, 11 Apr 2023 05:40:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18003C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF66781FB6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:40:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF66781FB6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rj4wmIBp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id df03BTxTqnD8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:40:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 203CA81F8F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 203CA81F8F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681191620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2MfVoDEeLgaeGehPapEDG88NMDEyPAiMkTlV+QvLe4=;
 b=Rj4wmIBp2ynEB14vwZguO1ZN4v34B3PVPYjIwp2xxe8zhBrhpfwu3la888ijJoN9Jd71Cz
 1+sYCRNQ+DUa3VZ2AfsQ3yjzHuOA18J9wEcSX8/Twn87zrIX+zX/iD3RHiKbTNMc8r9wt2
 qMHgdGm6Dq4NNbBupf99lb7EM1aFL1g=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-Cw1X_DKvN8iMByQIXHNUFw-1; Tue, 11 Apr 2023 01:40:18 -0400
X-MC-Unique: Cw1X_DKvN8iMByQIXHNUFw-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-180baff12ccso11501397fac.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 22:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681191618; x=1683783618;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2MfVoDEeLgaeGehPapEDG88NMDEyPAiMkTlV+QvLe4=;
 b=tAiHXYMr/FXpJ8WugMRW9FRL4C3Mn49OIvfGpPR/7R/RzgF03R9UqKvgrUYKVqa7XN
 wfboLaClVbzAcQlf2pbJ8K1xMAGglnvqstSbwxeMQnNh/SOw9uLME/DUCHAvofu+JnRL
 xnIi9gdW5IXthFBXfRUogZCgMg8yuqp/5yGAGjWJDnKWe5+gJJcnTrRyioIGwtLSHSHZ
 bD2L9fa5tkkNOLBoDGnNT8JHVUTc+HEWnzdUWJWoY7Q+qnlBKMZKAIL5LuXSOwtbcwlW
 Y32+omyoXJbUqoOHLqpVLLPLnPCKMYZkIvKK4vekDi6jJdCP8ndCCI9hxjfOPuR8JeKe
 2Pnw==
X-Gm-Message-State: AAQBX9eBqOvp+lujl5iL1dkOpwGUBoKhhUtdAuhJBAjRp5cYZtzR+oEQ
 QoVR2CJg2miVMF9Dwigu2SvDFIBJaxolNBZ3yfU/4E4/blkqGS5KFPynXwOlkEj5PRIGuMzcOrs
 s5iQS7g1P1m5NkGJTJYSWXkwQ0WgLLZziUnwOs17N7fkOGSeATXSTVY5jIQ==
X-Received: by 2002:aca:2105:0:b0:37f:ab56:ff42 with SMTP id
 5-20020aca2105000000b0037fab56ff42mr382707oiz.9.1681191617958; 
 Mon, 10 Apr 2023 22:40:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350b86Y/QCGjnR1TfO/EgY70echaGQeoEIsSV/BF854H5Sew6uskMivEF98OtO13bWZNWxpr8cuxN3sYgnFz5lyY=
X-Received: by 2002:aca:2105:0:b0:37f:ab56:ff42 with SMTP id
 5-20020aca2105000000b0037fab56ff42mr382703oiz.9.1681191617729; Mon, 10 Apr
 2023 22:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230404131326.44403-1-sgarzare@redhat.com>
 <20230404131326.44403-3-sgarzare@redhat.com>
In-Reply-To: <20230404131326.44403-3-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Apr 2023 13:40:06 +0800
Message-ID: <CACGkMEsuoZMW==JKd_VeW5TUh=KTZC+vDJWLHQ5hbfncAf387Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] vhost-vdpa: use bind_mm/unbind_mm device callbacks
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
emFyZUByZWRoYXQuY29tPiB3cm90ZToKPgo+IFdoZW4gdGhlIHVzZXIgY2FsbCBWSE9TVF9TRVRf
T1dORVIgaW9jdGwgYW5kIHRoZSB2RFBBIGRldmljZQo+IGhhcyBgdXNlX3ZhYCBzZXQgdG8gdHJ1
ZSwgbGV0J3MgY2FsbCB0aGUgYmluZF9tbSBjYWxsYmFjay4KPiBJbiB0aGlzIHdheSB3ZSBjYW4g
YmluZCB0aGUgZGV2aWNlIHRvIHRoZSB1c2VyIGFkZHJlc3Mgc3BhY2UKPiBhbmQgZGlyZWN0bHkg
dXNlIHRoZSB1c2VyIFZBLgo+Cj4gVGhlIHVuYmluZF9tbSBjYWxsYmFjayBpcyBjYWxsZWQgZHVy
aW5nIHRoZSByZWxlYXNlIGFmdGVyCj4gc3RvcHBpbmcgdGhlIGRldmljZS4KPgo+IFNpZ25lZC1v
ZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KCkFja2VkLWJ5
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0tLQo+Cj4gTm90
ZXM6Cj4gICAgIHY0Ogo+ICAgICAtIGFkZGVkIG5ldyBzd2l0Y2ggYWZ0ZXIgdmhvc3RfZGV2X2lv
Y3RsKCkgW0phc29uXQo+ICAgICB2MzoKPiAgICAgLSBhZGRlZCBgY2FzZSBWSE9TVF9TRVRfT1dO
RVJgIGluIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoKSBbSmFzb25dCj4gICAgIHYyOgo+ICAg
ICAtIGNhbGwgdGhlIG5ldyB1bmJpbmRfbW0gY2FsbGJhY2sgZHVyaW5nIHRoZSByZWxlYXNlIFtK
YXNvbl0KPiAgICAgLSBhdm9pZCB0byBjYWxsIGJpbmRfbW0gY2FsbGJhY2sgYWZ0ZXIgdGhlIHJl
c2V0LCBzaW5jZSB0aGUgZGV2aWNlCj4gICAgICAgaXMgbm90IGRldGFjaGluZyBpdCBub3cgZHVy
aW5nIHRoZSByZXNldAo+Cj4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMzQgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygr
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92
ZHBhLmMKPiBpbmRleCA3YmU5ZDlkOGYwMWMuLjM4MjRjMjQ5NjEyZiAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gQEAgLTIx
OSw2ICsyMTksMjggQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Jlc2V0KHN0cnVjdCB2aG9zdF92
ZHBhICp2KQo+ICAgICAgICAgcmV0dXJuIHZkcGFfcmVzZXQodmRwYSk7Cj4gIH0KPgo+ICtzdGF0
aWMgbG9uZyB2aG9zdF92ZHBhX2JpbmRfbW0oc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4gK3sKPiAr
ICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gKyAgICAgICBjb25z
dCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7Cj4gKwo+ICsgICAg
ICAgaWYgKCF2ZHBhLT51c2VfdmEgfHwgIW9wcy0+YmluZF9tbSkKPiArICAgICAgICAgICAgICAg
cmV0dXJuIDA7Cj4gKwo+ICsgICAgICAgcmV0dXJuIG9wcy0+YmluZF9tbSh2ZHBhLCB2LT52ZGV2
Lm1tKTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQgdmhvc3RfdmRwYV91bmJpbmRfbW0oc3RydWN0
IHZob3N0X3ZkcGEgKnYpCj4gK3sKPiArICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9
IHYtPnZkcGE7Cj4gKyAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2
ZHBhLT5jb25maWc7Cj4gKwo+ICsgICAgICAgaWYgKCF2ZHBhLT51c2VfdmEgfHwgIW9wcy0+dW5i
aW5kX21tKQo+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4gKwo+ICsgICAgICAgb3BzLT51bmJp
bmRfbW0odmRwYSk7Cj4gK30KPiArCj4gIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2Rldmlj
ZV9pZChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICphcmdwKQo+ICB7Cj4gICAgICAg
ICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+IEBAIC03MTYsNiArNzM4LDE3
IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZp
bGVwLAo+ICAgICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAgIH0KPgo+ICsgICAgICAgaWYg
KHIpCj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+ICsKPiArICAgICAgIHN3aXRjaCAoY21k
KSB7Cj4gKyAgICAgICBjYXNlIFZIT1NUX1NFVF9PV05FUjoKPiArICAgICAgICAgICAgICAgciA9
IHZob3N0X3ZkcGFfYmluZF9tbSh2KTsKPiArICAgICAgICAgICAgICAgaWYgKHIpCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgdmhvc3RfZGV2X3Jlc2V0X293bmVyKGQsIE5VTEwpOwo+ICsgICAg
ICAgICAgICAgICBicmVhazsKPiArICAgICAgIH0KPiArb3V0Ogo+ICAgICAgICAgbXV0ZXhfdW5s
b2NrKCZkLT5tdXRleCk7Cj4gICAgICAgICByZXR1cm4gcjsKPiAgfQo+IEBAIC0xMjg3LDYgKzEz
MjAsNyBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVsZWFzZShzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCBzdHJ1Y3QgZmlsZSAqZmlsZXApCj4gICAgICAgICB2aG9zdF92ZHBhX2NsZWFuX2lycSh2KTsK
PiAgICAgICAgIHZob3N0X3ZkcGFfcmVzZXQodik7Cj4gICAgICAgICB2aG9zdF9kZXZfc3RvcCgm
di0+dmRldik7Cj4gKyAgICAgICB2aG9zdF92ZHBhX3VuYmluZF9tbSh2KTsKPiAgICAgICAgIHZo
b3N0X3ZkcGFfY29uZmlnX3B1dCh2KTsKPiAgICAgICAgIHZob3N0X3ZkcGFfY2xlYW51cCh2KTsK
PiAgICAgICAgIG11dGV4X3VubG9jaygmZC0+bXV0ZXgpOwo+IC0tCj4gMi4zOS4yCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
