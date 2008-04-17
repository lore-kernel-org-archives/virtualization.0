From: Ryan Harper <ryanh@us.ibm.com>
Subject: Re: [PATCH] add virtio disk geometry feature
Date: Thu, 17 Apr 2008 09:37:38 -0500
Message-ID: <20080417143738.GE17938__30400.8074258038$1208444165$gmane$org@us.ibm.com>
References: <1208372197-20815-1-git-send-email-ryanh@us.ibm.com>
	<200804170715.55041.rusty@rustcorp.com.au>
	<4806706E.10701@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4806706E.10701@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Hollis Blanchard <hollisb@us.ibm.com>, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

* Anthony Liguori <aliguori@us.ibm.com> [2008-04-16 16:33]:
> Rusty Russell wrote:
> >On Thursday 17 April 2008 04:56:37 Ryan Harper wrote:
> >  
> >>From: Ryan Harper <ryanh@us.ibm.com>
> >>
> >>Rather than faking up some geometry, allow the backend to push the disk
> >>geometry via virtio pci config option.  Keep the old geo code around for
> >>compatibility.
> >>    
> >
> >Hi Ryan,
> >
> >   Looks good! Some brief review below.  Mainly just "how I would have done
> >things" stuff.  BTW, does this help in real life?  I assume something in
> >userspace wants it?
> >  
> 
> Boot loaders (like grub) query the geometry from the kernel to figure 
> out how to setup the stage1/stage2.  We've seen strange issues with grub 
> thinking it has crazy geometries when installed on a virtio disk (as 
> opposed to booting from virtio with an existing disk).
> 
> Ryan: have you tested a hardy install with your patches?  Does it help 
> when installing to virtio?  I could pretty reliably reproduce the 
> strangeness with a 20GB disk image FWIW.

I had tested out hardy with a 10G disk and saw nothing out of the
ordinary.  Disk size was the expected value and grub had no issues with
it.

-- 
Ryan Harper
Software Engineer; Linux Technology Center
IBM Corp., Austin, Tx
(512) 838-9253   T/L: 678-9253
ryanh@us.ibm.com
