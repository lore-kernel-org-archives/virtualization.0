From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
Date: Thu,  5 Sep 2019 15:48:41 -0400
Message-ID: <20190905194859.16219-1-vgoyal__17550.4568427399$1567713066$gmane$org@redhat.com>
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
To: linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, miklos@szeredi.hu
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, dgilbert@redhat.com, virtio-fs@redhat.com, stefanha@redhat.com, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Michael Tsirkin pointed out issues w.r.t various locking related TODO
items and races w.r.t device removal. 

In this first round of cleanups, I have taken care of most pressing
issues.

These patches apply on top of following.

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4

I have tested these patches with mount/umount and device removal using
qemu monitor. For example.

virsh qemu-monitor-command --hmp vm9-f28 device_del myvirtiofs

Now a mounted device can be removed and file system will return errors
-ENOTCONN and one can unmount it.

Miklos, if you are fine with the patches, I am fine if you fold these
all into existing patch. I kept them separate so that review is easier.

Any feedback or comments are welcome.

Thanks
Vivek


Vivek Goyal (18):
  virtiofs: Remove request from processing list before calling end
  virtiofs: Check whether hiprio queue is connected at submission time
  virtiofs: Pass fsvq instead of vq as parameter to
    virtio_fs_enqueue_req
  virtiofs: Check connected state for VQ_REQUEST queue as well
  Maintain count of in flight requests for VQ_REQUEST queue
  virtiofs: ->remove should not clean virtiofs fuse devices
  virtiofs: Stop virtiofs queues when device is being removed
  virtiofs: Drain all pending requests during ->remove time
  virtiofs: Add an helper to start all the queues
  virtiofs: Do not use device managed mem for virtio_fs and virtio_fs_vq
  virtiofs: stop and drain queues after sending DESTROY
  virtiofs: Use virtio_fs_free_devs() in error path
  virtiofs: Do not access virtqueue in request submission path
  virtiofs: Add a fuse_iqueue operation to put() reference
  virtiofs: Make virtio_fs object refcounted
  virtiofs: Use virtio_fs_mutex for races w.r.t ->remove and mount path
  virtiofs: Remove TODO to quiesce/end_requests
  virtiofs: Remove TODO item from virtio_fs_free_devs()

 fs/fuse/fuse_i.h    |   5 +
 fs/fuse/inode.c     |   6 +
 fs/fuse/virtio_fs.c | 259 ++++++++++++++++++++++++++++++++------------
 3 files changed, 198 insertions(+), 72 deletions(-)

-- 
2.20.1
