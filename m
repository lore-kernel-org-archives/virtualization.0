From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] VSOCK: The performance problem of vhost_vsock.
Date: Mon, 15 Oct 2018 10:33:08 +0800
Message-ID: <30d7c370-b206-cdac-dc85-53e9be1e1c63__2431.01949240572$1539570676$gmane$org@redhat.com>
References: <5BC3F0D4.60409@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5BC3F0D4.60409@huawei.com>
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
To: jiangyiwen <jiangyiwen@huawei.com>, stefanha@redhat.com
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MTDmnIgxNeaXpSAwOTo0Mywgamlhbmd5aXdlbiB3cm90ZToKPiBIaSBTdGVm
YW4gJiBBbGw6Cj4KPiBOb3cgSSBmaW5kIHZob3N0LXZzb2NrIGhhcyB0d28gcGVyZm9ybWFuY2Ug
cHJvYmxlbXMgZXZlbiBpZiBpdAo+IGlzIG5vdCBkZXNpZ25lZCBmb3IgcGVyZm9ybWFuY2UuCj4K
PiBGaXJzdCwgSSB0aGluayB2aG9zdC12c29jayBzaG91bGQgZmFzdGVyIHRoYW4gdmhvc3QtbmV0
IGJlY2F1c2UgaXQKPiBpcyBubyBUQ1AvSVAgc3RhY2ssIGJ1dCB0aGUgcmVhbCB0ZXN0IHJlc3Vs
dCB2aG9zdC1uZXQgaXMgNX4xMAo+IHRpbWVzIHRoYW4gdmhvc3QtdnNvY2ssIGN1cnJlbnRseSBJ
IGFtIGxvb2tpbmcgZm9yIHRoZSByZWFzb24uCgpUQ1AvSVAgaXMgbm90IGEgbXVzdCBmb3Igdmhv
c3QtbmV0LgoKSG93IGRvIHlvdSB0ZXN0IGFuZCBjb21wYXJlIHRoZSBwZXJmb3JtYW5jZT8KClRo
YW5rcwoKPiBTZWNvbmQsIHZob3N0LXZzb2NrIG9ubHkgc3VwcG9ydHMgdHdvIHZxcyh0eCBhbmQg
cngpLCB0aGF0IG1lYW5zCj4gaWYgbXVsdGlwbGUgc29ja2V0cyBpbiB0aGUgZ3Vlc3Qgd2lsbCB1
c2UgdGhlIHNhbWUgdnEgdG8gdHJhbnNtaXQKPiB0aGUgbWVzc2FnZSBhbmQgZ2V0IHRoZSByZXNw
b25zZS4gU28gaWYgdGhlcmUgYXJlIG11bHRpcGxlIGFwcGxpY2F0aW9ucwo+IGluIHRoZSBndWVz
dCwgd2Ugc2hvdWxkIHN1cHBvcnQgIk11bHRpcXVldWUiIGZlYXR1cmUgZm9yIFZpcnRpby12c29j
ay4KPgo+IFN0ZWZhbiwgaGF2ZSB5b3UgZW5jb3VudGVyZWQgdGhlc2UgcHJvYmxlbXM/Cj4KPiBU
aGFua3MsCj4gWWl3ZW4uCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
