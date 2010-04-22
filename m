From: David Stevens <dlstevens@us.ibm.com>
Subject: Re: [PATCH v4] Add mergeable RX bufs support to vhost
Date: Thu, 22 Apr 2010 11:59:55 -0600
Message-ID: <OF4D87C139.FBE240E7-ON8825770D.0061E3C3-8825770D.0062DEBC@us.ibm.com>
References: <20100422174349.GA1926@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_mixed 0062DEBC8825770D_="
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20100422174349.GA1926@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

--=_mixed 0062DEBC8825770D_=
Content-Type: text/plain; charset="US-ASCII"

"Michael S. Tsirkin" <mst@redhat.com> wrote on 04/22/2010 10:43:49 AM:

> On Mon, Apr 19, 2010 at 03:12:19PM -0700, David L Stevens wrote:
> > This patch adds the mergeable RX buffers feature to vhost.
> > 
> > Signed-off-by: David L Stevens <dlstevens@us.ibm.com>
> 
> BTW, which userspace should I use for testing this?

        I use the qemu-kvm patch to your git tree that I posted
a while back (also attached). And it needs your TUNSETVNETHDRSIZE
ioctl in the kernel as well. Also, I added the TUN ioctl
defines to /usr/include for this to pick up (it compiles, but
won't do the ioctl's without that); will get back
to that patch per your comments next.

[also correction: I said 10-20% guest to host, I meant host-to-guest
        (ie, the receiver side). h2g appears improved too, but not as
        much)]

                                                        +-DLS

--=_mixed 0062DEBC8825770D_=
Content-Type: application/octet-stream; name="qemu-MRXB-2.patch"
Content-Disposition: attachment; filename="qemu-MRXB-2.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtcnVOcCBxZW11LWt2bS5tc3QvaHcvdmhvc3RfbmV0LmMgcWVtdS1rdm0uZGxzL2h3L3Zo
b3N0X25ldC5jCi0tLSBxZW11LWt2bS5tc3QvaHcvdmhvc3RfbmV0LmMJMjAxMC0wMy0wMyAxMzoz
OTowNy4wMDAwMDAwMDAgLTA4MDAKKysrIHFlbXUta3ZtLmRscy9ody92aG9zdF9uZXQuYwkyMDEw
LTAzLTI5IDIwOjM3OjM0LjAwMDAwMDAwMCAtMDcwMApAQCAtNSw2ICs1LDcgQEAKICNpbmNsdWRl
IDxzeXMvaW9jdGwuaD4KICNpbmNsdWRlIDxsaW51eC92aG9zdC5oPgogI2luY2x1ZGUgPGxpbnV4
L3ZpcnRpb19yaW5nLmg+CisjaW5jbHVkZSA8bGludXgvaWZfdHVuLmg+CiAjaW5jbHVkZSA8bmV0
cGFja2V0L3BhY2tldC5oPgogI2luY2x1ZGUgPG5ldC9ldGhlcm5ldC5oPgogI2luY2x1ZGUgPG5l
dC9pZi5oPgpAQCAtMzgsMTUgKzM5LDYgQEAgdW5zaWduZWQgdmhvc3RfbmV0X2dldF9mZWF0dXJl
cyhzdHJ1Y3QgdgogCXJldHVybiBmZWF0dXJlczsKIH0KIAotdm9pZCB2aG9zdF9uZXRfYWNrX2Zl
YXR1cmVzKHN0cnVjdCB2aG9zdF9uZXQgKm5ldCwgdW5zaWduZWQgZmVhdHVyZXMpCi17Ci0JbmV0
LT5kZXYuYWNrZWRfZmVhdHVyZXMgPSBuZXQtPmRldi5iYWNrZW5kX2ZlYXR1cmVzOwotCWlmIChm
ZWF0dXJlcyAmICgxIDw8IFZJUlRJT19GX05PVElGWV9PTl9FTVBUWSkpCi0JCW5ldC0+ZGV2LmFj
a2VkX2ZlYXR1cmVzIHw9ICgxIDw8IFZJUlRJT19GX05PVElGWV9PTl9FTVBUWSk7Ci0JaWYgKGZl
YXR1cmVzICYgKDEgPDwgVklSVElPX1JJTkdfRl9JTkRJUkVDVF9ERVNDKSkKLQkJbmV0LT5kZXYu
YWNrZWRfZmVhdHVyZXMgfD0gKDEgPDwgVklSVElPX1JJTkdfRl9JTkRJUkVDVF9ERVNDKTsKLX0K
LQogc3RhdGljIGludCB2aG9zdF9uZXRfZ2V0X2ZkKFZMQU5DbGllbnRTdGF0ZSAqYmFja2VuZCkK
IHsKIAlzd2l0Y2ggKGJhY2tlbmQtPmluZm8tPnR5cGUpIHsKQEAgLTU4LDYgKzUwLDI1IEBAIHN0
YXRpYyBpbnQgdmhvc3RfbmV0X2dldF9mZChWTEFOQ2xpZW50U3QKIAl9CiB9CiAKK3ZvaWQgdmhv
c3RfbmV0X2Fja19mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfbmV0ICpuZXQsIHVuc2lnbmVkIGZlYXR1
cmVzKQoreworCWludCB2bmV0X2hkcl9zeiA9IHNpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9oZHIp
OworCisJbmV0LT5kZXYuYWNrZWRfZmVhdHVyZXMgPSBuZXQtPmRldi5iYWNrZW5kX2ZlYXR1cmVz
OworCWlmIChmZWF0dXJlcyAmICgxIDw8IFZJUlRJT19GX05PVElGWV9PTl9FTVBUWSkpCisJCW5l
dC0+ZGV2LmFja2VkX2ZlYXR1cmVzIHw9ICgxIDw8IFZJUlRJT19GX05PVElGWV9PTl9FTVBUWSk7
CisJaWYgKGZlYXR1cmVzICYgKDEgPDwgVklSVElPX1JJTkdfRl9JTkRJUkVDVF9ERVNDKSkKKwkJ
bmV0LT5kZXYuYWNrZWRfZmVhdHVyZXMgfD0gKDEgPDwgVklSVElPX1JJTkdfRl9JTkRJUkVDVF9E
RVNDKTsKKwlpZiAoZmVhdHVyZXMgJiAoMSA8PCBWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGKSkgewor
CQluZXQtPmRldi5hY2tlZF9mZWF0dXJlcyB8PSAoMSA8PCBWSVJUSU9fTkVUX0ZfTVJHX1JYQlVG
KTsKKwkJdm5ldF9oZHJfc3ogPSBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfaGRyX21yZ19yeGJ1
Zik7CisJfQorI2lmZGVmIFRVTlNFVFZORVRIRFJTWgorCWlmIChpb2N0bCh2aG9zdF9uZXRfZ2V0
X2ZkKG5ldC0+dmMpLCBUVU5TRVRWTkVUSERSU1osICZ2bmV0X2hkcl9zeikgPCAwKQorCQlwZXJy
b3IoIlRVTlNFVFZORVRIRFJTWiIpOworI2VuZGlmIC8qIFRVTlNFVFZORVRIRFJTWiAqLworfQor
CiBzdHJ1Y3Qgdmhvc3RfbmV0ICp2aG9zdF9uZXRfaW5pdChWTEFOQ2xpZW50U3RhdGUgKmJhY2tl
bmQsIGludCBkZXZmZCkKIHsKIAlpbnQgcjsKZGlmZiAtcnVOcCBxZW11LWt2bS5tc3QvaHcvdmly
dGlvLW5ldC5jIHFlbXUta3ZtLmRscy9ody92aXJ0aW8tbmV0LmMKLS0tIHFlbXUta3ZtLm1zdC9o
dy92aXJ0aW8tbmV0LmMJMjAxMC0wMy0wMyAxMzozOTowNy4wMDAwMDAwMDAgLTA4MDAKKysrIHFl
bXUta3ZtLmRscy9ody92aXJ0aW8tbmV0LmMJMjAxMC0wMy0yOSAxNjoxNTo0Ni4wMDAwMDAwMDAg
LTA3MDAKQEAgLTIxMSwxMiArMjExLDE2IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19uZXRfc2V0X2Zl
YXR1cmVzKFZpcnQKICAgICBuLT5tZXJnZWFibGVfcnhfYnVmcyA9ICEhKGZlYXR1cmVzICYgKDEg
PDwgVklSVElPX05FVF9GX01SR19SWEJVRikpOwogCiAgICAgaWYgKG4tPmhhc192bmV0X2hkcikg
eworCXN0cnVjdCB2aG9zdF9uZXQgKnZob3N0X25ldCA9IHRhcF9nZXRfdmhvc3RfbmV0KG4tPm5p
Yy0+bmMucGVlcik7CisKICAgICAgICAgdGFwX3NldF9vZmZsb2FkKG4tPm5pYy0+bmMucGVlciwK
ICAgICAgICAgICAgICAgICAgICAgICAgIChmZWF0dXJlcyA+PiBWSVJUSU9fTkVUX0ZfR1VFU1Rf
Q1NVTSkgJiAxLAogICAgICAgICAgICAgICAgICAgICAgICAgKGZlYXR1cmVzID4+IFZJUlRJT19O
RVRfRl9HVUVTVF9UU080KSAmIDEsCiAgICAgICAgICAgICAgICAgICAgICAgICAoZmVhdHVyZXMg
Pj4gVklSVElPX05FVF9GX0dVRVNUX1RTTzYpICYgMSwKICAgICAgICAgICAgICAgICAgICAgICAg
IChmZWF0dXJlcyA+PiBWSVJUSU9fTkVUX0ZfR1VFU1RfRUNOKSAgJiAxLAogICAgICAgICAgICAg
ICAgICAgICAgICAgKGZlYXR1cmVzID4+IFZJUlRJT19ORVRfRl9HVUVTVF9VRk8pICAmIDEpOwor
CWlmICh2aG9zdF9uZXQpCisJCXZob3N0X25ldF9hY2tfZmVhdHVyZXModmhvc3RfbmV0LCBmZWF0
dXJlcyk7CiAgICAgfQogfQogCg==

--=_mixed 0062DEBC8825770D_=--
