From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Wed, 13 May 2009 00:28:02 +0300
Message-ID: <20090512212802.GC28935__36638.7938069694$1242163968$gmane$org@redhat.com>
References: <20090507082841.GA31751@redhat.com>
	<20090507095302.GI8112@parisc-linux.org>
	<200905071819.54426.sheng@linux.intel.com>
	<200905080925.01398.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905080925.01398.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, Matthew Wilcox <willy@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 08, 2009 at 09:25:00AM +0930, Rusty Russell wrote:
> On Thu, 7 May 2009 07:49:53 pm Sheng Yang wrote:
> > On Thursday 07 May 2009 17:53:02 Matthew Wilcox wrote:
> > > Here's a good example.  Let's suppose you have a driver which supports
> > > two different models of cards, one has 16 MSI-X interrupts, the other
> > > has 10.  You can call pci_enable_msix() asking for 16 vectors.  If your
> > > card is model A, you get 16 interrupts.  If your card is model B, it says
> > > "you can have 10".
> 
> Sheng is absolutely right, that's a horrid API.
> 
> If it actually enabled that number and returned it, it might make sense (cf. 
> write() returning less bytes than you give it).  But overloading the return 
> value to save an explicit call is just ugly; it's not worth saving a few lines 
> of code at cost of making all the drivers subtle and tricksy.
> 
> Fail with -ENOSPC or something.
> 
> Rusty.

I do agree that returning a positive value from pci_enable_msix
it an ugly API (but note that this is the API that linux currently has).

Here's a wrapper that I ended up with in my driver:

static int enable_msix(struct pci_dev *dev, struct msix_entry *entries,
		       int *options, int noptions)
{
        int i;
        for (i = 0; i < noptions; ++i)
                if (!pci_enable_msix(dev, entries, options[i]))
                        return options[i];
        return -EBUSY;
}

This gets an array of options for # of vectors and tries them one after
the other until an option that the system can support is found.
On success, we get the # of vectors actually enabled, and
driver can then use them as it sees fit.

Is there interest in moving something like this to pci.h?

-- 
MST
