From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 06/11] tuntap: split out XDP logic
Date: Mon, 10 Sep 2018 11:43:35 +0800
Message-ID: <c2e48fa5-eeb7-12eb-335f-c4e1e9943bec@redhat.com>
References: <20180906040526.22518-1-jasowang@redhat.com>
	<20180906040526.22518-7-jasowang@redhat.com>
	<20180906131703-mutt-send-email-mst@kernel.org>
	<84ae17c1-f34b-610d-a5a1-ba8dce1732f3@redhat.com>
	<20180907101606-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180907101606-mutt-send-email-mst@kernel.org>
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

CgpPbiAyMDE45bm0MDnmnIgwN+aXpSAyMjoxNiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IE9uIEZyaSwgU2VwIDA3LCAyMDE4IGF0IDExOjI5OjM0QU0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+Pj4gKwkJaWYgKGFjdCAhPSBYRFBfUEFTUykKPj4+PiArCQkJZ290byBvdXQ7Cj4+PiBs
aWtlbHk/Cj4+IEl0IGRlcGVuZHMgb24gdGhlIFhEUCBwcm9ncmFtLCBzbyBJIHRlbmQgbm90IHRv
IHVzZSBpdC4KPiBQb2ludCBpcyBYRFBfUEFTUyBpcyBhbHJlYWR5IHNsb3cuCj4KCk9rLgoKVGhh
bmtzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
