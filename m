From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net] virtio-net: re enable XDP_REDIRECT for mergeable
	buffer
Date: Fri, 2 Mar 2018 08:05:17 +0100
Message-ID: <20180302080517.4526f384__10170.1341489845$1519974234$gmane$org@redhat.com>
References: <1519971929-15148-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1519971929-15148-1-git-send-email-jasowang@redhat.com>
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
Cc: mst@redhat.com, netdev@vger.kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, brouer@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri,  2 Mar 2018 14:25:29 +0800
Jason Wang <jasowang@redhat.com> wrote:

> @@ -770,6 +774,19 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  				goto err_xdp;
>  			rcu_read_unlock();
>  			goto xdp_xmit;
> +		case XDP_REDIRECT:
> +			err = xdp_do_redirect(dev, &xdp, xdp_prog);
> +			if (err) {
> +				trace_xdp_exception(vi->dev, xdp_prog, act);

Do not add a trace_xdp_exception here... this is handled inside
xdp_do_redirect() invocation.

> +				if (unlikely(xdp_page != page))
> +					put_page(xdp_page);
> +				goto err_xdp;
> +			}
> +			*xdp_xmit = true;
> +			if (unlikely(xdp_page != page))
> +				goto err_xdp;
> +			rcu_read_unlock();
> +			goto xdp_xmit;



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
