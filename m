From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-blk: Fix kconfig option
Date: Tue, 04 Sep 2012 15:53:53 +0930
Message-ID: <87wr0ae26e.fsf@rustcorp.com.au>
References: <20120903044133.GA9980@moria.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120903044133.GA9980@moria.home.lan>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kent Overstreet <koverstreet@google.com>, mst@redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Kent Overstreet <koverstreet@google.com> writes:

> CONFIG_VIRTIO isn't exposed, everything else is supposed to select it
> instead.

This is a slight mis-understanding.  It's supposed to be selected by
the particular driver, probably virtio_pci in your case.

Cheers,
Rusty.
