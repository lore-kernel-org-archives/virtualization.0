From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net V2] vhost: correctly remove wait queue during poll
	failure
Date: Thu, 29 Mar 2018 16:01:44 +0800
Message-ID: <66bebbe2-25f3-5098-c6ac-f61fe160c940__44730.3362926052$1522310410$gmane$org@redhat.com>
References: <1522155052-13347-1-git-send-email-jasowang@redhat.com>
	<20180329071801-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180329071801-mutt-send-email-mst@kernel.org>
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
Cc: netdev@vger.kernel.org, Darren Kenny <darren.kenny@oracle.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDPmnIgyOeaXpSAxMjoyMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IE9uIFR1ZSwgTWFyIDI3LCAyMDE4IGF0IDA4OjUwOjUyUE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+IFdlIHRyaWVkIHRvIHJlbW92ZSB2cSBwb2xsIGZyb20gd2FpdCBxdWV1ZSwgYnV0IGRv
IG5vdCBjaGVjayB3aGV0aGVyCj4+IG9yIG5vdCBpdCB3YXMgaW4gYSBsaXN0IGJlZm9yZS4gVGhp
cyB3aWxsIGxlYWQgZG91YmxlIGZyZWUuIEZpeGluZwo+PiB0aGlzIGJ5IHN3aXRjaGluZyB0byB1
c2Ugdmhvc3RfcG9sbF9zdG9wKCkgd2hpY2ggemVyb3MgcG9sbC0+d3FoIGFmdGVyCj4+IHJlbW92
aW5nIHBvbGwgZnJvbSB3YWl0cXVldWUgdG8gbWFrZSBzdXJlIGl0IHdvbid0IGJlIGZyZWVkIHR3
aWNlLgo+Pgo+PiBDYzogRGFycmVuIEtlbm55PGRhcnJlbi5rZW5ueUBvcmFjbGUuY29tPgo+PiBS
ZXBvcnRlZC1ieTpzeXpib3QrYzAyNzI5NzJiMDFiODcyZTYwNGFAc3l6a2FsbGVyLmFwcHNwb3Rt
YWlsLmNvbQo+PiBGaXhlczogMmI4YjMyOGI2MWM3OSAoInZob3N0X25ldDogaGFuZGxlIHBvbGxp
bmcgZXJyb3JzIHdoZW4gc2V0dGluZyBiYWNrZW5kIikKPj4gU2lnbmVkLW9mZi1ieTogSmFzb24g
V2FuZzxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IE9LIHdpdGggdGhpcyB0aGUgb25seSBidWcgd2Ug
aGF2ZSBpcyB3aGVyZSBnZXQgdXNlciBwYWdlcyByZXR1cm5zIDAKPiAoUmVwb3J0ZWQtYnk6c3l6
Ym90KzYzMDRiZjk3ZWY0MzY1ODBmZWRlQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20pCj4KPgo+
CgpUaGFua3MgZm9yIHRoZSByZW1pbmRlci4KCkkgcG9zdCBhIHBhdGNoIHRvIGF2b2lkIHRoaXMu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
