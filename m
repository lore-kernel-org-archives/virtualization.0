From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
	target
Date: Wed, 25 Nov 2015 20:32:36 +0100
Message-ID: <56560CD4.8090805@redhat.com>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
	<56506D95.70101@redhat.com> <1448266667.18175.5.camel@hasee>
	<56531F5F.3050709@redhat.com> <1448350074.6696.3.camel@hasee>
	<56544122.3010300@redhat.com> <1448393115.2925.2.camel@ssi>
	<56559B36.90406@redhat.com> <1448477482.6540.3.camel@ssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1448477482.6540.3.camel@ssi>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lin <mlin@kernel.org>
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org



On 25/11/2015 19:51, Ming Lin wrote:
> > Do you still have a blk_set_aio_context somewhere?  I'm losing track of
> > the changes.
> 
> No.

You'll need it.  That's what causes your error.

> BTW, I'm not sure about qemu upstream policy.
> Do I need to first make the kernel side patch upstream?
> https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=nvme-google-ext

No problem, there's time.  QEMU is in freeze right now, and the 2.6
cycle will last until March or so.

Paolo
