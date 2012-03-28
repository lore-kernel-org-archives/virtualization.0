From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V5 0/6] kvm : Paravirt-spinlock support for KVM guests
Date: Thu, 29 Mar 2012 00:02:29 +0530
Message-ID: <4F73593D.5020305@linux.vnet.ibm.com>
References: <20120323080503.14568.43092.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120323080503.14568.43092.sendpatchset@codeblue>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Alexander Graf <agraf@suse.de>, Gleb Natapov <gleb@redhat.com>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, X86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Xen <xen-devel@lists.xensource.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization <virtualization@lists.linux-foundation.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/23/2012 01:35 PM, Raghavendra K T wrote:
> The 6-patch series to follow this email extends KVM-hypervisor and Linux guest
> running on KVM-hypervisor to support pv-ticket spinlocks, based on Xen's
> implementation.
>
> One hypercall is introduced in KVM hypervisor,that allows a vcpu to kick
> another vcpu out of halt state.
> The blocking of vcpu is done using halt() in (lock_spinning) slowpath.
> one MSR is added to aid live migration.
>
> Changes in V5:
> - rebased to 3.3-rc6
> - added PV_UNHALT_MSR that would help in live migration (Avi)
> - removed PV_LOCK_KICK vcpu request and pv_unhalt flag (re)added.

Sorry for pinging
I know it is busy time. But I hope to get response on these patches in 
your free time, so that I can target next merge window for this. 
(whether it has reached some good state or it is heading in reverse 
direction!). it would really boost my morale.
especially MSR stuff and dropping vcpu request bit for PV unhalt.

- Raghu
