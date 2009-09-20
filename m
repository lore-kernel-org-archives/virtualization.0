From: Avi Kivity <avi@redhat.com>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Sun, 20 Sep 2009 22:00:00 +0300
Message-ID: <4AB67BB0.3020303@redhat.com>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com>	<20090919224430.GB9567@kroah.com>	<1253419185.3253.21.camel@ank32.eng.vmware.com>	<20090920074247.GA5733@elte.hu>
	<20090920095239.456ad6f2@infradead.org>
	<4AB5EF25.9070502@redhat.com> <4AB64EFC.10707@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AB64EFC.10707@goop.org>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, the arch/x86 maintainers <x86@kernel.org>, Alok Kataria <akataria@vmware.com>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On 09/20/2009 06:49 PM, Jeremy Fitzhardinge wrote:
>> kvm will be removing the pvmmu support soon; and Xen is talking about
>> running paravirtualized guests in a vmx/svm container where they don't
>> need most of the hooks.
>>
>>      
> We have no plans to drop support for non-vmx/svm capable processors, let
> alone require ept/npt.
>    

Today, certainly; similarly kvm will host-side pvmmu support for a while 
to support live migration from older hosts.

But in a few years it may make sense to run everything in a vmx/svm 
container even for Xen; we can then drop x86 pv_ops for good.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
