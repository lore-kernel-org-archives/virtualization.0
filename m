From: Amos Kong <akong@redhat.com>
Subject: Re: [3.16 stable PATCH 0/2] virtio-rng: two backports to fix stuck
Date: Tue, 4 Nov 2014 12:32:27 +0800
Message-ID: <20141104043227.GA13409@air.redhat.com>
References: <1412981509-30025-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1412981509-30025-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: amit.shah@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Oct 11, 2014 at 06:51:47AM +0800, Amos Kong wrote:
> I received two mails about faile to apply patches to 3.16-stable tree:
> 
> FAILED: patch "[PATCH] virtio-rng: skip reading when we start to remove the device" failed to apply to 3.16-stable tree
> FAILED: patch "[PATCH] virtio-rng: fix stuck of hot-unplugging busy device" failed to apply to 3.16-stable tree
> 
> Amit already backported two patches for 3.16-stable, then cherry-pick
> of my two patches works.
> 
> Thanks.

Ping Greg, thanks.
 
> Amos Kong (2):
>   virtio-rng: fix stuck of hot-unplugging busy device
>   virtio-rng: skip reading when we start to remove the device
> 
>  drivers/char/hw_random/virtio-rng.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> -- 
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
			Amos.
