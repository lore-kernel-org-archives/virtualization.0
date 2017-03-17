From: Changpeng Liu <changpeng.liu@intel.com>
Subject: [RFC] virtio_blk: add DISCARD support to virtio_blk driver
Date: Fri, 17 Mar 2017 09:34:39 +0800
Message-ID: <1489714479-4002-1-git-send-email-changpeng.liu@intel.com>
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
To: virtualization@lists.linux-foundation.org
Cc: changpeng.liu@intel.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Currently virtio_blk driver does not provide discard feature
flag, so the filesystems which built on top of the block device
will not send discard command. This is okay for HDD backend, but
it will impact the performance for SSD backend.

Add a feature flag such as VIRTIO_BLK_F_DISCARD to virtio_blk driver
is very straightforward, but it will extend the exist virtio_blk
protocol, I'm preparing to add this feature, before that, I'd like
to get comments or suggestions from community.

---
1.9.3
