From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
	VIRTIO_NET_F_STANDBY feature bit to virtio_net
Date: Tue, 26 Jun 2018 17:17:32 +0200
Message-ID: <20180626171732.5038f53f.cohuck__8496.32505928657$1530026135$gmane$org@redhat.com>
References: <CADGSJ22B39JiS14L0yCYQ720-fZcwyUt1wCX1YO-6Y9FhmDKZg@mail.gmail.com>
	<20180622053141-mutt-send-email-mst@kernel.org>
	<CADGSJ23SBEFJCD50K-F-Gt86Q1-i_6iHTmSSjdXDzNnnpWZ_oQ@mail.gmail.com>
	<CADGSJ22nLcz_XaJNzUUdpjQaJY8b5wZs=ohm=B7c2qf2K7_yGA@mail.gmail.com>
	<20180623002628-mutt-send-email-mst@kernel.org>
	<CADGSJ20td7b6He6S1PBSJjCq=bNvgqMGbOjiho2eeQm2pgpK3g@mail.gmail.com>
	<20180623012406-mutt-send-email-mst@kernel.org>
	<CADGSJ211pWKYnuuzcgUqJZiHU+=7H3oQSpp1TnE=+EBjkdmCSQ@mail.gmail.com>
	<CADGSJ22DX8=rNPY+gNS_q=LCYLR5ieoE7oD8p4+8AnpzQsWSCg@mail.gmail.com>
	<da144f8f-65cd-45d9-3c81-6c8ca1fb25fe@intel.com>
	<20180626044650-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180626044650-mutt-send-email-mst@kernel.org>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, konrad.wilk@oracle.com, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Venu Busireddy <venu.busireddy@oracle.com>, Netdev <netdev@vger.kernel.org>, boris.ostrovsky@oracle.com, aaron.f.brown@intel.com, Joao Martins <joao.m.martins@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCAyNiBKdW4gMjAxOCAwNDo1MDoyNSArMDMwMAoiTWljaGFlbCBTLiBUc2lya2luIiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgoKPiBPbiBNb24sIEp1biAyNSwgMjAxOCBhdCAxMDo1NDow
OUFNIC0wNzAwLCBTYW11ZHJhbGEsIFNyaWRoYXIgd3JvdGU6Cj4gPiA+ID4gPiA+IE1pZ2h0IG5v
dCBuZWNjZXNzYXJpbHkgYmUgc29tZXRoaW5nIHdyb25nLCBidXQgaXQncyB2ZXJ5IGxpbWl0ZWQg
dG8KPiA+ID4gPiA+ID4gcHJvaGliaXQgdGhlIE1BQyBvZiBWRiBmcm9tIGNoYW5naW5nIHdoZW4g
ZW5zbGF2ZWQgYnkgZmFpbG92ZXIuICAKPiA+ID4gPiA+IFlvdSBtZWFuIGd1ZXN0IGNoYW5naW5n
IE1BQz8gSSdtIG5vdCBzdXJlIHdoeSB3ZSBwcm9oaWJpdCB0aGF0LiAgCj4gPiA+ID4gSSB0aGlu
ayBTcmlkaGFyIGFuZCBKaXJpIG1pZ2h0IGJlIGJldHRlciBwZXJzb24gdG8gYW5zd2VyIGl0LiBN
eQo+ID4gPiA+IGltcHJlc3Npb24gd2FzIHRoYXQgc3luYydpbmcgdGhlIE1BQyBhZGRyZXNzIGNo
YW5nZSBiZXR3ZWVuIGFsbCAzCj4gPiA+ID4gZGV2aWNlcyBpcyBjaGFsbGVuZ2luZywgYXMgdGhl
IGZhaWxvdmVyIGRyaXZlciB1c2VzIE1BQyBhZGRyZXNzIHRvCj4gPiA+ID4gbWF0Y2ggbmV0X2Rl
dmljZSBpbnRlcm5hbGx5LiAgCj4gPiAKPiA+IFllcy4gVGhlIE1BQyBhZGRyZXNzIGlzIGFzc2ln
bmVkIGJ5IHRoZSBoeXBlcnZpc29yIGFuZCBpdCBuZWVkcyB0byBtYW5hZ2UgdGhlIG1vdmVtZW50
Cj4gPiBvZiB0aGUgTUFDIGJldHdlZW4gdGhlIFBGIGFuZCBWRi7CoCBBbGxvd2luZyB0aGUgZ3Vl
c3QgdG8gY2hhbmdlIHRoZSBNQUMgd2lsbCByZXF1aXJlCj4gPiBzeW5jaHJvbml6YXRpb24gYmV0
d2VlbiB0aGUgaHlwZXJ2aXNvciBhbmQgdGhlIFBGL1ZGIGRyaXZlcnMuIE1vc3Qgb2YgdGhlIFZG
IGRyaXZlcnMKPiA+IGRvbid0IGFsbG93IGNoYW5naW5nIGd1ZXN0IE1BQyB1bmxlc3MgaXQgaXMg
YSB0cnVzdGVkIFZGLiAgCj4gCj4gT0sgYnV0IGl0J3MgYSBwb2xpY3kgdGhpbmcuIE1heWJlIGl0
J3MgYSB0cnVzdGVkIFZGLiBXaG8ga25vd3M/Cj4gRm9yIGV4YW1wbGUgSSBjYW4gc2VlIGhvc3Qg
anVzdAo+IGZhaWxpbmcgVklSVElPX05FVF9DVFJMX01BQ19BRERSX1NFVCBpZiBpdCB3YW50cyB0
byBibG9jayBpdC4KPiBJJ20gbm90IHN1cmUgd2h5IFZJUlRJT19ORVRfRl9TVEFOREJZIGhhcyB0
byBibG9jayBpdCBpbiB0aGUgZ3Vlc3QuCj4gCgpTbywgd2hhdCBJIGdldCBmcm9tIHRoaXMgaXMg
dGhhdCBRRU1VIG5lZWRzIHRvIGJlIGFibGUgdG8gY29udHJvbCBhbGwKb2Ygc3RhbmRieSwgdXVp
ZCwgYW5kIG1hYyB0byBhY2NvbW1vZGF0ZSB0aGUgZGlmZmVyZW50IHNldHVwcwoocmVzcGVjdGl2
ZWx5IGhhdmUgbGlidmlydC9tYW5hZ2VtZW50IHNvZnR3YXJlIHNldCBpdCB1cCkuIElzIHRoZSBo
b3N0CmFibGUgdG8gZmluZCBvdXQgcmVzcGVjdGl2ZWx5IGRlZmluZSB3aGV0aGVyIGEgVkYgaXMg
dHJ1c3RlZD8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
