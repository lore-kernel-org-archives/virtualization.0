Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E47C433E0
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 03:17:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21B622ADF
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 03:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21B622ADF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5188486FC0;
	Tue, 12 Jan 2021 03:17:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hgc0lygZzhSc; Tue, 12 Jan 2021 03:17:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A9E3C86FC5;
	Tue, 12 Jan 2021 03:17:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D3ACC0893;
	Tue, 12 Jan 2021 03:17:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9DA0C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 03:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A029622EC9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 03:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7MlDISkjZ8P0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 03:17:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 4E49320035
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 03:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610421429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdL9xijqYhEmBrknuY6rf1ZBEjGj8lHKRm8qxVj2FtM=;
 b=aUdccw8NJp5L6FBcKOF5NWBoCjSsCEg4sL5A5Gu788DFtRkHw9JhgliEUivi0ueXWaqbJJ
 tnxiQiMxRRIhuMUTLQBF/XnFbss9Gsmd7jjoCI/q9N+TG06k/Q++iIMXKzaqFrb+GF+tyz
 NhNCRV42S8/hCeAi2LNVskVTztgj97M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-vEyIChIWN3OhI1Lu5P_qaA-1; Mon, 11 Jan 2021 22:17:07 -0500
X-MC-Unique: vEyIChIWN3OhI1Lu5P_qaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70C15107ACFB;
 Tue, 12 Jan 2021 03:17:06 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45FA96A8F9;
 Tue, 12 Jan 2021 03:17:03 +0000 (UTC)
Subject: Re: [PATCH v1] vhost_vdpa: fix the problem in
 vhost_vdpa_set_config_call
To: Cindy Lu <lulu@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, lingshan.zhu@intel.com
References: <20210112024648.31428-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7045438c-2f8b-b804-81bd-f9a5cf6e20bb@redhat.com>
Date: Tue, 12 Jan 2021 11:17:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210112024648.31428-1-lulu@redhat.com>
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

Ck9uIDIwMjEvMS8xMiDkuIrljYgxMDo0NiwgQ2luZHkgTHUgd3JvdGU6Cj4gaW4gdmhvc3RfdmRw
YV9zZXRfY29uZmlnX2NhbGwsIHRoZSBjYi5wcml2YXRlIHNob3VsZCBiZSB2aG9zdF92ZHBhLgoK
ClNob3VsZCBiZSAiSW4iCgoKPiB0aGlzIGNiLnByaXZhdGUgd2lsbCBmaW5hbGx5IHVzZSBpbiB2
aG9zdF92ZHBhX2NvbmZpZ19jYiBhcwo+IHZob3N0X3ZkcGEuRml4IHRoaXMgaXNzdWUKCgpBbiB3
aGl0ZXNwYWNlIGlzIG5lZWRlZCBiZWZvcmUgRml4IGFuZCBhIGZ1bGwgc3RvcCBhZnRlciAiaXNz
dWUiCgpGaXhlczogNzc2ZjM5NTAwNGQ4MiAoInZob3N0X3ZkcGE6IFN1cHBvcnQgY29uZmlnIGlu
dGVycnVwdCBpbiB2ZHBhIikKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgoKUGxlYXNlIHBvc3QgYSBWMiB3aXRoIHRoZSBhYm92ZSBmaXhlZCBhbmQgY2Mgc3RhYmxl
LgoKVGhhbmtzCgoKPgo+IFNpZ25lZC1vZmYtYnk6IENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+
Cj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBpbmRleCBlZjY4OGM4YzBlMGUu
LjNmYmI5YzFmNDlkYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBi
L2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gQEAgLTMxOSw3ICszMTksNyBAQCBzdGF0aWMgbG9uZyB2
aG9zdF92ZHBhX3NldF9jb25maWdfY2FsbChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTMyIF9fdXNl
ciAqYXJncCkKPiAgIAlzdHJ1Y3QgZXZlbnRmZF9jdHggKmN0eDsKPiAgIAo+ICAgCWNiLmNhbGxi
YWNrID0gdmhvc3RfdmRwYV9jb25maWdfY2I7Cj4gLQljYi5wcml2YXRlID0gdi0+dmRwYTsKPiAr
CWNiLnByaXZhdGUgPSB2Owo+ICAgCWlmIChjb3B5X2Zyb21fdXNlcigmZmQsIGFyZ3AsIHNpemVv
ZihmZCkpKQo+ICAgCQlyZXR1cm4gIC1FRkFVTFQ7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
