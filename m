From: Laszlo Ersek <lersek@redhat.com>
Subject: anyone willing to review a virtio-net guest driver for OVMF?
Date: Wed, 29 May 2013 12:59:42 +0200
Message-ID: <51A5DF9E.6040906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: virtualization@lists.linux-foundation.org, ipxe-devel@ipxe.org
Cc: "Jordan Justen (Intel address)" <jordan.l.justen@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

(Resending to the virt list after the original qemu-devel posting,
following MST's advice; plus adding ipxe-devel too -- apologies for
spamming!)

Hi,

the driver in question is intended as a fallback driver when the iPXE
EFI driver for virtio-net is not present as an oprom. The series starts
with technical notes that should help the virtio-net expert catch any
errors more easily.

This review could easily take up a lot of time; my hope is in the fact
that people here are both more skilled and faster than my humble self.

http://thread.gmane.org/gmane.comp.bios.tianocore.devel/2804

Thanks,
Laszlo
