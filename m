Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3276DC7EE2C
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 21:44:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4B4F8188A;
	Tue, 16 May 2023 21:44:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A4B4F8188A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BHW_t-DNPTlC; Tue, 16 May 2023 21:44:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2419B81858;
	Tue, 16 May 2023 21:44:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2419B81858
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05A2AC0037;
	Tue, 16 May 2023 21:44:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EB82C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 21:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05CB6616E1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 21:44:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05CB6616E1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dN2BcOsmL5Vr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 21:44:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3023660FC9
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3023660FC9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 21:44:30 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1B42C632DB;
 Tue, 16 May 2023 21:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF912C433EF;
 Tue, 16 May 2023 21:44:25 +0000 (UTC)
Date: Tue, 16 May 2023 17:44:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 01/20] x86: move prepare_ftrace_return prototype to header
Message-ID: <20230516174422.63e1e942@gandalf.local.home>
In-Reply-To: <20230516193549.544673-2-arnd@kernel.org>
References: <20230516193549.544673-1-arnd@kernel.org>
 <20230516193549.544673-2-arnd@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, linux-pci@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Alexey Makhalov <amakhalov@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, linux-trace-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 platform-driver-x86@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Andy Shevchenko <andy@infradead.org>
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

T24gVHVlLCAxNiBNYXkgMjAyMyAyMTozNTozMCArMDIwMApBcm5kIEJlcmdtYW5uIDxhcm5kQGtl
cm5lbC5vcmc+IHdyb3RlOgoKPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgo+
IAo+IE9uIDMyLWJpdCBidWlsZHMsIHRoZSBwcmVwYXJlX2Z0cmFjZV9yZXR1cm4oKSBmdW5jdGlv
biBvbmx5IGhhcyBhIGdsb2JhbAo+IGRlZmluaXRpb24sIGJ1dCBubyBwcm90b3R5cGUgYmVmb3Jl
IGl0LCB3aGljaCBjYXVzZXMgYSB3YXJuaW5nOgo+IAo+IGFyY2gveDg2L2tlcm5lbC9mdHJhY2Uu
Yzo2MjU6Njogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhwcmVwYXJlX2Z0
cmFjZV9yZXR1cm7igJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+ICAgNjI1IHwgdm9pZCBwcmVw
YXJlX2Z0cmFjZV9yZXR1cm4odW5zaWduZWQgbG9uZyBpcCwgdW5zaWduZWQgbG9uZyAqcGFyZW50
LAo+IAo+IE1vdmUgdGhlIHByb3RvdHlwZSB0aGF0IGlzIGFscmVhZHkgbmVlZGVkIGZvciBzb21l
IGNvbmZpZ3VyYXRpb25zIGludG8KPiBhIGhlYWRlciBmaWxlIHdoZXJlIGl0IGNhbiBiZSBzZWVu
IHVuY29uZGl0aW9uYWxseS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5k
QGFybmRiLmRlPgo+IC0tLQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9mdHJhY2UuaCB8IDMgKysr
Cj4gIGFyY2gveDg2L2tlcm5lbC9mdHJhY2UuYyAgICAgIHwgMyAtLS0KPiAgMiBmaWxlcyBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2Z0cmFjZS5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vZnRyYWNl
LmgKPiBpbmRleCA1MDYxYWM5OGZmYTEuLmI4ZDRhMDdmOTU5NSAxMDA2NDQKPiAtLS0gYS9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9mdHJhY2UuaAo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2Z0
cmFjZS5oCgpBY2tlZC1ieTogU3RldmVuIFJvc3RlZHQgKEdvb2dsZSkgPHJvc3RlZHRAZ29vZG1p
cy5vcmc+CgotLSBTdGV2ZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
