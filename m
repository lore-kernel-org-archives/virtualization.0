From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC PATCH v6 55/92] kvm: introspection: add KVMI_CONTROL_MSR
	and KVMI_EVENT_MSR
Date: Mon, 19 Aug 2019 11:36:44 -0700
Message-ID: <20190819183643.GB1916@linux.intel.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-56-alazar@bitdefender.com>
	<20190812210501.GD1437@linux.intel.com>
	<f9e94e9649f072911cc20129c2b633747d5c1df5.camel@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f9e94e9649f072911cc20129c2b633747d5c1df5.camel@bitdefender.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nicusor CITU <ncitu@bitdefender.com>
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C <yu.c.zhang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel =?iso-8859-1?Q?Laur=E9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Zhang@vger.kernel.org" <Zhang@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 15, 2019 at 06:36:44AM +0000, Nicusor CITU wrote:
> > > +	void (*msr_intercept)(struct kvm_vcpu *vcpu, unsigned int msr,
> > > +				bool enable);
> > 
> > This should be toggle_wrmsr_intercept(), or toggle_msr_intercept()
> > with a paramter to control RDMSR vs. WRMSR.
> 
> Ok, I can do that.
> 
> 
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index 6450c8c44771..0306c7ef3158 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -7784,6 +7784,15 @@ static __exit void hardware_unsetup(void)
> > >  	free_kvm_area();
> > >  }
> > >  
> > > +static void vmx_msr_intercept(struct kvm_vcpu *vcpu, unsigned int
> > > msr,
> > > +			      bool enable)
> > > +{
> > > +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> > > +	unsigned long *msr_bitmap = vmx->vmcs01.msr_bitmap;

Is KVMI intended to play nice with nested virtualization?  Unconditionally
updating vmcs01.msr_bitmap is correct regardless of whether the vCPU is in
L1 or L2, but if the vCPU is currently in L2 then the effective bitmap,
i.e. vmcs02.msr_bitmap, won't be updated until the next nested VM-Enter.

> > > +
> > > +	vmx_set_intercept_for_msr(msr_bitmap, msr, MSR_TYPE_W, enable);
> > > +}
> > 
> > Unless I overlooked a check, this will allow userspace to disable
> > WRMSR interception for any MSR in the above range, i.e. userspace can
> > use KVM to gain full write access to pretty much all the interesting
> > MSRs. This needs to only disable interception if KVM had interception
> > disabled before introspection started modifying state.
> 
> We only need to enable the MSR interception. We never disable it -
> please see kvmi_arch_cmd_control_msr().

In that case, drop @enable and use enable_wrmsr_intercept() or something
along those lines for kvm_x86_ops instead of toggle_wrmsr_intercept().
