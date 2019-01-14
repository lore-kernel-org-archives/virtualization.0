From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Mon, 14 Jan 2019 17:41:56 +0800
Message-ID: <38bcbd46-674c-348a-cbd6-66bd431e986a__4187.1304311373$1547693242$gmane$org@redhat.com>
References: <20190110134433.15672-1-joro@8bytes.org>
	<5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
	<20190111091502.GC5825@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190111091502.GC5825@8bytes.org>
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
To: Joerg Roedel <joro@8bytes.org>
Cc: Jens Axboe <axboe@kernel.dk>, jon.grimm@amd.com, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jfehlig@suse.com, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMS8xMSDkuIvljYg1OjE1LCBKb2VyZyBSb2VkZWwgd3JvdGU6Cj4gT24gRnJpLCBK
YW4gMTEsIDIwMTkgYXQgMTE6Mjk6MzFBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4gSnVz
dCB3b25kZXIgaWYgbXkgdW5kZXJzdGFuZGluZyBpcyBjb3JyZWN0IElPTU1VX1BMQVRGT1JNIG11
c3QgYmUgc2V0IGZvcgo+PiBhbGwgdmlydGlvIGRldmljZXMgdW5kZXIgQU1ELVNFViBndWVzdHM/
Cj4gWWVzLCB0aGF0IGlzIGNvcnJlY3QuIEVtdWxhdGVkIERNQSBjYW4gb25seSBoYXBwZW4gb24g
dGhlIFNXSU9UTEIKPiBhcGVydHVyZSwgYmVjYXVzZSB0aGF0IG1lbW9yeSBpcyBub3QgZW5jcnlw
dGVkLiBUaGUgZ3Vlc3QgYm91bmNlcyB0aGUKPiBkYXRhIHRoZW4gdG8gaXRzIGVuY3J5cHRlZCBt
ZW1vcnkuCj4KPiBSZWdhcmRzLAo+Cj4gCUpvZXJnCgoKVGhhbmtzLCBoYXZlIHlvdSB0ZXN0ZWQg
dmhvc3QtbmV0IGluIHRoaXMgY2FzZS4gSSBzdXNwZWN0IGl0IG1heSBub3Qgd29yawoKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
