From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-net: parameterize min ring num_free for virtio
	receive
Date: Thu, 18 Jul 2019 10:42:47 -0400
Message-ID: <20190718103641-mutt-send-email-mst__25401.3616054848$1563461008$gmane$org@kernel.org>
References: <BYAPR14MB32056583C4963342F5D817C4A6C80@BYAPR14MB3205.namprd14.prod.outlook.com>
	<20190718085836-mutt-send-email-mst@kernel.org>
	<bdd30ef5-4f69-8218-eed0-38c6daac42db@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <bdd30ef5-4f69-8218-eed0-38c6daac42db@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>, "songliubraving@fb.com" <songliubraving@fb.com>, "kafai@fb.com" <kafai@fb.com>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "hawk@kernel.org" <hawk@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "jiangran.jr@alibaba-inc.com" <jiangran.jr@alibaba-inc.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "ast@kernel.org" <ast@kernel.org>, ? jiang <jiangkidd@hotmail.com>, "yhs@fb.com" <yhs@fb.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBKdWwgMTgsIDIwMTkgYXQgMTA6MDE6MDVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDE5LzcvMTgg5LiL5Y2IOTowNCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gVGh1LCBKdWwgMTgsIDIwMTkgYXQgMTI6NTU6NTBQTSArMDAwMCwgPyBqaWFuZyB3
cm90ZToKPiA+ID4gVGhpcyBjaGFuZ2UgbWFrZXMgcmluZyBidWZmZXIgcmVjbGFpbSB0aHJlc2hv
bGQgbnVtX2ZyZWUgY29uZmlndXJhYmxlCj4gPiA+IGZvciBiZXR0ZXIgcGVyZm9ybWFuY2UsIHdo
aWxlIGl0J3MgaGFyZCBjb2RlZCBhcyAxLzIgKiBxdWV1ZSBub3cuCj4gPiA+IEFjY29yZGluZyB0
byBvdXIgdGVzdCB3aXRoIHFlbXUgKyBkcGRrLCBwYWNrZXQgZHJvcHBpbmcgaGFwcGVucyB3aGVu
Cj4gPiA+IHRoZSBndWVzdCBpcyBub3QgYWJsZSB0byBwcm92aWRlIGZyZWUgYnVmZmVyIGluIGF2
YWlsIHJpbmcgdGltZWx5Lgo+ID4gPiBTbWFsbGVyIHZhbHVlIG9mIG51bV9mcmVlIGRvZXMgZGVj
cmVhc2UgdGhlIG51bWJlciBvZiBwYWNrZXQgZHJvcHBpbmcKPiA+ID4gZHVyaW5nIG91ciB0ZXN0
IGFzIGl0IG1ha2VzIHZpcnRpb19uZXQgcmVjbGFpbSBidWZmZXIgZWFybGllci4KPiA+ID4gCj4g
PiA+IEF0IGxlYXN0LCB3ZSBzaG91bGQgbGVhdmUgdGhlIHZhbHVlIGNoYW5nZWFibGUgdG8gdXNl
ciB3aGlsZSB0aGUKPiA+ID4gZGVmYXVsdCB2YWx1ZSBhcyAxLzIgKiBxdWV1ZSBpcyBrZXB0Lgo+
ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogamlhbmdraWRkPGppYW5na2lkZEBob3RtYWlsLmNv
bT4KPiA+IFRoYXQgd291bGQgYmUgb25lIHJlYXNvbiwgYnV0IEkgc3VzcGVjdCBpdCdzIG5vdCB0
aGUKPiA+IHRydWUgb25lLiBJZiB5b3UgbmVlZCBtb3JlIGJ1ZmZlciBkdWUgdG8gaml0dGVyCj4g
PiB0aGVuIGp1c3QgaW5jcmVhc2UgdGhlIHF1ZXVlIHNpemUuIFdvdWxkIGJlIGNsZWFuZXIuCj4g
PiAKPiA+IAo+ID4gSG93ZXZlciBhcmUgeW91IHN1cmUgdGhpcyBpcyB0aGUgcmVhc29uIGZvcgo+
ID4gcGFja2V0IGRyb3BzPyBEbyB5b3Ugc2VlIHRoZW0gZHJvcHBlZCBieSBkcGRrCj4gPiBkdWUg
dG8gbGFjayBvZiBzcGFjZSBpbiB0aGUgcmluZz8gQXMgb3Bwb3NlZCB0bwo+ID4gYnkgZ3Vlc3Q/
Cj4gPiAKPiA+IAo+IAo+IEJlc2lkZXMgdGhvc2UsIHRoaXMgcGF0Y2ggZGVwZW5kcyBvbiB0aGUg
dXNlciB0byBjaG9vc2UgYSBzdWl0YWJsZSB0aHJlc2hvbGQKPiB3aGljaCBpcyBub3QgZ29vZC4g
WW91IG5lZWQgZWl0aGVyIGEgZ29vZCB2YWx1ZSB3aXRoIGRlbW9uc3RyYXRlZCBudW1iZXJzIG9y
Cj4gc29tZXRoaW5nIHNtYXJ0ZXIuCj4gCj4gVGhhbmtzCgpJIGRvIGhvd2V2ZXIgdGhpbmsgdGhh
dCB3ZSBoYXZlIGEgcHJvYmxlbSByaWdodCBub3c6IHRyeV9maWxsX3JlY3YgY2FuCnRha2UgdXAg
YSBsb25nIHRpbWUgZHVyaW5nIHdoaWNoIG5ldCBzdGFjayBkb2VzIG5vdCBydW4gYXQgYWxsLiBJ
bWFnaW5lCmEgMUsgcXVldWUgLSB3ZSBhcmUgdGFsa2luZyA1MTIgcGFja2V0cy4gVGhhdCdzIGV4
Y2Vlc3NpdmUuICBuYXBpIHBvbGwKd2VpZ2h0IHNvbHZlcyBhIHNpbWlsYXIgcHJvYmxlbSwgc28g
aXQgbWlnaHQgbWFrZSBzZW5zZSB0byBjYXAgdGhpcyBhdApuYXBpX3BvbGxfd2VpZ2h0LgoKV2hp
Y2ggd2lsbCBhbGxvdyB0d2Vha2luZyBpdCB0aHJvdWdoIGEgbW9kdWxlIHBhcmFtZXRlciBhcyBh
CnNpZGUgZWZmZWN0IDopIE1heWJlIGp1c3QgZG8gTkFQSV9QT0xMX1dFSUdIVC4KCk5lZWQgdG8g
YmUgY2FyZWZ1bCB0aG91Z2g6IHF1ZXVlcyBjYW4gYWxzbyBiZSBzbWFsbCBhbmQgSSBkb24ndCB0
aGluayB3ZQp3YW50IHRvIGV4Y2VlZCBxdWV1ZSBzaXplIC8gMiwgb3IgbWF5YmUgcXVldWUgc2l6
ZSAtIG5hcGlfcG9sbF93ZWlnaHQuCkRlZmluaXRlbHkgbXVzdCBub3QgZXhjZWVkIHRoZSBmdWxs
IHF1ZXVlIHNpemUuCgotLSAKTVNUCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
