From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 4/6] virtio_ring: virtqueue_add_outbuf /
	virtqueue_add_inbuf.
Date: Thu, 07 Mar 2013 11:33:19 +1100
Message-ID: <87boaw9hgw.fsf@rustcorp.com.au>
References: <87k3plaz3d.fsf@rustcorp.com.au> <877gllaypf.fsf@rustcorp.com.au>
	<20130306083730.GB5281@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130306083730.GB5281@hj.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

Asias He <asias@redhat.com> writes:
> On Wed, Mar 06, 2013 at 04:23:24PM +1100, Rusty Russell wrote:
>> These are specialized versions of virtqueue_add_buf(), which cover
>> over 80% of cases and are far clearer.
>> 
>> In particular, the scatterlists passed to these functions don't have
>> to be clean (ie. we ignore end markers).
>> 
>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> 
>
> So, what is the plan for the following ideas discussed in the other
> thread?
>
>    '''
>    > Looking at code, it seems that most users really have a single sg, in
>    > low memory. So how about simply passing void * instead of sg? Whoever
>    > has multiple sgs can use the rich interface.
>    
>    Good point, let's do that:
>    1) Make virtqueue_add_outbuf()/inbuf() take a void * and len.
>    2) Transfer users across to use that.
>    3) Make everyone else use clean scatterlists with virtqueue_add_sgs[].
>    4) Remove virtqueue_add_bufs().

Networking performance: there is still a performance penalty in using
virtqueue_add_sgs(), and it can't use a simple void * and len.

So I changed my mind.  Again...

Cheers,
Rusty.
