Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E134C6FD1D
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 04:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7472560FA1;
	Tue,  4 Apr 2023 04:55:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7472560FA1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TcG0uYpD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0mwffkYE1Bca; Tue,  4 Apr 2023 04:55:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 52E4D60737;
	Tue,  4 Apr 2023 04:55:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 52E4D60737
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F0B5C0036;
	Tue,  4 Apr 2023 04:55:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 267C6C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 04:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE655402A7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 04:55:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EE655402A7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TcG0uYpD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XkUxn4xmsS3F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 04:55:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 09AE040297
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 09AE040297
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 04:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680584119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=huRkk8+ODNCo/GWbnpEFLOz2kC18bjGiJYM+FQxuVbw=;
 b=TcG0uYpDldwmtX/rWkNXk10zZB9PG7nwRIKIbmpQP2fnLffQsRz7vPL9VT6254j4aHgDA6
 hNFIOUZMEtWktVirH3rny+kZ9P1nYPGRnAPLxrHkHXB2M6js6GPRqb7HOrjgq8l2x6O2Tf
 ems5v7m2gyhFmOFut7PZdgXMz21IJYg=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-yJHcROZgP7GSHoL4BJCZew-1; Tue, 04 Apr 2023 00:55:18 -0400
X-MC-Unique: yJHcROZgP7GSHoL4BJCZew-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-17fd0d597dcso9251686fac.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Apr 2023 21:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680584118; x=1683176118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=huRkk8+ODNCo/GWbnpEFLOz2kC18bjGiJYM+FQxuVbw=;
 b=gNC/b1Ro8yoA8kcDfCEVtSlaNQkI5rbeAyhtWTWYsIioUjdNQDdv+wp000FFC4D99C
 iQXjf0dWjqWjXVQsz58CxHPa78sgDi87hiII7LjxWUKlrNJiokGooTWm7uo0LUjuSDJH
 A/qQC6xKu3YipOGEBj3ndXtNfDpr8C8STWeRQ1DMYNIKeIKbinQKXCAGSZS/zRVAufgX
 UpD+LTukoLkTPJeDH2zvk0aVA54Z5auV5bazRABvbY4M/O9ggPrT8gy01SzrX5E5fKAm
 VCK5wp6KnX616EONL7NIZYBArIh5xAM7VMJHMyTFAZ88fzWCY8W3W+bc56P6kaEQnf+Y
 4Vqw==
X-Gm-Message-State: AAQBX9ea7ZHcgOQdk4jb3mifPTfaTNKEM2nEIpk3bH3s/IXaLcQB8UlA
 nWkK+h5qzenJ0m+T4R/T5YOryAlzaWJ7FVByW84uLmvBjEN4QdnxJcvfQHZuc33JKRD1W2UpwBr
 LAn2cbMHx+vnHinHyC+vo1TdI1W3PvKyfcl82/whBG4ijFpHHZjafefrEyw==
X-Received: by 2002:a9d:6a5a:0:b0:69f:573:6113 with SMTP id
 h26-20020a9d6a5a000000b0069f05736113mr474491otn.2.1680584117850; 
 Mon, 03 Apr 2023 21:55:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350Ya4cUYX9chwcDhq6bvC1K8BCYajiAZYSkHzh4LgLcwjwFt4W/YMnQaR661zJIb06phBXlW2qy57R7wOsRx3s8=
X-Received: by 2002:a9d:6a5a:0:b0:69f:573:6113 with SMTP id
 h26-20020a9d6a5a000000b0069f05736113mr474486otn.2.1680584117593; Mon, 03 Apr
 2023 21:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230402125219.1084754-1-alvaro.karsz@solid-run.com>
 <20230402125219.1084754-2-alvaro.karsz@solid-run.com>
 <CACGkMEuQpJyQNuYTs2TwCc8SmvynbVwqtcZnF2EEzPEBQnpo5w@mail.gmail.com>
 <AM0PR04MB47239379BDB27553EB5D1E30D4929@AM0PR04MB4723.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB47239379BDB27553EB5D1E30D4929@AM0PR04MB4723.eurprd04.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Apr 2023 12:55:06 +0800
Message-ID: <CACGkMEvOcaRB4eUOUy=GzuGnfeba3wWHWFDNdOgxXVbqyX+wkA@mail.gmail.com>
Subject: Re: [PATCH resend 1/2] vdpa/snet: support getting and setting VQ state
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "mst@redhat.com" <mst@redhat.com>
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

T24gTW9uLCBBcHIgMywgMjAyMyBhdCA1OjE44oCvUE0gQWx2YXJvIEthcnN6IDxhbHZhcm8ua2Fy
c3pAc29saWQtcnVuLmNvbT4gd3JvdGU6Cj4KPiBIaSBKYXNvbiwKPgo+ID4gPiArICAgICAgIC8q
IE92ZXJ3cml0ZSB0aGUgY29udHJvbCByZWdpc3RlciB3aXRoIHRoZSBuZXcgYnVmZmVyIHNpemUg
KGluIDRCIHdvcmRzKSAqLwo+ID4gPiArICAgICAgIHNuZXRfd3JpdGVfY3RybChyZWdzLCBidWZf
d29yZHMpOwo+ID4gPiArICAgICAgIC8qIFVzZSBhIG1lbW9yeSBiYXJyaWVyLCB0aGlzIG11c3Qg
YmUgd3JpdHRlbiBiZWZvcmUgdGhlIG9wY29kZSByZWdpc3Rlci4gKi8KPiA+ID4gKyAgICAgICB3
bWIoKTsKPiA+Cj4gPgo+ID4gQXQgbGVhc3QgeW91IG5lZWQgdG8gdXNlIHNtcF93bWIoKSBidXQg
aWYgeW91IHdhbnQgdG8gc2VyaWFsaXplIE1NSU8KPiA+IHdyaXRlcyB5b3UgY2FuIHNpbXBseSB1
c2Ugc3BpbmxvY2tzIGFmdGVyIHRoZSByZW1vdmFsIG9mIG1taW93Ygo+ID4gd29ya1sxXS4KPiA+
Cj4KPiBJJ20gbm90IHN1cmUgaG93IGEgc3BpbmxvY2sgY2FuIGhlbHAgaW4gdGhpcyBjYXNlLgo+
IFRoZSBlbnRpcmUgY29udHJvbCBtZWNoYW5pc20gaXMgcHJvdGVjdGVkIGJ5IHRoZSBzcGlubG9j
ayBzbmV0LT5jdHJsX2xvY2ssIHNvIG11bHRpcGxlIENQVXMgd29uJ3QgdXNlIGl0IHNpbXVsdGFu
ZW91c2x5Lgo+Cj4gPiBOb3RlIHRoYXQgRG9jdW1lbnRhdGlvbi9tZW1vcnktYmFycmllcnMudHh0
IHNhaWQ6Cj4gPgo+ID4gICAgICAgICAxLiBBbGwgcmVhZFgoKSBhbmQgd3JpdGVYKCkgYWNjZXNz
ZXMgdG8gdGhlIHNhbWUgcGVyaXBoZXJhbCBhcmUgb3JkZXJlZAo+ID4gICAgICAgICAgICB3aXRo
IHJlc3BlY3QgdG8gZWFjaCBvdGhlci4gVGhpcyBlbnN1cmVzIHRoYXQgTU1JTyByZWdpc3RlciBh
Y2Nlc3Nlcwo+ID4gICAgICAgICAgICBieSB0aGUgc2FtZSBDUFUgdGhyZWFkIHRvIGEgcGFydGlj
dWxhciBkZXZpY2Ugd2lsbCBhcnJpdmUgaW4gcHJvZ3JhbQo+ID4gICAgICAgICAgICBvcmRlci4K
PiA+Cj4KPiBTbyBpdCB3aWxsIGFycml2ZSB0byB0aGUgcGNpIHN1YnN5c3RlbSBpbiBwcm9ncmFt
IG9yZGVyLCBidXQgdGhlIHBjaSBzdWJzeXN0ZW0gbWF5IHJlb3JkZXIsIHJpZ2h0PwoKVGhpcyBp
cyBub3Qgd2hhdCBJIHJlYWQgZnJvbSB0aGUgYWJvdmUgZG9jLiBJdCBzYWlkICJ0byBhIHBhcnRp
Y3VsYXIKZGV2aWNlIHdpbGwgYXJyaXZlIGluIHByb2dyYW0gb3JkZXIiLgoKPiBJIGNhbiBqdXN0
IGlzc3VlIGEgcmVhZCBhZnRlciB0aGUgd3JpdGVzLCBzb21ldGhpbmcgbGlrZToKPgo+IHdyaXRl
X2NvbnRyb2wKPiByZWFkX2NvbnRyb2wKPiB3cml0ZSBvcAo+IHJlYWQgb3AKPgo+IFdoYXQgZG8g
eW91IHRoaW5rPwoKVGhpcyBzaG91bGQgd29yay4KClRoYW5rcwoKPgo+ID4gPiArICAgICAgIC8q
IENsZWFyIHRoZSBjb250cm9sIHJlZ2lzdGVyIC0gY2xlYXIgdGhlIGVycm9yIGNvZGUgaWYgcHJl
dmlvdXMgY29udHJvbCBvcGVyYXRpb24gZmFpbGVkICovCj4gPiA+ICsgICAgICAgc25ldF93cml0
ZV9jdHJsKHJlZ3MsIDApOwo+ID4gPiArCj4gPiA+ICsgICAgICAgLyogV3JpdGUgb3Bjb2RlIGFu
ZCBWUSBpZHggKi8KPiA+ID4gKyAgICAgICB2YWwgPSBvcGNvZGUgfCAodnFfaWR4IDw8IDE2KTsK
PiA+ID4gKyAgICAgICBzbmV0X3dyaXRlX29wKHJlZ3MsIHZhbCk7Cj4gPgo+ID4gSSBndWVzcyB3
ZSBuZWVkIHRvIHNlcmlhbGl6ZSB0d28gd3JpdGVzIGhlcmUgYXMgd2VsbC4KPgo+IFNhbWUgaGVy
ZS4KPgo+IFRoYW5rcwo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
