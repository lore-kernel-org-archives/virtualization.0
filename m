From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Xen paravirt frontend block hang
Date: Sun, 02 Mar 2008 07:35:13 -0800
Message-ID: <47CAC931.1000107__5157.42347711257$1204472706$gmane$org@goop.org>
References: <4772AC8E.7010007@theshore.net> <47C712EF.1060703@goop.org>
	<47C9F818.4020200@theshore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47C9F818.4020200@theshore.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Christopher S. Aker" <caker@theshore.net>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christopher S. Aker wrote:
> Jeremy Fitzhardinge wrote:
>> I've been running this all night without seeing any problem.  I'm 
>> using current x86.git#testing with a few local patches, but nothing 
>> especially relevent-looking.
>
> Meh .. what backend are you using?  We're using LVM volumes exported 
> directly into the domUs like so:
>
> disk =[ 'phy:vg1/xencaker-56392,xvda,w', ... ]
>
>> Could you try the attached patch to see if it makes any difference?
>
> Unfortunately we're still in the same place... pv_ops kernels are 
> still hanging after heavy disk IO:
>
> works - 2.6.18.x (from xen-unstable)
> hangs - 2.6.25-rc3-git3
> hangs - 2.6.25-rc3-git3 + your patch
>
> Any other suggestions or debugging I can provide that would be useful 
> to squash this? 

Are you running an SMP or UP domain?  I found I could get hangs very 
easily with UP (but I need confirm it isn't a result of some other very 
experimental patches).

    J
