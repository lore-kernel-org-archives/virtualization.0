From: Sheng Yang <sheng@linux.intel.com>
Subject: Re: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Thu, 7 May 2009 18:19:53 +0800
Message-ID: <200905071819.54426.sheng__16738.0453589887$1241691644$gmane$org@linux.intel.com>
References: <20090507082841.GA31751@redhat.com>
	<200905071740.16190.sheng@linux.intel.com>
	<20090507095302.GI8112@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090507095302.GI8112@parisc-linux.org>
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

On Thursday 07 May 2009 17:53:02 Matthew Wilcox wrote:
> On Thu, May 07, 2009 at 05:40:15PM +0800, Sheng Yang wrote:
> > It's indeed weird. Why the semantic of pci_enable_msix can be changed to
> > "enable msix, or tell me how many vector do you have"? You can simply
> > call pci_msix_table_size() to get what you want, also without any more
> > work, no? I can't understand...
>
> Here's a good example.  Let's suppose you have a driver which supports
> two different models of cards, one has 16 MSI-X interrupts, the other
> has 10.  You can call pci_enable_msix() asking for 16 vectors.  If your
> card is model A, you get 16 interrupts.  If your card is model B, it says
> "you can have 10".
>
> This is less work in the driver (since it must implement falling back to
> a smaller number of interrupts *anyway*) than interrogating the card to
> find out how many interrupts there are, then requesting the right number,
> and still having the fallback path which is going to be less tested.

Yeah, partly understand now.

But the confusing of return value is not that pleasure compared to this 
benefit. And even you have to fall back if return > 0 anyway, but in the past, 
you just need fall back once at most; but now you may fall back twice. This 
make thing more complex - you need either two ifs or a simple loop. And just 
one "if" can deal with it before. All that required is one call for 
pci_msix_table_size(), and I believe most driver would like to know how much 
vector it have before it fill the vectors, so mostly no extra cost. But for 
this ambiguous return meaning, you have to add more code for fall back - yes, 
the driver may can assert that the positive return value always would be irq 
numbers if it call pci_msix_table_size() before, but is it safe in logic?

-- 
regards
Yang, Sheng
