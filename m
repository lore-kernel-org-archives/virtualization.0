From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 0/2] Revert and rework on the metadata accelreation
Date: Sat, 7 Sep 2019 15:03:32 +0000
Message-ID: <20190907150330.GC2940@mellanox.com>
References: <20190905122736.19768-1-jasowang@redhat.com>
	<20190905135907.GB6011@mellanox.com>
	<7785d39b-b4e7-8165-516c-ee6a08ac9c4e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7785d39b-b4e7-8165-516c-ee6a08ac9c4e@redhat.com>
Content-Language: en-US
Content-ID: <1C5F76DC2A6AD84FA5F277E8F3D586C0@eurprd05.prod.outlook.com>
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
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "jglisse@redhat.com" <jglisse@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCBTZXAgMDYsIDIwMTkgYXQgMDY6MDI6MzVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToNCj4gDQo+IE9uIDIwMTkvOS81IOS4i+WNiDk6NTksIEphc29uIEd1bnRob3JwZSB3cm90ZToN
Cj4gPiBPbiBUaHUsIFNlcCAwNSwgMjAxOSBhdCAwODoyNzozNFBNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOg0KPiA+ID4gSGk6DQo+ID4gPiANCj4gPiA+IFBlciByZXF1ZXN0IGZyb20gTWljaGFl
bCBhbmQgSmFzb24sIHRoZSBtZXRhZGF0YSBhY2NlbHJlYXRpb24gaXMNCj4gPiA+IHJldmVydGVk
IGluIHRoaXMgdmVyc2lvbiBhbmQgcmV3b3JrIGluIG5leHQgdmVyc2lvbi4NCj4gPiA+IA0KPiA+
ID4gUGxlYXNlIHJldmlldy4NCj4gPiA+IA0KPiA+ID4gVGhhbmtzDQo+ID4gPiANCj4gPiA+IEph
c29uIFdhbmcgKDIpOg0KPiA+ID4gICAgUmV2ZXJ0ICJ2aG9zdDogYWNjZXNzIHZxIG1ldGFkYXRh
IHRocm91Z2gga2VybmVsIHZpcnR1YWwgYWRkcmVzcyINCj4gPiA+ICAgIHZob3N0OiByZS1pbnRy
b2R1Y2luZyBtZXRhZGF0YSBhY2NlbGVyYXRpb24gdGhyb3VnaCBrZXJuZWwgdmlydHVhbA0KPiA+
ID4gICAgICBhZGRyZXNzDQo+ID4gVGhlcmUgYXJlIGEgYnVuY2ggb2YgcGF0Y2hlcyBpbiB0aGUg
cXVldWUgYWxyZWFkeSB0aGF0IHdpbGwgaGVscA0KPiA+IHZob3N0LCBhbmQgSSBhIHdvcmtpbmcg
b24gb25lIGZvciBuZXh0IGN5Y2xlIHRoYXQgd2lsbCBoZWxwIGFsb3QgbW9yZQ0KPiA+IHRvby4N
Cj4gDQo+IA0KPiBJIHdpbGwgY2hlY2sgdGhvc2UgcGF0Y2hlcywgYnV0IGlmIHlvdSBjYW4gZ2l2
ZSBtZSBzb21lIHBvaW50ZXJzIG9yIGtleXdvcmRzDQo+IGl0IHdvdWxkIGJlIG11Y2ggYXBwcmVj
aWF0ZWQuDQoNCllvdSBjYW4gbG9vayBoZXJlOg0KDQpodHRwczovL2dpdGh1Yi5jb20vamd1bnRo
b3JwZS9saW51eC9jb21taXRzL21tdV9ub3RpZmllcg0KDQpUaGUgZmlyc3QgcGFydHMsIHRoZSBn
ZXQvcHV0IGFyZSBpbiB0aGUgaG1tIHRyZWUsIGFuZCB0aGUgbGFzdCBwYXJ0LA0KdGhlIGludGVy
dmFsIHRyZWUgaW4gdGhlIGxhc3QgY29tbWl0IGlzIHN0aWxsIGEgV0lQLCBidXQgaXQgd291bGQN
CnJlbW92ZSBhbG90IG9mIHRoYXQgY29kZSBmcm9tIHZob3N0IGFzIHdlbGwuDQoNCkphc29uDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
