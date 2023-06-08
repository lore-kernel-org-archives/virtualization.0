Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FEFC7EE23
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 14:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E8CE614C8;
	Thu,  8 Jun 2023 14:47:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E8CE614C8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HSvYmOXF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vI64ozpEczEk; Thu,  8 Jun 2023 14:46:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 67F2A614C2;
	Thu,  8 Jun 2023 14:46:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 67F2A614C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E601C0037;
	Thu,  8 Jun 2023 14:46:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D8EDC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 14:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA14E41902
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 14:46:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA14E41902
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HSvYmOXF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gks4bgLsEzqW
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 14:46:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7CA82405BB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CA82405BB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 14:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686235614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzPWzeBSXLWcqJWUGgOyhtXDtzFvOKEEJL0THkxADz0=;
 b=HSvYmOXFarGGcQCiSuOHuoS05juzHtp9LfhgNsTuLIvVtZJrkdrcqnDP7dESJM5euynz75
 WbGyRORwIYVNA8gxfUqXK5Ayyi8uHdc77RBJBcBaXlae9kMdvbxDRL2D/lEUaLzCWNwKRn
 9Vnn9T+6swrfrs/GB3nnZfnqcI7ogMM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-4jjNnHAlN02eLC8pS0n1-Q-1; Thu, 08 Jun 2023 10:46:52 -0400
X-MC-Unique: 4jjNnHAlN02eLC8pS0n1-Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso313309f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 07:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686235611; x=1688827611;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BzPWzeBSXLWcqJWUGgOyhtXDtzFvOKEEJL0THkxADz0=;
 b=Y6WkIMNJPm1ESCO2o547cCSuaoTzHNln7YTJOQeZXku7Ocg+hsN66yZQqcLDzm41OH
 bQ9o+/pTlzNg0Zdvuvd06Ab4EVFmf2Vf44zEGM4iBG35h9Mk0w9kVKPyGyj9mQewziRc
 YiNZrB0jckpqj4v3H+WGpH0n+WX/XJNg5ZyAjLxcJylRYt+4ZGc5pHdpGjQSML8kkCPU
 lKrW9KTnIhlGvFuBS3Tugkdk292Cey0IL9TYT+4NU4v7Sbk0sHEpcaywpB7bGKfPwJj6
 rcQPkL/7ie4YeZ7fTs3kE0NPlKyrgce4BShQwcbmy9GcSS0iNI+J20MzLIk6+DqYHQPJ
 NJyQ==
X-Gm-Message-State: AC+VfDyhJ7GbEqdRuEVhUA/7OryYD/W4WgubBGDUr7yFVNd/i/o9X5LT
 EHe42SWs97ZDIlFSfg22d6L6Q5+kvk5IycOLISBp2vDbvMby/zd6gi7b8NfrB4GjIgu6p8o4kii
 Q8Co/PD4jN4CbosgZ0v/jPR1z9ftuvULV6cIGcVhw3g==
X-Received: by 2002:adf:fe04:0:b0:30e:59a2:42c0 with SMTP id
 n4-20020adffe04000000b0030e59a242c0mr5084592wrr.11.1686235610980; 
 Thu, 08 Jun 2023 07:46:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5AaVaor0HUixD1BUg6Pn4MIEMgyGeZdhps2oVA1MXS+5jSz/cuObFR1X7VxjaAY/mioTCApA==
X-Received: by 2002:adf:fe04:0:b0:30e:59a2:42c0 with SMTP id
 n4-20020adffe04000000b0030e59a242c0mr5084582wrr.11.1686235610632; 
 Thu, 08 Jun 2023 07:46:50 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 q2-20020adffec2000000b0030632833e74sm1810260wrs.11.2023.06.08.07.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 07:46:50 -0700 (PDT)
Date: Thu, 8 Jun 2023 10:46:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: virtio-blk: support completion batching for the IRQ path - failure
Message-ID: <20230608104537-mutt-send-email-mst@kernel.org>
References: <BN9PR11MB53545DD1516BFA0FB23F95458353A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <CAFNWusa7goyDs1HaMVYDvvXT7ePfB7cAQt3EewT+t=-kKNf5eg@mail.gmail.com>
 <BN9PR11MB535433DFB3A1CFAD097C13278353A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <BN9PR11MB53545EDF64FC43EF8854D0628350A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <CAFNWusbOKhZtVBRu88Ebo3=Cv9rdsX2aAf6_5hfnge=iryR3DQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFNWusbOKhZtVBRu88Ebo3=Cv9rdsX2aAf6_5hfnge=iryR3DQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, "Roberts, Martin" <martin.roberts@intel.com>,
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

T24gVGh1LCBKdW4gMDgsIDIwMjMgYXQgMTE6MDc6MjFQTSArMDkwMCwgU3V3YW4gS2ltIHdyb3Rl
Ogo+IE9uIFRodSwgSnVuIDgsIDIwMjMgYXQgNzoxNuKAr1BNIFJvYmVydHMsIE1hcnRpbiA8bWFy
dGluLnJvYmVydHNAaW50ZWwuY29tPiB3cm90ZToKPiA+Cj4gPiBUaGUgcnFfYWZmaW5pdHkgY2hh
bmdlIGRvZXMgbm90IHJlc29sdmUgdGhlIGlzc3VlOyBqdXN0IHJlZHVjZXMgaXRzIG9jY3VycmVu
Y2UgcmF0ZTsgSSBhbSBzdGlsbCBzZWVpbmcgaGFuZ3Mgd2l0aCBpdCBzZXQgdG8gMi4KPiA+Cj4g
PiBNYXJ0aW4KPiA+Cj4gPgo+ID4KPiA+IEZyb206IFJvYmVydHMsIE1hcnRpbgo+ID4gU2VudDog
V2VkbmVzZGF5LCBKdW5lIDcsIDIwMjMgMzo0NiBQTQo+ID4gVG86IFN1d2FuIEtpbSA8c3V3YW4u
a2ltMDI3QGdtYWlsLmNvbT4KPiA+IENjOiBtc3RAcmVkaGF0LmNvbTsgdmlydHVhbGl6YXRpb24g
PHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnPjsgbGludXgtYmxvY2tA
dmdlci5rZXJuZWwub3JnCj4gPiBTdWJqZWN0OiBSRTogdmlydGlvLWJsazogc3VwcG9ydCBjb21w
bGV0aW9uIGJhdGNoaW5nIGZvciB0aGUgSVJRIHBhdGggLSBmYWlsdXJlCj4gPgo+ID4KPiA+Cj4g
PiBJdCBpcyB0aGUgY2hhbmdlIGluZGljYXRlZCB0aGF0IGJyZWFrcyBpdCAtIGNoYW5naW5nIHRo
ZSBJUlEgaGFuZGxpbmcgdG8gYmF0Y2hpbmcuCj4gPgo+ID4KPiA+Cj4gPgo+ID4KPiA+Cj4gPgo+
ID4gRnJvbSByZXBvcnRzIHN1Y2ggYXMsCj4gPgo+ID4gW1BBVENIIDEvMV0gYmxrLW1xOiBhZGRl
ZCBjYXNlIGZvciBjcHUgb2ZmbGluZSBkdXJpbmcgc2VuZF9pcGkgaW4gcnFfY29tcGxldGUgKGtl
cm5lbC5vcmcpCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDkyOTAzMzQyOC4y
NTk0OC0xLW1qMDEyMy5sZWVAc2Ftc3VuZy5jb20vVC8KPiA+Cj4gPiBbUkZDXSBibGstbXE6IERv
bid0IElQSSByZXF1ZXN0cyBvbiBQUkVFTVBUX1JUIC0gUGF0Y2h3b3JrIChsaW5hcm8ub3JnKQo+
IGh0dHBzOi8vcGF0Y2hlcy5saW5hcm8ub3JnL3Byb2plY3QvbGludXgtcnQtdXNlcnMvcGF0Y2gv
MjAyMDEwMjMxMTA0MDAuYngzdXpzYjd4eTVqdHNlYUBsaW51dHJvbml4LmRlLwo+ID4KPiA+Cj4g
Pgo+ID4gSeKAmW0gdGhpbmtpbmcgdGhlIGlzc3VlIGhhcyBzb21ldGhpbmcgdG8gZG8gd2l0aCB3
aGljaCBDUFUgdGhlIElSUSBpcyBydW5uaW5nIG9uLgo+ID4KPiA+Cj4gPgo+ID4gU28sIEkgc2V0
LAo+ID4KPiA+ICMgZWNobyAyID4gL3N5cy9ibG9jay92ZGEvcXVldWUvcnFfYWZmaW5pdHkKPiA+
Cj4gPiAjIGVjaG8gMiA+IC9zeXMvYmxvY2svdmRiL3F1ZXVlL3JxX2FmZmluaXR5Cj4gPgo+ID4g
4oCmCj4gPgo+ID4gIyBlY2hvIDIgPiAvc3lzL2Jsb2NrL3ZkcC9xdWV1ZS9ycV9hZmZpbml0eQo+
ID4KPiA+Cj4gPgo+ID4KPiA+Cj4gPiBhbmQgdGhlIHN5c3RlbSAocnVubmluZyAxNiBkaXNrcywg
NCBxdWV1ZXMvZGlzaykgaGFzIG5vdCB5ZXQgaHVuZyAocnVubmluZyBPSyBmb3Igc2V2ZXJhbCBo
b3VycynigKYKPiA+Cj4gPgo+ID4KPiA+IE1hcnRpbgo+ID4KPiAKPiBIaSBNYXJ0aW4sCj4gCj4g
Qm90aCBjb2RlcyAob3JpZ2luYWwgY29kZSBhbmQgeW91ciBzaW1wbGUgcGF0aCkgZXhlY3V0ZQo+
IGJsa19tcV9jb21wbGV0ZV9zZW5kX2lwaSgpCj4gYXQgYmxrX21xX2NvbXBsZXRlX3JlcXVlc3Rf
cmVtb3RlKCkuIFNvIG1heWJlIG1pc3NpbmcgcmVxdWVzdCBjb21wbGV0aW9uCj4gb24gb3RoZXIg
dkNQVSBpcyBub3QgdGhlIGNhdXNlLi4uCj4gCj4gVGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUg
b3JpZ2luYWwgY29kZSBhbmQgeW91ciBzaW1wbGUgcGF0aCBpcyB0aGF0Cj4gdGhlIG9yaWdpbmFs
IGNvZGUgY2FsbHMgYmxrX21xX2VuZF9yZXF1ZXN0X2JhdGNoKCkgYXQgdmlydGJsa19kb25lKCkK
PiB0byBwcm9jZXNzIHJlcXVlc3QgYXQgYmxvY2sgbGF5ZXIKPiBhbmQgeW91ciBjb2RlIGNhbGxz
IGJsa19tcV9lbmRfcmVxdWVzdCgpIGF0IHZpcnRibGtfZG9uZSgpIHRvIGRvIHNhbWUgdGhpbmcu
Cj4gCj4gVGhlIG9yaWdpbmFsIGNvZGUgOgo+IHZpcnRibGtfaGFuZGxlX3JlcSgpIGZpcnN0IGNv
bGxlY3RzIGFsbCByZXF1ZXN0cyBmcm9tIHZpcnRxdWV1ZSBpbiB3aGlsZSBsb29wCj4gYW5kIHBh
c3MgaXQgdG8gYmxrX21xX2VuZF9yZXF1ZXN0X2JhdGNoKCkgYXQgb25jZQo+IAo+IFlvdXIgc2lt
cGxlIHBhdGg6Cj4gdmlydGJsa19oYW5kbGVfcmVxKCkgZ2V0IHNpbmdsZSByZXF1ZXN0IGZyb20g
dmlydHF1ZXVlIGFuZCBwYXNzIGl0IHRvCj4gYmxrX21xX2VuZF9yZXF1ZXN0KCkgYW5kIGRvIGl0
IGFnYWluIGluIHdoaWxlIGxvb3AgdW50aWwgdGhlcmUgaW4gbm8gcmVxdWVzdAo+IGluIHZpcnRx
dWV1ZQo+IAo+IAo+IEkgdGhpbmsgd2UgbmVlZCB0byBmb2N1cyBvbiB0aGUgZGlmZmVyZW5jZSBi
ZXR3ZWVuIGJsa19tcV9lbmRfcmVxdWVzdCgpCj4gYW5kIGJsa19tcV9lbmRfcmVxdWVzdF9iYXRj
aCgpCj4gCj4gUmVnYXJkcywKPiBTdXdhbiBLaW0KPiAKClllcyBidXQgbGludXggcmVsZWFzZSBp
cyBpbW1pbmVudCBhbmQgcmVncmVzc2lvbnMgYXJlIGJhZC4KV2hhdCBkbyB5b3Ugc3VnZ2VzdCBm
b3Igbm93PyBJZiB0aGVyZSdzIG5vIGJldHRlciBpZGVhCkknbGwgc2VuZCBhIHJldmVydCBwYXRj
aCBhbmQgd2UnbGwgc2VlIGluIHRoZSBuZXh0IGxpbnV4IHZlcnNpb24uCgoKPiAKPiAKPiA+Cj4g
Pgo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+IEZyb206IFN1d2FuIEtpbSA8c3V3
YW4ua2ltMDI3QGdtYWlsLmNvbT4KPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSA3LCAyMDIzIDM6
MjEgUE0KPiA+IFRvOiBSb2JlcnRzLCBNYXJ0aW4gPG1hcnRpbi5yb2JlcnRzQGludGVsLmNvbT4K
PiA+IENjOiBtc3RAcmVkaGF0LmNvbTsgdmlydHVhbGl6YXRpb24gPHZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnPjsgbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnCj4g
PiBTdWJqZWN0OiBSZTogdmlydGlvLWJsazogc3VwcG9ydCBjb21wbGV0aW9uIGJhdGNoaW5nIGZv
ciB0aGUgSVJRIHBhdGggLSBmYWlsdXJlCj4gPgo+ID4KPiA+Cj4gPiBPbiBXZWQsIEp1biA3LCAy
MDIzIGF0IDY6MTTigK9QTSBSb2JlcnRzLCBNYXJ0aW4gPG1hcnRpbi5yb2JlcnRzQGludGVsLmNv
bT4gd3JvdGU6Cj4gPgo+ID4gPgo+ID4KPiA+ID4gUmU6IHZpcnRpby1ibGs6IHN1cHBvcnQgY29t
cGxldGlvbiBiYXRjaGluZyBmb3IgdGhlIElSUSBwYXRoIMK3IHRvcnZhbGRzL2xpbnV4QDA3YjY3
OWYgwrcgR2l0SHViCj4gPgo+ID4gPgo+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogU3V3YW4gS2lt
IHN1d2FuLmtpbTAyN0BnbWFpbC5jb20KPiA+Cj4gPiA+Cj4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBNaWNoYWVsIFMuIFRzaXJraW4gbXN0QHJlZGhhdC5jb20KPiA+Cj4gPiA+Cj4gPgo+ID4gPgo+
ID4KPiA+ID4KPiA+Cj4gPiA+Cj4gPgo+ID4gPgo+ID4KPiA+ID4gVGhpcyBjaGFuZ2UgYXBwZWFy
cyB0byBoYXZlIGJyb2tlbiB0aGluZ3PigKYKPiA+Cj4gPiA+Cj4gPgo+ID4gPiBXZSBub3cgc2Vl
IGFwcGxpY2F0aW9ucyBoYW5naW5nIGR1cmluZyBkaXNrIGFjY2Vzc2VzLgo+ID4KPiA+ID4KPiA+
Cj4gPiA+IGUuZy4KPiA+Cj4gPiA+Cj4gPgo+ID4gPiBtdWx0aS1wb3J0IHZpcnRpby1ibGsgZGV2
aWNlIHJ1bm5pbmcgaW4gaC93IChGUEdBKQo+ID4KPiA+ID4KPiA+Cj4gPiA+IEhvc3QgcnVubmlu
ZyBhIHNpbXBsZSDigJhmaW/igJggdGVzdC4KPiA+Cj4gPiA+Cj4gPgo+ID4gPiBbZ2xvYmFsXQo+
ID4KPiA+ID4KPiA+Cj4gPiA+IHRocmVhZD0xCj4gPgo+ID4gPgo+ID4KPiA+ID4gZGlyZWN0PTEK
PiA+Cj4gPiA+Cj4gPgo+ID4gPiBpb2VuZ2luZT1saWJhaW8KPiA+Cj4gPiA+Cj4gPgo+ID4gPiBu
b3JhbmRvbW1hcD0xCj4gPgo+ID4gPgo+ID4KPiA+ID4gZ3JvdXBfcmVwb3J0aW5nPTEKPiA+Cj4g
PiA+Cj4gPgo+ID4gPiBicz00Swo+ID4KPiA+ID4KPiA+Cj4gPiA+IHJ3PXJlYWQKPiA+Cj4gPiA+
Cj4gPgo+ID4gPiBpb2RlcHRoPTEyOAo+ID4KPiA+ID4KPiA+Cj4gPiA+IHJ1bnRpbWU9MQo+ID4K
PiA+ID4KPiA+Cj4gPiA+IG51bWpvYnM9NAo+ID4KPiA+ID4KPiA+Cj4gPiA+IHRpbWVfYmFzZWQK
PiA+Cj4gPiA+Cj4gPgo+ID4gPiBbam9iMF0KPiA+Cj4gPiA+Cj4gPgo+ID4gPiBmaWxlbmFtZT0v
ZGV2L3ZkYQo+ID4KPiA+ID4KPiA+Cj4gPiA+IFtqb2IxXQo+ID4KPiA+ID4KPiA+Cj4gPiA+IGZp
bGVuYW1lPS9kZXYvdmRiCj4gPgo+ID4gPgo+ID4KPiA+ID4gW2pvYjJdCj4gPgo+ID4gPgo+ID4K
PiA+ID4gZmlsZW5hbWU9L2Rldi92ZGMKPiA+Cj4gPiA+Cj4gPgo+ID4gPiAuLi4KPiA+Cj4gPiA+
Cj4gPgo+ID4gPiBbam9iMTVdCj4gPgo+ID4gPgo+ID4KPiA+ID4gZmlsZW5hbWU9L2Rldi92ZHAK
PiA+Cj4gPiA+Cj4gPgo+ID4gPgo+ID4KPiA+ID4KPiA+Cj4gPiA+IGkuZS4gMTYgZGlza3M7IDQg
cXVldWVzIHBlciBkaXNrOyBzaW1wbGUgYnVyc3Qgb2YgNEtCIHJlYWRzCj4gPgo+ID4gPgo+ID4K
PiA+ID4gVGhpcyBpcyByZXBlYXRlZGx5IHJ1biBpbiBhIGxvb3AuCj4gPgo+ID4gPgo+ID4KPiA+
ID4KPiA+Cj4gPiA+Cj4gPgo+ID4gPiBBZnRlciBhIGZldywgbm9ybWFsbHkgPDEwIHNlY29uZHMs
IGZpbyBoYW5ncy4KPiA+Cj4gPiA+Cj4gPgo+ID4gPiBXaXRoIDY0IHF1ZXVlcyAoMTYgZGlza3Mp
LCBmYWlsdXJlIG9jY3VycyB3aXRoaW4gYSBmZXcgc2Vjb25kczsgd2l0aCA4IHF1ZXVlcyAoMiBk
aXNrcykgaXQgbWF5IHRha2UgfmhvdXIgYmVmb3JlIGhhbmdpbmcuCj4gPgo+ID4gPgo+ID4KPiA+
ID4gTGFzdCBtZXNzYWdlOgo+ID4KPiA+ID4KPiA+Cj4gPiA+IGZpby0zLjE5Cj4gPgo+ID4gPgo+
ID4KPiA+ID4gU3RhcnRpbmcgOCB0aHJlYWRzCj4gPgo+ID4gPgo+ID4KPiA+ID4gSm9iczogMSAo
Zj0xKTogW18oNyksUigxKV1bNjguMyVdW2V0YSAwM2g6MTFtOjA2c10KPiA+Cj4gPiA+Cj4gPgo+
ID4gPiBJIHRoaW5rIHRoaXMgbWVhbnMgYXQgdGhlIGVuZCBvZiB0aGUgcnVuIDEgcXVldWUgd2Fz
IGxlZnQgaW5jb21wbGV0ZS4KPiA+Cj4gPiA+Cj4gPgo+ID4gPgo+ID4KPiA+ID4KPiA+Cj4gPiA+
IOKAmGRpc2tzdGF0c+KAmSAocnVuIHdoaWxlIGZpbyBpcyBodW5nKSBzaG93cyBubyBvdXRzdGFu
ZGluZyB0cmFuc2FjdGlvbnMuCj4gPgo+ID4gPgo+ID4KPiA+ID4gZS5nLgo+ID4KPiA+ID4KPiA+
Cj4gPiA+ICQgY2F0IC9wcm9jL2Rpc2tzdGF0cwo+ID4KPiA+ID4KPiA+Cj4gPiA+IC4uLgo+ID4K
PiA+ID4KPiA+Cj4gPiA+IDI1MiAgICAgICAwIHZkYSAxODQzMTQwMDcxIDAgMTQ3NDUxMjA1Njgg
NzEyNTY4NjQ1IDAgMCAwIDAgMCAzMTE3OTQ3IDcxMjU2ODY0NSAwIDAgMCAwIDAgMAo+ID4KPiA+
ID4KPiA+Cj4gPiA+IDI1MiAgICAgIDE2IHZkYiAxODE2MjkxNTExIDAgMTQ1MzAzMzIwODggNzA0
OTA1NjIzIDAgMCAwIDAgMCAzMTE3NzExIDcwNDkwNTYyMyAwIDAgMCAwIDAgMAo+ID4KPiA+ID4K
PiA+Cj4gPiA+IC4uLgo+ID4KPiA+ID4KPiA+Cj4gPiA+Cj4gPgo+ID4gPgo+ID4KPiA+ID4gT3Ro
ZXIgc3RhdHMgKGluIHRoZSBoL3csIGFuZCBhZGRlZCB0byB0aGUgdmlydGlvLWJsayBkcml2ZXIg
KFthXXZpcnRpb19xdWV1ZV9ycSgpLCBbYl12aXJ0YmxrX2hhbmRsZV9yZXEoKSwgW2NddmlydGJs
a19yZXF1ZXN0X2RvbmUoKSkgYWxsIGFncmVlLCBhbmQgc2hvdyBldmVyeSByZXF1ZXN0IGhhZCBh
IGNvbXBsZXRpb24sIGFuZCB0aGF0IHZpcnRibGtfcmVxdWVzdF9kb25lKCkgbmV2ZXIgZ2V0cyBj
YWxsZWQuCj4gPgo+ID4gPgo+ID4KPiA+ID4gZS5nLgo+ID4KPiA+ID4KPiA+Cj4gPiA+IFBGPSAw
ICAgICAgICAgICAgICAgICAgICAgICAgIHZxPTAgICAgICAgICAgIDEgICAgICAgICAgIDIgICAg
ICAgICAgIDMKPiA+Cj4gPiA+Cj4gPgo+ID4gPiBbYV1yZXF1ZXN0X2NvdW50ICAgICAtICAgODM5
NDE2NTkwICAgODEzMTQ4OTE2ICAgMTA1NTg2MTc5ICAgIDg0OTg4MTIzCj4gPgo+ID4gPgo+ID4K
PiA+ID4gW2JdY29tcGxldGlvbjFfY291bnQgLSAgIDgzOTQxNjU5MCAgIDgxMzE0ODkxNiAgIDEw
NTU4NjE3OSAgICA4NDk4ODEyMwo+ID4KPiA+ID4KPiA+Cj4gPiA+IFtjXWNvbXBsZXRpb24yX2Nv
dW50IC0gICAgICAgICAgIDAgICAgICAgICAgIDAgICAgICAgICAgIDAgICAgICAgICAgIDAKPiA+
Cj4gPiA+Cj4gPgo+ID4gPgo+ID4KPiA+ID4KPiA+Cj4gPiA+IFBGPSAxICAgICAgICAgICAgICAg
ICAgICAgICAgIHZxPTAgICAgICAgICAgIDEgICAgICAgICAgIDIgICAgICAgICAgIDMKPiA+Cj4g
PiA+Cj4gPgo+ID4gPiBbYV1yZXF1ZXN0X2NvdW50ICAgICAtICAgODIzMzM1ODg3ICAgODEyNTE2
MTQwICAgMTA0NTgyNjcyICAgIDc1ODU2NTQ5Cj4gPgo+ID4gPgo+ID4KPiA+ID4gW2JdY29tcGxl
dGlvbjFfY291bnQgLSAgIDgyMzMzNTg4NyAgIDgxMjUxNjE0MCAgIDEwNDU4MjY3MiAgICA3NTg1
NjU0OQo+ID4KPiA+ID4KPiA+Cj4gPiA+IFtjXWNvbXBsZXRpb24yX2NvdW50IC0gICAgICAgICAg
IDAgICAgICAgICAgIDAgICAgICAgICAgIDAgICAgICAgICAgIDAKPiA+Cj4gPiA+Cj4gPgo+ID4g
Pgo+ID4KPiA+ID4KPiA+Cj4gPiA+IGkuZS4gdGhlIGlzc3VlIGlzIGFmdGVyIHRoZSB2aXJ0aW8t
YmxrIGRyaXZlci4KPiA+Cj4gPiA+Cj4gPgo+ID4gPgo+ID4KPiA+ID4KPiA+Cj4gPiA+Cj4gPgo+
ID4gPgo+ID4KPiA+ID4gVGhpcyBjaGFuZ2Ugd2FzIGludHJvZHVjZWQgaW4ga2VybmVsIDYuMy4w
Lgo+ID4KPiA+ID4KPiA+Cj4gPiA+IEkgYW0gc2VlaW5nIHRoaXMgdXNpbmcgNi4zLjMuCj4gPgo+
ID4gPgo+ID4KPiA+ID4gSWYgSSBydW4gd2l0aCBhbiBlYXJsaWVyIGtlcm5lbCAoNS4xNSksIGl0
IGRvZXMgbm90IG9jY3VyLgo+ID4KPiA+ID4KPiA+Cj4gPiA+IElmIEkgbWFrZSBhIHNpbXBsZSBw
YXRjaCB0byB0aGUgNi4zLjMgdmlydGlvLWJsayBkcml2ZXIsIHRvIHNraXAgdGhlIGJsa19tcV9h
ZGRfdG9fYmF0Y2goKWNhbGwsIGl0IGRvZXMgbm90IGZhaWwuCj4gPgo+ID4gPgo+ID4KPiA+ID4g
ZS5nLgo+ID4KPiA+ID4KPiA+Cj4gPiA+IGtlcm5lbCA1LjE1IOKAkyB0aGlzIGlzIE9LCj4gPgo+
ID4gPgo+ID4KPiA+ID4gdmlydGlvX2Jsay5jLHZpcnRibGtfZG9uZSgpIFtpcnEgaGFuZGxlcl0K
PiA+Cj4gPiA+Cj4gPgo+ID4gPiAgICAgICAgICAgICAgICAgIGlmIChsaWtlbHkoIWJsa19zaG91
bGRfZmFrZV90aW1lb3V0KHJlcS0+cSkpKSB7Cj4gPgo+ID4gPgo+ID4KPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICBibGtfbXFfY29tcGxldGVfcmVxdWVzdChyZXEpOwo+ID4KPiA+ID4K
PiA+Cj4gPiA+ICAgICAgICAgICAgICAgICAgfQo+ID4KPiA+ID4KPiA+Cj4gPiA+Cj4gPgo+ID4g
Pgo+ID4KPiA+ID4ga2VybmVsIDYuMy4zIOKAkyB0aGlzIGZhaWxzCj4gPgo+ID4gPgo+ID4KPiA+
ID4gdmlydGlvX2Jsay5jLHZpcnRibGtfaGFuZGxlX3JlcSgpIFtpcnEgaGFuZGxlcl0KPiA+Cj4g
PiA+Cj4gPgo+ID4gPiAgICAgICAgICAgICAgICAgIGlmIChsaWtlbHkoIWJsa19zaG91bGRfZmFr
ZV90aW1lb3V0KHJlcS0+cSkpKSB7Cj4gPgo+ID4gPgo+ID4KPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICBpZiAoIWJsa19tcV9jb21wbGV0ZV9yZXF1ZXN0X3JlbW90ZShyZXEpKSB7Cj4g
Pgo+ID4gPgo+ID4KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICgh
YmxrX21xX2FkZF90b19iYXRjaChyZXEsIGlvYiwgdmlydGJsa192YnJfc3RhdHVzKHZiciksIHZp
cnRibGtfY29tcGxldGVfYmF0Y2gpKSB7Cj4gPgo+ID4gPgo+ID4KPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRibGtfcmVxdWVzdF9kb25lKHJlcSk7
ICAgIC8vdGhpcyBuZXZlciBnZXRzIGNhbGxlZC4uLiBzbyBibGtfbXFfYWRkX3RvX2JhdGNoKCkg
bXVzdCBhbHdheXMgc3VjY2VlZAo+ID4KPiA+ID4KPiA+Cj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfQo+ID4KPiA+ID4KPiA+Cj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfQo+ID4KPiA+ID4KPiA+Cj4gPiA+ICAgICAgICAgICAgICAgICAgfQo+ID4KPiA+
ID4KPiA+Cj4gPiA+Cj4gPgo+ID4gPgo+ID4KPiA+ID4gSWYgSSBkbywga2VybmVsIDYuMy4zIOKA
kyB0aGlzIGlzIE9LCj4gPgo+ID4gPgo+ID4KPiA+ID4gdmlydGlvX2Jsay5jLHZpcnRibGtfaGFu
ZGxlX3JlcSgpIFtpcnEgaGFuZGxlcl0KPiA+Cj4gPiA+Cj4gPgo+ID4gPiAgICAgICAgICAgICAg
ICAgIGlmIChsaWtlbHkoIWJsa19zaG91bGRfZmFrZV90aW1lb3V0KHJlcS0+cSkpKSB7Cj4gPgo+
ID4gPgo+ID4KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIWJsa19tcV9jb21w
bGV0ZV9yZXF1ZXN0X3JlbW90ZShyZXEpKSB7Cj4gPgo+ID4gPgo+ID4KPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0YmxrX3JlcXVlc3RfZG9uZShyZXEpOyAvL2Zv
cmNlIHRoaXMgaGVyZS4uLgo+ID4KPiA+ID4KPiA+Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpZiAoIWJsa19tcV9hZGRfdG9fYmF0Y2gocmVxLCBpb2IsIHZpcnRibGtf
dmJyX3N0YXR1cyh2YnIpLCB2aXJ0YmxrX2NvbXBsZXRlX2JhdGNoKSkgewo+ID4KPiA+ID4KPiA+
Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0Ymxr
X3JlcXVlc3RfZG9uZShyZXEpOyAgICAvL3RoaXMgbmV2ZXIgZ2V0cyBjYWxsZWQuLi4gc28gYmxr
X21xX2FkZF90b19iYXRjaCgpIG11c3QgYWx3YXlzIHN1Y2NlZWQKPiA+Cj4gPiA+Cj4gPgo+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiA+Cj4gPiA+Cj4gPgo+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiA+Cj4gPiA+Cj4gPgo+ID4gPiAgICAgICAg
ICAgICAgICAgIH0KPiA+Cj4gPiA+Cj4gPgo+ID4gPgo+ID4KPiA+ID4KPiA+Cj4gPiA+Cj4gPgo+
ID4gPgo+ID4KPiA+ID4gUGVyaGFwcyB5b3UgbWlnaHQgbGlrZSB0byBmaXgvdGVzdC9yZXZlcnQg
dGhpcyBjaGFuZ2XigKYKPiA+Cj4gPiA+Cj4gPgo+ID4gPiBNYXJ0aW4KPiA+Cj4gPiA+Cj4gPgo+
ID4gPgo+ID4KPiA+Cj4gPgo+ID4gSGkgTWFydGluLAo+ID4KPiA+Cj4gPgo+ID4gVGhlcmUgYXJl
IG1hbnkgY2hhbmdlcyBiZXR3ZWVuIDYuMy4wIGFuZCA2LjMuMy4KPiA+Cj4gPiBDb3VsZCB5b3Ug
dHJ5IHRvIGZpbmQgYSBjb21taXQgd2hpY2ggdHJpZ2dlcnMgdGhlIGlvIGhhbmc/Cj4gPgo+ID4g
SXMgaXQgb2sgd2l0aCA2LjMuMCBrZXJuZWwgb3Igd2l0aCByZXZlcnRpbmcKPiA+Cj4gPiAidmly
dGlvLWJsazogc3VwcG9ydCBjb21wbGV0aW9uIGJhdGNoaW5nIGZvciB0aGUgSVJRIHBhdGgiIGNv
bW1pdD8KPiA+Cj4gPgo+ID4KPiA+IFdlIG5lZWQgdG8gY29uZmlybSB3aGljaCBjb21taXQgaXMg
Y2F1c2luZyB0aGUgZXJyb3IuCj4gPgo+ID4KPiA+Cj4gPiBSZWdhcmRzLAo+ID4KPiA+IFN1d2Fu
IEtpbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
