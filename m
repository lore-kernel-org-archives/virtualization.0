From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 07/10] virtio: console: Use a control message to add ports
Date: Tue, 6 Apr 2010 12:39:01 +0930
Message-ID: <201004061239.02139.rusty@rustcorp.com.au>
References: <1270475654-399-1-git-send-email-amit.shah@redhat.com>
	<1270475654-399-7-git-send-email-amit.shah@redhat.com>
	<1270475654-399-8-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1270475654-399-8-git-send-email-amit.shah@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 5 Apr 2010 11:24:11 pm Amit Shah wrote:
> @@ -1431,13 +1414,20 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
>  			err = -ENOMEM;
>  			goto free_vqs;
>  		}
> +
>  	}

Minor nit: gratuitous whitespace addition.

Cheers,
Rusty.
