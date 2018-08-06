From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v3 2/2] virtio_balloon: replace oom notifier with shrinker
Date: Mon, 6 Aug 2018 12:44:42 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7397222E8__38749.9176235453$1533559444$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <1533285146-25212-1-git-send-email-wei.w.wang@intel.com>
	<1533285146-25212-3-git-send-email-wei.w.wang@intel.com>
	<16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
	<5B681B41.6070205@intel.com>
	<c8d25019-1990-f0dd-c83d-e4def5b5f7fe@i-love.sakura.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c8d25019-1990-f0dd-c83d-e4def5b5f7fe@i-love.sakura.ne.jp>
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

T24gTW9uZGF5LCBBdWd1c3QgNiwgMjAxOCA2OjI5IFBNLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMTgvMDgvMDYgMTg6NTYsIFdlaSBXYW5nIHdyb3RlOg0KPiA+IE9uIDA4LzAzLzIwMTgg
MDg6MTEgUE0sIFRldHN1byBIYW5kYSB3cm90ZToNCj4gPj4gT24gMjAxOC8wOC8wMyAxNzozMiwg
V2VpIFdhbmcgd3JvdGU6DQo+ID4+PiArc3RhdGljIGludCB2aXJ0aW9fYmFsbG9vbl9yZWdpc3Rl
cl9zaHJpbmtlcihzdHJ1Y3QgdmlydGlvX2JhbGxvb24NCj4gPj4+ICsqdmIpIHsNCj4gPj4+ICvC
oMKgwqAgdmItPnNocmlua2VyLnNjYW5fb2JqZWN0cyA9IHZpcnRpb19iYWxsb29uX3Nocmlua2Vy
X3NjYW47DQo+ID4+PiArwqDCoMKgIHZiLT5zaHJpbmtlci5jb3VudF9vYmplY3RzID0gdmlydGlv
X2JhbGxvb25fc2hyaW5rZXJfY291bnQ7DQo+ID4+PiArwqDCoMKgIHZiLT5zaHJpbmtlci5iYXRj
aCA9IDA7DQo+ID4+PiArwqDCoMKgIHZiLT5zaHJpbmtlci5zZWVrcyA9IERFRkFVTFRfU0VFS1M7
DQo+ID4+IFdoeSBmbGFncyBmaWVsZCBpcyBub3Qgc2V0PyBJZiB2YiBpcyBhbGxvY2F0ZWQgYnkg
a21hbGxvYyhHRlBfS0VSTkVMKQ0KPiA+PiBhbmQgaXMgbm93aGVyZSB6ZXJvLWNsZWFyZWQsIEtB
U0FOIHdvdWxkIGNvbXBsYWluIGl0Lg0KPiA+DQo+ID4gQ291bGQgeW91IHBvaW50IHdoZXJlIGlu
IHRoZSBjb2RlIHRoYXQgd291bGQgY29tcGxhaW4gaXQ/DQo+ID4gSSBvbmx5IHNlZSB0d28gc2hy
aW5rZXIgZmxhZ3MgKE5VTUFfQVdBUkUgYW5kIE1FTUNHX0FXQVJFKSwgYW5kDQo+IHRoZXkgc2Vl
bSBub3QgcmVsYXRlZCB0byB0aGF0Lg0KPiANCj4gV2hlcmUgaXMgdmItPnNocmlua2VyLmZsYWdz
IGluaXRpYWxpemVkPw0KDQpJcyB0aGF0IG1hbmRhdG9yeSB0byBiZSBpbml0aWFsaXplZD8gSSBm
aW5kIGl0J3Mgbm90IGluaXRpYWxpemVkIGluIG1vc3Qgc2hyaW5rZXJzIChlLmcuIHpzX3JlZ2lz
dGVyX3Nocmlua2VyLCBodWdlX3plcm9fcGFnZV9zaHJpbmtlcikuDQoNCkJlc3QsDQpXZWkNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
