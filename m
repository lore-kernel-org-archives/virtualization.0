From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Re: kernel BUG at drivers/block/virtio_blk.c:172
Date: Fri, 31 Oct 2014 12:40:00 +0800
Message-ID: <CACVXFVPVdTqJ7X6xokq-8X8CTh3A59xwGNdwTm+SW1dOB-xxLQ@mail.gmail.com>
References: <54524D50.50509@kernel.dk>
	<54524D68.7080509@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113ccd4ef510fd0506b09614
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54524D68.7080509@kernel.dk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <axboe@kernel.dk>
Cc: =?UTF-8?B?THVrw6HFoSBDemVybmVy?= <lczerner@redhat.com>, Christoph Hellwig <hch@lst.de>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--001a113ccd4ef510fd0506b09614
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 10:38 PM, Jens Axboe <axboe@kernel.dk> wrote:
> Forgot to CC you...
>
>
> -------- Forwarded Message --------
> Subject: Re: kernel BUG at drivers/block/virtio_blk.c:172
> Date: Thu, 30 Oct 2014 08:38:08 -0600
> From: Jens Axboe <axboe@kernel.dk>
> To: Luk=C3=A1=C5=A1 Czerner <lczerner@redhat.com>,
> virtualization@lists.linux-foundation.org
> CC: hch@lst.de
>
> On 2014-10-30 08:33, Luk=C3=A1=C5=A1 Czerner wrote:
>>
>> Hi,
>>
>> I've just hit this BUG at drivers/block/virtio_blk.c when updated to
>> the kernel from the top of the Linus git tree.
>>
>> commit a7ca10f263d7e673c74d8e0946d6b9993405cc9c
>>
>> This is my virtual machine running on RHEL7 guest
>>
>> qemu-kvm-1.5.3-60.el7.x86_64
>>
>> The last upstream kernel (3.17.0-rc4) worked well. I'll try to
>> bisect, but meanwhile this is a backtrace I got very early in the boot.
>> The root fs on that guest is xfs and I am using raw disk image and virti=
o
>> driver.
>>
>> Let me know if you need more information.
>
>
> Ming, looks like this still isn't really fixed. The above upstream
> commit has the latest fixup as well for the segments being wrong, so
> nothing else should be pending.

That looks weird, and I can't reproduce with mkfs.xfs & mount
in my environment.

Luk=C3=A1=C5=A1, could you reproduce the issue with attached debug patch
and post the result? BTW, do you pass 'scsi=3Doff' in the qemu
command line for the virito-blk device?



Thanks,
--=20
Ming Lei

--001a113ccd4ef510fd0506b09614
Content-Type: text/x-patch; charset=US-ASCII; name="blk-seg.patch"
Content-Disposition: attachment; filename="blk-seg.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i1x1xox20

ZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tZXJnZS5jIGIvYmxvY2svYmxrLW1lcmdlLmMKaW5kZXgg
YjNhYzQwYS4uOTFmMzI3NSAxMDA2NDQKLS0tIGEvYmxvY2svYmxrLW1lcmdlLmMKKysrIGIvYmxv
Y2svYmxrLW1lcmdlLmMKQEAgLTExMyw2ICsxMTMsMTUgQEAgdm9pZCBibGtfcmVjb3VudF9zZWdt
ZW50cyhzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwgc3RydWN0IGJpbyAqYmlvKQogCQliaW8tPmJp
X25leHQgPSBueHQ7CiAJfQogCisJaWYgKG5vX3NnX21lcmdlICYmIChiaW8tPmJpX3BoeXNfc2Vn
bWVudHMgPj0gcXVldWVfbWF4X3NlZ21lbnRzKHEpKSkKKwkJcHJpbnRrKCIlczogJWQtJWQtJWQg
dmNudC0lZCBzZWdzLSVkXG4iLAorCQkJCV9fZnVuY19fLAorCQkJCW5vX3NnX21lcmdlLAorCQkJ
CSFiaW9fZmxhZ2dlZChiaW8sIEJJT19DTE9ORUQpLAorCQkJCW1lcmdlX25vdF9uZWVkLAorCQkJ
CWJpby0+YmlfdmNudCwKKwkJCQliaW8tPmJpX3BoeXNfc2VnbWVudHMpOworCiAJYmlvLT5iaV9m
bGFncyB8PSAoMSA8PCBCSU9fU0VHX1ZBTElEKTsKIH0KIEVYUE9SVF9TWU1CT0woYmxrX3JlY291
bnRfc2VnbWVudHMpOwo=
--001a113ccd4ef510fd0506b09614
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--001a113ccd4ef510fd0506b09614--
