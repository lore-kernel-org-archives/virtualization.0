From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Thu, 7 May 2009 12:31:37 +0300
Message-ID: <20090507093137.GD32039@redhat.com>
References: <20090507082841.GA31751@redhat.com>
	<200905071651.24970.sheng@linux.intel.com>
	<20090507090506.GB32039@redhat.com>
	<200905071710.47204.sheng@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905071710.47204.sheng@linux.intel.com>
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
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, Matthew Wilcox <willy@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 07, 2009 at 05:10:46PM +0800, Sheng Yang wrote:
> > > I think driver should read from capability list to know how many vector
> > > supported by this device before enable MSI-X for device, as
> > > pci_msix_table_size() did...
> >
> > Drivers can do this, but it's more code. Since pci_enable_msix
> > calls pci_msix_table_size already, let it do the work. Right?
> 
> If you don't know the vectors number before you enable MSI-X, how can you 
> setup vectors? 

I don't know how many irqs I will be able to get anyway.
vectors that can't be assigned are useless ...

-- 
MST
