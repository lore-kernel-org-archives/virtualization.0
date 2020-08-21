Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C9BC433DF
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 10:35:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BF9207DA
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 10:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jo8saM4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BF9207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BD88A86D36;
	Fri, 21 Aug 2020 10:35:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qJQ20JCqohmp; Fri, 21 Aug 2020 10:35:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 461A086CF9;
	Fri, 21 Aug 2020 10:35:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36B1EC07FF;
	Fri, 21 Aug 2020 10:35:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D87F4C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C6FBC88646
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:35:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9DfMbQsZR5Gu
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:35:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2E98888656
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598006114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OKy/5qBO5o//LYJ+b8xL+LjmCbIRLl1gm4kTDHiwBRU=;
 b=Jo8saM4UNjHiC4EZEAFEskIbChLagMMeOzkPTPti40L2A+VOx7dFIpHmc/U7BQBbQTJ+nZ
 jY3u3YRGVmr4GRbFzgRn0Y6WShyYDbxHxK3CaouxgAzP/U4AM8HZkkBQBdiThVT3cPq6oD
 2HuiQqnJ3dHCXRcyW7HAOQIJCZGLo9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-2VGBU1yXNXyePjxSO5BEig-1; Fri, 21 Aug 2020 06:35:12 -0400
X-MC-Unique: 2VGBU1yXNXyePjxSO5BEig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 002AE80733A;
 Fri, 21 Aug 2020 10:35:10 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-87.ams2.redhat.com [10.36.114.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9887C756DD;
 Fri, 21 Aug 2020 10:35:04 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] xen/balloon: try to merge system ram resources
Date: Fri, 21 Aug 2020 12:34:30 +0200
Message-Id: <20200821103431.13481-5-david@redhat.com>
In-Reply-To: <20200821103431.13481-1-david@redhat.com>
References: <20200821103431.13481-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Juergen Gross <jgross@suse.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, linux-hyperv@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, Julien Grall <julien@xen.org>,
 Baoquan He <bhe@redhat.com>, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Stefano Stabellini <sstabellini@kernel.org>,
 Wei Yang <richardw.yang@linux.intel.com>, xen-devel@lists.xenproject.org,
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

TGV0J3MgcmV1c2UgdGhlIG5ldyBtZWNoYW5pc20gdG8gbWVyZ2Ugc3lzdGVtIHJhbSByZXNvdXJj
ZXMgYmVsb3cgdGhlCnJvb3QuIFdlIGFyZSB0aGUgb25seSBvbmUgaG90cGx1Z2dpbmcgc3lzdGVt
IHJhbSAoZS5nLiwgRElNTXMgZG9uJ3QgYXBwbHkpLApzbyB0aGlzIGlzIHNhZmUgdG8gYmUgdXNl
ZC4KCkNjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPgpDYzogTWlj
aGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+CkNjOiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9z
dHJvdnNreUBvcmFjbGUuY29tPgpDYzogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPgpD
YzogU3RlZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPgpDYzogUm9nZXIg
UGF1IE1vbm7DqSA8cm9nZXIucGF1QGNpdHJpeC5jb20+CkNjOiBKdWxpZW4gR3JhbGwgPGp1bGll
bkB4ZW4ub3JnPgpDYzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGEubGludXhAZ21haWwuY29t
PgpDYzogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+CkNjOiBXZWkgWWFuZyA8cmljaGFyZHcu
eWFuZ0BsaW51eC5pbnRlbC5jb20+ClNpZ25lZC1vZmYtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxk
YXZpZEByZWRoYXQuY29tPgotLS0KIGRyaXZlcnMveGVuL2JhbGxvb24uYyB8IDQgKysrKwogMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL2Jh
bGxvb24uYyBiL2RyaXZlcnMveGVuL2JhbGxvb24uYwppbmRleCAzN2ZmY2NkYThiYjg3Li41ZWM3
M2Y3NTJiOGE3IDEwMDY0NAotLS0gYS9kcml2ZXJzL3hlbi9iYWxsb29uLmMKKysrIGIvZHJpdmVy
cy94ZW4vYmFsbG9vbi5jCkBAIC0zMzgsNiArMzM4LDEwIEBAIHN0YXRpYyBlbnVtIGJwX3N0YXRl
IHJlc2VydmVfYWRkaXRpb25hbF9tZW1vcnkodm9pZCkKIAlpZiAocmMpIHsKIAkJcHJfd2Fybigi
Q2Fubm90IGFkZCBhZGRpdGlvbmFsIG1lbW9yeSAoJWkpXG4iLCByYyk7CiAJCWdvdG8gZXJyOwor
CX0gZWxzZSB7CisJCXJlc291cmNlID0gTlVMTDsKKwkJLyogVHJ5IHRvIHJlZHVjZSB0aGUgbnVt
YmVyIG9mIHN5c3RlbSByYW0gcmVzb3VyY2VzLiAqLworCQltZXJnZV9zeXN0ZW1fcmFtX3Jlc291
cmNlcygmaW9tZW1fcmVzb3VyY2UpOwogCX0KIAogCWJhbGxvb25fc3RhdHMudG90YWxfcGFnZXMg
Kz0gYmFsbG9vbl9ob3RwbHVnOwotLSAKMi4yNi4yCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
