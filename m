From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 0/1] virtio-balloon vs. endianness
Date: Wed, 18 May 2016 14:12:42 +0200
Message-ID: <1463573563-34081-1-git-send-email-cornelia.huck@de.ibm.com>
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
To: mst@redhat.com
Cc: borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

this patch (against your vhost branch) should fix the endianness issues
we saw on s390 that I mentioned on irc yesterday.

Both the config space and the stats seem to be fine endianness-wise,
but the pfns for inflate/deflate were not converted to little endian
for virtio-1 (the qemu code is correct).

Without the patch, I get an immediate crash on qemu master when
started via libvirt with currentMemory=0.5*Memory (thanks to
Christian for the hint) - as virtio-ccw is enabling virtio-1 by
default:

[    3.273419] ------------[ cut here ]------------
[    3.273424] Kernel BUG at 0000000000300df2 [verbose debug info unavailable]
[    3.273617] illegal operation: 0001 ilc:1 [#1] PREEMPT SMP DEBUG_PAGEALLOC
[    3.273623] Modules linked in: autofs4
[    3.273627] CPU: 2 PID: 1 Comm: systemd Not tainted 4.5.0-00798-g1181f16 #6
[    3.273629] task: 000000003def8000 ti: 000000003deec000 task.ti: 000000003deec000
[    3.273631] Krnl PSW : 0704d00180000000 0000000000300df2 (do_iter_readv_writev+0x2/0x90)
[    3.273640]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 EA:3
Krnl GPRS: 000000003deefe30 0000000000008000 000000003bba8c00 000000003deefdb0
[    3.273644]            000000003deeff08 00000000001b3e60 000000003deefda8 000003ffc18fde60
[    3.273646]            0000000000000248 0000000000000000 000000003deeff08 0000000000000001
[    3.273647]            000000003bba8c00 00000000001b3e60 0000000000301f08 000000003deefd00
[    3.273655] Krnl Code:>0000000000300df2: 000         unknown
           0000000000300df4: 0000         unknown
           0000000000300df6: 0000         unknown
           0000000000300df8: 0000         unknown
           0000000000300dfa: 0000         unknown
           0000000000300dfc: 0000         unknown
           0000000000300dfe: 0000         unknown
           0000000000300e00: 0000         unknown
[    3.273665] Call Trace:
[    3.273667] ([<0000000000301e86>] do_readv_writev+0x86/0x260)
[    3.273669]  [<0000000000302132>] vfs_writev+0x5a/0x78
[    3.273671]  [<000000000030305e>] SyS_writev+0x66/0xe8
[    3.273677]  [<000000000076955e>] system_call+0xd6/0x270
[    3.273679]  [<000003ff9d2f82c4>] 0x3ff9d2f82c4
[    3.273680] INFO: lockdep is turned off.
[    3.273681] Last Breaking-Event-Address:
[    3.273683]  [<0000000000769a60>] io_int_handler+0x17c/0x298
[    3.273686]
[    3.273688] Kernel panic - not syncing: Fatal exception: panic_on_oops

The crash is gone by either forcing the device to legacy (max_revision=0)
or by applying the patch below in the guest.

[There also have been reports of people getting immediate "Out of puff!"
messages, but I don't know how to reproduce that.]

Problems should presumably also arise with virtio-pci on big endian
platforms, but given that it took us some time to hit this in tests
with the always-modern virtio-ccw environment, I'm not surprised if
nobody hit that yet.

[As an aside: Should the virtio spec be a bit more clear on how the
queues for the balloon operate, or do we want to avoid spending more
time on the legacy balloon?]

The fix (this patch or something different) needs to be cc:stable,
I guess.

Cornelia Huck (1):
  virtio-balloon: handle virtio-1 endianness

 drivers/virtio/virtio_balloon.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.6.6
