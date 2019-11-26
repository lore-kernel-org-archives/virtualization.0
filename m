From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
Date: Tue, 26 Nov 2019 19:45:27 +0100
Message-ID: <20191126184527.GA10481__5337.43165885738$1574793945$gmane$org@lst.de>
References: <20191114124646.74790-1-pasic@linux.ibm.com>
 <20191119121022.03aed69a.pasic@linux.ibm.com>
 <20191119080420-mutt-send-email-mst@kernel.org>
 <20191122140827.0ead345c.pasic@linux.ibm.com>
 <1ec7c229-6c4f-9351-efda-ed2df20f95f6@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1ec7c229-6c4f-9351-efda-ed2df20f95f6@amd.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-s390@vger.kernel.org, "Kalra, Ashish" <Ashish.Kalra@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, Janosch Frank <frankja@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

T24gU2F0LCBOb3YgMjMsIDIwMTkgYXQgMDk6Mzk6MDhBTSAtMDYwMCwgVG9tIExlbmRhY2t5IHdy
b3RlOgo+IElkZWFsbHksIGhhdmluZyBhIHBvb2wgb2Ygc2hhcmVkIHBhZ2VzIGZvciBETUEsIG91
dHNpZGUgb2Ygc3RhbmRhcmQKPiBTV0lPVExCLCBtaWdodCBiZSBhIGdvb2QgdGhpbmcuICBPbiB4
ODYsIFNXSU9UTEIgcmVhbGx5IHNlZW1zIGdlYXJlZAo+IHRvd2FyZHMgZGV2aWNlcyB0aGF0IGRv
bid0IHN1cHBvcnQgNjQtYml0IERNQS4gSWYgYSBkZXZpY2Ugc3VwcG9ydHMgNjQtYml0Cj4gRE1B
IHRoZW4gaXQgY2FuIHVzZSBzaGFyZWQgcGFnZXMgdGhhdCByZXNpZGUgYW55d2hlcmUgdG8gcGVy
Zm9ybSB0aGUgRE1BCj4gYW5kIGJvdW5jZSBidWZmZXJpbmcuIEkgd29uZGVyIGlmIHRoZSBTV0lP
VExCIHN1cHBvcnQgY2FuIGJlIGVuaGFuY2VkIHRvCj4gc3VwcG9ydCBzb21ldGhpbmcgbGlrZSB0
aGlzLCB1c2luZyB0b2RheSdzIGxvdyBTV0lPVExCIGJ1ZmZlcnMgaWYgdGhlIERNQQo+IG1hc2sg
bmVjZXNzaXRhdGVzIGl0LCBvdGhlcndpc2UgdXNpbmcgYSBkeW5hbWljYWxseSBzaXplZCBwb29s
IG9mIHNoYXJlZAo+IHBhZ2VzIHRoYXQgY2FuIGxpdmUgYW55d2hlcmUuCgpJIHRoaW5rIHRoYXQg
Y2FuIGJlIGRvbmUgcmVsYXRpdmVseSBlYXNpbHkuICBJJ3ZlIGFjdHVhbGx5IGJlZW4gdGhpbmtp
bmcKb2YgbXVsdGlwbGUgcG9vbCBzdXBwb3J0IGZvciBhIHdo0ZZsZSB0byByZXBsYWNlIHRoZSBi
b3VuY2UgYnVmZmVyaW5nCmluIHRoZSBibG9jayBsYXllciBmb3IgSVNBIGRldmljZXMgKDI0LWJp
dCBhZGRyZXNzaW5nKS4KCkkndmUgYWxzbyBiZWVuIGxvb2tpbmcgaW50byBhIGRtYV9hbGxvY19w
YWdlcyBpbnRlcmZhY2UgdG8gaGVscCBwZW9wbGUKanVzdCBhbGxvY2F0ZSBwYWdlcyB0aGF0IGFy
ZSBhbHdheXMgZG1hIGFkZHJlc3NhYmxlLCBidXQgZG9uJ3QgbmVlZAphIGNvaGVyZW50IGFsbG9j
YXRpb24uICBNeSBsYXN0IHZlcnNpb24gSSBzaGFyZWQgaXMgaGVyZToKCmh0dHA6Ly9naXQuaW5m
cmFkZWFkLm9yZy91c2Vycy9oY2gvbWlzYy5naXQvc2hvcnRsb2cvcmVmcy9oZWFkcy9kbWFfYWxs
b2NfcGFnZXMKCkJ1dCBpdCB0dXJucyBvdXQgdGhpcyBzdGlsbCBkb2Vzbid0IHdvcmsgd2l0aCBT
RVYgYXMgd2UnbGwgYWx3YXlzCmJvdW5jZS4gIEFuZCBJJ3ZlIGJlZW4ga2luZGEgbG9zdCBvbiBm
aWd1cmluZyBvdXQgYSB3YXkgaG93IHRvCmFsbG9jYXRlIHVuZW5jcnlwdGVkIHBhZ2VzIHRoYXQg
d2Ugd2UgY2FuIGZlZWQgaW50byB0aGUgbm9ybWFsCmRtYV9tYXBfcGFnZSAmIGNvIGludGVyZmFj
ZXMgZHVlIHRvIHRoZSBtYWdpYyBlbmNyeXB0aW9uIGJpdCBpbgp0aGUgYWRkcmVzcy4gIEkgZ3Vl
c3Mgd2UgY291bGQgaGF2ZSBhIGZhbGxiYWNrIHBhdGggaW4gdGhlIG1hcHBpbmcKcGF0aCBhbmQg
anVzdCB1bmNvbmRpdGlvbmFsbHkgY2xlYXIgdGhhdCBiaXQgaW4gdGhlIGRtYV90b19waHlzCnBh
dGguCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
