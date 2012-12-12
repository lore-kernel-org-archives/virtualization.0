From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [[PATCH v9 3/3] 1/1] virtio_console: Remove buffers from out_vq
	at port removal
Date: Wed, 12 Dec 2012 10:31:04 +1030
Message-ID: <87wqwo3zr3.fsf@rustcorp.com.au>
References: <029d7029bc1186fbd2ec74123dc88922b9600660.1352366215.git.amit.shah@redhat.com>
	<87ip96id3a.fsf@rustcorp.com.au>
	<20121210055401.GA17187@amit.redhat.com>
	<871uexec7e.fsf@rustcorp.com.au>
	<20121211041012.GA16297@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121211041012.GA16297@amit.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, sjur@brendeland.net, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, masami.hiramatsu.pt@hitachi.com, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

QW1pdCBTaGFoIDxhbWl0LnNoYWhAcmVkaGF0LmNvbT4gd3JpdGVzOgoKPiBPbiAoVHVlKSAxMSBE
ZWMgMjAxMiBbMDk6Mzk6NDFdLCBSdXN0eSBSdXNzZWxsIHdyb3RlOgo+PiBBbWl0IFNoYWggPGFt
aXQuc2hhaEByZWRoYXQuY29tPiB3cml0ZXM6Cj4+IAo+PiA+IE9uIChGcmkpIDE2IE5vdiAyMDEy
IFsxMToyMjowOV0sIFJ1c3R5IFJ1c3NlbGwgd3JvdGU6Cj4+ID4+IEFtaXQgU2hhaCA8YW1pdC5z
aGFoQHJlZGhhdC5jb20+IHdyaXRlczoKPj4gPj4gPiBGcm9tOiBTanVyIEJyw6ZuZGVsYW5kIDxz
anVyLmJyYW5kZWxhbmRAc3Rlcmljc3Nvbi5jb20+Cj4+ID4+ID4KPj4gPj4gPiBSZW1vdmUgYnVm
ZmVycyBmcm9tIHRoZSBvdXQtcXVldWUgd2hlbiBhIHBvcnQgaXMgcmVtb3ZlZC4gUnByb2Nfc2Vy
aWFsCj4+ID4+ID4gY29tbXVuaWNhdGVzIHdpdGggcmVtb3RlIHByb2Nlc3NvcnMgdGhhdCBtYXkg
Y3Jhc2ggYW5kIGxlYXZlIGJ1ZmZlcnMgaW4KPj4gPj4gPiB0aGUgb3V0LXF1ZXVlLiBUaGUgdmly
dGlvIHNlcmlhbCBwb3J0cyBtYXkgaGF2ZSBidWZmZXJzIGluIHRoZSBvdXQtcXVldWUKPj4gPj4g
PiBhcyB3ZWxsLCBlLmcuIGZvciBub24tYmxvY2tpbmcgcG9ydHMgYW5kIHRoZSBob3N0IGRpZG4n
dCBjb25zdW1lIHRoZW0KPj4gPj4gPiB5ZXQuCj4+ID4+ID4KPj4gPj4gPiBbQW1pdDogUmVtb3Zl
IFdBUk5fT04gZm9yIGdlbmVyaWMgcG9ydHMgY2FzZS5dCj4+ID4+ID4KPj4gPj4gPiBTaWduZWQt
b2ZmLWJ5OiBTanVyIEJyw6ZuZGVsYW5kIDxzanVyLmJyYW5kZWxhbmRAc3Rlcmljc3Nvbi5jb20+
Cj4+ID4+ID4gU2lnbmVkLW9mZi1ieTogQW1pdCBTaGFoIDxhbWl0LnNoYWhAcmVkaGF0LmNvbT4K
Pj4gPj4gCj4+ID4+IEkgYWxyZWFkeSBoYXZlIHRoaXMgaW4gbXkgcGVuZGluZyBxdWV1ZTsgSSd2
ZSBwcm9tb3RlZCBpdCB0byBteQo+PiA+PiB2aXJ0aW8tbmV4dCBicmFuY2ggbm93Lgo+PiA+Cj4+
ID4gUnVzdHksIEkgc3RpbGwgc2VlIHRoaXMgc2VyaWVzIGluIHlvdXIgcGVuZGluZyBxdWV1ZSwg
bm90IGluCj4+ID4gdmlydGlvLW5leHQuICBEaWQgYW55dGhpbmcgY2hhbmdlIGluIHRoZSBtZWFu
dGltZT8KPj4gCj4+IEhtbToKPj4gCj4+IDQwZTYyNWFjNTBmNDBkODdkZGJhOTMyODBkMGE1MDM0
MjVhYTY4ZTk/Cj4KPiBJJ20gc29ycnksIEkgbWVhbnQgdGhlIHJlbW90ZXByb2MgY29kZSwgbm90
IHRoaXMgcGF0Y2guCgpTdGlsbCB3YWl0aW5nIGZvciB2OSwgQUZJQUNUPwoKU2p1ciwgd2UncmUg
aW4gdGhlIG1lcmdlIHdpbmRvdyBub3csIHNvIGl0J2QgYmUgbmljZSB0byBnZXQgeW91ciBsYXRl
c3QKdmVyc2lvbiBvbiB0b3Agb2YgbGludXgtbmV4dCAob3Igc2ltcGx5IG15IHZpcnRpby1uZXh0
IGdpdCB0cmVlKSB0b2RheS4KClRoYW5rcywKUnVzdHkuCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
