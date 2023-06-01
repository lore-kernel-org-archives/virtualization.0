Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A269CC77B7E
	for <virtualization@archiver.kernel.org>; Thu,  1 Jun 2023 07:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A43F41BA2;
	Thu,  1 Jun 2023 07:43:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A43F41BA2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W33fsJRy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id krKo9fx8Il0T; Thu,  1 Jun 2023 07:43:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 439E541BB3;
	Thu,  1 Jun 2023 07:43:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 439E541BB3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10505C007A;
	Thu,  1 Jun 2023 07:43:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84076C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F651405A7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:43:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F651405A7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=W33fsJRy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GDwGC_DOdoHK
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:43:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 84ED0402E0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84ED0402E0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685605423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvJ0J/2Ad97d0Y3oIleyJnXlsfA2gT2V2y9NzKFld6k=;
 b=W33fsJRyfQFpaZvvCI3q98ntjxaqCffNyvLEViNombKeJ3G4iydrHk41kddWcH3YWajEAt
 0tNjud6y2jYzA+zl5VM+C+t2ptvnT6jSuZQ8pngLKt92GUMmQ0SBEuOXsr76OTxwMUUE8x
 56qLnOos1Gc2/4IcCb/cJrjaTtU1aJw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-qCUySRT8PqyLHtBT12q-rA-1; Thu, 01 Jun 2023 03:43:40 -0400
X-MC-Unique: qCUySRT8PqyLHtBT12q-rA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56EA885A5BB;
 Thu,  1 Jun 2023 07:43:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.135])
 by smtp.corp.redhat.com (Postfix) with SMTP id 5C07B2166B25;
 Thu,  1 Jun 2023 07:43:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Thu,  1 Jun 2023 09:43:20 +0200 (CEST)
Date: Thu, 1 Jun 2023 09:43:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230601074315.GA13133@redhat.com>
References: <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
 <20230531072449.GA25046@redhat.com>
 <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
 <20230531091432.GB25046@redhat.com>
 <CACGkMEvNrC5gc4ppp0QG-SNSbs_snrqwPkNBotffRRDJA1VJjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACGkMEvNrC5gc4ppp0QG-SNSbs_snrqwPkNBotffRRDJA1VJjQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

T24gMDYvMDEsIEphc29uIFdhbmcgd3JvdGU6Cj4KPiBPbiBXZWQsIE1heSAzMSwgMjAyMyBhdCA1
OjE04oCvUE0gT2xlZyBOZXN0ZXJvdiA8b2xlZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiA+
ID4gSSBkb24ndCB1bmRlcnN0YW5kIHlvdS4gT0ssIHRvIHNpbXBsaWZ5LCBzdXBwb3NlIHdlIGhh
dmUgMiBnbG9iYWwgdmFycwo+ID4gPiA+Cj4gPiA+ID4gICAgICAgICB2b2lkICpQVFIgPSBzb21l
dGhpbmdfbm9uX251bGw7Cj4gPiA+ID4gICAgICAgICB1bnNpZ25lZCBsb25nIEZMQUdTID0gLTF1
bDsKPiA+ID4gPgo+ID4gPiA+IE5vdyBJIHRoaW5rIHRoaXMgY29kZQo+ID4gPiA+Cj4gPiA+ID4g
ICAgICAgICBDUFVfMCAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVV8xCj4gPiA+ID4KPiA+
ID4gPiAgICAgICAgIHZvaWQgKnB0ciA9IFBUUjsgICAgICAgICAgICAgICAgaWYgKCF0ZXN0X2Fu
ZF9zZXRfYml0KDAsIEZMQUdTKSkKPiA+ID4gPiAgICAgICAgIGNsZWFyX2JpdCgwLCBGTEFHUyk7
ICAgICAgICAgICAgICAgICAgICBQVFIgPSBOVUxMOwo+ID4gPiA+ICAgICAgICAgQlVHX09OKCFw
dHIpOwo+ID4gPiA+Cj4gPiA+ID4gaXMgcmFjeSBhbmQgY2FuIGhpdCB0aGUgQlVHX09OKCFwdHIp
Lgo+ID4gPgo+ID4gPiBUaGlzIHNlZW1zIGRpZmZlcmVudCB0byB0aGUgYWJvdmUgY2FzZT8KPiA+
Cj4gPiBub3Qgc3VyZSwKPiA+Cj4gPiA+IEFuZCB5b3UgY2FuIGhpdCBCVUdfT04gd2l0aAo+ID4g
PiB0aGUgZm9sbG93aW5nIGV4ZWN1dGlvbiBzZXF1ZW5jZToKPiA+ID4KPiA+ID4gW2NwdSAwXSBj
bGVhcl9iaXQoMCwgRkxBR1MpOwo+ID4gPiBbY3B1IDFdIGlmICghdGVzdF9hbmRfc2V0X2JpdCgw
LCBGTEFHUykpCj4gPiA+IFtjcHUgMV0gUFRSID0gTlVMTDsKPiA+ID4gW2NwdSAwXSBCVUdfT04o
IXB0cikKPiA+Cj4gPiBJIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBwYXJ0Li4uIHllcywgd2UgY2Fu
IGhpdCB0aGlzIEJVR19PTigpIHdpdGhvdXQgbWIgaW4KPiA+IGJldHdlZW4sIHRoaXMgaXMgd2hh
dCBJIHRyaWVkIHRvIHNheS4KPgo+IEkgbWF5IG1pc3Mgc29tZXRoaW5nLAoKT3IgbWUuLi4gbm90
ZSB0aGF0IENQVV8wIGxvYWRzIHRoZSBnbG9iYWwgIlBUUiIgaW50byB0aGUgbG9jYWwgInB0ciIg
YmVmb3JlIGNsZWFyX2JpdC4KU2luY2UgeW91IGhhdmUgbWVudGlvbmVkIHRoZSBwcm9ncmFtIG9y
ZGVyOiB5ZXMgdGhpcyBsYWNrcyBSRUFEX09OQ0UoKSBvciBiYXJyaWVyKCksCmJ1dCB0aGUgc2Ft
ZSBpcyB0cnVlIGZvciB0aGUgY29kZSBpbiB2aG9zdF93b3JrZXIoKS4gU28gSSBzdGlsbCBkb24n
dCB1bmRlcnN0YW5kLgoKPiBidXQgdGhlIGFib3ZlIGlzIHRoZSBzZXF1ZW5jZSB0aGF0IGlzIGV4
ZWN1dGVkCj4gYnkgdGhlIHByb2Nlc3NvciAoZm9yIGVhY2ggQ1BVLCBpdCdzIGp1c3QgdGhlIHBy
b2dyYW0gb3JkZXIpLiBTbyB3aGVyZQo+IGRvIHlvdSBleHBlY3QgdG8gcGxhY2UgYW4gbWIgY2Fu
IGhlbHA/CgpiZWZvcmUgY2xlYXJfYml0OgoKCUNQVV8wCgoJdm9pZCAqcHRyID0gUFRSOwoJbWIo
KTsJCQkvLyBpbXBsaWVzIGNvbXBpbGVyIGJhcnJpZXIgYXMgd2VsbAoJY2xlYXJfYml0KDAsIEZM
QUdTKTsKCUJVR19PTighcHRyKTsKCmp1c3QgaW4gY2FzZS4uLiBtYigpIGluIHRoZSBjb2RlIGFi
b3ZlIGlzIG9ubHkgZm9yIGlsbHVzdHJhdGlvbiwgd2UgY2FuIHVzZQpzbXBfbWJfX2JlZm9yZV9h
dG9taWMoKSArIGNsZWFyX2JpdCgpLiBPciBqdXN0IGNsZWFyX2JpdF91bmxvY2soKSwgaWl1YyB0
aGUKb25lLXdheSBiYXJyaWVyIGlzIGZpbmUgaW4gdGhpcyBjYXNlLgoKCj4gPiA+IEluIHZob3N0
IGNvZGUsIHRoZXJlJ3MgYSBjb25kaXRpb24gYmVmb3JlIHRoZSBjbGVhcl9iaXQoKSB3aGljaCBz
aXRzCj4gPiA+IGluc2lkZSBsbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKCk6Cj4gPiA+Cj4gPiA+
ICNkZWZpbmUgbGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShwb3MsIG4sIG5vZGUsIG1lbWJlcikg
ICAgICAgICAgICAgICAgICAgICAgICBcCj4gPiA+ICAgICAgICAgZm9yIChwb3MgPSBsbGlzdF9l
bnRyeSgobm9kZSksIHR5cGVvZigqcG9zKSwgbWVtYmVyKTsgICAgICAgICAgICAgICAgICBcCj4g
PiA+ICAgICAgICAgICAgICBtZW1iZXJfYWRkcmVzc19pc19ub25udWxsKHBvcywgbWVtYmVyKSAm
JiAgICAgICAgICAgICAgICAgICAgICAgICBcCj4gPiA+ICAgICAgICAgICAgICAgICAobiA9IGxs
aXN0X2VudHJ5KHBvcy0+bWVtYmVyLm5leHQsIHR5cGVvZigqbiksIG1lbWJlciksIHRydWUpOyBc
Cj4gPiA+ICAgICAgICAgICAgICBwb3MgPSBuKQo+ID4gPgo+ID4gPiBUaGUgY2xlYXJfYml0KCkg
aXMgYSBzdG9yZSB3aGljaCBpcyBub3Qgc3BlY3VsYXRlZCwgc28gdGhlcmUncyBhCj4gPiA+IGNv
bnRyb2wgZGVwZW5kZW5jeSwgdGhlIHN0b3JlIGNhbid0IGJlIGV4ZWN1dGVkIHVudGlsIHRoZSBj
b25kaXRpb24KPiA+ID4gZXhwcmVzc2lvbiBpcyBldmFsdWF0ZWQgd2hpY2ggcmVxdWlyZXMgcG9z
LT5tZW1iZXIubmV4dAo+ID4gPiAod29yay0+bm9kZS5uZXh0KSB0byBiZSBsb2FkZWQuCj4gPgo+
ID4gQnV0IGxsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoKSBkb2Vzbid0IGNoZWNrICJuIiwgSSBt
ZWFuLCBpdCBpcyBub3QgdGhhdCB3ZSBoYXZlCj4gPiBzb21ldGhpbmcgbGlrZQo+ID4KPiA+ICAg
ICAgICAgbiA9IGxsaXN0X2VudHJ5KC4uLik7Cj4gPiAgICAgICAgIGlmIChuKQo+ID4gICAgICAg
ICAgICAgICAgIGNsZWFyX2JpdCguLi4pOwo+ID4KPiA+IHNvIEkgZG8gbm90IHNlZSBob3cgY2Fu
IHdlIHJlbHkgb24gdGhlIGxvYWQtc3RvcmUgY29udHJvbCBkZXBlbmRlbmN5Lgo+Cj4gSnVzdCB0
byBtYWtlIHN1cmUgd2UgYXJlIG9uIHRoZSBzYW1lIHBhZ2UsIHRoZSBjb25kaXRpb24gZXhwcmVz
c2lvbiBpcwo+Cj4gbWVtYmVyX2FkZHJlc3NfaXNfbm9ubnVsbChwb3MsIG1lbWJlcikgJiYgKG4g
PQo+IGxsaXN0X2VudHJ5KHBvcy0+bWVtYmVyLm5leHQsIHR5cGVvZigqbiksIG1lbWJlciksIHRy
dWUpCj4KPiBTbyBpdCdzIHNvbWV0aGluZyBsaWtlOgo+Cj4gaWYgKHdvcmstPm5vZGUgJiYgKHdv
cmtfbmV4dCA9IHdvcmstPm5vZGUtPm5leHQsIHRydWUpKQo+ICAgICBjbGVhcl9iaXQoJndvcmst
PmZsYWdzKTsKPgo+IFNvIHR3byBsb2FkcyBmcm9tIGJvdGggd29yay0+bm9kZSBhbmQgd29yay0+
bm9kZS0+bmV4dCwgYW5kIHRoZXJlJ3MgYQo+IHN0b3JlIHdoaWNoIGlzIGNsZWFyX2JpdCwgdGhl
biBpdCdzIGEgbG9hZC1zdG9yZSBjb250cm9sIGRlcGVuZGVuY2llcz8KCkkgZ3Vlc3MgeW91IG1p
c3NlZCB0aGUgY29tbWEgZXhwcmVzc2lvbi4uLiBMZXQgbWUgcmV3cml0ZSB5b3VyIHBzZXVkby1j
b2RlCmFib3ZlLCBpdCBpcyBlcXVpdmFsZW50IHRvCgoJaWYgKHdvcmstPm5vZGUpIHsKCQlpZiAo
KHdvcmtfbmV4dCA9IHdvcmstPm5vZGUtPm5leHQsIHRydWUpKQoJCQljbGVhcl9iaXQoJndvcmst
PmZsYWdzKTsKCX0KCmFub3RoZXIgcmV3cml0ZToKCQoJaWYgKHdvcmstPm5vZGUpIHsKCQl3b3Jr
X25leHQgPSB3b3JrLT5ub2RlLT5uZXh0OwoJCWlmICgod29yaywgdHJ1ZSkpCgkJCWNsZWFyX2Jp
dCgmd29yay0+ZmxhZ3MpOwoJfQoKYW5kIHRoZSBmaW5hbCByZXdyaXRlOgoKCWlmICh3b3JrLT5u
b2RlKSB7CgkJd29ya19uZXh0ID0gd29yay0+bm9kZS0+bmV4dDsKCQlpZiAodHJ1ZSkKCQkJY2xl
YXJfYml0KCZ3b3JrLT5mbGFncyk7Cgl9CgpzbyBhZ2FpbiwgSSBkbyBub3Qgc2VlIHRoZSBsb2Fk
LXN0b3JlIGNvbnRyb2wgZGVwZW5kZW5jeS4gTm90IHRvIG1lbnRpb24gdGhpcwpjb2RlIGxhY2tz
IFJFQURfT05DRSgpLgoKCklmIHdlIGhhZCBzb21ldGhpbmcgbGlrZQoKCWlmICh3b3JrLT5ub2Rl
KSB7CgkJd29ya19uZXh0ID0gUkVBRF9PTkNFKHdvcmstPm5vZGUtPm5leHQpOwoJCWlmICh3b3Jr
X25leHQpCgkJCWNsZWFyX2JpdCgmd29yay0+ZmxhZ3MpOwoJfQoKaW5zdGVhZCwgdGhlbiB5ZXMs
IHdlIGNvdWxkIHJlbHkgb24gdGhlIExPQUQtU1RPUkUgZGVwZW5kZW5jeS4KCk9sZWcuCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
