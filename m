From: sjur.brandeland@stericsson.com
Subject: [PATCH] virtio: Don't access device data after unregistration.
Date: Mon,  3 Sep 2012 15:50:42 +0200
Message-ID: <1346680242-5717-1-git-send-email-sjur.brandeland__30881.1800591231$1346681611$gmane$org@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: =?UTF-8?q?Sjur=20Br=C3=A6ndeland?= <sjurbren@gmail.com>, "Guzman Lugo,
	Fernadndo" <fernando.lugo@ti.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, =?UTF-8?q?Sjur=20Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

RnJvbTogU2p1ciBCcsOmbmRlbGFuZCA8c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPgoK
Rml4IHBhbmljIGluIHZpcnRpby5jIHdoZW4gQ09ORklHX0RFQlVHX1NMQUIgaXMgc2V0LgpVc2Ug
ZGV2aWNlX2RlbCgpIGFuZCBwdXRfZGV2aWNlKCkgaW5zdGVhZCBvZgpkZXZpY2VfdW5yZWdpc3Rl
cigpLCBhbmQgYWNjZXNzIGRldmljZSBkYXRhIGJlZm9yZQpjYWxsaW5nIHB1dF9kZXZpY2UoKS4K
CgpTaWduZWQtb2ZmLWJ5OiBTanVyIEJyw6ZuZGVsYW5kIDxzanVyLmJyYW5kZWxhbmRAc3Rlcmlj
c3Nvbi5jb20+CmNjOiBHdXptYW4gTHVnbywgRmVybmFkbmRvIDxmZXJuYW5kby5sdWdvQHRpLmNv
bT4KY2M6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+CmNjOiB2aXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpjYzogT2hhZCBCZW4tQ29oZW4gPG9oYWRA
d2l6ZXJ5LmNvbT4KLS0tCiBkcml2ZXJzL3ZpcnRpby92aXJ0aW8uYyB8ICAgIDMgKystCiAxIGZp
bGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpby5jCmluZGV4
IGMzYjNmN2YuLjcxZWFjZDEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpby5jCisr
KyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpby5jCkBAIC0yMjUsOCArMjI1LDkgQEAgRVhQT1JUX1NZ
TUJPTF9HUEwocmVnaXN0ZXJfdmlydGlvX2RldmljZSk7CiAKIHZvaWQgdW5yZWdpc3Rlcl92aXJ0
aW9fZGV2aWNlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpCiB7Ci0JZGV2aWNlX3VucmVnaXN0
ZXIoJmRldi0+ZGV2KTsKKwlkZXZpY2VfZGVsKCZkZXYtPmRldik7CiAJaWRhX3NpbXBsZV9yZW1v
dmUoJnZpcnRpb19pbmRleF9pZGEsIGRldi0+aW5kZXgpOworCXB1dF9kZXZpY2UoJmRldi0+ZGV2
KTsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKHVucmVnaXN0ZXJfdmlydGlvX2RldmljZSk7CiAKLS0g
CjEuNy41LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
