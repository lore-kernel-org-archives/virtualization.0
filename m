From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: Announcing: Open OVF project source code availibility
Date: Tue, 12 Aug 2008 16:42:36 +0100
Message-ID: <20080812154236.GS13067__35685.4473743171$1218555940$gmane$org@redhat.com>
References: <20080812143432.GA8431@silverwood.ncultra.org>
	<20080812144656.GQ13067@redhat.com>
	<20080812152634.GA8457@silverwood.ncultra.org>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080812152634.GA8457@silverwood.ncultra.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mike Day <ncmike@ncultra.org>
Cc: xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, smoser@us.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 12, 2008 at 11:26:34AM -0400, Mike Day wrote:
> On 12/08/08 15:46 +0100, Daniel P. Berrange wrote:
> > 
> > Why was the Eclipse Public License chosen ?  This license is not
> > compatible with the GPL[1], so no GPL licensed app can make use of
> > this code :-( For example it makes it impossible to use this code to
> > assist in supporting OVF in virt-manager, virt-install or virt-image
> > 
> >   http://en.wikipedia.org/wiki/Eclipse_Public_License
> > 
> >   "The EPL 1.0 is not compatible with the GPL, and a work created by
> >    combining a work licensed under the GPL with a work licensed under
> >    the EPL cannot be lawfully distributed."
> > 
> 
> As a file format, the output from open-ovf can be used by any
> code of any license. That is, any code can consume an OVF file.

Yep, that's not what I'm concerned with.

> For runtime integration, we are planning on implementing an XML-RPC
> interface into and out of the ovf library, which will allow any other
> runtime code to interact with it. 

It is the runtime integration I was refering to. The open-ovf tools
are all python. So is virt-manage/install/image. If these tools were
under a license that were compatible with usage from a GPL  licensed
app, then I could simply call into the OVF APIs. Building an XML-RPC
interface just to call into functions for manipulating OVF files is
rather overkill. 

But perhaps you don't intend to maintain the python libraries as an
official 'public' API for other apps to use ?

Daniel
-- 
|: Red Hat, Engineering, London   -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org  -o-  http://virt-manager.org  -o-  http://ovirt.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-  F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|
