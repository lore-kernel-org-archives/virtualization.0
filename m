From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH V3 0/5] Hi:
Date: Mon, 7 Jan 2019 11:53:41 +0800
Message-ID: <c15a17b3-b604-a105-af44-a7e6dfd79801@redhat.com>
References: <20181229124656.3900-1-jasowang@redhat.com>
	<20190102154038-mutt-send-email-mst@kernel.org>
	<0efd115a-a7fb-54bf-5376-59d047a15fd3@redhat.com>
	<20190106221832-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190106221832-mutt-send-email-mst@kernel.org>
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
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMS83IOS4iuWNiDExOjI4LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
TW9uLCBKYW4gMDcsIDIwMTkgYXQgMTA6MTk6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gT24gMjAxOS8xLzMg5LiK5Y2INDo0NywgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4g
T24gU2F0LCBEZWMgMjksIDIwMTggYXQgMDg6NDY6NTFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPj4+PiBUaGlzIHNlcmllcyB0cmllcyB0byBhY2Nlc3MgdmlydHF1ZXVlIG1ldGFkYXRhIHRo
cm91Z2gga2VybmVsIHZpcnR1YWwKPj4+PiBhZGRyZXNzIGluc3RlYWQgb2YgY29weV91c2VyKCkg
ZnJpZW5kcyBzaW5jZSB0aGV5IGhhZCB0b28gbXVjaAo+Pj4+IG92ZXJoZWFkcyBsaWtlIGNoZWNr
cywgc3BlYyBiYXJyaWVycyBvciBldmVuIGhhcmR3YXJlIGZlYXR1cmUKPj4+PiB0b2dnbGluZy4K
Pj4+IFdpbGwgcmV2aWV3LCB0aGFua3MhCj4+PiBPbmUgcXVlc3Rpb25zIHRoYXQgY29tZXMgdG8g
bWluZCBpcyB3aGV0aGVyIGl0J3MgYWxsIGFib3V0IGJ5cGFzc2luZwo+Pj4gc3RhYy9jbGFjLiAg
Q291bGQgeW91IHBsZWFzZSBpbmNsdWRlIGEgcGVyZm9ybWFuY2UgY29tcGFyaXNvbiB3aXRoCj4+
PiBub3NtYXA/Cj4+Pgo+PiBPbiBtYWNoaW5lIHdpdGhvdXQgU01BUCAoU2FuZHkgQnJpZGdlKToK
Pj4KPj4gQmVmb3JlOiA0LjhNcHBzCj4+Cj4+IEFmdGVyOiA1LjJNcHBzCj4gT0sgc28gd291bGQg
eW91IHNheSBpdCdzIHJlYWxseSB1bnNhZmUgdmVyc3VzIHNhZmUgYWNjZXNzZXM/Cj4gT3Igd291
bGQgeW91IHNheSBpdCdzIGp1c3QgYSBiZXR0ZXIgd3JpdHRlbiBjb2RlPwoKCkl0J3MgdGhlIGVm
ZmVjdCBvZiByZW1vdmluZyBzcGVjdWxhdGlvbiBiYXJyaWVyLgoKCj4KPj4gT24gbWFjaGluZSB3
aXRoIFNNQVAgKEJyb2Fkd2VsbCk6Cj4+Cj4+IEJlZm9yZTogNS4wTXBwcwo+Pgo+PiBBZnRlcjog
Ni4xTXBwcwo+Pgo+PiBObyBzbWFwOiA3LjVNcHBzCj4+Cj4+Cj4+IFRoYW5rcwo+Cj4gbm8gc21h
cCBiZWluZyBiZWZvcmUgb3IgYWZ0ZXI/Cj4KCkxldCBtZSBjbGFyaWZ5OgoKCkJlZm9yZSAoU01B
UCBvbik6IDUuME1wcHMKCkJlZm9yZSAoU01BUCBvZmYpOiA3LjVNcHBzCgpBZnRlciAoU01BUCBv
bik6IDYuMU1wcHMKCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
