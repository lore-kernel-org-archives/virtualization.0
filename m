From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm: ttm: virtio-gpu: dma-buf: Constify ttm_place
	structures.
Date: Mon, 03 Jul 2017 11:48:01 +0200
Message-ID: <1499075281.771.10.camel__10178.5054117956$1499075298$gmane$org@redhat.com>
References: <25a189402a516a0142d9a4412da0a597c660a96a.1498981093.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <25a189402a516a0142d9a4412da0a597c660a96a.1498981093.git.arvind.yadav.cs@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

T24gU3VuLCAyMDE3LTA3LTAyIGF0IDEzOjExICswNTMwLCBBcnZpbmQgWWFkYXYgd3JvdGU6Cj4g
dHRtX3BsYWNlIGFyZSBub3Qgc3VwcG9zZWQgdG8gY2hhbmdlIGF0IHJ1bnRpbWUuIEFsbCBmdW5j
dGlvbnMKPiB3b3JraW5nIHdpdGggdHRtX3BsYWNlIHByb3ZpZGVkIGJ5IDxkcm0vdHRtL3R0bV9w
bGFjZW1lbnQuaD4gd29yawo+IHdpdGggY29uc3QgdHRtX3BsYWNlLiBTbyBtYXJrIHRoZSBub24t
Y29uc3Qgc3RydWN0cyBhcyBjb25zdC4KPiAKPiBGaWxlIHNpemUgYmVmb3JlOgo+IMKgwqDCoHRl
eHQJwqDCoMKgZGF0YQnCoMKgwqDCoGJzcwnCoMKgwqDCoGRlYwnCoMKgwqDCoGhleAkKPiBmaWxl
bmFtZQo+IMKgwqDCoDIzMTUJwqDCoMKgwqAxODQJwqDCoMKgwqDCoMKgMAnCoMKgwqAyNDk5CcKg
wqDCoMKgOWMzCj4gZHJpdmVycy9ncHUvZHJtL3ZpcnRpby92aXJ0Z3B1X3R0bS5vCj4gCj4gRmls
ZSBzaXplIEFmdGVyIGFkZGluZyAnY29uc3QnOgo+IMKgwqDCoHRleHQJwqDCoMKgZGF0YQnCoMKg
wqDCoGJzcwnCoMKgwqDCoGRlYwnCoMKgwqDCoGhleAkKPiBmaWxlbmFtZQo+IMKgwqDCoDIzNDcJ
wqDCoMKgwqAxNTIJwqDCoMKgwqDCoMKgMAnCoMKgwqAyNDk5CcKgwqDCoMKgOWMzCj4gZHJpdmVy
cy9ncHUvZHJtL3ZpcnRpby92aXJ0Z3B1X3R0bS5vCj4gCj4gU2lnbmVkLW9mZi1ieTogQXJ2aW5k
IFlhZGF2IDxhcnZpbmQueWFkYXYuY3NAZ21haWwuY29tPgoKcHVzaGVkIHRvIGRybS1taXNjLW5l
eHQgKHF4bCBwYXRjaCB0b28pLgoKY2hlZXJzLAogIEdlcmQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
