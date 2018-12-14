From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net V2 4/4] vhost: log dirty page correctly
Date: Fri, 14 Dec 2018 10:43:03 +0800
Message-ID: <519ee6f7-06fc-ad49-03da-c096aeb24ced__31407.0550412454$1544755291$gmane$org@redhat.com>
References: <20181212100819.21295-1-jasowang@redhat.com>
	<20181212100819.21295-5-jasowang@redhat.com>
	<20181212092435-mutt-send-email-mst@kernel.org>
	<0239c220-e7ca-c08f-be26-eb9be63fced3@redhat.com>
	<20181213092930-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181213092930-mutt-send-email-mst@kernel.org>
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

Ck9uIDIwMTgvMTIvMTMg5LiL5Y2IMTA6MzEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4g
SnVzdCB0byBtYWtlIHN1cmUgSSB1bmRlcnN0YW5kIHRoaXMuIEl0IGxvb2tzIHRvIG1lIHdlIHNo
b3VsZDoKPj4KPj4gLSBhbGxvdyBwYXNzaW5nIEdJT1ZBLT5HUEEgdGhyb3VnaCBVQVBJCj4+Cj4+
IC0gY2FjaGUgR0lPVkEtPkdQQSBzb21ld2hlcmUgYnV0IHN0aWxsIHVzZSBHSU9WQS0+SFZBIGlu
IGRldmljZSBJT1RMQiBmb3IKPj4gcGVyZm9ybWFuY2UKPj4KPj4gSXMgdGhpcyB3aGF0IHlvdSBz
dWdnZXN0Pwo+Pgo+PiBUaGFua3MKPiBOb3QgcmVhbGx5LiBXZSBhbHJlYWR5IGhhdmUgR1BBLT5I
VkEsIHNvIEkgc3VnZ2VzdGVkIGEgZmxhZyB0byBwYXNzCj4gR0lPVkEtPkdQQSBpbiB0aGUgSU9U
TEIuCj4KPiBUaGlzIGhhcyBhZHZhbnRhZ2VzIGZvciBzZWN1cml0eSBzaW5jZSBhIHNpbmdsZSB0
YWJsZSBuZWVkcwo+IHRoZW4gdG8gYmUgdmFsaWRhdGVkIHRvIGVuc3VyZSBndWVzdCBkb2VzIG5v
dCBjb3JydXB0Cj4gUUVNVSBtZW1vcnkuCj4KCkkgd29uZGVyIGhvdyBtdWNoIHdlIGNhbiBnYWlu
IHRocm91Z2ggdGhpcy4gQ3VycmVudGx5LCBxZW11IElPTU1VIGdpdmVzIApHSU9WQS0+R1BBIG1h
cHBpbmcsIGFuZCBxZW11IHZob3N0IGNvZGUgd2lsbCB0cmFuc2xhdGUgR1BBIHRvIEhWQSB0aGVu
IApwYXNzIEdJT1ZBLT5IVkEgdG8gdmhvc3QuIEl0IGxvb2tzIG5vIGRpZmZlcmVuY2UgdG8gbWUu
CgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
