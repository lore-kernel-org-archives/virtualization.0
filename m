Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC516C433DF
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 10:35:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE394204EA
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 10:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrULWNGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE394204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7E173885B5;
	Fri, 21 Aug 2020 10:35:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2dQsVF68PKfv; Fri, 21 Aug 2020 10:35:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C6FDA885E5;
	Fri, 21 Aug 2020 10:35:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB81BC07FF;
	Fri, 21 Aug 2020 10:35:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04F4AC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0145A885B5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4oqfGmtMct+D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:35:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F2EEA885E5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598006101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G68oLT4JVMoIG5DqaYBfCZBI9EqNtAD2sZmp6ATBUeA=;
 b=FrULWNGUo4md0VuZQnM9ccGnoG1bCbfjiS10prNeVMG1jZJcfWOHOQp2SojYbRZ/jqDhRz
 C23r2E074N3A9wlN4jJ3WBEA/AHaLAAfaPvN0kobbB+PqCnBG9JwugXDn87cdbxFZyQog7
 jv/eNDQ+cSqQy3JTqAmhqocPO0epvzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-i2qdkbQ-NhGC9y6PSLFkzg-1; Fri, 21 Aug 2020 06:34:57 -0400
X-MC-Unique: i2qdkbQ-NhGC9y6PSLFkzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7F3A8030D0;
 Fri, 21 Aug 2020 10:34:54 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-87.ams2.redhat.com [10.36.114.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05299756D8;
 Fri, 21 Aug 2020 10:34:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] kernel/resource: merge_system_ram_resources() to merge
 resources after hotplug
Date: Fri, 21 Aug 2020 12:34:28 +0200
Message-Id: <20200821103431.13481-3-david@redhat.com>
In-Reply-To: <20200821103431.13481-1-david@redhat.com>
References: <20200821103431.13481-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-hyperv@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Ard Biesheuvel <ardb@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baoquan He <bhe@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org,
 Julien Grall <julien@xen.org>, Kees Cook <keescook@chromium.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Yang <richardw.yang@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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

U29tZSBhZGRfbWVtb3J5KigpIHVzZXJzIGFkZCBtZW1vcnkgaW4gc21hbGwsIGNvbnRpZ3VvdXMg
bWVtb3J5IGJsb2Nrcy4KRXhhbXBsZXMgaW5jbHVkZSB2aXJ0aW8tbWVtLCBoeXBlci12IGJhbGxv
b24sIGFuZCB0aGUgWEVOIGJhbGxvb24uCgpUaGlzIGNhbiBxdWlja2x5IHJlc3VsdCBpbiBhIGxv
dCBvZiBtZW1vcnkgcmVzb3VyY2VzLCB3aGVyZWJ5IHRoZSBhY3R1YWwKcmVzb3VyY2UgYm91bmRh
cmllcyBhcmUgbm90IG9mIGludGVyZXN0IChlLmcuLCBpdCBtaWdodCBiZSByZWxldmFudCBmb3IK
RElNTXMsIGV4cG9zZWQgdmlhIC9wcm9jL2lvbWVtIHRvIHVzZXIgc3BhY2UpLiBXZSByZWFsbHkg
d2FudCB0byBtZXJnZQphZGRlZCByZXNvdXJjZXMgaW4gdGhpcyBzY2VuYXJpbyB3aGVyZSBwb3Nz
aWJsZS4KCkxldCdzIHByb3ZpZGUgYW4gaW50ZXJmYWNlIHRvIHRyaWdnZXIgbWVyZ2luZyBvZiBh
cHBsaWNhYmxlIGNoaWxkCnJlc291cmNlcy4gSXQgd2lsbCBiZSwgZm9yIGV4YW1wbGUsIHVzZWQg
YnkgdmlydGlvLW1lbSB0byB0cmlnZ2VyCm1lcmdpbmcgb2Ygc3lzdGVtIHJhbSByZXNvdXJjZXMg
aXQgYWRkZWQgdG8gaXRzIHJlc291cmNlIGNvbnRhaW5lciwgYnV0CmFsc28gYnkgWEVOIGFuZCBI
eXBlci1WIHRvIHRyaWdnZXIgbWVyZ2luZyBvZiBzeXN0ZW0gcmFtIHJlc291cmNlcyBpbgppb21l
bV9yZXNvdXJjZS4KCk5vdGU6IFdlIHJlYWxseSB3YW50IHRvIG1lcmdlIGFmdGVyIHRoZSB3aG9s
ZSBvcGVyYXRpb24gc3VjY2VlZGVkLCBub3QKZGlyZWN0bHkgd2hlbiBhZGRpbmcgYSByZXNvdXJj
ZSB0byB0aGUgcmVzb3VyY2UgdHJlZSAoaXQgd291bGQgYnJlYWsKYWRkX21lbW9yeV9yZXNvdXJj
ZSgpIGFuZCByZXF1aXJlIHNwbGl0dGluZyByZXNvdXJjZXMgYWdhaW4gd2hlbiB0aGUKb3BlcmF0
aW9uIGZhaWxlZCAtIGUuZy4sIGR1ZSB0byAtRU5PTUVNKS4KCkNjOiBBbmRyZXcgTW9ydG9uIDxh
a3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPgpDYzogTWljaGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5j
b20+CkNjOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4KQ2M6IEphc29u
IEd1bnRob3JwZSA8amdnQHppZXBlLmNhPgpDYzogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1
bS5vcmc+CkNjOiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPgpDYzogVGhvbWFzIEds
ZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+CkNjOiAiSy4gWS4gU3Jpbml2YXNhbiIgPGt5c0Bt
aWNyb3NvZnQuY29tPgpDYzogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT4K
Q2M6IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPgpDYzogV2VpIExp
dSA8d2VpLmxpdUBrZXJuZWwub3JnPgpDYzogQm9yaXMgT3N0cm92c2t5IDxib3Jpcy5vc3Ryb3Zz
a3lAb3JhY2xlLmNvbT4KQ2M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4KQ2M6IFN0
ZWZhbm8gU3RhYmVsbGluaSA8c3N0YWJlbGxpbmlAa2VybmVsLm9yZz4KQ2M6IFJvZ2VyIFBhdSBN
b25uw6kgPHJvZ2VyLnBhdUBjaXRyaXguY29tPgpDYzogSnVsaWVuIEdyYWxsIDxqdWxpZW5AeGVu
Lm9yZz4KQ2M6IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhLmxpbnV4QGdtYWlsLmNvbT4KQ2M6
IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPgpDYzogV2VpIFlhbmcgPHJpY2hhcmR3LnlhbmdA
bGludXguaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRA
cmVkaGF0LmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L2lvcG9ydC5oIHwgIDMgKysrCiBrZXJuZWwv
cmVzb3VyY2UuYyAgICAgIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2lvcG9ydC5oIGIvaW5jbHVkZS9saW51eC9pb3BvcnQuaAppbmRleCA1MmE5
MWY1ZmExYTM2Li4zYmIwMDIwY2Q2ZGRjIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2lvcG9y
dC5oCisrKyBiL2luY2x1ZGUvbGludXgvaW9wb3J0LmgKQEAgLTI1MSw2ICsyNTEsOSBAQCBleHRl
cm4gdm9pZCBfX3JlbGVhc2VfcmVnaW9uKHN0cnVjdCByZXNvdXJjZSAqLCByZXNvdXJjZV9zaXpl
X3QsCiBleHRlcm4gdm9pZCByZWxlYXNlX21lbV9yZWdpb25fYWRqdXN0YWJsZShzdHJ1Y3QgcmVz
b3VyY2UgKiwgcmVzb3VyY2Vfc2l6ZV90LAogCQkJCQkgIHJlc291cmNlX3NpemVfdCk7CiAjZW5k
aWYKKyNpZmRlZiBDT05GSUdfTUVNT1JZX0hPVFBMVUcKK2V4dGVybiB2b2lkIG1lcmdlX3N5c3Rl
bV9yYW1fcmVzb3VyY2VzKHN0cnVjdCByZXNvdXJjZSAqcmVzKTsKKyNlbmRpZgogCiAvKiBXcmFw
cGVycyBmb3IgbWFuYWdlZCBkZXZpY2VzICovCiBzdHJ1Y3QgZGV2aWNlOwpkaWZmIC0tZ2l0IGEv
a2VybmVsL3Jlc291cmNlLmMgYi9rZXJuZWwvcmVzb3VyY2UuYwppbmRleCAxZGNlZjVkNTNkNzZl
Li5iNGUwOTYzZWRhZGQyIDEwMDY0NAotLS0gYS9rZXJuZWwvcmVzb3VyY2UuYworKysgYi9rZXJu
ZWwvcmVzb3VyY2UuYwpAQCAtMTM2MCw2ICsxMzYwLDU4IEBAIHZvaWQgcmVsZWFzZV9tZW1fcmVn
aW9uX2FkanVzdGFibGUoc3RydWN0IHJlc291cmNlICpwYXJlbnQsCiB9CiAjZW5kaWYJLyogQ09O
RklHX01FTU9SWV9IT1RSRU1PVkUgKi8KIAorI2lmZGVmIENPTkZJR19NRU1PUllfSE9UUExVRwor
c3RhdGljIGJvb2wgc3lzdGVtX3JhbV9yZXNvdXJjZXNfbWVyZ2VhYmxlKHN0cnVjdCByZXNvdXJj
ZSAqcjEsCisJCQkJCSAgIHN0cnVjdCByZXNvdXJjZSAqcjIpCit7CisJcmV0dXJuIHIxLT5mbGFn
cyA9PSByMi0+ZmxhZ3MgJiYgcjEtPmVuZCArIDEgPT0gcjItPnN0YXJ0ICYmCisJICAgICAgIHIx
LT5uYW1lID09IHIyLT5uYW1lICYmIHIxLT5kZXNjID09IHIyLT5kZXNjICYmCisJICAgICAgICFy
MS0+Y2hpbGQgJiYgIXIyLT5jaGlsZDsKK30KKworLyoKKyAqIG1lcmdlX3N5c3RlbV9yYW1fcmVz
b3VyY2VzIC0gdHJ5IHRvIG1lcmdlIGNvbnRpZ3VvdXMgc3lzdGVtIHJhbSByZXNvdXJjZXMKKyAq
IEBwYXJlbnQ6IHBhcmVudCByZXNvdXJjZSBkZXNjcmlwdG9yCisgKgorICogVGhpcyBpbnRlcmZh
Y2UgaXMgaW50ZW5kZWQgZm9yIG1lbW9yeSBob3RwbHVnLCB3aGVyZWJ5IGxvdHMgb2YgY29udGln
dW91cworICogc3lzdGVtIHJhbSByZXNvdXJjZXMgYXJlIGFkZGVkIChlLmcuLCB2aWEgYWRkX21l
bW9yeSooKSkgYnkgYSBkcml2ZXIsIGFuZAorICogdGhlIGFjdHVhbCByZXNvdXJjZSBib3VuZGFy
aWVzIGFyZSBub3Qgb2YgaW50ZXJlc3QgKGUuZy4sIGl0IG1pZ2h0IGJlCisgKiByZWxldmFudCBm
b3IgRElNTXMpLiBPbmx5IGltbWVkaWF0ZSBjaGlsZCByZXNvdXJjZXMgdGhhdCBhcmUgYnVzeSBh
bmQKKyAqIGRvbid0IGhhdmUgYW55IGNoaWxkcmVuIGFyZSBjb25zaWRlcmVkLiBBbGwgYXBwbGlj
YWJsZSBjaGlsZCByZXNvdXJjZXMKKyAqIG11c3QgYmUgaW1tdXRhYmxlIGR1cmluZyB0aGUgcmVx
dWVzdC4KKyAqCisgKiBOb3RlOgorICogLSBUaGUgY2FsbGVyIGhhcyB0byBtYWtlIHN1cmUgdGhh
dCBubyBwb2ludGVycyB0byByZXNvdXJjZXMgdGhhdCBtaWdodAorICogICBnZXQgbWVyZ2VkIGFy
ZSBoZWxkIGFueW1vcmUuIENhbGxlcnMgc2hvdWxkIG9ubHkgdHJpZ2dlciBtZXJnaW5nIG9mIGNo
aWxkCisgKiAgIHJlc291cmNlcyB3aGVuIHRoZXkgYXJlIHRoZSBvbmx5IG9uZSBhZGRpbmcgc3lz
dGVtIHJhbSByZXNvdXJjZXMgdG8gdGhlCisgKiAgIHBhcmVudCAoYmVzaWRlcyBkdXJpbmcgYm9v
dCkuCisgKiAtIHJlbGVhc2VfbWVtX3JlZ2lvbl9hZGp1c3RhYmxlKCkgd2lsbCBzcGxpdCBvbiBk
ZW1hbmQgb24gbWVtb3J5IGhvdHVucGx1ZworICovCit2b2lkIG1lcmdlX3N5c3RlbV9yYW1fcmVz
b3VyY2VzKHN0cnVjdCByZXNvdXJjZSAqcGFyZW50KQoreworCWNvbnN0IHVuc2lnbmVkIGxvbmcg
ZmxhZ3MgPSBJT1JFU09VUkNFX1NZU1RFTV9SQU0gfCBJT1JFU09VUkNFX0JVU1k7CisJc3RydWN0
IHJlc291cmNlICpjdXIsICpuZXh0OworCisJd3JpdGVfbG9jaygmcmVzb3VyY2VfbG9jayk7CisK
KwljdXIgPSBwYXJlbnQtPmNoaWxkOworCXdoaWxlIChjdXIgJiYgY3VyLT5zaWJsaW5nKSB7CisJ
CW5leHQgPSBjdXItPnNpYmxpbmc7CisJCWlmICgoY3VyLT5mbGFncyAmIGZsYWdzKSA9PSBmbGFn
cyAmJgorCQkgICAgc3lzdGVtX3JhbV9yZXNvdXJjZXNfbWVyZ2VhYmxlKGN1ciwgbmV4dCkpIHsK
KwkJCWN1ci0+ZW5kID0gbmV4dC0+ZW5kOworCQkJY3VyLT5zaWJsaW5nID0gbmV4dC0+c2libGlu
ZzsKKwkJCWZyZWVfcmVzb3VyY2UobmV4dCk7CisJCQluZXh0ID0gY3VyLT5zaWJsaW5nOworCQl9
CisJCWN1ciA9IG5leHQ7CisJfQorCisJd3JpdGVfdW5sb2NrKCZyZXNvdXJjZV9sb2NrKTsKK30K
K0VYUE9SVF9TWU1CT0wobWVyZ2Vfc3lzdGVtX3JhbV9yZXNvdXJjZXMpOworI2VuZGlmCS8qIENP
TkZJR19NRU1PUllfSE9UUExVRyAqLworCiAvKgogICogTWFuYWdlZCByZWdpb24gcmVzb3VyY2UK
ICAqLwotLSAKMi4yNi4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
