Return-Path: <SRS0=FgjU=D3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329B7C43457
	for <virtualization@archiver.kernel.org>; Tue, 20 Oct 2020 06:32:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F49222E8
	for <virtualization@archiver.kernel.org>; Tue, 20 Oct 2020 06:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ho/N65rG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F49222E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1A05386B45;
	Tue, 20 Oct 2020 06:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TosV44gT3EFw; Tue, 20 Oct 2020 06:32:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 97DF886B18;
	Tue, 20 Oct 2020 06:32:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77DCBC0052;
	Tue, 20 Oct 2020 06:32:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1E26C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 06:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B2B182E19C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 06:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wTZLP17DLZHF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 06:32:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 2B34C2E184
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 06:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603175545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kUV7+7Yb5gWkt6R5BK6/Nubk0EIUzqlyn1lORobljU8=;
 b=ho/N65rGP7qEo1ynqxhUa2/H0XMAf4wx8zUWOL6dsoZoJgdEjniud3URX0CBSGyt6QPMMD
 X/HS/bnV+iE4sXzmF7IDzAz4hrNmx93mAWwjrRYWfzKO7OsMVz/PnubccHJqCxpTdfh+eW
 1YBgc62wwzGQdzqS51E3F2ffHsOvC48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-TllFas1gNjWKqFl0xh-Dfg-1; Tue, 20 Oct 2020 02:32:24 -0400
X-MC-Unique: TllFas1gNjWKqFl0xh-Dfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E71A01006C8C;
 Tue, 20 Oct 2020 06:32:21 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E70976EF59;
 Tue, 20 Oct 2020 06:32:13 +0000 (UTC)
Subject: Re: [PATCH 2/2] KVM: not link irqfd with a fake IRQ bypass producer
To: Zhenzhong Duan <zhenzhong.duan@gmail.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
References: <20201019090657.131-1-zhenzhong.duan@gmail.com>
 <20201019090657.131-2-zhenzhong.duan@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7eec99d5-e36b-ee5b-5b6c-1486e453a083@redhat.com>
Date: Tue, 20 Oct 2020 14:32:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019090657.131-2-zhenzhong.duan@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: wanpengli@tencent.com, mst@redhat.com, netdev@vger.kernel.org,
 joro@8bytes.org, sean.j.christopherson@intel.com, mingo@redhat.com,
 bp@alien8.de, pbonzini@redhat.com, tglx@linutronix.de, jmattson@google.com
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

Ck9uIDIwMjAvMTAvMTkg5LiL5Y2INTowNiwgWmhlbnpob25nIER1YW4gd3JvdGU6Cj4gSW4gY2Fz
ZSBmYWlsdXJlIHRvIHNldHVwIFBvc3QgaW50ZXJydXB0IGZvciBhbiBJUlEsIGl0IG1ha2Ugbm8g
c2Vuc2UKPiB0byBhc3NpZ24gaXJxZmQtPnByb2R1Y2VyIHRvIHRoZSBwcm9kdWNlci4KPgo+IFRo
aXMgY2hhbmdlIG1ha2VzIGNvZGUgbW9yZSByb2J1c3QuCgoKSXQncyBiZXR0ZXIgdG8gZGVzY3Jp
YmUgd2hhdCBpc3N1ZSB3ZSB3aWxsIGdldCB3aXRob3V0IHRoaXMgcGF0Y2guCgpUaGFua3MKCgo+
Cj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGdtYWlsLmNv
bT4KPiAtLS0KPiAgIGFyY2gveDg2L2t2bS94ODYuYyB8IDMgKystCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYva3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4Ni5jCj4gaW5kZXggY2U4NTZlMC4uMjc3ZTk2
MSAxMDA2NDQKPiAtLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMKPiArKysgYi9hcmNoL3g4Ni9rdm0v
eDg2LmMKPiBAQCAtMTA2ODMsMTMgKzEwNjgzLDE0IEBAIGludCBrdm1fYXJjaF9pcnFfYnlwYXNz
X2FkZF9wcm9kdWNlcihzdHJ1Y3QgaXJxX2J5cGFzc19jb25zdW1lciAqY29ucywKPiAgIAkJY29u
dGFpbmVyX29mKGNvbnMsIHN0cnVjdCBrdm1fa2VybmVsX2lycWZkLCBjb25zdW1lcik7Cj4gICAJ
aW50IHJldDsKPiAgIAo+IC0JaXJxZmQtPnByb2R1Y2VyID0gcHJvZDsKPiAgIAlrdm1fYXJjaF9z
dGFydF9hc3NpZ25tZW50KGlycWZkLT5rdm0pOwo+ICAgCXJldCA9IGt2bV94ODZfb3BzLnVwZGF0
ZV9waV9pcnRlKGlycWZkLT5rdm0sCj4gICAJCQkJCSBwcm9kLT5pcnEsIGlycWZkLT5nc2ksIDEp
Owo+ICAgCj4gICAJaWYgKHJldCkKPiAgIAkJa3ZtX2FyY2hfZW5kX2Fzc2lnbm1lbnQoaXJxZmQt
Pmt2bSk7Cj4gKwllbHNlCj4gKwkJaXJxZmQtPnByb2R1Y2VyID0gcHJvZDsKPiAgIAo+ICAgCXJl
dHVybiByZXQ7Cj4gICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
