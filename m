From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [Xen-devel] x86info: dump kvm cpuid's
Date: Tue, 1 May 2012 11:29:04 +0100
Message-ID: <1335868144.6038.89.camel@zakaz.uk.xensource.com>
References: <20120429101019.GA21165@redhat.com>
	<20120430084319.GE15413@redhat.com> <20120430093811.GC5414@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120430093811.GC5414@redhat.com>
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

On Mon, 2012-04-30 at 10:38 +0100, Michael S. Tsirkin wrote:
> On Mon, Apr 30, 2012 at 11:43:19AM +0300, Gleb Natapov wrote:
> > On Sun, Apr 29, 2012 at 01:10:21PM +0300, Michael S. Tsirkin wrote:
> > > The following makes 'x86info -r' dump kvm cpu ids
> > > (signature+features) when running in a vm.
> > > 
> > > On the guest we see the signature and the features:
> > > eax in: 0x40000000, eax = 00000000 ebx = 4b4d564b ecx = 564b4d56 edx = 0000004d
> > > eax in: 0x40000001, eax = 0100007b ebx = 00000000 ecx = 00000000 edx = 00000000
> > > 
> > > On the host it just adds a couple of zero lines:
> > > eax in: 0x40000000, eax = 00000000 ebx = 00000000 ecx = 00000000 edx = 00000000
> > > eax in: 0x40000001, eax = 00000000 ebx = 00000000 ecx = 00000000 edx = 00000000
> > > 
> > This is too KVM specific.
> 
> That's what I have. I scratch my own itch.
> 
> > Other hypervisors may use more cpuid leafs.
> 
> But not less so no harm's done.
> 
> > As far as I see Hyper-V uses 5 and use cpuid.0x40000000.eax as max cpuid
> > leaf available. Haven't checked Xen or VMWare.

Xen does the same, documentation in the Xen public interfaces header:
http://xenbits.xen.org/docs/unstable/hypercall/include,public,arch-x86,cpuid.h.html.

If compat mode for another h/v is enabled then those leaves will appear
at 0x40000000 and Xen's will be bumped up, so a fully Xen aware set of
drivers (or detection routine, etc) should check at 0x100 intervals
until 0x40010000 for the appropriate signatures (I realise that the docs
are somewhat lacking in this regard, I should cook up a patch).

Ian.
