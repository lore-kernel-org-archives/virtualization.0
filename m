Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4627EC46467
	for <virtualization@archiver.kernel.org>; Mon, 16 Jan 2023 16:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4F9581E00;
	Mon, 16 Jan 2023 16:11:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4F9581E00
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M4ArWaQCGWk0; Mon, 16 Jan 2023 16:11:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1FD5781E10;
	Mon, 16 Jan 2023 16:11:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FD5781E10
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1D23C0032;
	Mon, 16 Jan 2023 16:11:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74789C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 16:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3497181E4C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 16:10:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3497181E4C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wIYbyB_ZJ5oc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 16:10:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 675CA81E26
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu
 [128.30.2.78])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 675CA81E26
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 16:10:46 +0000 (UTC)
Received: from c-24-17-218-140.hsd1.wa.comcast.net ([24.17.218.140]
 helo=srivatsab3MD6R.vmware.com)
 by outgoing2021.csail.mit.edu with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.95)
 (envelope-from <srivatsa@csail.mit.edu>) id 1pHS49-00Ec49-Pd;
 Mon, 16 Jan 2023 11:10:33 -0500
Subject: Re: [PATCH] x86/paravirt: merge activate_mm and dup_mmap callbacks
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux-foundation.org
References: <20230112152132.4399-1-jgross@suse.com>
 <3fcb5078-852e-0886-c084-7fb0cfa5b757@csail.mit.edu>
 <27d08d32-1a17-0959-203f-39e769f555d1@suse.com>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <6a8e25eb-758d-8ad6-23c1-5fea7dab3b09@csail.mit.edu>
Date: Mon, 16 Jan 2023 08:10:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <27d08d32-1a17-0959-203f-39e769f555d1@suse.com>
Content-Language: en-US
Cc: "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Alexey Makhalov <amakhalov@vmware.com>,
 xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

T24gMS8xNS8yMyAxMDo0MyBQTSwgSnVlcmdlbiBHcm9zcyB3cm90ZToKPiBPbiAxNi4wMS4yMyAw
NToyNywgU3JpdmF0c2EgUy4gQmhhdCB3cm90ZToKPj4KPj4gSGkgSnVlcmdlbiwKPj4KPj4gT24g
MS8xMi8yMyA3OjIxIEFNLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOgo+Pj4gVGhlIHR3byBwYXJhdmly
dCBjYWxsYmFja3MgLm1tdS5hY3RpdmF0ZV9tbSBhbmQgLm1tdS5kdXBfbW1hcCBhcmUKPj4+IHNo
YXJpbmcgdGhlIHNhbWUgaW1wbGVtZW50YXRpb25zIGluIGFsbCBjYXNlczogZm9yIFhlbiBQViBn
dWVzdHMgdGhleQo+Pj4gYXJlIHBpbm5pbmcgdGhlIFBHRCBvZiB0aGUgbmV3IG1tX3N0cnVjdCwg
YW5kIGZvciBhbGwgb3RoZXIgY2FzZXMKPj4+IHRoZXkgYXJlIGEgTk9QLgo+Pj4KPj4KPj4gSSB3
YXMgZXhwZWN0aW5nIHRoYXQgdGhlIGR1cGxpY2F0ZWQgZnVuY3Rpb25zIHhlbl9hY3RpdmF0ZV9t
bSgpIGFuZAo+PiB4ZW5fZHVwX21tYXAoKSB3b3VsZCBiZSBtZXJnZWQgaW50byBhIGNvbW1vbiBv
bmUsIGFuZCB0aGF0IGJvdGgKPj4gLm1tdS5hY3RpdmF0ZV9tbSBhbmQgLm1tdS5kdXBfbW1hcCBj
YWxsYmFja3Mgd291bGQgYmUgbWFwcGVkIHRvIHRoYXQKPj4gY29tbW9uIGltcGxlbWVudGF0aW9u
IGZvciBYZW4gUFYuCj4+Cj4+PiBTbyBtZXJnZSB0aGVtIHRvIGEgY29tbW9uIGNhbGxiYWNrIC5t
bXUuZW50ZXJfbW1hcCAoaW4gY29udHJhc3QgdG8gdGhlCj4+PiBjb3JyZXNwb25kaW5nIGFscmVh
ZHkgZXhpc3RpbmcgLm1tdS5leGl0X21tYXApLgo+Pj4KPj4KPj4gSW5zdGVhZCwgdGhpcyBwYXRj
aCBzZWVtcyB0byBiZSBtZXJnaW5nIHRoZSBjYWxsYmFja3MgdGhlbXNlbHZlcy4uLgo+Pgo+PiBJ
IHNlZSB0aGF0J3Mgbm90IGFuIGlzc3VlIHJpZ2h0IG5vdyBzaW5jZSB0aGVyZSBpcyBubyBvdGhl
ciBhY3R1YWwKPj4gdXNlciBmb3IgdGhlc2UgY2FsbGJhY2tzLiBCdXQgYXJlIHdlIHN1cmUgdGhh
dCBtZXJnaW5nIHRoZSBjYWxsYmFja3MKPj4ganVzdCBiZWNhdXNlIHRoZSBjdXJyZW50IHVzZXIg
KFhlbiBQVikgaGFzIHRoZSBzYW1lIGltcGxlbWVudGF0aW9uIGZvcgo+PiBib3RoIGlzIGEgZ29v
ZCBpZGVhPyBUaGUgY2FsbGJhY2tzIGFyZSBpbnZva2VkIGF0IGRpc3RpbmN0IHBvaW50cyBmcm9t
Cj4+IGZvcmsvZXhlYywgc28gd291bGRuJ3QgaXQgYmUgdmFsdWFibGUgdG8gcmV0YWluIHRoYXQg
ZGlzdGluY3Rpb24gaW4KPj4gc2VtYW50aWNzIGluIHRoZSBjYWxsYmFja3MgYXMgd2VsbD8KPj4K
Pj4gSG93ZXZlciwgaWYgeW91IGJlbGlldmUgdGhhdCB0d28gc2VwYXJhdGUgY2FsbGJhY2tzIGFy
ZSBub3QgcmVhbGx5Cj4+IHJlcXVpcmVkIGhlcmUgKGJlY2F1c2UgdGhlcmUgaXMgbm8gc2lnbmlm
aWNhbnQgZGlmZmVyZW5jZSBpbiB3aGF0IHRoZXkKPj4gbWVhbiwgcmF0aGVyIHRoYW4gYmVjYXVz
ZSB0aGVpciBjYWxsYmFjayBpbXBsZW1lbnRhdGlvbnMgaGFwcGVuIHRvIGJlCj4+IHRoZSBzYW1l
IHJpZ2h0IG5vdyksIHRoZW4gY291bGQgeW91IHBsZWFzZSBleHBhbmQgb24gdGhpcyBhbmQgY2Fs
bCBpdAo+PiBvdXQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCBwbGVhc2U/Cj4gCj4gV291bGQgeW91
IGJlIGZpbmUgd2l0aDoKPiAKPiDCoCBJbiB0aGUgZW5kIGJvdGggY2FsbGJhY2tzIGFyZSBtZWFu
dCB0byByZWdpc3RlciBhbiBhZGRyZXNzIHNwYWNlIHdpdGggdGhlCj4gwqAgdW5kZXJseWluZyBo
eXBlcnZpc29yLCBzbyB0aGVyZSBuZWVkcyB0byBiZSBvbmx5IGEgc2luZ2xlIGNhbGxiYWNrIGZv
ciB0aGF0Cj4gwqAgcHVycG9zZS4KPiAKClN1cmUsIHRoYXQgbG9va3MgZ29vZC4gVGhhbmsgeW91
IQogClJlZ2FyZHMsClNyaXZhdHNhClZNd2FyZSBQaG90b24gT1MKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
