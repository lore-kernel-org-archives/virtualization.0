From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_net: Check for room in the vq before adding buffer
Date: Thu, 27 Aug 2009 19:17:20 +0930
Message-ID: <200908271917.21260.rusty@rustcorp.com.au>
References: <1251278908-18601-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1251278908-18601-1-git-send-email-amit.shah@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 26 Aug 2009 06:58:28 pm Amit Shah wrote:
> Saves us one cycle of alloc-add-free if the queue was full.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>

Thanks, applied with one change:

> @@ -323,7 +323,7 @@ static bool try_fill_recv_maxbufs(struct virtnet_info *vi, gfp_t gfp)
>  			break;
>  		}
>  		vi->num++;
> -	}
> +	} while (err > 0);

This is better as "while (err >= num)".  The other one is right (we only need
1 buffer), this one we need to be able to fit "num" entries.

Thanks!
Rusty.
