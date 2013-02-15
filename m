From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/9] virtio: new API for addition of buffers, scatterlist
	changes
Date: Fri, 15 Feb 2013 19:04:19 +0100
Message-ID: <511E78A3.9070607@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Il 14/02/2013 10:23, Paolo Bonzini ha scritto:
>> > How about this as a first step?
>> > 
>> > virtio_ring: virtqueue_add_sgs, to add multiple sgs.
>> > 
>> > virtio_scsi and virtio_blk can really use these, to avoid their current
>> > hack of copying the whole sg array.
>> > 
>> > Signed-off-by: Ruty Russell <rusty@rustcorp.com.au> 
> It's much better than the other prototype you had posted, but I still
> dislike this...  You pay for additional counting of scatterlists when
> the caller knows the number of buffers; and the nested loops aren't
> free, either.

Another problem is that you cannot pass "truncated" scatterlists.  You
must ensure there is an end marker on the last item.  I'm not sure if
the kernel ensures that, given that for_each_sg takes explicitly the
number of scatterlist elements; and it is not as trivial as
"sg_mark_end(foo + nsg - 1);" if the upper layers hand you a chained
scatterlist.

Paolo
