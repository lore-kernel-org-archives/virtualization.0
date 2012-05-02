From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [Xen-devel] [PATCHv2] x86info: dump kvm cpuid's
Date: Wed, 02 May 2012 10:58:46 +0100
Message-ID: <1335952726.26758.34.camel@zakaz.uk.xensource.com>
References: <20120430143835.GA10190@redhat.com>
	<1335875225.6038.98.camel@zakaz.uk.xensource.com>
	<20120501130419.GJ22191@redhat.com>
	<1335951927.26758.24.camel@zakaz.uk.xensource.com>
	<20120502095053.GA31543@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120502095053.GA31543@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "davej@redhat.com" <davej@redhat.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2012-05-02 at 10:50 +0100, Michael S. Tsirkin wrote:
> On Wed, May 02, 2012 at 10:45:27AM +0100, Ian Campbell wrote:
> > On Tue, 2012-05-01 at 16:04 +0300, Gleb Natapov wrote:
> > > > BTW, according to arch/x86/include/asm/kvm_para.h unsurprisingly KVM has
> > > > a signature too 'KVMKVMKVM'.
> > > > 
> > > > >  	cpu->stepping = eax & 0xf;
> > > > >  	cpu->model = (eax >> 4) & 0xf;
> > > > >  	cpu->family = (eax >> 8) & 0xf;
> > > > > @@ -29,6 +29,19 @@ void get_cpu_info_basics(struct cpudata *cpu)
> > > > >  
> > > > >  	cpuid(cpu->number, 0xC0000000, &maxei, NULL, NULL, NULL);
> > > > >  	cpu->maxei2 = maxei;
> > > > > +	if (ecx & 0x80000000) {
> > > > > +		cpuid(cpu->number, 0x40000000, &maxhv, NULL, NULL, NULL);
> > > > > +		/*
> > > > > +		 * KVM up to linux 3.4 reports 0 as the max hypervisor leaf,
> > > > > +		 * where it really means 0x40000001.
> > > > 
> > > > This is something where I definitely think you want to check the
> > > > signature first.
> > > In theory yes, but in practice what will this break?
> > 
> > I've got no idea -- but what's the harm in checking?
> > 
> > Ian.
> 
> Users can set kvm signature to anything, if they do
> debugging will be a bit harder for them.

Ah, right, someone already mentioned that and I forgot, sorry.

And, just to complete my train of thought, cpuid just returns reserved
values for requests for non-existent leaves (rather than #GP for
example) so it's safe enough even if you do end up trying to read an
eax=0x40000001 when it doesn't exist.

Seems fine to me then.

Ian.

-- 
Ian Campbell
Current Noise: Hypocrisy - Buried

He's like a function -- he returns a value, in the form of his opinion.
It's up to you to cast it into a void or not.
		-- Phil Lapsley
