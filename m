Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615A6C433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Jun 2022 16:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A27760B02;
	Tue, 14 Jun 2022 16:44:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kHsRpoK1p2sn; Tue, 14 Jun 2022 16:44:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 989726077D;
	Tue, 14 Jun 2022 16:44:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F83DC0039;
	Tue, 14 Jun 2022 16:44:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4799C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 16:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B098141576
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 16:44:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W_4ccmEQmeCF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 16:44:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66644410BB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=lGPDnVOvpW5cJYkNK5aiO+HQt8YloxSeZZcAt0L3T+0=; b=DAyjnelx4YBZDCDKjW1vABnwD6
 bfuQInSMcO0k1N9c43zulrHrt0FEspCLqBV7dzVlaMMaDm/0d8h+E1vx/Mn16eV+mdIA5cFTuH3pJ
 ZPctIYIGAc1IQVFMkXT59RectB0+FvezRUN6pXOBo7jPhyxeW7DquiSvQAiutE+ZX5GvtHgbHFHRx
 6HNiF1zBAiNoXSUuUybOLrpKXxYLhLp7SkKzRQuOg8AsSzW4GjX7X7PIc8C1Yqe4MS+PoRyI4eENc
 TnTVXl8b+mj78ByEoizyUwQl4K8tWC0/1bV8h78+HtzLeArX034mK97ekOVdMcZW15wljxz2QwCm7
 eJasXJFA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1o19e7-007uTz-7Y; Tue, 14 Jun 2022 16:44:05 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BBDAE3002BE;
 Tue, 14 Jun 2022 18:44:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id A1F7228B3F630; Tue, 14 Jun 2022 18:44:02 +0200 (CEST)
Date: Tue, 14 Jun 2022 18:44:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nadav Amit <namit@vmware.com>
Subject: Re: [Pv-drivers] [PATCH 29/36] cpuidle,	xenpv: Make more
 PARAVIRT_XXL noinstr clean
Message-ID: <Yqi60lnN6MQpysBw@hirez.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.759631860@infradead.org>
 <510b9b68-7d53-7d4d-5a05-37fbd199eb4b@csail.mit.edu>
 <BAE566A0-AEA3-493E-8AC5-912C795BF1DE@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BAE566A0-AEA3-493E-8AC5-912C795BF1DE@vmware.com>
Cc: "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "bsegall@google.com" <bsegall@google.com>,
 "guoren@kernel.org" <guoren@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
 "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "mattst88@gmail.com" <mattst88@gmail.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "sammy@sammy.net" <sammy@sammy.net>, "pmladek@suse.com" <pmladek@suse.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
 "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "acme@kernel.org" <acme@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
 "svens@linux.ibm.com" <svens@linux.ibm.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "paulus@samba.org" <paulus@samba.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 "James.Bottomley@hansenpartnership.com"
 <James.Bottomley@hansenpartnership.com>,
 "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "kernel@xen0n.name" <kernel@xen0n.name>,
 "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
 linux-s390 <linux-s390@vger.kernel.org>,
 "vschneid@redhat.com" <vschneid@redhat.com>,
 "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
 "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
 "festevam@gmail.com" <festevam@gmail.com>, "deller@gmx.de" <deller@gmx.de>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "hca@linux.ibm.com" <hca@linux.ibm.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "shorne@gmail.com" <shorne@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "chris@zankel.net" <chris@zankel.net>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "dinguyen@kernel.org" <dinguyen@kernel.org>,
 "bristot@redhat.com" <bristot@redhat.com>,
 "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
 "joel@joelfernandes.org" <joel@joelfernandes.org>,
 Will Deacon <will@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "tony@atomide.com" <tony@atomide.com>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 Mel Gorman <mgorman@suse.de>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 "ulli.kroll@googlemail.com" <ulli.kroll@googlemail.com>,
 "vgupta@kernel.org" <vgupta@kernel.org>,
 "josh@joshtriplett.org" <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "bcain@quicinc.com" <bcain@quicinc.com>,
 "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "anup@brainfault.org" <anup@brainfault.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "dalias@libc.org" <dalias@libc.org>, Pv-drivers <Pv-drivers@vmware.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 "jonas@southpole.se" <jonas@southpole.se>,
 "yury.norov@gmail.com" <yury.norov@gmail.com>,
 "richard@nod.at" <richard@nod.at>, X86 ML <x86@kernel.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "agross@kernel.org" <agross@kernel.org>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "frederic@kernel.org" <frederic@kernel.org>,
 "stefan.kristiansson@saunalahti.fi" <stefan.kristiansson@saunalahti.fi>,
 "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
 "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>,
 "monstr@monstr.eu" <monstr@monstr.eu>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

T24gTW9uLCBKdW4gMTMsIDIwMjIgYXQgMDc6MjM6MTNQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90
ZToKPiBPbiBKdW4gMTMsIDIwMjIsIGF0IDExOjQ4IEFNLCBTcml2YXRzYSBTLiBCaGF0IDxzcml2
YXRzYUBjc2FpbC5taXQuZWR1PiB3cm90ZToKPiAKPiA+IOKaoCBFeHRlcm5hbCBFbWFpbAo+ID4g
Cj4gPiBPbiA2LzgvMjIgNDoyNyBQTSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6Cj4gPj4gdm1saW51
eC5vOiB3YXJuaW5nOiBvYmp0b29sOiBhY3BpX2lkbGVfZW50ZXJfczJpZGxlKzB4ZGU6IGNhbGwg
dG8gd2JpbnZkKCkgbGVhdmVzIC5ub2luc3RyLnRleHQgc2VjdGlvbgo+ID4+IHZtbGludXgubzog
d2FybmluZzogb2JqdG9vbDogZGVmYXVsdF9pZGxlKzB4NDogY2FsbCB0byBhcmNoX3NhZmVfaGFs
dCgpIGxlYXZlcyAubm9pbnN0ci50ZXh0IHNlY3Rpb24KPiA+PiB2bWxpbnV4Lm86IHdhcm5pbmc6
IG9ianRvb2w6IHhlbl9zYWZlX2hhbHQrMHhhOiBjYWxsIHRvIEhZUEVSVklTT1Jfc2NoZWRfb3Au
Y29uc3Rwcm9wLjAoKSBsZWF2ZXMgLm5vaW5zdHIudGV4dCBzZWN0aW9uCj4gPj4gCj4gPj4gU2ln
bmVkLW9mZi1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
Cj4gPiAKPiA+IFJldmlld2VkLWJ5OiBTcml2YXRzYSBTLiBCaGF0IChWTXdhcmUpIDxzcml2YXRz
YUBjc2FpbC5taXQuZWR1Pgo+ID4gCj4gPj4gCj4gPj4gLXN0YXRpYyBpbmxpbmUgdm9pZCB3Ymlu
dmQodm9pZCkKPiA+PiArZXh0ZXJuIG5vaW5zdHIgdm9pZCBwdl9uYXRpdmVfd2JpbnZkKHZvaWQp
Owo+ID4+ICsKPiA+PiArc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIHdiaW52ZCh2b2lkKQo+
ID4+IHsKPiA+PiAgICAgIFBWT1BfQUxUX1ZDQUxMMChjcHUud2JpbnZkLCAid2JpbnZkIiwgQUxU
X05PVChYODZfRkVBVFVSRV9YRU5QVikpOwo+ID4+IH0KPiAKPiBJIGd1ZXNzIGl0IGlzIHlldCBh
bm90aGVyIGluc3RhbmNlIG9mIHdyb25nIGFjY291bnRpbmcgb2YgR0NDIGZvcgo+IHRoZSBhc3Nl
bWJseSBibG9ja3PigJkgd2VpZ2h0LiBJIGd1ZXNzIGl0IGlzIG5vdCBhIHNvbHV0aW9uIGZvciBv
bGRlcgo+IEdDQ3MsIGJ1dCBwcmVzdW1hYmx5IF9fX19QVk9QX0FMVF9DQUxMKCkgYW5kIGZyaWVu
ZHMgc2hvdWxkIGhhdmUKPiB1c2VkIGFzbV9pbmxpbmUgb3Igc29tZSBuZXcg4oCcYXNtX3ZvbGF0
aWxlX2lubGluZeKAnSB2YXJpYW50LgoKUGFydGlhbGx5LCBzb21lIG9mIHRoZSAqU0FOIG9wdGlv
bnMgYWxzbyBnZW5lcmF0ZSBhIG1ldHJpYyB0b24gb2YKbm9uc2Vuc2Ugd2hlbiBlbmFibGVkIGFu
ZCBza2V3IHRoZSBjb21waWxlcnMgdG93YXJkcyBub3QgaW5saW5pbmcKdGhpbmdzLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
