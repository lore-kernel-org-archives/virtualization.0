From: Laszlo Ersek <lersek@redhat.com>
Subject: QueuePFN peculiarity in virtio-mmio
Date: Tue, 22 Oct 2013 19:49:21 +0200
Message-ID: <5266BAA1.5080303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
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
To: Linux Virtualization <virtualization@lists.linux-foundation.org>, Jon Masters <jcm@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: "Jordan Justen (Intel address)" <jordan.l.justen@intel.com>, "edk2-devel@lists.sourceforge.net" <edk2-devel@lists.sourceforge.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Olivier Martin <olivier.martin@arm.com>, Mark Salter <msalter@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

"Appendix X: virtio-mmio" in the virtio spec says

    =95 0x040 | RW | QueuePFN
      [...] When the Guest stops using the queue it must write zero
      (0x0) to this register.
      [...]

and

    Virtqueue Configuration

    [...]
    2. Check if the queue is not already in use: read QueuePFN
    register, returned value should be zero (0x0).
    [...]

I think this in itself is already suboptimal, because a guest that
crashes and reboots (while the emulator itself survives) will not be
able to use the device after said reboot (it has never re-set QueuePFN
to zero).

But, more importantly: I think that resetting the device (by writing 0
to its status register) should include (ie. *guarantee*) the effects of
setting QueuePFN to zero for all imaginable queues of the device.

This way, a defensive guest that starts up by resetting the device (*)
after identifying it via MagicValue / Version / DeviceID / VendorID
would be able to use the device regardless of the device's prior
QueuePFN setting(s).

(*) Resetting the device is the first step in "2.2.1 Device
Initialization Sequence". It "is not required on initial start up", but
as a guest driver can never be sure whether the startup in question is
the initial one, a defensive driver will always start with device reet.


The question arises because Olivier has posted a series to edk2-devel
that adds virtio-mmio support to TianoCore, and Mark tested it (using
OVMF) with a Linux guest and found problems. Namely, OVMF itself can
drive the virtio devices via virtio-mmio, but the Linux kernel booted
from OVMF can not. The reason is the missing zeroing of QueuePFN when
OVMF is exiting. (I'm just paraphrasing the analysis.)

I think
- that resetting the device (via its status register) should make the
host forget *all* prior configuration, including QueuePFN,
- and that the Linux driver should reset the device as first step.

So:
- What's the motivation for the "acquire/release" semantics of QueuePFN?
- Am I right that device reset should force a QueuePFN release too?

Thanks,
Laszlo
