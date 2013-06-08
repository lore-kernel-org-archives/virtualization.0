From: Laszlo Ersek <lersek@redhat.com>
Subject: [virtio-spec PATCH 0/5] Receiving Used Buffers example code: cleanups
	and an extra mb()
Date: Sat,  8 Jun 2013 19:39:23 +0200
Message-ID: <1370713168-20624-1-git-send-email-lersek@redhat.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, Jordan Justen <jordan.l.justen@intel.com>, Laszlo Ersek <lersek@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Patches before the last are small cleanups.

In the last patch I'm trying to extract / generalize an idea from Stefan
Hajnoczi's review of my virtio-net driver for OVMF.

Unfortunately I can't find Stefan's email on any mailing list archive
(sourceforge, gmane, mail-archive etc. all have only my response), so
I'll quote it here.

The patch Stefan was reviewing is
<http://thread.gmane.org/gmane.comp.bios.tianocore.devel/2804/focus=2819>:

  [PATCH v3 10/15]
  OvmfPkg: VirtioNetDxe: implement Tx: SNP.Transmit and SNP.GetStatus

On 06/07/13 16:17, Stefan Hajnoczi wrote:

> There is no read memory barrier between fetching TxCurUsed and
> fetching UsedElem[].Id.  In theory I think there is no guarantee that
> Dev->TxRing.Used.UsedElem[UsedElemIdx].Id is fetched *after*
> Dev->TxRing.Used.Idx.  On x86 it shouldn't be a problem but I expected
> a read memory barrier after comparing fetching Dev->TxRing.Used.Idx.

(Solely for the record, my response is at
<http://thread.gmane.org/gmane.comp.bios.tianocore.devel/3052>.)

In the last patch I'm trying to apply this remark to the virtio spec.
Hopefully I'm not misrepresenting the idea, nor glossing over any
important differences between the VirtioNetDxe code Stefan was actually
reviewing and the example code in the virtio spec.

I didn't add

  Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>

to the last patch, because my translation may easily have corrupted his
idea, but if the patch is deemed worthwhile, please do add his
Suggested-by.


I'm not subscribed to the virtualization list, please keep me CC'd.

Thanks!

Laszlo Ersek (5):
  Receiving Used Buffers: fix typo in "ring empty" condition in example
    code
  Receiving Used Buffers: re-disable interrupts when staying in the
    loop
  Receiving Used Buffers: variable for Queue Size is called "qsz"
    elsewhere
  Receiving Used Buffers: switch . and -> operators, add missing &
  Receiving Used Buffers: prevent speculative load when not
    sequentially consistent

 virtio-spec.lyx |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)
