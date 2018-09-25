From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v9 0/6] net: vhost: improve performance when
	enable busyloop
Date: Tue, 25 Sep 2018 10:21:03 +0800
Message-ID: <08f01199-ad0f-446c-0bcf-187dc31f2b42__3424.3447859355$1537841954$gmane$org@redhat.com>
References: <1536493887-2637-1-git-send-email-xiangxia.m.yue@gmail.com>
	<CAMDZJNWk7UThRus4fZeznx4SvWjtj38ruC6Y_xPc1LV95EfLnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMDZJNWk7UThRus4fZeznx4SvWjtj38ruC6Y_xPc1LV95EfLnA@mail.gmail.com>
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
To: Tonghao Zhang <xiangxia.m.yue@gmail.com>, mst@redhat.com, makita.toshiaki@lab.ntt.co.jp
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDnmnIgyM+aXpSAyMTo0OCwgVG9uZ2hhbyBaaGFuZyB3cm90ZToKPiBPbiBT
dW4sIFNlcCA5LCAyMDE4IGF0IDc6NTIgUE0gPHhpYW5neGlhLm0ueXVlQGdtYWlsLmNvbT4gd3Jv
dGU6Cj4+IEZyb206IFRvbmdoYW8gWmhhbmcgPHhpYW5neGlhLm0ueXVlQGdtYWlsLmNvbT4KPj4K
Pj4gVGhpcyBwYXRjaGVzIGltcHJvdmUgdGhlIGd1ZXN0IHJlY2VpdmUgcGVyZm9ybWFuY2UuCj4+
IE9uIHRoZSBoYW5kbGVfdHggc2lkZSwgd2UgcG9sbCB0aGUgc29jayByZWNlaXZlIHF1ZXVlCj4+
IGF0IHRoZSBzYW1lIHRpbWUuIGhhbmRsZV9yeCBkbyB0aGF0IGluIHRoZSBzYW1lIHdheS4KPj4K
Pj4gRm9yIG1vcmUgcGVyZm9ybWFuY2UgcmVwb3J0LCBzZWUgcGF0Y2ggNCwgNSwgNgo+Pgo+PiBU
b25naGFvIFpoYW5nICg2KToKPj4gICAgbmV0OiB2aG9zdDogbG9jayB0aGUgdnFzIG9uZSBieSBv
bmUKPj4gICAgbmV0OiB2aG9zdDogcmVwbGFjZSBtYWdpYyBudW1iZXIgb2YgbG9jayBhbm5vdGF0
aW9uCj4+ICAgIG5ldDogdmhvc3Q6IGZhY3RvciBvdXQgYnVzeSBwb2xsaW5nIGxvZ2ljIHRvIHZo
b3N0X25ldF9idXN5X3BvbGwoKQo+PiAgICBuZXQ6IHZob3N0OiBhZGQgcnggYnVzeSBwb2xsaW5n
IGluIHR4IHBhdGgKPj4gICAgbmV0OiB2aG9zdDogZGlzYWJsZSByeCB3YWtldXAgZHVyaW5nIHR4
IGJ1c3lwb2xsCj4+ICAgIG5ldDogdmhvc3Q6IG1ha2UgYnVzeWxvb3BfaW50ciBtb3JlIGFjY3Vy
YXRlCj4+Cj4+ICAgZHJpdmVycy92aG9zdC9uZXQuYyAgIHwgMTYzICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tCj4+ICAgZHJpdmVycy92aG9zdC92aG9z
dC5jIHwgIDI0ICsrKy0tLS0tCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMDggaW5zZXJ0aW9ucygr
KSwgNzkgZGVsZXRpb25zKC0pCj4+Cj4+IC0tCj4+IDEuOC4zLjEKPj4KPiBwaW5nID8KCkhJIFRv
bmdoYW86CgpBcyBEYXZpZCBwb2ludGVkIG91dCwgd2Ugb25seSByZWNlaXZlIGZpcnN0IDQgcGF0
Y2hlcy4gWW91IHByb2JhYmx5IG5lZWQgCnRvIHJlc2VuZCB0aGUgc2VyaWVzLgoKVGhhbmtzCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
