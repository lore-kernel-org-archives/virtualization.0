Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C6CC77B7A
	for <virtualization@archiver.kernel.org>; Wed, 31 May 2023 09:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77B7E82037;
	Wed, 31 May 2023 09:15:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 77B7E82037
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QVDqCTnu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OQFyd-9Q61P9; Wed, 31 May 2023 09:15:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0860781F64;
	Wed, 31 May 2023 09:15:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0860781F64
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9B0DC007C;
	Wed, 31 May 2023 09:15:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C7A5C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 09:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1815D408E3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 09:15:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1815D408E3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QVDqCTnu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zShSc_6n8vCv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 09:15:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF441400E0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF441400E0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685524500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ir4H/Z1/r0sZbaFI9Fc11zZLFNyyd0qULW+BtXwpIUM=;
 b=QVDqCTnuansOR9NJaxk8Z10XbP0Kt4b6hqtXNtgQBDlGEyT/rdjaJO2cTfmc0Fm5Ox3vAG
 B87sPDCqH1My8ms1mmQ8FwZZkpIEgrBdLTHwklBJ0acaKuIHjLIODcY0eQFLAFcRiB3jbr
 FLai8Qtc1kImxKsD2zakgLUXc5qRXfc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-vhu6RDiDO0Ckd4-MKb7pKA-1; Wed, 31 May 2023 05:14:57 -0400
X-MC-Unique: vhu6RDiDO0Ckd4-MKb7pKA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94D77811E86;
 Wed, 31 May 2023 09:14:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.238])
 by smtp.corp.redhat.com (Postfix) with SMTP id 7F606492B0A;
 Wed, 31 May 2023 09:14:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Wed, 31 May 2023 11:14:36 +0200 (CEST)
Date: Wed, 31 May 2023 11:14:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230531091432.GB25046@redhat.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
 <20230531072449.GA25046@redhat.com>
 <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com, linux@leemhuis.info,
 linux-kernel@vger.kernel.org, ebiederm@xmission.com, stefanha@redhat.com,
 nicolas.dichtel@6wind.com, virtualization@lists.linux-foundation.org,
 torvalds@linux-foundation.org
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

T24gMDUvMzEsIEphc29uIFdhbmcgd3JvdGU6Cj4KPiBPbiBXZWQsIE1heSAzMSwgMjAyMyBhdCAz
OjI14oCvUE0gT2xlZyBOZXN0ZXJvdiA8b2xlZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBP
biAwNS8zMSwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4KPiA+ID4g5ZyoIDIwMjMvNS8yMyAyMDox
NSwgT2xlZyBOZXN0ZXJvdiDlhpnpgZM6Cj4gPiA+ID4KPiA+ID4gPiAgICAgICAgICAgICAvKiBt
YWtlIHN1cmUgZmxhZyBpcyBzZWVuIGFmdGVyIGRlbGV0aW9uICovCj4gPiA+ID4gICAgICAgICAg
ICAgc21wX3dtYigpOwo+ID4gPiA+ICAgICAgICAgICAgIGxsaXN0X2Zvcl9lYWNoX2VudHJ5X3Nh
ZmUod29yaywgd29ya19uZXh0LCBub2RlLCBub2RlKSB7Cj4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICBjbGVhcl9iaXQoVkhPU1RfV09SS19RVUVVRUQsICZ3b3JrLT5mbGFncyk7Cj4gPiA+ID4K
PiA+ID4gPkkgYW0gbm90IHN1cmUgYWJvdXQgc21wX3dtYiArIGNsZWFyX2JpdC4gT25jZSB3ZSBj
bGVhciBWSE9TVF9XT1JLX1FVRVVFRCwKPiA+ID4gPnZob3N0X3dvcmtfcXVldWUoKSBjYW4gYWRk
IHRoaXMgd29yayBhZ2FpbiBhbmQgY2hhbmdlIHdvcmstPm5vZGUtPm5leHQuCj4gPiA+ID4KPiA+
ID4gPlRoYXQgaXMgd2h5IHdlIHVzZSBfc2FmZSwgYnV0IHdlIG5lZWQgdG8gZW5zdXJlIHRoYXQg
bGxpc3RfZm9yX2VhY2hfc2FmZSgpCj4gPiA+ID5jb21wbGV0ZXMgTE9BRCh3b3JrLT5ub2RlLT5u
ZXh0KSBiZWZvcmUgVkhPU1RfV09SS19RVUVVRUQgaXMgY2xlYXJlZC4KPiA+ID4KPiA+ID4gVGhp
cyBzaG91bGQgYmUgZmluZSBzaW5jZSBzdG9yZSBpcyBub3Qgc3BlY3VsYXRlZCwgc28gd29yay0+
bm9kZS0+bmV4dCBuZWVkcwo+ID4gPiB0byBiZSBsb2FkZWQgYmVmb3JlIFZIT1NUX1dPUktfUVVF
VUVEIGlzIGNsZWFyZWQgdG8gbWVldCB0aGUgbG9vcCBjb25kaXRpb24uCj4gPgo+ID4gSSBkb24n
dCB1bmRlcnN0YW5kIHlvdS4gT0ssIHRvIHNpbXBsaWZ5LCBzdXBwb3NlIHdlIGhhdmUgMiBnbG9i
YWwgdmFycwo+ID4KPiA+ICAgICAgICAgdm9pZCAqUFRSID0gc29tZXRoaW5nX25vbl9udWxsOwo+
ID4gICAgICAgICB1bnNpZ25lZCBsb25nIEZMQUdTID0gLTF1bDsKPiA+Cj4gPiBOb3cgSSB0aGlu
ayB0aGlzIGNvZGUKPiA+Cj4gPiAgICAgICAgIENQVV8wICAgICAgICAgICAgICAgICAgICAgICAg
ICAgQ1BVXzEKPiA+Cj4gPiAgICAgICAgIHZvaWQgKnB0ciA9IFBUUjsgICAgICAgICAgICAgICAg
aWYgKCF0ZXN0X2FuZF9zZXRfYml0KDAsIEZMQUdTKSkKPiA+ICAgICAgICAgY2xlYXJfYml0KDAs
IEZMQUdTKTsgICAgICAgICAgICAgICAgICAgIFBUUiA9IE5VTEw7Cj4gPiAgICAgICAgIEJVR19P
TighcHRyKTsKPiA+Cj4gPiBpcyByYWN5IGFuZCBjYW4gaGl0IHRoZSBCVUdfT04oIXB0cikuCj4K
PiBUaGlzIHNlZW1zIGRpZmZlcmVudCB0byB0aGUgYWJvdmUgY2FzZT8KCm5vdCBzdXJlLAoKPiBB
bmQgeW91IGNhbiBoaXQgQlVHX09OIHdpdGgKPiB0aGUgZm9sbG93aW5nIGV4ZWN1dGlvbiBzZXF1
ZW5jZToKPgo+IFtjcHUgMF0gY2xlYXJfYml0KDAsIEZMQUdTKTsKPiBbY3B1IDFdIGlmICghdGVz
dF9hbmRfc2V0X2JpdCgwLCBGTEFHUykpCj4gW2NwdSAxXSBQVFIgPSBOVUxMOwo+IFtjcHUgMF0g
QlVHX09OKCFwdHIpCgpJIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBwYXJ0Li4uIHllcywgd2UgY2Fu
IGhpdCB0aGlzIEJVR19PTigpIHdpdGhvdXQgbWIgaW4KYmV0d2VlbiwgdGhpcyBpcyB3aGF0IEkg
dHJpZWQgdG8gc2F5LgoKPiBJbiB2aG9zdCBjb2RlLCB0aGVyZSdzIGEgY29uZGl0aW9uIGJlZm9y
ZSB0aGUgY2xlYXJfYml0KCkgd2hpY2ggc2l0cwo+IGluc2lkZSBsbGlzdF9mb3JfZWFjaF9lbnRy
eV9zYWZlKCk6Cj4KPiAjZGVmaW5lIGxsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocG9zLCBuLCBu
b2RlLCBtZW1iZXIpICAgICAgICAgICAgICAgICAgICAgICAgXAo+ICAgICAgICAgZm9yIChwb3Mg
PSBsbGlzdF9lbnRyeSgobm9kZSksIHR5cGVvZigqcG9zKSwgbWVtYmVyKTsgICAgICAgICAgICAg
ICAgICBcCj4gICAgICAgICAgICAgIG1lbWJlcl9hZGRyZXNzX2lzX25vbm51bGwocG9zLCBtZW1i
ZXIpICYmICAgICAgICAgICAgICAgICAgICAgICAgIFwKPiAgICAgICAgICAgICAgICAgKG4gPSBs
bGlzdF9lbnRyeShwb3MtPm1lbWJlci5uZXh0LCB0eXBlb2YoKm4pLCBtZW1iZXIpLCB0cnVlKTsg
XAo+ICAgICAgICAgICAgICBwb3MgPSBuKQo+Cj4gVGhlIGNsZWFyX2JpdCgpIGlzIGEgc3RvcmUg
d2hpY2ggaXMgbm90IHNwZWN1bGF0ZWQsIHNvIHRoZXJlJ3MgYQo+IGNvbnRyb2wgZGVwZW5kZW5j
eSwgdGhlIHN0b3JlIGNhbid0IGJlIGV4ZWN1dGVkIHVudGlsIHRoZSBjb25kaXRpb24KPiBleHBy
ZXNzaW9uIGlzIGV2YWx1YXRlZCB3aGljaCByZXF1aXJlcyBwb3MtPm1lbWJlci5uZXh0Cj4gKHdv
cmstPm5vZGUubmV4dCkgdG8gYmUgbG9hZGVkLgoKQnV0IGxsaXN0X2Zvcl9lYWNoX2VudHJ5X3Nh
ZmUoKSBkb2Vzbid0IGNoZWNrICJuIiwgSSBtZWFuLCBpdCBpcyBub3QgdGhhdCB3ZSBoYXZlCnNv
bWV0aGluZyBsaWtlCgoJbiA9IGxsaXN0X2VudHJ5KC4uLik7CglpZiAobikKCQljbGVhcl9iaXQo
Li4uKTsKCnNvIEkgZG8gbm90IHNlZSBob3cgY2FuIHdlIHJlbHkgb24gdGhlIGxvYWQtc3RvcmUg
Y29udHJvbCBkZXBlbmRlbmN5LgoKT2xlZy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
