From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] vhost: re-introducing metadata acceleration through
	kernel virtual address
Date: Mon, 9 Sep 2019 10:30:20 +0800
Message-ID: <868bfaed-ede4-6da8-0247-af2a03ea121d__28833.7314663053$1567996265$gmane$org@redhat.com>
References: <20190905122736.19768-1-jasowang@redhat.com>
	<20190905122736.19768-3-jasowang@redhat.com>
	<20190908063618-mutt-send-email-mst@kernel.org>
	<1cb5aa8d-6213-5fce-5a77-fcada572c882@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1cb5aa8d-6213-5fce-5a77-fcada572c882@redhat.com>
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
Cc: aarcange@redhat.com, Christoph Hellwig <hch@infradead.org>, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-mm@kvack.org, jglisse@redhat.com, jgg@mellanox.com, David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOS85IOS4iuWNiDEwOjE4LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4KPj4+IE9uIGEg
ZWxkZXIgQ1BVIFNhbmR5IEJyaWRnZSB3aXRob3V0IFNNQVAgc3VwcG9ydC4gVFggUFBTIGRvZXNu
J3Qgc2VlCj4+PiBhbnkgZGlmZmVyZW5jZS4KPj4gV2h5IGlzIG5vdCBLYWJ5IExha2Ugd2l0aCBT
TUFQIG9mZiB0aGUgc2FtZSBhcyBTYW5keSBCcmlkZ2U/Cj4KPgo+IEkgZG9uJ3Qga25vdywgSSBn
dWVzcyBpdCB3YXMgYmVjYXVzZSB0aGUgYXRvbWljIGlzIGwgCgoKU29ycnksIEkgbWVhbnQgYXRv
bWljIGNvc3RzIGxlc3MgZm9yIEthYnkgTGFrZS4KClRoYW5rcwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
