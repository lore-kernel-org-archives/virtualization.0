From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH V2 06/18] Tools: hv: Further refactor
 kvp_get_ip_address()
Date: Tue, 14 Aug 2012 03:01:25 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF9236BF8F8@SN2PRD0310MB382.namprd03.prod.outlook.com>
References: <1344877584-21738-1-git-send-email-kys@microsoft.com>
	 <1344877627-21779-1-git-send-email-kys@microsoft.com>
	 <1344877627-21779-6-git-send-email-kys@microsoft.com>
 <1344908771.824.156.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344908771.824.156.camel@deadeye.wl.decadent.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>
List-Id: virtualization@lists.linuxfoundation.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuIEh1dGNoaW5ncyBb
bWFpbHRvOmJlbkBkZWNhZGVudC5vcmcudWtdDQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDEzLCAy
MDEyIDk6NDYgUE0NCj4gVG86IEtZIFNyaW5pdmFzYW4NCj4gQ2M6IGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZlbEBsaW51eGRy
aXZlcnByb2plY3Qub3JnOyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5vc2RsLm9yZzsgb2xhZkBhZXBm
bGUuZGU7DQo+IGFwd0BjYW5vbmljYWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMDYv
MThdIFRvb2xzOiBodjogRnVydGhlciByZWZhY3RvciBrdnBfZ2V0X2lwX2FkZHJlc3MoKQ0KPiAN
Cj4gT24gTW9uLCAyMDEyLTA4LTEzIGF0IDEwOjA2IC0wNzAwLCBLLiBZLiBTcmluaXZhc2FuIHdy
b3RlOg0KPiA+IEluIHByZXBhcmF0aW9uIGZvciBtYWtpbmcga3ZwX2dldF9pcF9hZGRyZXNzKCkg
bW9yZSBnZW5lcmljLCBmYWN0b3Igb3V0DQo+ID4gdGhlIGNvZGUgZm9yIGhhbmRsaW5nIElQIGFk
ZHJlc3Nlcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEsuIFkuIFNyaW5pdmFzYW4gPGt5c0Bt
aWNyb3NvZnQuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBt
aWNyb3NvZnQuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBPbGFmIEhlcmluZyA8b2xhZkBhZXBmbGUu
ZGU+DQo+ID4gUmV2aWV3ZWQtYnk6IEJlbiBIdXRjaGluZ3MgPGJlbkBkZWNhZGVudC5vcmcudWs+
DQo+IA0KPiBJIGxvb2tlZCBhdCB5b3VyIGxhc3QgcGF0Y2ggc2V0LCBzbyBpbiBhIHNlbnNlIHRo
ZXNlIGhhdmUgYmVlbiByZXZpZXdlZA0KPiBieSBtZS4gIEJ1dCB0aGUgJ1Jldmlld2VkLWJ5JyBs
aW5lIGluIGEgY29tbWl0IG1lc3NhZ2UgbWVhbnMgdGhlDQo+IHJldmlld2VyIHRoaW5rcyBpdCdz
IE9LOyB0aGUgcmV2aWV3ZXIgbXVzdCBzYXkgdGhhdCwgYW5kIEkgZGlkbid0Lg0KDQpNeSBtaXN0
YWtlLCBzb3JyeSBhYm91dCB0aGF0Lg0KDQpSZWdhcmRzLA0KDQpLLiBZDQo=
