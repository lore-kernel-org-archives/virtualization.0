From: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH] x86 DMA: Handle devices assigned to the guest by the host
Date: Wed, 30 Apr 2008 09:29:41 +0300
Message-ID: <20080430062940.GM7378__39835.4551908143$1209537031$gmane$org@il.ibm.com>
References: <1209465451-3758-1-git-send-email-amit.shah@qumranet.com>
	<1209465451-3758-2-git-send-email-amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1209465451-3758-2-git-send-email-amit.shah@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@qumranet.com>
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, linux-kernel@vger.kernel.org, gcosta@redhat.com, virtualization@lists.linux-foundation.org, Ben-Ami Yassour1 <BENAMI@il.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 29, 2008 at 01:37:29PM +0300, Amit Shah wrote:

> dma_alloc_coherent() doesn't call dma_ops->alloc_coherent in case no
> IOMMU translations are necessary.

I always thought this was a huge wart in the x86-64 DMA ops. Would
there be strong resistance to fixing it so that alloc_coherent
matches the way the other ops are used? This will eliminate the need
for this patch and will make other DMA ops implementations saner.

Cheers,
Muli
