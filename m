From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Fri, 8 May 2009 09:25:00 +0930
Message-ID: <200905080925.01398.rusty__23014.9762508974$1241740611$gmane$org@rustcorp.com.au>
References: <20090507082841.GA31751@redhat.com>
	<20090507095302.GI8112@parisc-linux.org>
	<200905071819.54426.sheng@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905071819.54426.sheng@linux.intel.com>
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
To: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, Matthew Wilcox <willy@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 7 May 2009 07:49:53 pm Sheng Yang wrote:
> On Thursday 07 May 2009 17:53:02 Matthew Wilcox wrote:
> > Here's a good example.  Let's suppose you have a driver which supports
> > two different models of cards, one has 16 MSI-X interrupts, the other
> > has 10.  You can call pci_enable_msix() asking for 16 vectors.  If your
> > card is model A, you get 16 interrupts.  If your card is model B, it says
> > "you can have 10".

Sheng is absolutely right, that's a horrid API.

If it actually enabled that number and returned it, it might make sense (cf. 
write() returning less bytes than you give it).  But overloading the return 
value to save an explicit call is just ugly; it's not worth saving a few lines 
of code at cost of making all the drivers subtle and tricksy.

Fail with -ENOSPC or something.

Rusty.
