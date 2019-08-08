From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH V4 7/9] vhost: do not use RCU to synchronize MMU notifier
	with worker
Date: Thu, 8 Aug 2019 10:05:25 -0300
Message-ID: <20190808130525.GA1989__12562.7438117348$1565269540$gmane$org@ziepe.ca>
References: <20190807070617.23716-1-jasowang@redhat.com>
	<20190807070617.23716-8-jasowang@redhat.com>
	<20190807120738.GB1557@ziepe.ca>
	<ba5f375f-435a-91fd-7fca-bfab0915594b@redhat.com>
	<1000f8a3-19a9-0383-61e5-ba08ddc9fcba@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1000f8a3-19a9-0383-61e5-ba08ddc9fcba@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBBdWcgMDgsIDIwMTkgYXQgMDg6NTQ6NTRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKCj4gSSBkb24ndCBoYXZlIGFueSBvYmplY3Rpb24gdG8gY29udmVydMKgIHRvIHNwaW5sb2Nr
KCkgYnV0IGp1c3Qgd2FudCB0bwo+IGtub3cgaWYgYW55IGNhc2UgdGhhdCB0aGUgYWJvdmUgc21w
X21iKCkgKyBjb3VudGVyIGxvb2tzIGdvb2QgdG8geW91PwoKVGhpcyBlbWFpbCBpcyBob3JyaWJs
eSBtYW5nbGVkLCBidXQgSSBkb24ndCB0aGluayBtaXhpbmcgc21iX21iKCkgYW5kCnNtcF9sb2Fk
X2FjcXVpcmUoKSB3b3VsZCBiZSBjb25zaWRlcmQgYSBiZXN0LXByYWN0aWNlLCBhbmQgdXNpbmcK
c21wX3N0b3JlX3JlbGVhc2UoKSBpbnN0ZWFkIHdvdWxkIGJlIHRoZSB3cm9uZyBiYXJyaWVyLgoK
c3BpbmxvY2sgZG9lcyBzZWVtIHRvIGJlIHRoZSBvbmx5IGV4aXN0aW5nIGxvY2tpbmcgcHJpbWl0
aXZlIHRoYXQgZG9lcwp3aGF0IGlzIG5lZWRlZCBoZXJlLgoKSmFzb24KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
