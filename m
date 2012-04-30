From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V6 1/5] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Mon, 30 Apr 2012 11:19:35 +0300
Message-ID: <4F9E4B17.7060909@redhat.com>
References: <20120423095937.30893.14776.sendpatchset@codeblue.in.ibm.com>
	<20120423095947.30893.84029.sendpatchset@codeblue.in.ibm.com>
	<4F9D415B.7010103@redhat.com> <4F9E42F6.8050108@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F9E42F6.8050108@linux.vnet.ibm.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, X86 <x86@kernel.org>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Xen <xen-devel@lists.xensource.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/30/2012 10:44 AM, Raghavendra K T wrote:
>> Hm, what about reusing KVM_REQ_UNHALT?
>>
>
>
> Yes, I had experimented this for some time without success.
> For e.g. having
> make_request(KVM_REQ_UNHALT, vcpu) directly from kick hypercall.
>
> It would still need a flag. (did not get any alternative so far except
> the  workaround posted in V4) :(
>

Okay.

-- 
error compiling committee.c: too many arguments to function
