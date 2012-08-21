From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2 v1] blkdrv: Add queue limits parameters for sg block
	drive
Date: Tue, 21 Aug 2012 12:14:16 +0200
Message-ID: <50335F78.1030005@redhat.com>
References: <1345537427-21601-1-git-send-email-mc@linux.vnet.ibm.com>
	<50334B51.6050900@redhat.com> <503357B2.5040901@linux.vnet.ibm.com>
	<CAJSP0QX8BL9R_M0NxisiP+wejjgh6C6-nz9LPAfgHppPpNpYnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QX8BL9R_M0NxisiP+wejjgh6C6-nz9LPAfgHppPpNpYnA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: stefanha@linux.vnet.ibm.com, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 21/08/2012 11:52, Stefan Hajnoczi ha scritto:
>>> >> Using /sys/dev/block or /sys/dev/char seems easier, and lets you
>>> >> retrieve the parameters for block devices too.
>>> >>
>> > what do you mean with "block devices"?   Using "/dev/sda" instead of
>> > "/dev/sg0"?

Yes.

>>> >> However, I'm worried of the consequences this has for migration.  You
>>> >> could have the same physical disk accessed with two different HBAs, with
>>> >> different limits.  So I don't know if this can really be solved at all.
>>> >>
>> > I know little about qemu migration now.  The pending scsi commands will be
>> > saved and
>> > transfered to remote machine when starting migration?
> 
> Passthrough is already a migration blocker if both hosts do not have
> access to the same LUNs.

Yes, but requiring the exact same hardware may be too much.  I'm trying
to understand the problem better before committing to a threefold
spec/qemu/kernel change.

Cong, what is the limit that the host HBA enforces (and what is the
HBA)?  What commands see a problem?  Is it fixed by using scsi-block
instead of scsi-generic (if you can use scsi-block at all, i.e. it's not
a tape or similar device)?

With scsi-generic, QEMU uses a bounce buffer for non-I/O commands to a
SCSI passthrough device, so the only problem in that case should be the
maximum segment size.  This could change in the future, but max_segments
and max_sectors should not yet be a problem.

With scsi-block, QEMU will use read/write on the block device and the
host kernel will then obey the host HBA's block limits.  QEMU will still
use a bounce buffer for non-I/O commands to a scsi-block device, but the
payload is usually small for non-I/O commands.

Paolo

> When both hosts do have access to the same LUNs it's possible to
> extract the block queue limits (using sysfs) and compare them.
> 
> Today you can start QEMU with different image files on both hosts.
> Migration will appear to work but the disk image on the destination
> host could be junk.  This is a similar case, I don't see a problem
> except that there should be a safety check (maybe at the libvirt
> level) to make this safe.
