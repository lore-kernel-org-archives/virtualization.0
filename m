From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH 09/10] virtio/s390: use DMA memory for ccw I/O and classic
	notifiers
Date: Thu, 9 May 2019 15:30:08 +0200
Message-ID: <db036887-c238-9795-5f47-cfeb475074e4@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-10-pasic@linux.ibm.com>
	<a873909a-9846-d6d3-f03e-e86d53fd9c75@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a873909a-9846-d6d3-f03e-e86d53fd9c75@linux.ibm.com>
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
To: Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Viktor Mihajlovski <mihajlov@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMDgvMDUvMjAxOSAxNjo0NiwgUGllcnJlIE1vcmVsIHdyb3RlOgo+IE9uIDI2LzA0LzIwMTkg
MjA6MzIsIEhhbGlsIFBhc2ljIHdyb3RlOgo+PiBCZWZvcmUgdmlydGlvLWNjdyBjb3VsZCBnZXQg
YXdheSB3aXRoIG5vdCB1c2luZyBETUEgQVBJIGZvciB0aGUgcGllY2VzIG9mCj4+IG1lbW9yeSBp
dCBkb2VzIGNjdyBJL08gd2l0aC4gV2l0aCBwcm90ZWN0ZWQgdmlydHVhbGl6YXRpb24gdGhpcyBo
YXMgdG8KPj4gY2hhbmdlLCBzaW5jZSB0aGUgaHlwZXJ2aXNvciBuZWVkcyB0byByZWFkIGFuZCBz
b21ldGltZXMgYWxzbyB3cml0ZSB0aGVzZQo+PiBwaWVjZXMgb2YgbWVtb3J5Lgo+Pgo+PiBUaGUg
aHlwZXJ2aXNvciBpcyBzdXBwb3NlZCB0byBwb2tlIHRoZSBjbGFzc2ljIG5vdGlmaWVycywgaWYg
dGhlc2UgYXJlCj4+IHVzZWQsIG91dCBvZiBiYW5kIHdpdGggcmVnYXJkcyB0byBjY3cgSS9PLiBT
byB0aGVzZSBuZWVkIHRvIGJlIGFsbG9jYXRlZAo+PiBhcyBETUEgbWVtb3J5ICh3aGljaCBpcyBz
aGFyZWQgbWVtb3J5IGZvciBwcm90ZWN0ZWQgdmlydHVhbGl6YXRpb24KPj4gZ3Vlc3RzKS4KPj4K
Pj4gTGV0IHVzIGZhY3RvciBvdXQgZXZlcnl0aGluZyBmcm9tIHN0cnVjdCB2aXJ0aW9fY2N3X2Rl
dmljZSB0aGF0IG5lZWRzIHRvCj4+IGJlIERNQSBtZW1vcnkgaW4gYSBzYXRlbGxpdGUgdGhhdCBp
cyBhbGxvY2F0ZWQgYXMgc3VjaC4KPj4KLi4uCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2YoaW5kaWNhdG9ycyh2Y2RldikpKTsKPiAKPiBzaG91
bGQgYmUgc2l6ZW9mKGxvbmcpID8KPiAKPiBUaGlzIGlzIGEgcmVjdXJyZW50IGVycm9yLCBidXQg
aXQgaXMgbm90IGFuIGlzc3VlIGJlY2F1c2UgdGhlIHNpemUgb2YKPiB0aGUgaW5kaWNhdG9ycyBp
cyB1bnNpZ25lZCBsb25nIGFzIHRoZSBzaXplIG9mIHRoZSBwb2ludGVyLgo+IAo+IFJlZ2FyZHMs
Cj4gUGllcnJlCj4gCgpIZXJlIHRvbywgd2l0aCB0aGUgcHJvYmxlbSBvZiB0aGUgaW5kaWNhdG9y
IHNpemUgaGFuZGxlZDoKUmV2aWV3ZWQtYnk6IFBpZXJyZSBNb3JlbDxwbW9yZWxAbGludXguaWJt
LmNvbT4KCgotLSAKUGllcnJlIE1vcmVsCkxpbnV4L0tWTS9RRU1VIGluIELDtmJsaW5nZW4gLSBH
ZXJtYW55CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
