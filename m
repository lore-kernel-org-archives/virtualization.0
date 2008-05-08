From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH/RFC] stop_machine: make stop_machine_run more
	virtualization friendly
Date: Thu, 08 May 2008 15:58:32 +0100
Message-ID: <48231518.9010209__42641.4319932975$1210260076$gmane$org@goop.org>
References: <200805081520.38310.borntraeger@de.ibm.com>
	<48230137.9090705@goop.org>
	<200805081641.20572.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805081641.20572.borntraeger@de.ibm.com>
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

Christian Borntraeger wrote:
> I really like 64 guest cpus as a good testcase for all kind of things. 
>   

Sure, I do the same kind of thing.

>> I think x86 (at least) is now using ticket locks, which is fair.  Which 
>> kernel are you seeing this problem on?
>>     
>
> Sorry, forgot to mention. Its kvm.git from 2 days ago on s390.
>   

And on s390 cpu_relax yields the vcpu?  That's not common behaviour 
across architectures.

    J
