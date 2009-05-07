From: Sheng Yang <sheng@linux.intel.com>
Subject: Re: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Thu, 7 May 2009 17:40:15 +0800
Message-ID: <200905071740.16190.sheng__9082.71242301471$1241689292$gmane$org@linux.intel.com>
References: <20090507082841.GA31751@redhat.com>
	<200905071651.24970.sheng@linux.intel.com>
	<20090507092731.GH8112@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090507092731.GH8112@parisc-linux.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, Matthew Wilcox <willy@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 07 May 2009 17:27:31 Matthew Wilcox wrote:
> On Thu, May 07, 2009 at 04:51:24PM +0800, Sheng Yang wrote:
> > On Thursday 07 May 2009 16:28:41 Michael S. Tsirkin wrote:
> > > pci_enable_msix currently returns -EINVAL if you ask
> > > for more vectors than supported by the device, which would
> > > typically cause fallback to regular interrupts.
> > >
> > > It's better to return the table size, making the driver retry
> > > MSI-X with less vectors.
> >
> > Hi Michael
> >
> > I think driver should read from capability list to know how many vector
> > supported by this device before enable MSI-X for device, as
> > pci_msix_table_size() did...
>
> I think Michael's patch makes sense.  It reduces the amount of work the
> driver has to do without requiring any additional work in the core.  I
> don't see the disadvantage to it.
>
> Reviewed-by: Matthew Wilcox <willy@linux.intel.com>

It's indeed weird. Why the semantic of pci_enable_msix can be changed to 
"enable msix, or tell me how many vector do you have"? You can simply call 
pci_msix_table_size() to get what you want, also without any more work, no? I 
can't understand...

-- 
regards
Yang, Sheng
