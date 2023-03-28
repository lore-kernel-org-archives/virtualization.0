Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E547C6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 02:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A533D417FC;
	Tue, 28 Mar 2023 02:59:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A533D417FC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PQ1IlJAG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2XTfLnFdmhmq; Tue, 28 Mar 2023 02:59:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 63FC6417C3;
	Tue, 28 Mar 2023 02:59:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63FC6417C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35931C007E;
	Tue, 28 Mar 2023 02:59:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0EFBC007C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83680610EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:59:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83680610EC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PQ1IlJAG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JTT9FHsealPC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:59:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08D6960EB3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08D6960EB3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679972342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVMGCykpINusC1X2o35RkpO4Jksn/8McHykOJK2uUY8=;
 b=PQ1IlJAGqrqiXhphVcw303FOFJjTA6sGlt8vMviI94qroqPDM7w8UWZHVKlgBiul+eYAxa
 /nReb5MkfEm1bRGqe8DREELLHA1qo+Eq0MF9S+CcJA5VXESakt83f0Ge67Pw4uR4VEBkS2
 EisPhMg57opuyx1yw2wdgWa6ppc8T7c=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-0RbgxvyLP8KOJ8gpJa5yKg-1; Mon, 27 Mar 2023 22:59:01 -0400
X-MC-Unique: 0RbgxvyLP8KOJ8gpJa5yKg-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-17abb9d4b67so6070780fac.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 19:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679972340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVMGCykpINusC1X2o35RkpO4Jksn/8McHykOJK2uUY8=;
 b=KlhlkSsV7dmpFF0ROt1O0YOMTFa7nahgfVFEKNclY5sK5Th/OMhueqL6vmQjbXEbmJ
 V0eBkrE71Ds4OgPpPuTYnTC9OI4cwIo+SURCvTDKvwzy9ooT1bS7XQwxs8JlKXVVsbfI
 Yv5/8uBqTdl8ubsutZTE+F4wR1QhPW6qqt/BW/DlkQL0V07XFhScQbes1gCC76Wc3Wr9
 4+PSCdPBTWW9cG7GdqW7W1sgA5lqxg6JafKnnN9D9R2VFgkgtkReY5wR6bDFXb02ELc8
 SmBB59Tcp7jElQvzXoZvSVYNcZmcWCwGHCWc5I6+nqha+PQnao6G5Fl5nJCHrk6IEcRq
 HRGA==
X-Gm-Message-State: AAQBX9cbQf2IU2xRX26aOqAqvIizZodzz9YHf3fgpNoCYs+2WZt2fUso
 UvLfEZjzz9P8if2HdU4Qt3mKwrCw9zs2Nk82VCAPhrsPdzy9S0EWLBlHfaIXCzBALd970my902O
 UlpLGSq0RiF/s0Xp2GGkRqbrvX2F7CjTuRkdfMF1AmAq1cIEejGA6HjjTfA==
X-Received: by 2002:a05:6870:8310:b0:177:c2fb:8cec with SMTP id
 p16-20020a056870831000b00177c2fb8cecmr5393490oae.9.1679972340035; 
 Mon, 27 Mar 2023 19:59:00 -0700 (PDT)
X-Google-Smtp-Source: AK7set9bmnFjMgjYohCBeL1d99Eg+sVv0sUJNJIXbQ4MkNune4yxD1oxJROTbptIQytupPC8Wk6CuoIKAAtkQZX3NQ4=
X-Received: by 2002:a05:6870:8310:b0:177:c2fb:8cec with SMTP id
 p16-20020a056870831000b00177c2fb8cecmr5393483oae.9.1679972339793; Mon, 27 Mar
 2023 19:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
 <ZCJNTBQLZeyLBKKB@codewreck.org>
In-Reply-To: <ZCJNTBQLZeyLBKKB@codewreck.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Mar 2023 10:58:48 +0800
Message-ID: <CACGkMEt29t9CK2Muiuyb1s6p2AzgcMiD_z0NVFn1d+KEqBydug@mail.gmail.com>
Subject: Re: 9p regression (Was: [PATCH v2] virtio_ring: don't update event
 idx on get_buf)
To: Dominique Martinet <asmadeus@codewreck.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Albert Huang <huangjie.albert@bytedance.com>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eric Van Hensbergen <ericvh@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 v9fs-developer@lists.sourceforge.net
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

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMTA6MTPigK9BTSBEb21pbmlxdWUgTWFydGluZXQKPGFz
bWFkZXVzQGNvZGV3cmVjay5vcmc+IHdyb3RlOgo+Cj4gSGkgTWljaGFlbCwgQWxiZXJ0LAo+Cj4g
QWxiZXJ0IEh1YW5nIHdyb3RlIG9uIFNhdCwgTWFyIDI1LCAyMDIzIGF0IDA2OjU2OjMzUE0gKzA4
MDA6Cj4gPiBpbiB2aXJ0aW9fbmV0LCBpZiB3ZSBkaXNhYmxlIHRoZSBuYXBpX3R4LCB3aGVuIHdl
IHRyaWdlciBhIHR4IGludGVycnVwdCwKPiA+IHRoZSB2cS0+ZXZlbnRfdHJpZ2dlcmVkIHdpbGwg
YmUgc2V0IHRvIHRydWUuIEl0IHdpbGwgbm8gbG9uZ2VyIGJlIHNldCB0bwo+ID4gZmFsc2UuIFVu
bGVzcyB3ZSBleHBsaWNpdGx5IGNhbGwgdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkIG9yCj4g
PiB2aXJ0cXVldWVfZW5hYmxlX2NiX3ByZXBhcmUuCj4KPiBUaGlzIHBhdGNoIChjb21taXRlZCBh
cyAzNTM5NTc3MGY4MDMgKCJ2aXJ0aW9fcmluZzogZG9uJ3QgdXBkYXRlIGV2ZW50Cj4gaWR4IG9u
IGdldF9idWYiKSBpbiBuZXh0LTIwMjMwMzI3IGFwcGFyZW50bHkgYnJlYWtzIDlwLCBhcyByZXBv
cnRlZCBieQo+IEx1aXMgaW4gaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci9aQ0krN1dnNU9jbFNs
RThjQGJvbWJhZGlsLmluZnJhZGVhZC5vcmcKPgo+IEkndmUganVzdCBoaXQgaGFkIGEgbG9vayBh
dCByZWNlbnQgcGF0Y2hlc1sxXSBhbmQgcmV2ZXJ0ZWQgdGhpcyB0byB0ZXN0Cj4gYW5kIEkgY2Fu
IG1vdW50IGFnYWluLCBzbyBJJ20gcHJldHR5IHN1cmUgdGhpcyBpcyB0aGUgY3VscHJpdCwgYnV0
IEkKPiBkaWRuJ3QgbG9vayBhdCB0aGUgY29udGVudCBhdCBhbGwgeWV0IHNvIGNhbm5vdCBhZHZp
c2UgZnVydGhlci4KPiBJdCBtaWdodCB2ZXJ5IHdlbGwgYmUgdGhhdCB3ZSBuZWVkIHNvbWUgZXh0
cmEgaGFuZGxpbmcgZm9yIDlwCj4gc3BlY2lmaWNhbGx5IHRoYXQgY2FuIGJlIGFkZGVkIHNlcGFy
YXRlbHkgaWYgcmVxdWlyZWQuCj4KPiBbMV0gZ2l0IGxvZyAwZWM1N2NmYTcyMWZiZDM2YjRjNGMw
ZDljY2M1ZDc4YTc4ZjdmYTM1Li5IRUFEIGRyaXZlcnMvdmlydGlvLwo+Cj4KPiBUaGlzIGNhbiBi
ZSByZXByb2R1Y2VkIHdpdGggYSBzaW1wbGUgbW91bnQsIHJ1biBxZW11IHdpdGggc29tZSAtdmly
dGZzCj4gYXJndW1lbnQgYW5kIGBtb3VudCAtdCA5cCAtbyBkZWJ1Zz02NTUzNSB0YWcgbW91bnRw
b2ludGAgd2lsbCBoYW5nIGFmdGVyCj4gdGhlc2UgbWVzc2FnZXM6Cj4gOXBuZXQ6IC0tIHA5X3Zp
cnRpb19yZXF1ZXN0ICg4Myk6IDlwIGRlYnVnOiB2aXJ0aW8gcmVxdWVzdAo+IDlwbmV0OiAtLSBw
OV92aXJ0aW9fcmVxdWVzdCAoODMpOiB2aXJ0aW8gcmVxdWVzdCBraWNrZWQKPgo+IFNvIEkgc3Vz
cGVjdCB3ZSdyZSBqdXN0IG5vdCBnZXR0aW5nIGEgY2FsbGJhY2suCgpJIHRoaW5rIHNvLiBUaGUg
cGF0Y2ggYXNzdW1lcyB0aGUgZHJpdmVyIHdpbGwgY2FsbAp2aXJ0cXVldWVfZGlzYWJsZS9lbmFi
bGVfY2IoKSB3aGljaCBpcyBub3QgdGhlIGNhc2Ugb2YgdGhlIDlwIGRyaXZlci4KClNvIGFmdGVy
IHRoZSBmaXJzdCBpbnRlcnJ1cHQsIGV2ZW50X3RyaWdnZXJlZCB3aWxsIGJlIHNldCB0byB0cnVl
IGZvcmV2ZXIuCgpUaGFua3MKCj4KPgo+IEknbGwgaGF2ZSBhIGNsb3NlciBsb29rIGFmdGVyIHdv
cmssIGJ1dCBhbnkgYWR2aWNlIG1lYW53aGlsZSB3aWxsIGJlCj4gYXBwcmVjaWF0ZWQhCj4gKEkn
bSBzdXJlIEx1aXMgd291bGQgYWxzbyBsaWtlIGEgdGVtcG9yYXJ5IGRyb3AgZnJvbSAtbmV4dCB1
bnRpbAo+IHRoaXMgaXMgZmlndXJlZCBvdXQsIGJ1dCBJJ2xsIGxlYXZlIHRoaXMgdXAgdG8geW91
KQo+Cj4KPiA+Cj4gPiBJZiB3ZSBkaXNhYmxlIHRoZSBuYXBpX3R4LCBpdCB3aWxsIG9ubHkgYmUg
Y2FsbGVkIHdoZW4gdGhlIHR4IHJpbmcKPiA+IGJ1ZmZlciBpcyByZWxhdGl2ZWx5IHNtYWxsLgo+
ID4KPiA+IEJlY2F1c2UgZXZlbnRfdHJpZ2dlcmVkIGlzIHRydWUuIFRoZXJlZm9yZSwgVlJJTkdf
QVZBSUxfRl9OT19JTlRFUlJVUFQgb3IKPiA+IFZSSU5HX1BBQ0tFRF9FVkVOVF9GTEFHX0RJU0FC
TEUgd2lsbCBub3QgYmUgc2V0LiBTbyB3ZSB1cGRhdGUKPiA+IHZyaW5nX3VzZWRfZXZlbnQoJnZx
LT5zcGxpdC52cmluZykgb3IgdnEtPnBhY2tlZC52cmluZy5kcml2ZXItPm9mZl93cmFwCj4gPiBl
dmVyeSB0aW1lIHdlIGNhbGwgdmlydHF1ZXVlX2dldF9idWZfY3R4LiBUaGlzIHdpbGwgYnJpbmcg
bW9yZSBpbnRlcnJ1cHRpb25zLgo+ID4KPiA+IFRvIHN1bW1hcml6ZToKPiA+IDEpIGV2ZW50X3Ry
aWdnZXJlZCB3YXMgc2V0IHRvIHRydWUgaW4gdnJpbmdfaW50ZXJydXB0KCkKPiA+IDIpIGFmdGVy
IHRoaXMgbm90aGluZyB3aWxsIGhhcHBlbiBmb3IgdmlydHF1ZXVlX2Rpc2FibGVfY2IoKSBzbwo+
ID4gICAgVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQgaXMgbm90IHNldCBpbiBhdmFpbF9mbGFn
c19zaGFkb3cKPiA+IDMpIHZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9zcGxpdCgpIHdpbGwgc3RpbGwg
dGhpbmsgdGhlIGNiIGlzIGVuYWJsZWQKPiA+ICAgIHRoZW4gaXQgdHJpZXMgdG8gcHVibGlzaCBu
ZXcgZXZlbnQKPiA+Cj4gPiBUbyBmaXgsIGlmIGV2ZW50X3RyaWdnZXJlZCBpcyBzZXQgdG8gdHJ1
ZSwgZG8gbm90IHVwZGF0ZQo+ID4gdnJpbmdfdXNlZF9ldmVudCgmdnEtPnNwbGl0LnZyaW5nKSBv
ciB2cS0+cGFja2VkLnZyaW5nLmRyaXZlci0+b2ZmX3dyYXAKPiA+Cj4gPiBUZXN0ZWQgd2l0aCBp
cGVyZjoKPiA+IGlwZXJmMyB0Y3Agc3RyZWFtOgo+ID4gdm0xIC0tLS0tLS0tLS0tLS0tLS0tPiB2
bTIKPiA+IHZtMiBqdXN0IHJlY2VpdmVzIHRjcCBkYXRhIHN0cmVhbSBmcm9tIHZtMSwgYW5kIHNl
bmRzIHRoZSBhY2sgdG8gdm0xLAo+ID4gdGhlcmUgYXJlIG1hbnkgdHggaW50ZXJydXB0cyBpbiB2
bTIuCj4gPiBidXQgd2l0aG91dCBldmVudF90cmlnZ2VyZWQgdGhlcmUgYXJlIGp1c3QgYSBmZXcg
dHggaW50ZXJydXB0cy4KPiA+Cj4gPiBGaXhlczogOGQ2MjJkMjFkMjQ4ICgidmlydGlvOiBmaXgg
dXAgdmlydGlvX2Rpc2FibGVfY2IiKQo+ID4gU2lnbmVkLW9mZi1ieTogQWxiZXJ0IEh1YW5nIDxo
dWFuZ2ppZS5hbGJlcnRAYnl0ZWRhbmNlLmNvbT4KPiA+IE1lc3NhZ2UtSWQ6IDwyMDIzMDMyMTA4
NTk1My4yNDk0OS0xLWh1YW5namllLmFsYmVydEBieXRlZGFuY2UuY29tPgo+ID4gU2lnbmVkLW9m
Zi1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiA+IC0tLQo+ID4gIGRy
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA2ICsrKystLQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
Cj4gPiBpbmRleCBjYmVlZWExYjA0MzkuLjFjMzZmYTQ3Nzk2NiAxMDA2NDQKPiA+IC0tLSBhL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPiA+IEBAIC05MTQsNyArOTE0LDggQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9n
ZXRfYnVmX2N0eF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gPiAgICAgICAvKiBJZiB3
ZSBleHBlY3QgYW4gaW50ZXJydXB0IGZvciB0aGUgbmV4dCBlbnRyeSwgdGVsbCBob3N0Cj4gPiAg
ICAgICAgKiBieSB3cml0aW5nIGV2ZW50IGluZGV4IGFuZCBmbHVzaCBvdXQgdGhlIHdyaXRlIGJl
Zm9yZQo+ID4gICAgICAgICogdGhlIHJlYWQgaW4gdGhlIG5leHQgZ2V0X2J1ZiBjYWxsLiAqLwo+
ID4gLSAgICAgaWYgKCEodnEtPnNwbGl0LmF2YWlsX2ZsYWdzX3NoYWRvdyAmIFZSSU5HX0FWQUlM
X0ZfTk9fSU5URVJSVVBUKSkKPiA+ICsgICAgIGlmICh1bmxpa2VseSghKHZxLT5zcGxpdC5hdmFp
bF9mbGFnc19zaGFkb3cgJiBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVCkgJiYKPiA+ICsgICAg
ICAgICAgICAgICAgICAhdnEtPmV2ZW50X3RyaWdnZXJlZCkpCj4gPiAgICAgICAgICAgICAgIHZp
cnRpb19zdG9yZV9tYih2cS0+d2Vha19iYXJyaWVycywKPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICZ2cmluZ191c2VkX2V2ZW50KCZ2cS0+c3BsaXQudnJpbmcpLAo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY3B1X3RvX3ZpcnRpbzE2KF92cS0+dmRldiwgdnEtPmxh
c3RfdXNlZF9pZHgpKTsKPiA+IEBAIC0xNzQ0LDcgKzE3NDUsOCBAQCBzdGF0aWMgdm9pZCAqdmly
dHF1ZXVlX2dldF9idWZfY3R4X3BhY2tlZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gPiAgICAg
ICAgKiBieSB3cml0aW5nIGV2ZW50IGluZGV4IGFuZCBmbHVzaCBvdXQgdGhlIHdyaXRlIGJlZm9y
ZQo+ID4gICAgICAgICogdGhlIHJlYWQgaW4gdGhlIG5leHQgZ2V0X2J1ZiBjYWxsLgo+ID4gICAg
ICAgICovCj4gPiAtICAgICBpZiAodnEtPnBhY2tlZC5ldmVudF9mbGFnc19zaGFkb3cgPT0gVlJJ
TkdfUEFDS0VEX0VWRU5UX0ZMQUdfREVTQykKPiA+ICsgICAgIGlmICh1bmxpa2VseSh2cS0+cGFj
a2VkLmV2ZW50X2ZsYWdzX3NoYWRvdyA9PSBWUklOR19QQUNLRURfRVZFTlRfRkxBR19ERVNDICYm
Cj4gPiArICAgICAgICAgICAgICAgICAgIXZxLT5ldmVudF90cmlnZ2VyZWQpKQo+ID4gICAgICAg
ICAgICAgICB2aXJ0aW9fc3RvcmVfbWIodnEtPndlYWtfYmFycmllcnMsCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAmdnEtPnBhY2tlZC52cmluZy5kcml2ZXItPm9mZl93cmFwLAo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1X3RvX2xlMTYodnEtPmxhc3RfdXNl
ZF9pZHgpKTsKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
