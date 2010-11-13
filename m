From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 06/20] x86/ticketlock: make __ticket_spin_trylock common
Date: Sat, 13 Nov 2010 11:48:41 +0100
Message-ID: <1289645321.2743.21.camel__1836.18514934114$1289645388$gmane$org@edumazet-laptop>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
	<4cea7b0804de5a2c1249034fc5c4840ade043ff4.1288794124.git.jeremy.fitzhardinge@citrix.com>
	<20101113101732.GH3837@hack>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20101113101732.GH3837@hack>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>
Cc: Nick Piggin <npiggin@suse.de>, Xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <peterz@infradead.org>, Srivatsa@smtp1.linux-foundation.org, Linux@smtp1.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Virtualization <virtualization@lists.linux-foundation.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

TGUgc2FtZWRpIDEzIG5vdmVtYnJlIDIwMTAgw6AgMTg6MTcgKzA4MDAsIEFtw6lyaWNvIFdhbmcg
YSDDqWNyaXQgOgo+IE9uIFdlZCwgTm92IDAzLCAyMDEwIGF0IDEwOjU5OjQ3QU0gLTA0MDAsIEpl
cmVteSBGaXR6aGFyZGluZ2Ugd3JvdGU6Cj4gCj4gPisJdW5pb24gewo+ID4rCQlzdHJ1Y3QgX19y
YXdfdGlja2V0cyB0aWNrZXRzOwo+ID4rCQlfX3RpY2tldHBhaXJfdCBzbG9jazsKPiA+Kwl9IHRt
cCwgbmV3Owo+ID4rCWludCByZXQ7Cj4gPisKPiA+Kwl0bXAudGlja2V0cyA9IEFDQ0VTU19PTkNF
KGxvY2stPnRpY2tldHMpOwo+ID4rCWlmICh0bXAudGlja2V0cy5oZWFkICE9IHRtcC50aWNrZXRz
LnRhaWwpCj4gPisJCXJldHVybiAwOwo+ID4rCj4gPisJbmV3LnNsb2NrID0gdG1wLnNsb2NrICsg
KDEgPDwgVElDS0VUX1NISUZUKTsKPiA+Kwo+ID4rCXJldCA9IGNtcHhjaGcoJmxvY2stPnRpY2tl
dHBhaXIsIHRtcC5zbG9jaywgbmV3LnNsb2NrKSA9PSB0bXAuc2xvY2s7Cj4gPisJYmFycmllcigp
OwkJLyoganVzdCBtYWtlIG5vdGhpbmcgY3JlZXBzIGJlZm9yZSBsb2NrIGlzIGNsYWltZWQgKi8K
PiAKPiBUaGlzIG9uZSBzaG91bGQgYmUgc21wX3dtYigpLCByaWdodD8gTm8gQ09ORklHX1g4Nl9P
T1NUT1JFIHByb3RlY3RlZC4KCmNtcHhjaGcoKSBpcyBhIGZ1bGwgbWVtb3J5IGJhcnJpZXIsIG5v
IG5lZWQgZm9yIHNtcF93bWIoKSBvciBiYXJyaWVyKCkKCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
