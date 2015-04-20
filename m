From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/18] virtio-blk: Support "VIRTIO_CONFIG_S_NEEDS_RESET"
Date: Mon, 20 Apr 2015 21:10:02 +0200
Message-ID: <55354F0A.5080809@redhat.com>
References: <1429257573-7359-1-git-send-email-famz@redhat.com>
	<20150420175905-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150420175905-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 20/04/2015 19:36, Michael S. Tsirkin wrote:
> At the implementation level, there's one big issue you seem to have
> missed: DMA to invalid memory addresses causes a crash in memory core.
> I'm not sure whether it makes sense to recover from virtio core bugs
> when we can't recover from device bugs.

What do you mean exactly?  DMA to invalid memory addresses causes
address_space_map to return a "short read".

Paolo
