From: Amit Shah <amit.shah@redhat.com>
Subject: Re: Multiple Port Support for virtio-console
Date: Thu, 10 Sep 2009 17:27:12 +0530
Message-ID: <20090910115712.GA27014__33359.5929005698$1252583901$gmane$org@amit-x200.redhat.com>
References: <1252483925-26336-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1252483925-26336-1-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) Sep 09 2009 [13:41:59], Amit Shah wrote:
> 
> Hello all,
> 
> Here is a new iteration of the patch series that implements a
> transport for guest and host communications.
> 
> I've tested for compatibility (old qemu & new kernel, new qemu & old
> kernel, new qemu & new kernel) and it all works fine*. Migration works
> with the patch Juan just posted.
> 
> There are a few items on my todo list but this works well.
> 
> New since last send:
> - migrate per-port buffers that are queued up
> - in-qemu api for open/close/read/write of ports.
>   - the read() is a callback that's invoked when complete data
>     corresponding to one write() request on the guest is available.
> - removed comments from virtio_console.c that are no longer relevant.
> - address review comments by Juan
> 
> TODO:
> - Convert all config writes to little endian in qemu / convert from
>   little endian to host endian in guest
> - Address a few FIXMEs spread in the code
> - Introduce a watermark to stop a rogue host process flooding guest
>   with data
> 
> Conditions:
> * Heavy IO on an hvc port and a non-hvc port causes memory corruption
>   each time, same place. It could be realted to locking but I doubt
>   that. This still has to be sorted out

I can't reproduce this badness anymore with the linux-next kernel in the
guest.

So I request the maintainers to please review this patchset for and
consider for inclusion.

Thanks,
		Amit
