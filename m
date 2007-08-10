From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 23/25] [PATCH] paravirt hooks for arch initialization
Date: Fri, 10 Aug 2007 11:51:17 -0700
Message-ID: <46BCB3A5.8090504__20712.7081150704$1186772109$gmane$org@goop.org>
References: <11865467522495-git-send-email-gcosta@redhat.com>	
	<11865468394005-git-send-email-gcosta@redhat.com>	
	<11865468431616-git-send-email-gcosta@redhat.com>	
	<200708081144.04119.ak@suse.de> <46BB5258.8040609@goop.org>	
	<20070809190303.214e5457@the-village.bc.nu>
	<5d6222a80708101108y62ebfa26n9f47bfc52b48f4a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80708101108y62ebfa26n9f47bfc52b48f4a8@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: lguest@ozlabs.org, Steven@smtp2.linux-foundation.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
> On 8/9/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>   
>>> What's the EBDA actually used for?  The only place which seems to use
>>> ebda_addr is in the e820 code to avoid that area as RAM.
>>>       
>> It belongs to the firmware.
>>     
>
> Wouldn't it be better, then, to just skip this step unconditionally if
> we are running a paravirtualized guest? What do we from doing it?
>   

It's better to make discover_ebda() quietly cope with a missing ebda for
whatever reason.  We could add an explicit interface to paravirt_ops to
handle this one little corner, but it isn't very important, not very
general and really its just clutter.  Its much better to have things
cope with being virtualized quietly on their own rather than hit them
all with the pv_ops hammer.   pv_ops is really for things where the
hypervisor-specific code really has to get actively involved.

For Xen-domU and lguest, there probably won't be an ebda, but its quite
likely that it will be present in some form for vmware, kvm and
xen-dom0; in those cases the (presumably virtual) ebda will be put in
place as it would be in the native case, eliminating the need for any
special handling.

    J
