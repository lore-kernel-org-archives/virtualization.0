From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/1] [virt] virtio-blk: Use ida to allocate disk index
Date: Thu, 02 Jun 2011 09:27:23 +0930
Message-ID: <87mxi1xfz0.fsf__19471.5486410589$1306980145$gmane$org@rustcorp.com.au>
References: <1306913069-23637-1-git-send-email-dwu@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1306913069-23637-1-git-send-email-dwu@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Mark Wu <dwu@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed,  1 Jun 2011 03:24:29 -0400, Mark Wu <dwu@redhat.com> wrote:
> Current index allocation in virtio-blk is based on a monotonically
> increasing variable "index". It could cause some confusion about disk
> name in the case of hot-plugging disks. And it's impossible to find the
> lowest available index by just maintaining a simple index. So it's
> changed to use ida to allocate index via referring to the index
> allocation in scsi disk.
> 
> Signed-off-by: Mark Wu <dwu@redhat.com>

Hi Mark,

   I don't believe that we do disk probes in parallel, so the spinlock
is unnecessary.  Otherwise, this looks good.

Thanks,
Rusty.
