From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/1] vhost: add per-vq worker thread
Date: Tue, 6 Nov 2018 10:48:51 +0800
Message-ID: <617e0c54-7d11-09b6-21e5-968260107872__27380.0783827484$1541472418$gmane$org@redhat.com>
References: <20181102160710.3741-1-v.mayatskih@gmail.com>
	<20181102160710.3741-2-v.mayatskih@gmail.com>
	<fe79c7fd-1e9f-dab8-3c65-8151181c922c@redhat.com>
	<CAGF4SLgDk+48aLKHhA_ZgRc6D30tGdnB89b5m5bZKwzyoDb0dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGF4SLgDk+48aLKHhA_ZgRc6D30tGdnB89b5m5bZKwzyoDb0dQ@mail.gmail.com>
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
To: Vitaly Mayatskih <v.mayatskih@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTgvMTEvNSDkuIrljYgxMToyOCwgVml0YWx5IE1heWF0c2tpaCB3cm90ZToKPiBPbiBT
dW4sIE5vdiA0LCAyMDE4IGF0IDk6NTMgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4KPj4gSSB3b25kZXIgd2hldGhlciBvciBub3QgaXQncyBiZXR0ZXIgdG8gYWxs
b3cgdGhlIGRldmljZSB0byBzcGVjaWZpYyB0aGUKPj4gd29ya2VyIGhlcmUgaW5zdGVhZCBvZiBm
b3JjaW5nIGEgcGVyIHZxIHdvcmtlciBtb2RlbC4gVGhlbiB3ZSBjYW4ga2VlcAo+PiB0aGUgYmVo
YXZpb3Igb2YgZXhpc3QgaW1wbGVtZW50YXRpb24gYW5kIGRvIG9wdGltaXphdGlvbiBvbiB0b3A/
Cj4gSSB3YXMgdGhpbmtpbmcgYWJvdXQgdGhhdCB0b28sIGJ1dCBmb3IgdGhlIHNha2Ugb2Ygc2lt
cGxpY2l0eSBpdAo+IHNvdW5kcyB2YWxpZCB0aGF0IGlmIHRoZSB1c2VyIHdhbnRlZCA4IHBhcmFs
bGVsIHF1ZXVlcyBmb3IgdGhlIGRpc2ssCj4gdGhleSBiZXR0ZXIgYmUgcGFyYWxsZWwsIGkuZS4g
d29ya2VyIHBlciBxdWV1ZS4gVGhlIHJlc3Qgb2YgZGlza3MgdGhhdAo+IGRvbid0IG5lZWQgaGln
aC1wZXJmb3JtYW5jZSwgY2FuIGhhdmUgMSBxdWV1ZSBzcGVjaWZpZWQuCj4KCklmIHlvdSBhbGxv
dyBkZXZpY2UgdG8gc3BlY2lmeSB0aGUgd29ya2VyIGl0c2VsZiwgeW91IGNhbiBkbyBhbnkga2lu
ZHMgCm9mIG1hcHBpbmcgYmV0dHdlZW4gd29yayBhbmQgd29ya2VyIGt0aHJlYWQgSSB0aGluay4g
VGhlIGFkdmFudGFnZSBvZiAKZG9pbmcgdGhpcyBpcyB0aGF0IHlvdSBjYW4ga2VlcCB0aGUgdmhv
c3QtbmV0IHVudG91Y2hlZC4gVGhpcyBtYWtlcyAKdGhpbmdzIGEgbGl0dGxlIGJpdCBlYXNpZXIg
YW5kIHByb3ZpbmcgdHdvIGt0aHJlYWRzIGlzIGJldHRlciB0aGFuIG9uZSAKZm9yIC1uZXQgd29y
a2xvYWQgaXMgcHJvYmFibHkgbm90IGFzIGVhc3kgYXMgaXQgbG9va3MuIFdlIG1heSBnZXQgYm9v
c3QgCmluIHNvbWUgY2FzZXMgYnV0IGRlZ3JhZGF0aW9uIGZvciB0aGUgcmVzdC4KCgpUaGFua3MK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
