Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD24C4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 11:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4465640584;
	Tue,  8 Mar 2022 11:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DJ92sp-dIkkJ; Tue,  8 Mar 2022 11:06:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4D3FA40144;
	Tue,  8 Mar 2022 11:06:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B04FC001D;
	Tue,  8 Mar 2022 11:06:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82A9DC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 11:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 643BE4035B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 11:06:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DuBIVYk4IEq8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 11:06:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 688CC40291
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 11:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646737614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=991nBlYZCZCpiOj2G+SgVUb1qCNFHvKZstldYfktIgA=;
 b=Oy6iSycFB8UmoTbb4WP8h4zH22pgbQu32q+lc2DxmSPNHTaMd1OM7/7Bt2TwFbMfPEfYTZ
 5g8CExSIAF683j0Y63H3WYCU/sqUJ8uKYzrXtY4OOOvkwuhqmKleWC48h2iQLsVJ2OGFBd
 VaB3JRqYQ2KqtUimBqy0NXN8+1k3vHw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-UDa-xZVuNiOH2pwrRzhfyw-1; Tue, 08 Mar 2022 06:06:53 -0500
X-MC-Unique: UDa-xZVuNiOH2pwrRzhfyw-1
Received: by mail-ed1-f72.google.com with SMTP id
 x5-20020a50ba85000000b004161d68ace6so5272674ede.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 03:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=991nBlYZCZCpiOj2G+SgVUb1qCNFHvKZstldYfktIgA=;
 b=C4w+7EKN2DBukQnRJLqRE5g83vFjI3ijOXPszduos55aZsS5qCuuaWC6YkkIS1XzAZ
 xKUweVoz+P05T8OALvXsckrBDL7riS2K1YEgpjDpk3D55bZ9+lDE1TboN8u1eXAr8Ubc
 tPbvIqbtWoXdu8+CXP1qj9kUrQS/XNsR4pqzEiRE8/AcXoDv58bYod2qRTRcgwMoGDqS
 6P3DYhUh+9jA+hjKWrupr6D9QbvHiHh6/8FEPyuYiMiZsdiX95x2d4RwXJ5lkhNkqoe0
 3GBrOtrp9k5iztYaVGmaFTrxvSucwA8WvxlipfvCjEb9DgvTFdsYqaS+U064wEK6uslZ
 EJLA==
X-Gm-Message-State: AOAM531IdRfiSOQ7Xz2HRUtEj0hPRtN8+jB2zPOPWMMG5P+LmrLp9BSc
 QsrNIb6uoKHT981A3gVAo24TVzgDseyeg0UL3BpJV/n95ZR0XCERep0w9nifAfoRNo5Hq1Kqvx9
 Gs9noeRO3NuY1nWTa1BXpOPhLDZ0UvAOmCnPG1Z4uPw==
X-Received: by 2002:a17:907:2a53:b0:6ce:e4fe:3f92 with SMTP id
 fe19-20020a1709072a5300b006cee4fe3f92mr12489213ejc.389.1646737611475; 
 Tue, 08 Mar 2022 03:06:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6OHvhq4Auw6rP2YfKxvG4L9ELqPU+Q10SahOdgKyllWovG+m4xcSqtTWQv7yg0Tmpn5/sLA==
X-Received: by 2002:a17:907:2a53:b0:6ce:e4fe:3f92 with SMTP id
 fe19-20020a1709072a5300b006cee4fe3f92mr12489189ejc.389.1646737611169; 
 Tue, 08 Mar 2022 03:06:51 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 y18-20020a056402271200b0041110d6b80asm7573255edd.39.2022.03.08.03.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 03:06:50 -0800 (PST)
Date: Tue, 8 Mar 2022 06:06:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220308060542-mutt-send-email-mst@kernel.org>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <CACGkMEsjmCNQPjxPjXL0WUfbMg8ARnumEp4yjUxqznMKR1nKSQ@mail.gmail.com>
 <YicO+aF4VhaBYNqK@google.com>
MIME-Version: 1.0
In-Reply-To: <YicO+aF4VhaBYNqK@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com,
 kvm <kvm@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
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

T24gVHVlLCBNYXIgMDgsIDIwMjIgYXQgMDg6MDg6MjVBTSArMDAwMCwgTGVlIEpvbmVzIHdyb3Rl
Ogo+IE9uIFR1ZSwgMDggTWFyIDIwMjIsIEphc29uIFdhbmcgd3JvdGU6Cj4gCj4gPiBPbiBUdWUs
IE1hciA4LCAyMDIyIGF0IDM6MTggQU0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4g
d3JvdGU6Cj4gPiA+Cj4gPiA+IHZob3N0X3Zzb2NrX2hhbmRsZV90eF9raWNrKCkgYWxyZWFkeSBo
b2xkcyB0aGUgbXV0ZXggZHVyaW5nIGl0cyBjYWxsCj4gPiA+IHRvIHZob3N0X2dldF92cV9kZXNj
KCkuICBBbGwgd2UgaGF2ZSB0byBkbyBoZXJlIGlzIHRha2UgdGhlIHNhbWUgbG9jawo+ID4gPiBk
dXJpbmcgdmlydHF1ZXVlIGNsZWFuLXVwIGFuZCB3ZSBtaXRpZ2F0ZSB0aGUgcmVwb3J0ZWQgaXNz
dWVzLgo+ID4gPgo+ID4gPiBBbHNvIFdBUk4oKSBhcyBhIHByZWNhdXRpb25hcnkgbWVhc3VyZS4g
IFRoZSBwdXJwb3NlIG9mIHRoaXMgaXMgdG8KPiA+ID4gY2FwdHVyZSBwb3NzaWJsZSBmdXR1cmUg
cmFjZSBjb25kaXRpb25zIHdoaWNoIG1heSBwb3AgdXAgb3ZlciB0aW1lLgo+ID4gPgo+ID4gPiBM
aW5rOiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9Mjc5NDMyZDMwZDgy
NWU2M2JhMDAKPiA+ID4KPiA+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPgo+ID4gPiBS
ZXBvcnRlZC1ieTogc3l6Ym90K2FkYzNjYjMyMzg1NTg2YmVjODU5QHN5emthbGxlci5hcHBzcG90
bWFpbC5jb20KPiA+ID4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJv
Lm9yZz4KPiA+ID4gLS0tCj4gPiA+ICBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAxMCArKysrKysr
KysrCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+ID4gPgo+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92aG9zdC5jIGIvZHJpdmVycy92aG9zdC92aG9zdC5j
Cj4gPiA+IGluZGV4IDU5ZWRiNWExZmZlMjguLmVmN2UzNzFlM2U2NDkgMTAwNjQ0Cj4gPiA+IC0t
LSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gPiArKysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0
LmMKPiA+ID4gQEAgLTY5Myw2ICs2OTMsMTUgQEAgdm9pZCB2aG9zdF9kZXZfY2xlYW51cChzdHJ1
Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gPiA+ICAgICAgICAgaW50IGk7Cj4gPiA+Cj4gPiA+ICAgICAg
ICAgZm9yIChpID0gMDsgaSA8IGRldi0+bnZxczsgKytpKSB7Cj4gPiA+ICsgICAgICAgICAgICAg
ICAvKiBObyB3b3JrZXJzIHNob3VsZCBydW4gaGVyZSBieSBkZXNpZ24uIEhvd2V2ZXIsIHJhY2Vz
IGhhdmUKPiA+ID4gKyAgICAgICAgICAgICAgICAqIHByZXZpb3VzbHkgb2NjdXJyZWQgd2hlcmUg
ZHJpdmVycyBoYXZlIGJlZW4gdW5hYmxlIHRvIGZsdXNoCj4gPiA+ICsgICAgICAgICAgICAgICAg
KiBhbGwgd29yayBwcm9wZXJseSBwcmlvciB0byBjbGVhbi11cC4gIFdpdGhvdXQgYSBzdWNjZXNz
ZnVsCj4gPiA+ICsgICAgICAgICAgICAgICAgKiBmbHVzaCB0aGUgZ3Vlc3Qgd2lsbCBtYWxmdW5j
dGlvbiwgYnV0IGF2b2lkaW5nIGhvc3QgbWVtb3J5Cj4gPiA+ICsgICAgICAgICAgICAgICAgKiBj
b3JydXB0aW9uIGluIHRob3NlIGNhc2VzIGRvZXMgc2VlbSBwcmVmZXJhYmxlLgo+ID4gPiArICAg
ICAgICAgICAgICAgICovCj4gPiA+ICsgICAgICAgICAgICAgICBXQVJOX09OKG11dGV4X2lzX2xv
Y2tlZCgmZGV2LT52cXNbaV0tPm11dGV4KSk7Cj4gPiA+ICsKPiA+IAo+ID4gSSBkb24ndCBnZXQg
aG93IHRoaXMgY2FuIGhlbHAsIHRoZSBtdXRleCBjb3VsZCBiZSBncmFiYmVkIGluIHRoZQo+ID4g
bWlkZGxlIG9mIHRoZSBhYm92ZSBhbmQgYmVsb3cgbGluZS4KPiAKPiBUaGUgd29yc3QgdGhhdCBo
YXBwZW5zIGluIHRoaXMgc2xpbSBzY2VuYXJpbyBpcyB3ZSBtaXNzIGEgd2FybmluZy4KPiBUaGUg
bXV0ZXhlcyBiZWxvdyB3aWxsIHN0aWxsIGZ1bmN0aW9uIGFzIGV4cGVjdGVkIGFuZCBwcmV2ZW50
IHBvc3NpYmxlCj4gbWVtb3J5IGNvcnJ1cHRpb24uCgptYXliZS4gb3IgbWF5YmUgY29ycnVwdGlv
biBhbHJlYWR5IGhhcHBlbmVkIGFuZCB0aGlzIGlzIHRoZQpmYWxsb3V0LgoKPiA+ID4gKyAgICAg
ICAgICAgICAgIG11dGV4X2xvY2soJmRldi0+dnFzW2ldLT5tdXRleCk7Cj4gPiA+ICAgICAgICAg
ICAgICAgICBpZiAoZGV2LT52cXNbaV0tPmVycm9yX2N0eCkKPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgZXZlbnRmZF9jdHhfcHV0KGRldi0+dnFzW2ldLT5lcnJvcl9jdHgpOwo+ID4gPiAg
ICAgICAgICAgICAgICAgaWYgKGRldi0+dnFzW2ldLT5raWNrKQo+ID4gPiBAQCAtNzAwLDYgKzcw
OSw3IEBAIHZvaWQgdmhvc3RfZGV2X2NsZWFudXAoc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ID4g
PiAgICAgICAgICAgICAgICAgaWYgKGRldi0+dnFzW2ldLT5jYWxsX2N0eC5jdHgpCj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGV2ZW50ZmRfY3R4X3B1dChkZXYtPnZxc1tpXS0+Y2FsbF9j
dHguY3R4KTsKPiA+ID4gICAgICAgICAgICAgICAgIHZob3N0X3ZxX3Jlc2V0KGRldiwgZGV2LT52
cXNbaV0pOwo+ID4gPiArICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZkZXYtPnZxc1tpXS0+
bXV0ZXgpOwo+ID4gPiAgICAgICAgIH0KPiA+IAo+ID4gSSdtIG5vdCBzdXJlIGl0J3MgY29ycmVj
dCB0byBhc3N1bWUgc29tZSBiZWhhdmlvdXIgb2YgYSBidWdneSBkZXZpY2UuCj4gPiBGb3IgdGhl
IGRldmljZSBtdXRleCwgd2UgdXNlIHRoYXQgdG8gcHJvdGVjdCBtb3JlIHRoYW4ganVzdCBlcnIv
Y2FsbAo+ID4gYW5kIHZxLgo+IAo+IFdoZW4gSSBhdXRob3JlZCB0aGlzLCBJIGRpZCBzbyBhcyAq
dGhlKiBmaXguICBIb3dldmVyLCBzaW5jZSB0aGUgY2F1c2UKPiBvZiB0b2RheSdzIGNyYXNoIGhh
cyBub3cgYmVlbiBwYXRjaGVkLCB0aGlzIGhhcyBiZWNvbWUgYSBiZWx0IGFuZAo+IGJyYWNlcyBz
b2x1dGlvbi4gIE1pY2hhZWwncyBhZGRpdGlvbiBvZiB0aGUgV0FSTigpIGFsc28gaGFzIHRoZQo+
IGJlbmVmaXQgb2YgcHJvdmlkaW5nIHVzIHdpdGggYW4gZWFybHkgd2FybmluZyBzeXN0ZW0gZm9y
IGZ1dHVyZQo+IGJyZWFrYWdlcy4gIFBlcnNvbmFsbHksIEkgdGhpbmsgaXQncyBraW5kYSBuZWF0
Lgo+IAo+IC0tIAo+IExlZSBKb25lcyBb5p2O55C85pavXQo+IFByaW5jaXBhbCBUZWNobmljYWwg
TGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwo+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNv
ZnR3YXJlIGZvciBBcm0gU29Dcwo+IEZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8
IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
