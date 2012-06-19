From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 1/3] block: Introduce __blk_segment_map_sg() helper
Date: Tue, 19 Jun 2012 10:02:38 +0800
Message-ID: <4FDFDDBE.3050506@redhat.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<1340002390-3950-2-git-send-email-asias@redhat.com>
	<20120618213103.GC32733@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120618213103.GC32733@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 06/19/2012 05:31 AM, Tejun Heo wrote:
> Hello, Asias.
>
> On Mon, Jun 18, 2012 at 02:53:08PM +0800, Asias He wrote:
>> Split the mapping code in blk_rq_map_sg() to a helper
>> __blk_segment_map_sg(), so that other mapping function, e.g.
>> blk_bio_map_sg(), can share the code.
>>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Shaohua Li <shli@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: Tejun Heo <tj@kernel.org>
>> Suggested-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Asias He <asias@redhat.com>
>> ---
>>   block/blk-merge.c |   80 ++++++++++++++++++++++++++++++-----------------------
>>   1 file changed, 45 insertions(+), 35 deletions(-)
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 160035f..576b68e 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -110,6 +110,49 @@ static int blk_phys_contig_segment(struct request_queue *q, struct bio *bio,
>>   	return 0;
>>   }
>>
>> +static void
>> +__blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
>> +		     struct scatterlist *sglist, struct bio_vec **bvprv,
>> +		     struct scatterlist **sg, int *nsegs, int *cluster)
>> +{
>> +
>> +	int nbytes = bvec->bv_len;
>> +
>> +	if (*bvprv && *cluster) {
>> +		if ((*sg)->length + nbytes > queue_max_segment_size(q))
>> +			goto new_segment;
>> +
>> +		if (!BIOVEC_PHYS_MERGEABLE(*bvprv, bvec))
>> +			goto new_segment;
>> +		if (!BIOVEC_SEG_BOUNDARY(q, *bvprv, bvec))
>> +			goto new_segment;
>> +
>> +		(*sg)->length += nbytes;
>> +	} else {
>> +new_segment:
>> +		if (!*sg)
>> +			*sg = sglist;
>> +		else {
>> +			/*
>> +			 * If the driver previously mapped a shorter
>> +			 * list, we could see a termination bit
>> +			 * prematurely unless it fully inits the sg
>> +			 * table on each mapping. We KNOW that there
>> +			 * must be more entries here or the driver
>> +			 * would be buggy, so force clear the
>> +			 * termination bit to avoid doing a full
>> +			 * sg_init_table() in drivers for each command.
>> +			 */
>> +			(*sg)->page_link &= ~0x02;
>> +			*sg = sg_next(*sg);
>> +		}
>> +
>> +		sg_set_page(*sg, bvec->bv_page, nbytes, bvec->bv_offset);
>> +		(*nsegs)++;
>> +	}
>> +	*bvprv = bvec;
>> +}
>
> I *hope* this is a bit prettier.  e.g. Do we really need to pass in
> @sglist and keep using "goto new_segment"?

I think this deserves another patch on top of this splitting one. I'd 
like to clean this up later.

-- 
Asias
