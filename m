From: "Bruce Rogers" <brogers@novell.com>
Subject: Re: [PATCH] virtio_net: indicate oom when addbuf returns
 failure
Date: Thu, 10 Jun 2010 09:46:30 -0600
Message-ID: <4C10B4760200004800097CA9__22220.3060788617$1276185025$gmane$org@sinclair.provo.novell.com>
References: <201006041028.56798.rusty@rustcorp.com.au>
	<20100606201258.GA21196@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100606201258.GA21196@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, netdev@vger.kernel.org, stable@kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

 >>> On 6/6/2010 at 02:13 PM, "Michael S. Tsirkin" <mst@redhat.com> wrote: 
> On Fri, Jun 04, 2010 at 10:28:56AM +0930, Rusty Russell wrote:
>> This patch is a subset of an already upstream patch, but this portion
>> is useful in earlier releases.
>> 
>> Please consider for the 2.6.32 and 2.6.33 stable trees.
>> 
>> If the add_buf operation fails, indicate failure to the caller.
>> 
>> Signed-off-by: Bruce Rogers <brogers@novell.com>
>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> Actually this code looks strange:
> Note that add_buf inicates out of memory
> condition with a positive return value, and ring full
> (which is not an error!) with -ENOSPC.
> 
> So it seems that this patch (and upstream code) will fill
> the ring and then end up setting oom = true and rescheduling the work
> forever.  And I suspect I actually saw this at some point
> on one of my systems: observed BW would drop
> with high CPU usage until reboot.
> Can't reproduce it now anymore ..
> 

Thanks for looking into this.

We've decided not to use this patch, since it is not a part of the
solution we need. The upstream patch from whence it came at first glance seemed useful, but is problematic as you point out.

We've retested without that patch and are still getting good results.

Bruce
