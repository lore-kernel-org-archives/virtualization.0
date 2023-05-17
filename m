Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F327C77B7A
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 05:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F8E661136;
	Wed, 17 May 2023 05:24:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F8E661136
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fDLjPl7M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ypxmnLLdi4aE; Wed, 17 May 2023 05:24:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5AC7D60BBE;
	Wed, 17 May 2023 05:24:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AC7D60BBE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 326A5C0037;
	Wed, 17 May 2023 05:24:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ABF1C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F15BF60BBE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:24:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F15BF60BBE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oJwugnsRVgsj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:24:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C91C8610F4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C91C8610F4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684301047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t2TQmhlyr4qpfepuY+DlN4KamSzGRCNW1CGNN09KiW0=;
 b=fDLjPl7MsCd+wxd4DJS8H+ZH1mD9X/uSzBT2abX5xDFjv7P6DkoR784ITrUWeG8V1USnjH
 uYVWiRZmq3Nt6CO+cVj4exQQuoCt/lq5Pe/FMb0u1z26EJOLantdJSIjRH0Z39MAQU69bE
 +KtWQk6tYX8o4Tq/JjLJRkqVlXynmxg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-JHMINgNjM9-iAf3JO3dunQ-1; Wed, 17 May 2023 01:24:03 -0400
X-MC-Unique: JHMINgNjM9-iAf3JO3dunQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4edb90ccaadso250954e87.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 22:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684301042; x=1686893042;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2TQmhlyr4qpfepuY+DlN4KamSzGRCNW1CGNN09KiW0=;
 b=atbAp/17FqKf0oLjnxT6iFlgbmL6GbVOryVy16RZPia7YjnWZNzl/x/lFqAvLjEti6
 uUOFjNUiPt6sTyWXHhu3nV6ulVv37UcvndiP6oHSh08xZK6ZgmCpL9F4mds/ShH+cdw8
 3LEDPx7RE9HvoW0rd5pazNk+062oUSeR3p7NUqDGFMqWZm3mVmAwTtuDxym1v9oCmO+n
 2Qr56BcaoyJpL67kGA+8isFkeuKDHNi4+IX9gfCky1HLNbVgIavA9U1w+sbXCDSGZhRC
 loiIU2t0/Cm70sdg4pK0ffj3JhvfFdnwwu/H+gZJd0HSG9WMVxHtYHusEA2wQIYGq98L
 qZ7Q==
X-Gm-Message-State: AC+VfDz3F/NutuiK50WO97IFi2McGWygvljn+t25ApEs3cdHl4BkD6Ih
 Hdfs3MhT78+E3ckhAbszqUz26xRhGj4FB6S00XKDEkx3lyssT3NjY+3P7rZpQ7ry2Tyucc6nLak
 vaVicxe3YGs7OYu/Zh2GIJRc7zhwePlKP6LgU8OSjumTotSZnT1OWOwaZMA==
X-Received: by 2002:ac2:598c:0:b0:4f3:83d6:f22c with SMTP id
 w12-20020ac2598c000000b004f383d6f22cmr2314500lfn.66.1684301042055; 
 Tue, 16 May 2023 22:24:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4cbD5EclJjMC9h5Bmo7GCWi9NvKPqma8Oxjx6jDgJ08ur23xMjHhPMa62dMTnl0xvbjx0fqKiMEfZSJJ6fsHM=
X-Received: by 2002:ac2:598c:0:b0:4f3:83d6:f22c with SMTP id
 w12-20020ac2598c000000b004f383d6f22cmr2314490lfn.66.1684301041754; Tue, 16
 May 2023 22:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230516135446.16266-1-feliu@nvidia.com>
In-Reply-To: <20230516135446.16266-1-feliu@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 May 2023 13:23:50 +0800
Message-ID: <CACGkMEtitFX1v=fFYohLNz=xo3S7CM3Cdt09=C6xXz8kb1a4Cg@mail.gmail.com>
Subject: Re: [PATCH v1] virtio_pci: Optimize virtio_pci_device structure size
To: Feng Liu <feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Jiri Pirko <jiri@nvidia.com>, Bodong Wang <bodong@nvidia.com>
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

T24gVHVlLCBNYXkgMTYsIDIwMjMgYXQgOTo1NeKAr1BNIEZlbmcgTGl1IDxmZWxpdUBudmlkaWEu
Y29tPiB3cm90ZToKPgo+IEltcHJvdmUgdGhlIHNpemUgb2YgdGhlIHZpcnRpb19wY2lfZGV2aWNl
IHN0cnVjdHVyZSwgd2hpY2ggaXMgY29tbW9ubHkKPiB1c2VkIHRvIHJlcHJlc2VudCBhIHZpcnRp
byBQQ0kgZGV2aWNlLiBBIGdpdmVuIHZpcnRpbyBQQ0kgZGV2aWNlIGNhbgo+IGVpdGhlciBvZiBs
ZWdhY3kgdHlwZSBvciBtb2Rlcm4gdHlwZSwgd2l0aCB0aGUKPiBzdHJ1Y3QgdmlydGlvX3BjaV9s
ZWdhY3lfZGV2aWNlIG9jY3VweWluZyAzMiBieXRlcyBhbmQgdGhlCj4gc3RydWN0IHZpcnRpb19w
Y2lfbW9kZXJuX2RldmljZSBvY2N1cHlpbmcgODggYnl0ZXMuIE1ha2UgdGhlbSBhIHVuaW9uLAo+
IHRoZXJlYnkgc2F2ZSAzMiBieXRlcyBvZiBtZW1vcnkgYXMgc2hvd24gYnkgdGhlIHBhaG9sZSB0
b29sLiBUaGlzCj4gaW1wcm92ZW1lbnQgaXMgcGFydGljdWxhcmx5IGJlbmVmaWNpYWwgd2hlbiBk
ZWFsaW5nIHdpdGggbnVtZXJvdXMKPiBkZXZpY2VzLCBhcyBpdCBoZWxwcyBjb25zZXJ2ZSBtZW1v
cnkgcmVzb3VyY2VzLgo+Cj4gQmVmb3JlIHRoZSBtb2RpZmljYXRpb24sIHBhaG9sZSB0b29sIHJl
cG9ydGVkIHRoZSBmb2xsb3dpbmc6Cj4gc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlIHsKPiBbLi4u
XQo+ICAgICAgICAgc3RydWN0IHZpcnRpb19wY2lfbGVnYWN5X2RldmljZSBsZGV2OyAgICAgICAg
ICAgIC8qICAgODI0ICAgIDMyICovCj4gICAgICAgICAvKiAtLS0gY2FjaGVsaW5lIDEzIGJvdW5k
YXJ5ICg4MzIgYnl0ZXMpIHdhcyAyNCBieXRlcyBhZ28gLS0tICovCj4gICAgICAgICBzdHJ1Y3Qg
dmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlIG1kZXY7ICAgICAgICAgICAgLyogICA4NTYgICAgODgg
Ki8KPgo+ICAgICAgICAgLyogWFhYIGxhc3Qgc3RydWN0IGhhcyA0IGJ5dGVzIG9mIHBhZGRpbmcg
Ki8KPiBbLi4uXQo+ICAgICAgICAgLyogc2l6ZTogMTA1NiwgY2FjaGVsaW5lczogMTcsIG1lbWJl
cnM6IDE5ICovCj4gWy4uLl0KPiB9Owo+Cj4gQWZ0ZXIgdGhlIG1vZGlmaWNhdGlvbiwgcGFob2xl
IHRvb2wgcmVwb3J0ZWQgdGhlIGZvbGxvd2luZzoKPiBzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2Ug
ewo+IFsuLi5dCj4gICAgICAgICB1bmlvbiB7Cj4gICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0
aW9fcGNpX2xlZ2FjeV9kZXZpY2UgbGRldjsgICAgLyogICA4MjQgICAgMzIgKi8KPiAgICAgICAg
ICAgICAgICAgc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSBtZGV2OyAgICAvKiAgIDgy
NCAgICA4OCAqLwo+ICAgICAgICAgfTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC8qICAgODI0ICAgIDg4ICovCj4gWy4uLl0KPiAgICAgICAgIC8qIHNpemU6
IDEwMjQsIGNhY2hlbGluZXM6IDE2LCBtZW1iZXJzOiAxOCAqLwo+IFsuLi5dCj4gfTsKPgo+IFNp
Z25lZC1vZmYtYnk6IEZlbmcgTGl1IDxmZWxpdUBudmlkaWEuY29tPgo+IFJldmlld2VkLWJ5OiBK
aXJpIFBpcmtvIDxqaXJpQG52aWRpYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9jb21tb24uaCB8IDcgKysrKy0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19w
Y2lfY29tbW9uLmggYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5oCj4gaW5kZXgg
MjMxMTJkODQyMThmLi40Yjc3M2JkN2M1OGMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9jb21tb24uaAo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29t
bW9uLmgKPiBAQCAtNDUsOSArNDUsMTAgQEAgc3RydWN0IHZpcnRpb19wY2lfdnFfaW5mbyB7Cj4g
IHN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSB7Cj4gICAgICAgICBzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSB2ZGV2Owo+ICAgICAgICAgc3RydWN0IHBjaV9kZXYgKnBjaV9kZXY7Cj4gLSAgICAgICBzdHJ1
Y3QgdmlydGlvX3BjaV9sZWdhY3lfZGV2aWNlIGxkZXY7Cj4gLSAgICAgICBzdHJ1Y3QgdmlydGlv
X3BjaV9tb2Rlcm5fZGV2aWNlIG1kZXY7Cj4gLQo+ICsgICAgICAgdW5pb24gewo+ICsgICAgICAg
ICAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9sZWdhY3lfZGV2aWNlIGxkZXY7Cj4gKyAgICAgICAg
ICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgbWRldjsKPiArICAgICAgIH07
Cj4gICAgICAgICBib29sIGlzX2xlZ2FjeTsKPgo+ICAgICAgICAgLyogV2hlcmUgdG8gcmVhZCBh
bmQgY2xlYXIgaW50ZXJydXB0ICovCj4gLS0KPiAyLjM3LjEgKEFwcGxlIEdpdC0xMzcuMSkKPgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
