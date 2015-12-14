From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH RFC 0/3] Xen on Virtio
Date: Mon, 14 Dec 2015 14:00:05 +0000
Message-ID: <566ECB65.3060509@citrix.com>
References: <alpine.DEB.2.02.1512071555590.24652@kaball.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.02.1512071555590.24652@kaball.uk.xensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>, mst@redhat.com
Cc: xen-devel@lists.xenproject.org, Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 07/12/15 16:19, Stefano Stabellini wrote:
> Hi all,
> 
> this patch series introduces support for running Linux on top of Xen
> inside a virtual machine with virtio devices (nested virt scenario).
> The problem is that Linux virtio drivers use virt_to_phys to get the
> guest pseudo-physical addresses to pass to the backend, which doesn't
> work as expected on Xen.
> 
> Switching the virtio drivers to the dma APIs (dma_alloc_coherent,
> dma_map/unmap_single and dma_map/unmap_sg) would solve the problem, as
> Xen support in Linux provides an implementation of the dma API which
> takes care of the additional address conversions. However using the dma
> API would increase the complexity of the non-Xen case too. We would also
> need to keep track of the physical or virtual address in addition to the
> dma address for each vring_desc to be able to free the memory in
> detach_buf (see patch #3).
> 
> Instead this series adds few obvious checks to perform address
> translations in a couple of key places, without changing non-Xen code
> paths. You are welcome to suggest improvements or alternative
> implementations.

Andy Lutomirski also looked at this.  Andy what happened to this work?

David
