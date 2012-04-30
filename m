From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: x86info: dump kvm cpuid's
Date: Mon, 30 Apr 2012 12:38:13 +0300
Message-ID: <20120430093811.GC5414@redhat.com>
References: <20120429101019.GA21165@redhat.com>
	<20120430084319.GE15413@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120430084319.GE15413@redhat.com>
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
Cc: xen-devel@lists.xensource.com, kvm@vger.kernel.org, pv-drivers@vmware.com, virtualization@lists.linux-foundation.org, devel@linuxdriverproject.org, davej@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 30, 2012 at 11:43:19AM +0300, Gleb Natapov wrote:
> On Sun, Apr 29, 2012 at 01:10:21PM +0300, Michael S. Tsirkin wrote:
> > The following makes 'x86info -r' dump kvm cpu ids
> > (signature+features) when running in a vm.
> > 
> > On the guest we see the signature and the features:
> > eax in: 0x40000000, eax = 00000000 ebx = 4b4d564b ecx = 564b4d56 edx = 0000004d
> > eax in: 0x40000001, eax = 0100007b ebx = 00000000 ecx = 00000000 edx = 00000000
> > 
> > On the host it just adds a couple of zero lines:
> > eax in: 0x40000000, eax = 00000000 ebx = 00000000 ecx = 00000000 edx = 00000000
> > eax in: 0x40000001, eax = 00000000 ebx = 00000000 ecx = 00000000 edx = 00000000
> > 
> This is too KVM specific.

That's what I have. I scratch my own itch.

> Other hypervisors may use more cpuid leafs.

But not less so no harm's done.

> As far as I see Hyper-V uses 5 and use cpuid.0x40000000.eax as max cpuid
> leaf available. Haven't checked Xen or VMWare.

I don't think guessing at the CPU behaviour from linux source
is the right thing to do.

I Cc'd some addresses found in MAINTAINERS in the linux
kernel. This will give more people the opportunity
to ask for their stuff to be added, if they care.

> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ---
> > 
> > Dave - not sure whether there's a mailing list for x86info.
> > The patch is on top of the master branch in
> > git://git.codemonkey.org.uk/x86info.git
> > 
> > Thanks!
> > 
> > diff --git a/x86info.c b/x86info.c
> > index 22c4734..dee5ed1 100644
> > --- a/x86info.c
> > +++ b/x86info.c
> > @@ -44,6 +44,7 @@ static void display_detailed_info(struct cpudata *cpu)
> >  
> >  		if (cpu->maxei2 >=0xC0000000)
> >  			dump_raw_cpuid(cpu->number, 0xC0000000, cpu->maxei2);
> > +		dump_raw_cpuid(cpu->number, 0x40000000, 0x40000001);
> >  	}
> >  
> >  	if (show_cacheinfo) {
> 
> --
> 			Gleb.
