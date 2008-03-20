From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [RFC PATCH 1/5] lguest: mmap backing file
Date: Thu, 20 Mar 2008 09:04:17 -0500
Message-ID: <47E26EE1.5030706__11849.0669447512$1206022262$gmane$org@codemonkey.ws>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<200803201705.44422.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803201705.44422.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> From: Paul TBBle Hampson <Paul.Hampson@Pobox.com>
>
> This creates a file in $HOME/.lguest/ to directly back the RAM and DMA memory
> mappings created by map_zeroed_pages.
>   

I created a test program recently that measured the latency of a 
reads/writes to an mmap() file in /dev/shm and in a normal filesystem.  
Even after unlinking the underlying file, the write latency was much 
better with a mmap()'d file in /dev/shm.

/dev/shm is not really for general use.  I think we'll want to have our 
own tmpfs mount that we use to create VM images.  I also prefer to use a 
unix socket for communication, unlink the file immediately after open, 
and then pass the fd via SCM_RIGHTS to the other process.

Regards,

Anthony Liguori
