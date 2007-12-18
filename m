From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [virtio-net][PATCH] Don't arm tx hrtimer with
	a	constant 500us each transmit
Date: Tue, 18 Dec 2007 18:24:56 +1100
Message-ID: <200712181824.57235.rusty__46416.7841630571$1197962798$gmane$org@rustcorp.com.au>
References: <475FD9E8.1060109@qumranet.com>
	<200712181101.14916.rusty@rustcorp.com.au>
	<47675AE0.8050808@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47675AE0.8050808@qumranet.com>
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
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, netdev@vger.kernel.org, dor.laor@qumranet.com, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 18 December 2007 16:30:08 Avi Kivity wrote:
> Rusty Russell wrote:
> >     Yes, I pondered this when I wrote the code.  On the one hand, it's a
> > low-probability pathological corner case, on the other, your patch
> > reduces the number of timer reprograms in the normal case.
>
> One thing that came up in our discussions is to let the host do the
> timer processing instead of the guest.  When tx exit mitigation is
> enabled, the guest bumps the queue pointer, but carefully refrains from
> kicking the host.  The host polls the tx pointer using a timer, kicking
> itself periodically; if polling yields no packets it disables tx exit
> mitigation.  This saves the guest the bother of programming the timer,
> which presumably requires an exit if the timer is the closest one to
> expiration.
>
> [btw, this can be implemented in virtqueue rather than virtio-net, no?]

Yes, the current patch is a hack (look at the hardcoded constant); wanted to 
see how much it helps, if any.

More sophisticated timer management would be a definite win... funny, I have a 
patch here which helps that....

Rusty.
