From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [PATCHv2] x86info: dump kvm cpuid's
Date: Wed, 02 May 2012 10:45:27 +0100
Message-ID: <1335951927.26758.24.camel__28998.1294693009$1335951959$gmane$org@zakaz.uk.xensource.com>
References: <20120430143835.GA10190@redhat.com>
	<1335875225.6038.98.camel@zakaz.uk.xensource.com>
	<20120501130419.GJ22191@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120501130419.GJ22191@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: xen-devel@lists.xensource.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, pv-drivers@vmware.com, virtualization@lists.linux-foundation.org, devel@linuxdriverproject.org, davej@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2012-05-01 at 16:04 +0300, Gleb Natapov wrote:
> > BTW, according to arch/x86/include/asm/kvm_para.h unsurprisingly KVM has
> > a signature too 'KVMKVMKVM'.
> > 
> > >  	cpu->stepping = eax & 0xf;
> > >  	cpu->model = (eax >> 4) & 0xf;
> > >  	cpu->family = (eax >> 8) & 0xf;
> > > @@ -29,6 +29,19 @@ void get_cpu_info_basics(struct cpudata *cpu)
> > >  
> > >  	cpuid(cpu->number, 0xC0000000, &maxei, NULL, NULL, NULL);
> > >  	cpu->maxei2 = maxei;
> > > +	if (ecx & 0x80000000) {
> > > +		cpuid(cpu->number, 0x40000000, &maxhv, NULL, NULL, NULL);
> > > +		/*
> > > +		 * KVM up to linux 3.4 reports 0 as the max hypervisor leaf,
> > > +		 * where it really means 0x40000001.
> > 
> > This is something where I definitely think you want to check the
> > signature first.
> In theory yes, but in practice what will this break?

I've got no idea -- but what's the harm in checking?

Ian.

-- 
Ian Campbell
Current Noise: Hypocrisy - Roswell 47

Angels we have heard on High
Tell us to go out and Buy.
		-- Tom Lehrer
