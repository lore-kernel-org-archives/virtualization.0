Return-Path: <SRS0=Cd1r=BK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A307AC433E3
	for <virtualization@archiver.kernel.org>; Fri, 31 Jul 2020 09:19:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D1822BF3
	for <virtualization@archiver.kernel.org>; Fri, 31 Jul 2020 09:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwyJn3jU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D1822BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5057D860D5;
	Fri, 31 Jul 2020 09:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z7V4zH-nqJQk; Fri, 31 Jul 2020 09:19:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4FC5A86813;
	Fri, 31 Jul 2020 09:19:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44331C0891;
	Fri, 31 Jul 2020 09:19:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3549C004D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 09:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A922020435
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 09:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BYJswpayETqt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 09:19:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id A5C7E20430
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 09:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596187142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GX38+opkWxBZfD2far/R2rRkc2X2qlfoUgt4pP5SXDg=;
 b=gwyJn3jU7N/REiKzRAhgTbpkjsF3/nUITttfsKZRuHB1p23+rMMRAwX0ywfGW4cRJyE5x9
 AobB+bvssCqavcJHHZaS6yRmHlBo7MzkztYsCI4ZKmtE8AddPcP19Y7FpfEnil8oK66xtL
 Wmn+xyRPyWX32GAtaulDphrYkhHmomY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-Z7A2oVdiNTiak_-Gh5Vfug-1; Fri, 31 Jul 2020 05:18:58 -0400
X-MC-Unique: Z7A2oVdiNTiak_-Gh5Vfug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4358480382D;
 Fri, 31 Jul 2020 09:18:55 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D0681A835;
 Fri, 31 Jul 2020 09:18:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFCv1 2/5] kernel/resource: merge_child_mem_resources() to
 merge memory resources after adding succeeded
Date: Fri, 31 Jul 2020 11:18:35 +0200
Message-Id: <20200731091838.7490-3-david@redhat.com>
In-Reply-To: <20200731091838.7490-1-david@redhat.com>
References: <20200731091838.7490-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-hyperv@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, Stephen Hemminger <sthemmin@microsoft.com>,
 Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 virtualization@lists.linux-foundation.org, Juergen Gross <jgross@suse.com>,
 linux-mm@kvack.org, Stefano Stabellini <sstabellini@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Julien Grall <julien@xen.org>,
 xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
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
YnkgdmlydGlvLW1lbSB0byB0cmlnZ2VyCm1lcmdpbmcgb2YgbWVtb3J5IHJlc291cmNlcyBpdCBh
ZGRlZCAodmlhIGFkZF9tZW1vcnlfZHJpdmVyKCkKbWFuYWdlZCkgdG8gaXRzIHJlc291cmNlIGNv
bnRhaW5lci4KCk5vdGU6IFdlIHJlYWxseSB3YW50IHRvIG1lcmdlIGFmdGVyIHRoZSB3aG9sZSBv
cGVyYXRpb24gc3VjY2VlZGVkLCBub3QKZGlyZWN0bHkgd2hlbiBhZGRpbmcgYSByZXNvdXJjZSB0
byB0aGUgcmVzb3VyY2UgdHJlZSAoaXQgd291bGQgYnJlYWsKYWRkX21lbW9yeV9yZXNvdXJjZSgp
IGFuZCByZXF1aXJlIHNwbGl0dGluZyByZXNvdXJjZXMgYWdhaW4gd2hlbiB0aGUKb3BlcmF0aW9u
IGZhaWxlZCAtIGUuZy4sIGR1ZSB0byAtRU5PTUVNKS4KCkNjOiBBbmRyZXcgTW9ydG9uIDxha3Bt
QGxpbnV4LWZvdW5kYXRpb24ub3JnPgpDYzogTWljaGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+
CkNjOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4KQ2M6IEphc29uIEd1
bnRob3JwZSA8amdnQHppZXBlLmNhPgpDYzogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5v
cmc+CkNjOiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPgpDYzogVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+CkNjOiAiSy4gWS4gU3Jpbml2YXNhbiIgPGt5c0BtaWNy
b3NvZnQuY29tPgpDYzogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT4KQ2M6
IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPgpDYzogV2VpIExpdSA8
d2VpLmxpdUBrZXJuZWwub3JnPgpDYzogQm9yaXMgT3N0cm92c2t5IDxib3Jpcy5vc3Ryb3Zza3lA
b3JhY2xlLmNvbT4KQ2M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4KQ2M6IFN0ZWZh
bm8gU3RhYmVsbGluaSA8c3N0YWJlbGxpbmlAa2VybmVsLm9yZz4KQ2M6IFJvZ2VyIFBhdSBNb25u
w6kgPHJvZ2VyLnBhdUBjaXRyaXguY29tPgpDYzogSnVsaWVuIEdyYWxsIDxqdWxpZW5AeGVuLm9y
Zz4KU2lnbmVkLW9mZi1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+Ci0t
LQogaW5jbHVkZS9saW51eC9pb3BvcnQuaCB8ICAzICsrKwoga2VybmVsL3Jlc291cmNlLmMgICAg
ICB8IDU2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxl
cyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9p
b3BvcnQuaCBiL2luY2x1ZGUvbGludXgvaW9wb3J0LmgKaW5kZXggNTJhOTFmNWZhMWEzNi4uNzQz
Yjg3ZmUyMjA1YiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9pb3BvcnQuaAorKysgYi9pbmNs
dWRlL2xpbnV4L2lvcG9ydC5oCkBAIC0yNTEsNiArMjUxLDkgQEAgZXh0ZXJuIHZvaWQgX19yZWxl
YXNlX3JlZ2lvbihzdHJ1Y3QgcmVzb3VyY2UgKiwgcmVzb3VyY2Vfc2l6ZV90LAogZXh0ZXJuIHZv
aWQgcmVsZWFzZV9tZW1fcmVnaW9uX2FkanVzdGFibGUoc3RydWN0IHJlc291cmNlICosIHJlc291
cmNlX3NpemVfdCwKIAkJCQkJICByZXNvdXJjZV9zaXplX3QpOwogI2VuZGlmCisjaWZkZWYgQ09O
RklHX01FTU9SWV9IT1RQTFVHCitleHRlcm4gdm9pZCBtZXJnZV9jaGlsZF9tZW1fcmVzb3VyY2Vz
KHN0cnVjdCByZXNvdXJjZSAqcmVzLCBjb25zdCBjaGFyICpuYW1lKTsKKyNlbmRpZgogCiAvKiBX
cmFwcGVycyBmb3IgbWFuYWdlZCBkZXZpY2VzICovCiBzdHJ1Y3QgZGV2aWNlOwpkaWZmIC0tZ2l0
IGEva2VybmVsL3Jlc291cmNlLmMgYi9rZXJuZWwvcmVzb3VyY2UuYwppbmRleCAyNDljNmI1NDAx
NGRlLi4wMWVjYzViNzk1NmY1IDEwMDY0NAotLS0gYS9rZXJuZWwvcmVzb3VyY2UuYworKysgYi9r
ZXJuZWwvcmVzb3VyY2UuYwpAQCAtMTM2MCw2ICsxMzYwLDYyIEBAIHZvaWQgcmVsZWFzZV9tZW1f
cmVnaW9uX2FkanVzdGFibGUoc3RydWN0IHJlc291cmNlICpwYXJlbnQsCiB9CiAjZW5kaWYJLyog
Q09ORklHX01FTU9SWV9IT1RSRU1PVkUgKi8KIAorI2lmZGVmIENPTkZJR19NRU1PUllfSE9UUExV
Rworc3RhdGljIGJvb2wgbWVtX3Jlc291cmNlc19tZXJnZWFibGUoc3RydWN0IHJlc291cmNlICpy
MSwgc3RydWN0IHJlc291cmNlICpyMikKK3sKKwlyZXR1cm4gcjEtPmVuZCArIDEgPT0gcjItPnN0
YXJ0ICYmCisJICAgICAgIHIxLT5uYW1lID09IHIyLT5uYW1lICYmCisJICAgICAgIHIxLT5mbGFn
cyA9PSByMi0+ZmxhZ3MgJiYKKwkgICAgICAgKHIxLT5mbGFncyAmIElPUkVTT1VSQ0VfTUVNKSAm
JgorCSAgICAgICByMS0+ZGVzYyA9PSByMi0+ZGVzYyAmJgorCSAgICAgICAhcjEtPmNoaWxkICYm
ICFyMi0+Y2hpbGQ7Cit9CisKKy8qCisgKiBtZXJnZV9jaGlsZF9tZW1fcmVzb3VyY2VzIC0gdHJ5
IHRvIG1lcmdlIGNvbnRpZ3VvdXMgY2hpbGQgSU9SRVNPVVJDRV9NRU0KKyAqICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByZXNvdXJjZXMgd2l0aCB0aGUgZ2l2ZW4gbmFtZSB0aGF0IG1hdGNo
IGFsbAorICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIG90aGVyIHByb3BlcnRpZXMKKyAq
IEBwYXJlbnQ6IHBhcmVudCByZXNvdXJjZSBkZXNjcmlwdG9yCisgKiBAbmFtZTogbmFtZSBvZiB0
aGUgY2hpbGQgcmVzb3VyY2VzIHRvIGNvbnNpZGVyIGZvciBtZXJnaW5nCisgKgorICogVGhpcyBp
bnRlcmZhY2UgaXMgaW50ZW5kZWQgZm9yIG1lbW9yeSBob3RwbHVnLCB3aGVyZWJ5IGxvdHMgb2Yg
Y29uc2VjdXRpdmUKKyAqIG1lbW9yeSByZXNvdXJjZXMgYXJlIGFkZGVkIChlLmcuLCB2aWEgYWRk
X21lbW9yeSooKSkgYnkgYSBkcml2ZXIsIGFuZCB0aGUKKyAqIGFjdHVhbCByZXNvdXJjZSBib3Vu
ZGFyaWVzIGFyZSBub3Qgb2YgaW50ZXJlc3QgKGUuZy4sIGl0IG1pZ2h0IGJlCisgKiByZWxldmFu
dCBmb3IgRElNTXMpLiBPbmx5IGltbWVkaWF0ZSBjaGlsZCByZXNvdXJjZXMgYXJlIGNvbnNpZGVy
ZWQuIEFsbAorICogYXBwbGljYWJsZSBjaGlsZCByZXNvdXJjZXMgbXVzdCBiZSBpbW11dGFibGUg
ZHVyaW5nIHRoZSByZXF1ZXN0LgorICoKKyAqIE5vdGU6CisgKiAtIFRoZSBjYWxsZXIgaGFzIHRv
IG1ha2Ugc3VyZSB0aGF0IG5vIHBvaW50ZXJzIHRvIHJlc291cmNlcyB0aGF0IG1pZ2h0CisgKiAg
IGdldCBtZXJnZWQgYXJlIGhlbGQgYW55bW9yZS4gQ2FsbGVycyBzaG91bGQgb25seSB0cmlnZ2Vy
IG1lcmdpbmcgb2YgY2hpbGQKKyAqICAgcmVzb3VyY2VzIHdoZW4gdGhleSBhcmUgdGhlIG9ubHkg
b25lIGFkZGluZyBzdWNoIHJlc291cmNlcyB0byB0aGUgcGFyZW50LgorICogICBFLmcuLCBpZiB0
d28gbWVjaGFuaXNtcyBjb3VsZCBhZGQgIlN5c3RlbSBSQU0iIGltbWVkaWF0ZWx5IGJlbG93IHRo
ZQorICogICBzYW1lIHBhcmVudCwgdGhpcyBmdW5jdGlvbiBpcyBub3Qgc2FmZSB0byB1c2UuCisg
KiAtIHJlbGVhc2VfbWVtX3JlZ2lvbl9hZGp1c3RhYmxlKCkgd2lsbCBzcGxpdCBvbiBkZW1hbmQg
b24gbWVtb3J5IGhvdHVucGx1ZworICovCit2b2lkIG1lcmdlX2NoaWxkX21lbV9yZXNvdXJjZXMo
c3RydWN0IHJlc291cmNlICpwYXJlbnQsIGNvbnN0IGNoYXIgKm5hbWUpCit7CisJc3RydWN0IHJl
c291cmNlICpjdXIsICpuZXh0OworCisJd3JpdGVfbG9jaygmcmVzb3VyY2VfbG9jayk7CisKKwlj
dXIgPSBwYXJlbnQtPmNoaWxkOworCXdoaWxlIChjdXIgJiYgY3VyLT5zaWJsaW5nKSB7CisJCW5l
eHQgPSBjdXItPnNpYmxpbmc7CisJCWlmICghc3RyY21wKGN1ci0+bmFtZSwgbmFtZSkgJiYKKwkJ
ICAgIG1lbV9yZXNvdXJjZXNfbWVyZ2VhYmxlKGN1ciwgbmV4dCkpIHsKKwkJCWN1ci0+ZW5kID0g
bmV4dC0+ZW5kOworCQkJY3VyLT5zaWJsaW5nID0gbmV4dC0+c2libGluZzsKKwkJCWZyZWVfcmVz
b3VyY2UobmV4dCk7CisJCQluZXh0ID0gY3VyLT5zaWJsaW5nOworCQl9CisJCWN1ciA9IG5leHQ7
CisJfQorCisJd3JpdGVfdW5sb2NrKCZyZXNvdXJjZV9sb2NrKTsKK30KK0VYUE9SVF9TWU1CT0wo
bWVyZ2VfY2hpbGRfbWVtX3Jlc291cmNlcyk7CisjZW5kaWYJLyogQ09ORklHX01FTU9SWV9IT1RQ
TFVHICovCisKIC8qCiAgKiBNYW5hZ2VkIHJlZ2lvbiByZXNvdXJjZQogICovCi0tIAoyLjI2LjIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
