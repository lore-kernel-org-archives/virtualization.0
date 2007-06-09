From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: lguest/host benchmarks.
Date: Sat, 9 Jun 2007 01:27:05 -0300
Message-ID: <5d6222a80706082127j6a12f4ddlff73f5633bbfa222@mail.gmail.com>
References: <Pine.LNX.4.60.0706011704240.786@rtl14.hofr.at>
	<1180780059.9228.72.camel@localhost.localdomain>
	<Pine.LNX.4.60.0706080908100.811@rtl14.hofr.at>
	<1181362602.6025.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1181362602.6025.72.camel@localhost.localdomain>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

>
> Yes.  A real page fault hurts quite a bit, because all page faults go
> via the host (which can swap out guest pages or have them COW).

I expect it to be even slower in 64-bit lguest, due to the added
complexity of the 4-level page table. But me and rostedt have not yet
made any benchmark for it _at all_, since we're mostly stuck trying to
make it smp ;-) (bugs, bugs, bugs)

Nick, are you willing to help us in 64-bit too?

thanks!

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
