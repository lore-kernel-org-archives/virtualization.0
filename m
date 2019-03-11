From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
	vmap()
Date: Mon, 11 Mar 2019 15:13:17 +0800
Message-ID: <56374231-7ba7-0227-8d6d-4d968d71b4d6__21444.6658430219$1552288419$gmane$org@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<20190308141220.GA21082@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190308141220.GA21082@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: aarcange@redhat.com, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMy84IOS4i+WNiDEwOjEyLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBX
ZWQsIE1hciAwNiwgMjAxOSBhdCAwMjoxODowN0FNIC0wNTAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBUaGlzIHNlcmllcyB0cmllcyB0byBhY2Nlc3MgdmlydHF1ZXVlIG1ldGFkYXRhIHRocm91Z2gg
a2VybmVsIHZpcnR1YWwKPj4gYWRkcmVzcyBpbnN0ZWFkIG9mIGNvcHlfdXNlcigpIGZyaWVuZHMg
c2luY2UgdGhleSBoYWQgdG9vIG11Y2gKPj4gb3ZlcmhlYWRzIGxpa2UgY2hlY2tzLCBzcGVjIGJh
cnJpZXJzIG9yIGV2ZW4gaGFyZHdhcmUgZmVhdHVyZQo+PiB0b2dnbGluZy4gVGhpcyBpcyBkb25l
IHRocm91Z2ggc2V0dXAga2VybmVsIGFkZHJlc3MgdGhyb3VnaCB2bWFwKCkgYW5kCj4+IHJlc2ln
dGVyIE1NVSBub3RpZmllciBmb3IgaW52YWxpZGF0aW9uLgo+Pgo+PiBUZXN0IHNob3dzIGFib3V0
IDI0JSBpbXByb3ZlbWVudCBvbiBUWCBQUFMuIFRDUF9TVFJFQU0gZG9lc24ndCBzZWUKPj4gb2J2
aW91cyBpbXByb3ZlbWVudC4KPiBIb3cgaXMgdGhpcyBnb2luZyB0byB3b3JrIGZvciBDUFVzIHdp
dGggdmlydHVhbGx5IHRhZ2dlZCBjYWNoZXM/CgoKQW55dGhpbmcgZGlmZmVyZW50IHRoYXQgeW91
IHdvcnJ5PyBJIGNhbiBoYXZlIGEgdGVzdCBidXQgZG8geW91IGtub3cgYW55IAphcmNocyB0aGF0
IHVzZSB2aXJ0dWFsIHRhZyBjYWNoZT8KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
