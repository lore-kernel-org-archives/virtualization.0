From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 3/5] lguest: avoid accidental recycling of pgdir pages
Date: Fri, 27 Mar 2009 09:28:12 -0700
Message-ID: <49CCFE9C.6060702__8419.88390679962$1238171562$gmane$org@goop.org>
References: <200903271022.28863.rusty@rustcorp.com.au>
	<49CC1B1C.3080102@goop.org>
	<200903271154.22450.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200903271154.22450.rusty@rustcorp.com.au>
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
Cc: lguest@ozlabs.org, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
>> You can't just do this in tlb flush?
>>     
>
> I don't think so.  The problem is that lguest tracks 4 toplevels, using random
> replacement.  This cache is indexed by cr3 value.
>
> Lguest assumes it's told about all pte removals or changes, but simple
> additions get faulted in.  If a pgdir page gets reused we'll potentially have
> stale values from its previous life as a pgdir, no?
>   

Yes, but when you get a tlb flush hypercall, couldn't you also look up 
the corresponding shadow pte and zap it so that it will get repopulated 
next time around?  And a full tlb flush would just zap the entire 
shadow.  After all, the shadow pagetable is just a glorified 
software-managed tlb...

    J
