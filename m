Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF566CDB474
	for <virtualization@archiver.kernel.org>; Fri, 13 Oct 2023 03:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45643821A6;
	Fri, 13 Oct 2023 03:02:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 45643821A6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LBqxKe3k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hQv_u4Hcl0fA; Fri, 13 Oct 2023 03:02:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DA39381EDD;
	Fri, 13 Oct 2023 03:02:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA39381EDD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD3B1C0039;
	Fri, 13 Oct 2023 03:02:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85A4AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 03:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B06141F13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 03:02:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B06141F13
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LBqxKe3k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AzCH3Vx_OPhy
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 03:02:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76BF041F06
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 03:02:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 76BF041F06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697166135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fh5pL38+B6R3gU+K0Col33PyIlfMXMZvWZg4AIIPXj0=;
 b=LBqxKe3kCBpbNfoOwRRzfiCaVok2CQm7zxGx2J4+Y7jlQHRWmOMkLa5Nij7ANtjLMiDscF
 o2DxeynM7W4kHgK7EUGwM08oHnj18+bdZuqbVjDQayy14zO9J3KYO02RRYOo+6Ci4MdFZ/
 A+DAJVSXjPSeHp/oGFB21kmzQ4RKwMo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-js_4_gZ3PByQFDuBvitqJw-1; Thu, 12 Oct 2023 23:02:13 -0400
X-MC-Unique: js_4_gZ3PByQFDuBvitqJw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5042d5a3f13so1589767e87.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 20:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697166132; x=1697770932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fh5pL38+B6R3gU+K0Col33PyIlfMXMZvWZg4AIIPXj0=;
 b=lMPf9uuTfckkIXFtwvlPzvbCqLMAvS8mmsqgp5tIIKsyADHNdjM9hPp2ff15/Ei1HU
 6CkHDmcl4ctqF3SyGhHglr7ttPunpiwU2nhyosiLubIu/vGG0NDnK6UeDQ/tkX3m1mFy
 0V1TakIKlr/aMgqyCrPibLMvT/mkBJqhIrqRQzJxoKo0+QCus1QS2ZqksvIbOQ4bJxk4
 MTeI0DqDJpuvNHQzhxoTud14Qyysr4JkXOpQ2Qak32qihtBtQg8CVSkX5L0YedmC2yZk
 IUpL4ioKFlaNNwAY6EQYnVpR0P0+1wE+vmurPkrtRdEhSAkNlyp3tvZ0wvEsPEQOXRsN
 d7ow==
X-Gm-Message-State: AOJu0YwCQ/gLGlusLlpPgv06QDFc5A5IF9FPS7X10L5WWNtPsr8/Ta9p
 W0Dj9Rl347IHUjeWKi+e/P4hWjNodcXY1N5tsM3nLsY6NBz0E5JCFe1VEeKbsBPaKfuuQ9fRwTW
 jDKR2clilbyCZLbhxh1QTC0y4hwLWJaEEWYCuLy/ZAq2lF0FkBiSBeMgfMg==
X-Received: by 2002:a05:6512:695:b0:503:28cb:c087 with SMTP id
 t21-20020a056512069500b0050328cbc087mr32985468lfe.29.1697166132485; 
 Thu, 12 Oct 2023 20:02:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHuVr/OjVrU/12Uzu6MgIHAsEMtvjUL8K454unWWAu/RqnNAL4TKk85GMF0sHqXNsyIBYN789XrHxITvoGNqw=
X-Received: by 2002:a05:6512:695:b0:503:28cb:c087 with SMTP id
 t21-20020a056512069500b0050328cbc087mr32985456lfe.29.1697166132169; Thu, 12
 Oct 2023 20:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Oct 2023 11:01:59 +0800
Message-ID: <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgNTowNeKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBEZXZpY2VzIHdpdGggb24tY2hpcCBJT01NVSBvciB2ZW5k
b3Igc3BlY2lmaWMgSU9UTEIgaW1wbGVtZW50YXRpb24KPiBtYXkgbmVlZCB0byByZXN0b3JlIGlv
dGxiIG1hcHBpbmcgdG8gdGhlIGluaXRpYWwgb3IgZGVmYXVsdCBzdGF0ZQo+IHVzaW5nIHRoZSAu
cmVzZXRfbWFwIG9wLCBhcyBpdCdzIGRlc2lyYWJsZSBmb3Igc29tZSBwYXJlbnQgZGV2aWNlcwo+
IHRvIHNvbGVseSBtYW5pcHVsYXRlIG1hcHBpbmdzIGJ5IGl0cyBvd24sIGluZGVwZW5kZW50IG9m
IHZpcnRpbyBkZXZpY2UKPiBzdGF0ZS4gRm9yIGluc3RhbmNlLCBkZXZpY2UgcmVzZXQgZG9lcyBu
b3QgY2F1c2UgbWFwcGluZyBnbyBhd2F5IG9uCj4gc3VjaCBJT1RMQiBtb2RlbCBpbiBuZWVkIG9m
IHBlcnNpc3RlbnQgbWFwcGluZy4gQmVmb3JlIHZob3N0LXZkcGEKPiBpcyBnb2luZyBhd2F5LCBn
aXZlIHRoZW0gYSBjaGFuY2UgdG8gcmVzZXQgaW90bGIgYmFjayB0byB0aGUgaW5pdGlhbAo+IHN0
YXRlIGluIHZob3N0X3ZkcGFfY2xlYW51cCgpLgo+Cj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExp
dSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8
IDE2ICsrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRw
YS5jCj4gaW5kZXggODUxNTM1Zi4uYTNmODE2MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0
L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gQEAgLTEzMSw2ICsxMzEsMTUg
QEAgc3RhdGljIHN0cnVjdCB2aG9zdF92ZHBhX2FzICp2aG9zdF92ZHBhX2ZpbmRfYWxsb2NfYXMo
c3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gICAgICAgICByZXR1cm4gdmhvc3RfdmRwYV9hbGxvY19h
cyh2LCBhc2lkKTsKPiAgfQo+Cj4gK3N0YXRpYyB2b2lkIHZob3N0X3ZkcGFfcmVzZXRfbWFwKHN0
cnVjdCB2aG9zdF92ZHBhICp2LCB1MzIgYXNpZCkKPiArewo+ICsgICAgICAgc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKPiArICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZp
Z19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPiArCj4gKyAgICAgICBpZiAob3BzLT5yZXNldF9t
YXApCj4gKyAgICAgICAgICAgICAgIG9wcy0+cmVzZXRfbWFwKHZkcGEsIGFzaWQpOwo+ICt9Cj4g
Kwo+ICBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVtb3ZlX2FzKHN0cnVjdCB2aG9zdF92ZHBhICp2
LCB1MzIgYXNpZCkKPiAgewo+ICAgICAgICAgc3RydWN0IHZob3N0X3ZkcGFfYXMgKmFzID0gYXNp
ZF90b19hcyh2LCBhc2lkKTsKPiBAQCAtMTQwLDYgKzE0OSwxMyBAQCBzdGF0aWMgaW50IHZob3N0
X3ZkcGFfcmVtb3ZlX2FzKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MzIgYXNpZCkKPgo+ICAgICAg
ICAgaGxpc3RfZGVsKCZhcy0+aGFzaF9saW5rKTsKPiAgICAgICAgIHZob3N0X3ZkcGFfaW90bGJf
dW5tYXAodiwgJmFzLT5pb3RsYiwgMFVMTCwgMFVMTCAtIDEsIGFzaWQpOwo+ICsgICAgICAgLyoK
PiArICAgICAgICAqIERldmljZXMgd2l0aCB2ZW5kb3Igc3BlY2lmaWMgSU9NTVUgbWF5IG5lZWQg
dG8gcmVzdG9yZQo+ICsgICAgICAgICogaW90bGIgdG8gdGhlIGluaXRpYWwgb3IgZGVmYXVsdCBz
dGF0ZSB3aGljaCBpcyBub3QgZG9uZQo+ICsgICAgICAgICogdGhyb3VnaCBkZXZpY2UgcmVzZXQs
IGFzIHRoZSBJT1RMQiBtYXBwaW5nIG1hbmlwdWxhdGlvbgo+ICsgICAgICAgICogY291bGQgYmUg
ZGVjb3VwbGVkIGZyb20gdGhlIHZpcnRpbyBkZXZpY2UgbGlmZSBjeWNsZS4KPiArICAgICAgICAq
LwoKU2hvdWxkIHdlIGRvIHRoaXMgYWNjb3JkaW5nIHRvIHdoZXRoZXIgSU9UTEJfUFJFU0lTVCBp
cyBzZXQ/IE90aGVyd2lzZQp3ZSBtYXkgYnJlYWsgb2xkIHVzZXJzcGFjZS4KClRoYW5rcwoKPiAr
ICAgICAgIHZob3N0X3ZkcGFfcmVzZXRfbWFwKHYsIGFzaWQpOwo+ICAgICAgICAga2ZyZWUoYXMp
Owo+Cj4gICAgICAgICByZXR1cm4gMDsKPiAtLQo+IDEuOC4zLjEKPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
