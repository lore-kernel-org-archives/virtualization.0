From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Re: kernel BUG at drivers/block/virtio_blk.c:172
Date: Mon, 10 Nov 2014 20:18:32 +0800
Message-ID: <CACVXFVOakGobOqJFAM=SZX+nkv9rf_R9y5h+jnTMgAnqWU_7fg@mail.gmail.com>
References: <54524D50.50509@kernel.dk> <54524D68.7080509@kernel.dk>
	<CACVXFVPVdTqJ7X6xokq-8X8CTh3A59xwGNdwTm+SW1dOB-xxLQ@mail.gmail.com>
	<alpine.LFD.2.00.1411101252110.24699@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113db20a39c7d205078029e7
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1411101252110.24699@localhost.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?UTF-8?B?THVrw6HFoSBDemVybmVy?= <lczerner@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--001a113db20a39c7d205078029e7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2014 at 7:59 PM, Luk=C3=A1=C5=A1 Czerner <lczerner@redhat.c=
om> wrote:
>
> Hi,
>
> so I encountered it again on 3.17.0-rc4. This output is from the
> run with your patch.
>
> I am using libvirt (virt-manager) to configure and run the virtual
> machine, but looking at the xml, I do not think it's passing
> 'scsi=3Doff' at all.
>
> Btw, that xfs file system is a root file system.
>
>
> [    3.667553] blk_recount_segments: 1-0-1 vcnt-0 segs-128
> [    3.668692] blk_recount_segments: 1-0-1 vcnt-0 segs-128
> [    3.669897] blk_recount_segments: 1-0-1 vcnt-0 segs-128
> [    3.671083] blk_recount_segments: 1-0-1 vcnt-0 segs-128

Hamm, I should have used bi_phys_segments to decide if
merge is needed, and attached patch should fix the problem.


Thanks,
Ming Lei

--001a113db20a39c7d205078029e7
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-block-blk-merge-fix-blk_recount_segments.patch"
Content-Disposition: attachment;
	filename="0001-block-blk-merge-fix-blk_recount_segments.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i2bsotkl0

RnJvbSBiY2I0ZjQxMWMyM2UxMTRmN2M3N2MwODU4ZDdmNzhmNTBmZGE2OGU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaW5nIExlaSA8dG9tLmxlaW1pbmdAZ21haWwuY29tPgpEYXRl
OiBNb24sIDEwIE5vdiAyMDE0IDIwOjEwOjI0ICswODAwClN1YmplY3Q6IFtQQVRDSF0gYmxvY2sv
YmxrLW1lcmdlOiBmaXggYmxrX3JlY291bnRfc2VnbWVudHMKCmJpby0+YmlfcGh5c19zZWdtZW50
cyBzaG91bGQgYmUgdXNlZCBmb3IgZGVjaWRpbmcgaWYgbWVyZ2UKaXMgbmVlZGVkIGluc3RlYWQg
b2YgYmlvLT52Y250IHdoaWNoIGlzbid0IHZhbGlkIGZvciBjbG9uZWQgYmlvLgoKU2lnbmVkLW9m
Zi1ieTogTWluZyBMZWkgPHRvbS5sZWltaW5nQGdtYWlsLmNvbT4KLS0tCiBibG9jay9ibGstbWVy
Z2UuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tZXJnZS5jIGIvYmxvY2svYmxrLW1lcmdlLmMK
aW5kZXggYjNhYzQwYS4uMzM4N2ZkNiAxMDA2NDQKLS0tIGEvYmxvY2svYmxrLW1lcmdlLmMKKysr
IGIvYmxvY2svYmxrLW1lcmdlLmMKQEAgLTk5LDcgKzk5LDcgQEAgdm9pZCBibGtfcmVjb3VudF9z
ZWdtZW50cyhzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwgc3RydWN0IGJpbyAqYmlvKQogewogCWJv
b2wgbm9fc2dfbWVyZ2UgPSAhIXRlc3RfYml0KFFVRVVFX0ZMQUdfTk9fU0dfTUVSR0UsCiAJCQkm
cS0+cXVldWVfZmxhZ3MpOwotCWJvb2wgbWVyZ2Vfbm90X25lZWQgPSBiaW8tPmJpX3ZjbnQgPCBx
dWV1ZV9tYXhfc2VnbWVudHMocSk7CisJYm9vbCBtZXJnZV9ub3RfbmVlZCA9IGJpby0+YmlfcGh5
c19zZWdtZW50cyA8IHF1ZXVlX21heF9zZWdtZW50cyhxKTsKIAogCWlmIChub19zZ19tZXJnZSAm
JiAhYmlvX2ZsYWdnZWQoYmlvLCBCSU9fQ0xPTkVEKSAmJgogCQkJbWVyZ2Vfbm90X25lZWQpCi0t
IAoxLjcuOS41Cgo=
--001a113db20a39c7d205078029e7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--001a113db20a39c7d205078029e7--
