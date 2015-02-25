From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2] virtio-balloon: do not call blocking ops when
	!TASK_RUNNING
Date: Wed, 25 Feb 2015 16:11:27 +0100
Message-ID: <20150225161127.51f06c8c.cornelia.huck@de.ibm.com>
References: <1424874878-17155-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1424874878-17155-1-git-send-email-mst@redhat.com>
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
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 25 Feb 2015 15:36:02 +0100
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtio balloon has this code:
>         wait_event_interruptible(vb->config_change,
>                                  (diff = towards_target(vb)) != 0
>                                  || vb->need_stats_update
>                                  || kthread_should_stop()
>                                  || freezing(current));
> 
> Which is a problem because towards_target() call might block after
> wait_event_interruptible sets task state to TAST_INTERRUPTIBLE, causing
> the task_struct::state collision typical of nesting of sleeping
> primitives
> 
> See also http://lwn.net/Articles/628628/ or Thomas's
> bug report
> http://article.gmane.org/gmane.linux.kernel.virtualization/24846
> for a fuller explanation.
> 
> To fix, rewrite using wait_woken.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> changes from v1:
> 	remove wait_event_interruptible
> 	noticed by Cornelia Huck <cornelia.huck@de.ibm.com>
> 
>  drivers/virtio/virtio_balloon.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 

I was able to reproduce Thomas' original problem and can confirm that
it is gone with this patch.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
