From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: vhost net: performance with ping benchmark
Date: Mon, 24 Aug 2009 21:22:47 -0500
Message-ID: <4A934AF7.2090904__35564.4680480056$1251167110$gmane$org@codemonkey.ws>
References: <20090824081240.GA3415@redhat.com>
	<20090824212137.GA9835@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090824212137.GA9835@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> On Mon, Aug 24, 2009 at 11:12:41AM +0300, Michael S. Tsirkin wrote:
>   
>> At Rusty's suggestion, I tested vhost base performance with ping.
>> Results below, and seem to be what you'd expect.
>>     
>
> Rusty, any chance you could look at the code?  Is it in reasonable
> shape? I think it makes sense to merge it through you. What do you
> think?  One comment on file placement: I put files under a separate
> vhost directory to avoid confusion with virtio-net which runs in guest.
> Does this sound sane?  Also, can a minimal version (without TSO, tap or
> any other features) be merged upstream first so that features can be
> added later? Or do we have to wait until it's more full featured?
> Finally, can it reasonably make 2.6.32, or you think it needs more time
> out of tree?
>   

I think 2.6.32 is pushing it.  I think some time is needed to flush out 
the userspace interface.  In particular, I don't think Mark's comments 
have been adequately addressed.  If a version were merged without GSO 
support, some mechanism to do feature detection would be needed in the 
userspace API.  I think this is likely going to be needed regardless.  I 
also think the tap compatibility suggestion would simplify the 
consumption of this in userspace.

I'd like some time to look at get_state/set_state ioctl()s along with 
dirty tracking support.  It's a much better model for live migration IMHO.

I think so more thorough benchmarking would be good too.  In particular, 
netperf/iperf runs would be nice.

Regards,

Anthony Liguori

> Thanks very much,
>
>   
