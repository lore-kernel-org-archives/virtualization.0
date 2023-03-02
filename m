Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1A3C678D4
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 07:04:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DAC14199D;
	Thu,  2 Mar 2023 07:04:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DAC14199D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CH1SHKrB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9QEZ27utRkMd; Thu,  2 Mar 2023 07:04:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AFE094199C;
	Thu,  2 Mar 2023 07:04:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AFE094199C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82687C0035;
	Thu,  2 Mar 2023 07:04:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48F8BC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 07:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30EEB81F43
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 07:04:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30EEB81F43
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CH1SHKrB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 57_Ch8Zn9GV9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 07:04:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B6DA81F42
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B6DA81F42
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 07:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677740669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3I7fEWBSkBRmUqs/CW5rH4YweDzHXspjsekRmlHIHT0=;
 b=CH1SHKrBw1UrwnH+XcZQqx4H2MjYKE/d0v5s4EisOt4Ocit8u6NzXcTdCQyoUsn8uRXcS0
 9xtUELqsokbK7B7Ee5/traYGx0tnkmYjQYg4NzxsqXTmKgbP8GlVmqTEzvly2mwaY7zrz/
 DK3AZfDF2YHxRASIBtEB3/6P7oZlISE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-i50bVHIaMYmST0Dih8iqcA-1; Thu, 02 Mar 2023 02:04:27 -0500
X-MC-Unique: i50bVHIaMYmST0Dih8iqcA-1
Received: by mail-oo1-f71.google.com with SMTP id
 d201-20020a4a52d2000000b0051faef7ba52so3342343oob.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Mar 2023 23:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3I7fEWBSkBRmUqs/CW5rH4YweDzHXspjsekRmlHIHT0=;
 b=0TH6Jrlzf3vsMUzpz6iw5W7mx6/MQShyV3uXg7joLS6Q2yOMHzJn34x00dP6ihM7iQ
 g2Pg9TSlVfrGUSM97TkjhUkXXia0/NFr/wtW/SoAA0BkBw0XyhubmhR+QkQnn84Dl8Ol
 XL3dVAJ7YNWcD7OURUaT/ZIOPT9ZONBfmf245R4a4/hZnfHUVfwO3IrptujaKm+tXK8T
 IyntPphYG3b1kIacpdK8uvKy7rwElHO3m12+oSiUCf0ykwqjzS169zC9rhAMt7kgfpwI
 aU/F0TbQvWOkPee+L7W8kPBdkm18OHK6w8YyWbvwvWvCPWBJDfJKXrikrgrxorLvy6LE
 aATg==
X-Gm-Message-State: AO0yUKXOagQHcwumQI4cC3u3SrOQ0fmj2iixwlNssuRYR1kStY2INM8O
 5RhfS6MxeFJvwSd3xRhs+0pMsKuYlCXEZbjoDfcYwbnh+ea4ZeLbZ7xzYZ2MUUBELknbonBXbw5
 gkPL/HpTEFUKYu4H6jEnxLXb6RhPJjpENwvYeO9DbgmDKGxqq1LQMgYkSxg==
X-Received: by 2002:aca:f14:0:b0:384:63a:305c with SMTP id
 20-20020aca0f14000000b00384063a305cmr406851oip.2.1677740666950; 
 Wed, 01 Mar 2023 23:04:26 -0800 (PST)
X-Google-Smtp-Source: AK7set/GVk7xB4Dn9iyfjHunjJpsSyZ3FpxKMSMLNZPMiyP0X8CCm77l0gsVjvHVGOmNLjOn/IuoalCbJZmuM7ep4GQ=
X-Received: by 2002:aca:f14:0:b0:384:63a:305c with SMTP id
 20-20020aca0f14000000b00384063a305cmr406838oip.2.1677740666774; 
 Wed, 01 Mar 2023 23:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20230301163203.29883-1-gautam.dawar@amd.com>
In-Reply-To: <20230301163203.29883-1-gautam.dawar@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Mar 2023 15:04:15 +0800
Message-ID: <CACGkMEtSe3ho5D3Lsx2gf2xUSJq+fgWcb-zsE6Lw4jJgSuLVjA@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: free iommu domain after last use during
 cleanup
To: Gautam Dawar <gautam.dawar@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: tanuj.kamde@amd.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-net-drivers@amd.com,
 netdev@vger.kernel.org, harpreet.anand@amd.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, "Longpeng \(Mike,
 Cloud Infrastructure Service Product Dept.\)" <longpeng2@huawei.com>
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

T24gVGh1LCBNYXIgMiwgMjAyMyBhdCAxMjozMuKAr0FNIEdhdXRhbSBEYXdhciA8Z2F1dGFtLmRh
d2FyQGFtZC5jb20+IHdyb3RlOgo+Cj4gQ3VycmVudGx5IHZob3N0X3ZkcGFfY2xlYW51cCgpIHVu
bWFwcyB0aGUgRE1BIG1hcHBpbmdzIGJ5IGNhbGxpbmcKPiBgaW9tbXVfdW5tYXAodi0+ZG9tYWlu
LCBtYXAtPnN0YXJ0LCBtYXAtPnNpemUpO2AKPiBmcm9tIHZob3N0X3ZkcGFfZ2VuZXJhbF91bm1h
cCgpIHdoZW4gdGhlIHBhcmVudCB2RFBBIGRyaXZlciBkb2Vzbid0Cj4gcHJvdmlkZSBETUEgY29u
ZmlnIG9wZXJhdGlvbnMuCj4KPiBIb3dldmVyLCB0aGUgSU9NTVUgZG9tYWluIHJlZmVycmVkIHRv
IGJ5IGB2LT5kb21haW5gIGlzIGZyZWVkIGluCj4gdmhvc3RfdmRwYV9mcmVlX2RvbWFpbigpIGJl
Zm9yZSB2aG9zdF92ZHBhX2NsZWFudXAoKSBpbgo+IHZob3N0X3ZkcGFfcmVsZWFzZSgpIHdoaWNo
IHJlc3VsdHMgaW4gTlVMTCBwb2ludGVyIGRlLXJlZmVyZW5jZS4KPiBBY2NvcmRpbmdseSwgbW92
aW5nIHRoZSBjYWxsIHRvIHZob3N0X3ZkcGFfZnJlZV9kb21haW4oKSBpbgo+IHZob3N0X3ZkcGFf
Y2xlYW51cCgpIHdvdWxkIG1ha2VzIHNlbnNlLiBUaGlzIHdpbGwgYWxzbyBoZWxwCj4gZGV0YWNo
aW5nIHRoZSBkbWEgZGV2aWNlIGluIGVycm9yIGhhbmRsaW5nIG9mIHZob3N0X3ZkcGFfYWxsb2Nf
ZG9tYWluKCkuCj4KPiBUaGlzIGlzc3VlIHdhcyBvYnNlcnZlZCBvbiB0ZXJtaW5hdGluZyBRRU1V
IHdpdGggU0lHUVVJVC4KPgo+IEZpeGVzOiAwMzdkNDMwNTU2OWEgKCJ2aG9zdC12ZHBhOiBjYWxs
IHZob3N0X3ZkcGFfY2xlYW51cCBkdXJpbmcgdGhlIHJlbGVhc2UiKQo+IFNpZ25lZC1vZmYtYnk6
IEdhdXRhbSBEYXdhciA8Z2F1dGFtLmRhd2FyQGFtZC5jb20+CgpBY2tlZC1ieTogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiAgZHJpdmVycy92aG9zdC92
ZHBhLmMgfCAzICsrLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYwo+IGluZGV4IGVjMzJmNzg1ZGZkZS4uYjc2NTc5ODRkZDhkIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBA
QCAtMTEzNCw2ICsxMTM0LDcgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX2FsbG9jX2RvbWFpbihz
dHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPgo+ICBlcnJfYXR0YWNoOgo+ICAgICAgICAgaW9tbXVfZG9t
YWluX2ZyZWUodi0+ZG9tYWluKTsKPiArICAgICAgIHYtPmRvbWFpbiA9IE5VTEw7Cj4gICAgICAg
ICByZXR1cm4gcmV0Owo+ICB9Cj4KPiBAQCAtMTE3OCw2ICsxMTc5LDcgQEAgc3RhdGljIHZvaWQg
dmhvc3RfdmRwYV9jbGVhbnVwKHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHZob3N0X3ZkcGFfcmVtb3ZlX2FzKHYsIGFzaWQpOwo+ICAgICAgICAgfQo+Cj4g
KyAgICAgICB2aG9zdF92ZHBhX2ZyZWVfZG9tYWluKHYpOwo+ICAgICAgICAgdmhvc3RfZGV2X2Ns
ZWFudXAoJnYtPnZkZXYpOwo+ICAgICAgICAga2ZyZWUodi0+dmRldi52cXMpOwo+ICB9Cj4gQEAg
LTEyNTAsNyArMTI1Miw2IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZWxlYXNlKHN0cnVjdCBp
bm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkKPiAgICAgICAgIHZob3N0X3ZkcGFfY2xl
YW5faXJxKHYpOwo+ICAgICAgICAgdmhvc3RfdmRwYV9yZXNldCh2KTsKPiAgICAgICAgIHZob3N0
X2Rldl9zdG9wKCZ2LT52ZGV2KTsKPiAtICAgICAgIHZob3N0X3ZkcGFfZnJlZV9kb21haW4odik7
Cj4gICAgICAgICB2aG9zdF92ZHBhX2NvbmZpZ19wdXQodik7Cj4gICAgICAgICB2aG9zdF92ZHBh
X2NsZWFudXAodik7Cj4gICAgICAgICBtdXRleF91bmxvY2soJmQtPm11dGV4KTsKPiAtLQo+IDIu
MzAuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
