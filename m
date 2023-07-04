Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD85EB64D9
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 15:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 993F74094F;
	Tue,  4 Jul 2023 15:45:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 993F74094F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BwlKMqEu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kV-EwaS4YQKA; Tue,  4 Jul 2023 15:45:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6A0D440861;
	Tue,  4 Jul 2023 15:45:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A0D440861
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14541C0072;
	Tue,  4 Jul 2023 15:45:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 772E8C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 15:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F6524094F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 15:45:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F6524094F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S1L1C-Ateedn
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 15:45:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF47E40861
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF47E40861
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688485518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/PUI+CtLNs4l2I0+iAQpXHNnM5sim5Or6js9Z3l/FyQ=;
 b=BwlKMqEujySN5qmw+K5Ji2A/Mzspe0yZk0QIdbBhKkUYclIY449s27xavVxf/f22rOYcs2
 Aj8GJ/vr5+Oy8b4+tT70dnirtcdptqtsAS9iZI9o4xCQVEDDFjmA7neUMmIZ5HY4VJ1Nkb
 YwLyJczOgVm4IRoFmJOGvhnVIF6zUMc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-aaKXaJo5NVugh0nTIiivwQ-1; Tue, 04 Jul 2023 11:45:17 -0400
X-MC-Unique: aaKXaJo5NVugh0nTIiivwQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31286355338so3315664f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Jul 2023 08:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688485516; x=1691077516;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/PUI+CtLNs4l2I0+iAQpXHNnM5sim5Or6js9Z3l/FyQ=;
 b=jrQuejjoIvLECOiMjZY6gRZimOpKJCS2zPE7yi2B3KlN3QfR4TvCNaB5pRO2lIZcpx
 gPd4466mDyPYczuaQODNPuXnHuVp7SYkLINgTIn1Jhg77fWMLdu5Iq9fMHLb4tF9UHWP
 AUoECmZQQl+Kcoj8FdZ3RrQ2QHgESfaiELMuFP4OeKjy3PjgThIna0bjQss65F/42h4q
 91cdrsrlWxA5pW2DraIdefNcAdjOrftSYFDbSwc0FDHQ33R0bAhfdz5ASPoyYqhUiYCO
 cg8FdcNT3yPleAI3XkBwTfiol4ysBu5RSaAxpO2nJVSPtDTys7q58ZDQVy8ynBAcVvat
 me/A==
X-Gm-Message-State: ABy/qLbZhZuTXWIB3lilR/EuNVefeLnysIz4iIv+dAK4RoQaPJZxUgda
 KBABYqPSS6bct36uit9fyGxLln6LPk93HCYZLWlDbo/V85+I73wPaALcSNou9zVTvun/ghh3tTr
 qU4lzzC83ZEcyblJQe3yzH6212WcabzMNf/DGoRw4CA==
X-Received: by 2002:a5d:674d:0:b0:314:13d8:8ae7 with SMTP id
 l13-20020a5d674d000000b0031413d88ae7mr11780927wrw.26.1688485516324; 
 Tue, 04 Jul 2023 08:45:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGHQsomKCUqerVJHD/653LO914nQ9p0VRaFIwyfELGloTwcXrjzg/w2GewNcsvZX5Lc+3kg9A==
X-Received: by 2002:a5d:674d:0:b0:314:13d8:8ae7 with SMTP id
 l13-20020a5d674d000000b0031413d88ae7mr11780912wrw.26.1688485515962; 
 Tue, 04 Jul 2023 08:45:15 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 24-20020a05600c021800b003fbe43238c6sm914770wmi.9.2023.07.04.08.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 08:45:15 -0700 (PDT)
Date: Tue, 4 Jul 2023 11:45:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does
 not support it
Message-ID: <20230704114159-mutt-send-email-mst@kernel.org>
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gVHVlLCBKdWwgMDQsIDIwMjMgYXQgMDE6MzY6MTFQTSArMDIwMCwgRXVnZW5pbyBQZXJleiBN
YXJ0aW4gd3JvdGU6Cj4gT24gVHVlLCBKdWwgNCwgMjAyMyBhdCAxMjozOOKAr1BNIE1pY2hhZWwg
Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1ZSwgSnVsIDA0
LCAyMDIzIGF0IDEyOjI1OjMyUE0gKzAyMDAsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+
ID4gPiBPbiBNb24sIEp1bCAzLCAyMDIzIGF0IDQ6NTLigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIE1vbiwgSnVsIDAzLCAy
MDIzIGF0IDA0OjIyOjE4UE0gKzAyMDAsIEV1Z2VuaW8gUMOpcmV6IHdyb3RlOgo+ID4gPiA+ID4g
V2l0aCB0aGUgY3VycmVudCBjb2RlIGl0IGlzIGFjY2VwdGVkIGFzIGxvbmcgYXMgdXNlcmxhbmQg
c2VuZCBpdC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBBbHRob3VnaCB1c2VybGFuZCBzaG91bGQgbm90
IHNldCBhIGZlYXR1cmUgZmxhZyB0aGF0IGhhcyBub3QgYmVlbgo+ID4gPiA+ID4gb2ZmZXJlZCB0
byBpdCB3aXRoIFZIT1NUX0dFVF9CQUNLRU5EX0ZFQVRVUkVTLCB0aGUgY3VycmVudCBjb2RlIHdp
bGwgbm90Cj4gPiA+ID4gPiBjb21wbGFpbiBmb3IgaXQuCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2lu
Y2UgdGhlcmUgaXMgbm8gc3BlY2lmaWMgcmVhc29uIGZvciBhbnkgcGFyZW50IHRvIHJlamVjdCB0
aGF0IGJhY2tlbmQKPiA+ID4gPiA+IGZlYXR1cmUgYml0IHdoZW4gaXQgaGFzIGJlZW4gcHJvcG9z
ZWQsIGxldCdzIGNvbnRyb2wgaXQgYXQgdmRwYSBmcm9udGVuZAo+ID4gPiA+ID4gbGV2ZWwuIEZ1
dHVyZSBwYXRjaGVzIG1heSBtb3ZlIHRoaXMgY29udHJvbCB0byB0aGUgcGFyZW50IGRyaXZlci4K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBGaXhlczogOTY3ODAwZDJkNTJlICgidmRwYTogYWNjZXB0IFZI
T1NUX0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVSX09LIGJhY2tlbmQgZmVhdHVyZSIpCj4g
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNv
bT4KPiA+ID4gPgo+ID4gPiA+IFBsZWFzZSBkbyBzZW5kIHYzLiBBbmQgYWdhaW4sIEkgZG9uJ3Qg
d2FudCB0byBzZW5kICJhZnRlciBkcml2ZXIgb2siIGhhY2sKPiA+ID4gPiB1cHN0cmVhbSBhdCBh
bGwsIEkgbWVyZ2VkIGl0IGluIG5leHQganVzdCB0byBnaXZlIGl0IHNvbWUgdGVzdGluZy4KPiA+
ID4gPiBXZSB3YW50IFJJTkdfQUNDRVNTX0FGVEVSX0tJQ0sgb3Igc29tZSBzdWNoLgo+ID4gPiA+
Cj4gPiA+Cj4gPiA+IEN1cnJlbnQgZGV2aWNlcyBkbyBub3Qgc3VwcG9ydCB0aGF0IHNlbWFudGlj
Lgo+ID4KPiA+IFdoaWNoIGRldmljZXMgc3BlY2lmaWNhbGx5IGFjY2VzcyB0aGUgcmluZyBhZnRl
ciBEUklWRVJfT0sgYnV0IGJlZm9yZQo+ID4gYSBraWNrPwo+ID4KPiAKPiBQcmV2aW91cyB2ZXJz
aW9ucyBvZiB0aGUgUUVNVSBMTSBzZXJpZXMgZGlkIGEgc3B1cmlvdXMga2ljayB0byBzdGFydAo+
IHRyYWZmaWMgYXQgdGhlIExNIGRlc3RpbmF0aW9uIFsxXS4gV2hlbiBpdCB3YXMgcHJvcG9zZWQs
IHRoYXQgc3B1cmlvdXMKPiBraWNrIHdhcyByZW1vdmVkIGZyb20gdGhlIHNlcmllcyBiZWNhdXNl
IHRvIGNoZWNrIGZvciBkZXNjcmlwdG9ycwo+IGFmdGVyIGRyaXZlcl9vaywgZXZlbiB3aXRob3V0
IGEga2ljaywgd2FzIGNvbnNpZGVyZWQgd29yayBvZiB0aGUKPiBwYXJlbnQgZHJpdmVyLgo+IAo+
IEknbSBvayB0byBnbyBiYWNrIHRvIHRoaXMgc3B1cmlvdXMga2ljaywgYnV0IEknbSBub3Qgc3Vy
ZSBpZiB0aGUgaHcKPiB3aWxsIHJlYWQgdGhlIHJpbmcgYmVmb3JlIHRoZSBraWNrIGFjdHVhbGx5
LiBJIGNhbiBhc2suCj4gCj4gVGhhbmtzIQo+IAo+IFsxXSBodHRwczovL2xpc3RzLm5vbmdudS5v
cmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMy0wMS9tc2cwMjc3NS5odG1sCgpMZXQncyBm
aW5kIG91dC4gV2UgbmVlZCB0byBjaGVjayBmb3IgRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyB0b28s
IG5vPwoKCgo+ID4gPiBNeSBwbGFuIHdhcyB0byBjb252ZXJ0Cj4gPiA+IGl0IGluIHZwX3ZkcGEg
aWYgbmVlZGVkLCBhbmQgcmV1c2UgdGhlIGN1cnJlbnQgdmRwYSBvcHMuIFNvcnJ5IGlmIEkKPiA+
ID4gd2FzIG5vdCBleHBsaWNpdCBlbm91Z2guCj4gPiA+Cj4gPiA+IFRoZSBvbmx5IHNvbHV0aW9u
IEkgY2FuIHNlZSB0byB0aGF0IGlzIHRvIHRyYXAgJiBlbXVsYXRlIGluIHRoZSB2ZHBhCj4gPiA+
IChwYXJlbnQ/KSBkcml2ZXIsIGFzIHRhbGtlZCBpbiB2aXJ0aW8tY29tbWVudC4gQnV0IHRoYXQg
Y29tcGxpY2F0ZXMKPiA+ID4gdGhlIGFyY2hpdGVjdHVyZToKPiA+ID4gKiBPZmZlciBWSE9TVF9C
QUNLRU5EX0ZfUklOR19BQ0NFU1NfQUZURVJfS0lDSwo+ID4gPiAqIFN0b3JlIHZxIGVuYWJsZSBz
dGF0ZSBzZXBhcmF0ZWx5LCBhdAo+ID4gPiB2ZHBhLT5jb25maWctPnNldF92cV9yZWFkeSh0cnVl
KSwgYnV0IG5vdCB0cmFuc21pdCB0aGF0IGVuYWJsZSB0byBodwo+ID4gPiAqIFN0b3JlIHRoZSBk
b29yYmVsbCBzdGF0ZSBzZXBhcmF0ZWx5LCBidXQgZG8gbm90IGNvbmZpZ3VyZSBpdCB0byB0aGUK
PiA+ID4gZGV2aWNlIGRpcmVjdGx5Lgo+ID4gPgo+ID4gPiBCdXQgaG93IHRvIHJlY292ZXIgaWYg
dGhlIGRldmljZSBjYW5ub3QgY29uZmlndXJlIHRoZW0gYXQga2ljayB0aW1lLAo+ID4gPiBmb3Ig
ZXhhbXBsZT8KPiA+ID4KPiA+ID4gTWF5YmUgd2UgY2FuIGp1c3QgZmFpbCBpZiB0aGUgcGFyZW50
IGRyaXZlciBkb2VzIG5vdCBzdXBwb3J0IGVuYWJsaW5nCj4gPiA+IHRoZSB2cSBhZnRlciBEUklW
RVJfT0s/IFRoYXQgd2F5IG5vIG5ldyBmZWF0dXJlIGZsYWcgaXMgbmVlZGVkLgo+ID4gPgo+ID4g
PiBUaGFua3MhCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gU2VudCB3aXRo
IEZpeGVzOiB0YWcgcG9pbnRpbmcgdG8gZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L21zdAo+ID4gPiA+ID4gY29tbWl0LiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSBzaG91
bGQgc2VuZCBhIHYzIG9mIFsxXSBpbnN0ZWFkLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFsxXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwNjA5MTIxMjQ0LW11dHQtc2VuZC1lbWFpbC1t
c3RAa2VybmVsLm9yZy9ULwo+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiAgZHJpdmVycy92aG9zdC92
ZHBhLmMgfCA3ICsrKysrLS0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+ID4gPiA+ID4KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiA+ID4gPiBpbmRleCBl
MWFiZjI5ZmVkNWIuLmE3ZTU1NDM1MjM1MSAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMv
dmhvc3QvdmRwYS5jCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiA+
ID4gQEAgLTY4MSwxOCArNjgxLDIxIEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRf
aW9jdGwoc3RydWN0IGZpbGUgKmZpbGVwLAo+ID4gPiA+ID4gIHsKPiA+ID4gPiA+ICAgICAgIHN0
cnVjdCB2aG9zdF92ZHBhICp2ID0gZmlsZXAtPnByaXZhdGVfZGF0YTsKPiA+ID4gPiA+ICAgICAg
IHN0cnVjdCB2aG9zdF9kZXYgKmQgPSAmdi0+dmRldjsKPiA+ID4gPiA+ICsgICAgIGNvbnN0IHN0
cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHYtPnZkcGEtPmNvbmZpZzsKPiA+ID4gPiA+ICAg
ICAgIHZvaWQgX191c2VyICphcmdwID0gKHZvaWQgX191c2VyICopYXJnOwo+ID4gPiA+ID4gICAg
ICAgdTY0IF9fdXNlciAqZmVhdHVyZXAgPSBhcmdwOwo+ID4gPiA+ID4gLSAgICAgdTY0IGZlYXR1
cmVzOwo+ID4gPiA+ID4gKyAgICAgdTY0IGZlYXR1cmVzLCBwYXJlbnRfZmVhdHVyZXMgPSAwOwo+
ID4gPiA+ID4gICAgICAgbG9uZyByID0gMDsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICBpZiAo
Y21kID09IFZIT1NUX1NFVF9CQUNLRU5EX0ZFQVRVUkVTKSB7Cj4gPiA+ID4gPiAgICAgICAgICAg
ICAgIGlmIChjb3B5X2Zyb21fdXNlcigmZmVhdHVyZXMsIGZlYXR1cmVwLCBzaXplb2YoZmVhdHVy
ZXMpKSkKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVGQVVMVDsKPiA+
ID4gPiA+ICsgICAgICAgICAgICAgaWYgKG9wcy0+Z2V0X2JhY2tlbmRfZmVhdHVyZXMpCj4gPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgcGFyZW50X2ZlYXR1cmVzID0gb3BzLT5nZXRfYmFj
a2VuZF9mZWF0dXJlcyh2LT52ZHBhKTsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgaWYgKGZlYXR1
cmVzICYgfihWSE9TVF9WRFBBX0JBQ0tFTkRfRkVBVFVSRVMgfAo+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpIHwK
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JB
Q0tFTkRfRl9SRVNVTUUpIHwKPiA+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVSX09LKSkpCj4gPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFyZW50X2ZlYXR1cmVzKSkKPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7Cj4gPiA+ID4g
PiAgICAgICAgICAgICAgIGlmICgoZmVhdHVyZXMgJiBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9T
VVNQRU5EKSkgJiYKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAhdmhvc3RfdmRwYV9jYW5f
c3VzcGVuZCh2KSkKPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiAyLjM5LjMKPiA+ID4gPgo+ID4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
