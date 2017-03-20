From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC] virtio_blk: add DISCARD support to virtio_blk driver
Date: Mon, 20 Mar 2017 15:28:57 +0000
Message-ID: <CAJSP0QUda0UMO9BqfjLTg8EJRVKrv34uZDjFbooG-8ZJafM=kg@mail.gmail.com>
References: <1489714479-4002-1-git-send-email-changpeng.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1489714479-4002-1-git-send-email-changpeng.liu@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 17, 2017 at 1:34 AM, Changpeng Liu <changpeng.liu@intel.com> wrote:
> Currently virtio_blk driver does not provide discard feature
> flag, so the filesystems which built on top of the block device
> will not send discard command. This is okay for HDD backend, but
> it will impact the performance for SSD backend.
>
> Add a feature flag such as VIRTIO_BLK_F_DISCARD to virtio_blk driver
> is very straightforward, but it will extend the exist virtio_blk
> protocol, I'm preparing to add this feature, before that, I'd like
> to get comments or suggestions from community.

Please remember to also send a VIRTIO spec change:
https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback

This feature was not added to virtio-blk in the past because
virtio-scsi was essentially a replacement that could support all disk
I/O features (thanks to the SCSI command set).  There are many
virtio-blk users and some may not want to migrate to virtio-scsi.  So
it seems reasonable to add a DISCARD command to virtio-blk.

Stefan
