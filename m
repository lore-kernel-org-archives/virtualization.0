From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Thu, 7 May 2009 03:27:31 -0600
Message-ID: <20090507092731.GH8112__46293.3449460708$1241688607$gmane$org@parisc-linux.org>
References: <20090507082841.GA31751@redhat.com>
	<200905071651.24970.sheng@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905071651.24970.sheng@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sheng Yang <sheng@linux.intel.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, Matthew Wilcox <willy@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 07, 2009 at 04:51:24PM +0800, Sheng Yang wrote:
> On Thursday 07 May 2009 16:28:41 Michael S. Tsirkin wrote:
> > pci_enable_msix currently returns -EINVAL if you ask
> > for more vectors than supported by the device, which would
> > typically cause fallback to regular interrupts.
> >
> > It's better to return the table size, making the driver retry
> > MSI-X with less vectors.
> 
> Hi Michael
> 
> I think driver should read from capability list to know how many vector 
> supported by this device before enable MSI-X for device, as 
> pci_msix_table_size() did...

I think Michael's patch makes sense.  It reduces the amount of work the
driver has to do without requiring any additional work in the core.  I
don't see the disadvantage to it.

Reviewed-by: Matthew Wilcox <willy@linux.intel.com>

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
