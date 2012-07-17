From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RESEND 0/5] Add vhost-blk support
Date: Tue, 17 Jul 2012 18:09:28 +0300
Message-ID: <20120717150928.GB11587__22061.9383072064$1342537832$gmane$org@redhat.com>
References: <1342169711-12386-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1342169711-12386-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org, target-devel <target-devel@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, lf-virt <virtualization@lists.linux-foundation.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Jeff Moyer <jmoyer@redhat.com>, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Christoph Hellwig <hch@lst.de>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 13, 2012 at 04:55:06PM +0800, Asias He wrote:
> 
> Hi folks,
> 
> [I am resending to fix the broken thread in the previous one.]
> 
> This patchset adds vhost-blk support. vhost-blk is a in kernel virito-blk
> device accelerator. Compared to userspace virtio-blk implementation, vhost-blk
> gives about 5% to 15% performance improvement.

Same thing as tcm_host comment:

	It seems not 100% clear whether this driver will have major
	userspace using it. And if not, it would be very hard to support a
	driver when recent userspace does not use it in the end.

	I think a good idea for 3.6 would be to make it depend on
	CONFIG_STAGING.  Then we don't commit to an ABI.  For this, you can add
	a separate Kconfig and source it from drivers/staging/Kconfig.  Maybe it
	needs to be in a separate directory drivers/vhost/staging/Kconfig.

I Cc'd the list of tcm_host in the hope that you can cooperate on this.

-- 
MST
