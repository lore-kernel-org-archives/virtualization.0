Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D307DC433E2
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 20:11:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C3D6208FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 20:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmJwwx/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3D6208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 09E0086CE0;
	Tue,  8 Sep 2020 20:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ere5zEGvMZ0a; Tue,  8 Sep 2020 20:11:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1004B86EBB;
	Tue,  8 Sep 2020 20:11:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0810CC0859;
	Tue,  8 Sep 2020 20:11:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D494BC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 20:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B033A27A6E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 20:11:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id clGDk7jVgEPt
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 20:11:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id A6F262150A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 20:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599595871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XWGa3qSfN9Odfx6sHlIPwO9T/8fSKtz1FdQi3pBhRQ0=;
 b=fmJwwx/yLiiDaUw2tz0cH2djPZWOd+UwB8ClaG1Np5FgNH+2tb/EQ0iWHsA7/KCicJuQQP
 dYlWRgt0RtIHuBcd7pZ44DNLhCMqNz6q4QyOm/1F026N2OFG59n8eMBQCnwfilGycJExm5
 IugipTAEMIM2vc6wsut1Myf7OpYpoQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-ugEopWE8Oy6O8LRJQsXXwg-1; Tue, 08 Sep 2020 16:11:07 -0400
X-MC-Unique: ugEopWE8Oy6O8LRJQsXXwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4701F1007465;
 Tue,  8 Sep 2020 20:11:04 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-46.ams2.redhat.com [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E9B75D9E8;
 Tue,  8 Sep 2020 20:10:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] mm/memory_hotplug: MEMHP_MERGE_RESOURCE to specify
 merging of System RAM resources
Date: Tue,  8 Sep 2020 22:10:09 +0200
Message-Id: <20200908201012.44168-5-david@redhat.com>
In-Reply-To: <20200908201012.44168-1-david@redhat.com>
References: <20200908201012.44168-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
aGVuIHRoZQpvcGVyYXRpb24gZmFpbGVkIC0gZS5nLiwgZHVlIHRvIC1FTk9NRU0pLgoKQ2M6IEFu
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
ICAgICB8ICA0ICsrKwogaW5jbHVkZS9saW51eC9tZW1vcnlfaG90cGx1Zy5oIHwgIDkgKysrKysK
IGtlcm5lbC9yZXNvdXJjZS5jICAgICAgICAgICAgICB8IDYwICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysKIG1tL21lbW9yeV9ob3RwbHVnLmMgICAgICAgICAgICB8ICA3ICsrKysK
IDQgZmlsZXMgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvaW9wb3J0LmggYi9pbmNsdWRlL2xpbnV4L2lvcG9ydC5oCmluZGV4IGQ3NjIwZDdjOTQx
YTAuLjdlNjEzODlkY2IwMTcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvaW9wb3J0LmgKKysr
IGIvaW5jbHVkZS9saW51eC9pb3BvcnQuaApAQCAtNjAsNiArNjAsNyBAQCBzdHJ1Y3QgcmVzb3Vy
Y2UgewogCiAvKiBJT1JFU09VUkNFX1NZU1JBTSBzcGVjaWZpYyBiaXRzLiAqLwogI2RlZmluZSBJ
T1JFU09VUkNFX1NZU1JBTV9EUklWRVJfTUFOQUdFRAkweDAyMDAwMDAwIC8qIEFsd2F5cyBkZXRl
Y3RlZCB2aWEgYSBkcml2ZXIuICovCisjZGVmaW5lIElPUkVTT1VSQ0VfU1lTUkFNX01FUkdFQUJM
RQkJMHgwNDAwMDAwMCAvKiBSZXNvdXJjZSBjYW4gYmUgbWVyZ2VkLiAqLwogCiAjZGVmaW5lIElP
UkVTT1VSQ0VfRVhDTFVTSVZFCTB4MDgwMDAwMDAJLyogVXNlcmxhbmQgbWF5IG5vdCBtYXAgdGhp
cyByZXNvdXJjZSAqLwogCkBAIC0yNTMsNiArMjU0LDkgQEAgZXh0ZXJuIHZvaWQgX19yZWxlYXNl
X3JlZ2lvbihzdHJ1Y3QgcmVzb3VyY2UgKiwgcmVzb3VyY2Vfc2l6ZV90LAogZXh0ZXJuIHZvaWQg
cmVsZWFzZV9tZW1fcmVnaW9uX2FkanVzdGFibGUoc3RydWN0IHJlc291cmNlICosIHJlc291cmNl
X3NpemVfdCwKIAkJCQkJICByZXNvdXJjZV9zaXplX3QpOwogI2VuZGlmCisjaWZkZWYgQ09ORklH
X01FTU9SWV9IT1RQTFVHCitleHRlcm4gdm9pZCBtZXJnZV9zeXN0ZW1fcmFtX3Jlc291cmNlKHN0
cnVjdCByZXNvdXJjZSAqcmVzKTsKKyNlbmRpZgogCiAvKiBXcmFwcGVycyBmb3IgbWFuYWdlZCBk
ZXZpY2VzICovCiBzdHJ1Y3QgZGV2aWNlOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tZW1v
cnlfaG90cGx1Zy5oIGIvaW5jbHVkZS9saW51eC9tZW1vcnlfaG90cGx1Zy5oCmluZGV4IDVjZDQ4
MzMyY2UxMTkuLmZlYjRhYWMwM2YyZWIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbWVtb3J5
X2hvdHBsdWcuaAorKysgYi9pbmNsdWRlL2xpbnV4L21lbW9yeV9ob3RwbHVnLmgKQEAgLTY4LDYg
KzY4LDE1IEBAIHN0cnVjdCBtaHBfcGFyYW1zIHsKIAlwZ3Byb3RfdCBwZ3Byb3Q7CiB9OwogCisv
KiBGbGFncyB1c2VkIGZvciBhZGRfbWVtb3J5KCkgYW5kIGZyaWVuZHMuICovCisKKy8qCisgKiBB
bGxvdyBtZXJnaW5nIG9mIHRoZSBhZGRlZCBTeXN0ZW0gUkFNIHJlc291cmNlIHdpdGggYWRqYWNl
bnQsIG1lcmdlYWJsZQorICogcmVzb3VyY2VzLiBBZnRlciBhIHN1Y2Nlc3NmdWwgY2FsbCB0byBh
ZGRfbWVtb3J5X3Jlc291cmNlKCkgd2l0aCB0aGlzIGZsYWcKKyAqIHNldCwgdGhlIHJlc291cmNl
IHBvaW50ZXIgbXVzdCBubyBsb25nZXIgYmUgdXNlZCBhcyBpdCBtaWdodCBiZSBzdGFsZS4KKyAq
LworI2RlZmluZSBNRU1IUF9NRVJHRV9SRVNPVVJDRQkJMQorCiAvKgogICogWm9uZSByZXNpemlu
ZyBmdW5jdGlvbnMKICAqCmRpZmYgLS1naXQgYS9rZXJuZWwvcmVzb3VyY2UuYyBiL2tlcm5lbC9y
ZXNvdXJjZS5jCmluZGV4IDM2YjM1NTIyMTAxMjAuLjdhOTFiOTM1ZjRjMjAgMTAwNjQ0Ci0tLSBh
L2tlcm5lbC9yZXNvdXJjZS5jCisrKyBiL2tlcm5lbC9yZXNvdXJjZS5jCkBAIC0xMzYzLDYgKzEz
NjMsNjYgQEAgdm9pZCByZWxlYXNlX21lbV9yZWdpb25fYWRqdXN0YWJsZShzdHJ1Y3QgcmVzb3Vy
Y2UgKnBhcmVudCwKIH0KICNlbmRpZgkvKiBDT05GSUdfTUVNT1JZX0hPVFJFTU9WRSAqLwogCisj
aWZkZWYgQ09ORklHX01FTU9SWV9IT1RQTFVHCitzdGF0aWMgYm9vbCBzeXN0ZW1fcmFtX3Jlc291
cmNlc19tZXJnZWFibGUoc3RydWN0IHJlc291cmNlICpyMSwKKwkJCQkJICAgc3RydWN0IHJlc291
cmNlICpyMikKK3sKKwkvKiBXZSBhc3N1bWUgZWl0aGVyIHIxIG9yIHIyIGlzIElPUkVTT1VSQ0Vf
U1lTUkFNX01FUkdFQUJMRS4gKi8KKwlyZXR1cm4gcjEtPmZsYWdzID09IHIyLT5mbGFncyAmJiBy
MS0+ZW5kICsgMSA9PSByMi0+c3RhcnQgJiYKKwkgICAgICAgcjEtPm5hbWUgPT0gcjItPm5hbWUg
JiYgcjEtPmRlc2MgPT0gcjItPmRlc2MgJiYKKwkgICAgICAgIXIxLT5jaGlsZCAmJiAhcjItPmNo
aWxkOworfQorCisvKgorICogbWVyZ2Vfc3lzdGVtX3JhbV9yZXNvdXJjZSAtIG1hcmsgdGhlIFN5
c3RlbSBSQU0gcmVzb3VyY2UgbWVyZ2VhYmxlIGFuZCB0cnkgdG8KKyAqIG1lcmdlIGl0IHdpdGgg
YWRqYWNlbnQsIG1lcmdlYWJsZSByZXNvdXJjZXMKKyAqIEByZXM6IHJlc291cmNlIGRlc2NyaXB0
b3IKKyAqCisgKiBUaGlzIGludGVyZmFjZSBpcyBpbnRlbmRlZCBmb3IgbWVtb3J5IGhvdHBsdWcs
IHdoZXJlYnkgbG90cyBvZiBjb250aWd1b3VzCisgKiBzeXN0ZW0gcmFtIHJlc291cmNlcyBhcmUg
YWRkZWQgKGUuZy4sIHZpYSBhZGRfbWVtb3J5KigpKSBieSBhIGRyaXZlciwgYW5kCisgKiB0aGUg
YWN0dWFsIHJlc291cmNlIGJvdW5kYXJpZXMgYXJlIG5vdCBvZiBpbnRlcmVzdCAoZS5nLiwgaXQg
bWlnaHQgYmUKKyAqIHJlbGV2YW50IGZvciBESU1NcykuIE9ubHkgcmVzb3VyY2VzIHRoYXQgYXJl
IG1hcmtlZCBtZXJnZWFibGUsIHRoYXQgaGF2ZSB0aGUKKyAqIHNhbWUgcGFyZW50LCBhbmQgdGhh
dCBkb24ndCBoYXZlIGFueSBjaGlsZHJlbiBhcmUgY29uc2lkZXJlZC4gQWxsIG1lcmdlYWJsZQor
ICogcmVzb3VyY2VzIG11c3QgYmUgaW1tdXRhYmxlIGR1cmluZyB0aGUgcmVxdWVzdC4KKyAqCisg
KiBOb3RlOgorICogLSBUaGUgY2FsbGVyIGhhcyB0byBtYWtlIHN1cmUgdGhhdCBubyBwb2ludGVy
cyB0byByZXNvdXJjZXMgdGhhdCBhcmUKKyAqICAgbWFya2VkIG1lcmdlYWJsZSBhcmUgdXNlZCBh
bnltb3JlIGFmdGVyIHRoaXMgY2FsbCAtIHRoZSByZXNvdXJjZSBtaWdodAorICogICBiZSBmcmVl
ZCBhbmQgdGhlIHBvaW50ZXIgbWlnaHQgYmUgc3RhbGUhCisgKiAtIHJlbGVhc2VfbWVtX3JlZ2lv
bl9hZGp1c3RhYmxlKCkgd2lsbCBzcGxpdCBvbiBkZW1hbmQgb24gbWVtb3J5IGhvdHVucGx1Zwor
ICovCit2b2lkIG1lcmdlX3N5c3RlbV9yYW1fcmVzb3VyY2Uoc3RydWN0IHJlc291cmNlICpyZXMp
Cit7CisJY29uc3QgdW5zaWduZWQgbG9uZyBmbGFncyA9IElPUkVTT1VSQ0VfU1lTVEVNX1JBTSB8
IElPUkVTT1VSQ0VfQlVTWTsKKwlzdHJ1Y3QgcmVzb3VyY2UgKmN1cjsKKworCWlmIChXQVJOX09O
X09OQ0UoKHJlcy0+ZmxhZ3MgJiBmbGFncykgIT0gZmxhZ3MpKQorCQlyZXR1cm47CisKKwl3cml0
ZV9sb2NrKCZyZXNvdXJjZV9sb2NrKTsKKwlyZXMtPmZsYWdzIHw9IElPUkVTT1VSQ0VfU1lTUkFN
X01FUkdFQUJMRTsKKworCS8qIFRyeSB0byBtZXJnZSB3aXRoIG5leHQgaXRlbSBpbiB0aGUgbGlz
dC4gKi8KKwljdXIgPSByZXMtPnNpYmxpbmc7CisJaWYgKGN1ciAmJiBzeXN0ZW1fcmFtX3Jlc291
cmNlc19tZXJnZWFibGUocmVzLCBjdXIpKSB7CisJCXJlcy0+ZW5kID0gY3VyLT5lbmQ7CisJCXJl
cy0+c2libGluZyA9IGN1ci0+c2libGluZzsKKwkJZnJlZV9yZXNvdXJjZShjdXIpOworCX0KKwor
CS8qIFRyeSB0byBtZXJnZSB3aXRoIHByZXZpb3VzIGl0ZW0gaW4gdGhlIGxpc3QuICovCisJY3Vy
ID0gcmVzLT5wYXJlbnQtPmNoaWxkOworCXdoaWxlIChjdXIgJiYgY3VyLT5zaWJsaW5nICE9IHJl
cykKKwkJY3VyID0gY3VyLT5zaWJsaW5nOworCWlmIChjdXIgJiYgc3lzdGVtX3JhbV9yZXNvdXJj
ZXNfbWVyZ2VhYmxlKGN1ciwgcmVzKSkgeworCQljdXItPmVuZCA9IHJlcy0+ZW5kOworCQljdXIt
PnNpYmxpbmcgPSByZXMtPnNpYmxpbmc7CisJCWZyZWVfcmVzb3VyY2UocmVzKTsKKwl9CisJd3Jp
dGVfdW5sb2NrKCZyZXNvdXJjZV9sb2NrKTsKK30KKyNlbmRpZgkvKiBDT05GSUdfTUVNT1JZX0hP
VFBMVUcgKi8KKwogLyoKICAqIE1hbmFnZWQgcmVnaW9uIHJlc291cmNlCiAgKi8KZGlmZiAtLWdp
dCBhL21tL21lbW9yeV9ob3RwbHVnLmMgYi9tbS9tZW1vcnlfaG90cGx1Zy5jCmluZGV4IDY0YjA3
ZjAwNmJjMTAuLmY2MmMyYTQ2ZGY4YjEgMTAwNjQ0Ci0tLSBhL21tL21lbW9yeV9ob3RwbHVnLmMK
KysrIGIvbW0vbWVtb3J5X2hvdHBsdWcuYwpAQCAtMTEwMyw2ICsxMTAzLDEzIEBAIGludCBfX3Jl
ZiBhZGRfbWVtb3J5X3Jlc291cmNlKGludCBuaWQsIHN0cnVjdCByZXNvdXJjZSAqcmVzLAogCS8q
IGRldmljZV9vbmxpbmUoKSB3aWxsIHRha2UgdGhlIGxvY2sgd2hlbiBjYWxsaW5nIG9ubGluZV9w
YWdlcygpICovCiAJbWVtX2hvdHBsdWdfZG9uZSgpOwogCisJLyoKKwkgKiBJbiBjYXNlIHdlJ3Jl
IGFsbG93ZWQgdG8gbWVyZ2UgdGhlIHJlc291cmNlLCBmbGFnIGl0IGFuZCB0cmlnZ2VyCisJICog
bWVyZ2luZyBub3cgdGhhdCBhZGRpbmcgc3VjY2VlZGVkLgorCSAqLworCWlmIChmbGFncyAmIE1F
TUhQX01FUkdFX1JFU09VUkNFKQorCQltZXJnZV9zeXN0ZW1fcmFtX3Jlc291cmNlKHJlcyk7CisK
IAkvKiBvbmxpbmUgcGFnZXMgaWYgcmVxdWVzdGVkICovCiAJaWYgKG1lbWhwX2RlZmF1bHRfb25s
aW5lX3R5cGUgIT0gTU1PUF9PRkZMSU5FKQogCQl3YWxrX21lbW9yeV9ibG9ja3Moc3RhcnQsIHNp
emUsIE5VTEwsIG9ubGluZV9tZW1vcnlfYmxvY2spOwotLSAKMi4yNi4yCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
