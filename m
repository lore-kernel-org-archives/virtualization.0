From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/5] lguest: avoid accidental recycling of pgdir pages
Date: Sat, 28 Mar 2009 17:07:22 +1030
Message-ID: <200903281707.22688.rusty__8899.28719630024$1238222785$gmane$org@rustcorp.com.au>
References: <200903271022.28863.rusty@rustcorp.com.au>
	<200903271154.22450.rusty@rustcorp.com.au>
	<49CCFFC0.1020904@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <49CCFFC0.1020904@goop.org>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: lguest@ozlabs.org, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 28 March 2009 03:03:04 Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> > Now, I haven't *seen* this happen...
> >   
> 
> Oh, maybe its because you already zap the shadows on tlb flush, and the 
> kernel is careful to tlb flush every pagetable page before freeing...

OK, you've convinced me.  I'll drop this patch.  It was as I was looking for
the inconsistent pte values that I thought of this issue.

Thanks!
Rusty.
