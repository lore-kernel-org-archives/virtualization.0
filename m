From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH] KVM simplified virtio balloon driver
Date: Sat, 19 Jan 2008 09:02:29 +0200
Message-ID: <4791A085.8060502__30665.5007684187$1200726687$gmane$org@qumranet.com>
References: <20080114200357.GA18354@dmt>
	<20080115190102.GA27645@dmt>	<1200525166.26281.103.camel@localhost.localdomain>
	<200801171245.59510.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801171245.59510.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> After discussions with Anthony Liguori, it seems that the virtio
> balloon can be made even simpler.  Here's my attempt.
>
> Since the balloon requires Guest cooperation anyway, there seems
> little reason to force it to tell the Host when it wants to reuse a
> page.  It can simply fault it in.
>
>   

Faulting is synchronous, while deflating is (or can be made) 
asynchronous. If the host needs to do some work to get the memory, the 
guest will be slowed down considerably.

If we have explicit deflate, the host can call madvise(MADV_WILLNEED) or 
actually touch the pages before the guest accesses them.


-- 
Any sufficiently difficult bug is indistinguishable from a feature.
