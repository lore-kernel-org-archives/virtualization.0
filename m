From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio balloon: do not call blocking ops when !TASK_RUNNING
Date: Thu, 26 Feb 2015 09:45:29 +0100
Message-ID: <20150226084529.GB24184__18580.9656315998$1424940370$gmane$org@redhat.com>
References: <20150225111318.0040536b@oc7435384737.ibm.com>
	<87y4nllb85.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87y4nllb85.fsf@rustcorp.com.au>
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
Cc: Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 26, 2015 at 11:50:42AM +1030, Rusty Russell wrote:
> Thomas Huth <thuth@linux.vnet.ibm.com> writes:
> >  Hi all,
> >
> > with the recent kernel 3.19, I get a kernel warning when I start my
> > KVM guest on s390 with virtio balloon enabled:
> 
> The deeper problem is that virtio_ccw_get_config just silently fails on
> OOM.

Same problem with virtio_ccw_reset.
But avoiding kmalloc calls in virtio_ccw_get_config isn't enough I think,
it might still sleep.


> 
> Neither get_config nor set_config are expected to fail.
> 
> Cornelia, I think ccw and config_area should be allocated inside vcdev.
> You could either use pointers, or simply allocate vcdev with GDP_DMA.
> 
> This would avoid the kmalloc inside these calls.
> 
> Thanks,
> Rusty.
