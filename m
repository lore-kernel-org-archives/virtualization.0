Return-Path: <SRS0=pGqY=CS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49B5C43461
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 05:19:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8E021D40
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 05:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8E021D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3D5F886DEF;
	Wed,  9 Sep 2020 05:19:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gqcj-Jwhig5H; Wed,  9 Sep 2020 05:19:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2114C868CC;
	Wed,  9 Sep 2020 05:19:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 185A2C0859;
	Wed,  9 Sep 2020 05:19:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD579C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 05:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 95B842D268
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 05:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0dQtUkNFQNud
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 05:19:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 89FE41FEAE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 05:19:01 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C8F73ACBA;
 Wed,  9 Sep 2020 05:19:00 +0000 (UTC)
Subject: Re: [PATCH v2 6/7] xen/balloon: try to merge system ram resources
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
References: <20200908201012.44168-1-david@redhat.com>
 <20200908201012.44168-7-david@redhat.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <64d7a2ce-e3b5-3525-d977-76a4bb06e52d@suse.com>
Date: Wed, 9 Sep 2020 07:18:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908201012.44168-7-david@redhat.com>
Content-Language: en-US
Cc: linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, Julien Grall <julien@xen.org>,
 linux-acpi@vger.kernel.org, Baoquan He <bhe@redhat.com>,
 linux-nvdimm@lists.01.org, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Wei Yang <richardw.yang@linux.intel.com>, xen-devel@lists.xenproject.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
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

T24gMDguMDkuMjAgMjI6MTAsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+IExldCdzIHRyeSB0
byBtZXJnZSBzeXN0ZW0gcmFtIHJlc291cmNlcyB3ZSBhZGQsIHRvIG1pbmltaXplIHRoZSBudW1i
ZXIKPiBvZiByZXNvdXJjZXMgaW4gL3Byb2MvaW9tZW0uIFdlIGRvbid0IGNhcmUgYWJvdXQgdGhl
IGJvdW5kYXJpZXMgb2YKPiBpbmRpdmlkdWFsIGNodW5rcyB3ZSBhZGRlZC4KPiAKPiBDYzogQW5k
cmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KPiBDYzogTWljaGFsIEhvY2tv
IDxtaG9ja29Ac3VzZS5jb20+Cj4gQ2M6IEJvcmlzIE9zdHJvdnNreSA8Ym9yaXMub3N0cm92c2t5
QG9yYWNsZS5jb20+Cj4gQ2M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4KPiBDYzog
U3RlZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPgo+IENjOiBSb2dlciBQ
YXUgTW9ubsOpIDxyb2dlci5wYXVAY2l0cml4LmNvbT4KPiBDYzogSnVsaWVuIEdyYWxsIDxqdWxp
ZW5AeGVuLm9yZz4KPiBDYzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGEubGludXhAZ21haWwu
Y29tPgo+IENjOiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4KPiBDYzogV2VpIFlhbmcgPHJp
Y2hhcmR3LnlhbmdAbGludXguaW50ZWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEhpbGRl
bmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPgoKUmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpn
cm9zc0BzdXNlLmNvbT4KCkp1ZXJnZW4KCj4gLS0tCj4gICBkcml2ZXJzL3hlbi9iYWxsb29uLmMg
fCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
PiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vYmFsbG9vbi5jIGIvZHJpdmVycy94ZW4vYmFs
bG9vbi5jCj4gaW5kZXggN2JhYzM4NzY0NTEzZC4uYjU3YjIwNjdlY2JmYiAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL3hlbi9iYWxsb29uLmMKPiArKysgYi9kcml2ZXJzL3hlbi9iYWxsb29uLmMKPiBA
QCAtMzMxLDcgKzMzMSw3IEBAIHN0YXRpYyBlbnVtIGJwX3N0YXRlIHJlc2VydmVfYWRkaXRpb25h
bF9tZW1vcnkodm9pZCkKPiAgIAltdXRleF91bmxvY2soJmJhbGxvb25fbXV0ZXgpOwo+ICAgCS8q
IGFkZF9tZW1vcnlfcmVzb3VyY2UoKSByZXF1aXJlcyB0aGUgZGV2aWNlX2hvdHBsdWcgbG9jayAq
Lwo+ICAgCWxvY2tfZGV2aWNlX2hvdHBsdWcoKTsKPiAtCXJjID0gYWRkX21lbW9yeV9yZXNvdXJj
ZShuaWQsIHJlc291cmNlLCAwKTsKPiArCXJjID0gYWRkX21lbW9yeV9yZXNvdXJjZShuaWQsIHJl
c291cmNlLCBNRU1IUF9NRVJHRV9SRVNPVVJDRSk7Cj4gICAJdW5sb2NrX2RldmljZV9ob3RwbHVn
KCk7Cj4gICAJbXV0ZXhfbG9jaygmYmFsbG9vbl9tdXRleCk7Cj4gICAKPiAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
