From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: virtio-blk.c handling of i/o which is not a 512 multiple
Date: Wed, 30 Mar 2011 09:45:24 +0100
Message-ID: <AANLkTi=zK4y2zXvC_0=bKcEucx5awW2VA8h2jSA2L9iM__33006.9948257462$1301474860$gmane$org@mail.gmail.com>
References: <loom.20110330T100043-284@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <loom.20110330T100043-284@post.gmane.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Conor Murphy <conor_murphy_virt@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 30, 2011 at 9:15 AM, Conor Murphy
<conor_murphy_virt@hotmail.com> wrote:
> I'm trying to write a virtio-blk driver for Solaris. I've gotten it to the point
> where Solaris can see the device and create a ZFS file system on it.
>
> However when I try and create a UFS filesystem on the device, the VM crashed
> with the error
> *** glibc detected *** /usr/bin/qemu-kvm: double free or corruption (!prev):
> 0x00007f2d38000a00 ***

This is a bug in QEMU.  A guest must not be able to trigger a crash.

> I can reproduce the problem with a simple dd, i.e.
> dd if=/dev/zero of=/dev/rdsk/c2d10p0 bs=5000 count=1

I think this a raw character device, which is why you're even able to
perform non-blocksize accesses?  Have you looked at how other drivers
(like the Xen pv blkfront) handle this?

> My driver will create a virtio-blk request with two elements in the sg list, one
> for the first 4096 byes and the other for the remaining 904.
>
> From stepping through with gdb, virtio_blk_handle_write will sets n_sectors to 9
> (5000 / 512). Later on the code, n_sectors is used the calculate the size of the
> buffer required but 9 * 512 is too small and so when the request is process it
> ends up writing past the end of the buffer and I guest this triggers the glibc
> error.

We need to validate that (qiov->size % BDRV_SECTOR_SIZE) == 0 and
reject invalid requests.

> Is there a requirement for virtio-blk guest drivers that all i/o requests are
> sized in multiples of 512 bytes?

There is no strict requirement according to the virtio specification,
but maybe there should be:

http://ozlabs.org/~rusty/virtio-spec/virtio-spec-0.8.9.pdf

Stefan
