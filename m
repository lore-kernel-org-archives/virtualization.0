From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2 RFC] virtio-spec: flexible configuration layout
Date: Wed, 16 Nov 2011 10:28:52 +1030
Message-ID: <87aa7xos3n.fsf@rustcorp.com.au>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com>
	<1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com>
	<8739e7uy87.fsf@rustcorp.com.au>
	<20111102233110.GA20289@redhat.com>
	<20111108214021.GA4538@redhat.com>
	<20111109195901.GA28155@redhat.com> <1320870287.3730.6.camel@lappy>
	<20111109205208.GA28599@redhat.com>
	<1320872248.3730.11.camel@lappy> <87aa83qoao.fsf@rustcorp.com.au>
	<CA+1xoqeH3ErNCELD+NoJHz=eH6FtxersUffoJSj0yQx2o=4g0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+1xoqeH3ErNCELD+NoJHz=eH6FtxersUffoJSj0yQx2o=4g0g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Wang Sheng-Hui <shhuiw@gmail.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, penberg@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCAxMSBOb3YgMjAxMSAwOTozOToxMyArMDIwMCwgU2FzaGEgTGV2aW4gPGxldmluc2Fz
aGE5MjhAZ21haWwuY29tPiB3cm90ZToKPiBPbiBGcmksIE5vdiAxMSwgMjAxMSBhdCA2OjI0IEFN
LCBSdXN0eSBSdXNzZWxsIDxydXN0eUBydXN0Y29ycC5jb20uYXU+IHdyb3RlOgo+ID4gKDIpIFRo
ZXJlJ3Mgbm8gaHVnZSB3aW4gaW4ga2VlcGluZyB0aGUgc2FtZSBsYXlvdXQuIMKgTGV0J3MgbWFr
ZSBzb21lCj4gPiDCoCDCoGNsZWFudXBzLiDCoFRoZXJlIGFyZSBtb3JlIHVzZXJzIGFoZWFkIG9m
IHVzIHRoZW4gYmVoaW5kIHVzIChJCj4gPiDCoCDCoGhvcGUhKS4KPiAKPiBBY3R1YWxseSwgaWYg
d2UgYWxyZWFkeSBkbyBjbGVhbnVwcywgaGVyZSBhcmUgdHdvIG1vcmUgc3VnZ2VzdGlvbnM6Cj4g
Cj4gMS4gTWFrZSA2NGJpdCBmZWF0dXJlcyBhIG9uZSBiaWcgNjRiaXQgYmxvY2ssIGluc3RlYWQg
b2YgaGF2aW5nIDMyYml0cwo+IGluIG9uZSBwbGFjZSBhbmQgMzIgaW4gYW5vdGhlci4KPiAyLiBS
ZW1vdmUgdGhlIHJlc2VydmVkIGZpZWxkcyBvdXQgb2YgdGhlIGNvbmZpZyAodGhlIG9uZXMgdGhh
dCB3ZXJlCj4gY2F1c2VkIGJ5IG1vdmluZyB0aGUgSVNSIGFuZCB0aGUgbm90aWZpY2F0aW9ucyBv
dXQpLgoKWWVzLCB0aG9zZSB3ZXJlIGV4YWN0bHkgd2hhdCBJIHdhcyB0aGlua2luZy4gIEkgbGVm
dCBpdCB2YWd1ZSBiZWNhdXNlCnRoZXJlIG1pZ2h0IGJlIG90aGVycyB5b3UgY2FuIHNlZSBpZiB3
ZSdyZSBwcmVwYXJlZCB0byBhYmFuZG9uIHRoZQpjdXJyZW50IGZvcm1hdC4KCkNoZWVycywKUnVz
dHkuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
