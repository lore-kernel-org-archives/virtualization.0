From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] stop_machine: make stop_machine_run more
	virtualization friendly
Date: Thu, 8 May 2008 18:23:35 +0200
Message-ID: <200805081823.35696.borntraeger__47841.9175874025$1210264248$gmane$org@de.ibm.com>
References: <200805081520.38310.borntraeger@de.ibm.com>
	<200805081641.20572.borntraeger@de.ibm.com>
	<48231518.9010209@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48231518.9010209@goop.org>
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
Cc: kvm-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Donnerstag, 8. Mai 2008 schrieb Jeremy Fitzhardinge:
> > Sorry, forgot to mention. Its kvm.git from 2 days ago on s390.
> >   
> 
> And on s390 cpu_relax yields the vcpu?  That's not common behaviour 
> across architectures.


Yes, cpu_relax on s390 calls diagnose 44. Diagnose 44 translates to yield on 
z/VM and LPAR. Guessing from the number of the diagnose, I think it was used 
on z/VM for timeslice yielding long before Linux came to s390.
