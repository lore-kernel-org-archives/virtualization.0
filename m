From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v3 2/2] virtio_balloon: replace oom notifier with shrinker
Date: Mon, 6 Aug 2018 14:02:05 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739722502@SHSMSX101.ccr.corp.intel.com>
References: <1533285146-25212-1-git-send-email-wei.w.wang@intel.com>
	<1533285146-25212-3-git-send-email-wei.w.wang@intel.com>
	<16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
	<5B681B41.6070205@intel.com>
	<c8d25019-1990-f0dd-c83d-e4def5b5f7fe@i-love.sakura.ne.jp>
	<286AC319A985734F985F78AFA26841F7397222E8@SHSMSX101.ccr.corp.intel.com>
	<109ff5ec-692d-67fe-4c5a-2de8b48e8300@i-love.sakura.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <109ff5ec-692d-67fe-4c5a-2de8b48e8300@i-love.sakura.ne.jp>
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
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uZGF5LCBBdWd1c3QgNiwgMjAxOCA5OjI5IFBNLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMTgvMDgvMDYgMjE6NDQsIFdhbmcsIFdlaSBXIHdyb3RlOg0KPiA+IE9uIE1vbmRheSwg
QXVndXN0IDYsIDIwMTggNjoyOSBQTSwgVGV0c3VvIEhhbmRhIHdyb3RlOg0KPiA+PiBPbiAyMDE4
LzA4LzA2IDE4OjU2LCBXZWkgV2FuZyB3cm90ZToNCj4gPj4+IE9uIDA4LzAzLzIwMTggMDg6MTEg
UE0sIFRldHN1byBIYW5kYSB3cm90ZToNCj4gPj4+PiBPbiAyMDE4LzA4LzAzIDE3OjMyLCBXZWkg
V2FuZyB3cm90ZToNCj4gPj4+Pj4gK3N0YXRpYyBpbnQgdmlydGlvX2JhbGxvb25fcmVnaXN0ZXJf
c2hyaW5rZXIoc3RydWN0IHZpcnRpb19iYWxsb29uDQo+ID4+Pj4+ICsqdmIpIHsNCj4gPj4+Pj4g
K8KgwqDCoCB2Yi0+c2hyaW5rZXIuc2Nhbl9vYmplY3RzID0gdmlydGlvX2JhbGxvb25fc2hyaW5r
ZXJfc2NhbjsNCj4gPj4+Pj4gK8KgwqDCoCB2Yi0+c2hyaW5rZXIuY291bnRfb2JqZWN0cyA9IHZp
cnRpb19iYWxsb29uX3Nocmlua2VyX2NvdW50Ow0KPiA+Pj4+PiArwqDCoMKgIHZiLT5zaHJpbmtl
ci5iYXRjaCA9IDA7DQo+ID4+Pj4+ICvCoMKgwqAgdmItPnNocmlua2VyLnNlZWtzID0gREVGQVVM
VF9TRUVLUzsNCj4gPj4+PiBXaHkgZmxhZ3MgZmllbGQgaXMgbm90IHNldD8gSWYgdmIgaXMgYWxs
b2NhdGVkIGJ5DQo+ID4+Pj4ga21hbGxvYyhHRlBfS0VSTkVMKSBhbmQgaXMgbm93aGVyZSB6ZXJv
LWNsZWFyZWQsIEtBU0FOIHdvdWxkDQo+IGNvbXBsYWluIGl0Lg0KPiA+Pj4NCj4gPj4+IENvdWxk
IHlvdSBwb2ludCB3aGVyZSBpbiB0aGUgY29kZSB0aGF0IHdvdWxkIGNvbXBsYWluIGl0Pw0KPiA+
Pj4gSSBvbmx5IHNlZSB0d28gc2hyaW5rZXIgZmxhZ3MgKE5VTUFfQVdBUkUgYW5kIE1FTUNHX0FX
QVJFKSwgYW5kDQo+ID4+IHRoZXkgc2VlbSBub3QgcmVsYXRlZCB0byB0aGF0Lg0KPiA+Pg0KPiA+
PiBXaGVyZSBpcyB2Yi0+c2hyaW5rZXIuZmxhZ3MgaW5pdGlhbGl6ZWQ/DQo+ID4NCj4gPiBJcyB0
aGF0IG1hbmRhdG9yeSB0byBiZSBpbml0aWFsaXplZD8NCj4gDQo+IE9mIGNvdXJzZS4gOy0pDQo+
IA0KPiA+IEkgZmluZCBpdCdzIG5vdCBpbml0aWFsaXplZCBpbiBtb3N0IHNocmlua2VycyAoZS5n
LiB6c19yZWdpc3Rlcl9zaHJpbmtlciwNCj4gaHVnZV96ZXJvX3BhZ2Vfc2hyaW5rZXIpLg0KPiAN
Cj4gQmVjYXVzZSBtb3N0IHNocmlua2VycyBhcmUgInN0YXRpY2FsbHkgaW5pdGlhbGl6ZWQgKHdo
aWNoIG1lYW5zIHRoYXQNCj4gdW5zcGVjaWZpZWQgZmllbGRzIGFyZSBpbXBsaWNpdGx5IHplcm8t
Y2xlYXJlZCkiIG9yICJkeW5hbWljYWxseSBhbGxvY2F0ZWQgd2l0aA0KPiBfX0dGUF9aRVJPIG9y
IHplcm8tY2xlYXJlZCB1c2luZw0KPiBtZW1zZXQoKSAod2hpY2ggbWVhbnMgdGhhdCBhbGwgZmll
bGRzIGFyZSBvbmNlIHplcm8tY2xlYXJlZCkiLg0KPiANCj4gQW5kIGlmIHlvdSBvbmNlIHplcm8t
Y2xlYXIgdmIgYXQgYWxsb2NhdGlvbiB0aW1lLCB5b3Ugd2lsbCBnZXQgYSBib251cyB0aGF0DQo+
IGNhbGxpbmcgdW5yZWdpc3Rlcl9zaHJpbmtlcigpIHdpdGhvdXQgY29ycmVzcG9uZGluZyByZWdp
c3Rlcl9zaHJpbmtlcigpIGlzIHNhZmUNCj4gKHdoaWNoIHdpbGwgc2ltcGxpZnkgaW5pdGlhbGl6
YXRpb24gZmFpbHVyZSBwYXRoKS4NCg0KT2gsIEkgc2VlLCB0aGFua3MuIFNvIGl0IHNvdW5kcyBi
ZXR0ZXIgdG8gZGlyZWN0bHkga3phbGxvYyB2Yi4NCg0KQmVzdCwNCldlaQ0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
