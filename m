Return-Path: <SRS0=Cd1r=BK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5819C433E0
	for <virtualization@archiver.kernel.org>; Fri, 31 Jul 2020 09:19:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B461B21883
	for <virtualization@archiver.kernel.org>; Fri, 31 Jul 2020 09:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKz2GmRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B461B21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6A3B2204D3;
	Fri, 31 Jul 2020 09:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xHWDV-UTCQkC; Fri, 31 Jul 2020 09:19:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8FAE720447;
	Fri, 31 Jul 2020 09:19:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79B68C0050;
	Fri, 31 Jul 2020 09:19:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6281C004D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 09:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D3FB786807
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 09:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VIuLdCkViyTK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 09:19:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C7C30867F6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 09:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596187145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXo92L6xzVp7lbkKaGhQOH5PjMjS2UMyqhJq+SqZmjU=;
 b=eKz2GmRzt71ZPjgS2zsWodplxYWV8Uzf3VNCS/zSN/Ixo1Sf06HXasBEzxNvRSR6NI5iBj
 tYpCPWqZft+a7ljcRaO0FmaQrcFBIvLYbJPkPOnFrHjoTJSgq6YOthrjZn2m2ZFGiSD1FH
 TBP6Q25KFwaqg7pQ276qpbNqxVmDjLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-Vj_nV24LO0GNaNZsmopdDQ-1; Fri, 31 Jul 2020 05:19:01 -0400
X-MC-Unique: Vj_nV24LO0GNaNZsmopdDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A93C718C63C0;
 Fri, 31 Jul 2020 09:18:59 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39C481A835;
 Fri, 31 Jul 2020 09:18:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFCv1 4/5] xen/balloon: try to merge "System RAM" resources
Date: Fri, 31 Jul 2020 11:18:37 +0200
Message-Id: <20200731091838.7490-5-david@redhat.com>
In-Reply-To: <20200731091838.7490-1-david@redhat.com>
References: <20200731091838.7490-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Juergen Gross <jgross@suse.com>, linux-hyperv@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, Julien Grall <julien@xen.org>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
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

TGV0J3MgcmV1c2UgdGhlIG5ldyBtZWNoYW5pc20gdG8gbWVyZ2UgIlN5c3RlbSBSQU0iIHJlc291
cmNlcyBiZWxvdyB0aGUKcm9vdC4gV2UgYXJlIHRoZSBvbmx5IG9uZSBob3RwbHVnZ2luZyAiU3lz
dGVtIFJBTSIgYW5kIERJTU1zIGRvbid0IGFwcGx5LApzbyB0aGlzIGlzIHNhZmUgdG8gdXNlLgoK
Q2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+CkNjOiBNaWNoYWwg
SG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4KQ2M6IEJvcmlzIE9zdHJvdnNreSA8Ym9yaXMub3N0cm92
c2t5QG9yYWNsZS5jb20+CkNjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+CkNjOiBT
dGVmYW5vIFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+CkNjOiBSb2dlciBQYXUg
TW9ubsOpIDxyb2dlci5wYXVAY2l0cml4LmNvbT4KQ2M6IEp1bGllbiBHcmFsbCA8anVsaWVuQHhl
bi5vcmc+ClNpZ25lZC1vZmYtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29t
PgotLS0KIGRyaXZlcnMveGVuL2JhbGxvb24uYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL2JhbGxvb24uYyBiL2RyaXZl
cnMveGVuL2JhbGxvb24uYwppbmRleCA3N2M1NzU2OGU1ZDdmLi42NDRhZTJlMzc5OGUyIDEwMDY0
NAotLS0gYS9kcml2ZXJzL3hlbi9iYWxsb29uLmMKKysrIGIvZHJpdmVycy94ZW4vYmFsbG9vbi5j
CkBAIC0zNTMsNiArMzUzLDEwIEBAIHN0YXRpYyBlbnVtIGJwX3N0YXRlIHJlc2VydmVfYWRkaXRp
b25hbF9tZW1vcnkodm9pZCkKIAlpZiAocmMpIHsKIAkJcHJfd2FybigiQ2Fubm90IGFkZCBhZGRp
dGlvbmFsIG1lbW9yeSAoJWkpXG4iLCByYyk7CiAJCWdvdG8gZXJyOworCX0gZWxzZSB7CisJCXJl
c291cmNlID0gTlVMTDsKKwkJLyogVHJ5IHRvIHJlZHVjZSB0aGUgbnVtYmVyIG9mICJTeXN0ZW0g
UkFNIiByZXNvdXJjZXMuICovCisJCW1lcmdlX2NoaWxkX21lbV9yZXNvdXJjZXMoJmlvbWVtX3Jl
c291cmNlLCAiU3lzdGVtIFJBTSIpOwogCX0KIAogCWJhbGxvb25fc3RhdHMudG90YWxfcGFnZXMg
Kz0gYmFsbG9vbl9ob3RwbHVnOwotLSAKMi4yNi4yCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
