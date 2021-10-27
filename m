Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06CDC433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 02:55:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEF36103B
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 02:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3FEF36103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0478F60685;
	Wed, 27 Oct 2021 02:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bypywd3Jkvmp; Wed, 27 Oct 2021 02:55:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9CFC96064D;
	Wed, 27 Oct 2021 02:55:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74A0BC0012;
	Wed, 27 Oct 2021 02:55:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85A8DC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6166A60685
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9fXtXO7-C1WF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:55:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5E7A6064D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635303318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XHXmq/zKeHW5Yih9b0wK27BhnoEgmOvb8teFUuALgk=;
 b=OJqnkvd2tzc6bZT2/EgplH8qeRgqRqE+Ku/pUBDjH36q14hyg7YWxF4GBsDfTKRhuSuomz
 UZ9rytsewFID5Gv3dmjqXW3L1UNm6VjdgyqXJvbGQ05Ja+amVQpJk+bVV09UR/C77jND2a
 E02qDH2GwAWOJerlJobPXaGGrohPrR8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-en-LaqHePAa4_a0W__Ctlw-1; Tue, 26 Oct 2021 22:55:17 -0400
X-MC-Unique: en-LaqHePAa4_a0W__Ctlw-1
Received: by mail-lf1-f72.google.com with SMTP id
 g10-20020a05651222ca00b003fda3f05c17so677279lfu.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 19:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8XHXmq/zKeHW5Yih9b0wK27BhnoEgmOvb8teFUuALgk=;
 b=J5Vl9YioX5nx3wG0HjGznp1zEtaRFJl5R9sTcydlIual9CiHN/TnzPz0rjgWP00Vlr
 DfbvIYgKMD8k6C5dth/0CAcnudnj3ybV65xXHa0UYPAFX8WK5ER81VOlQLvkeepSti+H
 xgYTkrt80Ko4NcE+hkMdUEHwAHtDLE0TUUZ6UkfZqznZlSUFfkkJqw2XiD0+qMQet2nJ
 ICglN52bYMyU+tCCQbTXMt+D7+96ITiit+cc9sdSi2fsv8T22W1PquZXq7R1pcFl5ZLi
 LlgrfYtMmbRH6VpZseEofdtIaAvX0W3pfcVKkWlbNKEuPHHom4WAMa/NToQmXApgHp9+
 NeWA==
X-Gm-Message-State: AOAM533E0zg7zT6hv+pIbEV/60JrwpOKhUfVzyZvAJ4ybX5DEzhKdEbi
 iWaxa1c0NXa4v9TK9TL7BebLnqj1YhSIzt7ymRalSWyBrJg5qH48eSHWL/ivQP1stEYnDG0EPAo
 2QrSMvAHL6YU5JCPDjlinYYl1SL062MmyDj+BawlBzcb0yTY03+NCqyaadw==
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr29841565ljp.307.1635303315588; 
 Tue, 26 Oct 2021 19:55:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyl6bcCWF9TvAy4gzBetlOvaHhdNtU2DeVxvPHRicHeJzfD6Z0vZaZjJVuP5wXMH+9xO8MEAzOcU1OKkMy3n0E=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr29841546ljp.307.1635303315380; 
 Tue, 26 Oct 2021 19:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <20211022051911.108383-13-michael.christie@oracle.com>
 <8aee8f07-76bd-f111-bc5f-fc5cad46ce56@redhat.com>
 <YXgiYFIUTKtoRJWW@stefanha-x1.localdomain>
In-Reply-To: <YXgiYFIUTKtoRJWW@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Oct 2021 10:55:04 +0800
Message-ID: <CACGkMEsD=JwjWgTM4XpcKVy+ZKs6siW_1Q=3zzB8jZ3vq1CyZA@mail.gmail.com>
Subject: Re: [PATCH V3 11/11] vhost: allow userspace to create workers
To: Stefan Hajnoczi <stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-scsi@vger.kernel.org, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 target-devel@vger.kernel.org, pbonzini <pbonzini@redhat.com>
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

T24gVHVlLCBPY3QgMjYsIDIwMjEgYXQgMTE6NDUgUE0gU3RlZmFuIEhham5vY3ppIDxzdGVmYW5o
YUByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgT2N0IDI2LCAyMDIxIGF0IDAxOjM3OjE0
UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPgo+ID4g5ZyoIDIwMjEvMTAvMjIg5LiL5Y2I
MToxOSwgTWlrZSBDaHJpc3RpZSDlhpnpgZM6Cj4gPiA+IFRoaXMgcGF0Y2ggYWxsb3dzIHVzZXJz
cGFjZSB0byBjcmVhdGUgd29ya2VycyBhbmQgYmluZCB0aGVtIHRvIHZxcy4gWW91Cj4gPiA+IGNh
biBoYXZlIE4gd29ya2VycyBwZXIgZGV2IGFuZCBhbHNvIHNoYXJlIE4gd29ya2VycyB3aXRoIE0g
dnFzLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNaWtlIENocmlzdGllIDxtaWNoYWVsLmNo
cmlzdGllQG9yYWNsZS5jb20+Cj4gPgo+ID4KPiA+IEEgcXVlc3Rpb24sIHdobyBpcyB0aGUgYmVz
dCBvbmUgdG8gZGV0ZXJtaW5lIHRoZSBiaW5kaW5nPyBJcyBpdCB0aGUgVk1NCj4gPiAoUWVtdSBl
dGMpIG9yIHRoZSBtYW5hZ2VtZW50IHN0YWNrPyBJZiB0aGUgbGF0dGVyLCBpdCBsb29rcyB0byBt
ZSBpdCdzCj4gPiBiZXR0ZXIgdG8gZXhwb3NlIHRoaXMgdmlhIHN5c2ZzPwo+Cj4gQSBmZXcgb3B0
aW9ucyB0aGF0IGxldCB0aGUgbWFuYWdlbWVudCBzdGFjayBjb250cm9sIHZob3N0IHdvcmtlciBD
UFUKPiBhZmZpbml0eToKPgo+IDEuIFRoZSBtYW5hZ2VtZW50IHRvb2wgb3BlbnMgdGhlIHZob3N0
IGRldmljZSBub2RlLCBjYWxscwo+ICAgIGlvY3RsKFZIT1NUX1NFVF9WUklOR19XT1JLRVIpLCBz
ZXRzIHVwIENQVSBhZmZpbml0eSwgYW5kIHRoZW4gcGFzc2VzCj4gICAgdGhlIGZkIHRvIHRoZSBW
TU0uIEluIHRoaXMgY2FzZSB0aGUgVk1NIGlzIHN0aWxsIGFibGUgdG8gY2FsbCB0aGUKPiAgICBp
b2N0bCwgd2hpY2ggbWF5IGJlIHVuZGVzaXJhYmxlIGZyb20gYW4gYXR0YWNrIHN1cmZhY2UgcGVy
c3BlY3RpdmUuCgpZZXMsIGFuZCB3ZSBjYW4ndCBkbyBwb3N0IG9yIGR5bmFtaWMgY29uZmlndXJh
dGlvbiBhZnRlcndhcmRzIGFmdGVyCnRoZSBWTSBpcyBsYXVuY2hlZD8KCj4KPiAyLiBUaGUgVk1N
IGNhbGxzIGlvY3RsKFZIT1NUX1NFVF9WUklOR19XT1JLRVIpIGl0c2VsZiBhbmQgdGhlIG1hbmFn
ZW1lbnQKPiAgICB0b29sIHF1ZXJpZXMgdGhlIHZxOndvcmtlciBkZXRhaWxzIGZyb20gdGhlIFZN
TSAoZS5nLiBhIG5ldyBRRU1VIFFNUAo+ICAgIHF1ZXJ5LXZob3N0LXdvcmtlcnMgY29tbWFuZCBz
aW1pbGFyIHRvIHF1ZXJ5LWlvdGhyZWFkcykuIFRoZQo+ICAgIG1hbmFnZW1lbnQgdG9vbCBjYW4g
dGhlbiBjb250cm9sIENQVSBhZmZpbml0eSBvbiB0aGUgdmhvc3Qgd29ya2VyCj4gICAgdGhyZWFk
cy4KPgo+ICAgIChUaGlzIGlzIGhvdyBDUFUgYWZmaW5pdHkgd29ya3MgaW4gUUVNVSBhbmQgbGli
dmlydCB0b2RheS4pCgpUaGVuIHdlIGFsc28gbmVlZCBhICJiaW5kLXZob3N0LXdvcmtlcnMiIGNv
bW1hbmQuCgo+Cj4gMy4gVGhlIHN5c2ZzIGFwcHJvYWNoIHlvdSBzdWdnZXN0ZWQuIERvZXMgc3lz
ZnMgZXhwb3J0IHZxLTAvLCB2cS0xLywgZXRjCj4gICAgZGlyZWN0b3JpZXMgd2l0aCBhICJ3b3Jr
ZXIiIGF0dHJpYnV0ZT8KClNvbWV0aGluZyBsaWtlIHRoaXMuCgo+IERvIHdlIG5lZWQgdG8gZGVm
aW5lIGEgcG9pbnQKPiAgICB3aGVuIHRoZSBWTU0gaGFzIHNldCB1cCB2cXMgYW5kIHRoZSBtYW5h
Z2VtZW50IHN0YWNrIGlzIGFibGUgdG8gcXVlcnkKPiAgICB0aGVtPwoKSXQgY291bGQgYmUgdGhl
IHBvaW50IHRoYXQgdGhlIHZob3N0IGZkIGlzIG9wZW5lZC4KCj4gIFZob3N0IGRldmljZXMgY3Vy
cmVudGx5IHByZS1hbGxvY2F0ZSB0aGUgbWF4aW11bSBudW1iZXIgb2YgdnFzCj4gICAgYW5kIEkn
bSBub3Qgc3VyZSBob3cgdG8gZGV0ZXJtaW5lIHRoZSBudW1iZXIgb2YgdnFzIHRoYXQgd2lsbAo+
ICAgIGFjdHVhbGx5IGJlIHVzZWQ/CgpJdCByZXF1aXJlcyBtb3JlIGluZm9ybWF0aW9uIHRvIGJl
IGV4cG9zZWQuIEJ1dCBiZWZvcmUgdGhpcywgd2Ugc2hvdWxkCmFsbG93IHRoZSBkeW5hbWljIGJp
bmRpbmcgb2YgYmV0d2VlbiB2cSBhbmQgd29ya2VyLgoKPgo+ICAgIE9uZSBhZHZhbnRhZ2Ugb2Yg
dGhpcyBpcyB0aGF0IGFjY2VzcyB0byB0aGUgdnE6d29ya2VyIG1hcHBpbmcgY2FuIGJlCj4gICAg
bGltaXRlZCB0byB0aGUgbWFuYWdlbWVudCBzdGFjayBhbmQgdGhlIFZNTSBjYW5ub3QgYWNjZXNz
IGl0LiBCdXQgaXQKPiAgICBzZWVtcyBhIGxpdHRsZSB0cmlja3kgYmVjYXVzZSB0aGUgdmhvc3Qg
bW9kZWwgdG9kYXkgZG9lc24ndCB1c2Ugc3lzZnMKPiAgICBvciBkZWZpbmUgYSBsaWZlY3ljbGUg
d2hlcmUgdGhlIG1hbmFnZW1lbnQgc3RhY2sgY2FuIGNvbmZpZ3VyZQo+ICAgIGRldmljZXMuCgpZ
ZXMuCgpUaGFua3MKCj4KPiBTdGVmYW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
