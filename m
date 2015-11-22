From: Marcel Apfelbaum <marcel@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Sun, 22 Nov 2015 19:04:32 +0200
Message-ID: <5651F5A0.5060400__36023.9258771346$1448343944$gmane$org@redhat.com>
References: <1446039327.3405.216.camel@infradead.org>
	<20151028155105-mutt-send-email-mst@redhat.com>
	<1446041609.3405.228.camel@infradead.org>
	<20151028161424-mutt-send-email-mst@redhat.com>
	<1446042754.3405.237.camel@infradead.org>
	<20151028175136-mutt-send-email-mst@redhat.com>
	<CALCETrWd7mK5bW2p_dvvjDRnqE31=ueAz5SAYKwY-PD5uZp76A@mail.gmail.com>
	<20151029104301-mutt-send-email-mst@redhat.com>
	<1446135536.3405.279.camel@infradead.org>
	<20151108120627-mutt-send-email-mst@redhat.com>
	<20151108114946.GG2255@suse.de> <5651BDC0.2040206@gmail.com>
	<1448207661.89124.50.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1448207661.89124.50.camel@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

T24gMTEvMjIvMjAxNSAwNTo1NCBQTSwgRGF2aWQgV29vZGhvdXNlIHdyb3RlOgo+IE9uIFN1biwg
MjAxNS0xMS0yMiBhdCAxNTowNiArMDIwMCwgTWFyY2VsIEFwZmVsYmF1bSB3cm90ZToKPj4KPj4K
Pj4gSSB0cmllZCB0byBnZW5lcmF0ZSBhIERNQVIgdGFibGUgdGhhdCBleGNsdWRlcyBzb21lIGRl
dmljZXMgZnJvbQo+PiBJT01NVSB0cmFuc2xhdGlvbiwgaG93ZXZlciBpdCBkb2VzIG5vdCBoZWxw
Lgo+Pgo+PiBUaGUgcmVhc29uIGlzLCBhcyBmYXIgYXMgSSB1bmRlcnN0YW5kLCB0aGF0IExpbnV4
IGtlcm5lbCBkb2VzCj4+IG5vdCBhbGxvdyBhbnkgZGV2aWNlIGJlaW5nIG91dHNpZGUgYW4gSU9N
TVUgc2NvcGUgaWYgdGhlCj4+IGlvbW11IGtlcm5lbCBvcHRpb24gaXMgYWN0aXZhdGVkLgo+Pgo+
PiBEb2VzIGFueWJvZHkga25vdyBpZiBpdCBpcyAiYnkgZGVzaWduIiBvciBpcyBzaW1wbHkgYW4g
dW5jb21tb24KPj4gY29uZmlndXJhdGlvbj8KPj4gKHNvbWUgZGV2aWNlcyBpbiBhbiBJT01NVSBz
Y29wZSwgd2hpbGUgb3RoZXJzIG91dHNpZGUgKmFueSogSU9NTVUKPj4gc2NvcGUpCj4KPiBUaGF0
J3MgYSBrZXJuZWwgYnVnIGluIHRoZSB3YXkgaXQgaGFuZGxlcyBwZXItZGV2aWNlIERNQSBvcGVy
YXRpb25zLiBPcgo+IG1vcmUgdG8gdGhlIHBvaW50LCBpbiB0aGUgd2F5IGl0IGRvZXNuJ3Qg4oCU
IHRoZSBub24tdHJhbnNsYXRlZCBkZXZpY2VzCj4gZW5kIHVwIGJlaW5nIHBvaW50ZWQgdG8gdGhl
IGludGVsX2RtYV9vcHMgZGVzcGl0ZSB0aGUgZmFjdCB0aGV5Cj4gc2hvdWxkbid0IGJlLiBJJ20g
d29ya2luZyBvbiB0aGF0Li4uCj4KCkhpIERhdmlkLApUaGFuayB5b3UgZm9yIHRoZSBmYXN0IHJl
c3BvbnNlLgoKU2FkbHkgSSBhbSBub3QgZmFtaWxpYXIgd2l0aCB0aGUgRE1BL0lPTU1VIGNvZGUg
dG8gY29udHJpYnV0ZQp3aXRoIGEgc2FuZSBpZGVhLCBidXQgSSdsbCBnbGFkbHkgdGVzdCBpdC4K
SWYgeW91IGxhY2sgdGhlIHRpbWUgYW5kIGhhdmUgYW4gaWRlYSB0byBzaGFyZSwgSSBjYW4gZ2l2
ZSBpdCBhIHRyeSB0aG91Z2guCgpUaGFua3MsCk1hcmNlbAoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
