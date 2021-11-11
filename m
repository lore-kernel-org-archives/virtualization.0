Return-Path: <SRS0=fJjx=P6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEE8C433EF
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 15:20:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32CF610C8
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 15:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D32CF610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97E5F80F73;
	Thu, 11 Nov 2021 15:20:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KTfyzbPb3yfH; Thu, 11 Nov 2021 15:20:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 34B5180ED2;
	Thu, 11 Nov 2021 15:20:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AD7FC0020;
	Thu, 11 Nov 2021 15:20:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D353C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 15:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 725FD404E3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 15:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0auHtvF_QeSA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 15:19:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37EDB404D9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 15:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636643997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j2K10Q3RYJAYLzZSO7lPYSVevInAJlNcm48b9LQMpGM=;
 b=g3Sgyui6LVkYhoHH1EUHwrdgkSPgIhvZzZXoUAKviDGrBA76yqVj3ypB747G2p4bXYVi5B
 Tu0pRp8W+ArOhhXJ3wyr6ohIMEGFzQEpGj3wJjlFYsLEO+nSyux1U03UBQq83+evZXleGk
 9cfO8aqm6JO1UxrLO+9v3928Dh6Ax/4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-IT9Y75BKP_GeE-WmVgAjIA-1; Thu, 11 Nov 2021 10:19:55 -0500
X-MC-Unique: IT9Y75BKP_GeE-WmVgAjIA-1
Received: by mail-ed1-f70.google.com with SMTP id
 y20-20020a056402359400b003e28c9bc02cso5694868edc.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 07:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=j2K10Q3RYJAYLzZSO7lPYSVevInAJlNcm48b9LQMpGM=;
 b=6SxJVkf8FM8UQJFqYQZk5PNUiEsxrmj/N/d9d/tuDOXX/yzJlFI5n/UdSSr5WacSrL
 y5otcyz+eNixBnqhsfo0+ecPbd1Hrskycv1QYschuzI+a+FM0TT/SzQjKAkSgKinQOWM
 uRQVNBkDsZcVJ/s/+ygwLX21DZUngqeUUn1CC1b3gfxj4GfeHywlihPC/mmofqnfkMzw
 qCF/8ESBu4cwbzC4c6Oxn03MGPZTUn8w8Hv9HV05SiykdqLwX2+LuIKTPcJite086ZVd
 tM/d+dxCh6uUXWVH6HMV6LNGm3rHypKFBKx8M5hVsfCEgp21WGTwEevKmD8oj78mciLd
 ewxA==
X-Gm-Message-State: AOAM530e/1bnkCmrgiubdZRRk5atFOGXcXJmN1l4DGOSTwpVvm9dEdqM
 KIBP2fVMCUpC5wRuvApIPBKbVu5jBprMDwCYN+PqwMZudGRIKEDcn4LZFjOt4sQZ1Xheg+PSspk
 G9wQ6+P09qGjlKjXZXCC5irhWSMvRLFg4u9nJz7WSWQ==
X-Received: by 2002:a17:907:3daa:: with SMTP id
 he42mr10526827ejc.160.1636643993884; 
 Thu, 11 Nov 2021 07:19:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyX+KFReiwpzw5VrVHE+1osuTAa+gMpiHonwGnKiRCl72CA5QaAceNd1oRYUsyAX6jJQJbX+Q==
X-Received: by 2002:a17:907:3daa:: with SMTP id
 he42mr10526785ejc.160.1636643993635; 
 Thu, 11 Nov 2021 07:19:53 -0800 (PST)
Received: from redhat.com ([2.55.135.246])
 by smtp.gmail.com with ESMTPSA id d13sm1682608edv.29.2021.11.11.07.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Nov 2021 07:19:52 -0800 (PST)
Date: Thu, 11 Nov 2021 10:19:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: Re: [RFC] hypercall-vsock: add a new vsock transport
Message-ID: <20211111100414-mutt-send-email-mst@kernel.org>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
 <20211110054121-mutt-send-email-mst@kernel.org>
 <dcaf10bed215456ab689956275d4b998@intel.com>
MIME-Version: 1.0
In-Reply-To: <dcaf10bed215456ab689956275d4b998@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "srutherford@google.com" <srutherford@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "erdemaktas@google.com" <erdemaktas@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Kleen, Andi" <andi.kleen@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>
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

T24gVGh1LCBOb3YgMTEsIDIwMjEgYXQgMDc6NTg6MjlBTSArMDAwMCwgV2FuZywgV2VpIFcgd3Jv
dGU6Cj4gT24gV2VkbmVzZGF5LCBOb3ZlbWJlciAxMCwgMjAyMSA2OjUwIFBNLCBNaWNoYWVsIFMu
IFRzaXJraW4gd3JvdGU6Cj4gPiBPbiBXZWQsIE5vdiAxMCwgMjAyMSBhdCAwNzoxMjozNkFNICsw
MDAwLCBXYW5nLCBXZWkgVyB3cm90ZToKPiA+Cj4gPiBoeXBlcmNhbGxzIGFyZSBmdW5kYW1lbnRh
bGx5IGh5cGVydmlzb3IgZGVwZW5kZW50IHRob3VnaC4KPiAKPiBZZXMsIGVhY2ggaHlwZXJ2aXNv
ciBuZWVkcyB0byBzdXBwb3J0IGl0Lgo+IFdlIGNvdWxkIHNpbXBsaWZ5IHRoZSBkZXNpZ24gYW5k
IGltcGxlbWVudGF0aW9uIHRvIHRoZSBtaW5pbWFsLCBzbyB0aGF0IGVhY2ggaHlwZXJ2aXNvciBj
YW4gZWFzaWx5IHN1cHBvcnQgaXQuCj4gT25jZSBldmVyeSBoeXBlcnZpc29yIGhhcyB0aGUgc3Vw
cG9ydCwgdGhlIGd1ZXN0IChNaWdURCkgY291bGQgYmUgYSB1bmlmaWVkIHZlcnNpb24uCj4gKGUu
Zy4gbm8gbmVlZCBmb3IgZWFjaCBoeXBlcnZpc29yIHVzZXIgdG8gZGV2ZWxvcCB0aGVpciBvd24g
TWlnVEQgdXNpbmcgdGhlaXIgb3duIHZzb2NrIHRyYW5zcG9ydCkKPiAKPiA+IEFzc3VtaW5nIHlv
dSBjYW4gY2FydmUgdXAgYSBoeXBlcnZpc29yIGluZGVwZW5kZW50IGh5cGVyY2FsbCwgdXNpbmcg
aXQgZm9yCj4gPiBzb21ldGhpbmcgYXMgbXVuZGFuZSBhbmQgc3BlY2lmaWMgYXMgdnNvY2sgZm9y
IFREWCBzZWVtcyBsaWtlIGEgaHVnZSBvdmVya2lsbC4KPiA+IEZvciBleGFtcGxlLCB2aXJ0aW8g
Y291bGQgYmVuZWZpdCBmcm9tIGZhc3RlciB2bWV4aXRzIHRoYXQgaHlwZXJjYWxscyBnaXZlIHlv
dQo+ID4gZm9yIHNpZ25hbGxpbmcuCj4gPiBIb3cgYWJvdXQgYSBjb21iaW5hdGlvbiBvZiB2aXJ0
aW8tbW1pbyBhbmQgaHlwZXJjYWxscyBmb3IgZmFzdC1wYXRoIHNpZ25hbGxpbmcKPiA+IHRoZW4/
Cj4gCj4gV2UgdGhvdWdodCBhYm91dCB2aXJ0aW8tbW1pby4gVGhlcmUgYXJlIHNvbWUgYmFycmll
cnM6Cj4gMSkgSXQgd2Fzbid0IG9yaWdpbmFsbHkgaW50ZW5kZWQgZm9yIHg4NiBtYWNoaW5lcy4g
VGhlIG9ubHkgbWFjaGluZSB0eXBlIGluIFFFTVUKPiB0aGF0IHN1cHBvcnRzIGl0ICh0byBydW4g
b24geDg2KSBpcyBtaWNyb3ZtLiBCdXQgIm1pY3Jvdm0iIGRvZXNu4oCZdCBzdXBwb3J0IFREWCBj
dXJyZW50bHksCj4gYW5kIGFkZGluZyB0aGlzIHN1cHBvcnQgbWlnaHQgbmVlZCBsYXJnZXIgZWZm
b3J0Lgo+IDIpIEl0J3Mgc2ltcGxlciB0aGFuIHZpcnRpby1wY2ksIGJ1dCBzdGlsbCBtb3JlIGNv
bXBsZXggdGhhbiBoeXBlcmNhbGwuCj4gMykgU29tZSBDU1BzIGRvbid0IGhhdmUgdmlydGlvIHN1
cHBvcnQgaW4gdGhlaXIgc29mdHdhcmUsIHNvIHRoaXMgbWlnaHQgYWRkIHRvbyBtdWNoIGRldmVs
b3BtZW50IGVmZm9ydCBmb3IgdGhlbS4KPiAKPiBUaGlzIHVzYWdlIGRvZXNu4oCZdCBuZWVkIGhp
Z2ggcGVyZm9ybWFuY2UsIHNvIGZhc3RlciBoeXBlcmNhbGwgZm9yIHNpZ25hbGxpbmcgaXNuJ3Qg
cmVxdWlyZWQsIEkgdGhpbmsuCj4gKGJ1dCBpZiBoeXBlcmNhbGwgaGFzIGJlZW4gdmVyaWZpZWQg
dG8gYmUgbXVjaCBmYXN0ZXIgdGhhbiB0aGUgY3VycmVudCBFUFQgbWlzY29uZmlnIGJhc2VkIG5v
dGlmaWNhdGlvbiwKPiBpdCBjb3VsZCBiZSBhZGRlZCBmb3IgdGhlIGdlbmVyYWwgdmlydGlvIHVz
YWdlcykKPiAKPiA+IAo+ID4gPiAyKSAgICAgICBJdCBpcyBzaW1wbGVyLiBJdCBkb2VzbuKAmXQg
cmVseSBvbiBhbnkgY29tcGxleCBidXMgZW51bWVyYXRpb24KPiA+ID4KPiA+ID4gKGUuZy4gdmly
dGlvLXBjaSBiYXNlZCB2c29jayBkZXZpY2UgbWF5IG5lZWQgdGhlIHdob2xlIGltcGxlbWVudGF0
aW9uIG9mCj4gPiBQQ0kpLgo+ID4gPgo+ID4gCj4gPiBOZXh0IHRoaW5nIHBlb3BsZSB3aWxsIHRy
eSB0byBkbyBpcyBpbXBsZW1lbnQgYSBidW5jaCBvZiBvdGhlciBkZXZpY2Ugb24gdG9wIG9mCj4g
PiBpdC4gIHZpcnRpbyB1c2VkIHBjaSBzaW1wbHkgYmVjYXVzZSBldmVyeW9uZSBpbXBsZW1lbnRz
IHBjaS4gIEFuZCB0aGUgcmVhc29uCj4gPiBmb3IgKnRoYXQqIGlzIGJlY2F1c2UgaW1wbGVtZW50
aW5nIGEgYmFzaWMgcGNpIGJ1cyBpcyBkZWFkIHNpbXBsZSwgd2hvbGUgb2YKPiA+IHBjaS5jIGlu
IHFlbXUgaXMgPDMwMDAgTE9DLgo+IAo+IFRoaXMgZG9lc27igJl0IGluY2x1ZGUgdGhlIFBDSSBl
bnVtZXJhdGlvbiBpbiBzZWFCSU9TIGFuZCB0aGUgUENJIGRyaXZlciBpbiB0aGUgZ3Vlc3QgdGhv
dWdoLgoKRG8gd2UgcmVhbGx5IG5lZWQgdG8gd29ycnkgYWJvdXQgbWlncmF0aW5nIGd1ZXN0cyB0
aGF0IGRpZCBub3QgY29tcGxldGUKUENJIGVudW1lcmF0aW9uIHlldD8KCkFueXdheSwga3ZtIHVu
aXQgdGVzdCBoYXMgYSB+NTAwIExPQyBwY2kgZHJpdmVyLiAgSXQgZG9lcyBub3Qgc3VwcG9ydCBw
Y2kgYnJpZGdlcwpvciBpbnRlcnJ1cHRzIHRob3VnaCAtIGlmIHlvdSB3YW50IHRvIGRvIHRoYXQg
dGhlbiByZXF1aXJpbmcgdGhhdCB0aGUgZGV2aWNlIGluCnF1ZXN0aW9uIGlzIG9uIGJ1cyAwIGFu
ZCB1c2luZyBwb2xsaW5nIHNlZW1zIGxpa2UgYSByZWFzb25hYmxlIGxpbWl0YXRpb24/Cgo+IFZp
cnRpbyBoYXMgaGlnaCBwZXJmb3JtYW5jZSwgSSB0aGluayB0aGF0J3MgYW4gaW1wb3J0YW50IHJl
YXNvbiB0aGF0IG1vcmUgZGV2aWNlcyBhcmUgY29udGludWFsbHkgYWRkZWQuCj4gRm9yIHRoaXMg
dHJhbnNwb3J0LCBJIGNvdWxkbuKAmXQgZW52aXNpb24gdGhhdCBhIGJ1bmNoIG9mIGRldmljZXMg
d291bGQgYmUgYWRkZWQuIEl0J3MgYSBzaW1wbGUgUFYgbWV0aG9kLgoKRmFtb3VzIGxhc3Qgd29y
ZHMuIE15IHBvaW50IGlzIGFkZGluZyBhIHZlbmRvciBhZ25vc3RpYyBoeXBlcmNhbGwgbmVlZHMK
YSBidW5jaCBvZiBuZWdvdGlhdGlvbiBhbmQgYWdyZWVtZW50IGJldHdlZW4gdmVuZG9ycy4gSWYg
eW91IGFyZSBnb2luZwp0byBhbGwgdGhlIHRyb3VibGUsIGl0IHNlZW1zIGxpa2UgYSB3YXN0ZSB0
byBtYWtlIGl0IHNpbmdsZSB1c2UuCgo+IAo+ID4gCj4gPiA+Cj4gPiA+IEFuIGV4YW1wbGUgdXNh
Z2UgaXMgdGhlIGNvbW11bmljYXRpb24gYmV0d2VlbiBNaWdURCBhbmQgaG9zdCAoUGFnZSA4Cj4g
PiA+IGF0Cj4gPiA+Cj4gPiA+IGh0dHBzOi8vc3RhdGljLnNjaGVkLmNvbS9ob3N0ZWRfZmlsZXMv
a3ZtZm9ydW0yMDIxL2VmLwo+ID4gPiBURFglMjBMaXZlJTIwTWlncmF0aW9uX1dlaSUyMFdhbmcu
cGRmKS4KPiA+ID4KPiA+ID4gTWlnVEQgY29tbXVuaWNhdGVzIHRvIGhvc3QgdG8gYXNzaXN0IHRo
ZSBtaWdyYXRpb24gb2YgdGhlIHRhcmdldCAodXNlcikgVEQuCj4gPiA+Cj4gPiA+IE1pZ1REIGlz
IHBhcnQgb2YgdGhlIFRDQiwgc28gaXRzIGltcGxlbWVudGF0aW9uIGlzIGV4cGVjdGVkIHRvIGJl
IGFzCj4gPiA+IHNpbXBsZSBhcyBwb3NzaWJsZQo+ID4gPgo+ID4gPiAoZS5nLiBiYXJlIG1lbnRh
bCBpbXBsZW1lbnRhdGlvbiB3aXRob3V0IE9TLCBubyBQQ0kgZHJpdmVyIHN1cHBvcnQpLgo+ID4g
Pgo+ID4gPgo+ID4gCj4gPiBUcnkgdG8gbGlzdCBkcmF3YmFja3M/IEZvciBleGFtcGxlLCBwYXNz
dGhyb3VnaCBmb3IgbmVzdGVkIHZpcnQgaXNuJ3QgcG9zc2libGUKPiA+IHVubGlrZSBwY2ksIG5l
aXRoZXIgYXJlIGhhcmR3YXJlIGltcGxlbWVudGF0aW9ucy4KPiA+IAo+IAo+IFdoeSBoeXBlcmNh
bGwgd291bGRuJ3QgYmUgcG9zc2libGUgZm9yIG5lc3RlZCB2aXJ0Pwo+IEwyIGh5cGVyY2FsbCBn
b2VzIHRvIEwwIGRpcmVjdGx5IGFuZCBMMCBjYW4gZGVjaWRlIHdoZXRoZXIgdG8gZm9yd2FyZCB0
aGUgY2FsbCB0aGUgTDEgKGluIG91ciBjYXNlLCBJIHRoaW5rIG5vIG5lZWQgYXMgdGhlIHBhY2tl
dCB3aWxsIGdvIG91dCksIHJpZ2h0Pwo+IAo+IEl0cyBkcmF3YmFja3MgYXJlIG9idmlvdXMgKGUu
Zy4gbG93IHBlcmZvcm1hbmNlKS4gCgpFeGFjdGx5LgoKPiBJbiBnZW5lcmFsLCBJIHRoaW5rIGl0
IGNvdWxkIGJlIGNvbnNpZGVyZWQgYXMgYSBjb21wbGVtZW50IHRvIHZpcnRpby4KPiBJIHRoaW5r
IG1vc3QgdXNhZ2VzIHdvdWxkIGNob29zZSB2aXJ0aW8gYXMgdGhleSBkb27igJl0IHdvcnJ5IGFi
b3V0IHRoZSBjb21wbGV4aXR5IGFuZCB0aGV5IHB1cnNlIGhpZ2ggcGVyZm9ybWFuY2UuCj4gRm9y
IHNvbWUgc3BlY2lhbCB1c2FnZXMgdGhhdCB0aGluayB2aXJ0aW8gaXMgdG9vIGNvbXBsZXggdG8g
c3VmZmljZSBhbmQgdGhleSB3YW50IHNvbWV0aGluZyBzaW1wbGVyLCB0aGV5IHdvdWxkIGNvbnNp
ZGVyIHRvIHVzZSB0aGlzIHRyYW5zcG9ydOOAggo+IAo+IFRoYW5rcywKPiBXZWkKClNvIGltcGxl
bWVudCBhIHNtYWxsIHN1YnNldCBvZiB2aXJ0aW8gdGhlbiwgbm8gb25lIGZvcmNlcyB5b3UgdG8g
dXNlIGFsbAppdHMgZmVhdHVyZXMuIHZpcnRpbyBtbWlvIGlzIGFib3V0IDMwIHJlZ2lzdGVycywg
bW9zdCBjYW4gYmUgc3R1YmJlZCB0bwpjb25zdGFudHMuIHBhY2tlZCByaW5nIGlzIG11Y2ggc2lt
cGxlciB0aGFuIHNwbGl0IG9uZS4KCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
