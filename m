Return-Path: <SRS0=yxq9=CL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76AAC433E7
	for <virtualization@archiver.kernel.org>; Wed,  2 Sep 2020 10:15:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC202078B
	for <virtualization@archiver.kernel.org>; Wed,  2 Sep 2020 10:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC202078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2A1D0203C7;
	Wed,  2 Sep 2020 10:15:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mUsiF4Fe6x7A; Wed,  2 Sep 2020 10:15:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AACAE1FEF0;
	Wed,  2 Sep 2020 10:15:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 982FEC0052;
	Wed,  2 Sep 2020 10:15:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C095C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 10:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2B19685F7C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 10:15:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RVjEP3btXG8p
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 10:15:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4C2E085A92
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 10:15:28 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D97A3AC61;
 Wed,  2 Sep 2020 10:15:26 +0000 (UTC)
Subject: Re: [PATCH v1 4/5] xen/balloon: try to merge system ram resources
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
References: <20200821103431.13481-1-david@redhat.com>
 <20200821103431.13481-5-david@redhat.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <226413fc-ef25-59bd-772f-79012fda0ee3@suse.com>
Date: Wed, 2 Sep 2020 12:15:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821103431.13481-5-david@redhat.com>
Content-Language: en-US
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, linux-hyperv@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, Julien Grall <julien@xen.org>,
 Baoquan He <bhe@redhat.com>, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Stefano Stabellini <sstabellini@kernel.org>,
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

T24gMjEuMDguMjAgMTI6MzQsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+IExldCdzIHJldXNl
IHRoZSBuZXcgbWVjaGFuaXNtIHRvIG1lcmdlIHN5c3RlbSByYW0gcmVzb3VyY2VzIGJlbG93IHRo
ZQo+IHJvb3QuIFdlIGFyZSB0aGUgb25seSBvbmUgaG90cGx1Z2dpbmcgc3lzdGVtIHJhbSAoZS5n
LiwgRElNTXMgZG9uJ3QgYXBwbHkpLAo+IHNvIHRoaXMgaXMgc2FmZSB0byBiZSB1c2VkLgo+IAo+
IENjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPgo+IENjOiBNaWNo
YWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4KPiBDYzogQm9yaXMgT3N0cm92c2t5IDxib3Jpcy5v
c3Ryb3Zza3lAb3JhY2xlLmNvbT4KPiBDYzogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29t
Pgo+IENjOiBTdGVmYW5vIFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+Cj4gQ2M6
IFJvZ2VyIFBhdSBNb25uw6kgPHJvZ2VyLnBhdUBjaXRyaXguY29tPgo+IENjOiBKdWxpZW4gR3Jh
bGwgPGp1bGllbkB4ZW4ub3JnPgo+IENjOiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YS5saW51
eEBnbWFpbC5jb20+Cj4gQ2M6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPgo+IENjOiBXZWkg
WWFuZyA8cmljaGFyZHcueWFuZ0BsaW51eC5pbnRlbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRGF2
aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3hlbi9i
YWxsb29uLmMgfCA0ICsrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPiAK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vYmFsbG9vbi5jIGIvZHJpdmVycy94ZW4vYmFsbG9v
bi5jCj4gaW5kZXggMzdmZmNjZGE4YmI4Ny4uNWVjNzNmNzUyYjhhNyAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3hlbi9iYWxsb29uLmMKPiArKysgYi9kcml2ZXJzL3hlbi9iYWxsb29uLmMKPiBAQCAt
MzM4LDYgKzMzOCwxMCBAQCBzdGF0aWMgZW51bSBicF9zdGF0ZSByZXNlcnZlX2FkZGl0aW9uYWxf
bWVtb3J5KHZvaWQpCj4gICAJaWYgKHJjKSB7Cj4gICAJCXByX3dhcm4oIkNhbm5vdCBhZGQgYWRk
aXRpb25hbCBtZW1vcnkgKCVpKVxuIiwgcmMpOwo+ICAgCQlnb3RvIGVycjsKPiArCX0gZWxzZSB7
Cj4gKwkJcmVzb3VyY2UgPSBOVUxMOwo+ICsJCS8qIFRyeSB0byByZWR1Y2UgdGhlIG51bWJlciBv
ZiBzeXN0ZW0gcmFtIHJlc291cmNlcy4gKi8KPiArCQltZXJnZV9zeXN0ZW1fcmFtX3Jlc291cmNl
cygmaW9tZW1fcmVzb3VyY2UpOwo+ICAgCX0KCkkgZG9uJ3Qgc2VlIHRoZSBuZWVkIGZvciBzZXR0
aW5nIHJlc291cmNlIHRvIE5VTEwgYW5kIHRvIHVzZSBhbiAiZWxzZSIKY2xhdXNlIGhlcmUuCgoK
SnVlcmdlbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
