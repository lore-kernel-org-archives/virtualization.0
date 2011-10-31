From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv4] virtio-blk: use ida to allocate disk index
Date: Mon, 31 Oct 2011 08:05:55 +0100
Message-ID: <4EAE48D3.4090504__47080.6171805181$1321323093$gmane$org@kernel.dk>
References: <20111030192959.GA31143@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111030192959.GA31143@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 2011-10-30 20:29, Michael S. Tsirkin wrote:
> Based on a patch by Mark Wu <dwu@redhat.com>
> 
> Current index allocation in virtio-blk is based on a monotonically
> increasing variable "index". This means we'll run out of numbers
> after a while.  It also could cause confusion about the disk
> name in the case of hot-plugging disks.
> Change virtio-blk to use ida to allocate index, instead.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Changes from Mark's versions:
>  use the new ida_simple_get
>  error handling cleanup
>  fix user after free
> 
> Works fine for me.
> 
> Jens, could you merge this for 3.2?
> That is, unless Rusty complains shortly ...

Yep, tentatively added.

-- 
Jens Axboe
