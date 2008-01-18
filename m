From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 0/10] Tree fixes for PARAVIRT
Date: Fri, 18 Jan 2008 13:54:08 -0800
Message-ID: <1200693248.21817.157.camel__23134.6935070635$1200693003$gmane$org@bodhitayantram.eng.vmware.com>
References: <12006768251548-git-send-email-gcosta@redhat.com>
	<20080118203259.GA3079@elte.hu>  <20080118213711.GA24979@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080118213711.GA24979@elte.hu>
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
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2008-01-18 at 22:37 +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > The first fix is not even specific for PARAVIRT, and it's actually 
> > > preventing the whole tree from booting.
> > 
> > on CONFIG_EFI, indeed :)
> 
> but in exchange you broke all of 32-bit with CONFIG_PARAVIRT=y. Which 
> means you did not even build-test it on 32-bit, let alone boot test 
> it...

Why are we rushing so much to do 64-bit paravirt that we are breaking
working configurations?  If the developement is going to be this
chaotic, it should be done and tested out of tree until it can
stabilize.

I do not like having to continuously retest and review the x86 branch
because the paravirt-ops are constantly in flux and the 32-bit code
keeps breaking.

We won't be doing 64-bit paravirt-ops for exactly this reason - is there
a serious justification from the performance angle on modern 64-bit
hardware?  If not, why justify the complexity and hackery to Linux?

Zach
