From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2] virtio-blk physical block size
Date: Mon, 4 Jan 2010 13:38:51 +1030
Message-ID: <201001041338.52621.rusty__21279.8194996596$1262577634$gmane$org@rustcorp.com.au>
References: <1262018363-15871-1-git-send-email-avi@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1262018363-15871-1-git-send-email-avi@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 29 Dec 2009 03:09:23 am Avi Kivity wrote:
> This patch adds a physical block size attribute to virtio disks,
> corresponding to /sys/devices/.../physical_block_size.  It is defined as
> the request alignment which will not trigger RMW cycles.  This can be
> important for modern disks which use 4K physical sectors (though they
> still support 512 logical sectors), and for file-backed disk images (which
> have both the underlying filesystem block size and their own allocation
> granularity to consider).
> 
> Installers use this to align partitions to physical block boundaries.
> 
> Note the spec already defined blk_size as the performance rather than
> minimum alignment.  However the driver interpreted this as the logical
> block size, so I updated the spec to match the driver assuming the driver
> predates the spec and that this is an error.

I thought this was what I was doing, but I have shown over and over that
I have no idea about block devices.

Our current driver treats BLK_SIZE as the logical and physical size (see
blk_queue_logical_block_size).

I have no idea what "logical" vs. "physical" actually means.  Anyone?  Most
importantly, is it some Linux-internal difference or a real I/O-visible
distinction?

Rusty.
