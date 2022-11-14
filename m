Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D15C4332F
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 16:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB3ED60DFC;
	Mon, 14 Nov 2022 16:18:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB3ED60DFC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L5NSdFA/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gbiDWnrU9spO; Mon, 14 Nov 2022 16:18:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4D7C860E07;
	Mon, 14 Nov 2022 16:18:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D7C860E07
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3617C0033;
	Mon, 14 Nov 2022 16:18:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B71B8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 16:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D31540317
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 16:18:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D31540317
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=L5NSdFA/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zh9TninuTbrl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 16:18:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB4DF4160A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB4DF4160A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 16:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668442688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxvXy2EJc9Qd0pwiulW/osrJ5/Pv/7EvjVfPKadkE/I=;
 b=L5NSdFA/m8vha7RHJPLdUF6dTe+i4vYrH7OGx+kVbO2wys68lk/osThEzqN/66Hp0LA9AM
 qveXH2y21kMEK3EQVHqAnYbLKbtyOLTDY/eChpTvn2wFzVtZ2QYWCRwyj7ZBJB0VTirolp
 A0QI1n31OSA/FaUT7DJqWvPY314ZV0E=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-269-jy9UCdipOzuLDQtrknzYRg-1; Mon, 14 Nov 2022 11:18:05 -0500
X-MC-Unique: jy9UCdipOzuLDQtrknzYRg-1
Received: by mail-il1-f197.google.com with SMTP id
 l4-20020a056e021aa400b00300ad9535c8so9557859ilv.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 08:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxvXy2EJc9Qd0pwiulW/osrJ5/Pv/7EvjVfPKadkE/I=;
 b=ozk/jNs24CtrJIL5OTB2n5+NseqluUuK2nOMgQ2jIvquHbJlIf4am9Bg8J4eiMQu01
 GMoywthq5je5Enc9iwnOzD4l/2sVbxux9OIxnaoUhTj095IDgpwB04IlQY/rX2ufaMBl
 ecSangPP3uBMzR84FIeJoWa80Voy6tUXCNssa37ZyLemWYqkJN0LILhsrWPJrXVqLbmS
 +1xj2whLSrbmuno7IRDflVxBEAoFCm3fkXR5gZtzoiFmS0PuQmz5FZ7xO+WQJNhkTAG+
 PqF2MBZDlMSv54v7cuCjKxIM1c4qoxg2fEwiT6nPz8CYMMqodrlqv/y5QJagJR8m1J16
 Ebtw==
X-Gm-Message-State: ANoB5pnP1HICc30W8JVSgCDRO2vXkJmK7smqxOAK7FNByx4hDeCA5aUX
 57plwmGxWrabC9AuhbqqwHFDv8l+RW1WYFdkZpdF9cgJ4rgmzPA7/ZAvFK24jmuF7JZ3oVA49gc
 ioJGs7ccM1aDW5tqwlFZsjR+WjkHlvjc3dg/8I52zGQ==
X-Received: by 2002:a05:6e02:1d06:b0:300:f4a5:7266 with SMTP id
 i6-20020a056e021d0600b00300f4a57266mr6579915ila.273.1668442684533; 
 Mon, 14 Nov 2022 08:18:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7lPMQWW+38n5rm2EgYIjtpOtDqi7Qiix94SnrgiMLorpuKojFAx39PuDP8JvI8meve6GVa+A==
X-Received: by 2002:a05:6e02:1d06:b0:300:f4a5:7266 with SMTP id
 i6-20020a056e021d0600b00300f4a57266mr6579906ila.273.1668442684300; 
 Mon, 14 Nov 2022 08:18:04 -0800 (PST)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 f19-20020a05660215d300b006ddf70e3ce8sm2290113iow.7.2022.11.14.08.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Nov 2022 08:18:03 -0800 (PST)
Date: Mon, 14 Nov 2022 09:18:02 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "leohou@tom.com" <leohou@tom.com>
Subject: Re: vIOMMU&IOMMU  gIOVA  to  HPA mapping
Message-ID: <20221114091802.6be5099e.alex.williamson@redhat.com>
In-Reply-To: <2022111420314945171759@tom.com>
References: <2022111420314945171759@tom.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: iommu <iommu@lists.linux.dev>, qemu-arm <qemu-arm@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gTW9uLCAxNCBOb3YgMjAyMiAyMDozMTo0OSArMDgwMAoibGVvaG91QHRvbS5jb20iIDxsZW9o
b3VAdG9tLmNvbT4gd3JvdGU6Cgo+IEhp77yMCj4gICAgICBIZXJlIGlzIG15IGFwcGxpY2F0aW9u
IHNjZW5hcmlv77yaCj4gMS4gVGhlIE5JQyAoTmV0d29yayBJbmZvcm1hdGlvbiBDZW50ZXIpIHBh
c3NlcyB0aHJvdWdoIHRvIHRoZSBWTShWaXJ0dWFsIE1hY2hpbmUpOwo+IDIuIFRoZSBWTSB1c2Vz
IHRoZSB1c2VyIG1vZGUgZHJpdmVyIERQREs7Cj4gCj4gUXVlc3Rpb246Cj4gMS4gdklPTU1VIG1h
aW50YWlucyB0aGUgbWFwcGluZyBnSU9WQS0+Z1BBLCBXaGVuIGRvIHlvdSB1c2UgdGhpcyBnUEEg
PwoKUUVNVSBpbiB0aGUgaG9zdCBkZXJpdmVzIHRoZSBoVkEgZnJvbSB0aGUgZ1BBLiAgVGhlIHZJ
T01NVSBkcml2ZXIgaW4KUUVNVSBpcyB0cmlnZ2VyaW5nIHRoZSBnSU9WQSB0byBoVkEgbWFwcGlu
ZyB0aHJvdWdoIHZmaW8gaW4gdGhlIGhvc3QuCgo+IDIuIFBoeXNpY2FsIElPTU1VIG1haW50YWlu
cyB0aGUgR0lPVkEtPkhQQSBtYXBwaW5nID8gIElmIHNvLCBieSB3aGF0IG1lYW5zIChnSU9WQSAt
PiBIUEEpIG1hcHBpbmcgPwoKQXMgYWJvdmUsIHRoZSB2SU9NTVUgaW4gdGhlIGd1ZXN0IHByb3Zp
ZGVzIGdJT1ZBIC0+IGdQQSwgaW4gUUVNVSB3ZSBkbwp0aGUgZ1BBIC0+IGhWQSwgdGhlbiB2Zmlv
IGluIHRoZSBob3N0IGtlcm5lbCBwZXJmb3JtcyBoVkEgLT4gaFBBIHZpYQpwYWdlIHBpbm5pbmcu
Cgo+IDMuIFdoYXQgZG9lcyBRRU1VIGRvIGluIE5JQyBwYXNzLXRocm91Z2ggYWRkcmVzcyB0cmFu
c2xhdGlvbiDvvJ8KClRoZSBndWVzdCB2aXNpYmxlIHZJT01NVSB0cmlnZ2VycyBNZW1vcnlMaXN0
ZW5lciBub3RpZmljYXRpb25zIGluIFFFTVUKZm9yIHRoZSBkZXZpY2UgYWRkcmVzcyBzcGFjZSwg
d2hpY2ggaW5zZXJ0IGFuZCByZW1vdmVzIG1hcHBpbmdzIHRvIHRoZQp2ZmlvIGxheWVyIGJlbG93
IGl0LiAgVGhhbmtzLAoKQWxleAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
