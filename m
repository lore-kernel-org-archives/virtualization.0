Return-Path: <SRS0=RIAz=EB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAFFC55179
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 03:33:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3758D208B3
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 03:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qc6fDh9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3758D208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6C56D871BB;
	Mon, 26 Oct 2020 03:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sUbjTbTa1mkp; Mon, 26 Oct 2020 03:33:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 77804871B5;
	Mon, 26 Oct 2020 03:33:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 487DCC088B;
	Mon, 26 Oct 2020 03:33:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86073C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 75546867CD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fz-ohafscDoW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:33:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3764A867BD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603683201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/UA4iCjiTPMl9Eaovz1mPhI0BzNej9aUfltuhE76s2M=;
 b=Qc6fDh9n7/i5z7TB6WJZSvKzV8KURtQh8NgC4cYw3nbKxbNyGo7hipsZe8P1rXHmvZ5vb/
 Yh4GUsi0mTs0YTt1UdhyQRaBxqeF3QNUO8JJADLZuWBlBG0Kay5B9t5AxVXXHzbfVhWR+e
 hi0il89BViDS5N8Ot1awX9e75BYhnvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-dbwGOHC0Pdu-Wod8u8nhzg-1; Sun, 25 Oct 2020 23:33:17 -0400
X-MC-Unique: dbwGOHC0Pdu-Wod8u8nhzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 422F9186840A;
 Mon, 26 Oct 2020 03:33:16 +0000 (UTC)
Received: from [10.72.13.201] (ovpn-13-201.pek2.redhat.com [10.72.13.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F2C755772;
 Mon, 26 Oct 2020 03:33:03 +0000 (UTC)
Subject: Re: [PATCH 01/17] vhost scsi: add lun parser helper
To: Mike Christie <michael.christie@oracle.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, mst@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
 <1603326903-27052-2-git-send-email-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eef46e20-ed8f-0fb4-be9f-a0f5bd1edfa0@redhat.com>
Date: Mon, 26 Oct 2020 11:33:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603326903-27052-2-git-send-email-michael.christie@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjAvMTAvMjIg5LiK5Y2IODozNCwgTWlrZSBDaHJpc3RpZSB3cm90ZToKPiBNb3ZlIGNv
ZGUgdG8gcGFyc2UgbHVuIGZyb20gcmVxJ3MgbHVuX2J1ZiB0byBoZWxwZXIsIHNvIHRtZiBjb2Rl
Cj4gY2FuIHVzZSBpdCBpbiB0aGUgbmV4dCBwYXRjaC4KPgo+IFNpZ25lZC1vZmYtYnk6IE1pa2Ug
Q2hyaXN0aWUgPG1pY2hhZWwuY2hyaXN0aWVAb3JhY2xlLmNvbT4KPiBSZXZpZXdlZC1ieTogUGFv
bG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3Qv
c2NzaS5jIHwgOSArKysrKysrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+CgoKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Njc2kuYyBiL2RyaXZlcnMvdmhv
c3Qvc2NzaS5jCj4gaW5kZXggYjIyYWRmMC4uMGVhNzhkMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3Zob3N0L3Njc2kuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvc2NzaS5jCj4gQEAgLTkwNyw2ICs5
MDcsMTEgQEAgc3RhdGljIHZvaWQgdmhvc3Rfc2NzaV9zdWJtaXNzaW9uX3dvcmsoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQo+ICAgCXJldHVybiByZXQ7Cj4gICB9Cj4gICAKPiArc3RhdGljIHUx
NiB2aG9zdF9idWZfdG9fbHVuKHU4ICpsdW5fYnVmKQo+ICt7Cj4gKwlyZXR1cm4gKChsdW5fYnVm
WzJdIDw8IDgpIHwgbHVuX2J1ZlszXSkgJiAweDNGRkY7Cj4gK30KPiArCj4gICBzdGF0aWMgdm9p
ZAo+ICAgdmhvc3Rfc2NzaV9oYW5kbGVfdnEoc3RydWN0IHZob3N0X3Njc2kgKnZzLCBzdHJ1Y3Qg
dmhvc3RfdmlydHF1ZXVlICp2cSkKPiAgIHsKPiBAQCAtMTA0NSwxMiArMTA1MCwxMiBAQCBzdGF0
aWMgdm9pZCB2aG9zdF9zY3NpX3N1Ym1pc3Npb25fd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndv
cmspCj4gICAJCQl0YWcgPSB2aG9zdDY0X3RvX2NwdSh2cSwgdl9yZXFfcGkudGFnKTsKPiAgIAkJ
CXRhc2tfYXR0ciA9IHZfcmVxX3BpLnRhc2tfYXR0cjsKPiAgIAkJCWNkYiA9ICZ2X3JlcV9waS5j
ZGJbMF07Cj4gLQkJCWx1biA9ICgodl9yZXFfcGkubHVuWzJdIDw8IDgpIHwgdl9yZXFfcGkubHVu
WzNdKSAmIDB4M0ZGRjsKPiArCQkJbHVuID0gdmhvc3RfYnVmX3RvX2x1bih2X3JlcV9waS5sdW4p
Owo+ICAgCQl9IGVsc2Ugewo+ICAgCQkJdGFnID0gdmhvc3Q2NF90b19jcHUodnEsIHZfcmVxLnRh
Zyk7Cj4gICAJCQl0YXNrX2F0dHIgPSB2X3JlcS50YXNrX2F0dHI7Cj4gICAJCQljZGIgPSAmdl9y
ZXEuY2RiWzBdOwo+IC0JCQlsdW4gPSAoKHZfcmVxLmx1blsyXSA8PCA4KSB8IHZfcmVxLmx1blsz
XSkgJiAweDNGRkY7Cj4gKwkJCWx1biA9IHZob3N0X2J1Zl90b19sdW4odl9yZXEubHVuKTsKPiAg
IAkJfQo+ICAgCQkvKgo+ICAgCQkgKiBDaGVjayB0aGF0IHRoZSByZWNlaXZlZCBDREIgc2l6ZSBk
b2VzIG5vdCBleGNlZWRlZCBvdXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
