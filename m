Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F60C2BB41
	for <virtualization@archiver.kernel.org>; Sat, 13 Aug 2022 22:00:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66C0C83E80;
	Sat, 13 Aug 2022 22:00:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66C0C83E80
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=czriY2QS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id in7Er06bh_0h; Sat, 13 Aug 2022 22:00:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D4E0582883;
	Sat, 13 Aug 2022 22:00:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4E0582883
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9CF9C0033;
	Sat, 13 Aug 2022 22:00:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF6FBC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Aug 2022 22:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8535982A29
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Aug 2022 22:00:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8535982A29
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6TFF3D4IFNd3
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Aug 2022 22:00:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61A9182883
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 61A9182883
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Aug 2022 22:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660428043; x=1691964043;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=J2stkkYmPik2bQMds1PPTKQFWYY4K6w3/+pjsawBn4I=;
 b=czriY2QSJtsHs+0YJIn5ie4MEylQAeO1kW/kS7jZoyutko3tg5lYKLsh
 U8uwSotSnGfPl2vJQS7mXtH4oMFazwVlS/Xc7jXjm/W0R2M8xn4DxBnHw
 kIWTBYyV1rhIi/CUgFr62xfLVN+CqYCowKo4VrUWdTiHHWU6njZrRlHxQ
 kaTEKulZ63EuSu4qn9pNqf4xP0sdTWK/u2NAugMb9FbtEUSj30NAXgimh
 5qPunzQISbEjtHhAHANiwq1Jl2HcUvhbN24qdPsixdN+lNMnl7ALLrf3m
 ZKPstDNZJppuxJNs4K8cjvcKaPPyhu1ezSatsWfsJc/83jLR0F08xO9ot w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="378070107"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; d="scan'208";a="378070107"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2022 15:00:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; d="scan'208";a="635047705"
Received: from tsaiyinl-mobl1.amr.corp.intel.com (HELO localhost)
 ([10.209.125.19])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2022 15:00:40 -0700
From: ira.weiny@intel.com
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>
Subject: [PATCH] checkpatch: Add kmap and kmap_atomic to the deprecated list
Date: Sat, 13 Aug 2022 15:00:34 -0700
Message-Id: <20220813220034.806698-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Cc: nvdimm@lists.linux.dev, kvm@vger.kernel.org, linux-sh@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net, dri-devel@lists.freedesktop.org,
 linux-mips@vger.kernel.org, linux-ide@vger.kernel.org, dm-devel@redhat.com,
 keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux1394-devel@lists.sourceforge.net, Ira Weiny <ira.weiny@intel.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 linux-csky@vger.kernel.org, iommu@lists.linux.dev,
 linux-snps-arc@lists.infradead.org,
 "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
 linux-media@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, loongarch@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
 linux-raid@vger.kernel.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
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

RnJvbTogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPgoKa21hcCgpIGFuZCBrbWFwX2F0
b21pYygpIGFyZSBiZWluZyBkZXByZWNhdGVkIGluIGZhdm9yIG9mCmttYXBfbG9jYWxfcGFnZSgp
LgoKVGhlcmUgYXJlIHR3byBtYWluIHByb2JsZW1zIHdpdGgga21hcCgpOiAoMSkgSXQgY29tZXMg
d2l0aCBhbiBvdmVyaGVhZAphcyBtYXBwaW5nIHNwYWNlIGlzIHJlc3RyaWN0ZWQgYW5kIHByb3Rl
Y3RlZCBieSBhIGdsb2JhbCBsb2NrIGZvcgpzeW5jaHJvbml6YXRpb24gYW5kICgyKSBpdCBhbHNv
IHJlcXVpcmVzIGdsb2JhbCBUTEIgaW52YWxpZGF0aW9uIHdoZW4KdGhlIGttYXDigJlzIHBvb2wg
d3JhcHMgYW5kIGl0IG1pZ2h0IGJsb2NrIHdoZW4gdGhlIG1hcHBpbmcgc3BhY2UgaXMgZnVsbHkK
dXRpbGl6ZWQgdW50aWwgYSBzbG90IGJlY29tZXMgYXZhaWxhYmxlLgoKa21hcF9sb2NhbF9wYWdl
KCkgaXMgc2FmZSBmcm9tIGFueSBjb250ZXh0IGFuZCBpcyB0aGVyZWZvcmUgcmVkdW5kYW50Cndp
dGgga21hcF9hdG9taWMoKSB3aXRoIHRoZSBleGNlcHRpb24gb2YgYW55IHBhZ2VmYXVsdCBvciBw
cmVlbXB0aW9uCmRpc2FibGUgcmVxdWlyZW1lbnRzLiAgSG93ZXZlciwgdXNpbmcga21hcF9hdG9t
aWMoKSBmb3IgdGhlc2Ugc2lkZQplZmZlY3RzIG1ha2VzIHRoZSBjb2RlIGxlc3MgY2xlYXIuICBT
byBhbnkgcmVxdWlyZW1lbnQgZm9yIHBhZ2VmYXVsdCBvcgpwcmVlbXB0aW9uIGRpc2FibGUgc2hv
dWxkIGJlIG1hZGUgZXhwbGljaXRseS4KCldpdGgga21hcF9sb2NhbF9wYWdlKCkgdGhlIG1hcHBp
bmdzIGFyZSBwZXIgdGhyZWFkLCBDUFUgbG9jYWwsIGNhbiB0YWtlCnBhZ2UgZmF1bHRzLCBhbmQg
Y2FuIGJlIGNhbGxlZCBmcm9tIGFueSBjb250ZXh0IChpbmNsdWRpbmcgaW50ZXJydXB0cykuCkl0
IGlzIGZhc3RlciB0aGFuIGttYXAoKSBpbiBrZXJuZWxzIHdpdGggSElHSE1FTSBlbmFibGVkLiBG
dXJ0aGVybW9yZSwKdGhlIHRhc2tzIGNhbiBiZSBwcmVlbXB0ZWQgYW5kLCB3aGVuIHRoZXkgYXJl
IHNjaGVkdWxlZCB0byBydW4gYWdhaW4sCnRoZSBrZXJuZWwgdmlydHVhbCBhZGRyZXNzZXMgYXJl
IHJlc3RvcmVkLgoKU3VnZ2VzdGVkLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4KU3VnZ2VzdGVkLWJ5OiBGYWJpbyBNLiBEZSBGcmFuY2VzY28gPGZtZGVmcmFuY2VzY29A
Z21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+
CgotLS0KU3VnZ2VzdGVkIGJ5IGNyZWRpdHMuCglUaG9tYXM6IElkZWEgdG8ga2VlcCBmcm9tIGdy
b3dpbmcgbW9yZSBrbWFwL2ttYXBfYXRvbWljIGNhbGxzLgoJRmFiaW86IFN0b2xlIHNvbWUgb2Yg
aGlzIGJvaWxlciBwbGF0ZSBjb21taXQgbWVzc2FnZS4KCk5vdGVzIG9uIHRyZWUtd2lkZSBjb252
ZXJzaW9uczoKCkkndmUgY2MnZWQgbWFpbGluZyBsaXN0cyBmb3Igc3Vic3lzdGVtcyB3aGljaCBj
dXJyZW50bHkgY29udGFpbnMgZWl0aGVyIGttYXAoKQpvciBrbWFwX2F0b21pYygpIGNhbGxzLiAg
QXMgc29tZSBvZiB5b3UgYWxyZWFkeSBrbm93IEZhYmlvIGFuZCBJIGhhdmUgYmVlbgp3b3JraW5n
IHRocm91Z2ggY29udmVydGluZyBrbWFwKCkgY2FsbHMgdG8ga21hcF9sb2NhbF9wYWdlKCkuICBC
dXQgdGhlcmUgaXMgYQpsb3QgbW9yZSB3b3JrIHRvIGJlIGRvbmUuICBIZWxwIGZyb20gdGhlIGNv
bW11bml0eSBpcyBhbHdheXMgd2VsY29tZSwKZXNwZWNpYWxseSB3aXRoIGttYXBfYXRvbWljKCkg
Y29udmVyc2lvbnMuICBUbyBrZWVwIGZyb20gc3RlcHBpbmcgb24gZWFjaApvdGhlcnMgdG9lcyBJ
J3ZlIGNyZWF0ZWQgYSBzcHJlYWRzaGVldCBvZiB0aGUgY3VycmVudCBjYWxsc1sxXS4gIFBsZWFz
ZSBsZXQgbWUKb3IgRmFiaW8ga25vdyBpZiB5b3UgcGxhbiBvbiB0YWNraW5nIG9uZSBvZiB0aGUg
Y29udmVyc2lvbnMgc28gd2UgY2FuIG1hcmsgaXQKb2ZmIHRoZSBsaXN0LgoKWzFdIGh0dHBzOi8v
ZG9jcy5nb29nbGUuY29tL3NwcmVhZHNoZWV0cy9kLzFpX2NrWjEwcDkwYkhfQ2t4RDJiWU5pMDVT
MlF6ODRFMk9GUHY4enFfXzB3L2VkaXQjZ2lkPTE2Nzk3MTQzNTcKCi0tLQogc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL3NjcmlwdHMvY2hlY2twYXRjaC5wbCBiL3NjcmlwdHMvY2hlY2twYXRjaC5wbAppbmRl
eCA3OWU3NTlhYWM1NDMuLjlmZjIxOWUwYTlkNSAxMDA3NTUKLS0tIGEvc2NyaXB0cy9jaGVja3Bh
dGNoLnBsCisrKyBiL3NjcmlwdHMvY2hlY2twYXRjaC5wbApAQCAtODA3LDYgKzgwNyw4IEBAIG91
ciAlZGVwcmVjYXRlZF9hcGlzID0gKAogCSJyY3VfYmFycmllcl9zY2hlZCIJCQk9PiAicmN1X2Jh
cnJpZXIiLAogCSJnZXRfc3RhdGVfc3luY2hyb25pemVfc2NoZWQiCQk9PiAiZ2V0X3N0YXRlX3N5
bmNocm9uaXplX3JjdSIsCiAJImNvbmRfc3luY2hyb25pemVfc2NoZWQiCQk9PiAiY29uZF9zeW5j
aHJvbml6ZV9yY3UiLAorCSJrbWFwIgkJCQkJPT4gImttYXBfbG9jYWxfcGFnZSIsCisJImttYXBf
YXRvbWljIgkJCQk9PiAia21hcF9sb2NhbF9wYWdlIiwKICk7CiAKICNDcmVhdGUgYSBzZWFyY2gg
cGF0dGVybiBmb3IgYWxsIHRoZXNlIHN0cmluZ3MgdG8gc3BlZWQgdXAgYSBsb29wIGJlbG93Cgpi
YXNlLWNvbW1pdDogNGE5MzUwNTk3YWZmNTBiYmQwZjRiODBjY2Y0OWQyZTAyZDExMTFmNQotLSAK
Mi4zNS4zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
