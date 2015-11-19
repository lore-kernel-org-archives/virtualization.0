From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH -qemu] nvme: support Google vendor extension
Date: Thu, 19 Nov 2015 11:37:54 +0100
Message-ID: <564DA682.8050706@redhat.com>
References: <1447825624-17011-1-git-send-email-mlin@kernel.org>
	<1447825624-17011-3-git-send-email-mlin@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447825624-17011-3-git-send-email-mlin@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lin <mlin@kernel.org>, linux-nvme@lists.infradead.org, qemu-devel@nongnu.org
Cc: fes@google.com, axboe@fb.com, Rob Nelson <rlnelson@google.com>, virtualization@lists.linux-foundation.org, keith.busch@intel.com, tytso@mit.edu, Christoph Hellwig <hch@lst.de>, Mihai Rusu <dizzy@google.com>
List-Id: virtualization@lists.linuxfoundation.org



On 18/11/2015 06:47, Ming Lin wrote:
> @@ -726,7 +798,11 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>          }
>  
>          start_sqs = nvme_cq_full(cq) ? 1 : 0;
> -        cq->head = new_head;
> +        /* When the mapped pointer memory area is setup, we don't rely on
> +         * the MMIO written values to update the head pointer. */
> +        if (!cq->db_addr) {
> +            cq->head = new_head;
> +        }

You are still checking

        if (new_head >= cq->size) {
            return;
        }

above.  I think this is incorrect when the extension is present, and
furthermore it's the only case where val is being used.

If you're not using val, you could use ioeventfd for the MMIO.  An
ioeventfd cuts the MMIO cost by at least 55% and up to 70%. Here are
quick and dirty measurements from kvm-unit-tests's vmexit.flat
benchmark, on two very different machines:

			Haswell-EP		Ivy Bridge i7
  MMIO memory write	5100 -> 2250 (55%)	7000 -> 3000 (58%)
  I/O port write	3800 -> 1150 (70%)	4100 -> 1800 (57%)

You would need to allocate two eventfds for each qid, one for the sq and
one for the cq.  Also, processing the queues is now bounced to the QEMU
iothread, so you can probably get rid of sq->timer and cq->timer.

Paolo
