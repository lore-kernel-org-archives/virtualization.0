From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH/RFC 3/4]Introduce "account modifiers"
	mechanism
Date: Fri, 17 Aug 2007 15:32:32 +0200
Message-ID: <200708171532.32850.borntraeger__8549.10286511785$1187357809$gmane$org@de.ibm.com>
References: <46C4719A.2060308@bull.net> <46C59AB1.6070505@qumranet.com>
	<46C59DC6.4020308@bull.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C59DC6.4020308@bull.net>
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
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Am Freitag, 17. August 2007 schrieb Laurent Vivier:
> > The normal user/system accounting has the same issue, no?  Whereever we
> > happen to land (kernel or user) gets the whole tick.
> 
> Yes... but perhaps I should rewrite this too ;-)

If you look further, you will see, that this was actually rewritten in 2.6.12 
and thats why we have cputime_t. The infrastructure is currently only used by 
s390 and ppc64. On s390 we use our cpu timer to get the current time on each 
syscall/irq/context switch etc to get precise accounting data for 
system/user/irq/softirq/nice. We also get steal time (this is interesting for 
the guest: how much of my cpu was actually not available because the 
hypervisor scheduled me away). I dont know enough about other architectures  
to say which one could exploit this infrastructure as well.

The current git tree is somewhat broken for CONFIG_VIRT_CPU_ACCOUTING due to 
the accouting changes introduced by CFS - we work on this.

If you are interested in the cputime stuff, you can have a look at 
arch/s390/kernel/vtime.c (account_system_vtime, account_vtime) as well as:

http://git.kernel.org/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commit;h=6be7071fdd321c206b1ee7a3e534782f25572830
for the first introduction and
http://git.kernel.org/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commit;h=db59f519d37f80683f3611927f6b5c3bdfc0f9e6
for the s390 exploitation.

Christian
