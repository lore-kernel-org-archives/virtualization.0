From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2] x86info: dump kvm cpuid's
Date: Tue, 1 May 2012 15:35:13 +0300
Message-ID: <20120501123513.GA8019@redhat.com>
References: <20120430143835.GA10190@redhat.com>
	<1335875225.6038.98.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1335875225.6038.98.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ian Campbell <ijc@hellion.org.uk>
Cc: xen-devel@lists.xensource.com, kvm@vger.kernel.org, pv-drivers@vmware.com, virtualization@lists.linux-foundation.org, devel@linuxdriverproject.org, davej@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 01, 2012 at 01:27:05PM +0100, Ian Campbell wrote:
> On Mon, 2012-04-30 at 17:38 +0300, Michael S. Tsirkin wrote:
> > The following makes 'x86info -r' dump hypervisor leaf cpu ids
> > (for kvm this is signature+features) when running in a vm.
> > 
> > On the guest we see the signature and the features:
> > eax in: 0x40000000, eax = 00000000 ebx = 4b4d564b ecx = 564b4d56 edx = 0000004d
> > eax in: 0x40000001, eax = 0100007b ebx = 00000000 ecx = 00000000 edx = 00000000
> > 
> > Hypervisor flag is checked to avoid output changes when not
> > running on a VM.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > Changes from v1:
> > 	Make work on non KVM hypervisors (only KVM was tested).
> > 	Avi Kivity said kvm will in the future report
> > 	max HV leaf in eax. For now it reports eax = 0
> >         so add a work around for that.
> > 
> > ---
> > 
> > diff --git a/identify.c b/identify.c
> > index 33f35de..a4a3763 100644
> > --- a/identify.c
> > +++ b/identify.c
> > @@ -9,8 +9,8 @@
> >  
> >  void get_cpu_info_basics(struct cpudata *cpu)
> >  {
> > -	unsigned int maxi, maxei, vendor, address_bits;
> > -	unsigned int eax;
> > +	unsigned int maxi, maxei, maxhv, vendor, address_bits;
> > +	unsigned int eax, ebx, ecx;
> >  
> >  	cpuid(cpu->number, 0, &maxi, &vendor, NULL, NULL);
> >  	maxi &= 0xffff;		/* The high-order word is non-zero on some Cyrix CPUs */
> > @@ -19,7 +19,7 @@ void get_cpu_info_basics(struct cpudata *cpu)
> >  		return;
> >  
> >  	/* Everything that supports cpuid supports these. */
> > -	cpuid(cpu->number, 1, &eax, NULL, NULL, NULL);
> > +	cpuid(cpu->number, 1, &eax, &ebx, &ecx, NULL);
> 
> You probably want to check ebx, ecx, edx for the signatures of the
> hypervisor's you are willing to support and which you know do something
> sane with eax?

Everyone puts the max leaf in eax - this is what hardware
CPUs do. So I think we can just interpret eax as such.
If someone wants to put broken info in cpuid,
send a patch to blacklist it.

> Also it would be something worth reporting in its own
> right?
> 
> BTW, according to arch/x86/include/asm/kvm_para.h unsurprisingly KVM has
> a signature too 'KVMKVMKVM'.
> 
> >  	cpu->stepping = eax & 0xf;
> >  	cpu->model = (eax >> 4) & 0xf;
> >  	cpu->family = (eax >> 8) & 0xf;
> > @@ -29,6 +29,19 @@ void get_cpu_info_basics(struct cpudata *cpu)
> >  
> >  	cpuid(cpu->number, 0xC0000000, &maxei, NULL, NULL, NULL);
> >  	cpu->maxei2 = maxei;
> > +	if (ecx & 0x80000000) {
> > +		cpuid(cpu->number, 0x40000000, &maxhv, NULL, NULL, NULL);
> > +		/*
> > +		 * KVM up to linux 3.4 reports 0 as the max hypervisor leaf,
> > +		 * where it really means 0x40000001.
> 
> This is something where I definitely think you want to check the
> signature first.
> 
> Ian.

kvm lets users change the signature.
But worst case we print one useless line.
Better than not printing something potentially useful.

-- 
MST
