From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Thu, 11 Jun 2009 11:28:18 -0700
Message-ID: <20090611112818.149b568e__34653.1957657591$1244828886$gmane$org@jbarnes-g45>
References: <20090507082841.GA31751@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090507082841.GA31751@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Matthew Wilcox <willy@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 7 May 2009 11:28:41 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> pci_enable_msix currently returns -EINVAL if you ask
> for more vectors than supported by the device, which would
> typically cause fallback to regular interrupts.
> 
> It's better to return the table size, making the driver retry
> MSI-X with less vectors.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Hi Jesse,
> This came up when I was adding MSI-X support to virtio pci driver,
> which does not know the exact table size upfront.
> Could you consider this patch for 2.6.31 please?

Applied this one to my linux-next branch; hopefully Rusty won't mind
too much. :)

-- 
Jesse Barnes, Intel Open Source Technology Center
