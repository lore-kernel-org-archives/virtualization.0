From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next V2 11/11] vhost_net: batch submitting XDP buffers
	to underlayer sockets
Date: Fri, 14 Sep 2018 11:11:19 +0800
Message-ID: <dfc04379-125b-dd4e-b903-4b9323a25506__26646.0540042774$1536894574$gmane$org@redhat.com>
References: <20180912031709.14112-1-jasowang@redhat.com>
	<20180912031709.14112-12-jasowang@redhat.com>
	<20180913140332-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180913140332-mutt-send-email-mst@kernel.org>
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

CgpPbiAyMDE45bm0MDnmnIgxNOaXpSAwMjowNCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IE9uIFdlZCwgU2VwIDEyLCAyMDE4IGF0IDExOjE3OjA5QU0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+ICtzdGF0aWMgdm9pZCB2aG9zdF90eF9iYXRjaChzdHJ1Y3Qgdmhvc3RfbmV0ICpuZXQs
Cj4+ICsJCQkgICBzdHJ1Y3Qgdmhvc3RfbmV0X3ZpcnRxdWV1ZSAqbnZxLAo+PiArCQkJICAgc3Ry
dWN0IHNvY2tldCAqc29jaywKPj4gKwkJCSAgIHN0cnVjdCBtc2doZHIgKm1zZ2hkcikKPj4gK3sK
Pj4gKwlzdHJ1Y3QgdHVuX21zZ19jdGwgY3RsID0gewo+PiArCQkudHlwZSA9IFRVTl9NU0dfUFRS
LAo+PiArCQkubnVtID0gbnZxLT5iYXRjaGVkX3hkcCwKPj4gKwkJLnB0ciA9IG52cS0+eGRwLAo+
PiArCX07Cj4+ICsJaW50IGVycjsKPj4gKwo+PiArCWlmIChudnEtPmJhdGNoZWRfeGRwID09IDAp
Cj4+ICsJCWdvdG8gc2lnbmFsX3VzZWQ7Cj4+ICsKPj4gKwltc2doZHItPm1zZ19jb250cm9sID0g
JmN0bDsKPj4gKwllcnIgPSBzb2NrLT5vcHMtPnNlbmRtc2coc29jaywgbXNnaGRyLCAwKTsKPj4g
KwlpZiAodW5saWtlbHkoZXJyIDwgMCkpIHsKPj4gKwkJdnFfZXJyKCZudnEtPnZxLCAiRmFpbCB0
byBiYXRjaCBzZW5kaW5nIHBhY2tldHNcbiIpOwo+PiArCQlyZXR1cm47Cj4+ICsJfQo+PiArCj4+
ICtzaWduYWxfdXNlZDoKPj4gKwl2aG9zdF9uZXRfc2lnbmFsX3VzZWQobnZxKTsKPj4gKwludnEt
PmJhdGNoZWRfeGRwID0gMDsKPj4gK30KPj4gKwo+IEdpdmVuIGl0J3MgYWxsIHR1bi1zcGVjaWZp
YyBub3csIGhvdyBhYm91dCBqdXN0IGV4cG9ydGluZyB0YXBfc2VuZG1zZwo+IGFuZCBjYWxsaW5n
IHRoYXQ/IFdpbGwgZ2V0IHJpZCBvZiBzb21lIGluZGlyZWN0aW9uIHRvby4KPgoKWWVzIHdlIGNh
biBkbyBpdCBvbiB0b3AgaW4gdGhlIGZ1dHVyZS4KClRoYW5rcwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
