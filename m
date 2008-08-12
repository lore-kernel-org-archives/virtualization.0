From: Mike Day <ncmike@ncultra.org>
Subject: Re: Announcing: Open OVF project source code availibility
Date: Tue, 12 Aug 2008 12:59:11 -0400
Message-ID: <20080812165911.GB8457__49119.6097959348$1218560506$gmane$org@silverwood.ncultra.org>
References: <20080812143432.GA8431@silverwood.ncultra.org>
	<20080812144656.GQ13067@redhat.com>
	<20080812152634.GA8457@silverwood.ncultra.org>
	<20080812154236.GS13067@redhat.com>
Reply-To: ncmike@ncultra.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080812154236.GS13067@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: xen-devel@lists.xensource.com, smoser@us.ibm.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 12/08/08 16:42 +0100, Daniel P. Berrange wrote:


> > For runtime integration, we are planning on implementing an XML-RPC
> > interface into and out of the ovf library, which will allow any other
> > runtime code to interact with it. 
> 
> It is the runtime integration I was refering to. The open-ovf tools
> are all python. So is virt-manage/install/image. If these tools were
> under a license that were compatible with usage from a GPL  licensed
> app, then I could simply call into the OVF APIs. Building an XML-RPC
> interface just to call into functions for manipulating OVF files is
> rather overkill. 

Perhaps locally, but certainly not overkill for remote access. Local
access to XML-RPC via the loopback is still pretty efficient within
the realm of interpreted languages. And the original OVA environment
specification requires a remote API. (The DMTF did not adopt the
environment services in its standard.) For example, a software
appliance running in a guest needs to query the OVF daemon for
information about its hosting hypervisor. This is best done by remote
procedure calls.
 
> But perhaps you don't intend to maintain the python libraries as an
> official 'public' API for other apps to use ?

We hope to establish remote APIs for use by guests at
runtime. Whatever else comes about is up to the community.

Mike
-- 
Mike Day
http://www.ncultra.org
AIM: ncmikeday |  Yahoo IM: ultra.runner
PGP key: http://www.ncultra.org/ncmike/pubkey.asc
