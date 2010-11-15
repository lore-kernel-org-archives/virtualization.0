From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 06/20] x86/ticketlock: make __ticket_spin_trylock common
Date: Mon, 15 Nov 2010 11:39:03 -0800
Message-ID: <4CE18C57.9070805__7578.39081711626$1289850315$gmane$org@goop.org>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>	
	<4cea7b0804de5a2c1249034fc5c4840ade043ff4.1288794124.git.jeremy.fitzhardinge@citrix.com>	
	<20101113101732.GH3837@hack>
	<1289645321.2743.21.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1289645321.2743.21.camel@edumazet-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Nick Piggin <npiggin@suse.de>, Xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <peterz@infradead.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?B?QW3DqXJpY28gV2FuZw==?= <xiyou.wangcong@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMTEvMTMvMjAxMCAwMjo0OCBBTSwgRXJpYyBEdW1hemV0IHdyb3RlOgo+IExlIHNhbWVkaSAx
MyBub3ZlbWJyZSAyMDEwIMOgIDE4OjE3ICswODAwLCBBbcOpcmljbyBXYW5nIGEgw6ljcml0IDoK
Pj4gT24gV2VkLCBOb3YgMDMsIDIwMTAgYXQgMTA6NTk6NDdBTSAtMDQwMCwgSmVyZW15IEZpdHpo
YXJkaW5nZSB3cm90ZToKPj4KPj4+ICsJdW5pb24gewo+Pj4gKwkJc3RydWN0IF9fcmF3X3RpY2tl
dHMgdGlja2V0czsKPj4+ICsJCV9fdGlja2V0cGFpcl90IHNsb2NrOwo+Pj4gKwl9IHRtcCwgbmV3
Owo+Pj4gKwlpbnQgcmV0Owo+Pj4gKwo+Pj4gKwl0bXAudGlja2V0cyA9IEFDQ0VTU19PTkNFKGxv
Y2stPnRpY2tldHMpOwo+Pj4gKwlpZiAodG1wLnRpY2tldHMuaGVhZCAhPSB0bXAudGlja2V0cy50
YWlsKQo+Pj4gKwkJcmV0dXJuIDA7Cj4+PiArCj4+PiArCW5ldy5zbG9jayA9IHRtcC5zbG9jayAr
ICgxIDw8IFRJQ0tFVF9TSElGVCk7Cj4+PiArCj4+PiArCXJldCA9IGNtcHhjaGcoJmxvY2stPnRp
Y2tldHBhaXIsIHRtcC5zbG9jaywgbmV3LnNsb2NrKSA9PSB0bXAuc2xvY2s7Cj4+PiArCWJhcnJp
ZXIoKTsJCS8qIGp1c3QgbWFrZSBub3RoaW5nIGNyZWVwcyBiZWZvcmUgbG9jayBpcyBjbGFpbWVk
ICovCj4+IFRoaXMgb25lIHNob3VsZCBiZSBzbXBfd21iKCksIHJpZ2h0PyBObyBDT05GSUdfWDg2
X09PU1RPUkUgcHJvdGVjdGVkLgo+IGNtcHhjaGcoKSBpcyBhIGZ1bGwgbWVtb3J5IGJhcnJpZXIs
IG5vIG5lZWQgZm9yIHNtcF93bWIoKSBvciBiYXJyaWVyKCkKCkFncmVlZC4KCiAgICBKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
