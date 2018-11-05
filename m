From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/1] vhost: add per-vq worker thread
Date: Mon, 5 Nov 2018 10:53:42 +0800
Message-ID: <fe79c7fd-1e9f-dab8-3c65-8151181c922c__47809.7948166125$1541386307$gmane$org@redhat.com>
References: <20181102160710.3741-1-v.mayatskih@gmail.com>
	<20181102160710.3741-2-v.mayatskih@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181102160710.3741-2-v.mayatskih@gmail.com>
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
To: Vitaly Mayatskikh <v.mayatskih@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTgvMTEvMyDkuIrljYgxMjowNywgVml0YWx5IE1heWF0c2tpa2ggd3JvdGU6Cj4gKwo+
ICtzdGF0aWMgaW50IHZob3N0X3ZxX3BvbGxfc3RhcnQoc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAq
dnEpCj4gK3sKPiArCWlmICghdnEtPndvcmtlcikgewo+ICsJCXZxLT53b3JrZXIgPSBrdGhyZWFk
X2NyZWF0ZSh2aG9zdF92cV93b3JrZXIsIHZxLCAidmhvc3QtJWQvJWkiLAo+ICsJCQkJCSAgICB2
cS0+ZGV2LT5waWQsIHZxLT5pbmRleCk7Cj4gKwkJaWYgKElTX0VSUih2cS0+d29ya2VyKSkgewo+
ICsJCQlpbnQgcmV0ID0gUFRSX0VSUih2cS0+d29ya2VyKTsKPiArCj4gKwkJCXByX2VycigiJXM6
IGNhbid0IGNyZWF0ZSB2cSB3b3JrZXI6ICVkXG4iLCBfX2Z1bmNfXywKPiArCQkJICAgICAgIHJl
dCk7Cj4gKwkJCXZxLT53b3JrZXIgPSBOVUxMOwo+ICsJCQlyZXR1cm4gcmV0Owo+ICsJCX0KPiAr
CX0KPiArCXZob3N0X3dvcmtfaW5pdCgmdnEtPndvcmssIHZob3N0X3ZxX3BvbGxfc3RhcnRfd29y
ayk7Cj4gKwl2aG9zdF92cV93b3JrX3F1ZXVlKHZxLCAmdnEtPndvcmspOwo+ICsJcmV0dXJuIDA7
Cj4gK30KPiArCgoKSSB3b25kZXIgd2hldGhlciBvciBub3QgaXQncyBiZXR0ZXIgdG8gYWxsb3cg
dGhlIGRldmljZSB0byBzcGVjaWZpYyB0aGUgCndvcmtlciBoZXJlIGluc3RlYWQgb2YgZm9yY2lu
ZyBhIHBlciB2cSB3b3JrZXIgbW9kZWwuIFRoZW4gd2UgY2FuIGtlZXAgCnRoZSBiZWhhdmlvciBv
ZiBleGlzdCBpbXBsZW1lbnRhdGlvbiBhbmQgZG8gb3B0aW1pemF0aW9uIG9uIHRvcD8KClRoYW5r
cwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
