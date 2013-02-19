From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/9] virtio: new API for addition of buffers,
	scatterlist changes
Date: Tue, 19 Feb 2013 18:19:11 +1030
Message-ID: <87ehgciw08.fsf@rustcorp.com.au>
References: <1360671815-2135-1-git-send-email-pbonzini@redhat.com>
	<87r4kjjuyn.fsf@rustcorp.com.au> <511CAD19.2010902@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <511CAD19.2010902@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Paolo Bonzini <pbonzini@redhat.com> writes:
>> virtio_ring: virtqueue_add_sgs, to add multiple sgs.
>> 
>> virtio_scsi and virtio_blk can really use these, to avoid their current
>> hack of copying the whole sg array.
>> 
>> Signed-off-by: Ruty Russell <rusty@rustcorp.com.au> 
>
> It's much better than the other prototype you had posted, but I still
> dislike this...  You pay for additional counting of scatterlists when
> the caller knows the number of buffers

Yes, but I like the API simplicity.  We could use an array of sg_table,
which is what you have in virtio_scsi anyway, but I doubt it's
measurable on benchmarks.

> and the nested loops aren't free, either.

I think they'll win over multiple function calls :)

But modulo devastating benchmarks, this wins.  Because the three-part
API is really, really ugly.  It *looks* like a generic "start - work
... work - end" API, but it's not.  Because you need to declare exactly
what you're doing in virtqueue_start_buf!

And that's OK, because noone wants a generic API like that.

> > +	sg_unmark_end(sg + out + in);
> > +	if (out && in)
> > +		sg_unmark_end(sg + out);
>
> What's this second sg_unmark_end block for?  Doesn't it access after the
> end of sg?  If you wanted it to be sg_mark_end, that must be:
> 
>   if (out)
> 	  sg_mark_end(sg + out - 1);
>   if (in)
> 	  sg_mark_end(sg + out + in - 1);
> 
>   with a corresponding unmark afterwards.

Thanks, I fixed that after I actually tested it :)

But as we clean them every time, we don't need to unmark:

	/* Workaround until callers pass well-formed sgs. */
	for (i = 0; i < out + in; i++)
		sg_unmark_end(sg + i);

	sg_mark_end(sg + out + in - 1);
	if (out && in)
		sg_mark_end(sg + out - 1);

	return virtqueue_add_sgs(_vq, sgs, out ? 1 : 0, in ? 1 : 0, data, gfp);

This is a workaround until all callers fixed / replaced, of course.

> Another problem is that you cannot pass "truncated" scatterlists.  You
> must ensure there is an end marker on the last item.  I'm not sure if
> the kernel ensures that, given that for_each_sg takes explicitly the
> number of scatterlist elements; and it is not as trivial as
> "sg_mark_end(foo + nsg - 1);" if the upper layers hand you a chained
> scatterlist.

Makes you wonder why they have end markers at all.  But yes, the block
layer does the right thing with end markers in blk_bio_map_sg(), which
seems to carry through.

Cheers,
Rusty.
PS.  Patchbomb coming, lightly tested.
