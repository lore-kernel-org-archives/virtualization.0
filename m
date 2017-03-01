From: Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH] virtio-console: avoid DMA from stack
Date: Wed, 1 Mar 2017 12:01:10 -0800
Message-ID: <20170301200110.GA24754@vader.dhcp.thefacebook.com>
References: <075115ddd99246ffc4228a3e050ba68eb36c6a8c.1485935920.git.osandov@fb.com>
	<20170201134712.GA7935@amit-lp.rh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170201134712.GA7935@amit-lp.rh>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>
Cc: kernel-team@fb.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 01, 2017 at 07:17:12PM +0530, Amit Shah wrote:
> On (Wed) 01 Feb 2017 [00:02:27], Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > put_chars() stuffs the buffer it gets into an sg, but that buffer may be
> > on the stack. This breaks with CONFIG_VMAP_STACK=y (for me, it
> > manifested as printks getting turned into NUL bytes).
> 
> Seems reasonable.  I wonder since all implementations of hvc do a
> memcpy, if we can abstract it - but that'll need some work.
> 
> Reviewed-by: Amit Shah <amit.shah@redhat.com>
> 
> Michael, please add to the virtio queue.
> 
> 		Amit

Hi, Michael,

I don't see this in Linus' master or in your git tree, is it going to go
in for -rc1?

Thanks.
