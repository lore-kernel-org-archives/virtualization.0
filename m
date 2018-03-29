From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net V2] vhost: correctly remove wait queue during poll
	failure
Date: Thu, 29 Mar 2018 07:20:30 +0300
Message-ID: <20180329071801-mutt-send-email-mst__49554.6976374046$1522297138$gmane$org@kernel.org>
References: <1522155052-13347-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1522155052-13347-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Darren Kenny <darren.kenny@oracle.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 27, 2018 at 08:50:52PM +0800, Jason Wang wrote:
> We tried to remove vq poll from wait queue, but do not check whether
> or not it was in a list before. This will lead double free. Fixing
> this by switching to use vhost_poll_stop() which zeros poll->wqh after
> removing poll from waitqueue to make sure it won't be freed twice.
> 
> Cc: Darren Kenny <darren.kenny@oracle.com>
> Reported-by: syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com
> Fixes: 2b8b328b61c79 ("vhost_net: handle polling errors when setting backend")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

OK with this the only bug we have is where get user pages returns 0
(Reported-by: syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com)



> ---
> Changes from V1:
> - tweak the commit log for to match the code
> ---
>  drivers/vhost/vhost.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 1b3e8d2d..5d5a9d9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -212,8 +212,7 @@ int vhost_poll_start(struct vhost_poll *poll, struct file *file)
>  	if (mask)
>  		vhost_poll_wakeup(&poll->wait, 0, 0, poll_to_key(mask));
>  	if (mask & EPOLLERR) {
> -		if (poll->wqh)
> -			remove_wait_queue(poll->wqh, &poll->wait);
> +		vhost_poll_stop(poll);
>  		ret = -EINVAL;
>  	}
>  
> -- 
> 2.7.4
