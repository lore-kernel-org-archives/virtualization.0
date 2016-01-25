From: Petr Mladek <pmladek@suse.com>
Subject: [PATCH v5 0/2] virtio_balloon: Conversion to workqueue + parallel
	stats
Date: Mon, 25 Jan 2016 17:38:04 +0100
Message-ID: <1453739886-29458-1-git-send-email-pmladek@suse.com>
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

The previous version did not prevent updating the balloon when it was
being removed. There was an idea to update the stats in a separate work
and cancel it after the config reset. But this does not seem to work.
The code for updating the stats communicates with the host. IMHO, it
should not run after the reset (flushing buffers). Therefore I decided
to use a boolean value and a spin lock (inspired by virtio_scsi).

Michael S. Tsirkin suggested that it would have been nice to split the work
and updated the stats in parallel. I did a lot of investigation and it seemed
that we did not need any extra sychronization. Anyway, I rather made the split
in a separate patch. See the patch description for more details.

Changes against v4:

  + removed fix of the balloon restore code; it was false alarm;
    freezer waken the kthread and it restored the balloon later

  + added a spin lock to prevent updating the balloon when being removed

  + split the work into two; it allows to update stats even
    when the balloon is being resized


Changes against v3:

  + rebased on 4.4-rc3

  + call cancel_work_sync() when removing the balloon

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


Just for record, the discussion about the previous version can be found
at http://thread.gmane.org/gmane.linux.kernel/2100306


Petr Mladek (2):
  virtio_balloon: Use a workqueue instead of "vballoon" kthread
  virtio_balloon: Allow to resize and update the balloon stats in
    parallel

 drivers/virtio/virtio_balloon.c | 122 ++++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

-- 
1.8.5.6
