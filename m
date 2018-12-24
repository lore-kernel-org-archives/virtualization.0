From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net V2 4/4] vhost: log dirty page correctly
Date: Mon, 24 Dec 2018 11:43:31 +0800
Message-ID: <55b3d55a-950f-eeaf-1908-bed78a1a9200@redhat.com>
References: <20181212100819.21295-1-jasowang@redhat.com>
	<20181212100819.21295-5-jasowang@redhat.com>
	<20181212092435-mutt-send-email-mst@kernel.org>
	<0239c220-e7ca-c08f-be26-eb9be63fced3@redhat.com>
	<20181213092930-mutt-send-email-mst@kernel.org>
	<519ee6f7-06fc-ad49-03da-c096aeb24ced@redhat.com>
	<20181214081821-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181214081821-mutt-send-email-mst@kernel.org>
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
Cc: Jintack Lim <jintack@cs.columbia.edu>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTgvMTIvMTQg5LiL5Y2IOToyMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IEZyaSwgRGVjIDE0LCAyMDE4IGF0IDEwOjQzOjAzQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IE9uIDIwMTgvMTIvMTMg5LiL5Y2IMTA6MzEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToK
Pj4+PiBKdXN0IHRvIG1ha2Ugc3VyZSBJIHVuZGVyc3RhbmQgdGhpcy4gSXQgbG9va3MgdG8gbWUg
d2Ugc2hvdWxkOgo+Pj4+Cj4+Pj4gLSBhbGxvdyBwYXNzaW5nIEdJT1ZBLT5HUEEgdGhyb3VnaCBV
QVBJCj4+Pj4KPj4+PiAtIGNhY2hlIEdJT1ZBLT5HUEEgc29tZXdoZXJlIGJ1dCBzdGlsbCB1c2Ug
R0lPVkEtPkhWQSBpbiBkZXZpY2UgSU9UTEIgZm9yCj4+Pj4gcGVyZm9ybWFuY2UKPj4+Pgo+Pj4+
IElzIHRoaXMgd2hhdCB5b3Ugc3VnZ2VzdD8KPj4+Pgo+Pj4+IFRoYW5rcwo+Pj4gTm90IHJlYWxs
eS4gV2UgYWxyZWFkeSBoYXZlIEdQQS0+SFZBLCBzbyBJIHN1Z2dlc3RlZCBhIGZsYWcgdG8gcGFz
cwo+Pj4gR0lPVkEtPkdQQSBpbiB0aGUgSU9UTEIuCj4+Pgo+Pj4gVGhpcyBoYXMgYWR2YW50YWdl
cyBmb3Igc2VjdXJpdHkgc2luY2UgYSBzaW5nbGUgdGFibGUgbmVlZHMKPj4+IHRoZW4gdG8gYmUg
dmFsaWRhdGVkIHRvIGVuc3VyZSBndWVzdCBkb2VzIG5vdCBjb3JydXB0Cj4+PiBRRU1VIG1lbW9y
eS4KPj4+Cj4+IEkgd29uZGVyIGhvdyBtdWNoIHdlIGNhbiBnYWluIHRocm91Z2ggdGhpcy4gQ3Vy
cmVudGx5LCBxZW11IElPTU1VIGdpdmVzCj4+IEdJT1ZBLT5HUEEgbWFwcGluZywgYW5kIHFlbXUg
dmhvc3QgY29kZSB3aWxsIHRyYW5zbGF0ZSBHUEEgdG8gSFZBIHRoZW4gcGFzcwo+PiBHSU9WQS0+
SFZBIHRvIHZob3N0LiBJdCBsb29rcyBubyBkaWZmZXJlbmNlIHRvIG1lLgo+Pgo+PiBUaGFua3MK
PiBUaGUgZGlmZmVyZW5jZSBpcyBpbiBzZWN1cml0eSBub3QgaW4gcGVyZm9ybWFuY2UuICBHZXR0
aW5nIGEgYmFkIEhWQQo+IGNvcnJ1cHRzIFFFTVUgbWVtb3J5IGFuZCBpdCBtaWdodCBiZSBndWVz
dCBjb250cm9sbGVkLiBWZXJ5IHJpc2t5LgoKCkhvdyBjYW4gdGhpcyBiZSBjb250cm9sbGVkIGJ5
IGd1ZXN0PyBIVkEgd2FzIGdlbmVyYXRlZCBmcm9tIHFlbXUgcmFtIApibG9ja3Mgd2hpY2ggaXMg
dG90YWxseSB1bmRlciB0aGUgY29udHJvbCBvZiBxZW11IG1lbW9yeSBjb3JlIGluc3RlYWQgb2Yg
Cmd1ZXN0LgoKClRoYW5rcwoKCj4gICBJZgo+IHRyYW5zbGF0aW9ucyB0byBIVkEgYXJlIGRvbmUg
aW4gYSBzaW5nbGUgcGxhY2UgdGhyb3VnaCBhIHNpbmdsZSB0YWJsZQo+IGl0J3Mgc2FmZXIgYXMg
dGhlcmUncyBhIHNpbmdsZSByaXNreSBwbGFjZS4KPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
