Return-Path: <SRS0=G0EF=CU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD67C2D0E4
	for <virtualization@archiver.kernel.org>; Fri, 11 Sep 2020 10:36:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E39E221EE
	for <virtualization@archiver.kernel.org>; Fri, 11 Sep 2020 10:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5Ur8RRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E39E221EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F0605873B1;
	Fri, 11 Sep 2020 10:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WaSJP0WdnZ0a; Fri, 11 Sep 2020 10:36:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8301C8739A;
	Fri, 11 Sep 2020 10:36:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78B7AC0052;
	Fri, 11 Sep 2020 10:36:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A0D3C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 10:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 89B69873A1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 10:36:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1k0g92O0-0vZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 10:36:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E8E968739A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 10:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599820566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pcPWZv9PYAHyw7ygKg8TV8AW3ZEfFOjouUb95Y7pmVU=;
 b=U5Ur8RRHZosiMT46QmThdNtOTYxMN4LERxUDr/zUrV1aB0WS1kRYr/1+XjXZWAYXCjNUm1
 ddFrWvq5YRojmgGhyHb0Y1Eisa5c/sjfjZeUax1zHIczYWQH+T0Q9nTNAQSGXAqAr+z9Ge
 4pG2FiMIFkQd2qN2NGsPeV4VOtsiGsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-8nXwlIW-OjOX_tpbFlQW3g-1; Fri, 11 Sep 2020 06:36:03 -0400
X-MC-Unique: 8nXwlIW-OjOX_tpbFlQW3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBF911008301;
 Fri, 11 Sep 2020 10:36:00 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-186.ams2.redhat.com [10.36.113.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B94C81C49;
 Fri, 11 Sep 2020 10:35:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] xen/balloon: try to merge system ram resources
Date: Fri, 11 Sep 2020 12:34:58 +0200
Message-Id: <20200911103459.10306-8-david@redhat.com>
In-Reply-To: <20200911103459.10306-1-david@redhat.com>
References: <20200911103459.10306-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Juergen Gross <jgross@suse.com>, linux-s390@vger.kernel.org,
 linux-hyperv@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Julien Grall <julien@xen.org>, linux-acpi@vger.kernel.org,
 Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Andrew Morton <akpmt@linux-foundation.org>, xen-devel@lists.xenproject.org,
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

TGV0J3MgdHJ5IHRvIG1lcmdlIHN5c3RlbSByYW0gcmVzb3VyY2VzIHdlIGFkZCwgdG8gbWluaW1p
emUgdGhlIG51bWJlcgpvZiByZXNvdXJjZXMgaW4gL3Byb2MvaW9tZW0uIFdlIGRvbid0IGNhcmUg
YWJvdXQgdGhlIGJvdW5kYXJpZXMgb2YKaW5kaXZpZHVhbCBjaHVua3Mgd2UgYWRkZWQuCgpSZXZp
ZXdlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPgpDYzogQW5kcmV3IE1vcnRv
biA8YWtwbXRAbGludXgtZm91bmRhdGlvbi5vcmc+CkNjOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0Bz
dXNlLmNvbT4KQ2M6IEJvcmlzIE9zdHJvdnNreSA8Ym9yaXMub3N0cm92c2t5QG9yYWNsZS5jb20+
CkNjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+CkNjOiBTdGVmYW5vIFN0YWJlbGxp
bmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+CkNjOiBSb2dlciBQYXUgTW9ubsOpIDxyb2dlci5w
YXVAY2l0cml4LmNvbT4KQ2M6IEp1bGllbiBHcmFsbCA8anVsaWVuQHhlbi5vcmc+CkNjOiBQYW5r
YWogR3VwdGEgPHBhbmthai5ndXB0YS5saW51eEBnbWFpbC5jb20+CkNjOiBCYW9xdWFuIEhlIDxi
aGVAcmVkaGF0LmNvbT4KQ2M6IFdlaSBZYW5nIDxyaWNoYXJkdy55YW5nQGxpbnV4LmludGVsLmNv
bT4KU2lnbmVkLW9mZi1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+Ci0t
LQogZHJpdmVycy94ZW4vYmFsbG9vbi5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vYmFsbG9vbi5j
IGIvZHJpdmVycy94ZW4vYmFsbG9vbi5jCmluZGV4IDlmNDBhMjk0ZDM5OGQuLmI1N2IyMDY3ZWNi
ZmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMveGVuL2JhbGxvb24uYworKysgYi9kcml2ZXJzL3hlbi9i
YWxsb29uLmMKQEAgLTMzMSw3ICszMzEsNyBAQCBzdGF0aWMgZW51bSBicF9zdGF0ZSByZXNlcnZl
X2FkZGl0aW9uYWxfbWVtb3J5KHZvaWQpCiAJbXV0ZXhfdW5sb2NrKCZiYWxsb29uX211dGV4KTsK
IAkvKiBhZGRfbWVtb3J5X3Jlc291cmNlKCkgcmVxdWlyZXMgdGhlIGRldmljZV9ob3RwbHVnIGxv
Y2sgKi8KIAlsb2NrX2RldmljZV9ob3RwbHVnKCk7Ci0JcmMgPSBhZGRfbWVtb3J5X3Jlc291cmNl
KG5pZCwgcmVzb3VyY2UsIE1IUF9OT05FKTsKKwlyYyA9IGFkZF9tZW1vcnlfcmVzb3VyY2Uobmlk
LCByZXNvdXJjZSwgTUVNSFBfTUVSR0VfUkVTT1VSQ0UpOwogCXVubG9ja19kZXZpY2VfaG90cGx1
ZygpOwogCW11dGV4X2xvY2soJmJhbGxvb25fbXV0ZXgpOwogCi0tIAoyLjI2LjIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
