Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B678C7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 03:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8C8281FD8;
	Tue, 11 Apr 2023 03:57:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8C8281FD8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PQLpbuZR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kCCtfsuOUl8j; Tue, 11 Apr 2023 03:57:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3573581F8F;
	Tue, 11 Apr 2023 03:57:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3573581F8F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD191C0036;
	Tue, 11 Apr 2023 03:57:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36562C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 043A781F92
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:57:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 043A781F92
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j_LF-8ffAKhm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:57:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95B6581F89
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95B6581F89
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681185421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dN6RiC/Xwm8NKvjIcSNOj4yk0tbo6PAAB47I+tLkOKo=;
 b=PQLpbuZR2rbfXFqwYa/THfAIZ6guO7YjPt6SzvhqBWugohvDm/NzwiESiSezdaDPjcVk9V
 WPSsmxfu7U9JMtgKQs38+n+WKk4BH3B+ThKcEODe6MdWGy9cQ3Jn/y0ntZhEmMwHMlMRAR
 VqQ0nEfDNQMR4dX37cZpwBiTtZhO1bU=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-vOfmFKWEN5q1jO79CJDSPw-1; Mon, 10 Apr 2023 23:56:59 -0400
X-MC-Unique: vOfmFKWEN5q1jO79CJDSPw-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1843667dbbbso3575748fac.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 20:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681185419; x=1683777419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dN6RiC/Xwm8NKvjIcSNOj4yk0tbo6PAAB47I+tLkOKo=;
 b=vHjSGb8JDwmR3pGTosVP35d1Fut3Obg1sZLrTCikVqpJiQsEMzIBcv+6b2dgJXsYMk
 UeVi1GlVFJdjUuce7L2i/2A9m6MkgSMtiHoygNm0CqDfJgmN490Tpz199OZVUVTrP9+H
 w1P4zU/tz8U2mKYx4UN5JjL/p2kew1XzYtf7xr5q5nc/sOKRk0ScOyX6+IJJJksl0bgT
 MUyhtFgSq3oK4HpHhjOTxB8Zi3cFbgwg7pIXMXF0596XT+VyqBA/721dwgVuN4paNZsd
 Va79chm8qjKyCPYTzQpDo7Om6m6OQm+l5S+bFoNYEVwgXJEG/CdMG0Pq5j6pFEd8gnax
 8h+A==
X-Gm-Message-State: AAQBX9chTDu3vbAGG3RGn4tJYcT0dVZwh1Oc6Yz3dQgQS3ln5CrYlg4Q
 LScpY0O3ZylXd1ZczD4lRQfbVI9PXiNCW366+tdgMvlYr/F3x7xTFSF2a/fzbzAMFR3VRJeBBOu
 LgPObnudHwppirwl1ln1H+UFUC1UlQAnizCZ2v0vCKi+aPBiPm5ApldAYuA==
X-Received: by 2002:a05:6808:3307:b0:383:fef9:6cac with SMTP id
 ca7-20020a056808330700b00383fef96cacmr3401654oib.9.1681185419066; 
 Mon, 10 Apr 2023 20:56:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZlwmMokmS1gYtdm5c/k4RMCUobBeyFjcYzBkNb3kI89F2xF1dleDkWlGe4cGWL81WqTCETpcLg5RfVNp4uGtM=
X-Received: by 2002:a05:6808:3307:b0:383:fef9:6cac with SMTP id
 ca7-20020a056808330700b00383fef96cacmr3401650oib.9.1681185418805; Mon, 10 Apr
 2023 20:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-9-xuanzhuo@linux.alibaba.com>
 <73a24f95-b779-44ac-be28-45b35d1bf540@roeck-us.net>
 <20230407064634-mutt-send-email-mst@kernel.org>
 <1681097397.338332-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
 <ZDQq0pDVkr8TvoTM@infradead.org>
 <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEskNEwD0_AZgoDLS2RBv9cpbH5u1q01=cDuawV0NbhK_w@mail.gmail.com>
 <ZDTUn6TUqzrF06mr@infradead.org>
In-Reply-To: <ZDTUn6TUqzrF06mr@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Apr 2023 11:56:47 +0800
Message-ID: <CACGkMEtD0BLBXv7S-TLY-Y483_Lx4UskLyPmEC2wyGa8VE_R6w@mail.gmail.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
To: Christoph Hellwig <hch@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMTE6MzHigK9BTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+Cj4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMTA6MDk6
NDBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IFdlIHdhbnQgdG8gc3VwcG9ydCBBRl9Y
RFAgZm9yIHZpcnRpby1uZXQuIEl0IG1lYW5zIEFGX1hEUCBuZWVkcyB0bwo+ID4ga25vdyB0aGUg
ZG1hIGRldmljZSB0byBwZXJmb3JtIERNQSBtYXBwaW5nLiBTbyB3ZSBpbnRyb2R1Y2UgYSBoZWxw
ZXIKPiA+IHRvIGV4cG9zZSB0aGUgZG1hIGRldiBvZiB0aGUgdmlydGlvIGRldmljZS4KPgo+IFRo
ZSB3aG9sZSB2aXJ0aW8gYXJjaGl0ZWN0dXJlIGlzIGJhc2VkIGFyb3VuZCB0aGUgY29yZSBjb2Rl
IGRvaW5nCj4gdGhlIERNQSBtYXBwaW5nLiAgSSBjYW4ndCBzZWUgaG93IHlvdSBjYW4ganVzdCBl
eHBvcnQgYSBoZWxwZXIgdG8KPiBleHBvc2UgdGhlIGRtYSBkZXZpY2UuICBZb3UnZCBoYXZlIHRv
IGNvbXBsZXRlIHJld29yayB0aGUgbGF5ZXJpbmcKPiBvZiB0aGUgdmlydGlvIGNvZGUgaWYgeW91
IHdhbnQgdG8gZG8gaXQgaW4gdGhlIHVwcGVyIGxldmVsIGRyaXZlcnMuCj4gQW5kIHdoeSB3b3Vs
ZCB5b3Ugd2FudCB0byBkbyB0aGlzPyAgVGhlIGxvdy1sZXZlbCBjb2RlIGlzIHRoZSBvbmx5Cj4g
cGllY2UgdGhhdCBjYW4gYWN0dWFsbHkga25vdyBpZiB5b3UgbmVlZCB0byBkbyBhIGRtYSBtYXBw
aW5nLiAgQWxsCj4gdGhlIGtlcm5lbCBzdWJzeXN0ZW1zIHRoYXQgZG9uJ3QgZG8gaXQgaW5zaWRl
IHRoZSBsb3ctbGV2ZWwgZHJpdmVycwo+IG9yIGhlbHBlcnMgY2xvc2VseSBhc3NvY2l0YXRlZCBh
cmUgYSBnaWFudCBhbmQgaGFyZCB0byBmaXggbWFwCj4gKHNlZSB1c2IgZm9yIHRoZSBwcmltZSBl
eGhpYml0KS4KPgo+IFNvIHRoZSBmaXJzdCBxdWVzdGlvbiBpczogIHdoeSBkbyB5b3Ugd2FudCB0
aGlzIGZvciBYRl9BRFAsCgpYdWFuLCBpcyBpdCBwb3NzaWJsZSB0byBzZXQgdXAgdGhlIERNQSBt
YXBwaW5nIGluc2lkZSB0aGUgdmlydGlvCmRyaXZlciBpdHNlbGY/IEkgdmFndWVseSByZW1lbWJl
ciBhdCBsZWFzdCB0aGUgUlggYnVmZmVyIG1hcHBpbmcgaXMKZG9uZSBieSB0aGUgZHJpdmVyLiBJ
ZiB0aGlzIGlzIHRydWUsIHdlIGNhbiBhdm9pZCBleHBvc2luZyBETUEgZGV0YWlscwp0byB0aGUg
dXBwZXIgbGF5ZXIuCgo+IGFuZAo+IHRoZSBuZXh0IHF1ZXN0aW9uIHdpbGwgYmUgaG93IHRvIGRv
IHRoYXQgd2l0aG91dCBtYWtpbmcgYSBjb21wbGV0ZQo+IG1lc3MuCj4KPiA+IFRoaXMgd29ya3Mg
ZmluZSBhcyBsb25nIGFzIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBpcyBuZWdvdGlhdGVkLiBC
dXQKPiA+IHdoZW4gaXQgaXMgbm90LCB0aGUgdmlydGlvIGRyaXZlciBuZWVkcyB0byB1c2UgYSBw
aHlzaWNhbCBhZGRyZXNzIHNvCj4gPiB3ZSB3YW50IHRvIGV4cG9zZSB0aGUgdmlydGlvIGRldmlj
ZSB3aXRob3V0IGRtYV9vcHMgaW4gdGhlIGhvcGUgdGhhdAo+ID4gaXQgd2lsbCBnbyBmb3IgZGly
ZWN0IG1hcHBpbmcgd2hlcmUgdGhlIHBoeXNpY2FsIGFkZHJlc3MgaXMgdXNlZC4gQnV0Cj4gPiBp
dCBtYXkgbm90IHdvcmsgb24gc29tZSBzcGVjaWZpYyBzZXR1cHMgKGFyY2hlcyB0aGF0IGFzc3Vt
ZSBhbiBJT01NVQo+ID4gb3IgaGF2ZSBhcmNoIGRtYSBvcHMpLgo+Cj4gVGhlIERNQSBkZXZpY2Ug
Zm9yIHZpcnRpb19wY2kgaXMgdGhlIHVuZGVybHlpbmcgUENJIGRldmljZSwgYWx3YXlzLgo+ICFW
SVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gbWVhbnMgdGhlcmUgaXMgbm8gZG1hIGRldmljZSBhdCBh
bGwuICBCZWNhdXNlCj4gb2YgYWxsIHRoZXNlIHRoaW5ncyB5b3UgY2FuJ3QganVzdCBleHBvc2Ug
YSBwb2ludGVyIHRvIHRoZSBkbWFfZGV2aWNlCj4gYXMgdGhhdCBpcyBqdXN0IGEgY29tcGxldGVs
eSB3cm9uZyB3YXkgb2YgdGhpbmtpbmcgYWJvdXQgdGhlIHByb2JsZW0uCgpPaywgc28gaWYgdGhl
cmUncyBubyBETUEgYXQgYWxsIHdlIHNob3VsZCBhdm9pZCB1c2luZyB0aGUgRE1BIEFQSQpjb21w
bGV0ZWx5LiBUaGlzIG1lYW5zIHdlIHNob3VsZCBjaGVjayBkbWFfZGV2IGFnYWluc3QgTlVMTCBp
bgp2aXJ0aW9faGFzX2RtYV9xdWlyaygpLgoKVGhhbmtzCgo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
