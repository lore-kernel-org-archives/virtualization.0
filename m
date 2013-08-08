From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH  V12 0/14] Paravirtualized ticket spinlocks
Date: Wed, 7 Aug 2013 20:50:12 -0400
Message-ID: <20130808005012.GI2810@phenom.dumpdata.com>
References: <20130806114020.20643.57235.sendpatchset@codeblue.in.ibm.com>
	<52016412.1020608@zytor.com> <5201B6FB.5080807@linux.vnet.ibm.com>
	<5201D180.9080005@zytor.com> <5201ED01.7000803@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5201ED01.7000803@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, stefano.stabellini@eu.citrix.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 07, 2013 at 12:15:21PM +0530, Raghavendra K T wrote:
> On 08/07/2013 10:18 AM, H. Peter Anvin wrote:
> >>Please let me know, if I should rebase again.
> >>
> >
> >tip:master is not a stable branch; it is more like linux-next.  We need
> >to figure out which topic branches are dependencies for this set.
> 
> Okay. I 'll start looking at the branches that would get affected.
> (Xen, kvm are obvious ones).
> Please do let me know the branches I might have to check for.

From the Xen standpoint anything past v3.11-rc4 would work.

> 
> 
> 
> 
> 
