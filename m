Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342D7C6FD1D
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 07:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC33140494;
	Tue,  4 Apr 2023 07:08:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC33140494
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CYffNFQ+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lCpr-L0OXik3; Tue,  4 Apr 2023 07:08:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 36A1140129;
	Tue,  4 Apr 2023 07:08:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 36A1140129
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B75DC0036;
	Tue,  4 Apr 2023 07:08:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50FDCC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1484A40173
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:08:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1484A40173
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CYffNFQ+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VPxOn0Wc39QC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:08:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15BDB40060
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 15BDB40060
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680592092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0rGG2EMT4oXWuoldIM2c0q03B9p8XZ9smw4HLg6lhkk=;
 b=CYffNFQ+jNFRoktnV1Hwaq/519fDokN15G9qA0GkNhsehS7EACKb6BTPjAZJIwUs1reT3q
 IPeivCLDUjivt3ne5yc6UMhhJnZtrzXbtoAoR/ljYJL+wVn/kh7BV+1ZLGYoUgo7Zpbtn2
 d9vFcwHVD3rcvRQ/6ceaQa07moSzgDA=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-m_JB5ZzrMEOgBfSB-7t3eg-1; Tue, 04 Apr 2023 03:08:10 -0400
X-MC-Unique: m_JB5ZzrMEOgBfSB-7t3eg-1
Received: by mail-oi1-f197.google.com with SMTP id
 q127-20020acaf285000000b00386dec7a02bso7835633oih.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 00:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680592090; x=1683184090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rGG2EMT4oXWuoldIM2c0q03B9p8XZ9smw4HLg6lhkk=;
 b=6XytdUdhNROLkKfkpkPnm4GJs6eKrx76vcYg6ZSiBDmLDkV+VW2bI/xBSUxSl5vKXi
 lXJ5OfpYWY52XYbgU+tTl9p5FOFx0H9w9gMMcQPUp1GpRYXECs8xMUMMuloZBWWEHsFu
 k3FmSf2XLIPPOYRtOYcQgJK9N/liwT9RgBhnrZbetT5VRQBtFYRWzsu0KAksg4nfn3Cr
 zX+5m/SnbxHWCOHi0c0KN1CJXH//KWai6YUOAHRYwFDnkwu+D2MoRjvkWyefFwJCTYYv
 0po9vXaVIeq12qxaoUU1YckfnWOgg9Rp6H85qhgHDwn16rAPOfSMENrAVYfi4/2/AD+k
 gyow==
X-Gm-Message-State: AAQBX9dVqejUh/CQrU0qMPAS/K6CAjgN/NJH0gqduehqzEvYYaw8JGvV
 CttBifVulDYSW9KyngWtIS6j/iHxr9BJ5gOaPdOXJyJfxU0LcqMT9nezvz0RNYOojCDuxBOH8zw
 A0ABhgURIykxIE1QoBrXegTilN6VmsXMMNzVAk2U46HpSyFRJMOVf6gNwmw==
X-Received: by 2002:a9d:6a5a:0:b0:69f:8fa8:1a4f with SMTP id
 h26-20020a9d6a5a000000b0069f8fa81a4fmr577674otn.2.1680592090121; 
 Tue, 04 Apr 2023 00:08:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZbWBUhKsvCOEtGWV4YyRxqBuqxsZ9scB8jtiFtuhoJk01ltHuB+kgTZjNrBtyNfOtIi1+hdr29S1kKD6GSiBY=
X-Received: by 2002:a9d:6a5a:0:b0:69f:8fa8:1a4f with SMTP id
 h26-20020a9d6a5a000000b0069f8fa81a4fmr577669otn.2.1680592089918; Tue, 04 Apr
 2023 00:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230328021717.42268-1-michael.christie@oracle.com>
 <20230328021717.42268-4-michael.christie@oracle.com>
In-Reply-To: <20230328021717.42268-4-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Apr 2023 15:07:59 +0800
Message-ID: <CACGkMEuJ6tdcXoDOn5wEHgd+gxOiEkedGs+X0wgRXb4JSMW3jQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/11] vhost: take worker or vq instead of dev for
 queueing
To: Mike Christie <michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 mst@redhat.com
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

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMTA6MTfigK9BTSBNaWtlIENocmlzdGllCjxtaWNoYWVs
LmNocmlzdGllQG9yYWNsZS5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaCBoYXMgdGhlIGNvcmUg
d29yayBxdWV1ZWluZyBmdW5jdGlvbiB0YWtlIGEgd29ya2VyIGZvciB3aGVuIHdlCj4gc3VwcG9y
dCBtdWx0aXBsZSB3b3JrZXJzLiBJdCBhbHNvIGFkZHMgYSBoZWxwZXIgdGhhdCB0YWtlcyBhIHZx
IGR1cmluZwo+IHF1ZXVlaW5nIHNvIG1vZHVsZXMgY2FuIGNvbnRyb2wgd2hpY2ggdnEvd29ya2Vy
IHRvIHF1ZXVlIHdvcmsgb24uCj4KPiBUaGlzIHRlbXAgbGVhdmVzIHZob3N0X3dvcmtfcXVldWUu
IEl0IHdpbGwgYmUgcmVtb3ZlZCB3aGVuIHRoZSBkcml2ZXJzCj4gYXJlIGNvbnZlcnRlZCBpbiB0
aGUgbmV4dCBwYXRjaGVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWlrZSBDaHJpc3RpZSA8bWljaGFl
bC5jaHJpc3RpZUBvcmFjbGUuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8IDQ0ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KPiAgZHJpdmVycy92aG9z
dC92aG9zdC5oIHwgIDEgKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDE2
IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2Ry
aXZlcnMvdmhvc3Qvdmhvc3QuYwo+IGluZGV4IDY1NjdhZWQ2OWViYi4uY2MyNjI4YmE5YTc3IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qv
dmhvc3QuYwo+IEBAIC0yMzEsNiArMjMxLDM0IEBAIHZvaWQgdmhvc3RfcG9sbF9zdG9wKHN0cnVj
dCB2aG9zdF9wb2xsICpwb2xsKQo+ICB9Cj4gIEVYUE9SVF9TWU1CT0xfR1BMKHZob3N0X3BvbGxf
c3RvcCk7Cj4KPiArc3RhdGljIHZvaWQgdmhvc3Rfd29ya19xdWV1ZV9vbihzdHJ1Y3Qgdmhvc3Rf
d29ya2VyICp3b3JrZXIsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
dmhvc3Rfd29yayAqd29yaykKPiArewo+ICsgICAgICAgaWYgKCF3b3JrZXIpCj4gKyAgICAgICAg
ICAgICAgIHJldHVybjsKPiArCj4gKyAgICAgICBpZiAoIXRlc3RfYW5kX3NldF9iaXQoVkhPU1Rf
V09SS19RVUVVRUQsICZ3b3JrLT5mbGFncykpIHsKPiArICAgICAgICAgICAgICAgLyogV2UgY2Fu
IG9ubHkgYWRkIHRoZSB3b3JrIHRvIHRoZSBsaXN0IGFmdGVyIHdlJ3JlCj4gKyAgICAgICAgICAg
ICAgICAqIHN1cmUgaXQgd2FzIG5vdCBpbiB0aGUgbGlzdC4KPiArICAgICAgICAgICAgICAgICog
dGVzdF9hbmRfc2V0X2JpdCgpIGltcGxpZXMgYSBtZW1vcnkgYmFycmllci4KPiArICAgICAgICAg
ICAgICAgICovCj4gKyAgICAgICAgICAgICAgIGxsaXN0X2FkZCgmd29yay0+bm9kZSwgJndvcmtl
ci0+d29ya19saXN0KTsKPiArICAgICAgICAgICAgICAgd2FrZV91cF9wcm9jZXNzKHdvcmtlci0+
dnRzay0+dGFzayk7Cj4gKyAgICAgICB9Cj4gK30KPiArCj4gK3ZvaWQgdmhvc3Rfd29ya19xdWV1
ZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHN0cnVjdCB2aG9zdF93b3JrICp3b3JrKQo+ICt7Cj4g
KyAgICAgICB2aG9zdF93b3JrX3F1ZXVlX29uKGRldi0+d29ya2VyLCB3b3JrKTsKPiArfQo+ICtF
WFBPUlRfU1lNQk9MX0dQTCh2aG9zdF93b3JrX3F1ZXVlKTsKPiArCj4gK3ZvaWQgdmhvc3RfdnFf
d29ya19xdWV1ZShzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2cSwgc3RydWN0IHZob3N0X3dvcmsg
KndvcmspCj4gK3sKPiArICAgICAgIHZob3N0X3dvcmtfcXVldWVfb24odnEtPndvcmtlciwgd29y
ayk7Cj4gK30KPiArRVhQT1JUX1NZTUJPTF9HUEwodmhvc3RfdnFfd29ya19xdWV1ZSk7Cj4gKwo+
ICB2b2lkIHZob3N0X2Rldl9mbHVzaChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gIHsKPiAgICAg
ICAgIHN0cnVjdCB2aG9zdF9mbHVzaF9zdHJ1Y3QgZmx1c2g7Cj4gQEAgLTI0NSwyMiArMjczLDYg
QEAgdm9pZCB2aG9zdF9kZXZfZmx1c2goc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ICB9Cj4gIEVY
UE9SVF9TWU1CT0xfR1BMKHZob3N0X2Rldl9mbHVzaCk7Cj4KPiAtdm9pZCB2aG9zdF93b3JrX3F1
ZXVlKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgc3RydWN0IHZob3N0X3dvcmsgKndvcmspCj4gLXsK
PiAtICAgICAgIGlmICghZGV2LT53b3JrZXIpCj4gLSAgICAgICAgICAgICAgIHJldHVybjsKPiAt
Cj4gLSAgICAgICBpZiAoIXRlc3RfYW5kX3NldF9iaXQoVkhPU1RfV09SS19RVUVVRUQsICZ3b3Jr
LT5mbGFncykpIHsKPiAtICAgICAgICAgICAgICAgLyogV2UgY2FuIG9ubHkgYWRkIHRoZSB3b3Jr
IHRvIHRoZSBsaXN0IGFmdGVyIHdlJ3JlCj4gLSAgICAgICAgICAgICAgICAqIHN1cmUgaXQgd2Fz
IG5vdCBpbiB0aGUgbGlzdC4KPiAtICAgICAgICAgICAgICAgICogdGVzdF9hbmRfc2V0X2JpdCgp
IGltcGxpZXMgYSBtZW1vcnkgYmFycmllci4KPiAtICAgICAgICAgICAgICAgICovCj4gLSAgICAg
ICAgICAgICAgIGxsaXN0X2FkZCgmd29yay0+bm9kZSwgJmRldi0+d29ya2VyLT53b3JrX2xpc3Qp
Owo+IC0gICAgICAgICAgICAgICB3YWtlX3VwX3Byb2Nlc3MoZGV2LT53b3JrZXItPnZ0c2stPnRh
c2spOwo+IC0gICAgICAgfQo+IC19Cj4gLUVYUE9SVF9TWU1CT0xfR1BMKHZob3N0X3dvcmtfcXVl
dWUpOwo+IC0KPiAgLyogQSBsb2NrbGVzcyBoaW50IGZvciBidXN5IHBvbGxpbmcgY29kZSB0byBl
eGl0IHRoZSBsb29wICovCj4gIGJvb2wgdmhvc3RfdnFfaGFzX3dvcmsoc3RydWN0IHZob3N0X3Zp
cnRxdWV1ZSAqdnEpCj4gIHsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92aG9zdC5oIGIv
ZHJpdmVycy92aG9zdC92aG9zdC5oCj4gaW5kZXggMGRkZTExOWZiMGVlLi5iNjRlZTRlZjM4N2Qg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5oCj4gKysrIGIvZHJpdmVycy92aG9z
dC92aG9zdC5oCj4gQEAgLTE5NCw2ICsxOTQsNyBAQCBpbnQgdmhvc3RfZ2V0X3ZxX2Rlc2Moc3Ry
dWN0IHZob3N0X3ZpcnRxdWV1ZSAqLAo+ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhv
c3RfbG9nICpsb2csIHVuc2lnbmVkIGludCAqbG9nX251bSk7Cj4gIHZvaWQgdmhvc3RfZGlzY2Fy
ZF92cV9kZXNjKHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKiwgaW50IG4pOwo+Cj4gK3ZvaWQgdmhv
c3RfdnFfd29ya19xdWV1ZShzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2cSwgc3RydWN0IHZob3N0
X3dvcmsgKndvcmspOwo+ICBib29sIHZob3N0X3ZxX2hhc193b3JrKHN0cnVjdCB2aG9zdF92aXJ0
cXVldWUgKnZxKTsKPiAgYm9vbCB2aG9zdF92cV9pc19zZXR1cChzdHJ1Y3Qgdmhvc3RfdmlydHF1
ZXVlICp2cSk7Cj4gIGludCB2aG9zdF92cV9pbml0X2FjY2VzcyhzdHJ1Y3Qgdmhvc3RfdmlydHF1
ZXVlICopOwo+IC0tCj4gMi4yNS4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
