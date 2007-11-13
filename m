From: Ravikiran Thirumalai <kiran@scalemp.com>
Subject: Re: [PATCH 24/24] make vsmp a paravirt client
Date: Tue, 13 Nov 2007 10:49:25 -0800
Message-ID: <20071113184925.GB10344__45005.7408809245$1194979908$gmane$org@localdomain>
References: <11946338683305-git-send-email-gcosta@redhat.com>
	<200711131333.41946.ak@suse.de> <47399DC8.7000504@redhat.com>
	<200711131409.41959.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711131409.41959.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 13, 2007 at 02:09:41PM +0100, Andi Kleen wrote:
>
>> If vsmp is selected, PARAVIRT will be too, and the interrupt code will
>> be patched.
>> the vsmp option triggers a select statement.
>> 
>> the ifdef only exists because, as I said, the code itself will be always
>> compiled in, to avoid an ifdef in setup_64.c. So it's just a taking it
>> from here, putting it there issue.
>
>Peeking around needlessly in pci config space at each boot just to avoid an 
>ifdef is not an good idea.

Agreed.  vsmp_init does not make sense unless the irq ops are patched.  We
can call vsmp_init under #ifdef CONFIG_PARAVIRT.

Thanks,
Kiran
