Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46ED5C77B7C
	for <virtualization@archiver.kernel.org>; Wed, 31 May 2023 07:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B299F405F9;
	Wed, 31 May 2023 07:25:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B299F405F9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gRR/WGpe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XjotOT2Ms8Ff; Wed, 31 May 2023 07:25:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 41B7640141;
	Wed, 31 May 2023 07:25:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41B7640141
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BA70C007C;
	Wed, 31 May 2023 07:25:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A1BBC0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 07:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46E4C60C1D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 07:25:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46E4C60C1D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gRR/WGpe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VKfdM12OCExb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 07:25:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 902C060BF2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 902C060BF2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 07:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685517936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N34/mNWQwnGZ07cT22bXzRfAdms5vf9xTB7hi2yghbc=;
 b=gRR/WGpe8yNfKfewvM5ES50cYNjMVaBRr8B07izMMaD2OLTGVYRmpGMJAHtSnT5thaHnko
 zvpq64JyW1maSIZgRwu5qvFtIUI1KIwkXFIPGMvpUqowlLYruYyFquni43J6tsx8RNhdUB
 RQ1Ohp6dUmYSWHudmvB80GJHYt3pkEs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-RzkGs-_iNSSyNN3HlogBmw-1; Wed, 31 May 2023 03:25:34 -0400
X-MC-Unique: RzkGs-_iNSSyNN3HlogBmw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FEB7185A7A5;
 Wed, 31 May 2023 07:25:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.238])
 by smtp.corp.redhat.com (Postfix) with SMTP id 6B5E5492B0A;
 Wed, 31 May 2023 07:25:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Wed, 31 May 2023 09:25:14 +0200 (CEST)
Date: Wed, 31 May 2023 09:25:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230531072449.GA25046@redhat.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
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

T24gMDUvMzEsIEphc29uIFdhbmcgd3JvdGU6Cj4KPiDlnKggMjAyMy81LzIzIDIwOjE1LCBPbGVn
IE5lc3Rlcm92IOWGmemBkzoKPiA+Cj4gPgkJLyogbWFrZSBzdXJlIGZsYWcgaXMgc2VlbiBhZnRl
ciBkZWxldGlvbiAqLwo+ID4JCXNtcF93bWIoKTsKPiA+CQlsbGlzdF9mb3JfZWFjaF9lbnRyeV9z
YWZlKHdvcmssIHdvcmtfbmV4dCwgbm9kZSwgbm9kZSkgewo+ID4JCQljbGVhcl9iaXQoVkhPU1Rf
V09SS19RVUVVRUQsICZ3b3JrLT5mbGFncyk7Cj4gPgo+ID5JIGFtIG5vdCBzdXJlIGFib3V0IHNt
cF93bWIgKyBjbGVhcl9iaXQuIE9uY2Ugd2UgY2xlYXIgVkhPU1RfV09SS19RVUVVRUQsCj4gPnZo
b3N0X3dvcmtfcXVldWUoKSBjYW4gYWRkIHRoaXMgd29yayBhZ2FpbiBhbmQgY2hhbmdlIHdvcmst
Pm5vZGUtPm5leHQuCj4gPgo+ID5UaGF0IGlzIHdoeSB3ZSB1c2UgX3NhZmUsIGJ1dCB3ZSBuZWVk
IHRvIGVuc3VyZSB0aGF0IGxsaXN0X2Zvcl9lYWNoX3NhZmUoKQo+ID5jb21wbGV0ZXMgTE9BRCh3
b3JrLT5ub2RlLT5uZXh0KSBiZWZvcmUgVkhPU1RfV09SS19RVUVVRUQgaXMgY2xlYXJlZC4KPgo+
IFRoaXMgc2hvdWxkIGJlIGZpbmUgc2luY2Ugc3RvcmUgaXMgbm90IHNwZWN1bGF0ZWQsIHNvIHdv
cmstPm5vZGUtPm5leHQgbmVlZHMKPiB0byBiZSBsb2FkZWQgYmVmb3JlIFZIT1NUX1dPUktfUVVF
VUVEIGlzIGNsZWFyZWQgdG8gbWVldCB0aGUgbG9vcCBjb25kaXRpb24uCgpJIGRvbid0IHVuZGVy
c3RhbmQgeW91LiBPSywgdG8gc2ltcGxpZnksIHN1cHBvc2Ugd2UgaGF2ZSAyIGdsb2JhbCB2YXJz
CgoJdm9pZCAqUFRSID0gc29tZXRoaW5nX25vbl9udWxsOwoJdW5zaWduZWQgbG9uZyBGTEFHUyA9
IC0xdWw7CgpOb3cgSSB0aGluayB0aGlzIGNvZGUKCglDUFVfMAkJCQlDUFVfMQoKCXZvaWQgKnB0
ciA9IFBUUjsJCWlmICghdGVzdF9hbmRfc2V0X2JpdCgwLCBGTEFHUykpCgljbGVhcl9iaXQoMCwg
RkxBR1MpOwkJCVBUUiA9IE5VTEw7CglCVUdfT04oIXB0cik7CgppcyByYWN5IGFuZCBjYW4gaGl0
IHRoZSBCVUdfT04oIXB0cikuCgpJIGd1ZXNzIGl0IGlzIGZpbmUgb24geDg2LCBidXQgaW4gZ2Vu
ZXJhbCB5b3UgbmVlZCBzbXBfbWJfX2JlZm9yZV9hdG9taWMoKQpiZWZvcmUgY2xlYXJfYml0KCks
IG9yIGNsZWFyX2JpdF91bmxvY2soKS4KCj4gPgkJCV9fc2V0X2N1cnJlbnRfc3RhdGUoVEFTS19S
VU5OSU5HKTsKPiA+Cj4gPldoeSBkbyB3ZSBzZXQgVEFTS19SVU5OSU5HIGluc2lkZSB0aGUgbG9v
cD8gRG9lcyB0aGlzIG1lYW4gdGhhdCB3b3JrLT5mbigpCj4gPmNhbiByZXR1cm4gd2l0aCBjdXJy
ZW50LT5zdGF0ZSAhPSBSVU5OSU5HID8KPgo+IEl0IGlzIGJlY2F1c2UgdGhlIHN0YXRlIHdlcmUg
c2V0IHRvIFRBU0tfSU5URVJSVVBUSUJMRSBpbiB0aGUgYmVnaW5uaW5nIG9mCj4gdGhlIGxvb3Ag
b3RoZXJ3aXNlIGl0IG1pZ2h0IGJlIHNpZGUgZWZmZWN0IHdoaWxlIGV4ZWN1dGluZyB3b3JrLT5m
bigpLgoKQWdhaW4sIEkgZG9uJ3QgdW5kZXJzdGFuZCB5b3UuIFNvIGxldCBtZSByZXBlYXQ6IGNh
biB3b3JrLT5mbigpIHJldHVybiB3aXRoCmN1cnJlbnQtPl9zdGF0ZSAhPSBUQVNLX1JVTk5JTkcg
PyBJZiBub3QgKGFuZCBJJ2Qgc2F5IGl0IHNob3VsZCBub3QpLCB5b3UgY2FuCmRvIF9fc2V0X2N1
cnJlbnRfc3RhdGUoVEFTS19SVU5OSU5HKSBvbmNlLCBiZWZvcmUgbGxpc3RfZm9yX2VhY2hfZW50
cnlfc2FmZSgpLgoKPiA+Tm93IHRoZSBtYWluIHF1ZXN0aW9uLiBXaGF0ZXZlciB3ZSBkbywgU0lH
S0lMTC9TSUdTVE9QL2V0YyBjYW4gY29tZSByaWdodAo+ID5iZWZvcmUgd2UgY2FsbCB3b3JrLT5m
bigpLiBJcyBpdCAic2FmZSIgdG8gcnVuIHRoaXMgY2FsbGJhY2sgd2l0aAo+ID5zaWduYWxfcGVu
ZGluZygpIG9yIGZhdGFsX3NpZ25hbF9wZW5kaW5nKCkgPwo+Cj4gSXQgbG9va3Mgc2FmZSBzaW5j
ZToKPgo+IDEpIHZob3N0IGhvbGQgcmVmY250IG9mIHRoZSBtbQo+IDIpIHJlbGVhc2Ugd2lsbCBz
eW5jIHdpdGggdGhlIHdvcmtlcgoKV2VsbCwgdGhhdCdzIG5vdCB3aGF0IEkgYXNrZWQuLi4gbmV2
ZXJtaW5kLCBwbGVhc2UgZm9yZ2V0LgoKVGhhbmtzLgoKT2xlZy4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
