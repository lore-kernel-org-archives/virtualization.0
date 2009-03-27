From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/5] lguest: avoid accidental recycling of pgdir pages
Date: Fri, 27 Mar 2009 11:54:20 +1030
Message-ID: <200903271154.22450.rusty__42827.7710023851$1238117230$gmane$org@rustcorp.com.au>
References: <200903271022.28863.rusty@rustcorp.com.au>
	<49CC1B1C.3080102@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <49CC1B1C.3080102@goop.org>
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

On Friday 27 March 2009 10:47:32 Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> > Impact: potential bugfix
> >
> > In theory, the kernel could reuse the same page as pgdir for a new process
> > while the hypervisor keeps it cached.  This would have undesirable results.
> >   
> 
> You can't just do this in tlb flush?

I don't think so.  The problem is that lguest tracks 4 toplevels, using random
replacement.  This cache is indexed by cr3 value.

Lguest assumes it's told about all pte removals or changes, but simple
additions get faulted in.  If a pgdir page gets reused we'll potentially have
stale values from its previous life as a pgdir, no?

Now, I haven't *seen* this happen...
Rusty.
