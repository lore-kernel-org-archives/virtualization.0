From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 09/11] tuntap: accept an array of XDP buffs
	through sendmsg()
Date: Fri, 7 Sep 2018 15:33:08 +0800
Message-ID: <ac494845-1fcc-602b-dec9-c11109f55518__19690.0015151643$1536305477$gmane$org@redhat.com>
References: <20180906040526.22518-1-jasowang@redhat.com>
	<20180906040526.22518-10-jasowang@redhat.com>
	<20180906134834-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180906134834-mutt-send-email-mst@kernel.org>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDnmnIgwN+aXpSAwMTo1MSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IE9uIFRodSwgU2VwIDA2LCAyMDE4IGF0IDEyOjA1OjI0UE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+IFRoaXMgcGF0Y2ggaW1wbGVtZW50IFRVTl9NU0dfUFRSIG1zZ19jb250cm9sIHR5cGUu
IFRoaXMgdHlwZSBhbGxvd3MKPj4gdGhlIGNhbGxlciB0byBwYXNzIGFuIGFycmF5IG9mIFhEUCBi
dWZmcyB0byB0dW50YXAgdGhyb3VnaCBwdHIgZmllbGQKPj4gb2YgdGhlIHR1bl9tc2dfY29udHJv
bC4gSWYgYW4gWERQIHByb2dyYW0gaXMgYXR0YWNoZWQsIHR1bnRhcCBjYW4gcnVuCj4+IFhEUCBw
cm9ncmFtIGRpcmVjdGx5LiBJZiBub3QsIHR1bnRhcCB3aWxsIGJ1aWxkIHNrYiBhbmQgZG8gYSBm
YXN0Cj4+IHJlY2VpdmluZyBzaW5jZSBwYXJ0IG9mIHRoZSB3b3JrIGhhcyBiZWVuIGRvbmUgYnkg
dmhvc3RfbmV0Lgo+Pgo+PiBUaGlzIHdpbGwgYXZvaWQgbG90cyBvZiBpbmRpcmVjdCBjYWxscyB0
aHVzIGltcHJvdmVzIHRoZSBpY2FjaGUKPj4gdXRpbGl6YXRpb24gYW5kIGFsbG93cyB0byBkbyBY
RFAgYmF0Y2hlZCBmbHVzaGluZyB3aGVuIGRvaW5nIFhEUAo+PiByZWRpcmVjdGlvbi4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZzxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IElzIG1vc3Qg
b2YgdGhlIGJlbmVmaXQgaW4gYmF0Y2hlZCBmbHVzaGluZyBvciBza2lwcGluZwo+IGluZGlyZWN0
IGNhbGxzPyBCZWNhdXNlIGlmIGl0J3MgZmx1c2hpbmcgd2UgY2FuIGdhaW4KPiBtb3N0IG9mIGl0
IGVhc2lseSBieSBhZGRpbmcgYW4gYW5hbG9nIG9mIHhtaXRfbW9yZS4KPgoKU2hvdWxkIGJlIGJv
dGguIFhEUF9EUk9QIGRvZXNuJ3QgZmx1c2ggYnV0IGl0IGdpdmVzIG9idmlvdXMgaW1wcm92ZW1l
bnQuCgpUaGFua3MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
