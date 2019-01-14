From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Mon, 14 Jan 2019 20:41:37 +0800
Message-ID: <ac6d83d8-02de-dbdf-e309-3a1115642d50__38206.7763749093$1547693286$gmane$org@redhat.com>
References: <20190110134433.15672-1-joro@8bytes.org>
	<5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
	<20190111091502.GC5825@8bytes.org>
	<38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
	<20190114095002.GA29874@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190114095002.GA29874@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, jon.grimm@amd.com, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Joerg Roedel <joro@8bytes.org>, "Michael S . Tsirkin" <mst@redhat.com>, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMS8xNCDkuIvljYg1OjUwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBN
b24sIEphbiAxNCwgMjAxOSBhdCAwNTo0MTo1NlBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBPbiAyMDE5LzEvMTEg5LiL5Y2INToxNSwgSm9lcmcgUm9lZGVsIHdyb3RlOgo+Pj4gT24gRnJp
LCBKYW4gMTEsIDIwMTkgYXQgMTE6Mjk6MzFBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+
PiBKdXN0IHdvbmRlciBpZiBteSB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QgSU9NTVVfUExBVEZP
Uk0gbXVzdCBiZSBzZXQgZm9yCj4+Pj4gYWxsIHZpcnRpbyBkZXZpY2VzIHVuZGVyIEFNRC1TRVYg
Z3Vlc3RzPwo+Pj4gWWVzLCB0aGF0IGlzIGNvcnJlY3QuIEVtdWxhdGVkIERNQSBjYW4gb25seSBo
YXBwZW4gb24gdGhlIFNXSU9UTEIKPj4+IGFwZXJ0dXJlLCBiZWNhdXNlIHRoYXQgbWVtb3J5IGlz
IG5vdCBlbmNyeXB0ZWQuIFRoZSBndWVzdCBib3VuY2VzIHRoZQo+Pj4gZGF0YSB0aGVuIHRvIGl0
cyBlbmNyeXB0ZWQgbWVtb3J5Lgo+Pj4KPj4+IFJlZ2FyZHMsCj4+Pgo+Pj4gCUpvZXJnCj4+Cj4+
IFRoYW5rcywgaGF2ZSB5b3UgdGVzdGVkIHZob3N0LW5ldCBpbiB0aGlzIGNhc2UuIEkgc3VzcGVj
dCBpdCBtYXkgbm90IHdvcmsKPiBXaGljaCBicmluZ3MgbWUgYmFjayB0byBteSBwZXQgcGV2ZWUg
dGhhdCB3ZSBuZWVkIHRvIHRha2UgYWN0aW9ucwo+IHRoYXQgdmlydGlvIHVzZXMgdGhlIHByb3Bl
ciBkbWEgbWFwcGluZyBBUEkgYnkgZGVmYXVsdCB3aXRoIHF1aXJrcwo+IGZvciBsZWdhY3kgY2Fz
ZXMuICBUaGUgbWFnaWMgYnlwYXNzIGl0IHVzZXMgaXMganVzdCBjYXVzaW5nIHByb2JsZW1zCj4g
b3ZlciBwcm9ibGVtcy4KCgpZZXMsIEkgZnVsbHkgYWdyZWUgd2l0aCB5b3UuIFRoaXMgaXMgcHJv
YmFibHkgYW4gZXhhY3QgZXhhbXBsZSBvZiBzdWNoIApwcm9ibGVtLgoKVGhhbmtzCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
