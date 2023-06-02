Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C966C7EE29
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 17:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9CD9C4020B;
	Fri,  2 Jun 2023 17:59:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9CD9C4020B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=abSWuJys
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UVy_rwepn7j7; Fri,  2 Jun 2023 17:59:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2967E40A8D;
	Fri,  2 Jun 2023 17:59:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2967E40A8D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2472C0037;
	Fri,  2 Jun 2023 17:59:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE945C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 17:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8229616A5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 17:59:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8229616A5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=abSWuJys
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BCPAASmhs-Ye
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 17:59:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2CE161458
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2CE161458
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685728767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vEfy4ABvbNm71f6wJfPO0YUTrGmZR9PK0H6cIJhbRw=;
 b=abSWuJysw7fwpk4xV/ySYfNpwdSuqRYLYAUcUa0q4pAfshcQROlA/mfbY43F11nYKg7EOP
 UciJLWjz4kIVRNgoOlVGGXcjJwIRSmAM/UAnAo6p9MCPmImlSUdbgY50DC0qoFpTVgol4o
 2FNlNdisUno9tox0oerPLeWNh2bgsks=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-nTsWchWkPnyhyWDJbcXr9A-1; Fri, 02 Jun 2023 13:59:24 -0400
X-MC-Unique: nTsWchWkPnyhyWDJbcXr9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB2033C14116;
 Fri,  2 Jun 2023 17:59:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
 by smtp.corp.redhat.com (Postfix) with SMTP id 0193FC154D7;
 Fri,  2 Jun 2023 17:59:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Fri,  2 Jun 2023 19:59:02 +0200 (CEST)
Date: Fri, 2 Jun 2023 19:58:47 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230602175846.GC555@redhat.com>
References: <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
 <20230531072449.GA25046@redhat.com>
 <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
 <20230531091432.GB25046@redhat.com>
 <CACGkMEvNrC5gc4ppp0QG-SNSbs_snrqwPkNBotffRRDJA1VJjQ@mail.gmail.com>
 <20230601074315.GA13133@redhat.com>
 <CACGkMEss2LkUiUKaEkhBWwFDBBz31T3N94a0=zSD1d+Fhb1zyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACGkMEss2LkUiUKaEkhBWwFDBBz31T3N94a0=zSD1d+Fhb1zyQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

T24gMDYvMDIsIEphc29uIFdhbmcgd3JvdGU6Cj4KPiBPbiBUaHUsIEp1biAxLCAyMDIzIGF0IDM6
NDPigK9QTSBPbGVnIE5lc3Rlcm92IDxvbGVnQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IGFu
ZCB0aGUgZmluYWwgcmV3cml0ZToKPiA+Cj4gPiAgICAgICAgIGlmICh3b3JrLT5ub2RlKSB7Cj4g
PiAgICAgICAgICAgICAgICAgd29ya19uZXh0ID0gd29yay0+bm9kZS0+bmV4dDsKPiA+ICAgICAg
ICAgICAgICAgICBpZiAodHJ1ZSkKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGNsZWFyX2Jp
dCgmd29yay0+ZmxhZ3MpOwo+ID4gICAgICAgICB9Cj4gPgo+ID4gc28gYWdhaW4sIEkgZG8gbm90
IHNlZSB0aGUgbG9hZC1zdG9yZSBjb250cm9sIGRlcGVuZGVuY3kuCj4KPiBUaGlzIGtpbmQgb2Yg
b3B0aW1pemF0aW9uIGlzIHN1c3BpY2lvdXMuIEVzcGVjaWFsbHkgY29uc2lkZXJpbmcgaXQncwo+
IHRoZSBjb250cm9sIGV4cHJlc3Npb24gb2YgdGhlIGxvb3AgYnV0IG5vdCBhIGNvbmRpdGlvbi4K
Ckl0IGlzIG5vdCBhYm91dCBvcHRpbWl6YXRpb24sCgo+IExvb2tpbmcgYXQgdGhlIGFzc2VtYmx5
ICh4ODYpOgo+Cj4gICAgMHhmZmZmZmZmZjgxZDQ2YzViIDwrNzU+OiAgICBjYWxscSAgMHhmZmZm
ZmZmZjgxNjg5YWMwIDxsbGlzdF9yZXZlcnNlX29yZGVyPgo+ICAgIDB4ZmZmZmZmZmY4MWQ0NmM2
MCA8KzgwPjogICAgbW92ICAgICVyYXgsJXIxNQo+ICAgIDB4ZmZmZmZmZmY4MWQ0NmM2MyA8Kzgz
PjogICAgdGVzdCAgICVyYXgsJXJheAo+ICAgIDB4ZmZmZmZmZmY4MWQ0NmM2NiA8Kzg2PjogICAg
amUgICAgIDB4ZmZmZmZmZmY4MWQ0NmMzYSA8dmhvc3Rfd29ya2VyKzQyPgo+ICAgIDB4ZmZmZmZm
ZmY4MWQ0NmM2OCA8Kzg4PjogICAgbW92ICAgICVyMTUsJXJkaQo+ICAgIDB4ZmZmZmZmZmY4MWQ0
NmM2YiA8KzkxPjogICAgbW92ICAgICglcjE1KSwlcjE1Cj4gICAgMHhmZmZmZmZmZjgxZDQ2YzZl
IDwrOTQ+OiAgICBsb2NrIGFuZGIgJDB4ZmQsMHgxMCglcmRpKQo+ICAgIDB4ZmZmZmZmZmY4MWQ0
NmM3MyA8Kzk5PjogICAgbW92bCAgICQweDAsMHgxOCglcmJ4KQo+ICAgIDB4ZmZmZmZmZmY4MWQ0
NmM3YSA8KzEwNj46ICAgbW92ICAgIDB4OCglcmRpKSwlcmF4Cj4gICAgMHhmZmZmZmZmZjgxZDQ2
YzdlIDwrMTEwPjogICBjYWxscSAgMHhmZmZmZmZmZjgyMWIzOWEwCj4gPF9feDg2X2luZGlyZWN0
X3RodW5rX2FycmF5Pgo+ICAgIDB4ZmZmZmZmZmY4MWQ0NmM4MyA8KzExNT46ICAgY2FsbHEgIDB4
ZmZmZmZmZmY4MjFiNGQxMCA8X19TQ1RfX2NvbmRfcmVzY2hlZD4KPiAuLi4KPgo+IEkgY2FuIHNl
ZToKPgo+IDEpIFRoZSBjb2RlIHJlYWQgbm9kZS0+bmV4dCAoKzkxKSBiZWZvcmUgY2xlYXJfYml0
ICgrOTQpCgpUaGUgY29kZSBkb2VzLiBidXQgd2hhdCBhYm91dCBDUFUgPwoKPiAyKSBBbmQgdGhl
IGl0IHVzZXMgYSBsb2NrIHByZWZpeCB0byBndWFyYW50ZWUgdGhlIGV4ZWN1dGlvbiBvcmRlcgoK
QXMgSSBzYWlkIGZyb20gdGhlIHZlcnkgYmVnaW5uaW5nLCB0aGlzIGNvZGUgaXMgZmluZSBvbiB4
ODYgYmVjYXVzZQphdG9taWMgb3BzIGFyZSBmdWxseSBzZXJpYWxpc2VkIG9uIHg4Ni4KCk9LLiB3
ZSBjYW4ndCBjb252aW5jZSBlYWNoIG90aGVyLiBJJ2xsIHRyeSB0byB3cml0ZSBhbm90aGVyIGVt
YWlsIHdoZW4KSSBoYXZlIHRpbWUsCgpJZiB0aGlzIGNvZGUgaXMgY29ycmVjdCwgdGhlbiBteSB1
bmRlcnN0YW5kaW5nIG9mIG1lbW9yeSBiYXJyaWVycyBpcyBldmVuCndvcnNlIHRoYW4gSSB0aGlu
ay4gSSB3b3VsZG4ndCBiZSBzdXJwcmlzZWQsIGJ1dCBJJ2QgbGlrZSB0byB1bmRlcnN0YW5kCndo
YXQgSSBoYXZlIG1pc3NlZC4KCk9sZWcuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
