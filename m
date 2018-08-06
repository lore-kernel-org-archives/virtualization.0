From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v3 2/2] virtio_balloon: replace oom notifier with shrinker
Date: Mon, 6 Aug 2018 22:28:59 +0900
Message-ID: <109ff5ec-692d-67fe-4c5a-2de8b48e8300__26960.6545604349$1533562034$gmane$org@i-love.sakura.ne.jp>
References: <1533285146-25212-1-git-send-email-wei.w.wang@intel.com>
	<1533285146-25212-3-git-send-email-wei.w.wang@intel.com>
	<16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
	<5B681B41.6070205@intel.com>
	<c8d25019-1990-f0dd-c83d-e4def5b5f7fe@i-love.sakura.ne.jp>
	<286AC319A985734F985F78AFA26841F7397222E8@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <286AC319A985734F985F78AFA26841F7397222E8@SHSMSX101.ccr.corp.intel.com>
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
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

T24gMjAxOC8wOC8wNiAyMTo0NCwgV2FuZywgV2VpIFcgd3JvdGU6Cj4gT24gTW9uZGF5LCBBdWd1
c3QgNiwgMjAxOCA2OjI5IFBNLCBUZXRzdW8gSGFuZGEgd3JvdGU6Cj4+IE9uIDIwMTgvMDgvMDYg
MTg6NTYsIFdlaSBXYW5nIHdyb3RlOgo+Pj4gT24gMDgvMDMvMjAxOCAwODoxMSBQTSwgVGV0c3Vv
IEhhbmRhIHdyb3RlOgo+Pj4+IE9uIDIwMTgvMDgvMDMgMTc6MzIsIFdlaSBXYW5nIHdyb3RlOgo+
Pj4+PiArc3RhdGljIGludCB2aXJ0aW9fYmFsbG9vbl9yZWdpc3Rlcl9zaHJpbmtlcihzdHJ1Y3Qg
dmlydGlvX2JhbGxvb24KPj4+Pj4gKyp2Yikgewo+Pj4+PiArwqDCoMKgIHZiLT5zaHJpbmtlci5z
Y2FuX29iamVjdHMgPSB2aXJ0aW9fYmFsbG9vbl9zaHJpbmtlcl9zY2FuOwo+Pj4+PiArwqDCoMKg
IHZiLT5zaHJpbmtlci5jb3VudF9vYmplY3RzID0gdmlydGlvX2JhbGxvb25fc2hyaW5rZXJfY291
bnQ7Cj4+Pj4+ICvCoMKgwqAgdmItPnNocmlua2VyLmJhdGNoID0gMDsKPj4+Pj4gK8KgwqDCoCB2
Yi0+c2hyaW5rZXIuc2Vla3MgPSBERUZBVUxUX1NFRUtTOwo+Pj4+IFdoeSBmbGFncyBmaWVsZCBp
cyBub3Qgc2V0PyBJZiB2YiBpcyBhbGxvY2F0ZWQgYnkga21hbGxvYyhHRlBfS0VSTkVMKQo+Pj4+
IGFuZCBpcyBub3doZXJlIHplcm8tY2xlYXJlZCwgS0FTQU4gd291bGQgY29tcGxhaW4gaXQuCj4+
Pgo+Pj4gQ291bGQgeW91IHBvaW50IHdoZXJlIGluIHRoZSBjb2RlIHRoYXQgd291bGQgY29tcGxh
aW4gaXQ/Cj4+PiBJIG9ubHkgc2VlIHR3byBzaHJpbmtlciBmbGFncyAoTlVNQV9BV0FSRSBhbmQg
TUVNQ0dfQVdBUkUpLCBhbmQKPj4gdGhleSBzZWVtIG5vdCByZWxhdGVkIHRvIHRoYXQuCj4+Cj4+
IFdoZXJlIGlzIHZiLT5zaHJpbmtlci5mbGFncyBpbml0aWFsaXplZD8KPiAKPiBJcyB0aGF0IG1h
bmRhdG9yeSB0byBiZSBpbml0aWFsaXplZD8KCk9mIGNvdXJzZS4gOy0pCgo+IEkgZmluZCBpdCdz
IG5vdCBpbml0aWFsaXplZCBpbiBtb3N0IHNocmlua2VycyAoZS5nLiB6c19yZWdpc3Rlcl9zaHJp
bmtlciwgaHVnZV96ZXJvX3BhZ2Vfc2hyaW5rZXIpLgoKQmVjYXVzZSBtb3N0IHNocmlua2VycyBh
cmUgInN0YXRpY2FsbHkgaW5pdGlhbGl6ZWQgKHdoaWNoIG1lYW5zIHRoYXQgdW5zcGVjaWZpZWQg
ZmllbGRzIGFyZQppbXBsaWNpdGx5IHplcm8tY2xlYXJlZCkiIG9yICJkeW5hbWljYWxseSBhbGxv
Y2F0ZWQgd2l0aCBfX0dGUF9aRVJPIG9yIHplcm8tY2xlYXJlZCB1c2luZwptZW1zZXQoKSAod2hp
Y2ggbWVhbnMgdGhhdCBhbGwgZmllbGRzIGFyZSBvbmNlIHplcm8tY2xlYXJlZCkiLgoKQW5kIGlm
IHlvdSBvbmNlIHplcm8tY2xlYXIgdmIgYXQgYWxsb2NhdGlvbiB0aW1lLCB5b3Ugd2lsbCBnZXQg
YSBib251cyB0aGF0CmNhbGxpbmcgdW5yZWdpc3Rlcl9zaHJpbmtlcigpIHdpdGhvdXQgY29ycmVz
cG9uZGluZyByZWdpc3Rlcl9zaHJpbmtlcigpIGlzIHNhZmUKKHdoaWNoIHdpbGwgc2ltcGxpZnkg
aW5pdGlhbGl6YXRpb24gZmFpbHVyZSBwYXRoKS4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
