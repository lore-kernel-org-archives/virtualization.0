From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 4/9] vhost: reset invalidate_count in
	vhost_set_vring_num_addr()
Date: Thu, 1 Aug 2019 13:03:24 +0800
Message-ID: <0a4deb4e-92e8-44e1-b20e-05767641b6ba__15811.5811807633$1564636495$gmane$org@redhat.com>
References: <20190731084655.7024-1-jasowang@redhat.com>
	<20190731084655.7024-5-jasowang@redhat.com>
	<20190731124124.GD3946@ziepe.ca>
	<31ef9ed4-d74a-3454-a57d-fa843a3a802b@redhat.com>
	<20190731193252.GH3946@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190731193252.GH3946@ziepe.ca>
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
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOC8xIOS4iuWNiDM6MzIsIEphc29uIEd1bnRob3JwZSB3cm90ZToKPiBPbiBXZWQs
IEp1bCAzMSwgMjAxOSBhdCAwOToyOToyOFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBP
biAyMDE5LzcvMzEg5LiL5Y2IODo0MSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+Pj4gT24gV2Vk
LCBKdWwgMzEsIDIwMTkgYXQgMDQ6NDY6NTBBTSAtMDQwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+
PiBUaGUgdmhvc3Rfc2V0X3ZyaW5nX251bV9hZGRyKCkgY291bGQgYmUgY2FsbGVkIGluIHRoZSBt
aWRkbGUgb2YKPj4+PiBpbnZhbGlkYXRlX3JhbmdlX3N0YXJ0KCkgYW5kIGludmFsaWRhdGVfcmFu
Z2VfZW5kKCkuIElmIHdlIGRvbid0IHJlc2V0Cj4+Pj4gaW52YWxpZGF0ZV9jb3VudCBhZnRlciB0
aGUgdW4tcmVnaXN0ZXJpbmcgb2YgTU1VIG5vdGlmaWVyLCB0aGUKPj4+PiBpbnZhbGlkYXRlX2Nv
bnQgd2lsbCBydW4gb3V0IG9mIHN5bmMgKGUuZyBuZXZlciByZWFjaCB6ZXJvKS4gVGhpcyB3aWxs
Cj4+Pj4gaW4gZmFjdCBkaXNhYmxlIHRoZSBmYXN0IGFjY2Vzc29yIHBhdGguIEZpeGluZyBieSBy
ZXNldCB0aGUgY291bnQgdG8KPj4+PiB6ZXJvLgo+Pj4+Cj4+Pj4gUmVwb3J0ZWQtYnk6IE1pY2hh
ZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4+PiBEaWQgTWljaGFlbCByZXBvcnQgdGhp
cyBhcyB3ZWxsPwo+Pgo+PiBDb3JyZWN0IG1lIGlmIEkgd2FzIHdyb25nLiBJIHRoaW5rIGl0J3Mg
cG9pbnQgNCBkZXNjcmliZWQgaW4KPj4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvNy8yMS8y
NS4KPiBJJ20gbm90IHN1cmUgd2hhdCB0aGF0IGlzIHRhbGtpbmcgYWJvdXQKPgo+IEJ1dCB0aGlz
IGZpeGVzIHdoYXQgSSBkZXNjcmliZWQ6Cj4KPiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS83
LzIyLzU1NAo+Cj4gSmFzb24KCgpJJ20gc29ycnkgSSBtaXNzIHRoaXMsIHdpbGwgYWRkIHlvdXIg
bmFtZSBhcyByZXBvcnRlZC1ieSBpbiB0aGUgbmV4dCAKdmVyc2lvbi4KClRoYW5rcwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
