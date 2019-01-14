From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Mon, 14 Jan 2019 10:50:02 +0100
Message-ID: <20190114095002.GA29874__46216.4240344011$1547693254$gmane$org@lst.de>
References: <20190110134433.15672-1-joro@8bytes.org>
	<5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
	<20190111091502.GC5825@8bytes.org>
	<38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, jon.grimm@amd.com, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Joerg Roedel <joro@8bytes.org>, "Michael S . Tsirkin" <mst@redhat.com>, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uLCBKYW4gMTQsIDIwMTkgYXQgMDU6NDE6NTZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+IE9uIDIwMTkvMS8xMSDkuIvljYg1OjE1LCBKb2VyZyBSb2VkZWwgd3JvdGU6Cj4+IE9u
IEZyaSwgSmFuIDExLCAyMDE5IGF0IDExOjI5OjMxQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+PiBKdXN0IHdvbmRlciBpZiBteSB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QgSU9NTVVfUExB
VEZPUk0gbXVzdCBiZSBzZXQgZm9yCj4+PiBhbGwgdmlydGlvIGRldmljZXMgdW5kZXIgQU1ELVNF
ViBndWVzdHM/Cj4+IFllcywgdGhhdCBpcyBjb3JyZWN0LiBFbXVsYXRlZCBETUEgY2FuIG9ubHkg
aGFwcGVuIG9uIHRoZSBTV0lPVExCCj4+IGFwZXJ0dXJlLCBiZWNhdXNlIHRoYXQgbWVtb3J5IGlz
IG5vdCBlbmNyeXB0ZWQuIFRoZSBndWVzdCBib3VuY2VzIHRoZQo+PiBkYXRhIHRoZW4gdG8gaXRz
IGVuY3J5cHRlZCBtZW1vcnkuCj4+Cj4+IFJlZ2FyZHMsCj4+Cj4+IAlKb2VyZwo+Cj4KPiBUaGFu
a3MsIGhhdmUgeW91IHRlc3RlZCB2aG9zdC1uZXQgaW4gdGhpcyBjYXNlLiBJIHN1c3BlY3QgaXQg
bWF5IG5vdCB3b3JrCgpXaGljaCBicmluZ3MgbWUgYmFjayB0byBteSBwZXQgcGV2ZWUgdGhhdCB3
ZSBuZWVkIHRvIHRha2UgYWN0aW9ucwp0aGF0IHZpcnRpbyB1c2VzIHRoZSBwcm9wZXIgZG1hIG1h
cHBpbmcgQVBJIGJ5IGRlZmF1bHQgd2l0aCBxdWlya3MKZm9yIGxlZ2FjeSBjYXNlcy4gIFRoZSBt
YWdpYyBieXBhc3MgaXQgdXNlcyBpcyBqdXN0IGNhdXNpbmcgcHJvYmxlbXMKb3ZlciBwcm9ibGVt
cy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
