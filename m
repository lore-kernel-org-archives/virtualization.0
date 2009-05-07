From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Thu, 7 May 2009 03:53:02 -0600
Message-ID: <20090507095302.GI8112__45115.6109491878$1241690121$gmane$org@parisc-linux.org>
References: <20090507082841.GA31751@redhat.com>
	<200905071651.24970.sheng@linux.intel.com>
	<20090507092731.GH8112@parisc-linux.org>
	<200905071740.16190.sheng@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905071740.16190.sheng@linux.intel.com>
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

On Thu, May 07, 2009 at 05:40:15PM +0800, Sheng Yang wrote:
> It's indeed weird. Why the semantic of pci_enable_msix can be changed to 
> "enable msix, or tell me how many vector do you have"? You can simply call 
> pci_msix_table_size() to get what you want, also without any more work, no? I 
> can't understand...

Here's a good example.  Let's suppose you have a driver which supports
two different models of cards, one has 16 MSI-X interrupts, the other
has 10.  You can call pci_enable_msix() asking for 16 vectors.  If your
card is model A, you get 16 interrupts.  If your card is model B, it says
"you can have 10".

This is less work in the driver (since it must implement falling back to
a smaller number of interrupts *anyway*) than interrogating the card to
find out how many interrupts there are, then requesting the right number,
and still having the fallback path which is going to be less tested.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
