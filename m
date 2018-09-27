From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] vhost-vsock: fix use after free
Date: Thu, 27 Sep 2018 20:21:37 +0800
Message-ID: <a05604fb-74c7-5a6b-2af1-702da68ffbec__10481.957512866$1538050786$gmane$org@redhat.com>
References: <20180927084301.573-1-jasowang@redhat.com>
	<a413a8b4-302d-7fbc-092d-95e8aa421c4c@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a413a8b4-302d-7fbc-092d-95e8aa421c4c@cogentembedded.com>
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
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, stefanha@redhat.com, mst@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDnmnIgyN+aXpSAxNzo1MiwgU2VyZ2VpIFNodHlseW92IHdyb3RlOgo+IEhl
bGxvIQo+Cj4gT24gOS8yNy8yMDE4IDExOjQzIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gwqDC
oCBKdXN0IGEgY291cGxlIG9mIHR5cG9zLi4uCj4KPj4gVGhlIGFjY2VzcyBvZiB2c29jayBpcyBu
b3QgcHJvdGVjdGVkIGJ5IHZob3N0X3Zzb2NrX2xvY2suIFRoaXMgbWF5Cj4+IGxlYWQgdXNlIGFm
dGVyIGZyZWUgc2luY2Ugdmhvc3RfdnNvY2tfZGV2X3JlbGVhc2UoKSBtYXkgZnJlZSB0aGUKPgo+
IMKgIExlYWQgdG8gdXNlLgo+Cj4+IHBvaW50ZXIgYXQgdGhlIHNhbWUgdGltZS4KPj4KPj4gRml4
IHRoaXMgYnkgaG9sZGluZyB0aGUgbG9jayBkdXJpbmcgdGhlIGFjZXNzLgo+Cj4gwqDCoCBBY2Nl
c3MuCj4KPj4gUmVwb3J0ZWQtYnk6IHN5emJvdCtlM2UwNzQ5NjM0OTVmOTJhODllZEBzeXprYWxs
ZXIuYXBwc3BvdG1haWwuY29tCj4+IEZpeGVzOiAxNjMyMGYzNjNhZTEgKCJ2aG9zdC12c29jazog
YWRkIHBrdCBjYW5jZWwgY2FwYWJpbGl0eSIpCj4+IEZpeGVzOiA0MzNmYzU4ZTZiZjIgKCJWU09D
SzogSW50cm9kdWNlIHZob3N0X3Zzb2NrLmtvIikKPj4gQ2M6IFN0ZWZhbiBIYWpub2N6aSA8c3Rl
ZmFuaGFAcmVkaGF0LmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KPiBbLi4uXQo+Cj4gTUJSLCBTZXJnZWkKCkxldCBtZSBwb3N0IFYyLgoKVGhh
bmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
