From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/19] vmw_balloon: compaction, shrinker, 64-bit, etc.
Date: Tue, 18 Sep 2018 14:27:29 +0200
Message-ID: <20180918122729.GA13598@kroah.com>
References: <20180918063853.198332-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180918063853.198332-1-namit@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Xavier Deguillard <xdeguillard@vmware.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 17, 2018 at 11:38:34PM -0700, Nadav Amit wrote:
> This patch-set adds the following enhancements to the VMware balloon
> driver:
> 
> 1. Balloon compaction support.
> 2. Report the number of inflated/deflated ballooned pages through vmstat.
> 3. Memory shrinker to avoid balloon over-inflation (and OOM).
> 4. Support VMs with memory limit that is greater than 16TB.
> 5. Faster and more aggressive inflation.
> 
> To support compaction we wish to use the existing infrastructure.
> However, we need to make slight adaptions for it. We add a new list
> interface to balloon-compaction, which is more generic and efficient,
> since it does not require as many IRQ save/restore operations. We leave
> the old interface that is used by the virtio balloon.
> 
> Big parts of this patch-set are cleanup and documentation. Patches 1-13
> simplify the balloon code, document its behavior and allow the balloon
> code to run concurrently. The support for concurrency is required for
> compaction and the shrinker interface.
> 
> For documentation we use the kernel-doc format. We are aware that the
> balloon interface is not public, but following the kernel-doc format may
> be useful one day.

kbuild seems to not like this patch series, so I'm going to drop it from
my queue and wait for a v2 respin before looking at it.

thanks,

greg k-h
