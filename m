From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-spec: flexible configuration layout
Date: Wed, 9 Nov 2011 12:49:17 +0200
Message-ID: <20111109104916.GA22194@redhat.com>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com>
	<1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com>
	<8739e7uy87.fsf@rustcorp.com.au>
	<20111102233110.GA20289@redhat.com>
	<20111108214021.GA4538@redhat.com>
	<1320828366.31056.16.camel@lappy>
	<20111109101318.GB20612@redhat.com>
	<1320834368.31056.31.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1320834368.31056.31.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, penberg@cs.helsinki.fi, avi@redhat.com, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gV2VkLCBOb3YgMDksIDIwMTEgYXQgMTI6MjY6MDhQTSArMDIwMCwgU2FzaGEgTGV2aW4gd3Jv
dGU6Cj4gT24gV2VkLCAyMDExLTExLTA5IGF0IDEyOjEzICswMjAwLCBNaWNoYWVsIFMuIFRzaXJr
aW4gd3JvdGU6Cj4gPiBPbiBXZWQsIE5vdiAwOSwgMjAxMSBhdCAxMDo0NjowNkFNICswMjAwLCBT
YXNoYSBMZXZpbiB3cm90ZToKPiA+ID4gVGhlIGRldmljZSBpbml0aWFsaXphdGlvbiBzZXF1ZW5j
ZSBtaWdodCB1c2UgYW4gdXBkYXRlIGFzIHdlbGwuCj4gPiAKPiA+IFdoYXQgaXMgbmVlZGVkPyBB
ZGQgYW4gaXRlbSB3aGVyZSB0aGUgZHJpdmVyIHNjYW5zIHRoZSBQQ0kgY2FwYWJpbGl0eQo+ID4g
bGlzdCB0byBkZXRlY3QgdGhlIGxheW91dD8KPiAKPiBZdXAsIHNvbWV0aGluZyBzaW1pbGFyIGxp
a2UgdGhhdCAtIGp1c3QgdG8gbWFrZSBpdCBvYnZpb3VzLgo+IAo+ID4gPiBNYXliZQo+ID4gPiBh
bHNvIGEgZGVzY3JpcHRpb24gb2YgaG93IGRldmljZSBoYW5kbGVzIG1pc3Npbmcgc3RydWN0dXJl
IElEcy4KPiA+ID4gCj4gPiA+IFtzbmlwXQo+ID4gCj4gPiBIbW0uIEkganVzdCBoYXZlCj4gPiAn
RHJpdmVycyBzaG91bGQgZmFsbCBiYWNrIG9uIHRoaXMgbGVnYWN5IHN0cnVjdHVyZSBpZiBhCj4g
PiAgVmlydGlvIFN0cnVjdHVyZSBjYXBhYmlsaXR5IGlzIG1pc3NpbmcgaW4gdGhlIFBDSSBjYXBh
YmlsaXR5Cj4gPiAgbGlzdCcuIAo+ID4gCj4gPiBXaGF0IGVsc2Ugd291bGQgYmUgaGVscGZ1bD8g
QW4gZXhhbXBsZT8gCj4gCj4gSSBqdXN0IHJlbWVtYmVyZWQgZnJvbSB5b3VyIHBhdGNoIHRoYXQg
eW91IGNvdWxkIGRlZmluZSBzb21lIHN0cnVjdHVyZQo+IElEcywgYnV0IG5vdCBuZWNlc3Nhcmls
eSBhbGwgb2YgdGhlbSwgaWYgaXQncyBub3QgbG9uZ2VyIHRoZSBjYXNlIHRoZW4KPiBpZ25vcmUg
bWUuIElmIGl0IGlzLCB0aGVuIHRoZSBzY2VuYXJpbyBvZiBhIG1pc3Npbmcgc3RydWN0dXJlIHNo
b3VsZCBiZQo+IHNwZWNpZmllZCAoRm9yIGV4YW1wbGUsIGlmIHRoZSBJU1Igc3RydWN0dXJlIHdh
c24ndCBkZWZpbmVkLCBmYWxsIGJhY2sKPiB0by4uLikuCgpZZXMsIHRoaXMgd2FzIHRoZSBpbnRl
bnQgb2YgdGhlIHRleHQgYWJvdmUuIEknbGwgbWFrZSB0aGF0IGV4cGxpY2l0LgoKPiA+ID4gSSdt
IG5vdCBzdXJlIHdoYXQgY2FwYWJpbGl0eSBsZW5ndGggaXMsIGNhbid0IGZpbmQgaXQgaW4gdGhl
IHNwZWMKPiA+ID4gZWl0aGVyLgo+ID4gPiAKPiA+ID4gW3NuaXBdCj4gPiAKPiA+IEl0J3MgdGhl
IGxlZ3RoIG9mIHRoZSB2ZW5kb3Igc3BlY2lmaWMgY2FwYWJpbGl0eSBzdHJ1Y3R1cmUgaW4gYnl0
ZXMuCj4gPiAndGhlIGJ5dGUgaW1tZWRpYXRlbHkgZm9sbG93aW5nIHRoZSDigJxOZXh04oCdCj4g
PiAgcG9pbnRlciBpbiB0aGUgY2FwYWJpbGl0eSBzdHJ1Y3R1cmUgaXMgZGVmaW5lZCB0byBiZSBh
IGxlbmd0aCBmaWVsZCcKPiA+IEl0J3Mgb24gcGFnZSAzMzAgaW4gbXkgY29weS4KPiAKPiBSaWdo
dCwgSSB3YXMgbG9va2luZyBvbmx5IGF0IHRoZSByZWd1bGFyIGNhcCBkZWZpbml0aW9uLgo+IAo+
IC0tIAo+IAo+IFNhc2hhLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
