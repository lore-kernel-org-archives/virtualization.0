From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH -qemu] nvme: support Google vendor extension
Date: Fri, 20 Nov 2015 09:58:08 +0100
Message-ID: <564EE0A0.1020800@redhat.com>
References: <1447825624-17011-1-git-send-email-mlin@kernel.org>
	<1447825624-17011-3-git-send-email-mlin@kernel.org>
	<564DA682.8050706@redhat.com> <1448007096.3473.10.camel@hasee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1448007096.3473.10.camel@hasee>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lin <mlin@kernel.org>
Cc: fes@google.com, keith.busch@intel.com, tytso@mit.edu, qemu-devel@nongnu.org, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org, axboe@fb.com, Rob Nelson <rlnelson@google.com>, Christoph Hellwig <hch@lst.de>, Mihai Rusu <dizzy@google.com>
List-Id: virtualization@lists.linuxfoundation.org



On 20/11/2015 09:11, Ming Lin wrote:
> On Thu, 2015-11-19 at 11:37 +0100, Paolo Bonzini wrote:
>>
>> On 18/11/2015 06:47, Ming Lin wrote:
>>> @@ -726,7 +798,11 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>>>          }
>>>  
>>>          start_sqs = nvme_cq_full(cq) ? 1 : 0;
>>> -        cq->head = new_head;
>>> +        /* When the mapped pointer memory area is setup, we don't rely on
>>> +         * the MMIO written values to update the head pointer. */
>>> +        if (!cq->db_addr) {
>>> +            cq->head = new_head;
>>> +        }
>>
>> You are still checking
>>
>>         if (new_head >= cq->size) {
>>             return;
>>         }
>>
>> above.  I think this is incorrect when the extension is present, and
>> furthermore it's the only case where val is being used.
>>
>> If you're not using val, you could use ioeventfd for the MMIO.  An
>> ioeventfd cuts the MMIO cost by at least 55% and up to 70%. Here are
>> quick and dirty measurements from kvm-unit-tests's vmexit.flat
>> benchmark, on two very different machines:
>>
>> 			Haswell-EP		Ivy Bridge i7
>>   MMIO memory write	5100 -> 2250 (55%)	7000 -> 3000 (58%)
>>   I/O port write	3800 -> 1150 (70%)	4100 -> 1800 (57%)
>>
>> You would need to allocate two eventfds for each qid, one for the sq and
>> one for the cq.  Also, processing the queues is now bounced to the QEMU
>> iothread, so you can probably get rid of sq->timer and cq->timer.
> 
> Here is a quick try.
> Too late now, I'll test it morning.
> 
> Do you see obvious problem?
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 3e1c38d..d28690d 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -543,6 +543,44 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>  
> +static void nvme_cq_notifier(EventNotifier *e)
> +{
> +    NvmeCQueue *cq =
> +        container_of(e, NvmeCQueue, notifier);
> +
> +    nvme_post_cqes(cq);
> +}
> +
> +static void nvme_init_cq_eventfd(NvmeCQueue *cq)
> +{
> +    NvmeCtrl *n = cq->ctrl;
> +    uint16_t offset = (cq->cqid*2+1) * NVME_CAP_DSTRD(n->bar.cap);
> +
> +    event_notifier_init(&cq->notifier, 0);
> +    event_notifier_set_handler(&cq->notifier, nvme_cq_notifier);
> +    memory_region_add_eventfd(&n->iomem,
> +        0x1000 + offset, 4, true, cq->cqid*2+1, &cq->notifier);

should be 0x1000 + offset, 4, false, 0, &cq->notifier

> +}
> +
> +static void nvme_sq_notifier(EventNotifier *e)
> +{
> +    NvmeSQueue *sq =
> +        container_of(e, NvmeSQueue, notifier);
> +
> +    nvme_process_sq(sq);
> +}
> +
> +static void nvme_init_sq_eventfd(NvmeSQueue *sq)
> +{
> +    NvmeCtrl *n = sq->ctrl;
> +    uint16_t offset = sq->sqid * 2 * NVME_CAP_DSTRD(n->bar.cap);
> +
> +    event_notifier_init(&sq->notifier, 0);
> +    event_notifier_set_handler(&sq->notifier, nvme_sq_notifier);
> +    memory_region_add_eventfd(&n->iomem,
> +        0x1000 + offset, 4, true, sq->sqid * 2, &sq->notifier);

likewise should be 0x1000 + offset, 4, false, 0, &sq->notifier

Otherwise looks good!

Paolo

> +}


> +
>  static uint16_t nvme_set_db_memory(NvmeCtrl *n, const NvmeCmd *cmd)
>  {
>      uint64_t db_addr = le64_to_cpu(cmd->prp1);
> @@ -565,6 +603,7 @@ static uint16_t nvme_set_db_memory(NvmeCtrl *n, const NvmeCmd *cmd)
>              /* Submission queue tail pointer location, 2 * QID * stride. */
>              sq->db_addr = db_addr + 2 * i * 4;
>              sq->eventidx_addr = eventidx_addr + 2 * i * 4;
> +            nvme_init_sq_eventfd(sq);
>          }
>  
>          if (cq != NULL) {
> @@ -572,6 +611,7 @@ static uint16_t nvme_set_db_memory(NvmeCtrl *n, const NvmeCmd *cmd)
>               */
>              cq->db_addr = db_addr + (2 * i + 1) * 4;
>              cq->eventidx_addr = eventidx_addr + (2 * i + 1) * 4;
> +            nvme_init_cq_eventfd(cq);
>          }
>      }
>      return NVME_SUCCESS;
> @@ -793,7 +833,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>          }
>  
>          cq = n->cq[qid];
> -        if (new_head >= cq->size) {
> +        if (!cq->db_addr && new_head >= cq->size) {
>              return;
>          }
>  
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 82aeab4..608f202 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -667,6 +667,7 @@ typedef struct NvmeSQueue {
>       * do not go over this value will not result in MMIO writes (but will
>       * still write the tail pointer to the "db_addr" location above). */
>      uint64_t    eventidx_addr;
> +    EventNotifier notifier;
>  } NvmeSQueue;
>  
>  typedef struct NvmeCQueue {
> @@ -689,6 +690,7 @@ typedef struct NvmeCQueue {
>       * do not go over this value will not result in MMIO writes (but will
>       * still write the head pointer to the "db_addr" location above). */
>      uint64_t    eventidx_addr;
> +    EventNotifier notifier;
>  } NvmeCQueue;
>  
>  typedef struct NvmeNamespace {
> 
>>
>> Paolo
