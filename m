From: Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 0/2] virtio_balloon: Fix restore and convert to workqueue
Date: Fri,  4 Dec 2015 14:37:49 +0100
Message-ID: <1449236271-10133-1-git-send-email-pmladek__29353.5699639053$1449240185$gmane$org@suse.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Jeff Epler <jepler@unpythonic.net>
List-Id: virtualization@lists.linuxfoundation.org

It has been long since I have sent v3 of the balloon conversion from
a kthread to a workqueue. I have gained some more experience with
the APIs in the meantime. I hope that you would like the outcome.

I have added one more patch that fixes a separate problem with
restoring the balloon after the system freeze. I have found this
when testing the conversion.

Changes against v3:

  + rebased on 4.4-rc3

  + call cancel_work_synch() when removing the balloon

  + do not queue the work from fill_balloon() and leak_balloon()
    because they are called also independently from the workqueue,
    e.g. remove_common(), virtballoon_oom_notify(). Re-queue
    the work from the work function when necessary.


Changes against v2:

  + Use system_freezable_wq instead of an allocated one
    and move INIT_WORK() higher in virtballoon_probe().

  + Fix typos in the commit message.


Changes against v1:

  + More elegant detection of the pending work in fill_balloon() and
    leak_balloon(). It still needs to keep the original requested number
    of pages but it does not add any extra boolean variable.

  + Remove WQ_MEM_RECLAIM workqueue parameter. If I get it correctly,
    this is possible because the code manipulates memory but it is not
    used in the memory reclaim path.

  + initialize the work item before allocation the workqueue

JFYI, the discussion about the previous version can be found at
http://thread.gmane.org/gmane.linux.kernel.virtualization/23701

Petr Mladek (2):
  virtio_balloon: Restore the entire balloon after the system freeze
  virtio_balloon: Use a workqueue instead of "vballoon" kthread

 drivers/virtio/virtio_balloon.c | 93 ++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 58 deletions(-)

-- 
1.8.5.6
