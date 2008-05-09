From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH/RFC] stop_machine: make stop_machine_run more
	virtualization friendly
Date: Fri, 9 May 2008 11:10:11 +1000
Message-ID: <200805091110.12271.rusty__9673.16390383548$1210295582$gmane$org@rustcorp.com.au>
References: <200805081520.38310.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805081520.38310.borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 08 May 2008 23:20:38 Christian Borntraeger wrote:
> Changing stop_machine to yield the cpu to the hypervisor when yielding
> inside the guest fixed the problem for me. While I am not completely happy
> with this patch, I think it causes no harm and it really improves the
> situation for me.

Yes, this change is harmless.  I'm reworking (ie. rewriting) stop_machine at 
the moment to simplify it, and as a side effect it won't be yielding.  (The 
yield is almost useless, since there's nothing at same priority as this 
thread anyway).

I've included this patch for my next push to Linus.

Thanks,
Rusty.
