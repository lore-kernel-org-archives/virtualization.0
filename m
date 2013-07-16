From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH RFC V10 15/18] kvm : Paravirtual ticketlocks support for
	linux guests running on KVM hypervisor
Date: Tue, 16 Jul 2013 19:31:04 +0300
Message-ID: <20130716163104.GD8981@redhat.com>
References: <20130624124014.27508.8906.sendpatchset@codeblue.in.ibm.com>
	<20130624124342.27508.44656.sendpatchset@codeblue.in.ibm.com>
	<20130714131241.GA11772@redhat.com>
	<51E3C5CE.7000009@linux.vnet.ibm.com>
	<20130715103648.GN11772@redhat.com>
	<51E4C011.4060803@linux.vnet.ibm.com>
	<20130716060215.GE11772@redhat.com>
	<20130716154852.GN23818@dyad.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130716154852.GN23818@dyad.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: jeremy@goop.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, gregkh@suse.de, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 16, 2013 at 05:48:52PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 16, 2013 at 09:02:15AM +0300, Gleb Natapov wrote:
> > BTW can NMI handler take spinlocks? 
> 
> No -- that is, yes you can using trylock, but you still shouldn't.
> 
Great news for this code. Thanks.

--
			Gleb.
