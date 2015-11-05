From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/3] dma: Provide simple noop dma ops
Date: Thu, 5 Nov 2015 14:31:30 +0100
Message-ID: <20151105133130.GB2255__10913.7069587179$1446730325$gmane$org@suse.de>
References: <1446551679-33492-1-git-send-email-borntraeger@de.ibm.com>
	<1446551679-33492-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1446551679-33492-2-git-send-email-borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Michael Tsirkin <mst@redhat.com>, benh@kernel.crashing.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, dwmw2@infradead.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 03, 2015 at 12:54:37PM +0100, Christian Borntraeger wrote:
> We are going to require dma_ops for several common drivers, even for
> systems that do have an identity mapping. Lets provide some minimal
> no-op dma_ops that can be used for that purpose.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  include/linux/dma-mapping.h |  2 ++
>  lib/Makefile                |  1 +
>  lib/dma-noop.c              | 75 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)
>  create mode 100644 lib/dma-noop.c

Reviewed-by: Joerg Roedel <jroedel@suse.de>
