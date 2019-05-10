From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH 04/10] s390/mm: force swiotlb for protected virtualization
Date: Fri, 10 May 2019 09:49:29 +0200
Message-ID: <20190510094929.67e4ad29@p-imbrenda.boeblingen.de.ibm.com>
References: <20190426183245.37939-5-pasic@linux.ibm.com>
	<ad23f5e7-dc78-04af-c892-47bbc65134c6@linux.ibm.com>
	<4c7a990a-7f11-17f3-2024-18acaf7ceb06@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4c7a990a-7f11-17f3-2024-18acaf7ceb06@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: "Vasily Gorbik , " <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Thomas Huth , " <thuth@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, "Michael S. Tsirkin ,
	" <mst@redhat.com>, "Cornelia Huck , " <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>, Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCA5IE1heSAyMDE5IDE0OjA1OjIwIC0wNDAwCiJKYXNvbiBKLiBIZXJuZSIgPGpqaGVy
bmVAbGludXguaWJtLmNvbT4gd3JvdGU6CgpbLi4uXQoKPiA+ICsjZGVmaW5lIHNtZV9tZV9tYXNr
wqDCoMKgIDBVTEwKPiA+ICsKPiA+ICtzdGF0aWMgaW5saW5lIGJvb2wgc21lX2FjdGl2ZSh2b2lk
KSB7IHJldHVybiBmYWxzZTsgfQo+ID4gK2V4dGVybiBib29sIHNldl9hY3RpdmUodm9pZCk7Cj4g
PiArICAKPiAKPiBJIG5vdGljZWQgdGhpcyBwYXRjaCBhbHdheXMgcmV0dXJucyBmYWxzZSBmb3Ig
c21lX2FjdGl2ZS4gSXMgaXQgc2FmZQo+IHRvIGFzc3VtZSB0aGF0IHdoYXRldmVyIGZpeHVwcyBh
cmUgcmVxdWlyZWQgb24geDg2IHRvIGRlYWwgd2l0aCBzbWUKPiBkbyBub3QgYXBwbHkgdG8gczM5
MD8KCnllcywgb24geDg2IHNldl9hY3RpdmUgcmV0dXJucyBmYWxzZSBpZiBTRVYgaXMgZW5hYmxl
ZC4gU01FIGlzIGZvcgpob3N0IG1lbW9yeSBlbmNyeXB0aW9uLiBmcm9tIGFyY2gveDg2L21tL21l
bV9lbmNyeXB0LmM6Cgpib29sIHNtZV9hY3RpdmUodm9pZCkKewogICAgICAgIHJldHVybiBzbWVf
bWVfbWFzayAmJiAhc2V2X2VuYWJsZWQ7Cn0KCmFuZCBpdCBtYWtlcyBzZW5zZSBiZWNhdXNlIHlv
dSBjYW4ndCBoYXZlIGJvdGggU01FIGFuZCBTRVYgZW5hYmxlZCBvbgp0aGUgc2FtZSBrZXJuZWws
IGJlY2F1c2UgZWl0aGVyIHlvdSdyZSBydW5uaW5nIG9uIGJhcmUgbWV0YWwgKGFuZCB0aGVuCnlv
dSBjYW4gaGF2ZSBTTUUpIF9fb3JfXyB5b3UgYXJlIHJ1bm5pbmcgYXMgYSBndWVzdCAoYW5kIHRo
ZW4geW91IGNhbgpoYXZlIFNFVikuIFRoZSBrZXkgZGlmZmVyZW5jZSBpcyB0aGF0IERNQSBvcGVy
YXRpb25zIGRvbid0IG5lZWQKYm91bmNlIGJ1ZmZlcnMgd2l0aCBTTUUsIGJ1dCB0aGV5IGRvIHdp
dGggU0VWLgoKSSBob3BlIHRoaXMgY2xhcmlmaWVzIHlvdXIgZG91YnRzIDopCgpbLi4uXQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
