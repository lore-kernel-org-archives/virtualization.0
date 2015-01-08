From: =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Subject: [PATCH] virtio_blk: fix blk_mq_init_queue() error handling
Date: Thu,  8 Jan 2015 11:05:40 +0100
Message-ID: <1420711540-17425-1-git-send-email-j__16114.2445788302$1420716257$gmane$org@bitron.ch>
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
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

YmxrX21xX2luaXRfcXVldWUoKSByZXR1cm5zIEVSUl9QVFIoKSBvbiBmYWlsdXJlLCBub3QgTlVM
TC4KClNpZ25lZC1vZmYtYnk6IErDvHJnIEJpbGxldGVyIDxqQGJpdHJvbi5jaD4KLS0tCiBkcml2
ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL3ZpcnRp
b19ibGsuYyBiL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCmluZGV4IDdlZjdjMDkuLmIxYjVj
NzUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCisrKyBiL2RyaXZlcnMv
YmxvY2svdmlydGlvX2Jsay5jCkBAIC02MzgsOCArNjM4LDggQEAgc3RhdGljIGludCB2aXJ0Ymxr
X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQogCQlnb3RvIG91dF9wdXRfZGlzazsK
IAogCXEgPSB2YmxrLT5kaXNrLT5xdWV1ZSA9IGJsa19tcV9pbml0X3F1ZXVlKCZ2YmxrLT50YWdf
c2V0KTsKLQlpZiAoIXEpIHsKLQkJZXJyID0gLUVOT01FTTsKKwlpZiAoSVNfRVJSKHEpKSB7CisJ
CWVyciA9IFBUUl9FUlIocSk7CiAJCWdvdG8gb3V0X2ZyZWVfdGFnczsKIAl9CiAKLS0gCjIuMi4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
