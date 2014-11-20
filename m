From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] virtio_balloon: Convert "vballoon" kthread into a
	workqueue
Date: Thu, 20 Nov 2014 11:07:46 -0500
Message-ID: <20141120160746.GI14877@htj.dyndns.org>
References: <1416499397-16669-1-git-send-email-pmladek@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1416499397-16669-1-git-send-email-pmladek@suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Petr Mladek <pmladek@suse.cz>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Jeff Epler <jepler@unpythonic.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 20, 2014 at 05:03:17PM +0100, Petr Mladek wrote:
...
> @@ -476,7 +460,6 @@ static void virtballoon_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb = vdev->priv;
>  
> -	kthread_stop(vb->thread);
>  	remove_common(vb);
>  	kfree(vb);
>  }

Shouldn't the work item be flushed before removal is complete?

Thanks.

-- 
tejun
