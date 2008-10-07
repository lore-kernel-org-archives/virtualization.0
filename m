From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors	and	Linux.
Date: Tue, 07 Oct 2008 16:45:43 -0700
Message-ID: <48EBF4A7.3080704__48374.6867430911$1223423281$gmane$org@goop.org>
References: <1222881242.9381.17.camel@alok-dev1>	 <48E3B19D.6060905@zytor.com>
	<1222882431.9381.23.camel@alok-dev1>	 <48E3BC21.4080803@goop.org>
	<1222895153.9381.69.camel@alok-dev1> <48E3FDD5.7040106@zytor.com>
	<0B53E02A2965CE4F9ADB38B34501A3A15D927EA4@orsmsx505.amr.corp.intel.com>
	<48E422CA.2010606@zytor.com>
	<0B53E02A2965CE4F9ADB38B34501A3A15DCBA221@orsmsx505.amr.corp.intel.com>
	<48E6AB15.8060405@zytor.com>
	<0B53E02A2965CE4F9ADB38B34501A3A15DCBA325@orsmsx505.amr.corp.intel.com>
	<48E6BA5B.2090804@zytor.com>
	<0B53E02A2965CE4F9ADB38B34501A3A15DE4F934@orsmsx505.amr.corp.intel.com>
	<48EBE499.5000304@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48EBE499.5000304@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "avi@redhat.com" <avi@redhat.com>, "akataria@vmware.com" <akataria@vmware.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> And you're absolutely right that the guest may end up picking and 
> choosing different parts of the interfaces.  That's how it is supposed 
> to work. 

No, that would be a horrible, horrible mistake.  There's no sane way to 
implement that; it would mean that the hypervisor would have to have 
some kind of state model that incorporates all the ABIs in a consistent 
way.  Any guest using multiple ABIs would effectively end up being 
dependent on a particular hypervisor via a frankensteinian interface 
that no other hypervisor would implement in the same way, even if they 
claim to implement the same set of interfaces.

If the hypervisor just needs to deal with one at a time then it can have 
relatively simple ABI<->internal state translation.

However, if you have the notion of hypervisor-agnostic or common 
interfaces, then you can include those as part of the rest of the ABI 
and make it sane (so Xen+common, hyperv+common, etc).

    J
