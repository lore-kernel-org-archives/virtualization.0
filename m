From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio-console: avoid DMA from stack
Date: Wed, 1 Feb 2017 19:17:12 +0530
Message-ID: <20170201134712.GA7935@amit-lp.rh>
References: <075115ddd99246ffc4228a3e050ba68eb36c6a8c.1485935920.git.osandov@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <075115ddd99246ffc4228a3e050ba68eb36c6a8c.1485935920.git.osandov@fb.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Omar Sandoval <osandov@osandov.com>
Cc: kernel-team@fb.com, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 01 Feb 2017 [00:02:27], Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> put_chars() stuffs the buffer it gets into an sg, but that buffer may be
> on the stack. This breaks with CONFIG_VMAP_STACK=y (for me, it
> manifested as printks getting turned into NUL bytes).

Seems reasonable.  I wonder since all implementations of hvc do a
memcpy, if we can abstract it - but that'll need some work.

Reviewed-by: Amit Shah <amit.shah@redhat.com>

Michael, please add to the virtio queue.

		Amit
