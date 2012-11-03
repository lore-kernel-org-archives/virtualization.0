From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 6/9] =?UTF-8?q?virtio=5Fmmio:=20Cast=20&resources[1].start=20?=
	=?UTF-8?q?to=20=E2=80=98unsigned=20int=20*=E2=80=99=20to=20rid=20compiler=20?=
	=?UTF-8?q?warning?=
Date: Sat,  3 Nov 2012 23:02:27 +0100
Message-ID: <1351980150-24145-7-git-send-email-lee.jones__11061.0771611848$1351982547$gmane$org@linaro.org>
References: <1351980150-24145-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1351980150-24145-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

ZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYzogSW4gZnVuY3Rpb24g4oCYdm1fY21kbGluZV9z
ZXTigJk6CmRyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmM6NTM1OjQ6IHdhcm5pbmc6IGZvcm1h
dCDigJgldeKAmSBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUg4oCYdW5zaWduZWQgaW50ICrigJks
IGJ1dCBhcmd1bWVudCA0IGhhcyB0eXBlIOKAmHJlc291cmNlX3NpemVfdCAq4oCZIFstV2Zvcm1h
dF0KCkNjOiBSdXN0eSBSdXNzZWxsIDxydXN0eUBydXN0Y29ycC5jb20uYXU+CkNjOiB2aXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlv
LmMgfCAgICAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX21taW8uYwppbmRleCA2YjFiN2UxLi4wNzdlOWNhIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jCisrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19t
bWlvLmMKQEAgLTUzMSw3ICs1MzEsNyBAQCBzdGF0aWMgaW50IHZtX2NtZGxpbmVfc2V0KGNvbnN0
IGNoYXIgKmRldmljZSwKIAlyZXNvdXJjZXNbMF0uZW5kID0gbWVtcGFyc2UoZGV2aWNlLCAmc3Ry
KSAtIDE7CiAKIAlwcm9jZXNzZWQgPSBzc2NhbmYoc3RyLCAiQCVsbGk6JXUlbjolZCVuIiwKLQkJ
CSZiYXNlLCAmcmVzb3VyY2VzWzFdLnN0YXJ0LCAmY29uc3VtZWQsCisJCQkmYmFzZSwgKHVuc2ln
bmVkIGludCAqKSZyZXNvdXJjZXNbMV0uc3RhcnQsICZjb25zdW1lZCwKIAkJCSZ2bV9jbWRsaW5l
X2lkLCAmY29uc3VtZWQpOwogCiAJaWYgKHByb2Nlc3NlZCA8IDIgfHwgcHJvY2Vzc2VkID4gMyB8
fCBzdHJbY29uc3VtZWRdKQotLSAKMS43LjkuNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
