From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: 9p: correctly pass physical address to userspace
	for high pages
Date: Fri, 19 Oct 2012 10:09:51 +1030
Message-ID: <87wqynpcxk.fsf@rustcorp.com.au>
References: <1350468877-7677-1-git-send-email-will.deacon@arm.com>
	<87lif4o739.fsf@rustcorp.com.au>
	<20121018094247.GA17296@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121018094247.GA17296@mudshark.cambridge.arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, Eric Van Hensbergen <ericvh@gmail.com>, Sasha Levin <levinsasha928@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Will Deacon <will.deacon@arm.com> writes:
> On Thu, Oct 18, 2012 at 03:19:06AM +0100, Rusty Russell wrote:
>> We do have an alternate solution: masking out __GFP_HIGHMEM from the
>> kmalloc of desc.  If it fails, we will fall back to laying out the
>> virtio request directly inside the ring; if it doesn't fit, we'll wait
>> for the device to consume more buffers.
>
> Hmm, that will probably work for the vring but the zero-copy code for 9p may
> just give us an address from userspace if I'm understanding it correctly. In
> that case, we really have to do the translation as below (which is actually
> much cleaner because everything is page-aligned).
>
>> > @@ -325,7 +326,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
>> >  		int count = nr_pages;
>> >  		while (nr_pages) {
>> >  			s = rest_of_page(data);
>> > -			pages[index++] = virt_to_page(data);
>> > +			pages[index++] = kmap_to_page(data);
>> >  			data += s;
>> >  			nr_pages--;
>> >  		}
>
> So what do you reckon? How about I leave this hunk as a separate patch and
> have a play masking out __GFP_HIGHMEM for the vring descriptor?

Yes, I think so.  A scathing comment would be nice, too...

Thanks,
Rusty.
