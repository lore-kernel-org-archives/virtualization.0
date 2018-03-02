From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 1/2] virtio-net: re enable XDP_REDIRECT for
	mergeable buffer
Date: Fri, 2 Mar 2018 12:20:50 +0800
Message-ID: <8c57f936-8fea-e2b8-ef8e-1dda81e190a6@redhat.com>
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
	<1519874345-10235-2-git-send-email-jasowang@redhat.com>
	<20180301153441-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180301153441-mutt-send-email-mst@kernel.org>
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
Cc: netdev@vger.kernel.org, brouer@redhat.com, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDPmnIgwMeaXpSAyMTozNiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IE9uIFRodSwgTWFyIDAxLCAyMDE4IGF0IDExOjE5OjA0QU0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+IFhEUF9SRURJUkVDVCBzdXBwb3J0IGZvciBtZXJnZWFibGUgYnVmZmVyIHdhcyByZW1v
dmVkIHNpbmNlIGNvbW1pdAo+PiA3MzI0ZjUzOTliMDYgKCJ2aXJ0aW9fbmV0OiBkaXNhYmxlIFhE
UF9SRURJUkVDVCBpbiByZWNlaXZlX21lcmdlYWJsZSgpCj4+IGNhc2UiKS4gVGhpcyBpcyBiZWNh
dXNlIHdlIGRvbid0IHJlc2VydmUgZW5vdWdoIHRhaWxyb29tIGZvciBzdHJ1Y3QKPj4gc2tiX3No
YXJlZF9pbmZvIHdoaWNoIGJyZWFrcyBYRFAgYXNzdW1wdGlvbi4gT3RoZXIgY29tcGxhaW50cyBh
cmUsIHRoZQo+PiBjb21wbGV4IGxpbmVhcml6ZSBsb2dpYyBhbmQgRVdNQSBlc3RpbWF0aW9uIG1h
eSBpbmNyZWFzZSB0aGUKPj4gcG9zc2liaWxpdHkgb2YgbGluZWFyaXppbmcuCj4+Cj4+IFNpZ25l
ZC1vZmYtYnk6IEphc29uIFdhbmc8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiBIb3cgYWJvdXQgcmVw
b3N0aW5nIGp1c3QgdGhpcyBwYXRjaCBmb3IgbmV0PyBJdCdzIHByZXR0eSBzbWFsbAo+IGFuZCB0
aGlzIHdheSB3ZSBkb24ndCBoYXZlIGJyb2tlbiByZWRpcmVjdCB0aGVyZS4KPiBQcm9iYWJseSBr
ZWVwaW5nIHRoZSBsaW5lYXJpemUgaW4gaGVyZSB0byByZWR1Y2UgdGhlCj4gYW1vdW50IG9mIGNo
YW5nZXMuCj4KCkxvb2tzIHBvc3NpYmxlLCBsZXQgbWUgcG9zdCBhIHZlcnNpb24gZm9yIG5ldC4K
ClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
