From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/virtio: don't leak bo on drm_gem_object_init failure
Date: Thu,  6 Apr 2017 17:59:40 +0200
Message-ID: <20170406155941.458-1-kraxel__17214.8140416995$1491494407$gmane$org@redhat.com>
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
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, liqiang6-s@360.cn, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

UmVwb3J0ZWQtYnk6IOadjuW8uiA8bGlxaWFuZzYtc0AzNjAuY24+ClNpZ25lZC1vZmYtYnk6IEdl
cmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS92aXJ0
aW8vdmlydGdwdV9vYmplY3QuYyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS92aXJ0aW8v
dmlydGdwdV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV9vYmplY3Qu
YwppbmRleCAxNDgzZGFlLi42ZjY2YjczIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdmly
dGlvL3ZpcnRncHVfb2JqZWN0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3ZpcnRpby92aXJ0Z3B1
X29iamVjdC5jCkBAIC04MSw4ICs4MSwxMCBAQCBpbnQgdmlydGlvX2dwdV9vYmplY3RfY3JlYXRl
KHN0cnVjdCB2aXJ0aW9fZ3B1X2RldmljZSAqdmdkZXYsCiAJCXJldHVybiAtRU5PTUVNOwogCXNp
emUgPSByb3VuZHVwKHNpemUsIFBBR0VfU0laRSk7CiAJcmV0ID0gZHJtX2dlbV9vYmplY3RfaW5p
dCh2Z2Rldi0+ZGRldiwgJmJvLT5nZW1fYmFzZSwgc2l6ZSk7Ci0JaWYgKHJldCAhPSAwKQorCWlm
IChyZXQgIT0gMCkgeworCQlrZnJlZShibyk7CiAJCXJldHVybiByZXQ7CisJfQogCWJvLT5kdW1i
ID0gZmFsc2U7CiAJdmlydGlvX2dwdV9pbml0X3R0bV9wbGFjZW1lbnQoYm8sIHBpbm5lZCk7CiAK
LS0gCjIuOS4zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
