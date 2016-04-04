From: Jeff Mahoney <jeffm@suse.com>
Subject: =?UTF-8?Q?[PATCH]_virtio:_fix_=22warning:_=e2=80=98queue=e2=80=99_m?=
	=?UTF-8?Q?ay_be_used_uninitialized=22?=
Date: Mon, 4 Apr 2016 14:14:19 -0400
Message-ID: <5702AEFB.5090701@suse.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

VGhpcyBmaXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmc6CmRyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmM6MTAzMjo1OiB3YXJuaW5nOiDigJhxdWV1ZeKAmSBtYXkgYmUgdXNlZAp1bmluaXRpYWxp
emVkIGluIHRoaXMgZnVuY3Rpb24KClRoZSBjb25kaXRpb25zIHRoYXQgZ292ZXJuIHdoZW4gcXVl
dWUgaXMgc2V0IGFyZW4ndCBhcHBhcmVudCB0byBnY2MuCgpTZXR0aW5nIHF1ZXVlID0gTlVMTCBj
bGVhcnMgdGhlIHdhcm5pbmcuCgpTaWduZWQtb2ZmLWJ5OiBKZWZmIE1haG9uZXkgPGplZmZtQHN1
c2UuY29tPgotLS0KCiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgICAgMiArLQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgotLS0gYS9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCisrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
QEAgLTEwMDYsNyArMTAwNiw3IEBAIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0
cXVldWUKIAljb25zdCBjaGFyICpuYW1lKQogewogCXN0cnVjdCB2aXJ0cXVldWUgKnZxOwotCXZv
aWQgKnF1ZXVlOworCXZvaWQgKnF1ZXVlID0gTlVMTDsKIAlkbWFfYWRkcl90IGRtYV9hZGRyOwog
CXNpemVfdCBxdWV1ZV9zaXplX2luX2J5dGVzOwogCXN0cnVjdCB2cmluZyB2cmluZzsKCi0tIApK
ZWZmIE1haG9uZXkKU1VTRSBMYWJzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
