From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH V2 0/8] Packed ring for vhost
Date: Tue, 27 Mar 2018 11:33:38 +0800
Message-ID: <1e5ad820-f11a-8208-d4c0-5d871adddb9e__34913.4417171173$1522121574$gmane$org@redhat.com>
References: <1522035533-11786-1-git-send-email-jasowang@redhat.com>
	<20180326190130.GE6928@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180326190130.GE6928@char.us.oracle.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDPmnIgyN+aXpSAwMzowMSwgS29ucmFkIFJ6ZXN6dXRlayBXaWxrIHdyb3Rl
Ogo+IE9uIE1vbiwgTWFyIDI2LCAyMDE4IGF0IDExOjM4OjQ1QU0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4+IEhpIGFsbDoKPj4KPj4gVGhpcyBSRkMgaW1wbGVtZW50IHBhY2tlZCByaW5nIGxh
eW91dC4gVGhlIGNvZGUgd2VyZSB0ZXN0ZWQgd2l0aCBwbWQKPj4gaW1wbGVtZW50IGJ5IEplbnMg
YXQKPj4gaHR0cDovL2RwZGsub3JnL21sL2FyY2hpdmVzL2Rldi8yMDE4LUphbnVhcnkvMDg5NDE3
Lmh0bWwuIE1pbm9yIGNoYW5nZQo+PiB3YXMgbmVlZGVkIGZvciBwbWQgY29kZXMgdG8ga2ljayB2
aXJ0cXVldWUgc2luY2UgaXQgYXNzdW1lcyBhIGJ1c3kKPj4gcG9sbGluZyBiYWNrZW5kLgo+Pgo+
PiBUZXN0IHdlcmUgZG9uZSBiZXR3ZWVuIGxvY2FsaG9zdCBhbmQgZ3Vlc3QuIFRlc3RwbWQgKHJ4
b25seSkgaW4gZ3Vlc3QKPj4gcmVwb3J0cyAyLjRNcHBzLiBUZXN0cG1kICh0eG9ubHkpIHJlcG90
cyBhYm91dCAyLjFNcHBzLgo+IEFuZCBob3cgZG9lcyBpdCBjb21wYXJlIHRvIG9sZGVyIHJpbmcg
bGF5b3V0Pwo+CgpObyBvYnZpb3VzIGRpZmZlcmVuY2UuCgpWaG9zdCBpdHNlbGYgYmVjb21lcyBh
IGJvdHRsZW5lY2suIEkgcGxhbiB0byBkbyBtb3JlIGFnZ3Jlc3NpdmUgYmF0Y2hpbmcgCmxpa2Ug
ZHBkayBvbiB0b3AuCgpUaGFua3MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
