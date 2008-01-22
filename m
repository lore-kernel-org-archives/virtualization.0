From: Jeremy Fitzhardinge <Jeremy.Fitzhardinge@citrix.com>
Subject: Re: [PATCH 0/4] paravirt_ops-64 compile fixes
Date: Tue, 22 Jan 2008 12:05:14 -0800
Message-ID: <47964C7A.6000609__5333.51417766443$1201032495$gmane$org@citrix.com>
References: <1200952133-31581-1-git-send-email-ehabkost@redhat.com>	<20080122120207.GA30271@elte.hu>	<20080122123450.GU7338@blackpad>
	<47962E1D.2090308@goop.org> <20080122194710.GC3218@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080122194710.GC3218@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Eduardo Pereira Habkost <ehabkost@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>>> Maybe should this force-paravirt mode be a kernel debugging option?
>>>       
>> No, just a plain CONFIG_PARAVIRT to turn it on and off independently 
>> of everything else.
>>     
>
> it should be a debugging option in the way that it's dependent on 
> KERNEL_DEBUG and KERNEL_EXPERIMENTAL.
>   

EXPERIMENTAL certainly, but not DEBUG.  Sure, CONFIG_PARAVIRT is 
somewhat useless if you don't also configure Xen/lguest/etc, but running 
a paravirt system on bare hardware will probably be the most common way 
a paravirt kernel gets run (a distro will always enable it and compile 
in whatever hypervisor support they want, but most people will end up 
just running it on bare hardware).  Therefore, we should try to be as 
sure as possible that PARAVIRT works well (ie, indistinguishable from 
non-PARAVIRT) on bare hardware.

> i dont think you shold worry about this - i think 64-bit guest support 
> for specific hypervisors could be added even after the merge window, if 
> it's reasonably isolated (which i'd expect it to be). It clearly cannot 
> break anything else so it's the same category as new driver or new 
> hardware support - more relaxed integration rules. Then we can remove 
> the KERNEL_DEBUG and KERNEL_EXPERIMENTAL dependency as well.

Good, I'm glad you feel that way.

    J
