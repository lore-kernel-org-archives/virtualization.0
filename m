From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH RFC V5 0/6] kvm : Paravirt-spinlock support for KVM guests
Date: Wed, 11 Apr 2012 21:26:46 -0300
Message-ID: <20120412002646.GC32051@amt.cnet>
References: <20120323080503.14568.43092.sendpatchset@codeblue>
	<4F73593D.5020305@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4F73593D.5020305@linux.vnet.ibm.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, X86 <x86@kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization <virtualization@lists.linux-foundation.org>, Xen <xen-devel@lists.xensource.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 29, 2012 at 12:02:29AM +0530, Raghavendra K T wrote:
> On 03/23/2012 01:35 PM, Raghavendra K T wrote:
> >The 6-patch series to follow this email extends KVM-hypervisor and Linux guest
> >running on KVM-hypervisor to support pv-ticket spinlocks, based on Xen's
> >implementation.
> >
> >One hypercall is introduced in KVM hypervisor,that allows a vcpu to kick
> >another vcpu out of halt state.
> >The blocking of vcpu is done using halt() in (lock_spinning) slowpath.
> >one MSR is added to aid live migration.
> >
> >Changes in V5:
> >- rebased to 3.3-rc6
> >- added PV_UNHALT_MSR that would help in live migration (Avi)
> >- removed PV_LOCK_KICK vcpu request and pv_unhalt flag (re)added.
> 
> Sorry for pinging
> I know it is busy time. But I hope to get response on these patches
> in your free time, so that I can target next merge window for this.
> (whether it has reached some good state or it is heading in reverse
> direction!). it would really boost my morale.
> especially MSR stuff and dropping vcpu request bit for PV unhalt.
> 
> - Raghu

Looks good. Only the MSR appears an abuse, since there is no need
to expose the info to the guest.
