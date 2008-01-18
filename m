From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/10] Tree fixes for PARAVIRT
Date: Fri, 18 Jan 2008 14:31:00 -0800
Message-ID: <479128A4.9070509__49333.7795757272$1200695803$gmane$org@goop.org>
References: <12006768251548-git-send-email-gcosta@redhat.com>	
	<20080118203259.GA3079@elte.hu> <20080118213711.GA24979@elte.hu>
	<1200693248.21817.157.camel@bodhitayantram.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1200693248.21817.157.camel@bodhitayantram.eng.vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: ak@suse.de, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, Ingo Molnar <mingo@elte.hu>, virtualization@lists.linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ehabkost@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Why are we rushing so much to do 64-bit paravirt that we are breaking
> working configurations?  If the developement is going to be this
> chaotic, it should be done and tested out of tree until it can
> stabilize.
>   

x86.git is out of the mainline tree, and it seems to be working fairly 
smoothly.  I've come to appreciate the "lots of small patches with quick 
turnaround" model that Ingo has been pushing.

> I do not like having to continuously retest and review the x86 branch
> because the paravirt-ops are constantly in flux and the 32-bit code
> keeps breaking.
>   

Most of the activity is pure unification, with paravirt being part of 
that.  It doesn't help that it increases the CONFIG_ combinatorial 
explosion, but "make randconfig" shakes things out fairly quickly.

> We won't be doing 64-bit paravirt-ops for exactly this reason - is there
> a serious justification from the performance angle on modern 64-bit
> hardware?  If not, why justify the complexity and hackery to Linux?
>   

A big part of the rationale is to unify 32 and 64 bit, so that paravirt 
isn't a gratuitous difference between the two.  Also, 32 and 64 bit Xen 
have almost identical interface requirements, so the work is making 
64-bit Xen progress (and lguest64, of course).

    J
