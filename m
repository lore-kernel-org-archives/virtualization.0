Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57019C4332F
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 16:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9B3F60E8D;
	Mon, 21 Feb 2022 16:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W91HnPr7I8P8; Mon, 21 Feb 2022 16:38:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 33F51605B2;
	Mon, 21 Feb 2022 16:38:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09DEDC0021;
	Mon, 21 Feb 2022 16:38:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96BEEC0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7049A60E53
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:38:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ic46nN2htyyy
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:38:26 +0000 (UTC)
X-Greylist: delayed 00:22:51 by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC98A600CC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=TgPy+0hQ7EBbGq8vtnHqmcyd0qHlGi+RFv1Qqzppcws=; b=R5kxVrzvFrVwbL8xpFNWFQMBmw
 w7vw6hddfMQF6y4ogxagzKCIjL8r8WehX4XRfIGnDsB++ebxYboyKYQuDUSVsNKqFr5pLo34RwHia
 JltcSJi2zgUe4D/3Nu97SIEv7g80Vnx6z5ZITvuR++XZ4B2bhgWqiT9Fkq+rewn4XyZa8nbH79PVQ
 9yvv1x0+eAnW64ZAkohjNJxcH0x9R21EBbqti19QO1rc+QG11lskWBuX8rAi8zXTcDOy1zr+Q3Mwa
 GEuPhzwpo9p7p88IVKJX/Zbpb/7npco6NjjKrKHLIB0Ix+f7TZfpeodwLXKmua/6pS5NTZPJlY9MK
 JCrvJm2w==;
Received: from [2001:8b0:10b:1::3ae] (helo=u3832b3a9db3152.ant.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMBLP-001ybj-I1; Mon, 21 Feb 2022 16:15:23 +0000
Message-ID: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
Subject: [PATCH] tools/virtio: Test virtual address range detection
From: David Woodhouse <dwmw2@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Feb 2022 16:15:22 +0000
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6297176059702785647=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6297176059702785647==
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-fGUf7S7FAdPjhZuMpLB6"


--=-fGUf7S7FAdPjhZuMpLB6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As things stand, an application which wants to use vhost with a trivial
1:1 mapping of its virtual address space is forced to jump through hoops
to detect what the address range might be. The VHOST_SET_MEM_TABLE ioctl
helpfully doesn't fail immediately; you only get a failure *later* when
you attempt to set the backend, if the table *could* map to an address
which is out of range, even if no out-of-range address is actually
being referenced.

Since userspace is growing workarounds for this lovely kernel API, let's
ensure that we have a regression test that does things basically the same
way as https://gitlab.com/openconnect/openconnect/-/commit/443edd9d8826
does.

This is untested as I can't actually get virtio_test to work at all; it
just seems to deadlock on a spinlock. But it's getting the right answer
for the virtio range on x86_64 at least.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
---

Please, tell me I don't need to do this. But if I *do*, it needs a
regression test in-kernel.

 tools/virtio/virtio_test.c | 109 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 3 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index cb3f29c09aff..e40eeeb05b71 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -11,6 +11,7 @@
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <sys/mman.h>
 #include <fcntl.h>
 #include <stdbool.h>
 #include <linux/virtio_types.h>
@@ -124,6 +125,109 @@ static void vq_info_add(struct vdev_info *dev, int nu=
m)
 	dev->nvqs++;
 }
=20
+/*
+ * This is awful. The kernel doesn't let us just ask for a 1:1 mapping of
+ * our virtual address space; we have to *know* the minimum and maximum
+ * addresses. We can't test it directly with VHOST_SET_MEM_TABLE because
+ * that actually succeeds, and the failure only occurs later when we try
+ * to use a buffer at an address that *is* valid, but our memory table
+ * *could* point to addresses that aren't. Ewww.
+ *
+ * So... attempt to work out what TASK_SIZE is for the kernel we happen
+ * to be running on right now...
+ */
+
+static int testaddr(unsigned long addr)
+{
+	void *res =3D mmap((void *)addr, getpagesize(), PROT_NONE,
+			 MAP_FIXED|MAP_ANONYMOUS, -1, 0);
+	if (res =3D=3D MAP_FAILED) {
+		if (errno =3D=3D EEXIST || errno =3D=3D EINVAL)
+			return 1;
+
+		/* We get ENOMEM for a bad virtual address */
+		return 0;
+	}
+	/* It shouldn't actually succeed without either MAP_SHARED or
+	 * MAP_PRIVATE in the flags, but just in case... */
+	munmap((void *)addr, getpagesize());
+	return 1;
+}
+
+static int find_vmem_range(struct vhost_memory *vmem)
+{
+	const unsigned long page_size =3D getpagesize();
+	unsigned long top;
+	unsigned long bottom;
+
+	top =3D -page_size;
+
+	if (testaddr(top)) {
+		vmem->regions[0].memory_size =3D top;
+		goto out;
+	}
+
+	/* 'top' is the lowest address known *not* to work */
+	bottom =3D top;
+	while (1) {
+		bottom >>=3D 1;
+		bottom &=3D ~(page_size - 1);
+		assert(bottom);
+
+		if (testaddr(bottom))
+			break;
+		top =3D bottom;
+	}
+
+	/* It's often a page or two below the boundary */
+	top -=3D page_size;
+	if (testaddr(top)) {
+		vmem->regions[0].memory_size =3D top;
+		goto out;
+	}
+	top -=3D page_size;
+	if (testaddr(top)) {
+		vmem->regions[0].memory_size =3D top;
+		goto out;
+	}
+
+	/* Now, bottom is the highest address known to work,
+	   and we must search between it and 'top' which is
+	   the lowest address known not to. */
+	while (bottom + page_size !=3D top) {
+		unsigned long test =3D bottom + (top - bottom) / 2;
+		test &=3D ~(page_size - 1);
+
+		if (testaddr(test)) {
+			bottom =3D test;
+			continue;
+		}
+		test -=3D page_size;
+		if (testaddr(test)) {
+			vmem->regions[0].memory_size =3D test;
+			goto out;
+		}
+
+		test -=3D page_size;
+		if (testaddr(test)) {
+			vmem->regions[0].memory_size =3D test;
+			goto out;
+		}
+		top =3D test;
+	}
+	vmem->regions[0].memory_size =3D bottom;
+
+ out:
+	vmem->regions[0].guest_phys_addr =3D page_size;
+	vmem->regions[0].userspace_addr =3D page_size;
+	printf("Detected virtual address range 0x%lx-0x%lx\n",
+	       page_size,
+	       (unsigned long)(page_size + vmem->regions[0].memory_size));
+
+	return 0;
+}
+
+
 static void vdev_info_init(struct vdev_info* dev, unsigned long long featu=
res)
 {
 	int r;
@@ -143,9 +247,8 @@ static void vdev_info_init(struct vdev_info* dev, unsig=
ned long long features)
 	memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
                           sizeof dev->mem->regions[0]);
 	dev->mem->nregions =3D 1;
-	dev->mem->regions[0].guest_phys_addr =3D (long)dev->buf;
-	dev->mem->regions[0].userspace_addr =3D (long)dev->buf;
-	dev->mem->regions[0].memory_size =3D dev->buf_size;
+	r =3D find_vmem_range(dev->mem);
+	assert(r >=3D 0);
 	r =3D ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
 	assert(r >=3D 0);
 }



--=-fGUf7S7FAdPjhZuMpLB6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjIwMjIxMTYxNTIyWjAvBgkqhkiG9w0BCQQxIgQgYNS4JFWX
Ln89wuSKw+GG+rgBzckCw29s2BPafBow1Howgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCvGWh3yBKoh+qoUML9OvzQwpDncUOBgW2y
qCzPaMjQKs7re6puszC+MNzILHRVNeu+DKs8I5N4Ok3iFzJl7m6DkV3Ih2eTa2pc1ErMYqspTQd/
jflCcxtwLOWPVzyenOoLKgy2qYmT9zt980gbI9aBfm8+nH9WFon+aFXlo95e7CVL5RL57gx3AZhu
lhukJ0kXqzt9P48DQQigwfUkBTJt4/e5uPaUU6GYIP9vfuYk9JsgFsEBGf6uxDarpzaqfK35Yefp
oHgp6TitK9lsh0Mb0duCxopoNO3us6Qic63k7rZPREwD/eSGhSfnz5ybc8Zvcpo7FnYBOTU1EI/L
XqsvgoTo/FsCbxFlkuzRRdCV9DZ2Rp6aFDPxnFEtpdk3oXrDQ6Dw8tY5DHsMIY/kae/hiRmmsemQ
mlhMvqs6BVV5csjZbVtBctuVB6kWwFhk82ZSCbKQRf0hhjiXot/6eB9zvp0mcgN9Bpteau+wiYb/
litPtHc6YJbLrHWAKcdIWZzSXGmkVe6u4zqoqVbJ9ggjh3Dk9OixpAQ2lqJFunOK1kUQgG4dlfY8
EvjBolnY08dY3LJTRzFO1fiqVpS9U89cSGw2xUmY2FurwJCB/kJ6HcfQ8CWl4WbbKAjyTK4+XbmY
LC4ThtUTUhAWcY05uFTNyVx5KzJan3cZkAn3wa/7qgAAAAAAAA==


--=-fGUf7S7FAdPjhZuMpLB6--


--===============6297176059702785647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6297176059702785647==--

