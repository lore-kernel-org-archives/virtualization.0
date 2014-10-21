From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: v3.18-rc1 32 bit KVM hangs early in boot process
Date: Tue, 21 Oct 2014 19:31:03 +0200
Message-ID: <54469857.3020203@gmx.de>
References: <5445479C.4030201@gmx.de>	<5446858B.3040107@gmx.de>
	<CA+5PVA5MCRhwnkbNXpMmLzeM4G=aau0kuRU_wma-5T59M+2vkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+5PVA5MCRhwnkbNXpMmLzeM4G=aau0kuRU_wma-5T59M+2vkA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

T24gMTAvMjEvMjAxNCAwNjo0MCBQTSwgSm9zaCBCb3llciB3cm90ZToKPiBPbiBUdWUsIE9jdCAy
MSwgMjAxNCBhdCAxMjoxMCBQTSwgVG9yYWxmIEbDtnJzdGVyIDx0b3JhbGYuZm9lcnN0ZXJAZ214
LmRlPiB3cm90ZToKPj4gT24gMTAvMjAvMjAxNCAwNzozNCBQTSwgVG9yYWxmIEbDtnJzdGVyIHdy
b3RlOgo+Pj4gSSB1cGxvYWRlZCB0aGUgc2NyZWVuIHNob3RzIGZyb20gdGhlIHZpcnQtbWFuYWdl
ciB0byBbMV0gYW5kIFsyXQo+Pj4KPj4+IEZXSVcgZTU2ZDlmY2NiIHdhcyBmaW5lIHNvIHRoZSBi
dWcgc2xpcHBlZCBpbiBhZnRlciB0aGF0Lgo+Pj4KPj4KPj4+Cj4+PiBbMV0gaHR0cDovL3d3dy5k
aXJlY3R1cGxvYWQubmV0L2ZpbGUvZC8zNzgxL2o5bXdydHBxX2pwZy5odG0KPj4+IFsyXSBodHRw
Oi8vd3d3LmRpcmVjdHVwbG9hZC5uZXQvZmlsZS9kLzM3ODEvMjl0cmM1NnZfanBnLmh0bQo+Pj4K
Pj4gSXQgbWlnaHQgYmUgdmlydGlvLWNvbnNvbGUgcmVsYXRlZCwgd2hlbiB0aGUgdWV2ZXRucyBh
cmUgcHJvY2Vzc2VkOgo+Pgo+PiBodHRwOi8vd3d3LmRpcmVjdHVwbG9hZC5uZXQvZmlsZS9kLzM3
ODIvNmxnNXlpaGhfanBnLmh0bQo+IAo+IFRyeQo+IGh0dHA6Ly9taWQuZ21hbmUub3JnLzE0MTM4
MTM1MjktMTEwNDQtMS1naXQtc2VuZC1lbWFpbC1jb3JuZWxpYS5odWNrQGRlLmlibS5jb20KPiAK
PiBqb3NoCj4gCkhlbHBzIGEgbGl0dGxlIGJpdCwgbm93IGl0IGNvbnRpbnVlcyB0aWxsCgpJTklU
OiBJZCAiYzYiIHJlc3Bhd25pbmcgdG9vIGZhc3Q6IGRpc2FibGVkIGZvciA1IG1pbnV0ZXMiCi4u
LgpJTklUO25vIG1vcmUgcHJvY2Vzc2VzIGxlZnQgaW4gdGhpcyBydW5sZXZlbAoKCihCVFcgZ21h
bmUgc3Vja3MsIGIvYyBJIGNvdWxkbid0IHNhdmUgdGhhdCBwb3N0IGRpcmVjdGx5LCBob3cgY2Fu
IEkgZG93bmxvYWQgYSBwYXRjaCBmcm9tIHRoYXQgcGFnZSA/KQoKLS0gClRvcmFsZgpwZ3Aga2V5
OiAwMDc2IEU5NEUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
