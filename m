From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Tue, 12 Mar 2019 15:15:22 +0800
Message-ID: <3b00dc4a-b1b7-aa3f-c4ba-515138e4d6dd__11484.771785193$1552374941$gmane$org@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-6-git-send-email-jasowang@redhat.com>
	<20190307103503-mutt-send-email-mst@kernel.org>
	<20190307124700-mutt-send-email-mst@kernel.org>
	<20190307191622.GP23850@redhat.com>
	<e2fad6ed-9257-b53c-394b-bc913fc444c0@redhat.com>
	<20190308194845.GC26923@redhat.com>
	<8b68a2a0-907a-15f5-a07f-fc5b53d7ea19@redhat.com>
	<20190311084525-mutt-send-email-mst@kernel.org>
	<ff45ea43-1145-5ea6-767c-1a99d55a9c61@redhat.com>
	<20190311234956-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190311234956-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMy8xMiDkuIrljYgxMTo1MCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+
IFVzaW5nIGRpcmVjdCBtYXBwaW5nIChJCj4+Pj4gZ3Vlc3Mga2VybmVsIHdpbGwgYWx3YXlzIHRy
eSBodWdlcGFnZSBmb3IgdGhhdD8pIHNob3VsZCBiZSBiZXR0ZXIgYW5kIHdlIGNhbgo+Pj4+IGV2
ZW4gdXNlIGl0IGZvciB0aGUgZGF0YSB0cmFuc2ZlciBub3Qgb25seSBmb3IgdGhlIG1ldGFkYXRh
Lgo+Pj4+Cj4+Pj4gVGhhbmtzCj4+PiBXZSBjYW4ndCByZWFsbHkuIFRoZSBiaWcgaXNzdWUgaXMg
Z2V0IHVzZXIgcGFnZXMuIERvaW5nIHRoYXQgb24gZGF0YQo+Pj4gcGF0aCB3aWxsIGJlIHNsb3dl
ciB0aGFuIGNvcHlYdXNlci4KPj4gSSBtZWFudCBpZiB3ZSBjYW4gZmluZCBhIHdheSB0byBhdm9p
ZCBkb2luZyBndXAgaW4gZGF0YXBhdGguIEUuZyB2aG9zdAo+PiBtYWludGFpbiBhIHJhbmdlIHRy
ZWUgYW5kIGFkZCBvciByZW1vdmUgcmFuZ2VzIHRocm91Z2ggTU1VIG5vdGlmaWVyLiBUaGVuIGlu
Cj4+IGRhdGFwYXRoLCBpZiB3ZSBmaW5kIHRoZSByYW5nZSwgdGhlbiB1c2UgZGlyZWN0IG1hcHBp
bmcgb3RoZXJ3aXNlCj4+IGNvcHlfdG9fdXNlcigpLgo+Pgo+PiBUaGFua3MKPiBXZSBjYW4gdHJ5
LiBCdXQgSSdtIG5vdCBzdXJlIHRoZXJlJ3MgYW55IHJlYXNvbiB0byB0aGluayB0aGVyZSdzIGFu
eQo+IGxvY2FsaXR5IHRoZXJlLgo+CgpPaywgYnV0IHdoYXQga2luZCBvZiBsb2NhbGl0eSBkbyB5
b3UgbWVhbiBoZXJlPwoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
