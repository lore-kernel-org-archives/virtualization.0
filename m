From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 00/18] virtio-blk: Support "VIRTIO_CONFIG_S_NEEDS_RESET"
Date: Mon, 20 Apr 2015 22:34:28 +0200
Message-ID: <20150420223113-mutt-send-email-mst@redhat.com>
References: <1429257573-7359-1-git-send-email-famz@redhat.com>
	<20150420175905-mutt-send-email-mst@redhat.com>
	<55354F0A.5080809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <55354F0A.5080809@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 20, 2015 at 09:10:02PM +0200, Paolo Bonzini wrote:
> 
> 
> On 20/04/2015 19:36, Michael S. Tsirkin wrote:
> > At the implementation level, there's one big issue you seem to have
> > missed: DMA to invalid memory addresses causes a crash in memory core.
> > I'm not sure whether it makes sense to recover from virtio core bugs
> > when we can't recover from device bugs.
> 
> What do you mean exactly?  DMA to invalid memory addresses causes
> address_space_map to return a "short read".
> 
> Paolo

I mean, first of all, a bunch of virtio_XXX_phys calls.
These eventually call qemu_get_ram_ptr, which internally calls
qemu_get_ram_block and ramblock_ptr.
Both abort on errors.

-- 
MST
