From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v2 5/6] drm/virtio: drop fencing in
	virtio_gpu_resource_create_ioctl
Date: Thu, 31 Jan 2019 11:50:25 +0100
Message-ID: <def6f74a-9817-1bc0-0c4e-b0e2a93a7eb2__33871.024700214$1548967525$gmane$org@tronnes.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
	<20190130094338.14203-6-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190130094338.14203-6-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

CgpEZW4gMzAuMDEuMjAxOSAxMC40Mywgc2tyZXYgR2VyZCBIb2ZmbWFubjoKPiBUaGVyZSBpcyBu
byBuZWVkIHRvIHdhaXQgZm9yIGNvbXBsZXRpb24gaGVyZS4KPiAKPiBUaGUgaG9zdCB3aWxsIHBy
b2Nlc3MgY29tbWFuZHMgaW4gc3VibWl0IG9yZGVyLCBzbyBjb21tYW5kcyBjYW4KPiByZWZlcmVu
Y2UgdGhlIG5ldyByZXNvdXJjZSBqdXN0IGZpbmUgZXZlbiB3aGVuIHF1ZXVlZCB1cCBiZWZvcmUK
PiBjb21wbGV0aW9uLgo+IAo+IE9uIHRoZSBndWVzdCBzaWRlIHRoZXJlIGlzIG5vIG5lZWQgdG8g
d2FpdCBmb3IgY29tcGxldGlvbiB0b28uICBXaGljaAo+IGJ0dyBpcyBkaWZmZXJlbnQgZnJvbSBy
ZXNvdXJjZSBkZXN0cm95LCB3aGVyZSB3ZSBoYXZlIHRvIG1ha2Ugc3VyZSB0aGUKPiBob3N0IGhh
cyBzZWVuIHRoZSBkZXN0cm95IGFuZCB0aHVzIGRvZXNuJ3QgdXNlIGl0IGFueSBtb3JlIGJlZm9y
ZQo+IHJlbGVhc2luZyB0aGUgcGFnZXMgYmFja2luZyB0aGUgcmVzb3VyY2UuCj4gCj4gU2lnbmVk
LW9mZi1ieTogR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+Cj4gLS0tCgpBY2tlZC1i
eTogTm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
