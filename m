Return-Path: <SRS0=7x/u=EF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA86CC55179
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 08:47:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143A620704
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 08:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCGOZDpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143A620704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 60B6C87163;
	Fri, 30 Oct 2020 08:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SWqVDcIKlc04; Fri, 30 Oct 2020 08:47:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9D64087190;
	Fri, 30 Oct 2020 08:47:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83B8BC0893;
	Fri, 30 Oct 2020 08:47:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20E64C0859
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 08:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 052AA86853
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 08:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CqEf-AI4NuNf
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 08:47:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 65A6C86843
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 08:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604047653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OowK7sEL9WYawE8HtiZ4y/bzMNMCZEory9yOR9ZIFgY=;
 b=iCGOZDptev63WZfKzyQV0yBX9gYS0GVjVQEVrw2MM1BOw1eWDTQMe/AhJ0y1ntUMwRUsLv
 P2LWYrJDUG1CpV9Yhq0hdzWyQFhbmmJ9o2NUX5VIPmFlrwDYVNS1zDyplpZiH6Ki1iBHEk
 HkLCvvVjo8sG+YbeQ2sq3jC5h+vDv8E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-JlN0THmXOvuVaF8Ac650lg-1; Fri, 30 Oct 2020 04:47:31 -0400
X-MC-Unique: JlN0THmXOvuVaF8Ac650lg-1
Received: by mail-wr1-f72.google.com with SMTP id j15so2385504wrd.16
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 01:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OowK7sEL9WYawE8HtiZ4y/bzMNMCZEory9yOR9ZIFgY=;
 b=iMYJF35y2Ft2nLsijE/SYWj5QyNdE7ePXueWJGbTTEajfig0F1nRda1lU1AAKm+o6b
 q23zTYGpxDpeYAleSkPy1cAtY2TBIGy7lX9xMcs/DcmUmFEh3C6YH0BbJpPBdaxgNC65
 fSZTUx5IlkSBDd3K5UKiSY/p546C6gLmYxubT2qOAKOrzUs5E+i5YUQhdK/A1SKgVAA8
 7yAibpNCvRPS6n802Fxs5REj1IYR0XX3eYRedAT+tnfA7YuEJQ1EwUDO36Lo1otghWgN
 SSIvlYKkRg+JltRWss+96uIwLmujMByPWzGMyIetqW4al9xVS3ALIAeVCIgKn8z6JKGq
 AkkA==
X-Gm-Message-State: AOAM532Z6kv5/j5CGxqV6qIZf+jdKH7F97iQyeQwV96tr3sR7yrAM4p4
 vNGR5cUiPN523pwYnWIK1UzIupUMVOn5Z12mmOLKDgLpyVqG8VpYIT8WE+YLxXPHrKx9oIsTb6h
 lBD6Z69JLanCK5me8UhI4ZxM1fDcCPosTO6YmYD2iXA==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr1514362wrm.285.1604047650186; 
 Fri, 30 Oct 2020 01:47:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwX0VUnp1F7pR6WRrcOB29Hkdk2r6gE37I/8kD5eGOV2J1UWZXMq2SjTH7D/hE2cwGkfYz5iQ==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr1514342wrm.285.1604047649952; 
 Fri, 30 Oct 2020 01:47:29 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id t7sm9232775wrx.42.2020.10.30.01.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 01:47:29 -0700 (PDT)
Date: Fri, 30 Oct 2020 04:47:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 07/17] vhost scsi: support delayed IO vq creation
Message-ID: <20201030044402-mutt-send-email-mst@kernel.org>
References: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
 <1603326903-27052-8-git-send-email-michael.christie@oracle.com>
 <9e97ea2a-bc57-d4aa-4711-35dba20b3b9e@redhat.com>
 <49c2fc29-348c-06db-4823-392f7476d318@oracle.com>
MIME-Version: 1.0
In-Reply-To: <49c2fc29-348c-06db-4823-392f7476d318@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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

T24gVHVlLCBPY3QgMjcsIDIwMjAgYXQgMTI6NDc6MzRBTSAtMDUwMCwgTWlrZSBDaHJpc3RpZSB3
cm90ZToKPiBPbiAxMC8yNS8yMCAxMDo1MSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiA+IAo+ID4g
T24gMjAyMC8xMC8yMiDkuIrljYg4OjM0LCBNaWtlIENocmlzdGllIHdyb3RlOgo+ID4gPiBFYWNo
IHZob3N0LXNjc2kgZGV2aWNlIHdpbGwgbmVlZCBhIGV2dCBhbmQgY3RsIHF1ZXVlLCBidXQgdGhl
IG51bWJlcgo+ID4gPiBvZiBJTyBxdWV1ZXMgZGVwZW5kcyBvbiB3aGF0ZXZlciB0aGUgdXNlciBo
YXMgY29uZmlndXJlZCBpbiB1c2Vyc3BhY2UuCj4gPiA+IFRoaXMgcGF0Y2ggaGFzIHZob3N0LXNj
c2kgY3JlYXRlIHRoZSBldnQsIGN0bCBhbmQgb25lIElPIHZxIGF0IGRldmljZQo+ID4gPiBvcGVu
IHRpbWUuIFdlIHRoZW4gY3JlYXRlIHRoZSBvdGhlciBJTyB2cXMgd2hlbiB1c2Vyc3BhY2Ugc3Rh
cnRzIHRvCj4gPiA+IHNldCB0aGVtIHVwLiBXZSBzdGlsbCB3YXN0ZSBzb21lIG1lbSBvbiB0aGUg
dnEgYW5kIHNjc2kgdnEgc3RydWN0cywKPiA+ID4gYnV0IHdlIGRvbid0IHdhc3RlIG1lbSBvbiBp
b3ZlYyByZWxhdGVkIGFycmF5cyBhbmQgZm9yIGxhdGVyIHBhdGNoZXMKPiA+ID4gd2Uga25vdyB3
aGljaCBxdWV1ZXMgYXJlIHVzZWQgYnkgdGhlIGRldi0+bnZxcyB2YWx1ZS4KPiA+ID4gCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IE1pa2UgQ2hyaXN0aWUgPG1pY2hhZWwuY2hyaXN0aWVAb3JhY2xlLmNv
bT4KPiA+ID4gLS0tCj4gPiA+IMKgIGRyaXZlcnMvdmhvc3Qvc2NzaS5jIHwgMTkgKysrKysrKysr
KysrKysrLS0tLQo+ID4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKPiA+IAo+ID4gCj4gPiBOb3QgZmFtaWxpYXIgd2l0aCBTQ1NJLiBCdXQgSSB3
b25kZXIgaWYgaXQgY291bGQgYmVoYXZlIGxpa2Ugdmhvc3QtbmV0Lgo+ID4gCj4gPiBFLmcgdXNl
cnNwYWNlIHNob3VsZCBrbm93biB0aGUgbnVtYmVyIG9mIHZpcnRxdWV1ZXMgc28gaXQgY2FuIGp1
c3Qgb3Blbgo+ID4gYW5kIGNsb3NlIG11bHRpcGxlIHZob3N0LXNjc2kgZmlsZSBkZXNjcmlwdG9y
cy4KPiA+IAo+IAo+IE9uZSBoaWNjdXAgSSdtIGhpdHRpbmcgaXMgdGhhdCB3ZSBtaWdodCBlbmQg
dXAgY3JlYXRpbmcgYWJvdXQgM3ggbW9yZSB2cXMKPiB0aGFuIHdlIG5lZWQuIFRoZSBwcm9ibGVt
IGlzIHRoYXQgZm9yIHNjc2kgZWFjaCB2aG9zdCBkZXZpY2UgaGFzOgo+IAo+IHZxPTA6IHNwZWNp
YWwgY29udHJvbCB2cQo+IHZxPTE6IGV2ZW50IHZxCj4gdnE9MiBhbmQgYWJvdmU6IFNDU0kgQ01E
L0lPIHZxcy4gV2Ugd2FudCB0byBjcmVhdGUgTiBvZiB0aGVzZS4KPiAKPiBUb2RheSB3ZSBkbzoK
PiAKPiBVZXJzcGFjZSBkb2VzIG9wZW4oL2Rldi92aG9zdC1zY3NpKQo+ICAgICAgICAgdmhvc3Rf
ZGV2X2luaXQoY3JlYXRlIDEyOCB2cXMgYW5kIHRoZW4gbGF0ZXIgd2Ugc2V0dXAgYW5kIHVzZSBO
IG9mCj4gdGhlbSk7Cj4gCj4gUWVtdSBkb2VzIGlvY3RsKFZIT1NUX1NFVF9PV05FUikKPiAgICAg
ICAgIHZob3N0X2Rldl9zZXRfb3duZXIoKQo+IAo+IEZvciBOIHZxcyB1c2Vyc3BhY2UgZG9lczoK
PiAgICAgICAgIC8vIHZpcnRxdWV1ZSBzZXR1cCByZWxhdGVkIGlvY3Rscwo+IAo+IFFlbXUgZG9l
cyBpb2N0bChWSE9TVF9TQ1NJX1NFVF9FTkRQT0lOVCkKPiAgICAgICAgIC0gbWF0Y2ggTElPL3Rh
cmdldCBwb3J0IHRvIHZob3N0X2Rldgo+IAo+IAo+IFNvIHdlIGNvdWxkIGNoYW5nZSB0aGF0IHRv
Ogo+IAo+IEZvciBOIElPIHZxcyB1c2Vyc3BhY2UgZG9lcwo+ICAgICAgICAgb3BlbigvZGV2L3Zo
b3N0LXNjc2kpCj4gICAgICAgICAgICAgICAgIHZob3N0X2Rldl9pbml0KGNyZWF0ZSBJTywgZXZ0
LCBhbmQgY3RsKTsKPiAKPiBmb3IgTiBJTyB2cXMgUWVtdSBkb2VzOgo+ICAgICAgICAgaW9jdGwo
VkhPU1RfU0VUX09XTkVSKQo+ICAgICAgICAgICAgICAgICB2aG9zdF9kZXZfc2V0X293bmVyKCkK
PiAKPiBmb3IgTiBJTyB2cXMgUWVtdSBkb2VzOgo+ICAgICAgICAgLy8gdmlydHF1ZXVlIHNldHVw
IHJlbGF0ZWQgaW9jdGxzCj4gCj4gZm9yIE4gSU8gdnFzIFFlbXUgZG9lczoKPiAgICAgICAgIGlv
Y3RsKFZIT1NUX1NDU0lfU0VUX0VORFBPSU5UKQo+ICAgICAgICAgICAgICAgICAtIG1hdGNoIExJ
Ty90YXJnZXQgcG9ydCB0byB2aG9zdF9kZXYgYW5kIGFzc2VtYmxlIHRoZQo+IG11bHRpcGxlIHZo
b3N0X2RldiBkZXZpY2UuCj4gCj4gVGhlIHByb2JsZW0gaXMgdGhhdCB3ZSBoYXZlIHRvIHNldHVw
IHNvbWUgb2YgdGhlIGV2dC9jdGwgc3BlY2lmaWMgcGFydHMgYXQKPiBvcGVuKCkgdGltZSB3aGVu
IHZob3N0X2Rldl9pbml0IGRvZXMgdmhvc3RfcG9sbF9pbml0IGZvciBleGFtcGxlLgo+IAo+IC0g
QXQgb3BlbiB0aW1lLCB3ZSBkb24ndCBrbm93IGlmIHRoaXMgdmhvc3RfZGV2IGlzIGdvaW5nIHRv
IGJlIHBhcnQgb2YgYQo+IG11bHRpcGxlIHZob3N0X2RldmljZSBkZXZpY2Ugb3IgYSBzaW5nbGUg
b25lIHNvIHdlIG5lZWQgdG8gY3JlYXRlIGF0IGxlYXN0IDMKPiBvZiB0aGVtCj4gLSBJZiBpdCBp
cyBhIG11bHRpcGxlIGRldmljZSB3ZSBkb24ndCBrbm93IGlmIGl0cyB0aGUgZmlyc3QgZGV2aWNl
IGJlaW5nCj4gY3JlYXRlZCBmb3IgdGhlIGRldmljZSBvciB0aGUgTid0aCwgc28gd2UgZG9uJ3Qg
a25vdyBpZiB0aGUgZGV2J3MgdnFzIHdpbGwKPiBiZSB1c2VkIGZvciBJTyBvciBjdGxzL2V2dHMs
IHNvIHdlIGhhdmUgdG8gY3JlYXRlIGFsbCAzLgo+IAo+IFdoZW4gd2UgZ2V0IHRoZSBmaXJzdCBW
SE9TVF9TQ1NJX1NFVF9FTkRQT0lOVCBjYWxsIGZvciBhIG5ldyBzdHlsZSBtdWx0aXBsZQo+IHZo
b3N0X2RldiBkZXZpY2UsIHdlIGNhbiB1c2UgdGhhdCBkZXYncyBldnQvY3RsIHZxcyBmb3IgZXZl
bnRzL2NvbnRyb2xzCj4gcmVxdWVzdHMuIFdoZW4gd2UgZ2V0IHRoZSBvdGhlciBWSE9TVF9TQ1NJ
X1NFVF9FTkRQT0lOVCBjYWxscyBmb3IgdGhlCj4gbXVsdGlwbGUgdmhvc3RfZGV2IGRldmljZSB0
aGVuIHRob3NlIGRldidzIGV2dC9jdGwgdnFzIHdpbGwgYmUgaWdub3JlZCBhbmQKPiB3ZSB3aWxs
IG9ubHkgdXNlIHRoZWlyIElPIHZxcy4gU28gd2UgZW5kIHVwIHdpdGggYSBsb3Qgb2YgZXh0cmEg
dnFzLgoKVGhlIGlzc3VlIEphc29uJ3MgaGludGluZyBhdCBpcyBob3cgY2FuIGFkbWlucyBjb250
cm9sIHRoZSBhbW91bnQKb2YgcmVzb3VyY2VzIGEgZ2l2ZW4gcWVtdSBpbnN0YW5jZSBjYW4gY29u
c3VtZT8KQWZ0ZXIgYWxsIHZob3N0IHZxcyBhbGwgbGl2ZSBpbiBob3N0IGtlcm5lbCBtZW1vcnkg
Li4uCkxpbWl0aW5nICMgb2Ygb3BlbiBmZHMgd291bGQgYmUgb25lIHdheSB0byBkbyB0aGF0IC4u
LgoKVGhlIG5lZWQgdG8gc2hhcmUgZXZlbnQvY29udHJvbCB2cXMgYmV0d2VlbiBkZXZpY2VzIGlz
IGEgcHJvYmxlbSB0aG91Z2gsCmFuZCBzZW5kaW5nIGxvdHMgb2YgaW9jdGxzIG9uIHRoaW5ncyBs
aWtlIHJlc2V0IGlzIGFsc28gbm90IHRoYXQgZWxlZ2FudC4KSmFzb24sIGRpZCB5b3UgaGF2ZSBh
IGdvb2Qgc29sdXRpb24gaW4gbWluZD8KCj4gT25lIG90aGVyIHF1ZXN0aW9uL2lzc3VlIEkgaGF2
ZSBpcyB0aGF0IHFlbXUgY2FuIG9wZW4gdGhlIC9kZXYvdmhvc3Qtc2NzaQo+IGRldmljZSBvciBp
dCBhbGxvd3MgdG9vbHMgbGlrZSBsaWJ2aXJ0ZCB0byBvcGVuIHRoZSBkZXZpY2UgYW5kIHBhc3Mg
aW4gdGhlCj4gZmQgdG8gdXNlLiBGb3IgdGhlIGxhdHRlciBjYXNlLCB3b3VsZCB3ZSBjb250aW51
ZSB0byBoYXZlIHRob3NlIHRvb2xzIHBhc3MKPiBpbiB0aGUgbGVhZGluZyBmZCwgdGhlbiBoYXZl
IHFlbXUgZG8gdGhlIG90aGVyIG51bV9xdWV1ZXMgLSAxCj4gb3BlbigvZGV2L3Zob3N0LXNjc2kp
IGNhbGxzPyBPciBkbyB0aGVzZSBhcHBzIHRoYXQgcGFzcyBpbiB0aGUgZmQgbmVlZCB0bwo+IGtu
b3cgYWJvdXQgYWxsIG9mIHRoZSBmZHMgZm9yIHNvbWUgbWFuYWdlbWVudCByZWFzb24/CgpUaGV5
IGtub3cgYWJvdXQgYWxsIHRoZSBmZHMsIGZvciByZXNvdXJjZSBjb250cm9sIGFuZCBwcml2ZWxl
ZGdlCnNlcGFyYXRpb24gcmVhc29ucy4KCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
