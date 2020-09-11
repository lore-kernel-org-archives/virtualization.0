Return-Path: <SRS0=G0EF=CU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD035C433E2
	for <virtualization@archiver.kernel.org>; Fri, 11 Sep 2020 10:36:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA17221ED
	for <virtualization@archiver.kernel.org>; Fri, 11 Sep 2020 10:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iq0J1u0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA17221ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1A1A6876F8;
	Fri, 11 Sep 2020 10:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MwSxEg+Yckws; Fri, 11 Sep 2020 10:36:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2032187804;
	Fri, 11 Sep 2020 10:36:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02F53C0052;
	Fri, 11 Sep 2020 10:36:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1254C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 10:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CFF1E877FB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 10:36:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Euq4qM6UiC1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 10:36:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A5F1F876F8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599820560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BnrxSoOh/uq5q7BWXjNOPypcyuPGVWf3LbFO26fAERU=;
 b=iq0J1u0Iwluu+vEPnD3MnUzM0tnMm5XXtjzD99YbcHVAaJU/62qZqbeg05BtS99mBnxd9k
 yuK5+Sngqwxud7ktYC/qVC5ix1PJKEOPF7YrTvKAkSuBlnWqIilKzIbJdnz8MPlVTsE2mz
 xJIGHEi28z5ImOmLEIYG9jmWKp1L7Yo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-WJjyTmDAPdGgDjVu_RQJAw-1; Fri, 11 Sep 2020 06:35:56 -0400
X-MC-Unique: WJjyTmDAPdGgDjVu_RQJAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 878F010082E6;
 Fri, 11 Sep 2020 10:35:53 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-186.ams2.redhat.com [10.36.113.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B35EB81C44;
 Fri, 11 Sep 2020 10:35:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] mm/memory_hotplug: MEMHP_MERGE_RESOURCE to specify
 merging of System RAM resources
Date: Fri, 11 Sep 2020 12:34:56 +0200
Message-Id: <20200911103459.10306-6-david@redhat.com>
In-Reply-To: <20200911103459.10306-1-david@redhat.com>
References: <20200911103459.10306-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: linux-hyperv@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baoquan He <bhe@redhat.com>,
 linux-nvdimm@lists.01.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Julien Grall <julien@xen.org>,
 Kees Cook <keescook@chromium.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>,
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
aWJsZS4KCkxldCdzIHByb3ZpZGUgYSBmbGFnIChNRU1IUF9NRVJHRV9SRVNPVVJDRSkgdG8gc3Bl
Y2lmeSB0aGF0IGEgcmVzb3VyY2UKZWl0aGVyIGNyZWF0ZWQgd2l0aGluIGFkZF9tZW1vcnkqKCkg
b3IgcGFzc2VkIHZpYSBhZGRfbWVtb3J5X3Jlc291cmNlKCkKc2hhbGwgYmUgbWFya2VkIG1lcmdl
YWJsZSBhbmQgbWVyZ2VkIHdpdGggYXBwbGljYWJsZSBzaWJsaW5ncy4KClRvIGltcGxlbWVudCB0
aGF0LCB3ZSBuZWVkIGEga2VybmVsL3Jlc291cmNlIGludGVyZmFjZSB0byBtYXJrIHNlbGVjdGVk
ClN5c3RlbSBSQU0gcmVzb3VyY2VzIG1lcmdlYWJsZSAoSU9SRVNPVVJDRV9TWVNSQU1fTUVSR0VB
QkxFKSBhbmQgdHJpZ2dlcgptZXJnaW5nLgoKTm90ZTogV2UgcmVhbGx5IHdhbnQgdG8gbWVyZ2Ug
YWZ0ZXIgdGhlIHdob2xlIG9wZXJhdGlvbiBzdWNjZWVkZWQsIG5vdApkaXJlY3RseSB3aGVuIGFk
ZGluZyBhIHJlc291cmNlIHRvIHRoZSByZXNvdXJjZSB0cmVlIChpdCB3b3VsZCBicmVhawphZGRf
bWVtb3J5X3Jlc291cmNlKCkgYW5kIHJlcXVpcmUgc3BsaXR0aW5nIHJlc291cmNlcyBhZ2FpbiB3
aGVuIHRoZQpvcGVyYXRpb24gZmFpbGVkIC0gZS5nLiwgZHVlIHRvIC1FTk9NRU0pLgoKUmV2aWV3
ZWQtYnk6IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhLmxpbnV4QGdtYWlsLmNvbT4KQ2M6IEFu
ZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+CkNjOiBNaWNoYWwgSG9ja28g
PG1ob2Nrb0BzdXNlLmNvbT4KQ2M6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwu
Y29tPgpDYzogSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+CkNjOiBLZWVzIENvb2sgPGtl
ZXNjb29rQGNocm9taXVtLm9yZz4KQ2M6IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+
CkNjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KQ2M6ICJLLiBZLiBTcmlu
aXZhc2FuIiA8a3lzQG1pY3Jvc29mdC5jb20+CkNjOiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBt
aWNyb3NvZnQuY29tPgpDYzogU3RlcGhlbiBIZW1taW5nZXIgPHN0aGVtbWluQG1pY3Jvc29mdC5j
b20+CkNjOiBXZWkgTGl1IDx3ZWkubGl1QGtlcm5lbC5vcmc+CkNjOiBCb3JpcyBPc3Ryb3Zza3kg
PGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPgpDYzogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuY29tPgpDYzogU3RlZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPgpD
YzogUm9nZXIgUGF1IE1vbm7DqSA8cm9nZXIucGF1QGNpdHJpeC5jb20+CkNjOiBKdWxpZW4gR3Jh
bGwgPGp1bGllbkB4ZW4ub3JnPgpDYzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGEubGludXhA
Z21haWwuY29tPgpDYzogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+CkNjOiBXZWkgWWFuZyA8
cmljaGFyZHcueWFuZ0BsaW51eC5pbnRlbC5jb20+ClNpZ25lZC1vZmYtYnk6IERhdmlkIEhpbGRl
bmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPgotLS0KIGluY2x1ZGUvbGludXgvaW9wb3J0LmggICAg
ICAgICB8ICA0ICsrKwogaW5jbHVkZS9saW51eC9tZW1vcnlfaG90cGx1Zy5oIHwgIDcgKysrKwog
a2VybmVsL3Jlc291cmNlLmMgICAgICAgICAgICAgIHwgNjAgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogbW0vbWVtb3J5X2hvdHBsdWcuYyAgICAgICAgICAgIHwgIDcgKysrKwog
NCBmaWxlcyBjaGFuZ2VkLCA3OCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9pb3BvcnQuaCBiL2luY2x1ZGUvbGludXgvaW9wb3J0LmgKaW5kZXggZDc2MjBkN2M5NDFh
MC4uN2U2MTM4OWRjYjAxNyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9pb3BvcnQuaAorKysg
Yi9pbmNsdWRlL2xpbnV4L2lvcG9ydC5oCkBAIC02MCw2ICs2MCw3IEBAIHN0cnVjdCByZXNvdXJj
ZSB7CiAKIC8qIElPUkVTT1VSQ0VfU1lTUkFNIHNwZWNpZmljIGJpdHMuICovCiAjZGVmaW5lIElP
UkVTT1VSQ0VfU1lTUkFNX0RSSVZFUl9NQU5BR0VECTB4MDIwMDAwMDAgLyogQWx3YXlzIGRldGVj
dGVkIHZpYSBhIGRyaXZlci4gKi8KKyNkZWZpbmUgSU9SRVNPVVJDRV9TWVNSQU1fTUVSR0VBQkxF
CQkweDA0MDAwMDAwIC8qIFJlc291cmNlIGNhbiBiZSBtZXJnZWQuICovCiAKICNkZWZpbmUgSU9S
RVNPVVJDRV9FWENMVVNJVkUJMHgwODAwMDAwMAkvKiBVc2VybGFuZCBtYXkgbm90IG1hcCB0aGlz
IHJlc291cmNlICovCiAKQEAgLTI1Myw2ICsyNTQsOSBAQCBleHRlcm4gdm9pZCBfX3JlbGVhc2Vf
cmVnaW9uKHN0cnVjdCByZXNvdXJjZSAqLCByZXNvdXJjZV9zaXplX3QsCiBleHRlcm4gdm9pZCBy
ZWxlYXNlX21lbV9yZWdpb25fYWRqdXN0YWJsZShzdHJ1Y3QgcmVzb3VyY2UgKiwgcmVzb3VyY2Vf
c2l6ZV90LAogCQkJCQkgIHJlc291cmNlX3NpemVfdCk7CiAjZW5kaWYKKyNpZmRlZiBDT05GSUdf
TUVNT1JZX0hPVFBMVUcKK2V4dGVybiB2b2lkIG1lcmdlX3N5c3RlbV9yYW1fcmVzb3VyY2Uoc3Ry
dWN0IHJlc291cmNlICpyZXMpOworI2VuZGlmCiAKIC8qIFdyYXBwZXJzIGZvciBtYW5hZ2VkIGRl
dmljZXMgKi8KIHN0cnVjdCBkZXZpY2U7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21lbW9y
eV9ob3RwbHVnLmggYi9pbmNsdWRlL2xpbnV4L21lbW9yeV9ob3RwbHVnLmgKaW5kZXggMzNlYjgw
ZmRiYTIyZi4uZDY1YzZmZGM1Y2ZjMyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9tZW1vcnlf
aG90cGx1Zy5oCisrKyBiL2luY2x1ZGUvbGludXgvbWVtb3J5X2hvdHBsdWcuaApAQCAtNjIsNiAr
NjIsMTMgQEAgdHlwZWRlZiBpbnQgX19iaXR3aXNlIG1ocF90OwogCiAvKiBObyBzcGVjaWFsIHJl
cXVlc3QgKi8KICNkZWZpbmUgTUhQX05PTkUJCSgoX19mb3JjZSBtaHBfdCkwKQorLyoKKyAqIEFs
bG93IG1lcmdpbmcgb2YgdGhlIGFkZGVkIFN5c3RlbSBSQU0gcmVzb3VyY2Ugd2l0aCBhZGphY2Vu
dCwKKyAqIG1lcmdlYWJsZSByZXNvdXJjZXMuIEFmdGVyIGEgc3VjY2Vzc2Z1bCBjYWxsIHRvIGFk
ZF9tZW1vcnlfcmVzb3VyY2UoKQorICogd2l0aCB0aGlzIGZsYWcgc2V0LCB0aGUgcmVzb3VyY2Ug
cG9pbnRlciBtdXN0IG5vIGxvbmdlciBiZSB1c2VkIGFzIGl0CisgKiBtaWdodCBiZSBzdGFsZSwg
b3IgdGhlIHJlc291cmNlIG1pZ2h0IGhhdmUgY2hhbmdlZC4KKyAqLworI2RlZmluZSBNRU1IUF9N
RVJHRV9SRVNPVVJDRQkoKF9fZm9yY2UgbWhwX3QpQklUKDApKQogCiAvKgogICogRXh0ZW5kZWQg
cGFyYW1ldGVycyBmb3IgbWVtb3J5IGhvdHBsdWc6CmRpZmYgLS1naXQgYS9rZXJuZWwvcmVzb3Vy
Y2UuYyBiL2tlcm5lbC9yZXNvdXJjZS5jCmluZGV4IDM2YjM1NTIyMTAxMjAuLjdhOTFiOTM1ZjRj
MjAgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9yZXNvdXJjZS5jCisrKyBiL2tlcm5lbC9yZXNvdXJjZS5j
CkBAIC0xMzYzLDYgKzEzNjMsNjYgQEAgdm9pZCByZWxlYXNlX21lbV9yZWdpb25fYWRqdXN0YWJs
ZShzdHJ1Y3QgcmVzb3VyY2UgKnBhcmVudCwKIH0KICNlbmRpZgkvKiBDT05GSUdfTUVNT1JZX0hP
VFJFTU9WRSAqLwogCisjaWZkZWYgQ09ORklHX01FTU9SWV9IT1RQTFVHCitzdGF0aWMgYm9vbCBz
eXN0ZW1fcmFtX3Jlc291cmNlc19tZXJnZWFibGUoc3RydWN0IHJlc291cmNlICpyMSwKKwkJCQkJ
ICAgc3RydWN0IHJlc291cmNlICpyMikKK3sKKwkvKiBXZSBhc3N1bWUgZWl0aGVyIHIxIG9yIHIy
IGlzIElPUkVTT1VSQ0VfU1lTUkFNX01FUkdFQUJMRS4gKi8KKwlyZXR1cm4gcjEtPmZsYWdzID09
IHIyLT5mbGFncyAmJiByMS0+ZW5kICsgMSA9PSByMi0+c3RhcnQgJiYKKwkgICAgICAgcjEtPm5h
bWUgPT0gcjItPm5hbWUgJiYgcjEtPmRlc2MgPT0gcjItPmRlc2MgJiYKKwkgICAgICAgIXIxLT5j
aGlsZCAmJiAhcjItPmNoaWxkOworfQorCisvKgorICogbWVyZ2Vfc3lzdGVtX3JhbV9yZXNvdXJj
ZSAtIG1hcmsgdGhlIFN5c3RlbSBSQU0gcmVzb3VyY2UgbWVyZ2VhYmxlIGFuZCB0cnkgdG8KKyAq
IG1lcmdlIGl0IHdpdGggYWRqYWNlbnQsIG1lcmdlYWJsZSByZXNvdXJjZXMKKyAqIEByZXM6IHJl
c291cmNlIGRlc2NyaXB0b3IKKyAqCisgKiBUaGlzIGludGVyZmFjZSBpcyBpbnRlbmRlZCBmb3Ig
bWVtb3J5IGhvdHBsdWcsIHdoZXJlYnkgbG90cyBvZiBjb250aWd1b3VzCisgKiBzeXN0ZW0gcmFt
IHJlc291cmNlcyBhcmUgYWRkZWQgKGUuZy4sIHZpYSBhZGRfbWVtb3J5KigpKSBieSBhIGRyaXZl
ciwgYW5kCisgKiB0aGUgYWN0dWFsIHJlc291cmNlIGJvdW5kYXJpZXMgYXJlIG5vdCBvZiBpbnRl
cmVzdCAoZS5nLiwgaXQgbWlnaHQgYmUKKyAqIHJlbGV2YW50IGZvciBESU1NcykuIE9ubHkgcmVz
b3VyY2VzIHRoYXQgYXJlIG1hcmtlZCBtZXJnZWFibGUsIHRoYXQgaGF2ZSB0aGUKKyAqIHNhbWUg
cGFyZW50LCBhbmQgdGhhdCBkb24ndCBoYXZlIGFueSBjaGlsZHJlbiBhcmUgY29uc2lkZXJlZC4g
QWxsIG1lcmdlYWJsZQorICogcmVzb3VyY2VzIG11c3QgYmUgaW1tdXRhYmxlIGR1cmluZyB0aGUg
cmVxdWVzdC4KKyAqCisgKiBOb3RlOgorICogLSBUaGUgY2FsbGVyIGhhcyB0byBtYWtlIHN1cmUg
dGhhdCBubyBwb2ludGVycyB0byByZXNvdXJjZXMgdGhhdCBhcmUKKyAqICAgbWFya2VkIG1lcmdl
YWJsZSBhcmUgdXNlZCBhbnltb3JlIGFmdGVyIHRoaXMgY2FsbCAtIHRoZSByZXNvdXJjZSBtaWdo
dAorICogICBiZSBmcmVlZCBhbmQgdGhlIHBvaW50ZXIgbWlnaHQgYmUgc3RhbGUhCisgKiAtIHJl
bGVhc2VfbWVtX3JlZ2lvbl9hZGp1c3RhYmxlKCkgd2lsbCBzcGxpdCBvbiBkZW1hbmQgb24gbWVt
b3J5IGhvdHVucGx1ZworICovCit2b2lkIG1lcmdlX3N5c3RlbV9yYW1fcmVzb3VyY2Uoc3RydWN0
IHJlc291cmNlICpyZXMpCit7CisJY29uc3QgdW5zaWduZWQgbG9uZyBmbGFncyA9IElPUkVTT1VS
Q0VfU1lTVEVNX1JBTSB8IElPUkVTT1VSQ0VfQlVTWTsKKwlzdHJ1Y3QgcmVzb3VyY2UgKmN1cjsK
KworCWlmIChXQVJOX09OX09OQ0UoKHJlcy0+ZmxhZ3MgJiBmbGFncykgIT0gZmxhZ3MpKQorCQly
ZXR1cm47CisKKwl3cml0ZV9sb2NrKCZyZXNvdXJjZV9sb2NrKTsKKwlyZXMtPmZsYWdzIHw9IElP
UkVTT1VSQ0VfU1lTUkFNX01FUkdFQUJMRTsKKworCS8qIFRyeSB0byBtZXJnZSB3aXRoIG5leHQg
aXRlbSBpbiB0aGUgbGlzdC4gKi8KKwljdXIgPSByZXMtPnNpYmxpbmc7CisJaWYgKGN1ciAmJiBz
eXN0ZW1fcmFtX3Jlc291cmNlc19tZXJnZWFibGUocmVzLCBjdXIpKSB7CisJCXJlcy0+ZW5kID0g
Y3VyLT5lbmQ7CisJCXJlcy0+c2libGluZyA9IGN1ci0+c2libGluZzsKKwkJZnJlZV9yZXNvdXJj
ZShjdXIpOworCX0KKworCS8qIFRyeSB0byBtZXJnZSB3aXRoIHByZXZpb3VzIGl0ZW0gaW4gdGhl
IGxpc3QuICovCisJY3VyID0gcmVzLT5wYXJlbnQtPmNoaWxkOworCXdoaWxlIChjdXIgJiYgY3Vy
LT5zaWJsaW5nICE9IHJlcykKKwkJY3VyID0gY3VyLT5zaWJsaW5nOworCWlmIChjdXIgJiYgc3lz
dGVtX3JhbV9yZXNvdXJjZXNfbWVyZ2VhYmxlKGN1ciwgcmVzKSkgeworCQljdXItPmVuZCA9IHJl
cy0+ZW5kOworCQljdXItPnNpYmxpbmcgPSByZXMtPnNpYmxpbmc7CisJCWZyZWVfcmVzb3VyY2Uo
cmVzKTsKKwl9CisJd3JpdGVfdW5sb2NrKCZyZXNvdXJjZV9sb2NrKTsKK30KKyNlbmRpZgkvKiBD
T05GSUdfTUVNT1JZX0hPVFBMVUcgKi8KKwogLyoKICAqIE1hbmFnZWQgcmVnaW9uIHJlc291cmNl
CiAgKi8KZGlmZiAtLWdpdCBhL21tL21lbW9yeV9ob3RwbHVnLmMgYi9tbS9tZW1vcnlfaG90cGx1
Zy5jCmluZGV4IDhmMGJkN2M5YTYzYTUuLjU1M2M3MTgyMjZiM2UgMTAwNjQ0Ci0tLSBhL21tL21l
bW9yeV9ob3RwbHVnLmMKKysrIGIvbW0vbWVtb3J5X2hvdHBsdWcuYwpAQCAtMTEwMiw2ICsxMTAy
LDEzIEBAIGludCBfX3JlZiBhZGRfbWVtb3J5X3Jlc291cmNlKGludCBuaWQsIHN0cnVjdCByZXNv
dXJjZSAqcmVzLCBtaHBfdCBtaHBfZmxhZ3MpCiAJLyogZGV2aWNlX29ubGluZSgpIHdpbGwgdGFr
ZSB0aGUgbG9jayB3aGVuIGNhbGxpbmcgb25saW5lX3BhZ2VzKCkgKi8KIAltZW1faG90cGx1Z19k
b25lKCk7CiAKKwkvKgorCSAqIEluIGNhc2Ugd2UncmUgYWxsb3dlZCB0byBtZXJnZSB0aGUgcmVz
b3VyY2UsIGZsYWcgaXQgYW5kIHRyaWdnZXIKKwkgKiBtZXJnaW5nIG5vdyB0aGF0IGFkZGluZyBz
dWNjZWVkZWQuCisJICovCisJaWYgKG1ocF9mbGFncyAmIE1FTUhQX01FUkdFX1JFU09VUkNFKQor
CQltZXJnZV9zeXN0ZW1fcmFtX3Jlc291cmNlKHJlcyk7CisKIAkvKiBvbmxpbmUgcGFnZXMgaWYg
cmVxdWVzdGVkICovCiAJaWYgKG1lbWhwX2RlZmF1bHRfb25saW5lX3R5cGUgIT0gTU1PUF9PRkZM
SU5FKQogCQl3YWxrX21lbW9yeV9ibG9ja3Moc3RhcnQsIHNpemUsIE5VTEwsIG9ubGluZV9tZW1v
cnlfYmxvY2spOwotLSAKMi4yNi4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
