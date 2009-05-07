From: Sheng Yang <sheng@linux.intel.com>
Subject: Re: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Thu, 7 May 2009 18:28:32 +0800
Message-ID: <200905071828.33593.sheng__48500.4715192646$1241692161$gmane$org@linux.intel.com>
References: <20090507082841.GA31751@redhat.com>
	<20090507095302.GI8112@parisc-linux.org>
	<1241691830.24385.6.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1241691830.24385.6.camel@concordia>
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
To: michael@ellerman.id.au
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, Matthew Wilcox <willy@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 07 May 2009 18:23:50 Michael Ellerman wrote:
> On Thu, 2009-05-07 at 03:53 -0600, Matthew Wilcox wrote:
> > On Thu, May 07, 2009 at 05:40:15PM +0800, Sheng Yang wrote:
> > > It's indeed weird. Why the semantic of pci_enable_msix can be changed
> > > to "enable msix, or tell me how many vector do you have"? You can
> > > simply call pci_msix_table_size() to get what you want, also without
> > > any more work, no? I can't understand...
> >
> > Here's a good example.  Let's suppose you have a driver which supports
> > two different models of cards, one has 16 MSI-X interrupts, the other
> > has 10.  You can call pci_enable_msix() asking for 16 vectors.  If your
> > card is model A, you get 16 interrupts.  If your card is model B, it says
> > "you can have 10".
> >
> > This is less work in the driver (since it must implement falling back to
> > a smaller number of interrupts *anyway*) than interrogating the card to
> > find out how many interrupts there are, then requesting the right number,
> > and still having the fallback path which is going to be less tested.
>
> Not to mention that there's no guarantee that you'll get as many
> interrupts as the device supports, so you should really be coding to
> cope with that anyway. Like the example in MSI-HOWTO.txt:
>
> 197 static int foo_driver_enable_msix(struct foo_adapter *adapter, int
> nvec) 198 {
> 199         while (nvec >= FOO_DRIVER_MINIMUM_NVEC) {
> 200                 rc = pci_enable_msix(adapter->pdev,
> 201                                      adapter->msix_entries, nvec);
> 202                 if (rc > 0)
> 203                         nvec = rc;
> 204                 else
> 205                         return rc;
> 206         }
> 207
> 208         return -ENOSPC;
> 209 }
>
> So I agree, this patch is an improvement.
>
Oh yeah.

Forgot irq counts can also be changed from time to time.

OK, there should be a loop, so that's fine. :)

-- 
regards
Yang, Sheng
