Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F51C7EE2A
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 05:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFEE84086E;
	Fri,  2 Jun 2023 05:03:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFEE84086E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A8N78Rlr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id miCX4GXZ0v_3; Fri,  2 Jun 2023 05:03:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C6D9C40879;
	Fri,  2 Jun 2023 05:03:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6D9C40879
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94F7BC0037;
	Fri,  2 Jun 2023 05:03:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA8AAC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 05:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F04760BF4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 05:03:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F04760BF4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=A8N78Rlr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aXwevYwijuh4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 05:03:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4DA4F60BDD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DA4F60BDD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 05:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685682201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sIus8gJyXRsINV2kC7yuh3plUDjK31JMCFZ/y6jp9No=;
 b=A8N78Rlr/gL9P+NJgpPDtSN1LzLG+VBGHlxx8+PZ1zBIa3AAq+vHHeQw4ZyZs362lQnL0/
 mwYYZNbBLketTpui8+yWMoZKKvC8sgfRr8y7kG0uv9lbAkknve7k8Nra9+RuhTGCgGm8xD
 T5Pyha+RjAQTZFq3tvVjPjVUEoSYn3M=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-zssVaXjXP6aAKPbmQOxvWg-1; Fri, 02 Jun 2023 01:03:19 -0400
X-MC-Unique: zssVaXjXP6aAKPbmQOxvWg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b168e97cdfso13012921fa.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Jun 2023 22:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685682198; x=1688274198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIus8gJyXRsINV2kC7yuh3plUDjK31JMCFZ/y6jp9No=;
 b=AuD2fGiUrbQVgwVLvAaN5SXq1tihbdvZtB49htjIOTgR3AG04fjRM/IFv9iDn2JJ6L
 u9VstRcZkmZfYCag4lT/GWdFEu4i6xLJcC9fLvrHQ7CdjOrev1ozOvb9zq1vGvqNS72F
 pRoNiCD+dVzzp86rsz8pF0KyZVYbEkElIVO5JabRrkT73vX2nSR7Aymo0a7LLAEFW8ZB
 P6GqgMuhtspbrmq4dG5Q8Nij23bCafCnlqkH8naugEfE4ai4wEIMNy/EJgSSUWFiaHtM
 Zlk1Nz7lIXze2X7gna2wr/k2w4+Mkaryjz4Ef8FmOxKHd6TZQ1T9SrEsa6R2w0GC/fGq
 AvQA==
X-Gm-Message-State: AC+VfDywYFlguR+clX6k356cO6B7d+I6Qa/NWzxCjWXHc22AQ2LjyUJG
 mxA3peQzMiQAAW919rbNpdzg8zfTTX3UQk3yK7ggDnIHGSmWCekdc16Tc1Uml7ZVSdX/ZDNZezs
 w1D6NOP4+35xH/nAAR2iNnXzcbY1cxmkqYOKiOiRcwcO0Igw3NEk9rQzDlQ==
X-Received: by 2002:a2e:9005:0:b0:2ad:ac93:3c7d with SMTP id
 h5-20020a2e9005000000b002adac933c7dmr834967ljg.38.1685682198387; 
 Thu, 01 Jun 2023 22:03:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4acTNwUqkxLVnp1Fp3xQamkPAm5e0xnQ7itKvZifc9MbO7W1sccpL2CPgJri2rUAflF0QjCvNNmlNGwY2oTuk=
X-Received: by 2002:a2e:9005:0:b0:2ad:ac93:3c7d with SMTP id
 h5-20020a2e9005000000b002adac933c7dmr834949ljg.38.1685682198003; Thu, 01 Jun
 2023 22:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
 <20230531072449.GA25046@redhat.com>
 <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
 <20230531091432.GB25046@redhat.com>
 <CACGkMEvNrC5gc4ppp0QG-SNSbs_snrqwPkNBotffRRDJA1VJjQ@mail.gmail.com>
 <20230601074315.GA13133@redhat.com>
In-Reply-To: <20230601074315.GA13133@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 2 Jun 2023 13:03:06 +0800
Message-ID: <CACGkMEss2LkUiUKaEkhBWwFDBBz31T3N94a0=zSD1d+Fhb1zyQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] fork,
 vhost: Use CLONE_THREAD to fix freezer/ps regression
To: Oleg Nesterov <oleg@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

T24gVGh1LCBKdW4gMSwgMjAyMyBhdCAzOjQz4oCvUE0gT2xlZyBOZXN0ZXJvdiA8b2xlZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+IE9uIDA2LzAxLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4KPiA+IE9u
IFdlZCwgTWF5IDMxLCAyMDIzIGF0IDU6MTTigK9QTSBPbGVnIE5lc3Rlcm92IDxvbGVnQHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiA+ID4gSSBkb24ndCB1bmRlcnN0YW5kIHlvdS4gT0ss
IHRvIHNpbXBsaWZ5LCBzdXBwb3NlIHdlIGhhdmUgMiBnbG9iYWwgdmFycwo+ID4gPiA+ID4KPiA+
ID4gPiA+ICAgICAgICAgdm9pZCAqUFRSID0gc29tZXRoaW5nX25vbl9udWxsOwo+ID4gPiA+ID4g
ICAgICAgICB1bnNpZ25lZCBsb25nIEZMQUdTID0gLTF1bDsKPiA+ID4gPiA+Cj4gPiA+ID4gPiBO
b3cgSSB0aGluayB0aGlzIGNvZGUKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgIENQVV8wICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQ1BVXzEKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAg
IHZvaWQgKnB0ciA9IFBUUjsgICAgICAgICAgICAgICAgaWYgKCF0ZXN0X2FuZF9zZXRfYml0KDAs
IEZMQUdTKSkKPiA+ID4gPiA+ICAgICAgICAgY2xlYXJfYml0KDAsIEZMQUdTKTsgICAgICAgICAg
ICAgICAgICAgIFBUUiA9IE5VTEw7Cj4gPiA+ID4gPiAgICAgICAgIEJVR19PTighcHRyKTsKPiA+
ID4gPiA+Cj4gPiA+ID4gPiBpcyByYWN5IGFuZCBjYW4gaGl0IHRoZSBCVUdfT04oIXB0cikuCj4g
PiA+ID4KPiA+ID4gPiBUaGlzIHNlZW1zIGRpZmZlcmVudCB0byB0aGUgYWJvdmUgY2FzZT8KPiA+
ID4KPiA+ID4gbm90IHN1cmUsCj4gPiA+Cj4gPiA+ID4gQW5kIHlvdSBjYW4gaGl0IEJVR19PTiB3
aXRoCj4gPiA+ID4gdGhlIGZvbGxvd2luZyBleGVjdXRpb24gc2VxdWVuY2U6Cj4gPiA+ID4KPiA+
ID4gPiBbY3B1IDBdIGNsZWFyX2JpdCgwLCBGTEFHUyk7Cj4gPiA+ID4gW2NwdSAxXSBpZiAoIXRl
c3RfYW5kX3NldF9iaXQoMCwgRkxBR1MpKQo+ID4gPiA+IFtjcHUgMV0gUFRSID0gTlVMTDsKPiA+
ID4gPiBbY3B1IDBdIEJVR19PTighcHRyKQo+ID4gPgo+ID4gPiBJIGRvbid0IHVuZGVyc3RhbmQg
dGhpcyBwYXJ0Li4uIHllcywgd2UgY2FuIGhpdCB0aGlzIEJVR19PTigpIHdpdGhvdXQgbWIgaW4K
PiA+ID4gYmV0d2VlbiwgdGhpcyBpcyB3aGF0IEkgdHJpZWQgdG8gc2F5Lgo+ID4KPiA+IEkgbWF5
IG1pc3Mgc29tZXRoaW5nLAo+Cj4gT3IgbWUuLi4gbm90ZSB0aGF0IENQVV8wIGxvYWRzIHRoZSBn
bG9iYWwgIlBUUiIgaW50byB0aGUgbG9jYWwgInB0ciIgYmVmb3JlIGNsZWFyX2JpdC4KPiBTaW5j
ZSB5b3UgaGF2ZSBtZW50aW9uZWQgdGhlIHByb2dyYW0gb3JkZXI6IHllcyB0aGlzIGxhY2tzIFJF
QURfT05DRSgpIG9yIGJhcnJpZXIoKSwKPiBidXQgdGhlIHNhbWUgaXMgdHJ1ZSBmb3IgdGhlIGNv
ZGUgaW4gdmhvc3Rfd29ya2VyKCkuIFNvIEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFuZC4KPgo+ID4g
YnV0IHRoZSBhYm92ZSBpcyB0aGUgc2VxdWVuY2UgdGhhdCBpcyBleGVjdXRlZAo+ID4gYnkgdGhl
IHByb2Nlc3NvciAoZm9yIGVhY2ggQ1BVLCBpdCdzIGp1c3QgdGhlIHByb2dyYW0gb3JkZXIpLiBT
byB3aGVyZQo+ID4gZG8geW91IGV4cGVjdCB0byBwbGFjZSBhbiBtYiBjYW4gaGVscD8KPgo+IGJl
Zm9yZSBjbGVhcl9iaXQ6Cj4KPiAgICAgICAgIENQVV8wCj4KPiAgICAgICAgIHZvaWQgKnB0ciA9
IFBUUjsKPiAgICAgICAgIG1iKCk7ICAgICAgICAgICAgICAgICAgIC8vIGltcGxpZXMgY29tcGls
ZXIgYmFycmllciBhcyB3ZWxsCj4gICAgICAgICBjbGVhcl9iaXQoMCwgRkxBR1MpOwo+ICAgICAg
ICAgQlVHX09OKCFwdHIpOwo+Cj4ganVzdCBpbiBjYXNlLi4uIG1iKCkgaW4gdGhlIGNvZGUgYWJv
dmUgaXMgb25seSBmb3IgaWxsdXN0cmF0aW9uLCB3ZSBjYW4gdXNlCj4gc21wX21iX19iZWZvcmVf
YXRvbWljKCkgKyBjbGVhcl9iaXQoKS4gT3IganVzdCBjbGVhcl9iaXRfdW5sb2NrKCksIGlpdWMg
dGhlCj4gb25lLXdheSBiYXJyaWVyIGlzIGZpbmUgaW4gdGhpcyBjYXNlLgoKT2ssIGJ1dCBpdCBz
ZWVtcyBkaWZmZXJlbnQsIGluIHRoZSBjYXNlIG9mIHZob3N0IHdlIGhhZCBhIGNvbmRpdGlvbgph
Ym92ZSB0aGUgY2xlYXJfYml0KCkuCgo+Cj4KPiA+ID4gPiBJbiB2aG9zdCBjb2RlLCB0aGVyZSdz
IGEgY29uZGl0aW9uIGJlZm9yZSB0aGUgY2xlYXJfYml0KCkgd2hpY2ggc2l0cwo+ID4gPiA+IGlu
c2lkZSBsbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKCk6Cj4gPiA+ID4KPiA+ID4gPiAjZGVmaW5l
IGxsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocG9zLCBuLCBub2RlLCBtZW1iZXIpICAgICAgICAg
ICAgICAgICAgICAgICAgXAo+ID4gPiA+ICAgICAgICAgZm9yIChwb3MgPSBsbGlzdF9lbnRyeSgo
bm9kZSksIHR5cGVvZigqcG9zKSwgbWVtYmVyKTsgICAgICAgICAgICAgICAgICBcCj4gPiA+ID4g
ICAgICAgICAgICAgIG1lbWJlcl9hZGRyZXNzX2lzX25vbm51bGwocG9zLCBtZW1iZXIpICYmICAg
ICAgICAgICAgICAgICAgICAgICAgIFwKPiA+ID4gPiAgICAgICAgICAgICAgICAgKG4gPSBsbGlz
dF9lbnRyeShwb3MtPm1lbWJlci5uZXh0LCB0eXBlb2YoKm4pLCBtZW1iZXIpLCB0cnVlKTsgXAo+
ID4gPiA+ICAgICAgICAgICAgICBwb3MgPSBuKQo+ID4gPiA+Cj4gPiA+ID4gVGhlIGNsZWFyX2Jp
dCgpIGlzIGEgc3RvcmUgd2hpY2ggaXMgbm90IHNwZWN1bGF0ZWQsIHNvIHRoZXJlJ3MgYQo+ID4g
PiA+IGNvbnRyb2wgZGVwZW5kZW5jeSwgdGhlIHN0b3JlIGNhbid0IGJlIGV4ZWN1dGVkIHVudGls
IHRoZSBjb25kaXRpb24KPiA+ID4gPiBleHByZXNzaW9uIGlzIGV2YWx1YXRlZCB3aGljaCByZXF1
aXJlcyBwb3MtPm1lbWJlci5uZXh0Cj4gPiA+ID4gKHdvcmstPm5vZGUubmV4dCkgdG8gYmUgbG9h
ZGVkLgo+ID4gPgo+ID4gPiBCdXQgbGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSgpIGRvZXNuJ3Qg
Y2hlY2sgIm4iLCBJIG1lYW4sIGl0IGlzIG5vdCB0aGF0IHdlIGhhdmUKPiA+ID4gc29tZXRoaW5n
IGxpa2UKPiA+ID4KPiA+ID4gICAgICAgICBuID0gbGxpc3RfZW50cnkoLi4uKTsKPiA+ID4gICAg
ICAgICBpZiAobikKPiA+ID4gICAgICAgICAgICAgICAgIGNsZWFyX2JpdCguLi4pOwo+ID4gPgo+
ID4gPiBzbyBJIGRvIG5vdCBzZWUgaG93IGNhbiB3ZSByZWx5IG9uIHRoZSBsb2FkLXN0b3JlIGNv
bnRyb2wgZGVwZW5kZW5jeS4KPiA+Cj4gPiBKdXN0IHRvIG1ha2Ugc3VyZSB3ZSBhcmUgb24gdGhl
IHNhbWUgcGFnZSwgdGhlIGNvbmRpdGlvbiBleHByZXNzaW9uIGlzCj4gPgo+ID4gbWVtYmVyX2Fk
ZHJlc3NfaXNfbm9ubnVsbChwb3MsIG1lbWJlcikgJiYgKG4gPQo+ID4gbGxpc3RfZW50cnkocG9z
LT5tZW1iZXIubmV4dCwgdHlwZW9mKCpuKSwgbWVtYmVyKSwgdHJ1ZSkKPiA+Cj4gPiBTbyBpdCdz
IHNvbWV0aGluZyBsaWtlOgo+ID4KPiA+IGlmICh3b3JrLT5ub2RlICYmICh3b3JrX25leHQgPSB3
b3JrLT5ub2RlLT5uZXh0LCB0cnVlKSkKPiA+ICAgICBjbGVhcl9iaXQoJndvcmstPmZsYWdzKTsK
PiA+Cj4gPiBTbyB0d28gbG9hZHMgZnJvbSBib3RoIHdvcmstPm5vZGUgYW5kIHdvcmstPm5vZGUt
Pm5leHQsIGFuZCB0aGVyZSdzIGEKPiA+IHN0b3JlIHdoaWNoIGlzIGNsZWFyX2JpdCwgdGhlbiBp
dCdzIGEgbG9hZC1zdG9yZSBjb250cm9sIGRlcGVuZGVuY2llcz8KPgo+IEkgZ3Vlc3MgeW91IG1p
c3NlZCB0aGUgY29tbWEgZXhwcmVzc2lvbi4uLgoKUHJvYmFibHkgbm90LCBzZWUgYmVsb3c6Cgo+
IExldCBtZSByZXdyaXRlIHlvdXIgcHNldWRvLWNvZGUKPiBhYm92ZSwgaXQgaXMgZXF1aXZhbGVu
dCB0bwo+Cj4gICAgICAgICBpZiAod29yay0+bm9kZSkgewo+ICAgICAgICAgICAgICAgICBpZiAo
KHdvcmtfbmV4dCA9IHdvcmstPm5vZGUtPm5leHQsIHRydWUpKQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGNsZWFyX2JpdCgmd29yay0+ZmxhZ3MpOwo+ICAgICAgICAgfQo+Cj4gYW5vdGhlciBy
ZXdyaXRlOgo+Cj4gICAgICAgICBpZiAod29yay0+bm9kZSkgewo+ICAgICAgICAgICAgICAgICB3
b3JrX25leHQgPSB3b3JrLT5ub2RlLT5uZXh0Owo+ICAgICAgICAgICAgICAgICBpZiAoKHdvcmss
IHRydWUpKQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNsZWFyX2JpdCgmd29yay0+ZmxhZ3Mp
Owo+ICAgICAgICAgfQo+Cj4gYW5kIHRoZSBmaW5hbCByZXdyaXRlOgo+Cj4gICAgICAgICBpZiAo
d29yay0+bm9kZSkgewo+ICAgICAgICAgICAgICAgICB3b3JrX25leHQgPSB3b3JrLT5ub2RlLT5u
ZXh0Owo+ICAgICAgICAgICAgICAgICBpZiAodHJ1ZSkKPiAgICAgICAgICAgICAgICAgICAgICAg
ICBjbGVhcl9iaXQoJndvcmstPmZsYWdzKTsKPiAgICAgICAgIH0KPgo+IHNvIGFnYWluLCBJIGRv
IG5vdCBzZWUgdGhlIGxvYWQtc3RvcmUgY29udHJvbCBkZXBlbmRlbmN5LgoKVGhpcyBraW5kIG9m
IG9wdGltaXphdGlvbiBpcyBzdXNwaWNpb3VzLiBFc3BlY2lhbGx5IGNvbnNpZGVyaW5nIGl0J3MK
dGhlIGNvbnRyb2wgZXhwcmVzc2lvbiBvZiB0aGUgbG9vcCBidXQgbm90IGEgY29uZGl0aW9uLgoK
TG9va2luZyBhdCB0aGUgYXNzZW1ibHkgKHg4Nik6CgogICAweGZmZmZmZmZmODFkNDZjNWIgPCs3
NT46ICAgIGNhbGxxICAweGZmZmZmZmZmODE2ODlhYzAgPGxsaXN0X3JldmVyc2Vfb3JkZXI+CiAg
IDB4ZmZmZmZmZmY4MWQ0NmM2MCA8KzgwPjogICAgbW92ICAgICVyYXgsJXIxNQogICAweGZmZmZm
ZmZmODFkNDZjNjMgPCs4Mz46ICAgIHRlc3QgICAlcmF4LCVyYXgKICAgMHhmZmZmZmZmZjgxZDQ2
YzY2IDwrODY+OiAgICBqZSAgICAgMHhmZmZmZmZmZjgxZDQ2YzNhIDx2aG9zdF93b3JrZXIrNDI+
CiAgIDB4ZmZmZmZmZmY4MWQ0NmM2OCA8Kzg4PjogICAgbW92ICAgICVyMTUsJXJkaQogICAweGZm
ZmZmZmZmODFkNDZjNmIgPCs5MT46ICAgIG1vdiAgICAoJXIxNSksJXIxNQogICAweGZmZmZmZmZm
ODFkNDZjNmUgPCs5ND46ICAgIGxvY2sgYW5kYiAkMHhmZCwweDEwKCVyZGkpCiAgIDB4ZmZmZmZm
ZmY4MWQ0NmM3MyA8Kzk5PjogICAgbW92bCAgICQweDAsMHgxOCglcmJ4KQogICAweGZmZmZmZmZm
ODFkNDZjN2EgPCsxMDY+OiAgIG1vdiAgICAweDgoJXJkaSksJXJheAogICAweGZmZmZmZmZmODFk
NDZjN2UgPCsxMTA+OiAgIGNhbGxxICAweGZmZmZmZmZmODIxYjM5YTAKPF9feDg2X2luZGlyZWN0
X3RodW5rX2FycmF5PgogICAweGZmZmZmZmZmODFkNDZjODMgPCsxMTU+OiAgIGNhbGxxICAweGZm
ZmZmZmZmODIxYjRkMTAgPF9fU0NUX19jb25kX3Jlc2NoZWQ+Ci4uLgoKSSBjYW4gc2VlOgoKMSkg
VGhlIGNvZGUgcmVhZCBub2RlLT5uZXh0ICgrOTEpIGJlZm9yZSBjbGVhcl9iaXQgKCs5NCkKMikg
QW5kIHRoZSBpdCB1c2VzIGEgbG9jayBwcmVmaXggdG8gZ3VhcmFudGVlIHRoZSBleGVjdXRpb24g
b3JkZXIKCj4gTm90IHRvIG1lbnRpb24gdGhpcwo+IGNvZGUgbGFja3MgUkVBRF9PTkNFKCkuCgpX
b3JrX25leHQgaXMgbG9hZGVkIG9ubHkgb25jZSBmb3IgdGVtcG9yYXJ5IHN0b3JhZ2UsIHNvIEkg
ZG9uJ3Qgc2VlCndoeSB3ZSBuZWVkIHRoYXQuCgpUaGFua3MKCgoKPgo+Cj4gSWYgd2UgaGFkIHNv
bWV0aGluZyBsaWtlCj4KPiAgICAgICAgIGlmICh3b3JrLT5ub2RlKSB7Cj4gICAgICAgICAgICAg
ICAgIHdvcmtfbmV4dCA9IFJFQURfT05DRSh3b3JrLT5ub2RlLT5uZXh0KTsKPiAgICAgICAgICAg
ICAgICAgaWYgKHdvcmtfbmV4dCkKPiAgICAgICAgICAgICAgICAgICAgICAgICBjbGVhcl9iaXQo
JndvcmstPmZsYWdzKTsKPiAgICAgICAgIH0KPgo+IGluc3RlYWQsIHRoZW4geWVzLCB3ZSBjb3Vs
ZCByZWx5IG9uIHRoZSBMT0FELVNUT1JFIGRlcGVuZGVuY3kuCj4KPiBPbGVnLgo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
