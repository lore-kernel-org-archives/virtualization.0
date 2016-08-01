From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] drivers: virtio_blk: notify blk-core when hw-queue number
	changes
Date: Mon, 1 Aug 2016 11:58:52 +0200
Message-ID: <b17ce95d-b11c-a74b-4118-ac8fa0be4bc1@redhat.com>
References: <1465811906-24510-1-git-send-email-bob.liu__9616.24590349874$1465832216$gmane$org@oracle.com>
	<3cd56d3a-85f0-9cce-d42f-f4eace84667b@redhat.com>
	<5799BFC0.1060804@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5799BFC0.1060804@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bob Liu <bob.liu@oracle.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 28/07/2016 10:18, Bob Liu wrote:
>>> >> A guest might be migrated to other hosts with different num_queues, the
>>> >> blk-core should aware of that else the reference of &vblk->vqs[qid] may be wrong.
>>> >>
>>> >> Signed-off-by: Bob Liu <bob.liu@oracle.com>
>>> >> ---
>>> >>  drivers/block/virtio_blk.c | 3 +++
>>> >>  1 file changed, 3 insertions(+)
>>> >>
>>> >> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>> >> index 42758b5..c169238 100644
>>> >> --- a/drivers/block/virtio_blk.c
>>> >> +++ b/drivers/block/virtio_blk.c
>>> >> @@ -819,6 +819,9 @@ static int virtblk_restore(struct virtio_device *vdev)
>>> >>  	if (ret)
>>> >>  		return ret;
>>> >>  
>>> >> +	if (vblk->num_vqs != vblk->tag_set.nr_hw_queues)
>>> >> +		blk_mq_update_nr_hw_queues(&vblk->tag_set, vblk->num_vqs);
>>> >> +
>>> >>  	virtio_device_ready(vdev);
>>> >>  
>>> >>  	blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
>>> >>
>> > 
>> > This should never happen; it'd be a configuration problem.
>> > 
> Do you mean all hosts have to be configured with the same number of ->num_vqs?
> What about cases like migrating a guest from HostA to HostB while HostB is much more powerful
> and would like to run more hardware queues to get better performance.

The number of queues should be equal to the number of CPUs for the
guest, not to the number of CPUs or queues on the host.  The idea is to
have one queue per guest vCPU.

Paolo
