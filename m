From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] vhost: re-introducing metadata acceleration through
	kernel virtual address
Date: Mon, 9 Sep 2019 15:23:58 +0800
Message-ID: <4ee20058-0beb-111c-6750-556965423f04__44533.7185099319$1568013858$gmane$org@redhat.com>
References: <20190905122736.19768-1-jasowang@redhat.com>
	<20190905122736.19768-3-jasowang@redhat.com>
	<20190908063618-mutt-send-email-mst@kernel.org>
	<1cb5aa8d-6213-5fce-5a77-fcada572c882@redhat.com>
	<20190909004504-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190909004504-mutt-send-email-mst@kernel.org>
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

Ck9uIDIwMTkvOS85IOS4i+WNiDEyOjQ1LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+PiBT
aW5jZSBpZHggY2FuIGJlIHNwZWN1bGF0ZWQsIEkgZ3Vlc3Mgd2UgbmVlZCBhcnJheV9pbmRleF9u
b3NwZWMgaGVyZT8KPj4gU28gd2UgaGF2ZQo+Pgo+PiBBQ1FVSVJFKG1tdV9sb2NrKQo+Pgo+PiBn
ZXQgaWR4Cj4+Cj4+IFJFTEVBU0UobW11X2xvY2spCj4+Cj4+IEFDUVVJUkUobW11X2xvY2spCj4+
Cj4+IHJlYWQgYXJyYXlbaWR4XQo+Pgo+PiBSRUxFQVNFKG1tdV9sb2NrKQo+Pgo+PiBUaGVuIEkg
dGhpbmsgaWR4IGNhbid0IGJlIHNwZWN1bGF0ZWQgY29uc2lkZXIgd2UndmUgcGFzc2VkIFJFTEVB
U0UgKwo+PiBBQ1FVSVJFPwo+IEkgZG9uJ3QgdGhpbmsgbWVtb3J5IGJhcnJpZXJzIGhhdmUgYW55
dGhpbmcgdG8gZG8gd2l0aCBzcGVjdWxhdGlvbiwKPiB0aGV5IGFyZSBhcmNoaXRlY3R1cmFsLgo+
CgpPaCByaWdodC4gTGV0IG1lIGFkZCBhcnJheV9pbmRleF9ub3NwZWMoKSBpbiBuZXh0IHZlcnNp
b24uCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
