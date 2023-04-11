Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5384FC76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 02:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEDE681EA0;
	Tue, 11 Apr 2023 02:10:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BEDE681EA0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S9uVv+uR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q2QgLwHlADRL; Tue, 11 Apr 2023 02:10:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 46E2881E9C;
	Tue, 11 Apr 2023 02:09:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46E2881E9C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 025A8C0037;
	Tue, 11 Apr 2023 02:09:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4238CC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 02:09:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06CEF408A0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 02:09:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06CEF408A0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=S9uVv+uR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WFLSvbfJsDg7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 02:09:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 716284089A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 716284089A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 02:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681178994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLtM+IOLvUhxnPTXuhcKwv8yhKehWKmppZ80LxOddYE=;
 b=S9uVv+uRgiN8L48Cy6hidAbJ8D0vQ3m6Ded1Pbo7SMSx85eER1Q+A9aSydGtda18Vb/qjN
 /HVng/V3uy2UchweDZg2OvvAJGxCqQeNYM5s9uhii1yS0f5UEegYDbc8u6AQ0ZapZhn7Q8
 f95xoi5ycbQLlEAQ5kP3EuGmh1AZiz0=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-ZaqAQ8hEMXWRKw_oNfkauQ-1; Mon, 10 Apr 2023 22:09:52 -0400
X-MC-Unique: ZaqAQ8hEMXWRKw_oNfkauQ-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1842d4a3112so4002657fac.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 19:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681178991; x=1683770991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rLtM+IOLvUhxnPTXuhcKwv8yhKehWKmppZ80LxOddYE=;
 b=5SmpHoQYLEdV7Bb5LyoXsKDzpr0fVOTuURTTHrnc7APeMQLXJ1Ud/zV9vjpzBldZA9
 MrA/a6V+nOHPDqlOnWV42aO0SODXQCV9yhrv1i5P58+OmCq6+Y5dlP8Z4Am1p8wq2YJW
 hctkjWyphoqup7YLzeM8f6Uvhd3a3BTXZe3RXcYmhmxgg3UevME/hWDcWJW1m8hCLRzP
 wPn3EmiTHEUU3qKejwhGae+nF+jX4Izc+iwwIXpsf9UQRM2TS01KWCrZcAEfmKF6EUkI
 c1cqvHPRLq5M07jjLi1DNIS0KdZ0FAaHO8ZpJHgSGH0DX0PIkuUV/JYdwTBZsYbZNmyE
 FZEg==
X-Gm-Message-State: AAQBX9fc6N1hEXn3txDGjxCTZRTWyOvVmBfAPvu3SGYxt7mYJ8qgcFTr
 D3n0MjRD5QWf1UnZCySEAm8E7KKQ5UURmfZrUC5sRIPeL1OJda/eNLUsCRDXt9DC4euiSzINqUI
 FnEyr4Rwyp4Ro+xzh69edgtWhvm3kqTnEFRHoMkQbkQjTYV6q5JSsSMJZCw==
X-Received: by 2002:a9d:6c01:0:b0:6a1:4c0e:1268 with SMTP id
 f1-20020a9d6c01000000b006a14c0e1268mr3297094otq.2.1681178991725; 
 Mon, 10 Apr 2023 19:09:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350YpjW/nWt+swt25BF2KFKqtEUqFzAmzHEqB8cB1nJzwKDCnHAnEezL6OVtpUpk1hYRXVTQEUw5o1vzrKn1R1uE=
X-Received: by 2002:a9d:6c01:0:b0:6a1:4c0e:1268 with SMTP id
 f1-20020a9d6c01000000b006a14c0e1268mr3297088otq.2.1681178991470; Mon, 10 Apr
 2023 19:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-9-xuanzhuo@linux.alibaba.com>
 <73a24f95-b779-44ac-be28-45b35d1bf540@roeck-us.net>
 <20230407064634-mutt-send-email-mst@kernel.org>
 <1681097397.338332-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
 <ZDQq0pDVkr8TvoTM@infradead.org>
 <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Apr 2023 10:09:40 +0800
Message-ID: <CACGkMEskNEwD0_AZgoDLS2RBv9cpbH5u1q01=cDuawV0NbhK_w@mail.gmail.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMTA6MDHigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgMTAgQXByIDIwMjMgMDg6Mjc6MTQg
LTA3MDAsIENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4gPiBP
biBNb24sIEFwciAxMCwgMjAyMyBhdCAwMToxNDoxM1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+ID4gPiA+IEJ1dCByZXRoaW5rLCB0aGlzIGlzIHVucmVsaWFibGUuIFNvbWUgcGxhdGZvcm1z
IGhhdmUgcmV0dXJuZWQgdGhlaXIgb3duIG9wcywKPiA+ID4gPiBpbmNsdWRpbmcgWDg2Lgo+ID4g
PiA+Cj4gPiA+ID4gQmVjYXVzZSB0aGUgcHJpb3JpdHkgb2YgZGV2LT5kbWFfb3BzIGlzIGhpZ2hl
ciB0aGFuIGdldF9hcmNoX2RtYV9vcHMoKSwgd2UKPiA+ID4gPiBzaG91bGQgbm90IGxldCBkZXYt
PmRtYV9vcHMgYmUgbnVsbC4gV2Ugc2hvdWxkIGRlZmluZSBhIHNldCBvZiBkbWFfb3BzIHRvCj4g
PiA+ID4gYWN0aXZlbHkgaW1wbGVtZW50IGRpcmVjdCBkTUEuCj4gPiA+Cj4gPiA+IFRoZW4gdGhp
cyB3aWxsIGR1cGxpY2F0ZSB3aXRoIGV4aXN0aW5nIERNQSBBUEkgaGVscGVycy4gQ291bGQgd2Ug
dHdlYWsKPiA+ID4gdGhlIHNwYXJjIG9yIGludHJvZHVjZSBhIG5ldyBmbGFnIGZvciB0aGUgZGV2
aWNlIHN0cnVjdHVyZSB0aGVuIHRoZQo+ID4gPiBETUEgQVBJIGtub3dzIGl0IG5lZWRzIHRvIHVz
ZSBkaXJlY3QgbWFwcGluZz8KPiA+ID4KPiA+ID4gQWRkaW5nIENocmlzdG9waCBmb3IgbW9yZSBj
b21tZW50cy4KPiA+Cj4gPiBDb2RlIG91dHNpZGUgb2YgdGhlIGNvcmUga2VybmVsL2RtYS8gY29k
ZSBoYXMgbm8gYnVzaW5lc3MgZG9pbmcKPiA+IGFueXRoaW5nIHdpdGggdGhlIGRtYV9vcHMuCj4K
PiBEbyB5b3UgbWVhbiB3ZSBzaG91bGQgbm90IGNoYW5nZSB0aGUgZG1hX29wcyBmcm9tIHRoZSBv
dXRzaWRlIG9mIHRoZSBjb3JlCj4ga2VybmVsL2RtYS8/Cj4KPiBIb3cgYWJvdXQgYWRkaW5nIG9u
ZSBuZXcgImRtYV9kaXJlY3QiIHRvIHN0cnVjdCBkZXZpdmU/Cj4KPiAtLS0gYS9pbmNsdWRlL2xp
bnV4L2RtYS1tYXAtb3BzLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L2RtYS1tYXAtb3BzLmgKPiBA
QCAtODgsNiArODgsOSBAQCBzdHJ1Y3QgZG1hX21hcF9vcHMgewo+Cj4gIHN0YXRpYyBpbmxpbmUg
Y29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpnZXRfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYp
Cj4gIHsKPiArICAgICAgIGlmIChkZXYtPmRtYV9kaXJlY3QpCj4gKyAgICAgICAgICAgICAgIHJl
dHVybiBOVUxMOwo+ICsKPiAgICAgICAgIGlmIChkZXYtPmRtYV9vcHMpCj4gICAgICAgICAgICAg
ICAgIHJldHVybiBkZXYtPmRtYV9vcHM7Cj4gICAgICAgICByZXR1cm4gZ2V0X2FyY2hfZG1hX29w
cygpOwo+Cj4KPiBUaGFua3MuCj4KPgo+Cj4gPiBXVEYgaXMgZ29pbmcgb24/CgpXZSB3YW50IHRv
IHN1cHBvcnQgQUZfWERQIGZvciB2aXJ0aW8tbmV0LiBJdCBtZWFucyBBRl9YRFAgbmVlZHMgdG8K
a25vdyB0aGUgZG1hIGRldmljZSB0byBwZXJmb3JtIERNQSBtYXBwaW5nLiBTbyB3ZSBpbnRyb2R1
Y2UgYSBoZWxwZXIKdG8gZXhwb3NlIHRoZSBkbWEgZGV2IG9mIHRoZSB2aXJ0aW8gZGV2aWNlLgoK
VGhpcyB3b3JrcyBmaW5lIGFzIGxvbmcgYXMgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGlzIG5l
Z290aWF0ZWQuIEJ1dAp3aGVuIGl0IGlzIG5vdCwgdGhlIHZpcnRpbyBkcml2ZXIgbmVlZHMgdG8g
dXNlIGEgcGh5c2ljYWwgYWRkcmVzcyBzbwp3ZSB3YW50IHRvIGV4cG9zZSB0aGUgdmlydGlvIGRl
dmljZSB3aXRob3V0IGRtYV9vcHMgaW4gdGhlIGhvcGUgdGhhdAppdCB3aWxsIGdvIGZvciBkaXJl
Y3QgbWFwcGluZyB3aGVyZSB0aGUgcGh5c2ljYWwgYWRkcmVzcyBpcyB1c2VkLiBCdXQKaXQgbWF5
IG5vdCB3b3JrIG9uIHNvbWUgc3BlY2lmaWMgc2V0dXBzIChhcmNoZXMgdGhhdCBhc3N1bWUgYW4g
SU9NTVUKb3IgaGF2ZSBhcmNoIGRtYSBvcHMpLgoKVGhhbmtzCgo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
