Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C598AC2D0E3
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 20:11:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739062080A
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 20:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPo80OPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739062080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 03793203AE;
	Tue,  8 Sep 2020 20:11:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nny3R0iTzx8x; Tue,  8 Sep 2020 20:11:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8ABFC2150A;
	Tue,  8 Sep 2020 20:11:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 728EAC0859;
	Tue,  8 Sep 2020 20:11:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 165A4C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 20:11:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 057FF86EC9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 20:11:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k49CO-tQ5olW
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 20:11:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 397F186EBB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 20:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599595892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8K1xYXTYUbnlqXd2ZY48Xr9MumdD7TqIS7rIjkX/laU=;
 b=fPo80OPVtsLQyxNSDLTnlNshggz94Ckne2m7T4WB4U9QkRv6yw8TXbkDYydZOlcyR15dee
 ExEN5TxLHScUavXK5ymgGVWGhjsPLvRWmfKNyW6ZHtFpxk76iJ3GOYVwm1hNB8V73h6uMo
 pV1HkOT9CpYBOVbE+R0YXGa/VMZXgkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-Y-wM1DyKPe22UQB0ydanhg-1; Tue, 08 Sep 2020 16:11:28 -0400
X-MC-Unique: Y-wM1DyKPe22UQB0ydanhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA4DC85C734;
 Tue,  8 Sep 2020 20:11:25 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-46.ams2.redhat.com [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 942655D9E8;
 Tue,  8 Sep 2020 20:11:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] xen/balloon: try to merge system ram resources
Date: Tue,  8 Sep 2020 22:10:11 +0200
Message-Id: <20200908201012.44168-7-david@redhat.com>
In-Reply-To: <20200908201012.44168-1-david@redhat.com>
References: <20200908201012.44168-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Juergen Gross <jgross@suse.com>, linux-s390@vger.kernel.org,
 linux-hyperv@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Julien Grall <julien@xen.org>, linux-acpi@vger.kernel.org,
 Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, xen-devel@lists.xenproject.org,
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
YWJvdXQgdGhlIGJvdW5kYXJpZXMgb2YKaW5kaXZpZHVhbCBjaHVua3Mgd2UgYWRkZWQuCgpDYzog
QW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KQ2M6IE1pY2hhbCBIb2Nr
byA8bWhvY2tvQHN1c2UuY29tPgpDYzogQm9yaXMgT3N0cm92c2t5IDxib3Jpcy5vc3Ryb3Zza3lA
b3JhY2xlLmNvbT4KQ2M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4KQ2M6IFN0ZWZh
bm8gU3RhYmVsbGluaSA8c3N0YWJlbGxpbmlAa2VybmVsLm9yZz4KQ2M6IFJvZ2VyIFBhdSBNb25u
w6kgPHJvZ2VyLnBhdUBjaXRyaXguY29tPgpDYzogSnVsaWVuIEdyYWxsIDxqdWxpZW5AeGVuLm9y
Zz4KQ2M6IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhLmxpbnV4QGdtYWlsLmNvbT4KQ2M6IEJh
b3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPgpDYzogV2VpIFlhbmcgPHJpY2hhcmR3LnlhbmdAbGlu
dXguaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVk
aGF0LmNvbT4KLS0tCiBkcml2ZXJzL3hlbi9iYWxsb29uLmMgfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3hl
bi9iYWxsb29uLmMgYi9kcml2ZXJzL3hlbi9iYWxsb29uLmMKaW5kZXggN2JhYzM4NzY0NTEzZC4u
YjU3YjIwNjdlY2JmYiAxMDA2NDQKLS0tIGEvZHJpdmVycy94ZW4vYmFsbG9vbi5jCisrKyBiL2Ry
aXZlcnMveGVuL2JhbGxvb24uYwpAQCAtMzMxLDcgKzMzMSw3IEBAIHN0YXRpYyBlbnVtIGJwX3N0
YXRlIHJlc2VydmVfYWRkaXRpb25hbF9tZW1vcnkodm9pZCkKIAltdXRleF91bmxvY2soJmJhbGxv
b25fbXV0ZXgpOwogCS8qIGFkZF9tZW1vcnlfcmVzb3VyY2UoKSByZXF1aXJlcyB0aGUgZGV2aWNl
X2hvdHBsdWcgbG9jayAqLwogCWxvY2tfZGV2aWNlX2hvdHBsdWcoKTsKLQlyYyA9IGFkZF9tZW1v
cnlfcmVzb3VyY2UobmlkLCByZXNvdXJjZSwgMCk7CisJcmMgPSBhZGRfbWVtb3J5X3Jlc291cmNl
KG5pZCwgcmVzb3VyY2UsIE1FTUhQX01FUkdFX1JFU09VUkNFKTsKIAl1bmxvY2tfZGV2aWNlX2hv
dHBsdWcoKTsKIAltdXRleF9sb2NrKCZiYWxsb29uX211dGV4KTsKIAotLSAKMi4yNi4yCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
