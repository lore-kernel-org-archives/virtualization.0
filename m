From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Subject: Re: [PATCH v3 1/2] PCI: vmd: Filter resource type bits from shadow
 register
Date: Fri, 12 Jun 2020 15:11:15 +0000
Message-ID: <8466e3ff386547a3bbaf578c3099dd12d545a7f8.camel@intel.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
         <20200528030240.16024-3-jonathan.derrick@intel.com>
         <20200529103315.GC12270@e121166-lin.cambridge.arm.com>
         <163e8cb37ece0c8daa6d6e5fd7fcae47ba4fa437.camel@intel.com>
         <20200529161824.GA17642@e121166-lin.cambridge.arm.com>
         <f1d36b8fc4ab7aacf6efca19303b04a5b4f8189c.camel@intel.com>
         <20200612135443.GA25653@e121166-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20200612135443.GA25653@e121166-lin.cambridge.arm.com>
Content-Language: en-US
Content-ID: <D2235C0C9FC0184E9366125CF83DC4A3@intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>
Cc: "hch@lst.de" <hch@lst.de>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "helgaas@kernel.org" <helgaas@kernel.org>, "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCAyMDIwLTA2LTEyIGF0IDE0OjU0ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVGh1LCBKdW4gMTEsIDIwMjAgYXQgMDk6MTY6NDhQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiA+ID4gPiBIaSBKb24sDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gaXQgbG9va3MgbGlrZSBJIGNhbiB0YWtlIHRoaXMgcGF0Y2ggZm9y
IHY1Ljggd2hlcmVhcyBwYXRjaCAyIGRlcGVuZHMNCj4gPiA+ID4gPiBvbiB0aGUgUUVNVSBjaGFu
Z2VzIGFjY2VwdGFuY2UgYW5kIHNob3VsZCBwcm9iYWJseSB3YWl0Lg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IFBsZWFzZSBsZXQgbWUga25vdyB5b3VyIHRob3VnaHRzIGFzYXAgYW5kIEkgd2lsbCB0
cnkgdG8gYXQgbGVhc3QNCj4gPiA+ID4gPiBzcXVlZXplIHRoaXMgcGF0Y2ggaW4uDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gTG9yZW56bw0KPiA+ID4gPiANCj4gPiA+ID4gSGkgTG9yZW56bywNCj4g
PiA+ID4gDQo+ID4gPiA+IFRoaXMgaXMgZmluZS4gUGxlYXNlIHRha2UgUGF0Y2ggMS4NCj4gPiA+
ID4gUGF0Y2ggMiBpcyBoYXJtbGVzcyB3aXRob3V0IHRoZSBRRU1VIGNoYW5nZXMsIGJ1dCBtYXkg
YWx3YXlzIG5lZWQgYQ0KPiA+ID4gPiBkaWZmZXJlbnQgYXBwcm9hY2guDQo+ID4gPiANCj4gPiA+
IFB1bGxlZCBwYXRjaCAxIGludG8gcGNpL3ZtZCwgdGhhbmtzLg0KPiA+ID4gDQo+ID4gPiBMb3Jl
bnpvDQo+ID4gDQo+ID4gSGkgTG9yZW56bywNCj4gPiANCj4gPiBBbGV4IGhhcyBwci1lZCB0aGUg
UUVNVSBwYXRjaCBbMV0NCj4gPiBJcyBpdCB0b28gbGF0ZSB0byBwdWxsIHBhdGNoIDIvMiBmb3Ig
djUuOD8NCj4gDQo+IEkgdGhpbmsgaXQgaXMgLSBJIGRvbid0IGtub3cgaWYgQmpvcm4gcGxhbm5l
ZCBhIHNlY29uZCBQUiBmb3IgdGhpcw0KPiBtZXJnZSB3aW5kb3csIGlmIG5vdCBpdCBpcyB2NS45
IG1hdGVyaWFsIEkgYW0gYWZyYWlkLg0KPiANCj4gVGhhbmtzLA0KPiBMb3JlbnpvDQo+IA0KPiA+
IFsxXSANCj4gPiBodHRwczovL2dpdGh1Yi5jb20vYXdpbGxpYW0vcWVtdS12ZmlvL3JlbGVhc2Vz
L3RhZy92ZmlvLXVwZGF0ZS0yMDIwMDYxMS4wDQoNCk5vIHByb2JsZW0NCkpvbg0K
