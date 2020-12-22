Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB07C433E0
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 13:23:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02788229C5
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 13:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02788229C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 974868666E;
	Tue, 22 Dec 2020 13:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vY8fcgpjI9qG; Tue, 22 Dec 2020 13:23:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7034B8665B;
	Tue, 22 Dec 2020 13:23:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 423C5C1787;
	Tue, 22 Dec 2020 13:23:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CA8BC0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 13:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4FB48860CF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 13:23:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vQtTm5W4Z7ex
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 13:23:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 689CD86073
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608643421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kISqIU8vAjOFBkpQnPPm5JuJX1GeR511WeyawMtRTI=;
 b=UiT/OqFO7H+EB3512OKvAsEuqKwZtl7z892RTOKiTSaEdjKD1WRanQMQZ4/2O13D+Lj/mV
 hXN67OdWXTF/Yn5mD468ve3K2086Qq5aUkHwUzAC2FaT4+dELyMR0s51Lu8J7mjwTtYT+g
 HqsKnMVLxCMmOdaGVMEBajx6Z+nO6f0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-ApXRZ9UWPA6cl6BD9yl7jQ-1; Tue, 22 Dec 2020 08:23:39 -0500
X-MC-Unique: ApXRZ9UWPA6cl6BD9yl7jQ-1
Received: by mail-wm1-f72.google.com with SMTP id b4so1690122wmj.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 05:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=9kISqIU8vAjOFBkpQnPPm5JuJX1GeR511WeyawMtRTI=;
 b=gnC/FWruUAPIDEEozKYmX8NB1hVyeQRNWbl8SiG7TqLqIDj07ezrHuef0zfJC4qEhM
 nUcpuJg4/8D/VCOlJ66p3O7lYNnBciixmPZsW25GcZeayHyR92tkMTSMVuqa5MI+4J3n
 fgSSMb9bKoUY7df3MWTJJbw62cnXiJHncFjduPp+/5nC3jQ5k3pxo43NC0TVcOwEcTMa
 vdTPyZEke32q45MtusOmNejRErMg150vejjdLaZl24EZwMACd/BQ1oCcfmgxJP/oHq3G
 sGi78wJUNyvCC48QHmuOhgUjdfQqgD65ypaX1EsJoXT5BZjzr/QmUAhZChFY9E3igtNV
 x82g==
X-Gm-Message-State: AOAM533LHJJ7G6TRsTX8/PeSHiDCjonZe/nhl0Ca6e/hiPK1xvgH7NWZ
 Cq9i/3C+qABXamcm11l452YsSBBhZJsiX+b7YDYAjliV+Yw6Szvl0MzLZHbs1eFu0V6ExsAKYVR
 dNudtan5hEanbL7zJ9OGpx9DBlsKAqeBE4wM1TiHoDw==
X-Received: by 2002:a05:600c:25c2:: with SMTP id
 2mr22499142wml.170.1608643417883; 
 Tue, 22 Dec 2020 05:23:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9rysDLcWTp8Jau0zRAN0UDLnMWHjrfFFfXPkheRBJUpzOIBynVFrzYgP/JEQ2TVAAHWtjJw==
X-Received: by 2002:a05:600c:25c2:: with SMTP id
 2mr22499103wml.170.1608643417665; 
 Tue, 22 Dec 2020 05:23:37 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id j59sm32452847wrj.13.2020.12.22.05.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Dec 2020 05:23:37 -0800 (PST)
Date: Tue, 22 Dec 2020 14:23:34 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block
 device
Message-ID: <20201222132334.v34qfcjyhta6noen@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
 <20201218113816.zcyeyqipux4ao4cp@steredhat>
 <7dd3ed02-36c3-fcfd-0a1d-9c31af6f473e@redhat.com>
 <20201221111423.sestfroiw2dgpluc@steredhat>
 <856d53c2-82e2-e408-76e6-24c92010f973@redhat.com>
 <20201222105733.4f6oou7lshi35qvc@steredhat>
 <cc913954-135d-da5a-1acd-38c3ecb77dfa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cc913954-135d-da5a-1acd-38c3ecb77dfa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBEZWMgMjIsIDIwMjAgYXQgMDg6Mjk6MjBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMi8yMiDkuIvljYg2OjU3LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+T24gVHVlLCBEZWMgMjIsIDIwMjAgYXQgMTA6NDQ6NDhBTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPj4+Cj4+Pk9uIDIwMjAvMTIvMjEg5LiL5Y2INzoxNCwgU3RlZmFubyBHYXJ6YXJlbGxh
IHdyb3RlOgo+Pj4+T24gTW9uLCBEZWMgMjEsIDIwMjAgYXQgMTE6MTY6NTRBTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPj4+Pj4KPj4+Pj5PbiAyMDIwLzEyLzE4IOS4i+WNiDc6MzgsIFN0ZWZh
bm8gR2FyemFyZWxsYSB3cm90ZToKPj4+Pj4+T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTE6Mzc6
NDhBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+Pgo+Pj4+Pj4+T24gMjAyMC8xMS8x
MyDkuIvljYg5OjQ3LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4+Pj4+Pj4+VGhhbmtzIHRv
IE1heCB0aGF0IHN0YXJ0ZWQgdGhpcyB3b3JrIQo+Pj4+Pj4+PkkgdG9vayBoaXMgcGF0Y2hlcywg
YW5kIGV4dGVuZGVkIHRoZSBibG9jayBzaW11bGF0b3IgYSBiaXQuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+
VGhpcyBzZXJpZXMgbW92ZXMgdGhlIG5ldHdvcmsgZGV2aWNlIHNpbXVsYXRvciBpbiBhIG5ldyBt
b2R1bGUKPj4+Pj4+Pj4odmRwYV9zaW1fbmV0KSBhbmQgbGVhdmVzIHRoZSBnZW5lcmljIGZ1bmN0
aW9ucyBpbiB0aGUgCj4+Pj4+Pj4+dmRwYV9zaW0gY29yZQo+Pj4+Pj4+Pm1vZHVsZSwgYWxsb3dp
bmcgdGhlIHBvc3NpYmlsaXR5IHRvIGFkZCBuZXcgdkRQQSBkZXZpY2Ugc2ltdWxhdG9ycy4KPj4+
Pj4+Pj5UaGVuIHdlIGFkZGVkIGEgbmV3IHZkcGFfc2ltX2JsayBtb2R1bGUgdG8gc2ltdWxhdGUg
YSBibG9jayBkZXZpY2UuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+SSdtIG5vdCBzdXJlIGFib3V0IHBhdGNo
IDExICgidnJpbmdoOiBhbGxvdyAKPj4+Pj4+Pj52cmluZ2hfaW92X3hmZXIoKSB0byBza2lwCj4+
Pj4+Pj4+Ynl0ZXMgd2hlbiBwdHIgaXMgTlVMTCIpLCBtYXliZSB3ZSBjYW4gYWRkIGEgbmV3IAo+
Pj4+Pj4+PmZ1bmN0aW9ucyBpbnN0ZWFkIG9mCj4+Pj4+Pj4+bW9kaWZ5IHZyaW5naF9pb3ZfeGZl
cigpLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PkFzIE1heCByZXBvcnRlZCwgSSdtIGFsc28gc2VlaW5nIGVy
cm9ycyB3aXRoIAo+Pj4+Pj4+PnZkcGFfc2ltX2JsayByZWxhdGVkIHRvCj4+Pj4+Pj4+aW90bGIg
YW5kIHZyaW5naCB3aGVuIHRoZXJlIGlzIGhpZ2ggbG9hZCwgdGhlc2UgYXJlIHNvbWUgCj4+Pj4+
Pj4+b2YgdGhlIGVycm9yCj4+Pj4+Pj4+bWVzc2FnZXMgSSBjYW4gc2VlIHJhbmRvbWx5Ogo+Pj4+
Pj4+Pgo+Pj4+Pj4+PsKgIHZyaW5naDogRmFpbGVkIHRvIGFjY2VzcyBhdmFpbCBpZHggYXQgMDAw
MDAwMDBlOGRlYjJjYwo+Pj4+Pj4+PsKgIHZyaW5naDogRmFpbGVkIHRvIHJlYWQgaGVhZDogaWR4
IDYyODkgYWRkcmVzcyAwMDAwMDAwMGUxYWQxZDUwCj4+Pj4+Pj4+wqAgdnJpbmdoOiBGYWlsZWQg
dG8gZ2V0IGZsYWdzIGF0IDAwMDAwMDAwNjYzNWQ3YTMKPj4+Pj4+Pj4KPj4+Pj4+Pj7CoCB2aXJ0
aW9fdmRwYSB2ZHBhMDogdnJpbmdoX2lvdl9wdXNoX2lvdGxiKCkgZXJyb3I6IC0xNCAKPj4+Pj4+
Pj5vZmZzZXQ6IMKgIDB4Mjg0MDAwMCBsZW46IDB4MjAwMDAKPj4+Pj4+Pj7CoCB2aXJ0aW9fdmRw
YSB2ZHBhMDogdnJpbmdoX2lvdl9wdWxsX2lvdGxiKCkgZXJyb3I6IC0xNCAKPj4+Pj4+Pj5vZmZz
ZXQ6IMKgIDB4NThlZTAwMCBsZW46IDB4MzAwMAo+Pj4+Pj4+Pgo+Pj4+Pj4+PlRoZXNlIGVycm9y
cyBzaG91bGQgYWxsIGJlIHJlbGF0ZWQgdG8gdGhlIGZhY3QgdGhhdCAKPj4+Pj4+Pj5pb3RsYl90
cmFuc2xhdGUoKQo+Pj4+Pj4+PmZhaWxzIHdpdGggLUVJTlZBTCwgc28gaXQgc2VlbXMgdGhhdCB3
ZSBtaXNzIHNvbWUgbWFwcGluZy4KPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj5JcyB0aGlzIG9ubHkg
cmVwcm9kdWNpYmxlIHdoZW4gdGhlcmUncyBtdWx0aXBsZSBjby1jdXJyZW50IAo+Pj4+Pj4+YWNj
ZXNzaW5nIG9mIElPVExCPyBJZiB5ZXMsIGl0J3MgcHJvYmFibHkgYSBoaW50IHRoYXQgc29tZSAK
Pj4+Pj4+PmtpbmQgb2Ygc3luY2hyb25pemF0aW9uIGlzIHN0aWxsIG1pc3NlZCBzb21ld2hlcmUu
Cj4+Pj4+Pj4KPj4+Pj4+Pkl0IG1pZ2h0IGJlIHVzZWZ1bCB0byBsb2cgdGhlIGRtYV9tYXAvdW5t
cCBpbiBib3RoIAo+Pj4+Pj4+dmlydGlvX3JpbmcgYW5kIHZyaW5naCB0byBzZWUgd2hvIGlzIG1p
c3NpbmcgdGhlIG1hcC4KPj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+SnVzdCBhbiB1cGRhdGUgYWJvdXQg
dGhlc2UgaXNzdWVzIHdpdGggdmRwYS1zaW0tYmxrLgo+Pj4+Pj5JJ3ZlIGJlZW4gZm9jdXNpbmcg
YSBsaXR0bGUgYml0IG9uIHRoZXNlIGZhaWx1cmVzIG92ZXIgdGhlIAo+Pj4+Pj5sYXN0IGZldyBk
YXlzIGFuZCBoYXZlIGZvdW5kIHR3byBpc3N1ZXMgcmVsYXRlZCB0byB0aGUgCj4+Pj4+PklPVExC
L0lPTU1VOgo+Pj4+Pj4KPj4+Pj4+MS4gU29tZSByZXF1ZXN0cyBjb21pbmcgZnJvbSB0aGUgYmxv
Y2sgbGF5ZXIgZmlsbHMgdGhlIFNHIAo+Pj4+Pj5saXN0IHdpdGggbXVsdGlwbGUgYnVmZmVycyB0
aGF0IGhhZCB0aGUgc2FtZSBwaHlzaWNhbCAKPj4+Pj4+YWRkcmVzcy4gVGhpcyBoYXBwZW5zIGZv
ciBleGFtcGxlIHdoaWxlIHVzaW5nICdta2ZzJywgYXQgCj4+Pj4+PnNvbWUgcG9pbnRzIG11bHRp
cGxlIHNlY3RvcnMgYXJlIHplcm9lZCBzbyBtdWx0aXBsZSBTRyAKPj4+Pj4+ZWxlbWVudHMgcG9p
bnQgdG8gdGhlIHNhbWUgcGh5c2ljYWwgcGFnZSB0aGF0IGlzIHplcm9lZC4KPj4+Pj4+U2luY2Ug
d2UgYXJlIHVzaW5nIHZob3N0X2lvdGxiX2RlbF9yYW5nZSgpIGluIHRoZSAKPj4+Pj4+dmRwYXNp
bV91bm1hcF9wYWdlKCksIHRoaXMgcmVtb3ZlcyBhbGwgdGhlIG92ZXJsYXBwZWQgCj4+Pj4+PnJh
bmdlcy4gSSBmaXhlZCByZW1vdmluZyBhIHNpbmdsZSBtYXAgaW4gCj4+Pj4+PnZkcGFzaW1fdW5t
YXBfcGFnZSgpLCBidXQgaGFzIGFuIGFsdGVybmF0aXZlIHdlIGNhbiAKPj4+Pj4+aW1wbGVtZW50
IHNvbWUga2luZCBvZiByZWZlcmVuY2UgY291bnRzLgo+Pj4+Pgo+Pj4+Pgo+Pj4+PkkgdGhpbmsg
d2UgbmVlZCB0byBkbyB3aGF0IGhhcmR3YXJlIGRvLiBTbyB1c2luZyByZWZjb3VudCBpcyAKPj4+
Pj5wcm9iYWJseSBub3QgYSBnb29kIGlkYS4KPj4+Pgo+Pj4+T2theSwgc28gc2luY2Ugd2UgYXJl
IHVzaW5nIGZvciBzaW1wbGljaXR5IGFuIGlkZW50aWNhbCBtYXBwaW5nLCAKPj4+PndlIGFyZSBh
c3NpZ25pbmcgdGhlIHNhbWUgZG1hX2FkZHIgdG8gbXVsdGlwbGUgcGFnZXMuCj4+Pgo+Pj4KPj4+
SSB0aGluayBJIGdldCB5b3Ugbm93LiBUaGF0J3MgdGhlIHJvb3QgY2F1c2UgZm9yIHRoZSBmYWls
dXJlLgo+Pgo+Plllcywgc29ycnksIEkgZGlkbid0IGV4cGxhaW4gd2VsbCBwcmV2aW91c2x5Lgo+
Pgo+Pj4KPj4+VGhlbiBJIHRoaW5rIHdlIG5lZWQgYW4gc2ltcGxlIGlvdmEgYWxsb2NhdG9yIGZv
ciB2ZHBhIHNpbXVsYXRvciwgCj4+PmFuZCBpdCBtaWdodCBiZSB1c2VmdWwgZm9yIFZEVVNFIGFz
IHdlbGwuCj4+Cj4+T2theSwgSSdsbCB3b3JrIG9uIGl0Lgo+PklmIHlvdSBoYXZlIGFuIGV4YW1w
bGUgdG8gZm9sbG93IG9yIHNvbWUgcG9pbnRlcnMsIHRoZXkgYXJlIHdlbGNvbWUgOi0pCj4KPgo+
S2VybmVsIGhhZCBpbXBsZW1lbnRlZCBvbmUgaW4gaW92YS5jIGJ1dCBJJ20gbm90IHN1cmUgd2Ug
bmVlZCB0aGUgCj5jb21wbGV4aXR5IGxpa2UgdGhhdC4gT3Igd2UgY2FuIGp1c3QgdXNlIHJidHJl
ZSBvciBpZHIgdG8gaW1wbGVtZW50IGEgCj5zaW1wbGVyIG9uZS4KClllYWgsIEkgZm91bmQgaXQg
YW5kIEkgc3RhcnRlZCB0byBpbnRlZ3JhdGUgaXQgaW4gdGhlIHNpbXVsYXRvci4KQWxzbyBpZiBp
dCBhcHBlYXJzIGNvbXBsaWNhdGVkLCBpdCBzZWFtcyB0byBtZSB0aGF0IGl0IHNob3VsZCBiZSBz
aW1wbGUgCnRvIGludGVncmF0ZS4KCkknbGwgZ2l2ZSBpdCBhIHRyeSwgYW5kIGlmIGl0IGlzIHRv
byBjb21wbGljYXRlLCBJJ2xsIHN3aXRjaCB0byBhIHNpbXBsZSAKcmJ0cmVlLgoKVGhhbmtzLApT
dGVmYW5vCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
