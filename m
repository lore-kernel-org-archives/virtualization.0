From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2] virtio_blk: unlock vblk->lock during kick
Date: Wed, 30 May 2012 15:39:05 +0200
Message-ID: <4FC622F9.2070506@de.ibm.com>
References: <1338383963-17910-1-git-send-email-stefanha@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1338383963-17910-1-git-send-email-stefanha@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, khoa@us.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On 30/05/12 15:19, Stefan Hajnoczi wrote:
> Holding the vblk->lock across kick causes poor scalability in SMP
> guests.  If one CPU is doing virtqueue kick and another CPU touches the
> vblk->lock it will have to spin until virtqueue kick completes.
> 
> This patch reduces system% CPU utilization in SMP guests that are
> running multithreaded I/O-bound workloads.  The improvements are small
> but show as iops and SMP are increased.

Funny, recently I got a bug report regarding spinlock lockup
(see http://lkml.indiana.edu/hypermail/linux/kernel/1205.3/02201.html)
Turned out that blk_done was called on many guest cpus while the guest
was heavily paging on one virtio block device. (and the guest had much
more cpus than the host)
This patch will probably reduce the pressure for those cases as well.
we can then finish requests if somebody else is doing the kick.

IIRC there were some other approaches to address this lock holding during
kick but this looks like the less intrusive one.

> Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
