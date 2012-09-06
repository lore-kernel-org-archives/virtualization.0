From: Kent Overstreet <koverstreet@google.com>
Subject: Re: [PATCH] virtio-blk: Fix kconfig option
Date: Thu, 6 Sep 2012 00:41:13 -0700
Message-ID: <20120906074113.GA5902@koverstreet-glaptop>
References: <20120903044133.GA9980@moria.home.lan>
	<87wr0ae26e.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87wr0ae26e.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 04, 2012 at 03:53:53PM +0930, Rusty Russell wrote:
> Kent Overstreet <koverstreet@google.com> writes:
> 
> > CONFIG_VIRTIO isn't exposed, everything else is supposed to select it
> > instead.
> 
> This is a slight mis-understanding.  It's supposed to be selected by
> the particular driver, probably virtio_pci in your case.

So are you saying virtio-blk depends on virtio-pci? If so, the kconfig
should have that.

As is, VIRTIO_BLK just has:
	depends on EXPERIMENTAL && VIRTIO

which is flat out broken.
