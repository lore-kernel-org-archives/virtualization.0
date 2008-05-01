From: Amit Shah <amit.shah@qumranet.com>
Subject: Re: [PATCH] KVM x86: Handle hypercalls for assigned PCI devices
Date: Thu, 1 May 2008 18:48:28 +0530
Message-ID: <200805011848.29363.amit.shah__5442.28295698321$1209648105$gmane$org@qumranet.com>
References: <1209465451-3758-1-git-send-email-amit.shah@qumranet.com>
	<48173440.304@redhat.com>
	<200804292128.52268.amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804292128.52268.amit.shah@qumranet.com>
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
To: Glauber Costa <gcosta@redhat.com>
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 29 April 2008 21:28:51 Amit Shah wrote:
> On Tuesday 29 April 2008 20:14:16 Glauber Costa wrote:
> > Amit Shah wrote:

> > > +	if (find_pci_pt_dev(&vcpu->kvm->arch.pci_pt_dev_head,
> > > +			    &pci_pt_info, 0, KVM_PT_SOURCE_ASSIGN))
> > > +		r++; /* We have assigned the device */
> > > +
> > > +	kunmap(host_page);
> >
> > better use atomic mappings here.
>
> We can't use atomic mappings for guest pages. They can be swapped out.

Actually you were right: there's no sleeping call here after doing the 
mapping. I've updated this call with kmap_atomic.

The other function that uses kmap can't be converted since we continue to map 
several pages in a loop (depending on the length of the DMA region) and hence 
can't use kmap_atomic there.
