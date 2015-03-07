From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: virtio fixes pull for 4.0?
Date: Sat, 7 Mar 2015 20:30:49 +0100
Message-ID: <20150307193049.GA32459__15732.921291101$1425756677$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: pawel.moll@arm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty!
There are a bunch of (mostly virtio 1.0 related) fixes for virtio
that need to go into 4.0 I think.
	virtio_blk: typo fix
	virtio_blk: fix comment for virtio 1.0
	virtio_console: init work unconditionally
	virtio_console: avoid config access from irq
	virtio_balloon: set DRIVER_OK before using device

seem ready?

	virtio_mmio: generation support
	virtio_mmio: fix endian-ness for mmio these two are waiting for ack by Pawel

These two fix bugs in virtio 1.0 code for mmio.
Host code for that was AFAIK not posted, so I can't test properly.
Pawel?

	virtio-balloon: do not call blocking ops when !TASK_RUNNING

Rusty, it seems you prefer a different fix for this issue,
while Cornelia prefers mine. Maybe both me and Cornelia misunderstand the
issue? I know you dealt with a ton of similar issues recently
so you are more likely to be right, but I'd like to understand
what's going on better all the same. Could you help please?

	virtio_rpmsg: set DRIVER_OK before using device

Just posted this, but seems pretty obvious.

I think it's a good idea to merge these patches (maybe except the
!TASK_RUNNING thing) sooner rather than later, to make sure people have
the time to test the fixes properly.  Would you like me to pack up (some
of them) them up and do a pull request?

Thanks,
-- 
MST
