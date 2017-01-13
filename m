From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_mmio: expose header to userspace
Date: Fri, 13 Jan 2017 15:31:14 +0200
Message-ID: <20170113152618-mutt-send-email-mst__39060.6218287305$1484314309$gmane$org@kernel.org>
References: <1484257033-11032-1-git-send-email-mst@redhat.com>
	<20170113075822.GA31777@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170113075822.GA31777@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 12, 2017 at 11:58:22PM -0800, Christoph Hellwig wrote:
> On Thu, Jan 12, 2017 at 11:37:22PM +0200, Michael S. Tsirkin wrote:
> > It's handy for userspace emulators like QEMU.
> 
> But it's not actually a userspace API - it's an on the write protocol.

We do this for all other virtio transports, mmio shouldn't be
any different.

> so: NAK.

We'll have to agree to disagree on this one. It's the interface
beween linux and the hypervisor. It isn't any less stable
than the one to userspace, for better or worse kvm
(ab)uses uapi for that. Compare also to include/uapi/linux/kvm_para.h
etc.

-- 
MST
